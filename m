Return-Path: <linux-kernel+bounces-134220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92D89AF31
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7731C21D48
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9F8F72;
	Sun,  7 Apr 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh5p1nnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647B2599
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474775; cv=none; b=dFrC1vqYJqS5txNqH1nH9rihA31g4AauVos7wlRy236xYXk6lPSJHBSdGYdmYpGvLTtzdGELEdEB+PCpiXBfh+Fw/NBuNL1HMfAgn3jnCbX0sOB5Sj+v7A59f8Z8UMB4TqF1Y4Sv42I1ZYWRkusLQl+dA120stgqn7GDKlpuDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474775; c=relaxed/simple;
	bh=4yvmXrQIABNgfTHlOdNy+K4jA8VXyviaTqDUNFlSm1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uUU85sSz2OjNFNoQh7oKicyKrOVBjWzXKwWNpYQpIgMUjTOSpLbhH8brieZ2C0WmlTkYNkTOZ/H9xVukayJoiWyLddD9vxtjbJFAl1YHhQu9Xli+/Yq4OnoVPHzyhXicAWmZfl2KnbzB/4nuc+x0zPpSRZe/3SJEJWNmjJEy/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh5p1nnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D0C433C7;
	Sun,  7 Apr 2024 07:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474774;
	bh=4yvmXrQIABNgfTHlOdNy+K4jA8VXyviaTqDUNFlSm1g=;
	h=From:To:Cc:Subject:Date:From;
	b=eh5p1nnEUfUb58qHgCn+7+2N1aCyUBi8S8auz0nYi2fHS9xQnZ18VaOwgVlbs6KMh
	 i+iNBSouoZzr3cvFNNiBE9RYE9rJx0q/bmK+FvZwNQeFK3gms9Xup1c9Kqi5WcMFyb
	 XGa5XHsJS5PwepFX1hQ3OvowWsmYMLkSzKHf0m189bPFlR01tA6U9fabt9XLQPXdXC
	 FfGmdfdXQMK5P7UFtvq3HintezEH/ZrTq1G1pH0ndd5GRRDi2ivKVtivT9BG3h3HXq
	 WKFCIcjksTN1JeL5N2UGCyn+7bgEYRh+bressp72vpzqjISC/68IgBKUMnbcqpNnW4
	 GBbE2gAVaJ5CA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 1/2] f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
Date: Sun,  7 Apr 2024 15:26:03 +0800
Message-Id: <20240407072604.3488169-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compress flag should be checked after inode lock held to avoid
racing w/ f2fs_setflags_common(), fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2cd4ca8433e1..ca401cf8152a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3549,9 +3549,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3570,7 +3567,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3731,9 +3729,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3745,7 +3740,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
-- 
2.40.1


