Return-Path: <linux-kernel+bounces-115899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87898894D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D131F30586
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039F386E43;
	Mon, 25 Mar 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXBlnfIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC31474B5;
	Sun, 24 Mar 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322091; cv=none; b=qy5D90shr7RriKZr0u0SoUyyZlh6OyznDYs8NZue0tc+IRCRrCbH0vQWwf1J9LwXSAb5Zed3gXVy1vxb9YIsPP0sWlj/Plx5hl2XNpSlVHUoOwYPH3ZtgFzQ9HgGhpf/DQakyzl2aNeFk+eSPsXmWGV9D/T1jEyXHEnB7j4cepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322091; c=relaxed/simple;
	bh=7F/UjZRPimn47pyAhv9BpU7s+7ntBT5NTeJBjjqzCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxqoxw+CaG+EB5bOFik/w9esdrIlruj9MFxCAnNFXACniZUbnyQGvtp1Jac2A1Dd0Wx1+17WYxbE5wk9xnCCqRjB1t8eOQT/sZ/yY2ixnLpXmuM1qtF2CcG5X5zMoTCqcBP0doiAOUeuwLji3gkASCl8iU9LFBIBjO4PkA4ljZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXBlnfIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E223AC433C7;
	Sun, 24 Mar 2024 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322090;
	bh=7F/UjZRPimn47pyAhv9BpU7s+7ntBT5NTeJBjjqzCc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXBlnfIOrv0blmOnP7ATSaJdLiqdxsfGlzu5w8FaJjIXgRcxGDqs0G+MqBdDgTk+0
	 yJ8qG9m5JdG5DP0rX43wbl5yl55YlTamm4F56xu+er8vs6ojC5br6oFtwtOClNPDUz
	 yoyx7LBQ6Z8x/M/X/ws5Us76WJ3x5c3FzBK4+XTkZe7zFbCWlUec7yCU5XIbSVi+L5
	 LL4HHXLvzdcBxVZSuXCzkomtDgC9l1BOMX+3LjSSyC99CMNKizsH5WG75QPdCvkrPd
	 c7/CJqzugRRNNtuzqoft4UBtKvvN2fdoDPfoFj9Jy+v8CJDn6Uj9WcZeihIo9L9Lc+
	 U9ByHphjeuFjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 164/451] wifi: wilc1000: revert reset line logic flip
Date: Sun, 24 Mar 2024 19:07:20 -0400
Message-ID: <20240324231207.1351418-165-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index b0fc5e68feeca..5877e2c1fa0fc 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -191,11 +191,11 @@ static void wilc_wlan_power(struct wilc *wilc, bool on)
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


