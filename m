Return-Path: <linux-kernel+bounces-114407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B324888A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72E028B676
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18FE2779DA;
	Sun, 24 Mar 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACTtapbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67C155388;
	Sun, 24 Mar 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321821; cv=none; b=hAlrSBqqFkXyZQYlGTu0CY2OL5IWdgeCRiOxE9BB6RZqvogk932nhUJkWXvwhblbSp+VZJQe8+mulwKwyD05P0pxic99k29qlECNcVubH6zAwFR6YujOn1IuWCiDdhJ304LWgDsfuC2yJixm+4l7VshR36lxfNzFKfdi4FsZ6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321821; c=relaxed/simple;
	bh=++3fqFLoJja3VoN3rG1ITpiKO4BY/tQ2GgE97lB6vgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmdVs7zGqJmtHAVpex0xQcwAK7gJ967SC/P17/6LVc5O7/jSVMTawvKOFBaI+0dVoWOGNwpSI95ll9KY1RSFqe4F88yqHXW58mjb5AW/zbnHXVrqecxd09DaWwirykyR3IezizGXlPizbM6tO3Wik1nd9yZ/KEOU8wZHD3mXsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACTtapbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA47C433B2;
	Sun, 24 Mar 2024 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321820;
	bh=++3fqFLoJja3VoN3rG1ITpiKO4BY/tQ2GgE97lB6vgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACTtapboWRmiKNS8gyrClcwlNAVu1CCnG4rdQRZ6BLvBFRBLVowalYAbQh8nJh1Pi
	 xwWuBXjCCOPPa6PP+jJZUxoMt4dPVVFSMFgc5f39GSGgBXEkv9LTOcROAkArWBE0ZA
	 F390kB6dTwcXPB+ugMf20+hzN4gCQeQExALylAc+33pid+4bIhzJvzRzSsTtDbUBTa
	 5HkCDWMEK/s1o2Z198J8Qw/t1mQ/mcI0FQBYIUQFv0UQLxXPsnRBWfUyJ1xs+LGBVY
	 iQC8/8oUNDtAYH0KZMz0ejCMm4SMaXzWy2IpIF2Vh7NGnM4n5wVswWh9As2KSQRU/r
	 4MF/SgZ2d7yqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Feng Song <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 548/638] f2fs: zone: fix to remove pow2 check condition for zoned block device
Date: Sun, 24 Mar 2024 18:59:45 -0400
Message-ID: <20240324230116.1348576-549-sashal@kernel.org>
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

From: Chao Yu <chao@kernel.org>

[ Upstream commit 11bec96afbfbc4679863db55258de440d786821e ]

Commit 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned
device") missed to remove pow2 check condition in init_blkz_info(),
fix it.

Fixes: 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned device")
Signed-off-by: Feng Song <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 76d94889e45cd..ab437022ea56f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3920,11 +3920,6 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 		return 0;
 
 	zone_sectors = bdev_zone_sectors(bdev);
-	if (!is_power_of_2(zone_sectors)) {
-		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-		return -EINVAL;
-	}
-
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
 				SECTOR_TO_BLOCK(zone_sectors))
 		return -EINVAL;
-- 
2.43.0


