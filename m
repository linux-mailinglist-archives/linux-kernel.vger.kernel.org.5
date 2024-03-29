Return-Path: <linux-kernel+bounces-124411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C700891730
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBD11C212EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CC7E11C;
	Fri, 29 Mar 2024 10:56:49 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760476A8CF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709809; cv=none; b=D+NHwr3OinLWGPXr98b58xFKoLyq4cllW6gdJTyojKEypfvNSxFSLhWrFU0a2WEJtbV9Zcv+5yyJNhPHTg1jn9vR9ZVVrrknD8ZWpFdvSA2TxxzjaCtlqAjIWgwaMe+DvKTfIYHYV0l9bqeBHZeKPcjRS/gKmpxBzhp+FEDg/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709809; c=relaxed/simple;
	bh=k+1YhdyA6bA8FnqCXxwU7KWqjxoU2scZqrkAAb7HRG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eupVIsdUFvPlpYlue511o5Zjx05X8jsZeDLGvOIfY2VXIWIxlJaOpJcGecWiwlPJaMwHbUhlKJAW+QYeKoHV88elmghooQa6FhFyZ4JW9bXjM4D4dPSSAwbLJ1WpEwfTVkdhYp7xwikCsHyTEG5WHjli01JK1UPS2BNWJ/yl1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 04ffcd06-edbb-11ee-b972-005056bdfda7;
	Fri, 29 Mar 2024 12:56:39 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] pinctrl: aw9523: Always try both ports in aw9523_gpio_set_multiple()
Date: Fri, 29 Mar 2024 12:55:17 +0200
Message-ID: <20240329105634.712457-4-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329105634.712457-1-andy.shevchenko@gmail.com>
References: <20240329105634.712457-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ports are equivalent from the user's point of view. Don't limit
trying them both if writing to one fails.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 65d523697b731..d93640a02d1d3 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -653,7 +653,7 @@ static void aw9523_gpio_set_multiple(struct gpio_chip *chip,
 	struct aw9523 *awi = gpiochip_get_data(chip);
 	u8 mask_lo, mask_hi, bits_lo, bits_hi;
 	unsigned int reg;
-	int ret = 0;
+	int ret;
 
 	mask_lo = *mask & U8_MAX;
 	mask_hi = (*mask >> 8) & U8_MAX;
@@ -663,10 +663,8 @@ static void aw9523_gpio_set_multiple(struct gpio_chip *chip,
 		bits_hi = (*bits >> 8) & U8_MAX;
 
 		ret = regmap_write_bits(awi->regmap, reg, mask_hi, bits_hi);
-		if (ret) {
+		if (ret)
 			dev_warn(awi->dev, "Cannot write port1 out level\n");
-			goto out;
-		}
 	}
 	if (mask_lo) {
 		reg = AW9523_REG_OUT_STATE(0);
@@ -675,7 +673,6 @@ static void aw9523_gpio_set_multiple(struct gpio_chip *chip,
 		if (ret)
 			dev_warn(awi->dev, "Cannot write port0 out level\n");
 	}
-out:
 	mutex_unlock(&awi->i2c_lock);
 }
 
-- 
2.44.0


