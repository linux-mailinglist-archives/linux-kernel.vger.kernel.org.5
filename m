Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7F7E1E70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjKFKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjKFKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:33:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763D99
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:33:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso30382085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699266803; x=1699871603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEIEnAhYsKepWBm91afApetsN5rpqVotK1JY+P5qDnE=;
        b=tHMptq0raRABlD1pHOKCf2/SyK9KVtDGhlHatzaYVMP+pZfoTxN01lJEZLxQLJkly/
         o5FvW3njxSjti9NzjxanyYyJa3hlomafxXX3oUk1B+G/MNMyypElb6kCkPlc8UBcSKy/
         /nLPwfEWMxZQKQSS+/CxOOeRuQL4omFI7ndRX3jxX47rCFCG67HwBO2st9+QUKMl2i/X
         s7p785t2BLqw6ij2ivbOKLOMU/rjr/tlu2J+6rwErFC7JMXFLQRVMkMuzMB1rpWTwjlZ
         xJNlX/1++ZzpHxX0Y6ICKwuZLtkyRQSDhQKQ8SFAL6+72OnmNLeI5bJ+nPz+syeNe34M
         EcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699266803; x=1699871603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEIEnAhYsKepWBm91afApetsN5rpqVotK1JY+P5qDnE=;
        b=Ykn52kXA/EhORptwBkhG6fBFtVSpmMLAu1lTNe0jV/c7duz74xTQOkxGCY7JceU2oe
         iP6o1oH3mPaxc6rigw/Mz4/rRMKpb3fNi6lBrqa4FZl6oJSTnHudOtZoj1EFc6dTNYQZ
         qUozXVCYgUiyeAG/njKsVi4wJ5rz0kS8VHbeVIcbqVgs9TP6xuJUWmpEc96HY4r9co0D
         4/xi1kypwVap+MhG61Q3vTGoSIPg3Olja099fSOWjNY1WjeMO8QQenayzh7Zsc2sFvKI
         7HCJJ+lkdqQF0d86gADbhVipr2X/65mO4WUtJ3Yq/QkViVn6gtCYqm9Ly4jwXABD/I3Q
         cedA==
X-Gm-Message-State: AOJu0Yx3h4i3Cq0VGEbNFqdXcqw3FfmwLIGgdIAzvwgp0HAQtnFT8rj4
        LS4nAMF4twkwTdPlR6FglpxKEw==
X-Google-Smtp-Source: AGHT+IGVwhrbtmIzc5AlDT2KYR1FqT+erDyiFUsFe+87wLnTwXX8iP/Qsv51s/ID4uBAQDdOHNeMWw==
X-Received: by 2002:a5d:6051:0:b0:317:393f:8633 with SMTP id j17-20020a5d6051000000b00317393f8633mr18825987wrt.58.1699266803332;
        Mon, 06 Nov 2023 02:33:23 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:fabf:ec8c:b644:5d3])
        by smtp.googlemail.com with ESMTPSA id d1-20020a056000114100b0032415213a6fsm9033602wrx.87.2023.11.06.02.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:33:22 -0800 (PST)
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
Subject: [PATCH 4/6] pwm: meson: add generic compatible for meson8 to sm1
Date:   Mon,  6 Nov 2023 11:32:51 +0100
Message-ID: <20231106103259.703417-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106103259.703417-1-jbrunet@baylibre.com>
References: <20231106103259.703417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 5c1053884b46..68fcdc0746bd 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -95,6 +95,7 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char * const *parent_names;
+	int (*channels_init)(struct device *dev);
 };
 
 struct meson_pwm {
@@ -334,95 +335,6 @@ static const struct pwm_ops meson_pwm_ops = {
 	.owner = THIS_MODULE,
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
@@ -529,12 +441,15 @@ static int meson_pwm_init_clocks_legacy(struct device *dev,
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
@@ -543,6 +458,133 @@ static int meson_pwm_init_channels(struct device *dev)
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
@@ -574,7 +616,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	err = meson_pwm_init_channels(&pdev->dev);
+	err = meson->data->channels_init(&pdev->dev);
 	if (err < 0)
 		return err;
 
-- 
2.42.0

