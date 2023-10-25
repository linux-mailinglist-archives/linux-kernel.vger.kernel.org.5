Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF277D6591
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjJYIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjJYIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:46:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F3D134
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:46:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWq-0002CE-9l; Wed, 25 Oct 2023 10:46:16 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-0048Wg-D5; Wed, 25 Oct 2023 10:46:15 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qvZWp-00CyT5-16;
        Wed, 25 Oct 2023 10:46:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 5/7] regulator: fixed: add support for under-voltage IRQ
Date:   Wed, 25 Oct 2023 10:46:12 +0200
Message-Id: <20231025084614.3092295-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025084614.3092295-1-o.rempel@pengutronix.de>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for under-voltage notification. This functionality
can be used on systems capable to detect under-voltage state and having
enough capacity to let the SoC do some emergency preparation.

This change enforce default policy to shutdown system as soon as
interrupt is triggered.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/fixed.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 55130efae9b8..cb93e5cdcfa9 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/reboot.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/fixed.h>
 #include <linux/gpio/consumer.h>
@@ -29,6 +30,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/clk.h>
 
+/* Default time in millisecond to wait for emergency shutdown */
+#define FV_DEF_EMERG_SHUTDWN_TMO	10
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
@@ -105,6 +108,49 @@ static int reg_is_enabled(struct regulator_dev *rdev)
 	return priv->enable_counter > 0;
 }
 
+static irqreturn_t reg_fixed_under_voltage_irq_handler(int irq, void *data)
+{
+	struct fixed_voltage_data *priv = data;
+	struct regulator_dev *rdev = priv->dev;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_UNDER_VOLTAGE,
+				      NULL);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * reg_fixed_get_irqs - Get and register the optional IRQ for fixed voltage
+ *                      regulator.
+ * @dev: Pointer to the device structure.
+ * @priv: Pointer to fixed_voltage_data structure containing private data.
+ *
+ * This function tries to get the IRQ from the device firmware node.
+ * If it's an optional IRQ and not found, it returns 0.
+ * Otherwise, it attempts to request the threaded IRQ.
+ *
+ * Return: 0 on success, or error code on failure.
+ */
+static int reg_fixed_get_irqs(struct device *dev,
+			      struct fixed_voltage_data *priv)
+{
+	int ret;
+
+	ret = fwnode_irq_get(dev_fwnode(dev), 0);
+	/* This is optional IRQ. If not found we will get -EINVAL */
+	if (ret == -EINVAL)
+		return 0;
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get IRQ\n");
+
+	ret = devm_request_threaded_irq(dev, ret, NULL,
+					reg_fixed_under_voltage_irq_handler,
+					IRQF_ONESHOT, "under-voltage", priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	return 0;
+}
 
 /**
  * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
@@ -294,6 +340,10 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "%s supplying %duV\n", drvdata->desc.name,
 		drvdata->desc.fixed_uV);
 
+	ret = reg_fixed_get_irqs(dev, drvdata);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.39.2

