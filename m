Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084527BC252
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjJFWot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjJFWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:44:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D6CF;
        Fri,  6 Oct 2023 15:44:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074E7C433C8;
        Fri,  6 Oct 2023 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632286;
        bh=TaVUWW2YTgz1B33ifPyvUZYuaUBkl9iBtWnuXF2mdhs=;
        h=From:To:Cc:Subject:Date:From;
        b=uRiT5kH4bdp40A3cDGW0oXog1gkh12AvzHEgfdNlavwYU2jRLTDQY0q5xYMi7g6MQ
         Jg+l16bcw++Efvwke6cJADUqw+Lym4Mt/yYQxzP9slQ/UY++kNy1OLspFRPg0u/NyW
         NSYAd+SwqD/aBp07cbwMjl6ClfLscYW6x3PPO/1UWyuduRtLYdpnaUDwrjwpJJ0j5n
         QpjyEg3jD33KsbM80Bd0YKDVGx0gQy9HzYjtieVwKeORANQGx1FVWE7i3dQMiQopUU
         pOpiOzW5M1w1hxpgQ3iS35GENwGhn8W8k3Ha+2dlvccUzjtyHctE2H9DMxNC5vgGLN
         5+E+XLDSBaKeA==
Received: (nullmailer pid 442980 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:39 -0500
Message-Id: <20231006224440.442864-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iio/adc/stm32-adc-core.c | 11 +++--------
 drivers/iio/adc/twl6030-gpadc.c  | 10 ++++------
 drivers/iio/dac/stm32-dac-core.c |  9 ++++-----
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index c19506b0aac8..616dd729666a 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -17,10 +17,11 @@
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -708,8 +709,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct stm32_adc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id;
-
 	struct resource *res;
 	u32 max_rate;
 	int ret;
@@ -722,11 +721,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, &priv->common);
 
-	of_id = of_match_device(dev->driver->of_match_table, dev);
-	if (!of_id)
-		return -ENODEV;
-
-	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
+	priv->cfg = device_get_match_data(dev);
 	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 224e9cb5e147..78bf55438b2c 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -16,9 +16,10 @@
  */
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
+#include <linux/property.h>
 #include <linux/mfd/twl.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -879,17 +880,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct twl6030_gpadc_data *gpadc;
 	const struct twl6030_gpadc_platform_data *pdata;
-	const struct of_device_id *match;
 	struct iio_dev *indio_dev;
 	int irq;
 	int ret;
 
-	match = of_match_device(of_twl6030_match_tbl, dev);
-	if (!match)
+	pdata = device_get_match_data(&pdev->dev);
+	if (!pdata)
 		return -EINVAL;
 
-	pdata = match->data;
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
 	if (!indio_dev)
 		return -ENOMEM;
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 15abe048729e..e150ac729154 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -9,9 +9,12 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
@@ -94,16 +97,12 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	struct reset_control *rst;
 	int ret;
 
-	if (!dev->of_node)
-		return -ENODEV;
-
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, &priv->common);
 
-	cfg = (const struct stm32_dac_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	cfg = device_get_match_data(dev);
 
 	mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmio))
-- 
2.40.1

