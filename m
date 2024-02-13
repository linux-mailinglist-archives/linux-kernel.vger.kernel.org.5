Return-Path: <linux-kernel+bounces-62570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A36852316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D551C22A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC81EC3;
	Tue, 13 Feb 2024 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryCzDLdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00753628;
	Tue, 13 Feb 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783521; cv=none; b=pD+Zh/3dz8W2R2IPZfTBOxZZ82cc0HUpmw5UaqdA0fI+0w2PF2ddJN0nsA7rhHyeGdk4eHjBcmQB4fBG7fjKsY2i4QJGuOsMVN6gAG3ahli//YYSVyRSg+3M9SQ8mg4PmSDChftNS8k3xStsli+YGaJKp6hCdARP0/B8coAJ/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783521; c=relaxed/simple;
	bh=2j3dNwDryiyvYFP5CnvHVh2czT4Remf6l+d6t6Xcu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJ+f94PUG6Rrz8gQYJqxPWupUP/VEw22gpkhMJR9yaQvF3LSATRwPu1CaeqyY4gYHLoyH5d+wkfWjuC2ylOoI/2ldd4sDQJOmLZ/C7FagacFOGsEHojO28m334b4K5HGMTiR4QER1Xr0iPKfZ9/XDm0ES33tRRAtme0OoatAIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryCzDLdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5D1C433F1;
	Tue, 13 Feb 2024 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783520;
	bh=2j3dNwDryiyvYFP5CnvHVh2czT4Remf6l+d6t6Xcu3w=;
	h=From:To:Cc:Subject:Date:From;
	b=ryCzDLdxeLdsr+nN4ZoxsqO06lexDPBjOHtTdswGq2pKHoFJBXXQDznSIp0qpCWhD
	 HiQHptn/5x3lMn09Cb+ixGtKiZ5oVwrvZ6eEcvFhgRCla6LSxFdNOOaHof0W+UGSxj
	 12OC94pj6xcOh5oHE3V3MQ1eBgFunav0kbobWfjTGVkXldE+diQ9D9NoZwUwR8gB4/
	 qdE7OPiNZ41c5ZkuDcb7ZdyEOIQj9dWl/HxsERN/ynFgfaz4SJQxaPcyqlFmSV48i2
	 LtQFbGZAGS0Ew2LrFIYQK0qIXtqOUS/lVUHMVygCHHV75D2YiqbS7pL1rUqet6SqIn
	 FAtujU989r73g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 01/58] fs/ntfs3: Improve alternative boot processing
Date: Mon, 12 Feb 2024 19:17:07 -0500
Message-ID: <20240213001837.668862-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c39de951282df9a60ef70664e4378d88006b2670 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..09d61c6c90aa 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -866,6 +866,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	u16 fn, ao;
 	u8 cluster_bits;
 	u32 boot_off = 0;
+	sector_t boot_block = 0;
 	const char *hint = "Primary boot";
 
 	/* Save original dev_size. Used with alternative boot. */
@@ -873,11 +874,11 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
-	bh = ntfs_bread(sb, 0);
+read_boot:
+	bh = ntfs_bread(sb, boot_block);
 	if (!bh)
-		return -EIO;
+		return boot_block ? -EINVAL : -EIO;
 
-check_boot:
 	err = -EINVAL;
 
 	/* Corrupted image; do not read OOB */
@@ -1108,26 +1109,24 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	}
 
 out:
-	if (err == -EINVAL && !bh->b_blocknr && dev_size0 > PAGE_SHIFT) {
+	brelse(bh);
+
+	if (err == -EINVAL && !boot_block && dev_size0 > PAGE_SHIFT) {
 		u32 block_size = min_t(u32, sector_size, PAGE_SIZE);
 		u64 lbo = dev_size0 - sizeof(*boot);
 
-		/*
-	 	 * Try alternative boot (last sector)
-		 */
-		brelse(bh);
-
-		sb_set_blocksize(sb, block_size);
-		bh = ntfs_bread(sb, lbo >> blksize_bits(block_size));
-		if (!bh)
-			return -EINVAL;
-
+		boot_block = lbo >> blksize_bits(block_size);
 		boot_off = lbo & (block_size - 1);
-		hint = "Alternative boot";
-		dev_size = dev_size0; /* restore original size. */
-		goto check_boot;
+		if (boot_block && block_size >= boot_off + sizeof(*boot)) {
+			/*
+			 * Try alternative boot (last sector)
+			 */
+			sb_set_blocksize(sb, block_size);
+			hint = "Alternative boot";
+			dev_size = dev_size0; /* restore original size. */
+			goto read_boot;
+		}
 	}
-	brelse(bh);
 
 	return err;
 }
-- 
2.43.0


