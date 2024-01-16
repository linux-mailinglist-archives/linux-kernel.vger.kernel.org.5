Return-Path: <linux-kernel+bounces-28021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456A82F930
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179A31C2518F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAE2C85D;
	Tue, 16 Jan 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUdq9p29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494D2C844;
	Tue, 16 Jan 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434923; cv=none; b=Gw3JTlDAaI0Mszu22Os9xzTpeTUQwcH4WjSFKw5LvD+DkGRxUSixNpl8gDZ+kylbtizZJ2Cf6xQOhpCzGn5UNdycvF2JMR6Vx67qkne0vJckdoGPj1bRmRPnz2hvDvQng/e+bd2P0UO0G0DJ0nAaLevfAWdWSuzLSpc5djTTzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434923; c=relaxed/simple;
	bh=Nu67YcmV68YpVzKmLQNFlbjgbFW/NcbGalpeDYXAi2c=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=eX0zxJy3dltlmmayVpukV+5R2bnYIjWjxSl08mQDS0PU4UOFMjtekFLvwqVJR6USioevJEnu4R9pmF2R71kK7iDBmSpgs4FJ1XwUvSsKzHMggPkNE8xVAPCMvNpRPzb0dRRFG/wR7yYV6FbyhdJPkg5vAM6yZPIaSIxyXOiURD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUdq9p29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF9BC43390;
	Tue, 16 Jan 2024 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434922;
	bh=Nu67YcmV68YpVzKmLQNFlbjgbFW/NcbGalpeDYXAi2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUdq9p291h5oLDCevv+MipIwu1CmDCXW/PUUxhYCRalvm9eBgoNjfQkgAnPigvLvs
	 UjqxyY7RlZZzycp+rcKKO9GuVjBN3bK8sv4h7k75SgoU+EHC1ry0ih435ZaZq9ZpQQ
	 FPsg4PUw0k2csOWzc8eRy/4mZjnBue1fzxYsQAEexltxzeaubIVfx8xF6Spoi+RRtE
	 P4/iO23FmJOZwt7ijAtXWb8/5cQOKqxYSnb5zijAEMWu0zg6w9fgqM2Q9BpjJATuPW
	 YUc/PApnR6X2AowqzH2ek2qC5Noe5uP4AYoD8CxQRMEw2F9k3lfiEHAhVgO8pp/GQR
	 fZgiI2SHUtRUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiji Yang <yangshiji66@outlook.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/68] wifi: rt2x00: correct wrong BBP register in RxDCOC calibration
Date: Tue, 16 Jan 2024 14:53:03 -0500
Message-ID: <20240116195511.255854-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 50da74e1e8b682853d1e07fc8bbe3a0774ae5e09 ]

Refer to Mediatek vendor driver RxDCOC_Calibration() function, when
performing gainfreeze calibration, we should write register 140
instead of 141. This fix can reduce the total calibration time from
6 seconds to 1 second.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 12b700c7b9c3..517d9023aae3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8672,7 +8672,7 @@ static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
 	rt2800_rfcsr_write_bank(rt2x00dev, 7, 4, saverfb7r4);
 
-	rt2800_bbp_write(rt2x00dev, 158, 141);
+	rt2800_bbp_write(rt2x00dev, 158, 140);
 	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
 	bbpreg = bbpreg & (~0x40);
 	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
-- 
2.43.0


