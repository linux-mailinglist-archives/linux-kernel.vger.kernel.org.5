Return-Path: <linux-kernel+bounces-151168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9278AAA34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8970D1F21698
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E46518F;
	Fri, 19 Apr 2024 08:31:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0716FB0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515490; cv=none; b=R9R8spSPFXPaNX/bffhjjCC+Akqj7/Zj2DQSBXYO3JZ89iEsc+JGIna6DK3TcZLh0nq233FT9cesmg2TmJQtf69PPoiqRHWP5ZFsoNJLsGMWre0pb9NWiWVdvMkALDOxTL9HiP89GHV3Q2pYCy+Q3eFYfAbASzfsdKDiPUO400o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515490; c=relaxed/simple;
	bh=qxoD5g4buTdC/BH/OQ7LEfEn3adg8fa4/j3TGO7/xjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iF4JWjumpBO4hhcDwIqDK46oQ1egYAWxWedSgnC+IZj8y5w7Y/xChkI3bZooRWZZMi0NBCNEXLWVhgOHNJOoKenlGFMfqVMbfprrd16B2xtE8rad8QvsocQY4of+rQUKTxEniZU+Jq8FJ/I3fwWG7WsmctgWZPJdPlazPbYqW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeQ-0006i8-Rf; Fri, 19 Apr 2024 10:31:18 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeQ-00D7hB-FI; Fri, 19 Apr 2024 10:31:18 +0200
Received: from has by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeQ-00DyIN-15;
	Fri, 19 Apr 2024 10:31:18 +0200
From: Holger Assmann <h.assmann@pengutronix.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	yibin.gong@nxp.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Holger Assmann <h.assmann@pengutronix.de>
Subject: [PATCH 1/2] regulator: pca9450: enable restart handler for I2C operation
Date: Fri, 19 Apr 2024 10:31:03 +0200
Message-Id: <20240419083104.3329252-2-h.assmann@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419083104.3329252-1-h.assmann@pengutronix.de>
References: <20240419083104.3329252-1-h.assmann@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: has@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The NXP PCA9450 can perform various kinds of power cycles when triggered
by I2C-command.
We therefore make this functionality accessible by introducing a
respective restart handler. It will be used after a priority has been
defined within the devicetree.

Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
---
 drivers/regulator/pca9450-regulator.c | 54 +++++++++++++++++++++++++++
 include/linux/regulator/pca9450.h     |  7 ++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2ab365d2749f9..e623323599964 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/pca9450.h>
+#include <linux/reboot.h>
 
 struct pc9450_dvs_config {
 	unsigned int run_reg; /* dvs0 */
@@ -33,6 +34,7 @@ struct pca9450 {
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *sd_vsel_gpio;
+	struct notifier_block restart_handler;
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
@@ -700,6 +702,34 @@ static irqreturn_t pca9450_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int pca9450_restart(struct notifier_block *nb,
+			   unsigned long mode, void *cmd)
+{
+	struct pca9450 *pmic = container_of(nb, struct pca9450,
+					    restart_handler);
+	struct i2c_client *client = container_of(pmic->dev,
+						 struct i2c_client, dev);
+	int ret = 0;
+	u32 rtype;
+
+	switch (mode) {
+	case REBOOT_WARM:
+		/* Warm reset (Toggle POR_B for 20 ms) */
+		rtype = 0x35;
+		break;
+	default:
+		/* Cold reset (Power recycle all regulators) */
+		rtype = 0x64;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, PCA9450_REG_SWRST, rtype);
+	if (ret < 0)
+		dev_alert(pmic->dev, "Failed to shutdown (err = %d)\n", ret);
+
+	mdelay(500);
+	return NOTIFY_DONE;
+}
+
 static int pca9450_i2c_probe(struct i2c_client *i2c)
 {
 	enum pca9450_chip_type type = (unsigned int)(uintptr_t)
@@ -845,12 +875,35 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		return PTR_ERR(pca9450->sd_vsel_gpio);
 	}
 
+	/* Register I2C restart handler if one is defined by device tree */
+	if (!of_property_read_u32(i2c->dev.of_node, "priority",
+				  &pca9450->restart_handler.priority)) {
+		pca9450->restart_handler.notifier_call = pca9450_restart;
+
+		ret = register_restart_handler(&pca9450->restart_handler);
+		if (ret)
+			return dev_err_probe(&i2c->dev, ret,
+					     "cannot register restart handler.\n");
+		else
+			dev_info(&i2c->dev,
+				 "registered restart handler with priority %d.\n",
+				 pca9450->restart_handler.priority);
+	}
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
 	return 0;
 }
 
+static void pca9450_i2c_remove(struct i2c_client *i2c)
+{
+	struct pca9450 *pca9450 = dev_get_drvdata(&i2c->dev);
+
+	if (pca9450->restart_handler.notifier_call)
+		unregister_restart_handler(&pca9450->restart_handler);
+}
+
 static const struct of_device_id pca9450_of_match[] = {
 	{
 		.compatible = "nxp,pca9450a",
@@ -875,6 +928,7 @@ static struct i2c_driver pca9450_i2c_driver = {
 		.of_match_table = pca9450_of_match,
 	},
 	.probe = pca9450_i2c_probe,
+	.remove = pca9450_i2c_remove,
 };
 
 module_i2c_driver(pca9450_i2c_driver);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 505c908dbb817..2ee38bab23402 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -226,6 +226,13 @@ enum {
 #define WDOG_B_CFG_COLD_LDO12		0x80
 #define WDOG_B_CFG_COLD			0xC0
 
+/* PCA9450_REG_SWRST bits */
+#define SW_RST_NONE			0x00
+#define SW_RST_DEFAULTS			0x05
+#define SW_RST_COLD_LDO12_CLK32		0x14
+#define SW_RST_WARM			0x35
+#define SW_RST_COLD			0x64
+
 /* PCA9450_REG_CONFIG2 bits */
 #define I2C_LT_MASK			0x03
 #define I2C_LT_FORCE_DISABLE		0x00
-- 
2.39.2


