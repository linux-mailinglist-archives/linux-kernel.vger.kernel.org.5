Return-Path: <linux-kernel+bounces-129955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50789727E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFAB1F290B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28645149C4C;
	Wed,  3 Apr 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4FhDPtz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3631494A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154268; cv=none; b=VX0xczxznTCWF49P78t6nHDx78n6XWUc+wVwY4Hf8HPHeIh4MyJBzCR7iuY36fpK+7mLvYKtpvHaSSF8v7I74piq2WPaGVdQ2U4d4tmAnXlHKfJBWR8DagevR9jcz14jv2/+sVrH8WLKwk+Z6mdGRjoQ6A7W4xKv89rHW1dcsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154268; c=relaxed/simple;
	bh=Et6k9jnpHCmh8RkVkmceF4DfrHtMEGLOP0mlzrDQVTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ogyt9ymPf8+ZeR1R/QUrDCMCzEJlGq9F4Bu7e1pdLhb3y5sUod+a+g4bVFg1jy60wKrbbNim15J6ZTYVY4XliBbmXkueRlzwWhvwkCrI4/X5VcR520JS5/e+M2laISKk+VjyqSK21t9aCMbXrGyFKIiM/Ya1vZ8XsV8m7COMofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4FhDPtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A697EC433F1;
	Wed,  3 Apr 2024 14:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154267;
	bh=Et6k9jnpHCmh8RkVkmceF4DfrHtMEGLOP0mlzrDQVTg=;
	h=From:To:Cc:Subject:Date:From;
	b=q4FhDPtznoIvgxXYNNTmflJkwAz5zan8MN7d5DCZWR+npG9lvlELY4xhniWJF/Qr3
	 0tBjo2D4tiAqrDQ4Rho1DCjgp6l02JntfbQHocIYDsjgS0reSS1LG2L4ePy/GXXjdI
	 vIRvLmR2buLiB+Pwq7dWnNA8fJtOb346RXmWYp5lTbQXMV5w5bbfhD6bwTJp8PWxLj
	 xiTRi0rOYinFu9xwTQKgv3s1yzPt26/hnQRViMAYSYqMRr+ogGAkiWPm9YiL8+zwZD
	 Xk0fy0Fhfp8tlRbW405XaVYRrghfX+WAUNdDWHa3sCJRGl50At2akdoDrIDPSaIXZM
	 BGBNC92fMR8Sw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to relocate check condition in f2fs_fallocate()
Date: Wed,  3 Apr 2024 22:24:19 +0800
Message-Id: <20240403142420.2042498-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compress and pinfile flag should be checked after inode lock held to
avoid race condition, fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 148bfe3effdf..83a807e25e31 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1820,15 +1820,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	/*
-	 * Pinned file should not support partial truncation since the block
-	 * can be used by applications.
-	 */
-	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
-		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
-		return -EOPNOTSUPP;
-
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 			FALLOC_FL_INSERT_RANGE))
@@ -1836,6 +1827,17 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	/*
+	 * Pinned file should not support partial truncation since the block
+	 * can be used by applications.
+	 */
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	ret = file_modified(file);
 	if (ret)
 		goto out;
-- 
2.40.1


