Return-Path: <linux-kernel+bounces-102666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12287B57D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16CD1F22F14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568371E480;
	Wed, 13 Mar 2024 23:55:41 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB65D908
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374140; cv=none; b=DB/UG/fPlOZnE2GN+cUhXUinR62ThAMoSr5gsMq8AAa9V+Cn1jJPk2PP0Lunw9Y+pqwnJ7c9j30J+jHITy37hStBqrLzqi94k+Zq+BP9I7Cz24vxj9/wdRczD72ScLbfb12+rbeACuNW4k08jU9Kil6mqc4nEuTKQIMks9NrnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374140; c=relaxed/simple;
	bh=A/6Rxz4Bmsq8vL9J8RxsvzpoTJK2t8DPLAAu7jQ7ezk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDLQ8tm1fbzunp1Hnrdok9rh6LxwJ4zIZFiEbunhH3GGmkhTmvmXqa3OUvtb7Zs7p7qFtm3HtxJE76+KvddAf0CTKOkYyGquXlR6gvNIYaMjrEwjMOsEdPh1ddDPELKlDCR3etylc4ke9jEml0IcxT3iF8Wxfz4slvFL5uOiN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 07bc019b-e195-11ee-b972-005056bdfda7;
	Thu, 14 Mar 2024 01:54:29 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/11] pinctrl: aw9523: Get rid of redundant ' & U8_MAX' pieces
Date: Thu, 14 Mar 2024 01:52:09 +0200
Message-ID: <20240313235422.180075-7-andy.shevchenko@gmail.com>
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

When the variable is declared as u8, no need to perform ' & U8_MAX'
as it's implied anyway.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 118896373844a..9e8e658f81404 100644
--- a/drivers/pinctrl/pinctrl-aw9523.c
+++ b/drivers/pinctrl/pinctrl-aw9523.c
@@ -603,7 +603,7 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 	mutex_lock(&awi->i2c_lock);
 
 	/* Port 0 (gpio 0-7) */
-	m = *mask & U8_MAX;
+	m = *mask;
 	if (m) {
 		ret = _aw9523_gpio_get_multiple(awi, 0, &state, m);
 		if (ret)
@@ -612,7 +612,7 @@ static int aw9523_gpio_get_multiple(struct gpio_chip *chip,
 	*bits = state;
 
 	/* Port 1 (gpio 8-15) */
-	m = (*mask >> 8) & U8_MAX;
+	m = *mask >> 8;
 	if (m) {
 		ret = _aw9523_gpio_get_multiple(awi, AW9523_PINS_PER_PORT,
 						&state, m);
@@ -635,20 +635,20 @@ static void aw9523_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned int reg;
 	int ret;
 
-	mask_lo = *mask & U8_MAX;
-	mask_hi = (*mask >> 8) & U8_MAX;
+	mask_lo = *mask;
+	mask_hi = *mask >> 8;
+	bits_lo = *bits;
+	bits_hi = *bits >> 8;
+
 	mutex_lock(&awi->i2c_lock);
 	if (mask_hi) {
 		reg = AW9523_REG_OUT_STATE(AW9523_PINS_PER_PORT);
-		bits_hi = (*bits >> 8) & U8_MAX;
-
 		ret = regmap_write_bits(awi->regmap, reg, mask_hi, bits_hi);
 		if (ret)
 			dev_warn(awi->dev, "Cannot write port1 out level\n");
 	}
 	if (mask_lo) {
 		reg = AW9523_REG_OUT_STATE(0);
-		bits_lo = *bits & U8_MAX;
 		ret = regmap_write_bits(awi->regmap, reg, mask_lo, bits_lo);
 		if (ret)
 			dev_warn(awi->dev, "Cannot write port0 out level\n");
-- 
2.44.0


