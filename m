Return-Path: <linux-kernel+bounces-113495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93038884C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F5285F18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F731B8FCD;
	Sun, 24 Mar 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCc9zS/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330371B8FB5;
	Sun, 24 Mar 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320297; cv=none; b=bqpsovC3rU84LVlv4gkEx3AJcHERnJ67cWET+MlwxJz+FXu62fd2/9pkO6X58ATM/IkWYJOLEmcFFO/M54+btFxQo0a6lDxsLgi8ervPkHTa8M0pQqTtQ1gz0+Lr1IfPFViApTq3pvOaKqztV6N0wr9mFXDuuOekiKBH/pPK1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320297; c=relaxed/simple;
	bh=2s6tXf7LXu3Ki+rm/NhyK94X2tkPoslHX4uEHVLgK8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFDQakec0C8wqejdbJ2ZzXdZwrCZRNvwzlwsZ7hFV1fTKil3YCX+NraeZ7PMsqUYqLr818SU9gybjEk9F5eo1JaKu7n55M+06TZK+ZYdS6rLUf/mYKvRJ4uSa12DtZpqZpcQocu2CVOHxjbsArmR7LblrADyKEmd8qvnE48HVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCc9zS/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5AC43390;
	Sun, 24 Mar 2024 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320297;
	bh=2s6tXf7LXu3Ki+rm/NhyK94X2tkPoslHX4uEHVLgK8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCc9zS/eTvlFeg3Wyb9IeP2lp61c6M2oNmDDgjWLL1Q5OFhE1P6mQ6LfMrOCpYYfw
	 aZFysYnm4pz2qL1XWMr/XOsAGTQDu0GLlJSfC8HXzm3iYZ9Bi0kReQNMYyqeYG19Ss
	 BQH590mwTwX3Crq+5k711wY5BqL+nHsuK5HZaqMoEtYX7mjtNBPx98drfwvF+TWat1
	 qIW+cLlXfIWGCptm/8foGGnXNMXp7suUdMF5530RAP7i4R6bbFFRmPRyLC+vkXHYV7
	 bXpKmm09b6MrYs4CZ1VF3VyZeC/AC4mgh3KxOE8fVPHOtTYrwlCrc+CWfTBtVXVOC4
	 ODvNfRgiUvXMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com,
	Ed Tsai <Ed.Tsai@mediatek.com>,
	Hillf Danton <hdanton@sina.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 604/715] f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault
Date: Sun, 24 Mar 2024 18:33:03 -0400
Message-ID: <20240324223455.1342824-605-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit eb70d5a6c932d9d23f4bb3e7b83782c21ac4b064 ]

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
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffe7fca39a8e8..51970b345eeee 100644
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
2.43.0


