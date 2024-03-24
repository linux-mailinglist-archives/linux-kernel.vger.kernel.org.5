Return-Path: <linux-kernel+bounces-115536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09517889C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD71F35E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B498245E30;
	Mon, 25 Mar 2024 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwYYM3ya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABE14A634;
	Sun, 24 Mar 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321030; cv=none; b=aa9yu465skK92/2hCwTucSM5m+lG0wcQ/RAsU3ESvCPqHLGjcg3ZJAP3P1rYAUKOh4mjCCFQBhsfsCrihtryTK1nPS18JMD40xyDwqLCGATnqxVMDExUh0YHaOaJg/pym3RwIwka9k/GVLn8B3S/0K5BLCYBTGI13LkVyaPpCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321030; c=relaxed/simple;
	bh=Cj8amsikF3auzo51ubBDZNkX034jMQDuD+e/2IkAstQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH2LyARIe6932Wj93LrU3OHlfNt/WUMQwYne69vyIus4K64ecevVoT0y75quCGW2HW2qrNcWsRlhLP4kwsAPYI6MYE+kOiGeVwz5kCirq4b808hJhmIdjWxKeg0//B3cJ7cB59zUJN4V7TS/Xk/8tmWVRohjjvsrZWiC69aj4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwYYM3ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96CBC433C7;
	Sun, 24 Mar 2024 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321029;
	bh=Cj8amsikF3auzo51ubBDZNkX034jMQDuD+e/2IkAstQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwYYM3yaSRiQv4pGToi1yh7YpEfAbj0VQJxOD9XgHvmSCLrUMkensHLNxhm6E3n+L
	 +rjho1ujHNZQ/cM19B0tbterzUpum7XhK6eZoo48KGNzLhMsLMxf6mfHT/Ir8UO2w8
	 vCmqjbouc5NjQv8esKFEDy4R3iNiyIQJvRYrEEloeu8um7ihjLkSh0XuOqPahknkOq
	 DGYMrmfXTwtewgrZKonbk96nfFBe9xcVBxKBOXr/MKrHmoDPdgVOdWosWQSEpXw14m
	 CtvglP74P9hjVv8stya/WVpadgaf8SdjksPKY2vWu/3xDYEohVy3Wc/v8ItJG9RZ9D
	 qWgpV8SYQs9cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 592/713] f2fs: check number of blocks in a current section
Date: Sun, 24 Mar 2024 18:45:18 -0400
Message-ID: <20240324224720.1345309-593-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


