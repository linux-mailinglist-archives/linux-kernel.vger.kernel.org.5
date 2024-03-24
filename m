Return-Path: <linux-kernel+bounces-114626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA183888B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AF8293A11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A813CA97;
	Sun, 24 Mar 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIbkhoOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1714E2D2;
	Sun, 24 Mar 2024 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322291; cv=none; b=sPp17RKPR/v3AQbzOX5yNkgCOPWLfVcEkeYDFXX3wtR4UJNP24VDMjFAm1v7mNW10eXM0QLBYT3Qir2relriLCCp+XAELh+zRBS7HQbznYkGfQnoS+/trdgf+6eSFZI4vQ72EY8xO3JSk2LGZoWIN5Js53Afccq4vz0QVQTMa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322291; c=relaxed/simple;
	bh=PY2HaD5LHa66OiiMDqlmoq5AVK70iTjWuMpPYegjr20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCRX+ux5wLsLL+ZPD3U4WkkrajZ1hlEv0hzAIzrPMDfShI/HLc9sY9y529E1Q/tPBG3oEfxq9JWMWrMashpiuvjojoYZaH2O6YHZpyb/PEDJ0Ajqq5/BP24pqwb8LIRfYl4qM26QPKZz22tAMHWXGtqi2sa5h1+47LUrv0WEggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIbkhoOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB3C433A6;
	Sun, 24 Mar 2024 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322291;
	bh=PY2HaD5LHa66OiiMDqlmoq5AVK70iTjWuMpPYegjr20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIbkhoOG68QDoZxEVzCcSn0Jof+UHdbeGbwlo13pQjmHWfjoXuQ19qz/JxRPGunUf
	 ohSe0AsZrSfaygaIRjV3iwJGsSQF7TqxZu5reRjd0G7A4bb9zsNhQqG91xuPjemkkG
	 K7teoHxfFcQj8m6stf4KU61O+yzGNPDms6LvzYn5q5SaQ9vOgKS/mSvX3b4FGANZFh
	 Stcaiqv6AMTGhiKV+Udw1X8e5gVt97TtY4k7j/f8WZVNQSGiVCC+P+XtD5j/Q2jUDC
	 NinrqEMlq1NjlBBmFCxcC5AYRFOCGJlnxMPp6dpFfU2PrUQXWov/k08MNEcRHYU8ph
	 r4s1VVKezqQdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 374/451] f2fs: check number of blocks in a current section
Date: Sun, 24 Mar 2024 19:10:50 -0400
Message-ID: <20240324231207.1351418-375-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index f3951e8ad3948..aa9ad85e0901d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -586,23 +586,22 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
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
@@ -651,7 +650,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 
 	if (free_secs > upper_secs)
 		return false;
-	else if (free_secs <= lower_secs)
+	if (free_secs <= lower_secs)
 		return true;
 	return !curseg_space;
 }
-- 
2.43.0


