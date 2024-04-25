Return-Path: <linux-kernel+bounces-158225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7C8B1D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE46B24FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCF7FBB4;
	Thu, 25 Apr 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3gJnOIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA528EB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035525; cv=none; b=rTpTuvuguEbcHbWc8vPT0nc+bl/L9M999As1l6pg6JsrGVQPFFByNxrngfmUrtttG7+dKMOJpCR+At/uGZB1uBPPOzXT/8TP5iiykU+5KlXErvQJr/6oDCIM83EgYOYNcGbhUvgafSRyW2eErTajcnxHaM7A6sjyxLLcufWYooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035525; c=relaxed/simple;
	bh=EaBSbJOHv52HBKklQSKkdSNTrsJUV+9br8OituPzzVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nccfnP4R5xR2+fqr4px4dQJF6Un1Jzl5YE72RTCnfu+170yT3UrUxz1c/rl+C0otrA7TbNoJDs+tAKQJpSIH3y5xsLJdLW+Q7KLs/bOb1GvHyx0oOHfhySl7kA4jTcWR9A0Abo58CMpKX2to/t4MXzmR7S+kYO3t68naTrltDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3gJnOIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D3C113CC;
	Thu, 25 Apr 2024 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714035525;
	bh=EaBSbJOHv52HBKklQSKkdSNTrsJUV+9br8OituPzzVw=;
	h=From:To:Cc:Subject:Date:From;
	b=R3gJnOIyGb2+MfqBAwTRrvF9QeF7rcYlA/BSXv2f3bY/WLiVWw7MSI2mGD9mG6Ee6
	 O4cTKwqXzpbHcTo8rcNg5B49anf2Fj/iQAmLFCWDtU7RpFdcU3kK6cvlfcW4DTMZol
	 Ydnd2tRMU4iyYS7uwKqbo/YHBPt56gOT9GL7W3/YJlHtr27ZILxMMi4/iMkxIT9n0K
	 bmWDk+MNhrNu2yKs5Xw2kFFv8Pm732p9fkowf/VN8hjbRoa/BF7tv5C7GP2doyuikU
	 1kgP1UjotydpOrsga3F873E0rtWHr0rpYXI3TPTgH1Yo6mgMwHmcG5sB7zamw/IoLo
	 ffwyMRBAv4OLA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()
Date: Thu, 25 Apr 2024 16:58:38 +0800
Message-Id: <20240425085838.4032657-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a kernel bug as below:

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
==================================================================
BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076

CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
 f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
 f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is we missed to do sanity check on i_xattr_nid during
f2fs_iget(), so that in fiemap() path, current_nat_addr() will access
nat_bitmap w/ offset from invalid i_xattr_nid, result in triggering
kasan bug report, fix it.

Reported-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000094036c0616e72a1d@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d7a5a88a1a5e..7968b14d49f4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -362,6 +362,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.40.1


