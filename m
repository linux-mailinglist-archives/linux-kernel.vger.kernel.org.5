Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28D7C0035
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjJJPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjJJPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:17:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74445CC;
        Tue, 10 Oct 2023 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951036; x=1728487036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6DdkRg1hXfc8CWke14GcuC2dyWewQd6DP8vUh4t5nE=;
  b=BjK4RXR46V6o6olOWvUJwOZnH45AEOyFvOd62RI6FvzOBpCaLkttngOz
   WPLugMpgD784x4sJSomLJzifRipYdFO7VQqhkw+wF+IwAIIqgbN+nW6JL
   WZORk5PrxR9D6eXL9hS/kcmLEu+4gTMyOnhB+PIAXZPlStf0x71gi5W2f
   p5AXfWIFPJPUqKQrlUv9eGM3O8Tua3sBP+VwRkN+lvga5IaUn0YGa11Ah
   ijM3O+UtmfRul9Pr+Axs+SG/wCldRhilFzufIND+hTBlvPg3wZ6wNehal
   TA3eC+oq7hCVt1vZniKdHyEy76/Etr1Mecq/a39c5KTCkvAFHAyxpBuCa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363771600"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="363771600"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823812777"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="823812777"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 08:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F9666CB; Tue, 10 Oct 2023 18:17:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 2/4] hte: tegra194: don't access struct gpio_chip
Date:   Tue, 10 Oct 2023 18:17:07 +0300
Message-Id: <20231010151709.4104747-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Using struct gpio_chip is not safe as it will disappear if the
underlying driver is unbound for any reason. Switch to using reference
counted struct gpio_device and its dedicated accessors.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
[andy: used gpio_device_find_by_fwnode()]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte-tegra194.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 9fd3c00ff695..339ff5921ec8 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -132,7 +132,7 @@ struct tegra_hte_soc {
 	const struct tegra_hte_data *prov_data;
 	struct tegra_hte_line_data *line_data;
 	struct hte_chip *chip;
-	struct gpio_chip *c;
+	struct gpio_device *gdev;
 	void __iomem *regs;
 };
 
@@ -421,7 +421,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
 	 * HTE/GTE namespace.
 	 */
 	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
-		line_id = desc->attr.line_id - gs->c->base;
+		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
 		map = gs->prov_data->map;
 		map_sz = gs->prov_data->map_sz;
 	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
@@ -643,12 +643,15 @@ static irqreturn_t tegra_hte_isr(int irq, void *dev_id)
 static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 					  const struct hte_ts_desc *hdesc)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct tegra_hte_soc *hte_dev = chip->data;
 
 	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
 		return false;
 
-	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
+	gdev = gpiod_to_device(hdesc->attr.line_data);
+
+	return hte_dev->gdev == gdev;
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
@@ -676,14 +679,11 @@ static void tegra_gte_disable(void *data)
 	tegra_hte_writel(gs, HTE_TECTRL, 0);
 }
 
-static int tegra_get_gpiochip_from_name(struct gpio_chip *chip, void *data)
+static void tegra_hte_put_gpio_device(void *data)
 {
-	return !strcmp(chip->label, data);
-}
+	struct gpio_device *gdev = data;
 
-static int tegra_gpiochip_match(struct gpio_chip *chip, void *data)
-{
-	return chip->fwnode == of_node_to_fwnode(data);
+	gpio_device_put(gdev);
 }
 
 static int tegra_hte_probe(struct platform_device *pdev)
@@ -763,8 +763,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		if (of_device_is_compatible(dev->of_node,
 					    "nvidia,tegra194-gte-aon")) {
-			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-						tegra_get_gpiochip_from_name);
+			hte_dev->gdev =
+				gpio_device_find_by_label("tegra194-gpio-aon");
 		} else {
 			gpio_ctrl = of_parse_phandle(dev->of_node,
 						     "nvidia,gpio-controller",
@@ -775,14 +775,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
 				return -ENODEV;
 			}
 
-			hte_dev->c = gpiochip_find(gpio_ctrl,
-						   tegra_gpiochip_match);
+			hte_dev->gdev =
+				gpio_device_find_by_fwnode(of_fnode_handle(gpio_ctrl));
 			of_node_put(gpio_ctrl);
 		}
 
-		if (!hte_dev->c)
+		if (!hte_dev->gdev)
 			return dev_err_probe(dev, -EPROBE_DEFER,
 					     "wait for gpio controller\n");
+
+		ret = devm_add_action_or_reset(dev, tegra_hte_put_gpio_device,
+					       hte_dev->gdev);
+		if (ret)
+			return ret;
 	}
 
 	hte_dev->chip = gc;
-- 
2.40.0.1.gaa8946217a0b

