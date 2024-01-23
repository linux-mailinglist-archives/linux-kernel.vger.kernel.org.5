Return-Path: <linux-kernel+bounces-35900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378C839873
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC547B22DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5928129A89;
	Tue, 23 Jan 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LKBshbAo"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CBA823B3;
	Tue, 23 Jan 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035633; cv=none; b=MmcKwXMaoU9nDNFHGfz4W2Wd7a6atkcjWMQ6TAEJDfKwoLdhnlrQtgFXrr82vsx2Ky3lGueuW3oP9b1mQjXHNVVG9te1ZgJi5RpDwAcCf+AU8rmDaDYtgxyr61fIsI2ix7NNFt85uBAq+ybipAYNxjyJxyEgf1AenyPfK+bS+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035633; c=relaxed/simple;
	bh=p96N34DQIp9iFKK4bMHk+DDoqnyUXSCL+rvjuPLimgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVodrtd+OtoY3+9AOsJ93yI/YppDkIAuwqeMZvTC9vZaIExJsREWnPoEx/PRn4zd/4bivLHIVjHDznpN/3jxnCVvFHfmizSFs9XS11dUAEa/1cjCw0xRufDiBfNZ7k374JgYrTZawoxRJqyfqPS9SULP8U/w8MrBItKM1EUFLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LKBshbAo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9120EC000B;
	Tue, 23 Jan 2024 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hzzlts4PGXFUuRWYcplGsnHuTe6WB3sA9fR+Y6Zs2Sk=;
	b=LKBshbAo11cOuZuIPLSZE4b0MvEIZl73uJXWr1LvAfV6Zt89UdGgHgceqBeSEf2VNPsH17
	hufmYUC7IQoR5a8cXnT+t5AxQEMybWOnR6QG2Q5OdhZUZDCjoP4KjXc5UEOj8i5VSZyst1
	kdKS5JK08Oq0Lz/NclDCsAUYphlvn0SAkS4PzmPSQlHHlR9j9I7zoWr4rWrIuwpZx7DXmD
	tEFd9HAifMtXFUK30eVFahx0hZwKI4UiRM4pUQPhuTV6KvPo/N3zHBeG6lO+VpgdVjeeW+
	jrW6R7u0bbsC6UAmLB4oQWTj2v6v+s/lMP5g35vYevGBS2brx+ylgRkOPBpqaw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Jan 2024 19:46:47 +0100
Subject: [PATCH v3 02/17] clk: fixed-factor: add fwname-based constructor
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240123-mbly-clk-v3-2-392b010b8281@bootlin.com>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
In-Reply-To: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
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
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add four functions to register clk_hw based on the fw_name field in
clk_parent_data, ie the value in the DT property `clock-names`.

There are variants for devm or not and passing an accuracy or not
passing one:

 - clk_hw_register_fixed_factor_fwname
 - clk_hw_register_fixed_factor_with_accuracy_fwname
 - devm_clk_hw_register_fixed_factor_fwname
 - devm_clk_hw_register_fixed_factor_with_accuracy_fwname

The `struct clk_parent_data` init is extracted from
__clk_hw_register_fixed_factor to each calling function. It is required
to allow each function to pass whatever field they want, not only index.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/clk-fixed-factor.c | 85 +++++++++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h   | 14 +++++++
 2 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index bc2644a9bd7d..fe0500a1af3e 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -91,13 +91,12 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
 static struct clk_hw *
 __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 		const char *name, const char *parent_name,
-		const struct clk_hw *parent_hw, int index,
+		const struct clk_hw *parent_hw, const struct clk_parent_data *pdata,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		unsigned long acc, unsigned int fixflags, bool devm)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init = { };
-	struct clk_parent_data pdata = { .index = index };
 	struct clk_hw *hw;
 	int ret;
 
@@ -128,7 +127,7 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	else if (parent_hw)
 		init.parent_hws = &parent_hw;
 	else
-		init.parent_data = &pdata;
+		init.parent_data = pdata;
 	init.num_parents = 1;
 
 	hw = &fix->hw;
@@ -165,7 +164,9 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, index,
+	const struct clk_parent_data pdata = { .index = index };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, &pdata,
 					      flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
@@ -187,8 +188,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
+	const struct clk_parent_data pdata = { .index = -1 };
+
 	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
-					      -1, flags, mult, div, 0, 0, true);
+					      &pdata, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
 
@@ -196,9 +199,10 @@ struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
-					      parent_hw, -1, flags, mult, div,
-					      0, 0, false);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+					      &pdata, flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
 
@@ -206,11 +210,37 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-					      flags, mult, div, 0, 0, false);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+					      &pdata, flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
+struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, 0, 0, false);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_fwname);
+
+struct clk_hw *clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div,
+		unsigned long acc)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, acc,
+			CLK_FIXED_FACTOR_FIXED_ACCURACY, false);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_with_accuracy_fwname);
+
 struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
@@ -253,16 +283,43 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
-			flags, mult, div, 0, 0, true);
+	const struct clk_parent_data pdata = { .index = -1 };
+
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+			&pdata, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
+struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, 0, 0, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_fwname);
+
+struct clk_hw *devm_clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div,
+		unsigned long acc)
+{
+	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
+
+	return __clk_hw_register_fixed_factor(dev, np, name, NULL, NULL,
+			&pdata, flags, mult, div, acc,
+			CLK_FIXED_FACTOR_FIXED_ACCURACY, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_with_accuracy_fwname);
+
 #ifdef CONFIG_OF
 static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk_hw *hw;
 	const char *clk_name = node->name;
+	const struct clk_parent_data pdata = { .index = 0 };
 	u32 div, mult;
 	int ret;
 
@@ -280,8 +337,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
-					    0, mult, div, 0, 0, false);
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL,
+					    &pdata, 0, mult, div, 0, 0, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7ddc952c8c67..4a537260f655 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1116,10 +1116,24 @@ void clk_unregister_fixed_factor(struct clk *clk);
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div);
+struct clk_hw *clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div,
+		unsigned long acc);
 void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
 struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
+struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div);
+struct clk_hw *devm_clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
+		struct device_node *np, const char *name, const char *fw_name,
+		unsigned long flags, unsigned int mult, unsigned int div,
+		unsigned long acc);
 struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div);

-- 
2.43.0


