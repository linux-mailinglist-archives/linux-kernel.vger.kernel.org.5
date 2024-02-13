Return-Path: <linux-kernel+bounces-62632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF338523DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE49A1F22573
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19EBE49;
	Tue, 13 Feb 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jks511qW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6A10FF;
	Tue, 13 Feb 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783654; cv=none; b=iCzn5uN5r1Ot0+pZJLwlId03ZX4c414kSn2UmcB4wlomNZ9uKk5Qy7aPx3pfCTCGlKTuLycFmdmBf8895rJ8hZtIdRqUsPIsEVqKbLA5toHsxpIlcayQLR0D8GenA7+sDLp0njPW3ioaoXmk88ZufIhzKYVZX5FXe7AcWh+0xRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783654; c=relaxed/simple;
	bh=DdzK22q+qsA1FusfEyCR6OfvhS+La0DV+WT2cEim5mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPFOEE/9XUrrsy/V3uzP/7N/ZtA/l7SRVFDGKL6XKUXODsrlm+wCYJTE//V7Ei5H719cS18XkQgEnJn5AZYm1cBRFsby6AU0zU87ReL1l9N6N5RTYC8ft+rTh01My/LUWmi/o7w6aYSdSk8aqwX0TRvSnnsIFt1aU8Vbh3MoBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jks511qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA18C433C7;
	Tue, 13 Feb 2024 00:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783654;
	bh=DdzK22q+qsA1FusfEyCR6OfvhS+La0DV+WT2cEim5mw=;
	h=From:To:Cc:Subject:Date:From;
	b=Jks511qWpabRviuxoCXeL75aIG56oEoSigLTMMqGEKg6ZiQpYBLjhy1xOX+kZWQsq
	 Mak8tt+gEhsuRTvmEXomfp/PYTNXtIoQfifBJSlGO4nGEKbH7Wq3Aib/S+iu0/JRH2
	 PLv5J16H5ozfsDe7xi0ymzHIxdhKAg0HOtq6kfd7yQFpIs4jFP6PBIig7JHFbBre4A
	 XGY3wAFPH+6ldaQTn2Zk29vsw4k0QOZ89zN3ljN6XNVIv5t4TydIcow2k6Ll9lLxM+
	 3dHuLDyVeQTaeCjXB2qXnJfsZ+wzj6r3Uixg3I4S4ZYE6BFNuVoBlS6Yrmz34tbgy/
	 21rAcQKgDw0xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/51] fs/ntfs3: Improve alternative boot processing
Date: Mon, 12 Feb 2024 19:19:38 -0500
Message-ID: <20240213002052.670571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c39de951282df9a60ef70664e4378d88006b2670 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/super.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index f763e3256ccc..aa3b2c262ab6 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -865,6 +865,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	u16 fn, ao;
 	u8 cluster_bits;
 	u32 boot_off = 0;
+	sector_t boot_block = 0;
 	const char *hint = "Primary boot";
 
 	/* Save original dev_size. Used with alternative boot. */
@@ -872,11 +873,11 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
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
@@ -1107,26 +1108,24 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
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


