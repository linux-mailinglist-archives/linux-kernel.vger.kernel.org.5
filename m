Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5A78CB07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjH2RTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjH2RSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34DE6A;
        Tue, 29 Aug 2023 10:18:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98377c5d53eso602414466b.0;
        Tue, 29 Aug 2023 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329468; x=1693934268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxQ4tL3N96YVekC9Q3F0L/yW2/LZMHRKh1BzDPVBfDY=;
        b=W/Ba6mCAi3EsvONs3oStI9qe3lO+rjKO8eqd6OeC8WOC74KB45sAbS9gwOsR0+B1ZB
         PwL13BHOhzqel1D0V2oej1RVUSQf5DoDYJYciJbLHJvwSoNC+cFkvwhDSfHRmcPMZII1
         neyUEn6Ja2qOg4YUvTVZ7Qm5OnlDoGd4gaQoZ9OeHUAkmF3iXPTA0HVdbNjvlrlGBGtR
         5eNVr3wvN+laOQRMTLthwwYCoQMvNZkMJW65SUwC9uk1SqiX2ZbtwK00+7SLfSJmr8hY
         cUiUL63YWqF2ZNiaqWzuoT8C5DWWgLL5LEenq3unErWmHO6zR0MxN11SwAIWSEILorFr
         OfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329468; x=1693934268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxQ4tL3N96YVekC9Q3F0L/yW2/LZMHRKh1BzDPVBfDY=;
        b=SfRyNDXVCOJIQDWfO6fjbWY0nIYU8Fe0l3ovm2P97cO3HsGQUfTfT94r2wb7zI8ftQ
         WbWT8pQJqlqBEv2O2V44TpbCPlzakbFZs+1MTjGfssqxslYsHVD1CF6fBezeQyrAPuE7
         vQHTO4uVidMiRRypIRdi512bVRq2vc2AHBnkvSAFUV5RUMxuASkiUTtGeON4v9Yo3RkJ
         5FOYFo3yXGOH8SN3V95CeYT0ErV9Wvjs8e4w1R24YsDnp8L10mqMD0Bmgss059OAnZjD
         T2vMXiyiMfAIKv8hII7Yfa/trLP+t0EnjJwlba6oP4HjOwX6mXtaX/XpJWHjv/dx0vvV
         07iQ==
X-Gm-Message-State: AOJu0YxTJIOsCWH2Or9ngTB+mgTTOgquehVdOg25tc8k8oGrAIINRiSG
        pe2say/GZWHfBKM2CUQFDA==
X-Google-Smtp-Source: AGHT+IEP+Kiln5uLUvH0vUDxEPIVhi+RtKwR8SCN3T7Y1jAiZqj1OOnREaOOEVkkHwHkpcNqHLAI6A==
X-Received: by 2002:a17:906:18c:b0:9a2:1e03:1571 with SMTP id 12-20020a170906018c00b009a21e031571mr12264491ejb.15.1693329468081;
        Tue, 29 Aug 2023 10:17:48 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 24/31] ARM: dts: rockchip: Add 8-channel I2S for RK3128
Date:   Tue, 29 Aug 2023 19:16:40 +0200
Message-ID: <20230829171647.187787-25-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3128 has a second I2S block with 8 playback channels.
It's internally hard-wired to the HDMI-TX, thus only usable with it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 4c5c9728179e..2339232ae2d7 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -7,6 +7,20 @@
 / {
 	compatible = "rockchip,rk3128";
 
+	i2s_8ch: i2s@10200000 {
+		compatible = "rockchip,rk3128-i2s", "rockchip,rk3066-i2s";
+		reg = <0x10200000 0x1000>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S_8CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&pdma 14>, <&pdma 15>;
+		dma-names = "tx", "rx";
+		rockchip,playback-channels = <8>;
+		rockchip,capture-channels = <2>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2c3: i2c@2005e000 {
 		compatible = "rockchip,rk3128-i2c", "rockchip,rk3288-i2c";
 		reg = <0x2005e000 0x1000>;
-- 
2.42.0

