Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA987768B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHITZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjHITZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7F3C0B;
        Wed,  9 Aug 2023 12:24:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbea147034so981065e9.0;
        Wed, 09 Aug 2023 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609061; x=1692213861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwigRAFAXBRS5qA8koF+a3Bv4bIxzklMHFE/MHDH5ok=;
        b=eve8xWI6YnHpUf/J5yzVBAv9L32VRTQu2RRy55ESICy3heLY5wjsRCBsUTwOV3DU5S
         RuCionFHq2S5hlamn5nk6ivk3p0gmVeJ+eCiq+Xqw7QaNzDlrYseRS9kV/CMGJj0NxFi
         sbdZfU7tnEQJeXq10+Gdoo2VA/PqCsQcWRKfWM42VjSwhxIHTIIVYQPCmxnMpVB87b8Y
         kCeVz9UkLYW5mE8Q6sDwY3Yarv0X9Nv6frMTlyQfQH0DwfK7d2c5WpiX3LFQyZGnWWOT
         SZW4itQ8mKpbTItkwF2hiWAD3pjZF/Dl96mgbqt4oPYTJhFU++j3nNXv4pI9+OknbFwN
         3JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609061; x=1692213861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwigRAFAXBRS5qA8koF+a3Bv4bIxzklMHFE/MHDH5ok=;
        b=iTCml0erA9YB7UZgHTupKSQHYt86tAM17z/9sgSIhZSzIfRuUD4pO/dpXToXEdr6XL
         bDT+6Hh/7LrtSGDvWlaHdKw4p/faRt+V2025NwRxCYcs8FfmLXxz5Qe3XSHIcnjHuhVS
         0rGkxnBCzhlaggWm0xKpvv3oEtbKLTRVDB0hBizuwg3QxNdBRM5D+ycmFOqMY+lp70AQ
         sPa7dB5DLrb7q48uWirL+Nplipwer7A16oYolN2wyuEbwiVdRKuB0T43SNHg498OlteL
         ct3j5ONnXBvFpC5k2T8SGHB5g+YAGS5UpIbCkX2eTrvs02+ok/D1eT5Rp1gc6Ox2N1Rc
         ypmw==
X-Gm-Message-State: AOJu0YxVmmPpHDPqJDNcLqOecG5WhZaVF6lcmys3mJjfWOQo53ZO1L02
        /F6ie9dlUvTKGe72hTysNa4=
X-Google-Smtp-Source: AGHT+IH4yai+QveqDBLSuuppf6HAOS+JBSMVsO4zEnvYLlgX2iVgvxEkWco9vicnXKSN1lV+MYcEdg==
X-Received: by 2002:a1c:7c0b:0:b0:3fd:e86b:f095 with SMTP id x11-20020a1c7c0b000000b003fde86bf095mr44652wmc.13.1691609060920;
        Wed, 09 Aug 2023 12:24:20 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:20 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:08 +0200
Subject: [PATCH v2 6/6] regulator: pca9450: register restart handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-6-b98b4f8139d5@skidata.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
In-Reply-To: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The PCA9450 supports both, a warm and a cold reset. Implement both and
register the respective handlers.

Acked-by: Mark Brown <broonie@kernel.org>
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

