Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75539811F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjLMTvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378934AbjLMTv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C544B9;
        Wed, 13 Dec 2023 11:51:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c2a444311so70962105e9.2;
        Wed, 13 Dec 2023 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497091; x=1703101891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrdwEALPZcYaKjrlHh8nC5j/rhRtGd0pBvTiQkbpRHQ=;
        b=E1ktWcc+Xiz5G+Vsu4Gj0o2zO9fm6fFeFAnsR04FFy8gg4QX9STKRCA2u5yd7l7+pS
         0BlsRxZG7GW9Q45gJM4Grxos9RnaP4kbMG9CKgOKgBT8AvUSfoALb5JhCOV0IWywd7PW
         UUw3fVE6EJdFJmiSn4jmoZpI7xoje4ZzLas5Ri6Q/9xIfbadENs2ZeqnYj/evfXZpXaY
         uMDwX+m8RF3kxomravf9aiS0JAdWNUJ+c/kLDNDKaIeGkkA7QY8fRSrIlG1B+fEDKjn4
         QunOZYEZSIbiPUFuWjx2Q6C9gBOks3K4acY4KhKTanYMyrF6ojxyB5qRJN05WBd7G1+1
         HWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497091; x=1703101891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrdwEALPZcYaKjrlHh8nC5j/rhRtGd0pBvTiQkbpRHQ=;
        b=EuJN/I6d4923Ac8jU7zpJB65bDwrDhhXW1snDRFrTG0Tl1a+T+ZxOWVcnYU6VEViiv
         Fanu/y2glRLfCPH4Ly7i/FfHF3CKspkffquvxHS4dBjrkqadmtCLstd0kQfa39Mp0IMT
         pJifWXpXs+QkgfJdGGkquufk9y0V4cTpuA94Mz+oYV870MKKSBSXvtAvPCcr9Oww5zWD
         YtM2f8X5RXN8VJVI68ehgqFLXGibzUhvy/2Q8hzkSrAX/WCxikHD4KjPm59d8Ztx+8BW
         WfTRwJfY8F7UF9i2U46cdsnplT3cGVWvYLStObRh3bf2HU7z5SFQ+PmXyXNnGdQ3s5zo
         Iagw==
X-Gm-Message-State: AOJu0YysUJklMwh/gr6ms3HiNwXQ+oE+FU2XzcufPDA5aUPevWW9a61n
        ZL527Zwe0ExoR654hx5TwQ==
X-Google-Smtp-Source: AGHT+IGQU5KA/JqpSqsrp3zI8GWSKHo4cXHdH/serdCAU99kJFKSeVc9Xpk0T5VW4UF/tn/PaiNWlw==
X-Received: by 2002:a05:600c:468d:b0:40c:3133:6efe with SMTP id p13-20020a05600c468d00b0040c31336efemr2320662wmo.358.1702497090968;
        Wed, 13 Dec 2023 11:51:30 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.30
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
Subject: [PATCH 06/11] drm/rockchip: inno_hdmi: Add RK3128 support
Date:   Wed, 13 Dec 2023 20:51:20 +0100
Message-ID: <20231213195125.212923-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variant requires the phy reference clock to be enabled before the
DDC block can work and the (initial) DDC bus frequency is calculated
based on the rate of this clock.
Besides the only difference is phy configuration which is required to make
the driver working for this variant as well.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 46 +++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 593b184bd0ad..f7f0bec725f9 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -63,6 +63,7 @@ struct inno_hdmi {
 
 	int irq;
 	struct clk *pclk;
+	struct clk *refclk;
 	void __iomem *regs;
 
 	struct drm_connector	connector;
@@ -85,6 +86,12 @@ static struct inno_hdmi_phy_config rk3036_hdmi_phy_configs[] = {
 	{ ~0UL,	     0x00, 0x00 }
 };
 
+static struct inno_hdmi_phy_config rk3128_hdmi_phy_configs[] = {
+	{ 74250000,  0x3f, 0xaa },
+	{ 165000000, 0x5f, 0xaa },
+	{ ~0UL,	     0x00, 0x00 }
+};
+
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
 {
 	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
@@ -930,6 +937,20 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	hdmi->refclk = devm_clk_get_optional(hdmi->dev, "ref");
+	if (IS_ERR(hdmi->refclk)) {
+		DRM_DEV_ERROR(hdmi->dev, "Unable to get HDMI reference clock\n");
+		ret = PTR_ERR(hdmi->refclk);
+		goto err_disable_pclk;
+	}
+
+	ret = clk_prepare_enable(hdmi->refclk);
+	if (ret) {
+		DRM_DEV_ERROR(hdmi->dev,
+			      "Cannot enable HDMI reference clock: %d\n", ret);
+		goto err_disable_pclk;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
@@ -946,12 +967,16 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	/*
-	 * When IP controller haven't configured to an accurate video
-	 * timing, then the TMDS clock source would be switched to
-	 * PCLK_HDMI, so we need to init the TMDS rate to PCLK rate,
-	 * and reconfigure the DDC clock.
+	 * When IP controller isn't configured to an accurate
+	 * video timing and there is no reference clock available,
+	 * then the TMDS clock source would be switched to PCLK_HDMI,
+	 * so we need to init the TMDS rate to PCLK rate, and
+	 * reconfigure the DDC clock.
 	 */
-	hdmi->tmds_rate = clk_get_rate(hdmi->pclk);
+	if (hdmi->refclk)
+		hdmi->tmds_rate = clk_get_rate(hdmi->refclk);
+	else
+		hdmi->tmds_rate = clk_get_rate(hdmi->pclk);
 	inno_hdmi_i2c_init(hdmi);
 
 	ret = inno_hdmi_register(drm, hdmi);
@@ -976,6 +1001,8 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 err_put_adapter:
 	i2c_put_adapter(hdmi->ddc);
 err_disable_clk:
+	clk_disable_unprepare(hdmi->refclk);
+err_disable_pclk:
 	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
@@ -989,6 +1016,7 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
 
 	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->refclk);
 	clk_disable_unprepare(hdmi->pclk);
 }
 
@@ -1012,10 +1040,18 @@ static const struct inno_hdmi_variant rk3036_inno_hdmi_variant = {
 	.default_phy_config = &rk3036_hdmi_phy_configs[1],
 };
 
+static const struct inno_hdmi_variant rk3128_inno_hdmi_variant = {
+	.phy_configs = rk3128_hdmi_phy_configs,
+	.default_phy_config = &rk3128_hdmi_phy_configs[1],
+};
+
 static const struct of_device_id inno_hdmi_dt_ids[] = {
 	{ .compatible = "rockchip,rk3036-inno-hdmi",
 	  .data = &rk3036_inno_hdmi_variant,
 	},
+	{ .compatible = "rockchip,rk3128-inno-hdmi",
+	  .data = &rk3128_inno_hdmi_variant,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, inno_hdmi_dt_ids);
-- 
2.43.0

