Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAE7C7E84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJMHXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJMHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:23:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19035BC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:23:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4066241289bso18843175e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697181825; x=1697786625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb3gYagB6dDOUEqTcgUJ+Jm7aEOybfjvWpE6CZqOl1I=;
        b=bwuMD1bAxLcmK+He1bJrevM0UBZt7CQ/8n7HyEI9S+H9+Gu9kWWcQSo8Z+X5jegCMI
         pBKe2zjA1X8R4EW0zABzNK6hLgBFwmVSHk9VzRJHSdcfC8MJo4fhDRny1r4k3SHeyl+F
         px5QDDLubNQ/sqfQeGcxnqtg/KSMS2ud90DTztGMbKdT1WLPGQiLLXJmMOvdTnq02El4
         7hyWbC5dSuru3LN7FNTshcsTp1/YUz0NNOTZSuZa+n6zB4OaBzQpKqxXqrXO1Dr0QEF5
         BahptbaKltsHcIjDWI8vb6k2vDqW9/HVpEG5x4GXuzLXsrvKsobsCYxyFCigwazIImXl
         wuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697181825; x=1697786625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb3gYagB6dDOUEqTcgUJ+Jm7aEOybfjvWpE6CZqOl1I=;
        b=DpnQet1qBsdJ8RuQJh+0YR+sFEm79hGYP23xMRw4zmWj2JOxOCUWUV+aRYFnOkekTS
         EmWoLbWvOSjd0n4bjfyE5paVNTZWVRVGPv5zk8/wkOwIhIwsa5nNE6PNWoHxtYLulBEA
         dzuHu/VYMIN7rwv/EuUpJaxURjG5RhSFM90SiPJnAFcD/pQQH7FZdQ7OtQBlw0rku/Cp
         SA5oITl4oaZuh577BWuW1qx8LKs26oJ8K3VFkckQ8j253OL1wDXQ5wpGSRfBMkR2Y+Bw
         h0JbxT1pWCmGow0QZjyDXpCm1/+L7pCxWDgOpQzjKmBCWLfua3ZHkKnESHwAd7ZfHRfg
         ignw==
X-Gm-Message-State: AOJu0YzhXBWPIGha77K8+IfzwoH9qSCHy48/iFcmnseAiDu2I6KHhyym
        RSFp3OItc1viDGNe4BZT5zJUZ+lsebhcrzsNk6Q=
X-Google-Smtp-Source: AGHT+IF+RKXGEq5EHir8wsGLD0lAZnjB+wgB691VzoDXLWE0fRX7rOlEhMnxP5TPZpfSHV3Q0je+7A==
X-Received: by 2002:a05:600c:21ce:b0:407:68a3:6b5d with SMTP id x14-20020a05600c21ce00b0040768a36b5dmr3284206wmj.23.1697181825417;
        Fri, 13 Oct 2023 00:23:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id y4-20020a1c4b04000000b004075d5664basm1775581wma.8.2023.10.13.00.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:23:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] hte: tegra194: don't access struct gpio_chip
Date:   Fri, 13 Oct 2023 09:23:40 +0200
Message-Id: <20231013072340.16411-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Dipen,

Can you retest this patch now rebased on top of current GPIO for-next?

v1 -> v2:
- rebase on top of current gpio/for-next

 drivers/hte/hte-tegra194.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 6fe6897047ac..341a134cb7d0 100644
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
 
@@ -418,7 +418,7 @@ static int tegra_hte_line_xlate(struct hte_chip *gc,
 	 * HTE/GTE namespace.
 	 */
 	if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && !args) {
-		line_id = desc->attr.line_id - gs->c->base;
+		line_id = desc->attr.line_id - gpio_device_get_base(gs->gdev);
 		map = gs->prov_data->map;
 		map_sz = gs->prov_data->map_sz;
 	} else if (gs->prov_data->type == HTE_TEGRA_TYPE_GPIO && args) {
@@ -645,7 +645,7 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 	if (!hte_dev || (hte_dev->prov_data->type != HTE_TEGRA_TYPE_GPIO))
 		return false;
 
-	return hte_dev->c == gpiod_to_chip(hdesc->attr.line_data);
+	return hte_dev->gdev == gpiod_to_gpio_device(hdesc->attr.line_data);
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
@@ -673,14 +673,11 @@ static void tegra_gte_disable(void *data)
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
@@ -760,8 +757,8 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 		if (of_device_is_compatible(dev->of_node,
 					    "nvidia,tegra194-gte-aon")) {
-			hte_dev->c = gpiochip_find("tegra194-gpio-aon",
-						tegra_get_gpiochip_from_name);
+			hte_dev->gdev =
+				gpio_device_find_by_label("tegra194-gpio-aon");
 		} else {
 			gpio_ctrl = of_parse_phandle(dev->of_node,
 						     "nvidia,gpio-controller",
@@ -772,14 +769,19 @@ static int tegra_hte_probe(struct platform_device *pdev)
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
2.39.2

