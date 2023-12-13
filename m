Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AB811F73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442446AbjLMTwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjLMTvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EDF7;
        Wed, 13 Dec 2023 11:51:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso48745205e9.1;
        Wed, 13 Dec 2023 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497094; x=1703101894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26TYtvJWQfom93EELDFR0hGRGZIq8W0h3c/9XO+9E4k=;
        b=f0vLLl5YLW9yIv+iKGdbgoWAi08goS4047nQwtMVQ9RVrIJI+xDhxN3N/RlF68Mjj1
         wVAfdwauwy6XRMrN/Bd5RKmlom6B3VX6oThO2HgCSY6FuWQJ3P5Fe4T3kmTNYHbVhY1/
         yw/J3aFzuXHAwmhPR48KXE79oDqF5X+bjKYDma5E14tmNUfC/jh8+yUgaNN1/HODgq7W
         k0wOmNveBWI1xnaimiWkOiEFYoTJXSBWbU5sQE9+mkpwaYcgfAlvw8v9Wh9M8BbAdV3H
         WrGBMcBFyjC3IDYU6B/aq1xEx4QfcrQl5e+ug/u/HrqYgxNvXMI9s6zgUTG+jB5GxxWs
         GV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497094; x=1703101894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26TYtvJWQfom93EELDFR0hGRGZIq8W0h3c/9XO+9E4k=;
        b=E4nAqH3DxuZoX+v4dnd27819VN5etTGqljNuSFtplJkce+HU17eLlmYq9Csm60D30y
         Lj1V2vQZSWKnhb6y96VGv4gr/98yGF4tv4rsVfYevqouuGDx+sPk7bsCzyC5cxVOpFLG
         m/FJIUizxwSWqFx2m/zer0QU4W9evLH1fVFfd07lmWHH1oSp7A8pkNzRMGwwMphEeeQp
         wqMsT3QaCXpDakOS3mofh/lrW9ZT9b2K01GXZVKNLN9x5DZCHArWVUFydPTO6SfQfmuV
         rooV23p4DlvOyrXHcsDhhqSJgdy0WqM6lDw3L/CnsFJwVF4R6VzdsW2TwumynrQW0nLN
         lBVg==
X-Gm-Message-State: AOJu0YzEJaE4eYuIWJ3o9i3gziFQ+HaFhuX1zQnbt2x0ZuxdgesGexYr
        mNAgjQBnJxKgmo52CcGYwg==
X-Google-Smtp-Source: AGHT+IHGKyN60yuyPA3ry6yA1Jw305WgBGta1msCkC8kPAxdLBAYlT9Ne9SbYyRVW+lhrit0x6CTYw==
X-Received: by 2002:a7b:c84b:0:b0:40c:3820:efeb with SMTP id c11-20020a7bc84b000000b0040c3820efebmr4553357wml.196.1702497094178;
        Wed, 13 Dec 2023 11:51:34 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:33 -0800 (PST)
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
Subject: [PATCH 11/11] ARM: dts: rockchip: Enable HDMI output for XPI-3128
Date:   Wed, 13 Dec 2023 20:51:25 +0100
Message-ID: <20231213195125.212923-12-knaerzche@gmail.com>
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

Add an hdmi-connector node and enable the hdmi, display-subsystem and vop
nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 03a97881519a..21c1678f4e91 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -47,6 +47,17 @@ dc_5v: dc-5v-regulator {
 		regulator-boot-on;
 	};
 
+	hdmi-connnector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
+
 	/*
 	 * This is a vbus-supply, which also supplies the GL852G usb hub,
 	 * thus has to be always-on
@@ -239,6 +250,10 @@ &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
 
+&display_subsystem {
+	status = "okay";
+};
+
 &emmc {
 	bus-width = <8>;
 	vmmc-supply = <&vcc_io>;
@@ -328,6 +343,16 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_connector_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -423,3 +448,7 @@ &usb2phy_host {
 &usb2phy_otg {
 	status = "okay";
 };
+
+&vop {
+	status = "okay";
+};
-- 
2.43.0

