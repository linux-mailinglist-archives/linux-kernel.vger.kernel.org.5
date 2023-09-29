Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330247B3061
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjI2Kbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjI2KbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:31:01 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659519A4;
        Fri, 29 Sep 2023 03:29:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CF122100004;
        Fri, 29 Sep 2023 13:29:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CF122100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1695983391;
        bh=02RgSRPHLOGMEHrDtoEfLEEz5FUki4ghJjru+SHAGro=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=SBP9ICdR7OYnGMVti7OwVZYhv9XoQskVjE6Ij4FkW2hBpunUMctJn9KcSgd15+8Ut
         CqLox9lwbbGxTa5on5HqkzsFV+vrCW2qjaRL8QFkr7E5a7Er6Px1kYhY/tf4foLb/3
         2ge/aue8vqb5EzfwVFBWvk/N5hbsezISbLG5tUFdc7ucdGCkMJRARTJ2no/Hc4cwAI
         A4GcHGd9KBdaxJUAH+z2X4tAr4rMbAGNnjCqaroZ96ZGQ6DWy+ncYs18GBBNsB68YW
         CasC9DhsMlwDfjj1a13MkbIjubWFK9QiHV5F2EoKeuUd/G0epXaMG1yY0+Jcyhn4OQ
         vJoWmf+yT2CPQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 29 Sep 2023 13:29:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 29 Sep 2023 13:29:51 +0300
From:   Alexey Romanov <avromanov@salutedevices.com>
To:     <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
        <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <conor@kernel.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <f.fainelli@gmail.com>, <hkallweit1@gmail.com>, <lists@kaiser.cx>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v5 1/3] drivers: rng: meson: add support for S4
Date:   Fri, 29 Sep 2023 13:29:36 +0300
Message-ID: <20230929102942.67985-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929102942.67985-1-avromanov@salutedevices.com>
References: <20230929102942.67985-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180231 [Sep 29 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/29 07:52:00 #22006267
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

For some Amlogic SOC's, mechanism to obtain random number
has been changed. For example, S4 now uses status bit waiting algo.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/char/hw_random/meson-rng.c | 80 ++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
index a4eb8e35f13d..75225eb9fef6 100644
--- a/drivers/char/hw_random/meson-rng.c
+++ b/drivers/char/hw_random/meson-rng.c
@@ -13,12 +13,23 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 
-#define RNG_DATA 0x00
+#define RNG_DATA	0x00
+#define RNG_S4_DATA	0x08
+#define RNG_S4_CFG	0x00
+
+#define RUN_BIT		BIT(0)
+#define SEED_READY_STS_BIT	BIT(31)
+
+struct meson_rng_priv {
+	int (*read)(struct hwrng *rng, void *buf, size_t max, bool wait);
+};
 
 struct meson_rng_data {
 	void __iomem *base;
 	struct hwrng rng;
+	struct device *dev;
 };
 
 static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
@@ -31,16 +42,62 @@ static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 	return sizeof(u32);
 }
 
+static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
+{
+	u32 status = 0;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout_atomic(cfg_addr,
+						status, !(status & bit),
+						10, 10000);
+	if (ret)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int meson_s4_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	struct meson_rng_data *data =
+			container_of(rng, struct meson_rng_data, rng);
+
+	void __iomem *cfg_addr = data->base + RNG_S4_CFG;
+	int err;
+
+	writel_relaxed(readl_relaxed(cfg_addr) | SEED_READY_STS_BIT, cfg_addr);
+
+	err = meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
+	if (err) {
+		dev_err(data->dev, "Seed isn't ready, try again\n");
+		return err;
+	}
+
+	err = meson_rng_wait_status(cfg_addr, RUN_BIT);
+	if (err) {
+		dev_err(data->dev, "Can't get random number, try again\n");
+		return err;
+	}
+
+	*(u32 *)buf = readl_relaxed(data->base + RNG_S4_DATA);
+
+	return sizeof(u32);
+}
+
 static int meson_rng_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_rng_data *data;
 	struct clk *core_clk;
+	const struct meson_rng_priv *priv;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	priv = device_get_match_data(&pdev->dev);
+	if (!priv)
+		return -ENODEV;
+
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
@@ -51,13 +108,30 @@ static int meson_rng_probe(struct platform_device *pdev)
 				     "Failed to get core clock\n");
 
 	data->rng.name = pdev->name;
-	data->rng.read = meson_rng_read;
+	data->rng.read = priv->read;
+
+	data->dev = &pdev->dev;
 
 	return devm_hwrng_register(dev, &data->rng);
 }
 
+static const struct meson_rng_priv meson_rng_priv = {
+	.read = meson_rng_read,
+};
+
+static const struct meson_rng_priv meson_rng_priv_s4 = {
+	.read = meson_s4_rng_read,
+};
+
 static const struct of_device_id meson_rng_of_match[] = {
-	{ .compatible = "amlogic,meson-rng", },
+	{
+		.compatible = "amlogic,meson-rng",
+		.data = (void *)&meson_rng_priv,
+	},
+	{
+		.compatible = "amlogic,meson-s4-rng",
+		.data = (void *)&meson_rng_priv_s4,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_rng_of_match);
-- 
2.25.1

