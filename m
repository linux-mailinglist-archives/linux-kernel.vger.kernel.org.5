Return-Path: <linux-kernel+bounces-96490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D086875CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A451F21ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCB2C6B1;
	Fri,  8 Mar 2024 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYSe037M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB72C6A7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869874; cv=none; b=oY7KYKY1WHuh3beEZqULYH4XF42d5+IkxGJ0apY6rapxWAbezg6/LwtmbtrM3eTWafcRQqQqwjlErm1oJ573nYAbIYfO1AblnMC1UtJ0a+DWglhIkSXyS/rwnVxpTkoJtXPykHtd/gPQVvNw67hVTbFqydr2Yv8AeuNxHl0GibI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869874; c=relaxed/simple;
	bh=L+U3YTJaKWjFVJqwd79Dx/KrkVoS6k2lA1363JvtMf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWf5MFknTh+z3JjWDXCg2NP1j+0WFg4K3iLYc3zNAfplu8IyprNhCyvGioxnLVnJda1NEHh087gzj/TwRmDM/kB47NczBOa4yg9hWEkPlBUjfh7AN/gxC8PYRFPPSJw2o1t2jGZICuTl03jOHlj/MD9E1K4O+FD/YupgcvEbs3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYSe037M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B8DC433F1;
	Fri,  8 Mar 2024 03:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709869873;
	bh=L+U3YTJaKWjFVJqwd79Dx/KrkVoS6k2lA1363JvtMf4=;
	h=From:To:Cc:Subject:Date:From;
	b=pYSe037MGJ18WUss5lY6ExOhP7hT5uqZ4h2ePbprihz92o+JWRwu3szl8/dcJliEP
	 0lqdBHwL0Z7dcsVhcNL2Cb6Mmth3xBtPIXmm23nkC51S3JHWDmEBiuNWyGroT/257F
	 dfTIG7Xv5t0+nvJ8WjtlHU+JpdNnNvVQSog+Y7376p4U0BWhbSHNjo6PwXI61LR6Zl
	 hp5I8uz64gCYrBvNHGDLj/6KDbaiHq0qNzJGAEvOWhtJggDeL9Ns7LQ65KmysxAVHt
	 gv1b+K4/rslUOM62uWJZgCWYbyBBqas0DN1fscAWhYzJUd6AEn+k/jmxr9/97D6MJX
	 9LFj2L3lij4iA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Feng Song <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] f2fs: zone: fix to remove pow2 check condition for zoned block device
Date: Fri,  8 Mar 2024 11:50:57 +0800
Message-Id: <20240308035057.62660-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned
device") missed to remove pow2 check condition in init_blkz_info(),
fix it.

Fixes: 2e2c6e9b72ce ("f2fs: remove power-of-two limitation of zoned device")
Signed-off-by: Feng Song <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0676c2dcbbf7..fb4c1ed72710 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3874,11 +3874,6 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
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
2.40.1


