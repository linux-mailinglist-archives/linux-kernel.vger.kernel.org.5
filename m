Return-Path: <linux-kernel+bounces-74978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047985E0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FC81C21BED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465981727;
	Wed, 21 Feb 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tKaSVONl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E680607
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528335; cv=none; b=ZSmiucLc/fTLwC/HBucoL/fmF6Slq8BQqf0OgSUf37ivDKx/ATogKSOkjWRkp6mOq7jPMqHD8/NWByhRVPOvp7fPFHpi7s24LVkwB9/BWjDOq79n9GR45O6sktqCJw3h6OTruNt8xqi0hR7UTU41m1mp3PBfsqBlGTTxEDYkXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528335; c=relaxed/simple;
	bh=X3WasE9KQ70MN0Vh4+bqPFmp29TXlEdA2D5rh4MfY18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYGJs6oG+wQDBjQaoGKd+B4P8WOotGWBXDKvev+A+9igVrrzXAIFLrY+EAGhdP08Ycc9XyrpXV9fFIpbQwCDU2QAXbQfnuYxbR2Ce1lzpKclCSWqRIPFrL/7d/24vqr5uhhpLRdYsBpt62HduHXj0Xn1mQgH+Z6M3YjQiS1asAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tKaSVONl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41273f53c71so6615755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708528332; x=1709133132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74FeFDIe1tQA6L7395dqtw/ncyV+KOTJre2S3F/uNM=;
        b=tKaSVONlRDeqDMg/2j8gNpfxGRgVNQVENe7h+yFMpV9LvaVFxDj670ipTJzv9qqTR6
         1k2EGFV9FDStfBCtpQLNqH4ixTdy+ZVynBcfjfiY3nQ9wgefcN8rl9HCyqmAMN+UxnkE
         dCc4OaeVg8HxveMvxO8pXiuEbq+UbSy0mxIcutb1jPAUqTXlkA+jYo0WNdrIdKryMrrV
         oiF3+eEWuDLJLo6XvFTAlRBnFg5jte/FDYsCJWOG5AeL9ABoy3zn/Zn9m0ROyzdpCvj2
         +Imy6StO65B3UtN6JVWtiUPqPv8nLlRck3hOslnm4cXVLPr1jJxIFSg0kiDWa/749U0H
         fPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528332; x=1709133132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74FeFDIe1tQA6L7395dqtw/ncyV+KOTJre2S3F/uNM=;
        b=rtywm/wGSQhr19lb4P/6EMrOgV1a3NAFXGDfJhCPbIZvRV7nqBAJnl/9tawiAXmuN1
         Dv9zikTuvIfr6SmLtB0/RM/5izzQoVqobAKwq8T5UjWB45d6KPJoYPFM5sRQ7VJI6f2O
         /AH1wvMu/IdYrWzufMUGuF6O2k0g31fXq/P84ZgZcUtJoI8MswX3IRJBjJLAv59+RMRB
         rtVUFFsatau5fhq+qKQcC4HSiqjMWYSu6nOzfrz4SVPACf6XVC3YPHbGUY3Ap19d5/1J
         kGcFMv4biarHAHjPJh4wThA69rt2KQF8MdtrJ8+4DtYY/TzExWWekRX3XRyPOydoDil0
         Z3hw==
X-Forwarded-Encrypted: i=1; AJvYcCUFiepD4izGDf4gz09K2jgxSm52mikQ3E+tWhwIKbnnTpdJ+NnevN86Sb1CXME62bwQyKduwnsr7J6IzSu6U6bf8d9NkRZr6hLjcHtx
X-Gm-Message-State: AOJu0YzPG2aM0mUfN9GxWwM4CrBugzFj79PRy4V4XKI6dpuEzLvWK5lN
	EdFJ87jbf2jHqQdtYQcDXXEuN4NeJjMX7AAyOkE1zIm0geJwaJfMCcRnN1ZSt7I=
X-Google-Smtp-Source: AGHT+IH0BIGfDcyECWrL+G0YcnBelN2VYVCfDRoTAKneFYafATVPl+LVdCn8hr7FrY+5box9ZQGFEg==
X-Received: by 2002:a05:600c:4f83:b0:411:ddc2:28b2 with SMTP id n3-20020a05600c4f8300b00411ddc228b2mr17153344wmq.27.1708528332062;
        Wed, 21 Feb 2024 07:12:12 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1b1a:d907:d735:9f9e])
        by smtp.googlemail.com with ESMTPSA id bg22-20020a05600c3c9600b0040fc56712e8sm18725342wmb.17.2024.02.21.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:12:11 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to sm1
Date: Wed, 21 Feb 2024 16:11:51 +0100
Message-ID: <20240221151154.26452-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221151154.26452-1-jbrunet@baylibre.com>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Introduce a new compatible support in the Amlogic PWM driver.

The PWM HW is actually the same for all SoCs supported so far. A specific
compatible is needed only because the clock sources of the PWMs are
hard-coded in the driver.

It is better to have the clock source described in DT but this changes the
bindings so a new compatible must be introduced.

When all supported platform have migrated to the new compatible, support
for the legacy ones may be removed from the driver.

The addition of this new compatible makes the old ones obsolete, as
described in the DT documentation.

Adding a callback to setup the clock will also make it easier to add
support for the new PWM HW found in a1, s4, c3 and t7 SoC families.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 195 +++++++++++++++++++++++++---------------
 1 file changed, 121 insertions(+), 74 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index fe61335d87d0..90fc7b349723 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -101,6 +101,7 @@ struct meson_pwm_channel {
 
 struct meson_pwm_data {
 	const char *const parent_names[MESON_NUM_MUX_PARENTS];
+	int (*channels_init)(struct pwm_chip *chip);
 };
 
 struct meson_pwm {
@@ -341,86 +342,16 @@ static const struct pwm_ops meson_pwm_ops = {
 	.get_state = meson_pwm_get_state,
 };
 
-static const struct meson_pwm_data pwm_meson8b_data = {
-	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
-};
-
-/*
- * Only the 2 first inputs of the GXBB AO PWMs are valid
- * The last 2 are grounded
- */
-static const struct meson_pwm_data pwm_gxbb_ao_data = {
-	.parent_names = { "xtal", "clk81", NULL, NULL },
-};
-
-static const struct meson_pwm_data pwm_axg_ee_data = {
-	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
-};
-
-static const struct meson_pwm_data pwm_axg_ao_data = {
-	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
-	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
-};
-
-static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
-	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
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
-static int meson_pwm_init_channels(struct pwm_chip *chip)
+static int meson_pwm_init_clocks_meson8b(struct pwm_chip *chip,
+					 struct clk_parent_data *mux_parent_data)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
 	struct device *dev = pwmchip_parent(chip);
 	unsigned int i;
 	char name[255];
 	int err;
 
-	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
-		mux_parent_data[i].index = -1;
-		mux_parent_data[i].name = meson->data->parent_names[i];
-	}
-
-	for (i = 0; i < chip->npwm; i++) {
+	for (i = 0; i < MESON_NUM_PWMS; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data pdata = {};
 		struct meson8b_pwm_clocks *clks;
@@ -502,6 +433,122 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 	return 0;
 }
 
+static int meson_pwm_init_channels_meson8b_legacy(struct pwm_chip *chip)
+{
+	struct clk_parent_data mux_parent_data[MESON_NUM_MUX_PARENTS] = {};
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	int i;
+
+	dev_warn_once(pwmchip_parent(chip),
+		      "using obsolete compatible, please consider updating dt\n");
+
+	for (i = 0; i < MESON_NUM_MUX_PARENTS; i++) {
+		mux_parent_data[i].index = -1;
+		mux_parent_data[i].name = meson->data->parent_names[i];
+	}
+
+	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
+}
+
+static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
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
+	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
+}
+
+static const struct meson_pwm_data pwm_meson8b_data = {
+	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
+/*
+ * Only the 2 first inputs of the GXBB AO PWMs are valid
+ * The last 2 are grounded
+ */
+static const struct meson_pwm_data pwm_gxbb_ao_data = {
+	.parent_names = { "xtal", "clk81", NULL, NULL },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
+static const struct meson_pwm_data pwm_axg_ee_data = {
+	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
+static const struct meson_pwm_data pwm_axg_ao_data = {
+	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
+	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
+	.channels_init = meson_pwm_init_channels_meson8b_legacy,
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
+	/* The following compatibles are obsolete */
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
 	struct pwm_chip *chip;
@@ -522,7 +569,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(chip);
+	err = meson->data->channels_init(chip);
 	if (err < 0)
 		return err;
 
-- 
2.43.0


