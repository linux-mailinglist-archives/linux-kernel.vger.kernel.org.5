Return-Path: <linux-kernel+bounces-124415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823089173C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CD7287B72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27BF85922;
	Fri, 29 Mar 2024 10:56:52 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF926A8CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709812; cv=none; b=gafVGeUjH/TIBWyFwZZi2KYj6lSplE/UeCePu5sumVmm23J6g/cUtreQmxIILCcbtO/G+NwgvLgV2u1gVp3UXtOGWiXnMaESqoHMA7BxyW4ItZvg1JmMZzajhvKDW/f/Wmb2ok942yiTV+r4ciqjOcgj/YaFZ0veUPWCLW+Dl6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709812; c=relaxed/simple;
	bh=f4f/kh0PmFJ42uACJgiRQ6RY/91nQkYiihrMsW88gGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkUF5qkeIpiiLojuZ1siSXn9i3YC5NzxcXjC2ctEJ5chR1ZuxdaWShVSUKhOMzSTAEGvwS977JHZKfuy+SOJm/XhfWrYbi9XDi0mAQMPAiZwlw8G8KxCfk28bS9nhA3epoOp5wyQPHU3HCFMyJUD7hHpYify53885LoIg6cN3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 06bb802c-edbb-11ee-a9de-005056bdf889;
	Fri, 29 Mar 2024 12:56:42 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] pinctrl: aw9523: Get rid of redundant ' & U8_MAX' pieces
Date: Fri, 29 Mar 2024 12:55:20 +0200
Message-ID: <20240329105634.712457-7-andy.shevchenko@gmail.com>
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

When the variable is declared as u8, no need to perform ' & U8_MAX'
as it's implied anyway.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-aw9523.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-aw9523.c b/drivers/pinctrl/pinctrl-aw9523.c
index 0f3361fa9ed88..8c615adb3d578 100644
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


