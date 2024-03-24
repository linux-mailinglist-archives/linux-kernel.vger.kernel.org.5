Return-Path: <linux-kernel+bounces-113489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C562A8884BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5098AB285F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176871B5E;
	Sun, 24 Mar 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stoLrILQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DAC13D26F;
	Sun, 24 Mar 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320290; cv=none; b=AywRFewV1jYIiMPKrQsn9Pr0D3RCbPinEJTp/7hYvjWkcLdhs56h+UMqTnR4xDBQTbekZmVJgyYNfRp9pBSfoXCUxxPK1yjVxDyZR2iTbIvy8lRbC1L2jn1fJbN+ihZ5ZzIDhz0ayY8wPODRzjoccsYgR2S45rWWpnf+kNPY18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320290; c=relaxed/simple;
	bh=doHdMExkYh7d+6RnWCqt0nUG0jAVLozHtlcdutCqjb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJy4O6XPiJdTJl+x8mYFH6aqiVD1XCfw81nsqEmZqP5NSFDKKOpr99KBZytD31ItQ/drNR0peak5lP+RU9W2nW3vvJ5iSLI8GhEfEJcfPX9cphLIaznHSWlEXNmwEi798j1mKHrrdp/MgBPrJAn7MoYrHkBsN8aUTaBNy8Y1AmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stoLrILQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860A1C43390;
	Sun, 24 Mar 2024 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320290;
	bh=doHdMExkYh7d+6RnWCqt0nUG0jAVLozHtlcdutCqjb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stoLrILQ62GOSSeu7Fvrl5vAIEi+Ck0p2P3jBrzzQrOX4iuy2ipTHUlULxqaar0BG
	 lBX12wgF6hMupSP5IpIg7M/Gq6pwODDUN33FTsw+2iYE5g1y9I8BkDbG0owAe5LRld
	 pSLqKqQMrGsws7oJAYzXTvbXNReUkOYqkYYQpRKj/GKIta6OFP+0Am/MZj+xGdomu9
	 8Uc+f55rhEspw+/GSGgnmdND9tKLfQFKOJRXKKCwlMnlxt5A1ZfDEP9sOQQpP4vNfQ
	 HzO48zttqbOa4dTP3I5E3oaR4I42SyGXoBo5b/uqhFYVxDemu9nWs19YtB3D2ubapA
	 OdNOfZbr8ylBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Feng Song <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 598/715] f2fs: zone: fix to remove pow2 check condition for zoned block device
Date: Sun, 24 Mar 2024 18:32:57 -0400
Message-ID: <20240324223455.1342824-599-sashal@kernel.org>
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
index e64ce5abcdf44..4ba613ed3a179 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3936,11 +3936,6 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
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


