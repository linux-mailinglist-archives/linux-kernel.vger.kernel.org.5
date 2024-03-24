Return-Path: <linux-kernel+bounces-114188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DEF888F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528141C2BB08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FF24BC0D;
	Sun, 24 Mar 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwLnOb3j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538313776A;
	Sun, 24 Mar 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321524; cv=none; b=YVoariFAZB54Sxg+M3nG7vC6EdXr+YXwgaGU6yRgxnl3v3YEQEdwGujMBba7kd8/hlE/yMd0nLLYSvDPxAFkwogA71FWPV3Gd22bN55ky1BpY8aYKUY08SIbrr0ee89Vemnhes/dFijZTLZE4BNS+AzvrX3FrXFbeZlmOJTOGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321524; c=relaxed/simple;
	bh=IIAH9R+wJulgFrXMraygEhGyRL+cuXpt2/Ip4olD4X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l20Q6260fjDQjdEhPr1s/vYryxZ/pesqddHxJ2MeV/Psz1a3MTZr4Epq4jN7NCN6SXvIR2950LBzktLThqw1wPfpw+A4Cft8rwAy6Au0vTtDVB8veWOqG+W6qkW9DPkHRri5z0OrkahVBUI8PnmmSX3miI6Ye2m6U5audBrINzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwLnOb3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21986C433C7;
	Sun, 24 Mar 2024 23:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321523;
	bh=IIAH9R+wJulgFrXMraygEhGyRL+cuXpt2/Ip4olD4X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwLnOb3j1sEEhEaciC6xziDk6KIcsc0mC5ZAvSz5qapLubIgnFPh1/DZp69Vlf0s/
	 yae2CuxgfQQFhy2D58MaR5KTYN1aW1BW5ttlRwgmjRepRN3zBpSv7hP98DyoM/tCgJ
	 wRh80mJwcjEmAi5O3vWbz96/4RqvaU2rM3iUE9q0jhEHvq6c5kf/MkaKoQWHDnQyCJ
	 xo11Q/98/ocU4GKFNOEG/hp/bQILyCbpMursjrtIMmc1ehKdCUs8x1kCutieBJf3pj
	 q7Ym8Ih2/OGT88GZk2FMMlBfcCgNjRGjOtmwGDq+Ytbu1G4sg2/Q9cKgnt6NeMEEKk
	 TqAsR5U8/JP8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 249/638] wifi: wilc1000: revert reset line logic flip
Date: Sun, 24 Mar 2024 18:54:46 -0400
Message-ID: <20240324230116.1348576-250-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit f3ec643947634bed41b97bd56b248f7c78498eab ]

This reverts commit fcf690b0b47494df51d214db5c5a714a400b0257.

When using a wilc1000 chip over a spi bus, users can optionally define a
reset gpio and a chip enable gpio. The reset line of wilc1000 is active
low, so to hold the chip in reset, a low (physical) value must be applied.

The corresponding device tree binding documentation was introduced by
commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
properties") and correctly indicates that the reset line is an active-low
signal. The corresponding driver part, brought by commit ec031ac4792c
("wilc1000: Add reset/enable GPIO support to SPI driver") was applying the
correct logic. But commit fcf690b0b474 ("wifi: wilc1000: use correct
sequence of RESET for chip Power-UP/Down") eventually flipped this logic
and started misusing the gpiod APIs, applying an inverted logic when
powering up/down the chip (for example, setting the reset line to a logic
"1" during power up, which in fact asserts the reset line when device tree
describes the reset line as GPIO_ACTIVE_LOW). As a consequence, any
platform currently using the driver in SPI mode must use a faulty reset
line description in device tree, or else chip will be maintained in reset
and will not even allow to bring up the chip.

Fix reset line usage by inverting back the gpiod APIs usage, setting the
reset line to the logic value "0" when powering the chip, and the logic
value "1" when powering off the chip.

Fixes: fcf690b0b474 ("wifi: wilc1000: use correct sequence of RESET for chip Power-UP/Down")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240217-wilc_1000_reset_line-v2-1-b216f433d7d5@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 77b4cdff73c37..4cf8586ed55ae 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -192,11 +192,11 @@ static void wilc_wlan_power(struct wilc *wilc, bool on)
 		/* assert ENABLE: */
 		gpiod_set_value(gpios->enable, 1);
 		mdelay(5);
-		/* assert RESET: */
-		gpiod_set_value(gpios->reset, 1);
-	} else {
 		/* deassert RESET: */
 		gpiod_set_value(gpios->reset, 0);
+	} else {
+		/* assert RESET: */
+		gpiod_set_value(gpios->reset, 1);
 		/* deassert ENABLE: */
 		gpiod_set_value(gpios->enable, 0);
 	}
-- 
2.43.0


