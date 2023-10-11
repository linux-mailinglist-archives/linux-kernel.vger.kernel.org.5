Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE47C5E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376482AbjJKU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376378AbjJKU0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:26:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785290;
        Wed, 11 Oct 2023 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697056008; x=1728592008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8PEWN3Jey64dbzw0CESM+jaomdEbjI2kq05LEDXsXnw=;
  b=Md6+37kZL+YEc+wDJjrsD3yGI95vhyUeK7gvtOq+RCdup+NDZq93J9u/
   jWHikFi0XyK6HzCkVrlJd2M9LDADmslTGKe9fW8hqkkfhyF7bU5hT3qwu
   Uyeg0l1M8Brl9pNHQ4mGjmxEuOZomom07EDRuI+8/ArI0PQbT7KuXbFHG
   Iu613O1M+IoPIyxWuil4PCEzp24hbwbTkedGkRtDZLatbFKWFyMM6N0CR
   drzrOMq4ooizmpQrasBL77OafXFnTpKW6o73RteuOhTgTL1LNbBDwHXnJ
   t55maB1BqPlZ2/69OOlB9yf+9RqDSQiRRcR5PDV6SKaI7WLUoSVmTXnDn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="471015131"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="471015131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 13:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783393502"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783393502"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2023 13:26:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1C4B96CB; Wed, 11 Oct 2023 23:26:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 2/4] hte: tegra194: don't access struct gpio_chip
Date:   Wed, 11 Oct 2023 23:26:36 +0300
Message-Id: <20231011202638.372382-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
References: <20231011202638.372382-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Dipen Patel <dipenp@nvidia.com>
Link: https://lore.kernel.org/r/20231010151709.4104747-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hte/hte-tegra194.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 9fd3c00ff695..f6c2dbcd0aca 100644
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
+				gpio_device_find_by_fwnode(of_fwnode_handle(gpio_ctrl));
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

