Return-Path: <linux-kernel+bounces-113117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20630888198
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43C8B232C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055AA15AADF;
	Sun, 24 Mar 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnD09Lxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB015AACA;
	Sun, 24 Mar 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319925; cv=none; b=Rv8qJDF0vpKepTV1NHMFkjqizE25LcxcgLB0oYQ/WD+0jsaKg6x+4gik7v0uIPgeDMXDOm7fomhWV5UK8KoSNbFTyQcUXGnZrV4VB9U3N0dC+SCE7E5C7Tmp7Ropc5C7HVD0UtH3O3OSKQutY3Xk3IVa6EyPvEEMeT/vk3nGW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319925; c=relaxed/simple;
	bh=hbKIBNSWUPiHR4rMABXrgLXVEZf8rqQ5ZcXfkHHMod8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DG0iE8bQxhVmnBx1muL7vFxCgQ575PpO7r2SVHm99S4R2Fem58+wW0ql+Yvxc1RI1ZMsJcxKxf3Izp/PsgT6NCMl1ooMYvSOZMLhEQ6IHVzZwfAxOWinFSwQIqUMdSxCfxJERCFaYSvUfKRePoe2LaUd3nGtD2WII10Ed+EqMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnD09Lxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3318DC433F1;
	Sun, 24 Mar 2024 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319925;
	bh=hbKIBNSWUPiHR4rMABXrgLXVEZf8rqQ5ZcXfkHHMod8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnD09LxqSknO0ys30zh+0VeL/hf8tlMwPONH9qCgJqsGh4z4Z80fbN2oMdnzyl2EY
	 jcYaV8uZ+OMiUT9SX86MJszbzlfcCpgPSlTkg2SGGD4NVOdYUmYlf9xBIryHjGo4UK
	 8HaJfu6c5bANI12rOTLvGdjEZdtyrSWzK2s34HOhZlH540sB7BPjYFo9LPmqZ2qxz+
	 ZO43+B2LXO0n132hPzVGG6Asd9Qzgt5P9T3IIXWK+bpGPoN+o/9eHDI+q+auMwefoC
	 jGPqk6AdrB4bK+hd/EA7+FDsEW4TEju8+fZzdwV44pSrs/U2rNiGxPNuDWCq3gC9Uo
	 TrBCW9arBLBOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 230/715] wifi: wilc1000: revert reset line logic flip
Date: Sun, 24 Mar 2024 18:26:49 -0400
Message-ID: <20240324223455.1342824-231-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 1d8b241ce43ca..6a82b6ca2769e 100644
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


