Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E4761B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGYONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGYONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:13:11 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDC188;
        Tue, 25 Jul 2023 07:13:08 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id C6133100029;
        Tue, 25 Jul 2023 17:13:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C6133100029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690294386;
        bh=4FOlV1wq6XHoXw00Qlh2v00hYQ5BBSmstePHbANhbRY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=pGK6rr0Mycmtl4l0xKzo0fk+nDlF3L9mZGlqyX9lwkgy7IfZ2MENm45+gX2Noe1Gl
         qjA1rWW45Ix3YTia3vBHm+/NF73c6RbEd0er7QW1Z3l9OuO8pKWhwjTdh83Fy4qmgd
         lNOSLgVXSJG/viL0HV7kiYBt/SbYRv75Jt7/qarKdUbfDL+FlZxAtaWuseGa9BAVQ8
         HpyNsHkuGjIgD6EL8H3wOFVut0Oy1owgh+UJjw2QpuWNRm01e7rfWH3m397wAFFoqJ
         NcT2D88JH2N8wsX7v1e8QR+x37w1maQWrwjgSdGhV2SrCuMNV5Z3gtEDscLe9/E0P4
         k+/gqTR2hIYBw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 25 Jul 2023 17:13:06 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 17:13:05 +0300
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
        <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <f.fainelli@gmail.com>, <hkallweit1@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/3] drivers: rng: add check status bit feature
Date:   Tue, 25 Jul 2023 17:12:50 +0300
Message-ID: <20230725141252.98848-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230725141252.98848-1-avromanov@sberdevices.ru>
References: <20230725141252.98848-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVRomanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some Amlogic SOC's, mechanism to obtain random number
has been changed. For example, S4 now uses status bit waiting algo.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/char/hw_random/meson-rng.c | 77 ++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/meson-rng.c b/drivers/char/hw_random/meson-rng.c
index a4eb8e35f13d..c6d7349630a1 100644
--- a/drivers/char/hw_random/meson-rng.c
+++ b/drivers/char/hw_random/meson-rng.c
@@ -14,19 +14,65 @@
 #include <linux/of.h>
 #include <linux/clk.h>
 
-#define RNG_DATA 0x00
+struct meson_rng_priv {
+	bool check_status_bit;
+	unsigned int data_offset;
+	unsigned int cfg_offset;
+};
 
 struct meson_rng_data {
 	void __iomem *base;
 	struct hwrng rng;
+	struct device *dev;
+	const struct meson_rng_priv *priv;
 };
 
+#define RUN_BIT			0
+#define SEED_READY_STS_BIT	31
+#define RETRY_CNT		100
+
+static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
+{
+	u32 status;
+	u32 cnt = 0;
+
+	do {
+		status = readl_relaxed(cfg_addr) & BIT(bit);
+		cpu_relax();
+	} while (status && (cnt++ < RETRY_CNT));
+
+	if (status)
+		return -EBUSY;
+
+	return 0;
+}
+
 static int meson_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 {
 	struct meson_rng_data *data =
 			container_of(rng, struct meson_rng_data, rng);
+	const struct meson_rng_priv *priv = data->priv;
+
+	if (priv->check_status_bit) {
+		void __iomem *cfg_addr = data->base + priv->cfg_offset;
+		int err;
+
+		writel_relaxed(readl_relaxed(cfg_addr) | BIT(SEED_READY_STS_BIT), cfg_addr);
 
-	*(u32 *)buf = readl_relaxed(data->base + RNG_DATA);
+		err = meson_rng_wait_status(cfg_addr, SEED_READY_STS_BIT);
+		if (err) {
+			dev_err(data->dev, "Seed isn't ready, try again\n");
+			return err;
+		}
+
+		err = meson_rng_wait_status(cfg_addr, RUN_BIT);
+		if (err) {
+			dev_err(data->dev, "Can't get random number, try again\n");
+			return err;
+		}
+	}
+
+	*(u32 *)buf = readl_relaxed(data->base + priv->data_offset);
 
 	return sizeof(u32);
 }
@@ -41,6 +87,10 @@ static int meson_rng_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->priv = device_get_match_data(&pdev->dev);
+	if (!data->priv)
+		return -ENODEV;
+
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
@@ -53,11 +103,32 @@ static int meson_rng_probe(struct platform_device *pdev)
 	data->rng.name = pdev->name;
 	data->rng.read = meson_rng_read;
 
+	data->dev = &pdev->dev;
+
 	return devm_hwrng_register(dev, &data->rng);
 }
 
+static const struct meson_rng_priv meson_rng_priv = {
+	.check_status_bit = false,
+	.data_offset = 0x0,
+	.cfg_offset = 0x0,
+};
+
+static const struct meson_rng_priv meson_rng_priv_s4 = {
+	.check_status_bit = true,
+	.data_offset = 0x8,
+	.cfg_offset = 0x0,
+};
+
 static const struct of_device_id meson_rng_of_match[] = {
-	{ .compatible = "amlogic,meson-rng", },
+	{
+		.compatible = "amlogic,meson-rng",
+		.data = (void *)&meson_rng_priv,
+	},
+	{
+		.compatible = "amlogic,meson-rng-s4",
+		.data = (void *)&meson_rng_priv_s4,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_rng_of_match);
-- 
2.38.1

