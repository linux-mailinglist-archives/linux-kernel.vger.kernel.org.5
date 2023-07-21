Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96375C84C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGUNul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGUNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3330DA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so17698185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947418; x=1690552218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrC0OKi8JQYuMqsO21AINU5+pXiu6nr1MLw9iKQGNsE=;
        b=cw1Y22JMoUFkP+Tx3LNBq4U3LrsJOXXyfWKC72ylHegFNsa2EsP6tpJO+W3v2P1tP/
         gkPRrX9ZOWY1IO4KRJsBKjNdN5wTLnIg7d5MEDwNqHf/i+fGNNCZbRhivEXU3RDXzskS
         GCXhjGycty7P1ew72UShwsQylLGgIht4oVd+lV0cQ9KjQzWQ3rnQKvm0B5EP6a6U5XRP
         jbyGC9HmwBylYjcL5YCmayM6FDal1WwwApTjguUZG45FVuf4dF/zx5vqnf81U0u7JDsS
         3QmfapFYuHbGYqBdaCVjCpgmoU1rfWhakRqq+xhRezkrLPrmK+Oqf1I0vCOUQ3NHtpqh
         NAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947418; x=1690552218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrC0OKi8JQYuMqsO21AINU5+pXiu6nr1MLw9iKQGNsE=;
        b=hHLSQUlyyrmboLrKTHZWz7cDYxWRRlrguCA8bSQxX8a1en6r3cYj4VaU4GAuxcS8++
         SpTWx3BTSMdZyiCYPlEVESp5qKuYM1GmARAk9IUPRf9XHkwRtkIzIh+AGRGSde4+8w49
         EIF0mVMuu4CUUjkAwRInkGm3jhXZ1nZCscDTu1QqlPpJqFA3fCQeMvxwYmTnWTk6EG6M
         Tg5vIdBGa0Y144oT2jL8vGe7Jl73GFB+pFydu+a0kmNcTyTbwlPvRFl3ifbObdHREN3i
         IV83OZOVFdUBOkkkK8BVV22GYNhsqUElsKAHaunNGXSmWx3OmG0vImvqmhz6tmjyyCBT
         34cw==
X-Gm-Message-State: ABy/qLbbY7jNSbpJJFYRcaoWLuC4l7tiOH2V2p1GcGlqNsMfotFz2WJQ
        jAFG/7am6/+yb2WfVkAnweLwtg==
X-Google-Smtp-Source: APBJJlEno01TqlbSvtHGOjdeWJG/V93lMZqCslhnWE4BROAorKilbJh9F6d1bkMsAOfVA6kIeDcg/w==
X-Received: by 2002:a05:600c:210d:b0:3fa:7b44:7195 with SMTP id u13-20020a05600c210d00b003fa7b447195mr1508308wml.10.1689947418587;
        Fri, 21 Jul 2023 06:50:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:18 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 5/6] can: tcan4x5x: Add support for tcan4552/4553
Date:   Fri, 21 Jul 2023 15:50:08 +0200
Message-Id: <20230721135009.1120562-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcan4552 and tcan4553 do not have wake or state pins, so they are
currently not compatible with the generic driver. The generic driver
uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
are not defined. These functions use register bits that are not
available in tcan4552/4553.

This patch adds support by introducing version information to reflect if
the chip has wake and state pins. Also the version is now checked.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 104 ++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index fb9375fa20ec..2d329b4e4f52 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -7,6 +7,7 @@
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
 #define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
 #define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
@@ -103,6 +104,37 @@
 #define TCAN4X5X_WD_3_S_TIMER BIT(29)
 #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
 
+struct tcan4x5x_version_info {
+	const char *name;
+	u32 id2_register;
+
+	bool has_wake_pin;
+	bool has_state_pin;
+};
+
+enum {
+	TCAN4552 = 0,
+	TCAN4553,
+	TCAN4X5X,
+};
+
+static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
+	[TCAN4552] = {
+		.name = "4552",
+		.id2_register = 0x32353534,
+	},
+	[TCAN4553] = {
+		.name = "4553",
+		.id2_register = 0x32353534,
+	},
+	/* generic version with no id2_register at the end */
+	[TCAN4X5X] = {
+		.name = "generic",
+		.has_wake_pin = true,
+		.has_state_pin = true,
+	},
+};
+
 static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct tcan4x5x_priv, cdev);
@@ -254,18 +286,53 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
+static const struct tcan4x5x_version_info
+*tcan4x5x_find_version(struct tcan4x5x_priv *priv)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID1, &val);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (val != TCAN4X5X_DEV_ID1_TCAN) {
+		dev_err(&priv->spi->dev, "Not a tcan device %x\n", val);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID2, &val);
+	if (ret)
+		return ERR_PTR(ret);
+
+	for (int i = 0; i != ARRAY_SIZE(tcan4x5x_versions); ++i) {
+		const struct tcan4x5x_version_info *vinfo = &tcan4x5x_versions[i];
+
+		if (!vinfo->id2_register || val == vinfo->id2_register) {
+			dev_info(&priv->spi->dev, "Detected TCAN device version %s\n",
+				 vinfo->name);
+			return vinfo;
+		}
+	}
+
+	return &tcan4x5x_versions[TCAN4X5X];
+}
+
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
+			      const struct tcan4x5x_version_info *version_info)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+	if (version_info->has_wake_pin) {
+		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
+							    GPIOD_OUT_HIGH);
+		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 
-		tcan4x5x_disable_wake(cdev);
+			tcan4x5x_disable_wake(cdev);
+		}
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -277,12 +344,14 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-							      "device-state",
-							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio)) {
-		tcan4x5x->device_state_gpio = NULL;
-		tcan4x5x_disable_state(cdev);
+	if (version_info->has_state_pin) {
+		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+								      "device-state",
+								      GPIOD_IN);
+		if (IS_ERR(tcan4x5x->device_state_gpio)) {
+			tcan4x5x->device_state_gpio = NULL;
+			tcan4x5x_disable_state(cdev);
+		}
 	}
 
 	return 0;
@@ -299,6 +368,7 @@ static struct m_can_ops tcan4x5x_ops = {
 
 static int tcan4x5x_can_probe(struct spi_device *spi)
 {
+	const struct tcan4x5x_version_info *version_info;
 	struct tcan4x5x_priv *priv;
 	struct m_can_classdev *mcan_class;
 	int freq, ret;
@@ -361,7 +431,13 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_m_can_class_free_dev;
 
-	ret = tcan4x5x_get_gpios(mcan_class);
+	version_info = tcan4x5x_find_version(priv);
+	if (IS_ERR(version_info)) {
+		ret = PTR_ERR(version_info);
+		goto out_power;
+	}
+
+	ret = tcan4x5x_get_gpios(mcan_class, version_info);
 	if (ret)
 		goto out_power;
 
-- 
2.40.1

