Return-Path: <linux-kernel+bounces-72255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027385B133
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451F9B21D02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B86433CA;
	Tue, 20 Feb 2024 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLRUaBYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452834A3F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398926; cv=none; b=O7HrYaRM2XnPEc5diPBeRrRfR3JzgKZR2AJ0AJvFfp8jXAqKkO2H34Ev7Bz7qVDnMuUXo4kapMxJWrGe2dclpQ8pXKRQS7JnYGc+IcQn3nvG5+gPJBehLnmwm3+Deaiej6j1GjSuxIdQMgDP7x70cfXeRMid729c976O/WmsfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398926; c=relaxed/simple;
	bh=wcGy26e5hKuwjbVHIKAwO6Zpao1Gq1LGw3qoshIq2tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jiDZLSuI6RkxvPPdB6/+fr2rLxfoY4tksi87truAY3/4XVFmWokEzUY2jbYoIx1XM6263xw0s4ZWdQBp+hQPutQhNKK3MopNxzKqqpk76qaBmQwyyNkPjiHfEDx056y8OFxyHZEpLqOfISGidCWWFiPLxYLiwjlTvQO3hiK6T7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLRUaBYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5CAC433F1;
	Tue, 20 Feb 2024 03:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708398925;
	bh=wcGy26e5hKuwjbVHIKAwO6Zpao1Gq1LGw3qoshIq2tI=;
	h=From:To:Cc:Subject:Date:From;
	b=eLRUaBYXEuPPYJHEymbnuz8iJrOunSt540tSXCPYysJL+xjSYLrR0LWA/6m4suEd5
	 1pJtd/3Crt9VAzdwOEHQwzDRYrAg4g5dEW+swJGkk9QEN4kdpEWmOGFXl+lqQfm83S
	 e+cifTigiAvVx0nRhXfmIGuPWxMrNy+gaSba/ZduSqUST3sbk3pV90DyQpnsqBQr41
	 UauM7dqweIOjs6PbfYsOwkeQmkCn7H7Jtn8WcVOEpBtI5qn1fEueNS0dZ0fTH8kUzV
	 j5+aqdFx41g3erZRQTmcn++HW7hRjjiDxqTxKjljwHFmmW6KGh1jap7M9sGQS1tOqz
	 yiHCk0SujT2nQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: introduce get_available_block_count() for cleanup
Date: Tue, 20 Feb 2024 11:15:15 +0800
Message-Id: <20240220031515.4039498-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are very similar codes in inc_valid_block_count() and
inc_valid_node_count() which is used for available user block
count calculation.

This patch introduces a new helper get_available_block_count()
to include those common codes, and used it to clean up codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to last dev-test branch
 fs/f2fs/f2fs.h | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b6c8de8737e..a1640be7dcbe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2278,6 +2278,27 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 	return false;
 }
 
+static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
+						struct inode *inode, bool cap)
+{
+	block_t avail_user_block_count;
+
+	avail_user_block_count = sbi->user_block_count -
+					sbi->current_reserved_blocks;
+
+	if (!__allow_reserved_blocks(sbi, inode, cap))
+		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (avail_user_block_count > sbi->unusable_block_count)
+			avail_user_block_count -= sbi->unusable_block_count;
+		else
+			avail_user_block_count = 0;
+	}
+
+	return avail_user_block_count;
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count, bool partial)
@@ -2303,18 +2324,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count -
-					sbi->current_reserved_blocks;
+	avail_user_block_count = get_available_block_count(sbi, inode, true);
 
-	if (!__allow_reserved_blocks(sbi, inode, true))
-		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
-
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (avail_user_block_count > sbi->unusable_block_count)
-			avail_user_block_count -= sbi->unusable_block_count;
-		else
-			avail_user_block_count = 0;
-	}
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		if (!partial) {
 			spin_unlock(&sbi->stat_lock);
@@ -2610,7 +2621,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count, user_block_count;
+	unsigned int valid_node_count;
+	unsigned int avail_user_block_count;
 	int err;
 
 	if (is_inode) {
@@ -2630,17 +2642,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count +
-					sbi->current_reserved_blocks + 1;
-
-	if (!__allow_reserved_blocks(sbi, inode, false))
-		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
-
-	user_block_count = sbi->user_block_count;
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		user_block_count -= sbi->unusable_block_count;
+	valid_block_count = sbi->total_valid_block_count + 1;
+	avail_user_block_count = get_available_block_count(sbi, inode, false);
 
-	if (unlikely(valid_block_count > user_block_count)) {
+	if (unlikely(valid_block_count > avail_user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
-- 
2.40.1


