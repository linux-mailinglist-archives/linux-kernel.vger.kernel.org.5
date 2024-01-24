Return-Path: <linux-kernel+bounces-37198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646083AC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D260529BCC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E67E79E;
	Wed, 24 Jan 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+nvrq5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647E7CF15
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107433; cv=none; b=YmSQQjfibdMJWJl6d4D3rWIYTAvXraQXI8qgPxBVY/Cscc0lc+o53Nd0dPYm0NbcrW5DW4EMFrjDP/Bd0rVgdS0trrUPE+T3j4xT728V1kKxASUZMj6lPaP9Yz1Bkd+B0+OSEfHtUtDF0vQTOek4DV5cBvbF+SXtiOVxIYCwSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107433; c=relaxed/simple;
	bh=W4jjIT3rFGY05/gjE0cqYf1XPxshz9/frF5SQn/Cvy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fzkck6XY7FDdI2cbI8X5+M/lFLoVrTwPUZC0Y8EAWY/AhCVKU/RjLJO11oQJRv9VLHqmVVb4E0IQiKDGZBNN0orj/LZKDuJ3ZgR+oJFcR50COPIYQgM489nfALDZKO26BZjBLgZ9EzYs/hwI8rP8WJpzYqhcj6Dn+SAI4XT28Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+nvrq5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE2CC433C7;
	Wed, 24 Jan 2024 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706107433;
	bh=W4jjIT3rFGY05/gjE0cqYf1XPxshz9/frF5SQn/Cvy8=;
	h=From:To:Cc:Subject:Date:From;
	b=Z+nvrq5Bor6DTnQQZYi7BMd6G/paRdTOD1kasJ2W+8VMC8yyAJiMFZp3guRoVCi3P
	 rcRaS95gCbn61GN0ybv9qcFc45ovLTdpKJKrw88jXYrFTJdhWB2A/Cu2HPW6lCirQN
	 kB5OiThib+tOqgK9yxb7/un1DtGo+3UfdIcVWUBmYCwtt9ejvGViq0JoWc5BiISFVY
	 jRL/QQpK1BNE9/O3q2TM5zcSMuMmMQVcZ9n2Vd+lYUNz+CeSxaCHZFmzYoX3b8/yzY
	 N0KvgzXS6/3E8BsHmYSjZ6P/E2PiaQUntPk8nrn8fECNpoKheeYUrbAyTpvqbXGso7
	 /Njj8KEqaoVAg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce get_available_block_count() for cleanup
Date: Wed, 24 Jan 2024 22:43:42 +0800
Message-Id: <20240124144342.14612-1-chao@kernel.org>
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
 fs/f2fs/f2fs.h | 61 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d19643a92af..0094a8c85f4a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2253,6 +2253,31 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
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
+	if (F2FS_IO_ALIGNED(sbi))
+		avail_user_block_count -= sbi->blocks_per_seg *
+				SM_I(sbi)->additional_reserved_segments;
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
@@ -2278,22 +2303,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count -
-					sbi->current_reserved_blocks;
-
-	if (!__allow_reserved_blocks(sbi, inode, true))
-		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+	avail_user_block_count = get_available_block_count(sbi, inode, true);
 
-	if (F2FS_IO_ALIGNED(sbi))
-		avail_user_block_count -= sbi->blocks_per_seg *
-				SM_I(sbi)->additional_reserved_segments;
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
@@ -2609,7 +2620,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count, user_block_count;
+	unsigned int valid_node_count;
+	unsigned int avail_user_block_count;
 	int err;
 
 	if (is_inode) {
@@ -2629,21 +2641,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count +
-					sbi->current_reserved_blocks + 1;
-
-	if (!__allow_reserved_blocks(sbi, inode, false))
-		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
-
-	if (F2FS_IO_ALIGNED(sbi))
-		valid_block_count += sbi->blocks_per_seg *
-				SM_I(sbi)->additional_reserved_segments;
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


