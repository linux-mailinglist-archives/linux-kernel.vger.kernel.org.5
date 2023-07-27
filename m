Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC176578D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjG0P1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjG0P0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46422D54;
        Thu, 27 Jul 2023 08:26:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3174aac120aso1135803f8f.2;
        Thu, 27 Jul 2023 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471611; x=1691076411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaf1CkazPa/KyrRWgauOWJb0xhcTY+lZFF1+FP/RQeg=;
        b=pES+br6PSABHemdK2hVq8M/cGE/LbSDF9CzsX6b/tw22P+HPQN5JDqFlEAJg1/Ko21
         4l3xTwhx1RpvV0FDlZF2XvaFtlAYeMU7nRTIr/+L1BYYBFaVDqgix7aWOakaSmIpBs57
         V8RX4xQ54mO2syAYOHY0JSsNAx39PgCv1UPklwkPMSEzB0DDdFIexEG++xX2uCkj79my
         KfjXxnfz5eSzNS48bUfU44hZGlvueZcipQKU/96SBWpTeznggJISFzzo9NtkcX+Zrulv
         9+q0yiO2GxW7MewOB14kqMvPIhW1/tnJ8mPS2ejOW+jDJ/WVVIUopKdkeZl8vo5bUc9m
         bidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471611; x=1691076411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaf1CkazPa/KyrRWgauOWJb0xhcTY+lZFF1+FP/RQeg=;
        b=VImuB800c2+5fGnNsdkd0+VxHEGFkZKOmckXTq90lJXTniMxGJTO/XPH0mu46nL8xL
         5HmKvS4MEtfnw6fsJ2quGTPVz3bja6NBzuqYLXLmW65m/WcPKe8MvrTiRmRE6HNKK8ZT
         doZHT9WL9UlArd8hirzgyVUC1ogc+83sM+fJ6VZLeayT9Qvukbrw/NRuhe0n0uUjryhP
         FktkVdqaMQ7MRUlk2bYpNZimD06/jbgguGMeAUX5FeIs4VvWtzG0g/J8FwBPPSd1bLuq
         9d14sk3dTb2E+dVSZWD7kKesDfUr+P/uQsskrwb1pi4YD1fU+65BomNYZuUY7NLKSczE
         IwSA==
X-Gm-Message-State: ABy/qLbIfasaZpN9uMHgDIaQBB/Izseu5/qm3PZAtLd3PUkRulIBYP3h
        J4o7s3ghwsqrgWVBBlASyyw=
X-Google-Smtp-Source: APBJJlHpj9mV3MVcTKuPvVTXJhI7/bT5b21nBa++UYoWXRN6A54XNn2ORsf8QM6bqXVp2qwKa/oldw==
X-Received: by 2002:adf:f091:0:b0:317:650e:9030 with SMTP id n17-20020adff091000000b00317650e9030mr1982626wro.57.1690471610905;
        Thu, 27 Jul 2023 08:26:50 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:50 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:41 +0200
Subject: [PATCH 6/6] regulator: pca9450: register restart handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-6-c8edb27bf404@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
In-Reply-To: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The PCA9450 supports both, a warm and a cold reset. Implement both and
register the respective handlers.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/pca9450-regulator.c | 59 +++++++++++++++++++++++++++++++++++
 include/linux/regulator/pca9450.h     |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2ab365d2749f..86903d677bf6 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -38,6 +38,11 @@ struct pca9450 {
 	int irq;
 };
 
+static inline struct pca9450 *dev_to_pca9450(struct device *dev)
+{
+	return dev_get_drvdata(dev);
+}
+
 static const struct regmap_range pca9450_status_range = {
 	.range_min = PCA9450_REG_INT1,
 	.range_max = PCA9450_REG_PWRON_STAT,
@@ -219,6 +224,42 @@ static int pca9450_set_dvs_levels(struct device_node *np,
 	return ret;
 }
 
+static int pca9450_cold_reset(struct pca9450 *pca9450)
+{
+	int ret;
+
+	ret = regmap_write(pca9450->regmap, PCA9450_REG_SWRST,
+			   SWRST_RESET_COLD_LDO12);
+	if (ret)
+		return ret;
+
+	/* t_RESTART is 250 ms. */
+	mdelay(500);
+	return -ETIME;
+}
+
+static int pca9450_warm_reset(struct pca9450 *pca9450)
+{
+	int ret;
+
+	ret = regmap_write(pca9450->regmap, PCA9450_REG_SWRST,
+			   SWRST_RESET_WARM);
+	if (ret)
+		return ret;
+
+	/* t_RESET is 20 ms. */
+	mdelay(50);
+	return -ETIME;
+}
+
+static int pca9450_restart_handler(struct sys_off_data *data)
+{
+	int (*handler)(struct pca9450 *) = data->cb_data;
+	struct pca9450 *pca9450 = dev_to_pca9450(data->dev);
+
+	return handler(pca9450);
+}
+
 static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
@@ -845,6 +886,24 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		return PTR_ERR(pca9450->sd_vsel_gpio);
 	}
 
+	ret = devm_register_cold_restart_handler(pca9450->dev,
+						 pca9450_restart_handler,
+						 pca9450_cold_reset);
+	if (ret) {
+		dev_err(&i2c->dev, "register cold restart handler failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = devm_register_warm_restart_handler(pca9450->dev,
+						 pca9450_restart_handler,
+						 pca9450_warm_reset);
+	if (ret) {
+		dev_err(&i2c->dev, "register warm restart handler failed: %d\n",
+			ret);
+		return ret;
+	}
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
 
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 505c908dbb81..a72fd4942d5f 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -93,6 +93,13 @@ enum {
 	PCA9450_MAX_REGISTER	    = 0x2F,
 };
 
+/* PCA9450 SW_RST bits */
+#define SWRST_NOACTION			0x00
+#define SWRST_RESET_REGS		0x05
+#define SWRST_RESET_COLD_LDO12		0x14
+#define SWRST_RESET_WARM		0x35
+#define SWRST_RESET_COLD		0x64
+
 /* PCA9450 BUCK ENMODE bits */
 #define BUCK_ENMODE_OFF			0x00
 #define BUCK_ENMODE_ONREQ		0x01

-- 
2.34.1

