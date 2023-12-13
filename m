Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468AC811F60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjLMTv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjLMTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D61B7;
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so51156695e9.0;
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497088; x=1703101888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrtW0qmKYRNQLQV31syGJ5EsohgiI927CfneGFLgIjg=;
        b=Mrd6M3PtKXTd0ng8eiCEMBUxMQUmPVZ/y8nUgKWJenZd2PzXe4LYGK8S9HyKnwF8pR
         c6kUp3E3iUtCd6NqpAE4jUNJ/cZ7xy3SRj31sheg3T9LERQhNW6DAjeayk3YOYjaxA21
         Yr+GzmSupmRMyVcXUmac0GqPn0dByfgTvgJdH2ycBoS0J+sc1J+YJVucnX5hw9Zc69iD
         fvf2BA8ss3KlNZ9ZjcwRf7r+E+3SNq/ffY+dCyv7QhqYI5OAF5d2QCRW6JCO3xaOzKon
         tq46AQQq4QRfVHy8av5gV0whXaF4QCA95xywVVIg9uPcSJXPyAEDnd8RJohn23jx9EtG
         Y6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497088; x=1703101888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrtW0qmKYRNQLQV31syGJ5EsohgiI927CfneGFLgIjg=;
        b=jCJZmMN4QUBrFPfasECXaY3pA8l8RF8h6xxjk6tDbxhfMSGFp4k1CwUYSO01TvsUYQ
         opv+Sm6v2NWNv6U6he8V/eAS9a7Dhm3MvOFz+zLizGAhoVaRokGS3LsT/D8EXi7tOdnW
         Rhy+7MOHuihRpXyAjOez85Z9dzcUrTsrUC0/mq8r++4tQXe3sVs5ZywPzDYjvi32vdO4
         EfqqDQggTMC8GtbnsoNsZMCAPCLNmfL/rMYkXPEj1ADjCApFN93dNEc4tWHzaqf5DLvW
         k+yz0P/qrjd10qAP6KyWg0dPvXf+HlFHzhInZkdWSl+FVm+iNkxp3fOh3WYcyKq4SIkS
         bPVQ==
X-Gm-Message-State: AOJu0YyuaGtbw0VKjOqEpnXJ8pkxtBQs61PYctSIBm8xgSjEdHs7xVkD
        RMI3hVOlELLH8cAXaRL5nQ==
X-Google-Smtp-Source: AGHT+IHR1mhbvtfmEHVnytGHmx53+I43r/Hf1Na5JA56piJCh0CXRoRhmTkjC+PLrRTxjaxT4a38fQ==
X-Received: by 2002:a05:600c:3b29:b0:40c:3290:7b80 with SMTP id m41-20020a05600c3b2900b0040c32907b80mr4610268wms.138.1702497088224;
        Wed, 13 Dec 2023 11:51:28 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:27 -0800 (PST)
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
Subject: [PATCH 02/11] drm/rockchip: vop: Add output selection registers for RK312x
Date:   Wed, 13 Dec 2023 20:51:16 +0100
Message-ID: <20231213195125.212923-3-knaerzche@gmail.com>
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

In contrast to RK3036, RK312x SoCs have multiple output channels such as
RGB (i.e. LVDS TTL), LVDS, DSI and HDMI.

In order to support that, this adds a new vop_output struct for rk3126_vop
with the registers required to enable the appropriate output and setup the
correct polarity.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 13 ++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  3 +++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index c51ca82320cb..b9ee02061d5b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -227,11 +227,22 @@ static const struct vop_win_data rk3126_vop_win_data[] = {
 	  .type = DRM_PLANE_TYPE_CURSOR },
 };
 
+static const struct vop_output rk3126_output = {
+	.pin_pol = VOP_REG(RK3036_DSP_CTRL0, 0xf, 4),
+	.hdmi_pin_pol = VOP_REG(RK3126_INT_SCALER, 0x7, 4),
+	.hdmi_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 22),
+	.hdmi_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 23),
+	.rgb_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 24),
+	.rgb_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 25),
+	.mipi_en = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 28),
+	.mipi_dclk_pol = VOP_REG(RK3036_AXI_BUS_CTRL, 0x1, 29),
+};
+
 static const struct vop_data rk3126_vop = {
 	.intr = &rk3036_intr,
 	.common = &rk3036_common,
 	.modeset = &rk3036_modeset,
-	.output = &rk3036_output,
+	.output = &rk3126_output,
 	.win = rk3126_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3126_vop_win_data),
 	.max_output = { 1920, 1080 },
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index 406e981c75bd..fbf1bcc68625 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -872,6 +872,9 @@
 /* rk3036 register definition end */
 
 /* rk3126 register definition */
+#define RK3126_INT_SCALER		0x0c
+
+/* win1 register */
 #define RK3126_WIN1_MST			0x4c
 #define RK3126_WIN1_DSP_INFO		0x50
 #define RK3126_WIN1_DSP_ST		0x54
-- 
2.43.0

