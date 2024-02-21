Return-Path: <linux-kernel+bounces-75268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C485E58C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1F32856D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA285650;
	Wed, 21 Feb 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ChqVUceC"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E37FBD5;
	Wed, 21 Feb 2024 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539737; cv=none; b=GwEhAvcUF2ggrpLBIYUtd4vtHNnbiXjR/ewYenRlth8aZXKJ9AHeZF7Vr7g0iVZ5sUz0nuPyBtBUFhsoZvH7MNWmrAEN6B1wToL6vmdJeBI1OA1iWxjMLOHm4AAbudO1lCWuYZPfp1noX4wCIdO2uQkXs/8lphGMRqWmhlWG32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539737; c=relaxed/simple;
	bh=RFY7ut+rYoNyROemcFQ4SPLXjLR+Hh3fj3dk+W3dUTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIrbOV1hE60lf79rP9jgheZCVRYpAnSfb1QvjvBLEyIBnH9TVGjz/c02eJyFU7URFKAXZE/qo6wVHoPAGuTSoNsn4wZtCtFo5sVCXm6zgZ2x0y/epK9K6A6QqgllZNC6d0ncANFHhEbIuhIJ9p6oM4vtiJgRvADAk6E6bInjcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ChqVUceC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CF8B1C000B;
	Wed, 21 Feb 2024 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4q8B4FHnqm+Q9SZFv8e202u5pyLWu9j+3pZ0RNxIqVE=;
	b=ChqVUceCPkJTlZw8xSx2cVMM27qR9bmOYfIwNpzLYx/+AogIhe+3hXEJbS0j4sKsZbHHlp
	bcq8/zQVK7/akstNq074hnOEjBW85+8feh0zJHPWCMIAWetYICRvltgMW5ciHXx8gk9/Uh
	c6g7zNLsLJ/T2OLV26sV31PkGBTKWGqaP77eTPmNgd4kiMWKZanjJe1RfyT9+c5+02LUmA
	sr0LCfMZEcr8viAkmjKttUS74svJcyCLXNfc9F6WJlCvw7LEBIut2YbdZRMG7CAfZRPeIw
	eousLVtd0Mp6jWKlAq5kZYB52z2LqUb9Vf6KIr4c+D2fahK12rMFBGP5t2wExQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 21 Feb 2024 19:22:09 +0100
Subject: [PATCH v7 01/14] clk: fixed-factor: add optional accuracy support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-mbly-clk-v7-1-31d4ce3630c3@bootlin.com>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
In-Reply-To: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Fixed factor clock reports the parent clock accuracy. Add flags and acc
fields to `struct clk_fixed_factor` to support setting a fixed
accuracy. The default if no flag is set is not changed: use the parent
clock accuracy.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/clk-fixed-factor.c | 28 +++++++++++++++++++++-------
 include/linux/clk-provider.h   | 12 +++++++++++-
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index b3e66202b942..bc2644a9bd7d 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -57,10 +57,22 @@ static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static unsigned long clk_factor_recalc_accuracy(struct clk_hw *hw,
+						unsigned long parent_accuracy)
+{
+	struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
+
+	if (fix->flags & CLK_FIXED_FACTOR_FIXED_ACCURACY)
+		return fix->acc;
+
+	return parent_accuracy;
+}
+
 const struct clk_ops clk_fixed_factor_ops = {
 	.round_rate = clk_factor_round_rate,
 	.set_rate = clk_factor_set_rate,
 	.recalc_rate = clk_factor_recalc_rate,
+	.recalc_accuracy = clk_factor_recalc_accuracy,
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
@@ -81,7 +93,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 		const char *name, const char *parent_name,
 		const struct clk_hw *parent_hw, int index,
 		unsigned long flags, unsigned int mult, unsigned int div,
-		bool devm)
+		unsigned long acc, unsigned int fixflags, bool devm)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init = { };
@@ -105,6 +117,8 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	fix->mult = mult;
 	fix->div = div;
 	fix->hw.init = &init;
+	fix->acc = acc;
+	fix->flags = fixflags;
 
 	init.name = name;
 	init.ops = &clk_fixed_factor_ops;
@@ -152,7 +166,7 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		unsigned int mult, unsigned int div)
 {
 	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, index,
-					      flags, mult, div, true);
+					      flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
 
@@ -174,7 +188,7 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
-					      -1, flags, mult, div, true);
+					      -1, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
 
@@ -184,7 +198,7 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 {
 	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
 					      parent_hw, -1, flags, mult, div,
-					      false);
+					      0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
 
@@ -193,7 +207,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		unsigned int mult, unsigned int div)
 {
 	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-					      flags, mult, div, false);
+					      flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
@@ -240,7 +254,7 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		unsigned int mult, unsigned int div)
 {
 	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-			flags, mult, div, true);
+			flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
@@ -267,7 +281,7 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
-					    0, mult, div, false);
+					    0, mult, div, 0, 0, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1293c38ddb7f..7ddc952c8c67 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1084,18 +1084,28 @@ void of_fixed_factor_clk_setup(struct device_node *node);
  * @hw:		handle between common and hardware-specific interfaces
  * @mult:	multiplier
  * @div:	divider
+ * @acc:	fixed accuracy in ppb
+ * @flags:	behavior modifying flags
  *
  * Clock with a fixed multiplier and divider. The output frequency is the
  * parent clock rate divided by div and multiplied by mult.
- * Implements .recalc_rate, .set_rate and .round_rate
+ * Implements .recalc_rate, .set_rate, .round_rate and .recalc_accuracy
+ *
+ * Flags:
+ * * CLK_FIXED_FACTOR_FIXED_ACCURACY - Use the value in @acc instead of the
+ *                                     parent clk accuracy.
  */
 
 struct clk_fixed_factor {
 	struct clk_hw	hw;
 	unsigned int	mult;
 	unsigned int	div;
+	unsigned long	acc;
+	unsigned int	flags;
 };
 
+#define CLK_FIXED_FACTOR_FIXED_ACCURACY	BIT(0)
+
 #define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
 
 extern const struct clk_ops clk_fixed_factor_ops;

-- 
2.43.2


