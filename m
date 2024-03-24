Return-Path: <linux-kernel+bounces-113471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D437888496
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70AD1F23ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9413BC00;
	Sun, 24 Mar 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDIHlRp7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C721B3A4E;
	Sun, 24 Mar 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320272; cv=none; b=U5S4eDp+Is0OURYWeVz2JtGwTdQBzLv9R3s1dU3xBVcm/t3KWcQlUiKDOubA9T//5BeDk6PXMtqiWaT2ZpVpWGHdf3lJPj3c7CRHsqvQr0Mw4qgc065XiVwQ1nJCtPbLBIwyC4F7r7wB7e+IDt+W9p18AWzYAhJgUJOGy+jgK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320272; c=relaxed/simple;
	bh=Cj8amsikF3auzo51ubBDZNkX034jMQDuD+e/2IkAstQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIoinQUtqSFZAZl3OY+hj2mXJgIVPaKBZ7xOO63a0XURS1GoFY8+3YIFbKVMBlVtQksWbDSis8X/EXA7yXleMBS3FXsHfqAYQrvM7UjIY7LPjUmukjR7GyOInRBi3+LMPNSPFLD1Dd3HMjYS3ZDBw87freBkIslOaji5mwwNIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDIHlRp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A66FC43394;
	Sun, 24 Mar 2024 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320272;
	bh=Cj8amsikF3auzo51ubBDZNkX034jMQDuD+e/2IkAstQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDIHlRp7Nnw5X3wjxR9CYbJL6b6qKAvg+tWdGnb5cCGiJiMBy0Hh7HKPdkZevoDxg
	 LHvh6Od5rVjCA3tqz9PWwvisvAsW12AlL/DxAgqTq+mQhQEmen6s7rF1tfEgRA4yX1
	 mkspjHYxWedV8ryyEQCipBELbDPMSimVJdRkIK6zmEOlRIy+YH2wgjipxd5gXBOcvH
	 6m8RMdUrPpZc/NfbJ+ggJvhcr3XLqnPaSKDgwSd1l8fUYalO4ie8zrd91gRLzJ4T5a
	 48mlrIvwsJC0eSvsCwbYf9gBZuE+n73rAf12vHrSgw9QXwsZGm3xDm/eVPb0iyY4Hj
	 AvYxN/I+aKBSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 580/715] f2fs: check number of blocks in a current section
Date: Sun, 24 Mar 2024 18:32:39 -0400
Message-ID: <20240324223455.1342824-581-sashal@kernel.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 7af2df0f67a1469762e59be3726a803882d83f6f ]

In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
the number of blocks in a section instead of the segment.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8129be788bd56..c77a562831493 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -573,23 +573,22 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int dent_blocks)
 {
 
-	unsigned int segno, left_blocks;
+	unsigned segno, left_blocks;
 	int i;
 
-	/* check current node segment */
+	/* check current node sections in the worst case. */
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
-
+		left_blocks = CAP_BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 		if (node_blocks > left_blocks)
 			return false;
 	}
 
-	/* check current data segment */
+	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	left_blocks = CAP_BLKS_PER_SEC(sbi) -
+			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
@@ -638,7 +637,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 
 	if (free_secs > upper_secs)
 		return false;
-	else if (free_secs <= lower_secs)
+	if (free_secs <= lower_secs)
 		return true;
 	return !curseg_space;
 }
-- 
2.43.0


