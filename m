Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1195811F71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442397AbjLMTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379033AbjLMTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE62E0;
        Wed, 13 Dec 2023 11:51:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso59661675e9.1;
        Wed, 13 Dec 2023 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497092; x=1703101892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBLnvjeKj80rmtJP//IlHjPdLy+lYfLLyByJrZj8/N8=;
        b=bxCQ3H14MTiM05nMM/WiVrgsXSWtYx1RAvZZC2hq/x+gIFZf0Vr4RclKkeb+rXrYpU
         JYXiGXaIDobNSSxBvJl+2rX+PWQ5SBTLSrgxIDFdKl1W0IifoJcSSvPXDJuBDttjvB5I
         q9ohyknymFvMoceBIfUPlpib3Z1lIljS3ukpZ695iL3gscXhrRyEZuXhWaBAtg84SiXM
         MluQ3h5psi5zOjVhqFYskmmE/XVA1BscapXac2OikKxmlKLVdXGj+Fkgv9SMK9vLY3n+
         0i7SvX7CY4boa748dvyrXZqzOyrrIjaTl0S0AQWJMPqQoURsdWZR4GyRKQhAoTgqq8kQ
         nXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497092; x=1703101892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBLnvjeKj80rmtJP//IlHjPdLy+lYfLLyByJrZj8/N8=;
        b=uQE7sS6eDAWRDb686PJqdcsKHNiGe8cDJCo6Wpdwi4gU5y7+BAZXDcT5yySs8II/2S
         HAUa0v0ccYzdwf867wDxBUWwFwTsyi/zPTf6dlnU9g3yehEqBRK/npCHc3wXcJm+ByWP
         f6AbktpNPDl9JZJEEMQr73JI2bqpT6mGKYjuyYiiIuB5dUbQhheMjJlEyGvdRdf/zpVx
         o6zR/x+O4cAgStDxt60Ylxr5HJbQr1A0CdzmhH23XjppBCuLcvIc9sXYer+9p1HVnZLp
         Ol7acq1uYGBcJe7b2iYpAyUgdv6G977KhWUf2CRUh5a5QZo7a0lFWc/kNFQtHD+ngEgc
         MQaQ==
X-Gm-Message-State: AOJu0Yx9633+t1wmiUsIlGzjXKeUQ833xc8IMKSh30KDVR4jLq9UvIDF
        dmBGmOIwvWtXKXQXXHNYmw==
X-Google-Smtp-Source: AGHT+IF9yTALPZ/WtAhWe1OyfTmJhAh53BvI/LasLM9OYzL66wjl3/q0XJ3XWlvlHYku/I4Y0WR6ZQ==
X-Received: by 2002:a05:600c:46c6:b0:40c:2ba6:809 with SMTP id q6-20020a05600c46c600b0040c2ba60809mr4457221wmo.157.1702497091606;
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
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
Subject: [PATCH 07/11] drm/rockchip: inno_hdmi: Add basic mode validation
Date:   Wed, 13 Dec 2023 20:51:21 +0100
Message-ID: <20231213195125.212923-8-knaerzche@gmail.com>
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

As per TRM this controller supports pixelclocks starting from 25 MHz. The
maximum supported pixelclocks are defined by the phy configurations we
have. Also it can't support modes that require doubled clocks.
If there is a phy reference clock we can additionally validate against
VESA DMT's recommendations.
Those checks are added to the mode_valid hook of the connector and
encoder's mode_fixup hook.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 38 ++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f7f0bec725f9..2f839ff31c1c 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -38,6 +38,8 @@ struct inno_hdmi_variant {
 	struct inno_hdmi_phy_config *default_phy_config;
 };
 
+#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
+
 struct hdmi_data_info {
 	int vic;
 	bool sink_has_audio;
@@ -572,6 +574,34 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	return 0;
 }
 
+static enum drm_mode_status inno_hdmi_mode_valid(struct inno_hdmi *hdmi,
+						 struct drm_display_mode *mode)
+{
+	/* No support for double-clock modes */
+	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
+		return MODE_BAD;
+
+	unsigned int mpixelclk = mode->clock * 1000;
+
+	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
+		return MODE_CLOCK_LOW;
+
+	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
+		return MODE_CLOCK_HIGH;
+
+	if (hdmi->refclk) {
+		long refclk = clk_round_rate(hdmi->refclk, mpixelclk);
+		unsigned int max_tolerance = mpixelclk / 5000;
+
+		/* Vesa DMT standard mentions +/- 0.5% max tolerance */
+		if (abs(refclk - mpixelclk) > max_tolerance ||
+		    mpixelclk - refclk > max_tolerance)
+			return MODE_NOCLOCK;
+	}
+
+	return MODE_OK;
+}
+
 static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 				       struct drm_display_mode *mode,
 				       struct drm_display_mode *adj_mode)
@@ -602,7 +632,9 @@ static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
 					 const struct drm_display_mode *mode,
 					 struct drm_display_mode *adj_mode)
 {
-	return true;
+	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
+
+	return inno_hdmi_mode_valid(hdmi, adj_mode) == MODE_OK;
 }
 
 static int
@@ -659,7 +691,9 @@ static enum drm_mode_status
 inno_hdmi_connector_mode_valid(struct drm_connector *connector,
 			       struct drm_display_mode *mode)
 {
-	return MODE_OK;
+	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
+
+	return inno_hdmi_mode_valid(hdmi, mode);
 }
 
 static int
-- 
2.43.0

