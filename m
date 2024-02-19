Return-Path: <linux-kernel+bounces-70651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7934859AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261F21C210B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822BC23D7;
	Mon, 19 Feb 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt560GmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132720F1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708309731; cv=none; b=tY5701AiymjcZIk2R0aIQMeI0a0dQhe0fpv2pFk9xB44pcdSIBJ1avPYS20QJ9I54eycq0pF/Izr54xtgwfVJwGMPXo7yxNB1Ar9jnRPnC09zBb3OT+NDTq3WhA9Gcv9ta1hfGoXmu+mwA4JztmTNxtROVnarbpTQFAetD8iiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708309731; c=relaxed/simple;
	bh=eM91wp5LBAx8zwOBUALHG4hfaSPH2/dYptc//f0MnoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+Qzgl9L/EHJqzbZzMZpzQ6gZRgCSF5sCTnE4+SNJcBCrqvpbVWAL1argALr5BmDK3MaPze+miJyG+xEhqEEs1AUuAAiFMKu1nW0McYoWSc+RXgZC8FL5IvPCHTg2jwqDBhUH2o9fdLYjr4BlCbrbOn2UF4CUSytkuRtQlExq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt560GmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE51C433C7;
	Mon, 19 Feb 2024 02:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708309731;
	bh=eM91wp5LBAx8zwOBUALHG4hfaSPH2/dYptc//f0MnoY=;
	h=From:To:Cc:Subject:Date:From;
	b=Vt560GmYBuyRJ26CzATnwp7aqyLWr1MABA/yKZVulnb5NFml42f7DtlJwzNNx9ljw
	 9ZgBfXul2d4fKm88yTFpdf6SFXvF+x2rQl4YLS1iQbc0Zwcmb+gWRe9ovjRSp4RrNe
	 2UakcO/BEC1ho/NcrZfRkftZ22A0x7W9Hsvf7u+1Ogdnhn0qBJnfYurLFhcVCnp1uD
	 qHazk3FBCu74DsOIPO2wWvtcCjzFkNi7w5ZSZ+7vdvrYMr3p1gsh7f/Azr2MaQy1jO
	 4Ab2QG+DL9wBYPhw6Y9W7L0W4DNdVssJlqSLTeN9umTuf1d6Z0VgUWOH3rwI6TtsKa
	 OoAFWVXtFlkZw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: compress: fix to check compress flag w/ .i_sem lock
Date: Mon, 19 Feb 2024 10:28:44 +0800
Message-Id: <20240219022844.3461390-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to check compress flag w/ .i_sem lock, otherwise, compressed
inode may be disabled after the check condition, it's not needed to
set compress option on non-compress inode.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e1e9b98f4408..62b51ac550f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4028,16 +4028,20 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 				sizeof(option)))
 		return -EFAULT;
 
-	if (!f2fs_compressed_file(inode) ||
-			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
-			option.algorithm >= COMPRESS_MAX)
+	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
 	file_start_write(filp);
 	inode_lock(inode);
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.40.1


