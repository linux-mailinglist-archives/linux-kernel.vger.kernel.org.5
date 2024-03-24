Return-Path: <linux-kernel+bounces-114398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDEA888A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA0B2BA98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8C275512;
	Sun, 24 Mar 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCMNXeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AD2197AB;
	Sun, 24 Mar 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321807; cv=none; b=mMvLhGy6aCwJw57ZwvaBOztuaXb97XPqUhSLrc2g31RY3MHU8VwhG1JTtRUvt4jChlLHRoenSo31g60PKcYoIU0MjF3p3nOmCS6hfws4Ghahg3oMukjnS+WsO6j/wJosgKom9nu7vKuDp5CEmOSMT62B94kVnN37vpCLDdf1E1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321807; c=relaxed/simple;
	bh=MpvWpxPIpAPm2MVsULn7crocH4OeN2+YDLBGTOZoCJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBdyUENsffC5COldWb8klOHnDtq4vxxUsRKO+6UC3McfhMOFeW1Tfj4xBhea/HKW9b39wYjYSnwqzxd+UTUebivL4/IhDGzxgVKT3jn4OpIEtyTbW0Y8zT4eEEaui4oxfOc8qBh+mN+rmKDjKd2m11Fj0jmYK7fkLkyh79KQ0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCMNXeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2CBC433B2;
	Sun, 24 Mar 2024 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321806;
	bh=MpvWpxPIpAPm2MVsULn7crocH4OeN2+YDLBGTOZoCJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNCMNXeKg0uC1yGgr+S8R0fwiBqWyl6ewk4+Y/+K+9oe2JO5HyDnvqhjKqgfjN+BF
	 4P/+MoRMeWBm08rBAQmdCmS4ksJM56kf7JmFIuMEXpLiubvA12bG1pWJ+bNfQtpvQF
	 e/2ZBf55q2TB4zsExKM81eTNVmW28VUIIn7JkTQAy03478G2lCr3IGl1BwrajBBpMf
	 ybm0a7EaSsFwHikw8d4uYlddx3PPT9pFue/2I6WHp9+dokYyLQ4BAkf3SyY03cNlSA
	 vGLixpeDLYTKpPpH1PtH0EossPkltUPmJkPZmMNVM660udHevTQkZvYgr19a+D19dR
	 0xHGw+GS1IPBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 534/638] f2fs: check number of blocks in a current section
Date: Sun, 24 Mar 2024 18:59:31 -0400
Message-ID: <20240324230116.1348576-535-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 2ca8fb5d0dc4d..20580ebd24138 100644
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


