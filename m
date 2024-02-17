Return-Path: <linux-kernel+bounces-69871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B8F858FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F467281C68
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE67AE4E;
	Sat, 17 Feb 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jkma2Nhz"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709522094;
	Sat, 17 Feb 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708176294; cv=none; b=eX+ixfcgqmF/DPE3RXBqKw7fI4nMHvigkRXhy3tZmvFoU8S6a86uOUk2PzG5u5kK7CCne0jMmjUNZJduulSKDnaaSuagrMnrxJqRUIaIbzaNA1I5dM2eDQd6uTM8mJY4pmULFfFx+/uD9Upa0x9jQ5E8U85UPis4CCbd6iVLeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708176294; c=relaxed/simple;
	bh=isBp3wCJWjacai14z29P5KSp+Y5zlyt2wA75/ZkVWbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rWWga5PCqjnQeU07DfQi+ZQ5TPEWbTWRIfjEey+ut/PqwzhOftxQILdXJx3O1ah7YBmDePahObpWv1V/n9aTknciHGPvA+OUX0rUjygcEO5H/SpL4kLeJs1M9xCPqYv3pVguHUtN70ZO3s9yXYg2d3IiPHcZzlZhMCs7vSL1Dkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jkma2Nhz; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB7221C0006;
	Sat, 17 Feb 2024 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708176289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9E0Vj/D0tS+cRSQY32RPNCGqo1WJBFZbJL/1pXftLwM=;
	b=Jkma2NhzcBHhs/HC7IzunPcSIVJQzpXUidSAWWQ4iXGxAoz1RSDVaRuXe4L1VelN0l8MgN
	MA5FyxBS+kO1pONki5oLFnyS60iXHAAWq+jS+M83w5F53RQPv8wuCNLqmdRH2fClbzKiHH
	2/SZRl6DgorTKGgh9+gj0PKA9Jjzrn42hhQnT5HnKyI1kVLxn8Sgc/HsGpYpbeWYWA3/LY
	J9AM26ifhtYZLjldCjrf3bsFAvK2CjHNMi6RZ+hQ4cFvJ2HClqw3ExmL7d00KROygSrmyi
	J/vt3OzD3UyaYhc8sbJKlXDZs7rEOKnlkncHtXBHGnkvbs53WVpJBVVu4+H5RQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Sat, 17 Feb 2024 14:22:41 +0100
Subject: [PATCH v2] wifi: wilc1000: revert reset line logic flip
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240217-wilc_1000_reset_line-v2-1-b216f433d7d5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACCz0GUC/22NwQqDMBBEf0X23JTdjSD21P8oIhrXumBNSURbx
 H9vaq89vhnmzQZRgkqES7ZBkEWj+ikBnzJwQzPdxWiXGBg5R6LSrDq6mhCxDhJlrkedxNjScoG
 9y4tcIE2fQXp9HdpblXjQOPvwPl4W+qY/IZP9L1zIkBGkruGWbS/dtfV+TtXZ+QdU+75/AJi1V
 +W6AAAA
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

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
---
This issue was detected because I struggled a bit to setup a WILC-over-SPI
setup, and eventually realized that it was due to chip being hold in reset.

This patch may break any downstream user having a working wilc-over-spi
setup (which then relies on a faulty device tree description). Discussions
about this possible breakage (see v1 in link below) led to a consensus in
favor of this patch.
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com
- Fix description by mentioning the real commit at the origin of the issue
- Make Fixes tag point to relevant commit
- Gather Acked-By from C. Dooley and A. Singh
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index 3c4451535c8a..61c3572ce321 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -194,11 +194,11 @@ static void wilc_wlan_power(struct wilc *wilc, bool on)
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
base-commit: 071235a89d35092c59574bf7aae3234649c97d12
change-id: 20240119-wilc_1000_reset_line-393270fc474e

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


