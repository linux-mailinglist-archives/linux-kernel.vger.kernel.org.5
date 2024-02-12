Return-Path: <linux-kernel+bounces-61731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D298515DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7ADB24BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7E13E477;
	Mon, 12 Feb 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fXcTEQsx"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81323D56F;
	Mon, 12 Feb 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745481; cv=none; b=OQuj733h6LqVcnb1JkBhcpiHDKUk1mz3K2xXt3iExAcR9seFgZ+DLxXgJKZVQaxgWr5TMyaOXFU2GsNmkS6iIrfQebDRyKBpJeIr+ueCvheV1jGo+q0jOTKW2ncF5TB/l+aTgZfXQf2M6PA65seugnLDnDK0uUcSUUXJ22+/Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745481; c=relaxed/simple;
	bh=p96N34DQIp9iFKK4bMHk+DDoqnyUXSCL+rvjuPLimgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dm04WdrOI5F9RMVPH0vezTrFSk3pt+uvBpakdNc2tlpmA53GOj2AZ45/E2TnpLPkUFvLCJ6v7UTbiz8aHyRzd/2oOn4yETzx9aVuVWN0DZqJvfi9W+gFc9weczVZEQFKb1VehG5y2NtDawS95pSAzWzSLjAt06l+hdRvgsN6NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fXcTEQsx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D5D8FF80E;
	Mon, 12 Feb 2024 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707745476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hzzlts4PGXFUuRWYcplGsnHuTe6WB3sA9fR+Y6Zs2Sk=;
	b=fXcTEQsxMaxf8lVMmX27YQgDauQSyrLPXbAa9V3fmmFGGTBd5Jpf25/Dye1EfsvJ4uglwQ
	QddJQiQ4Vt8Ik22rJXM4OHPPV4NBJHDyKR9tDmuT6pGrd5RXkRMtcwMQTFoAmL+OeW7dHf
	SwxjQ1D1b4Ge9kWtKE7NtnOg+GQu2RKHlffGX3MaoCOfdNjIeg8K/doqsTELhbasHoB8Y7
	YLJsf2aQceOcjeKrnacqZnHJfkAOGqjlDPbkkGKq3UP4oMR+XI/rRGOC1zvVAQJHmyLZyD
	ouJZieoQ7qDFPsyT8n9EPaw0oQbkUusLLBn027rDj4qNxHcmQcaGnQ6ckMVb8Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 12 Feb 2024 14:44:33 +0100
Subject: [PATCH v6 02/13] clk: fixed-factor: add fwname-based constructor
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-mbly-clk-v6-2-c46fa1f93839@bootlin.com>
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
In-Reply-To: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
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


