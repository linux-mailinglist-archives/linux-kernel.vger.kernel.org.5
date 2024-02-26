Return-Path: <linux-kernel+bounces-82435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD4868484
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D671C22096
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545F135A46;
	Mon, 26 Feb 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDaQrFRr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3B133285
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989269; cv=none; b=Bap0HjEmHzurEtvFgWjDI4ydz/OhecRYMKSGNQbyZnSJKggL4VhuJ7FTaGMd6np7yARZyct4I3CYddF/jW3PIeeWWsx6IGq3r0fWZBQMpwWOicZw4wFUqQzu29XTYFRiLIVWXoLHyunAG1Rg2ELcQyKQuLzGypCs0onbnjOb9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989269; c=relaxed/simple;
	bh=O2m22R0yZCGVUk6cDrklmfyRKcLTlO8eSyTHoowZsEA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUPOnKyGCQUP04tYYg+yoq4K/cvzIgM0GpBIA0Upl9FbIo2PtH82L37DOgKAQS4a/0ysaz7NAHQFnMNiYoZSBvoJMiCCeSkUQSdrqczOANYxJ4kW8LUxRsrjqxafge96N9YPXEkD30KWUhHSK7yrEJLwJLoY6bTNFIGYuATFCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDaQrFRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CFEC433C7;
	Mon, 26 Feb 2024 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708989268;
	bh=O2m22R0yZCGVUk6cDrklmfyRKcLTlO8eSyTHoowZsEA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=FDaQrFRrmymL+JYoAdRI13bV7T8F3WAJ2guVlW5g1VaWiWm34V7JVBM2RkJIUoRlb
	 D2DqI89d/OcyH04NS0dbUQsfQ/Yu8e5e0gi5SmVH48vQNItQtDQ4UDprXuW7oiMr9R
	 WdG6HCdA7CgIdOy8GMkEB0an5bBFAX+AIJij5pjmwCgenVeLmaSZ4x87686VCLvyzB
	 30xoADnGNJZKRdQXQrWn5Zg2tknISMO2IqhcvZS2iNO8HrAoZ4CSRtycFKwV8pp/tu
	 emD7F5qixKWTCBp2U3W8uE2F+WXn4B5m+Yyp52DS8L/LwbinKgIVAxHbLpxhuqHvfo
	 fTzv21yohbATg==
Date: Mon, 26 Feb 2024 15:14:26 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5 v2] f2fs: check number of blocks in a current section
Message-ID: <Zd0bUnFCWmPtwK2u@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>

In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
the number of blocks in a section instead of the segment.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 from v1:
  - check current node block space to deal with the worst case
  - TODO: need to fine tuning on node temperature

 fs/f2fs/segment.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3edd3809b6b5..335fc6285fa5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -561,23 +561,22 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
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
@@ -626,7 +625,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 
 	if (free_secs > upper_secs)
 		return false;
-	else if (free_secs <= lower_secs)
+	if (free_secs <= lower_secs)
 		return true;
 	return !curseg_space;
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


