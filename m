Return-Path: <linux-kernel+bounces-63797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B82853488
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255DC1F24811
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE35DF2F;
	Tue, 13 Feb 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kfaq/68N"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25045D902;
	Tue, 13 Feb 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837888; cv=none; b=f4TYqgQfFRuHcwvoFnEssnJ6jzpOmCQBj9M5qGovxCowOdgI3i8I5HlNlaF0BrddMd5bFzXySqFJRnR7os8Ox9WuDE53DTU8+FH6TYNG2bHyTYYEs5OH6ulrR3CVc2Z1zK6qGIYTV3/e2ouANOW8kLW+2r5FKc4s66egxPuQSA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837888; c=relaxed/simple;
	bh=ZRse6JczO8c8briiSuR06UnfYpScvqAmNKuKcNSxv4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s+huxKBTuACenrk7I5H9LRQkclTGti4Kn72BePFoJ9jX92c4IINTp1hOO0S4RADMbnh72S7UaRidWAcqQkOU2mQH8bIq32ThdIGe5KwrZYWK3/pMm9WGJtqidqs83jF0di/rKtnpHg6VufadyI9+2aI6kP4y7nLy7qZJsJT7jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kfaq/68N; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C49012000B;
	Tue, 13 Feb 2024 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707837877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=52cY2LUgFu15OCe72LM2FQu+S39du9WmCDQ8io2kZ8M=;
	b=kfaq/68NzMwiXUkSTseCvfYIiL4b4bIu5M5IexBkVGXzeSEmz1ghDU6VPuKXiseIpxTfgm
	OX6X86yQEKg3JgHyYBq5oDJ4OzDJM21V6yGD4BUOdbgbqSUHilpQAr/kgPe/uQzcXkmfMW
	TWllHo+DBBJjAIskfwiu6GvrKkigwvYgeiBvPIsEijh2zu9NsyvORI/AAzZT/XG/iA6PVE
	vXmzpmaPhgYjsUm7g7bqNz2syNx0S9Go4hlOJP6I+qL+iRR8NzQiNF1+grwWirAvm0+rxj
	L/4iU5xiIcVO73t9ELMpD6XOGyZTzaH9pRnWZyUrGIkckJNM5+Bva5gD/vqg7g==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 13 Feb 2024 16:22:44 +0100
Subject: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEOJy2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0NL3fLMnOR4QwMDg/ii1OLUkviczLxUXWNLYyNzg7RkE3OTVCWg1oK
 i1LTMCrCx0UpBbs5KsbW1AK54SQtrAAAA
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

When using a wilc1000 chip over a spi bus, users can optionally define a
reset gpio and a chip enable gpio. The reset line of wilc1000 is active
low, so to hold the chip in reset, a low (physical) value must be applied.

The corresponding device tree binding documentation was introduced by
commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
properties") and correctly indicates that the reset line is an active-low
signal. However, the corresponding driver part, brought by commit
ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver"), is
misusing the gpiod APIs and apply an inverted logic when powering up/down
the chip (for example, setting the reset line to a logic "1" during power
up, which in fact asserts the reset line when device tree describes the
reset line as GPIO_ACTIVE_LOW). As a consequence, any platform currently
using the driver in SPI mode must use a faulty reset line description in
device tree, or else chip will be maintained in reset and will not even
allow to bring up the chip.

Fix reset line usage by inverting back the gpiod APIs usage, setting the
reset line to the logic value "0" when powering the chip, and the logic
value "1" when powering off the chip.

Fixes: ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
This issue was detected because I struggled a bit to setup a WILC-over-SPI
setup, and eventually realized that it was due to chip being hold in reset.

This patch, if accepted, will force any WILC-over-SPI user to update its
device tree description: any platform currently working correctly in this
setup likely have a wrong GPIO_ACTIVE_HIGH used on the reset line device
tree description, contrary to what the documentation says. I am not sure
whether this is tolerable ? If not, what would be the proper way to fix
this ? Make the driver manually parse this flag and somehow make it able
to deal with both versions (so basically: ignoring the setting) ? Just live
with it, and possibly document the issue somewhere ?
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index c92ee4b73a74..30eed2ea523d 100644
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

---
base-commit: 246a8c611ace197f43ecc6ea4936c6ca363b8aaa
change-id: 20240119-wilc_1000_reset_line-393270fc474e

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


