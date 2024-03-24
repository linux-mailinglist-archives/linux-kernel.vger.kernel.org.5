Return-Path: <linux-kernel+bounces-115545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1F88A11E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66550B3BACC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097B249F45;
	Mon, 25 Mar 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JineZw2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9B1EF7FB;
	Sun, 24 Mar 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321044; cv=none; b=s57bbS4JUQVuCcVyOWvmtvadl33MkTaG7hRXcoCZG3Ut+SkxQ82vx9HzSHKMegdHZQeawvCY3D0V6ARdpMToS/gHz2bZ7EXL7ZZFi3hnNLEsZy51iUZA3sNJdquiIZODJYztd0CqM+l4zIyfqzTBaxfvoQBcMfC1RIUYE+wZzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321044; c=relaxed/simple;
	bh=dtJdamV21gnAevuOXezq32BncsqSrlLRSk61ICFSq5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWdwZQwmDj0frOsJVVjTZvjZyhlu/0JDqvIhWsEM7J6e/iBaUebK5T27UqbJ34iRLMi55nctyHz1I0CqdoGlMmciRe84iXbrhL4P+5MMpjp3rspWnMm+fDGDOh3+oP0PyBis9F0+/FlhS8i8wpoa7Os9Snt+RBwP/ZCvjuFyYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JineZw2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CDAC433C7;
	Sun, 24 Mar 2024 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321043;
	bh=dtJdamV21gnAevuOXezq32BncsqSrlLRSk61ICFSq5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JineZw2qbDrsj8h7ftK/yzdi++BhAhcIxRxCaBSyARE5iWlQ3bS7A8snxDLDGmxQJ
	 SoNQoSfPI717mS9fjZkeCZVGlU9x7Du7tnF2m6Eo6hfJ4E+8ircjCAh3GqNhzwvRYe
	 QMzx3ZZ32O7mG0lTW/LMVHUfOCWMddQREoHyEJqkRDQtG7ic9kwz2vOMOpw1SPB8UY
	 RJPouNGoJVexlOjbGOmONpNgRPUBvMPFbktwjBjK4jzXII3iU2AG0DOBNP98klM3Lp
	 181F5et4T4x1BA8Z1Ns87gUiYkIaP/orv6wV57MvfW4TBghfcH2/6IRDHasnIKh82A
	 v+woOe1WFxY8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Feng Song <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 606/713] f2fs: zone: fix to remove pow2 check condition for zoned block device
Date: Sun, 24 Mar 2024 18:45:32 -0400
Message-ID: <20240324224720.1345309-607-sashal@kernel.org>
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
index 655cfadc92457..4151293fc4d67 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3944,11 +3944,6 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
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


