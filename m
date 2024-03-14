Return-Path: <linux-kernel+bounces-102708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA7687B649
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17662830DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77E522E;
	Thu, 14 Mar 2024 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG8OoOuQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E04A08
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381940; cv=none; b=dwtAe/VNfT/uUXm4c2BK01tdX2DVxXSs97yUdQulHI+HuJtKirj9+1RBh6k++zbP2a3xXRFTJHh8NCgvGOUUWEWwyigyhGHI/zacc/UvkNO51Ri5lSDyBRJedPezUncXp0LJCl1Rt5SjqPHYQuLgUNKKGMiSijJXkf4Cfx05Ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381940; c=relaxed/simple;
	bh=U7PYq18bfRAU5ibN6PAzHt9sq4pbBVTYfvTtQlSUZlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PQLZqsK2j7PD3AWV41A9KzU9dSp311ZoFxqb7Yrq7gDuUin55Kd5Fi7M1LZSyzmneATWw5zWr0wAF+pTk8xGqKTIG/wyPjeMbbT6bRjrgXfnpqzf9eIE4wkiy23GUo7J4cwW+6OcW7GlH24Z2r2wqpTh1DK4dTZRkL7Do0F7opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tG8OoOuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966EDC433C7;
	Thu, 14 Mar 2024 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710381940;
	bh=U7PYq18bfRAU5ibN6PAzHt9sq4pbBVTYfvTtQlSUZlw=;
	h=From:To:Cc:Subject:Date:From;
	b=tG8OoOuQWZabqbTq5kUgMK1AS0e1VYZ40UHH/2aY9rWy9ExRjXLLG8eAcaL4joGxa
	 IepwJt7C4afXJY9ALttZn4h+YFUNvsz3dDtiy4vhtTc4efMpZj52r42ExvGA9ON8iA
	 QJ5Q/5A3omSFYi4tJKAPflQOh97EOcp/Nb9z52HaXyvqWDYeXNFDtM/Mg+ELdySrEF
	 rI74jCaA+29INrSgvSffGgque6QaE5JGzJtzJJs6tbKJl+SyAj/QJKhOpyRGkbDXTQ
	 zAC8H8fpUoRki5d/jCK0uKAvTxM2FEhR7r2L8rLk0FgGNuD6psx92Jko55f9oeAxaH
	 +RcAlbJoMQSRA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com,
	Ed Tsai <Ed.Tsai@mediatek.com>,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH] f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault
Date: Thu, 14 Mar 2024 10:05:28 +0800
Message-Id: <20240314020528.3051533-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

BUG: KASAN: slab-use-after-free in f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
Read of size 8 at addr ffff88807bb22680 by task syz-executor184/5058

CPU: 0 PID: 5058 Comm: syz-executor184 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
 __do_fault+0x131/0x450 mm/memory.c:4376
 do_shared_fault mm/memory.c:4798 [inline]
 do_fault mm/memory.c:4872 [inline]
 do_pte_missing mm/memory.c:3745 [inline]
 handle_pte_fault mm/memory.c:5144 [inline]
 __handle_mm_fault+0x23b7/0x72b0 mm/memory.c:5285
 handle_mm_fault+0x27e/0x770 mm/memory.c:5450
 do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

The root cause is: in f2fs_filemap_fault(), vmf->vma may be not alive after
filemap_fault(), so it may cause use-after-free issue when accessing
vmf->vma->vm_flags in trace_f2fs_filemap_fault(). So it needs to keep vm_flags
in separated temporary variable for tracepoint use.

Fixes: 87f3afd366f7 ("f2fs: add tracepoint for f2fs_vm_page_mkwrite()")
Reported-and-tested-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000e8222b060f00db3b@google.com
Cc: Ed Tsai <Ed.Tsai@mediatek.com>
Cc: Hillf Danton <hdanton@sina.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a47c57e813bb..c19e55a3e50e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -39,6 +39,7 @@
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_flags_t flags = vmf->vma->vm_flags;
 	vm_fault_t ret;
 
 	ret = filemap_fault(vmf);
@@ -46,7 +47,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
-	trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma->vm_flags, ret);
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
 
 	return ret;
 }
-- 
2.40.1


