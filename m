Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0F7EF337
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjKQM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbjKQM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:59:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46467D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:59:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-409299277bbso14304725e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700225976; x=1700830776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOigh6xEIHsnetURZKAyAV1p94v8dqGGYbyO3VKINpU=;
        b=WjLuh8mqqidS7hRxr1e/y+b7V7XhNJ1cIMceR/WoqvPUWBZPOdzfjwTNUqVUcAXiwm
         jHK3Z3YVfUCWxJ48py1gOJ7NPqe5soMks6bOLWfvr1Aa5VoHdON4N1Qxjxo3tCDiMV6n
         O4rVBCT98sQHASudO8QXIk4IqopBnVWfPiSMnUrOr8kf8ap+hm+KikTQEkDau2P/nTYe
         UeI/DIUfyt4mrGMYnhsbYTu/zpv6ooXKnTYECakmCAou/bCJYoffrkqqJ16Ad9s8GmL1
         gbFhYYI38/Tm8du6qYTTxlVw3fWYNOmDktPkWTOE8wYVh4p0w1ZLDm/GwZhkjooi+rz2
         GTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225976; x=1700830776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOigh6xEIHsnetURZKAyAV1p94v8dqGGYbyO3VKINpU=;
        b=Ben6qk4KfpzpxHFBnDJYi0cbYOYypl3DWZMSygopzFX2MxXTV7z9CIJ77Bobaj5AsQ
         GJkyVKmsNINeabOoTfiIKdxALz6jDPCErcjCV8Uf/nfYae8cfA5m2vW2k7mQvGsD9JS/
         XVM74dcz6/okc8nAqB7SRuwEj3NR+HnlxESr/0kmBhTWY5yq1NdqkkjL93KTW4hku8rk
         ztGswKZrNZMjSCoyaXO9zqUV12z0Q6dvWuHHm4zVzVnyD5bmyP6Rq4tN1GwlzO3IWrje
         8Ksx9++lK3WG7VYFHUhrvA0myWVUCMYMVIdJ+a6TOYI774ULNvYthGc7V8kv5kmLm3+T
         KnlQ==
X-Gm-Message-State: AOJu0Yzee9skT7Y0Pwa1B189p/0QSNGkLfMoNA6D3v1V6/sJGEm3vDYF
        SQsvIzH/2bM0V2RZhFPmNBCe3Q==
X-Google-Smtp-Source: AGHT+IHEtT6ZmxVlplA97BAnVFOpyJiYia3JjhedIByl1fV2eDfHeVagprornqQXjsBhl9hpgS6Xqg==
X-Received: by 2002:a7b:c8d7:0:b0:40a:2796:61a0 with SMTP id f23-20020a7bc8d7000000b0040a279661a0mr14432533wml.33.1700225975631;
        Fri, 17 Nov 2023 04:59:35 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8196:e423:38cb:9a09])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b0040a487758dcsm2671343wms.6.2023.11.17.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 04:59:35 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v2 4/6] pwm: meson: add generic compatible for meson8 to sm1
Date:   Fri, 17 Nov 2023 13:59:14 +0100
Message-ID: <20231117125919.1696980-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117125919.1696980-1-jbrunet@baylibre.com>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
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

Introduce a new compatible support in the Amlogic PWM driver.

The PWM HW is actually the same for all SoCs supported so far.
A specific compatible is needed only because the clock sources
of the PWMs are hard-coded in the driver.

It is better to have the clock source described in DT but this
changes the bindings so a new compatible must be introduced.

When all supported platform have migrated to the new compatible,
support for the legacy ones may be removed from the driver.

Adding a callback to setup the clock will also make it easier
to add support for the new PWM HW found in a1, s4, c3 and t7 SoC
families

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 224 ++++++++++++++++++++++++----------------
 1 file changed, 133 insertions(+), 91 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5cbd65cae28a..d5d745a651d3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -95,6 +95,7 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char * const *parent_names;
+	int (*channels_init)(struct device *dev);
 };
 
 struct meson_pwm {
@@ -333,95 +334,6 @@ static const struct pwm_ops meson_pwm_ops = {
 	.get_state = meson_pwm_get_state,
 };
 
-static const char * const pwm_meson8b_parent_names[] = {
-	"xtal", NULL, "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_meson8b_data = {
-	.parent_names = pwm_meson8b_parent_names,
-};
-
-/*
- * Only the 2 first inputs of the GXBB AO PWMs are valid
- * The last 2 are grounded
- */
-static const char * const pwm_gxbb_ao_parent_names[] = {
-	"xtal", "clk81", NULL, NULL,
-};
-
-static const struct meson_pwm_data pwm_gxbb_ao_data = {
-	.parent_names = pwm_gxbb_ao_parent_names,
-};
-
-static const char * const pwm_axg_ee_parent_names[] = {
-	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
-};
-
-static const struct meson_pwm_data pwm_axg_ee_data = {
-	.parent_names = pwm_axg_ee_parent_names,
-};
-
-static const char * const pwm_axg_ao_parent_names[] = {
-	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
-};
-
-static const struct meson_pwm_data pwm_axg_ao_data = {
-	.parent_names = pwm_axg_ao_parent_names,
-};
-
-static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
-	.parent_names = pwm_g12a_ao_ab_parent_names,
-};
-
-static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "g12a_ao_clk81", NULL, NULL,
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
-	.parent_names = pwm_g12a_ao_cd_parent_names,
-};
-
-static const struct of_device_id meson_pwm_matches[] = {
-	{
-		.compatible = "amlogic,meson8b-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-gxbb-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-gxbb-ao-pwm",
-		.data = &pwm_gxbb_ao_data
-	},
-	{
-		.compatible = "amlogic,meson-axg-ee-pwm",
-		.data = &pwm_axg_ee_data
-	},
-	{
-		.compatible = "amlogic,meson-axg-ao-pwm",
-		.data = &pwm_axg_ao_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ee-pwm",
-		.data = &pwm_meson8b_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-		.data = &pwm_g12a_ao_ab_data
-	},
-	{
-		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
-		.data = &pwm_g12a_ao_cd_data
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, meson_pwm_matches);
-
 static int meson_pwm_init_clocks_legacy(struct device *dev,
 					struct clk_parent_data *mux_parent_data)
 {
@@ -528,12 +440,15 @@ static int meson_pwm_init_clocks_legacy(struct device *dev,
 	return 0;
 }
 
-static int meson_pwm_init_channels(struct device *dev)
+static int meson_pwm_init_channels_legacy(struct device *dev)
 {
 	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
 	struct meson_pwm *meson = dev_get_drvdata(dev);
 	int i;
 
+	dev_info(dev, "using obsolete compatible, please consider updating dt\n");
+
+
 	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
 		mux_parent_data[i].index = -1;
 		mux_parent_data[i].name = meson->data->parent_names[i];
@@ -542,6 +457,133 @@ static int meson_pwm_init_channels(struct device *dev)
 	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
 }
 
+static int meson_pwm_init_channels_meson8b_v2(struct device *dev)
+{
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
+	int i;
+
+	/*
+	 * NOTE: Instead of relying on the hard coded names in the driver
+	 * as the legacy version, this relies on DT to provide the list of
+	 * clocks.
+	 * For once, using input numbers actually makes more sense than names.
+	 * Also DT requires clock-names to be explicitly ordered, so there is
+	 * no point bothering with clock names in this case.
+	 */
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++)
+		mux_parent_data[i].index = i;
+
+	return meson_pwm_init_clocks_legacy(dev, mux_parent_data);
+}
+
+static const char * const pwm_meson8b_parent_names[] = {
+	"xtal", NULL, "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_meson8b_data = {
+	.parent_names = pwm_meson8b_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+/*
+ * Only the 2 first inputs of the GXBB AO PWMs are valid
+ * The last 2 are grounded
+ */
+static const char * const pwm_gxbb_ao_parent_names[] = {
+	"xtal", "clk81", NULL, NULL,
+};
+
+static const struct meson_pwm_data pwm_gxbb_ao_data = {
+	.parent_names = pwm_gxbb_ao_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_axg_ee_parent_names[] = {
+	"xtal", "fclk_div5", "fclk_div4", "fclk_div3"
+};
+
+static const struct meson_pwm_data pwm_axg_ee_data = {
+	.parent_names = pwm_axg_ee_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_axg_ao_parent_names[] = {
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_axg_ao_data = {
+	.parent_names = pwm_axg_ao_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_g12a_ao_ab_parent_names[] = {
+	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_names = pwm_g12a_ao_ab_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const char * const pwm_g12a_ao_cd_parent_names[] = {
+	"xtal", "g12a_ao_clk81", NULL, NULL,
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_names = pwm_g12a_ao_cd_parent_names,
+	.channels_init = meson_pwm_init_channels_legacy,
+};
+
+static const struct meson_pwm_data pwm_meson8_v2_data = {
+	.channels_init = meson_pwm_init_channels_meson8b_v2,
+};
+
+static const struct of_device_id meson_pwm_matches[] = {
+	{
+		.compatible = "amlogic,meson8-pwm-v2",
+		.data = &pwm_meson8_v2_data
+	},
+	/*
+	 * The following compatibles are obsolete.
+	 * Support for these may be removed once the related
+	 * platforms have been updated
+	 */
+	{
+		.compatible = "amlogic,meson8b-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-ao-pwm",
+		.data = &pwm_gxbb_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ee-pwm",
+		.data = &pwm_axg_ee_data
+	},
+	{
+		.compatible = "amlogic,meson-axg-ao-pwm",
+		.data = &pwm_axg_ao_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ee-pwm",
+		.data = &pwm_meson8b_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
+		.data = &pwm_g12a_ao_ab_data
+	},
+	{
+		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
+		.data = &pwm_g12a_ao_cd_data
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, meson_pwm_matches);
+
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
@@ -573,7 +615,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	err = meson_pwm_init_channels(&pdev->dev);
+	err = meson->data->channels_init(&pdev->dev);
 	if (err < 0)
 		return err;
 
-- 
2.42.0

