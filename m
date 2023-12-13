Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D90811F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjLMTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjLMTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE739C;
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso52952485e9.2;
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497090; x=1703101890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SouF/Ke6EpeUvfoqZ3rKNuHloSyd05Y/ZVCgaagWqrY=;
        b=L9JrxHP5oJ99bQgsCxU81Ac5IPWaFoxUMiSveKRc7Q8ba6dfr/DNVXg2ATAE29rJyF
         XVehLS+S+ec9zhb8PIG1XhuJtFrhMs14jQ0U92wUptrpAA2Nzu1b3/ixrTOdaFzDCxii
         qxfUcDKK8G3lZE+glFagOXYtGJNYlNUZrJLct6ElGc+5Ty7xomoDCOEqxF/Q7zNzyHLe
         tW/z1cU4KhpTdADrKsNstg6n3rnRAFAxWUvzqbPIkiDwV9NuV9Y6eM2EzkEOV/o0sYiN
         cHqqx/970mXjV8FnMjFOXwCvJaB0gOEOss4vaI83cEC/Y+mSquCQ38Hk6R4vC2ImXs19
         CZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497090; x=1703101890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SouF/Ke6EpeUvfoqZ3rKNuHloSyd05Y/ZVCgaagWqrY=;
        b=T+re4ZDjreAInbndC+8YPcZVDClAK86bCd4vmuhxF/NKVVZwMNnnDF8vfLrhxREEV7
         PmkB8JdxtCMWdIIzSVgwM9oO8TtUTB77v3KpudgfbFRl76bU/q4cQkXfNZ3aB6doB662
         hluYj3TZSo7xTEPMAcx44xgz2Wd8eCbIKRWdBMzVnsw2etNBrvRs9MLFcxZ4vG/nk+RG
         lGV//PKq6IcvgY0Dvp205qL5OYzPMV8qWvtX4WY7QJTYAsWwcpqfIUTGH36Ltbsne1U6
         rJHYKwZvQc+le4eWxn4t60s2ThZloRTtlXHgAk5xUHDl0ea9N3as+ezbUbsKybiyK7nb
         PaEg==
X-Gm-Message-State: AOJu0YyAjXdTQ3mfJU3sVhMtxe3h8xwvMwLGIdodBpyCX4Fsrk9UGrs7
        eFzf/WJpX0sF5Yc/iBnKmQ==
X-Google-Smtp-Source: AGHT+IF3dmjdH+sKpem8q1BZFR4nFS4vYZs3puOpJfKUnCvQRp2cuFM4A3r5prEoc+CN23yNfvJiAQ==
X-Received: by 2002:a05:600c:20e:b0:40c:22de:79 with SMTP id 14-20020a05600c020e00b0040c22de0079mr3015293wmi.226.1702497090248;
        Wed, 13 Dec 2023 11:51:30 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:30 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 05/11] drm/rockchip: inno_hdmi: Add variant support
Date:   Wed, 13 Dec 2023 20:51:19 +0100
Message-ID: <20231213195125.212923-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support RK3128's integration of the controller, this
patch adds a simple variant implementation. They mainly differ in the
phy configuration required, so those are part of the match_data.
The values have been taken from downstream. The pixelclocks in there are
meant to be max-inclusive.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 68 +++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 32626a75723c..593b184bd0ad 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -27,6 +27,17 @@
 
 #include "inno_hdmi.h"
 
+struct inno_hdmi_phy_config {
+	unsigned int pixelclock;
+	u8 pre_emphasis;
+	u8 voltage_level_control;
+};
+
+struct inno_hdmi_variant {
+	struct inno_hdmi_phy_config *phy_configs;
+	struct inno_hdmi_phy_config *default_phy_config;
+};
+
 struct hdmi_data_info {
 	int vic;
 	bool sink_has_audio;
@@ -64,6 +75,14 @@ struct inno_hdmi {
 
 	struct hdmi_data_info	hdmi_data;
 	struct drm_display_mode previous_mode;
+
+	const struct inno_hdmi_variant *variant;
+};
+
+static struct inno_hdmi_phy_config rk3036_hdmi_phy_configs[] = {
+	{ 74250000,  0x3f, 0xbb },
+	{ 165000000, 0x6f, 0xbb },
+	{ ~0UL,	     0x00, 0x00 }
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -176,6 +195,24 @@ static inline void hdmi_modb(struct inno_hdmi *hdmi, u16 offset,
 	hdmi_writeb(hdmi, offset, temp);
 }
 
+static int inno_hdmi_find_phy_config(struct inno_hdmi *hdmi,
+				     unsigned int pixelclk)
+{
+	const struct inno_hdmi_phy_config *phy_configs =
+						hdmi->variant->phy_configs;
+	int i;
+
+	for (i = 0; phy_configs[i].pixelclock != ~0UL; i++) {
+		if (pixelclk <= phy_configs[i].pixelclock)
+			return i;
+	}
+
+	DRM_DEV_DEBUG(hdmi->dev, "No phy configuration for pixelclock %u\n",
+		      pixelclk);
+
+	return -EINVAL;
+}
+
 static void inno_hdmi_i2c_init(struct inno_hdmi *hdmi)
 {
 	int ddc_bus_freq;
@@ -200,12 +237,25 @@ static void inno_hdmi_sys_power(struct inno_hdmi *hdmi, bool enable)
 
 static void inno_hdmi_set_pwr_mode(struct inno_hdmi *hdmi, int mode)
 {
+	int ret;
+	struct inno_hdmi_phy_config *phy_config;
+
 	switch (mode) {
 	case NORMAL:
 		inno_hdmi_sys_power(hdmi, false);
 
-		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, 0x6f);
-		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, 0xbb);
+		ret = inno_hdmi_find_phy_config(hdmi, hdmi->tmds_rate);
+		if (ret < 0) {
+			phy_config = hdmi->variant->default_phy_config;
+			DRM_DEV_ERROR(hdmi->dev,
+				      "Using default phy configuration for TMDS rate %u",
+				      hdmi->tmds_rate);
+		} else {
+			phy_config = &hdmi->variant->phy_configs[ret];
+		}
+
+		hdmi_writeb(hdmi, HDMI_PHY_PRE_EMPHASIS, phy_config->pre_emphasis);
+		hdmi_writeb(hdmi, HDMI_PHY_DRIVER, phy_config->voltage_level_control);
 
 		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x15);
 		hdmi_writeb(hdmi, HDMI_PHY_SYS_CTL, 0x14);
@@ -845,6 +895,8 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
 	struct inno_hdmi *hdmi;
+	const struct inno_hdmi_variant *variant;
+
 	int irq;
 	int ret;
 
@@ -853,6 +905,12 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	hdmi->dev = dev;
+
+	variant = of_device_get_match_data(hdmi->dev);
+	if (!variant)
+		return -EINVAL;
+
+	hdmi->variant = variant;
 	hdmi->drm_dev = drm;
 
 	hdmi->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -949,8 +1007,14 @@ static void inno_hdmi_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &inno_hdmi_ops);
 }
 
+static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
+	.phy_configs = rk3036_hdmi_phy_configs,
+	.default_phy_config = &rk3036_hdmi_phy_configs[1],
+};
+
 static const struct of_device_id inno_hdmi_dt_ids[] = {
 	{ .compatible = "rockchip,rk3036-inno-hdmi",
+	  .data = &rk3036_inno_hdmi_variant,
 	},
 	{},
 };
-- 
2.43.0

