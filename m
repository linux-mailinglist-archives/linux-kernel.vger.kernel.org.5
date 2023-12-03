Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEE802869
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjLCW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjLCW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:29:13 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200AE3;
        Sun,  3 Dec 2023 14:29:19 -0800 (PST)
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r9uxa-006zEF-B3; Sun, 03 Dec 2023 23:29:10 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r9uxZ-001RYl-2b;
        Sun, 03 Dec 2023 23:29:09 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v3 2/6] twl-core: add power off implementation for twl603x
Date:   Sun,  3 Dec 2023 23:28:59 +0100
Message-Id: <20231203222903.343711-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231203222903.343711-1-andreas@kemnade.info>
References: <20231203222903.343711-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system-power-controller property is there, enable power off.
Implementation is based on a Linux v3.0 vendor kernel.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl-core.c  | 28 ++++++++++++++++++++++++++++
 include/linux/mfd/twl.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 6e384a79e3418..f3982d18008d1 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -124,6 +124,11 @@
 #define TWL6030_BASEADD_RSV		0x0000
 #define TWL6030_BASEADD_ZERO		0x0000
 
+/* some fields in TWL6030_PHOENIX_DEV_ON */
+#define TWL6030_APP_DEVOFF		BIT(0)
+#define TWL6030_CON_DEVOFF		BIT(1)
+#define TWL6030_MOD_DEVOFF		BIT(2)
+
 /* Few power values */
 #define R_CFG_BOOT			0x05
 
@@ -687,6 +692,20 @@ static void twl_remove(struct i2c_client *client)
 	twl_priv->ready = false;
 }
 
+static void twl6030_power_off(void)
+{
+	int err;
+	u8 val;
+
+	err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val, TWL6030_PHOENIX_DEV_ON);
+	if (err)
+		return;
+
+	val |= TWL6030_APP_DEVOFF | TWL6030_CON_DEVOFF | TWL6030_MOD_DEVOFF;
+	twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val, TWL6030_PHOENIX_DEV_ON);
+}
+
+
 static struct of_dev_auxdata twl_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
 	{ /* sentinel */ },
@@ -852,6 +871,15 @@ twl_probe(struct i2c_client *client)
 			goto free;
 	}
 
+	if (twl_class_is_6030()) {
+		if (of_device_is_system_power_controller(node)) {
+			if (!pm_power_off)
+				pm_power_off = twl6030_power_off;
+			else
+				dev_warn(&client->dev, "Poweroff callback already assigned\n");
+		}
+	}
+
 	status = of_platform_populate(node, NULL, twl_auxdata_lookup,
 				      &client->dev);
 
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index c062d91a67d92..85dc406173dba 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -461,6 +461,7 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)
 
 #define TWL4030_PM_MASTER_GLOBAL_TST		0xb6
 
+#define TWL6030_PHOENIX_DEV_ON                  0x06
 /*----------------------------------------------------------------------*/
 
 /* Power bus message definitions */
-- 
2.39.2

