Return-Path: <linux-kernel+bounces-102663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B632E87B579
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85541C20E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A15E086;
	Wed, 13 Mar 2024 23:55:40 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B55D8E4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374139; cv=none; b=o+THMhSSShI79D2xtycKQv6/DzWCRllyh3NSJ54ZiIA55+Q5UFgMZPo+jxRNhCzNkFWpHeLWq982pspxEZAvgQUnt8RwW3698fHiYCeT3dm9uWLWbp7N5EcyZxYucDbc5a4UHeFiOpK8trDn/l0/NGen4hzn1lnNUbnjcIFMvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374139; c=relaxed/simple;
	bh=k+1YhdyA6bA8FnqCXxwU7KWqjxoU2scZqrkAAb7HRG4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjyacF/HbXj7Qc55DQ8GzprVCAp+qFbKWcwzMzeaEXoYUav2dWKd+KKJ/mUgR2L44JZ5zkl9fIw70f3e62POtESRZxg1C2jkMklTR4L/bnuBa0WCV8f7vtw4yYXJcMyEPb0Q0lwMtpqlGQSr/436EEPw9CYN83qkS1/M21jRtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 06688e94-e195-11ee-abf4-005056bdd08f;
	Thu, 14 Mar 2024 01:54:27 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/11] pinctrl: aw9523: Always try both ports in aw9523_gpio_set_multiple()
Date: Thu, 14 Mar 2024 01:52:06 +0200
Message-ID: <20240313235422.180075-4-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313235422.180075-1-andy.shevchenko@gmail.com>
References: <20240313235422.180075-1-andy.shevchenko@gmail.com>
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


