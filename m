Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466178CB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjH2RT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbjH2RS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3980ECD3;
        Tue, 29 Aug 2023 10:18:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso601822666b.1;
        Tue, 29 Aug 2023 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329473; x=1693934273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS+cPFrn5V/oSL99Q2BbWTKIW7SUu4ItJIJ2pH0oI9I=;
        b=aSD4wG+1ZRnljM4CSIseFFCuF2Tv5IT8Wosx2+GepQr8oGYlYInqGm4jF10OVnDP0L
         BZIXogAsXeoecVaZXYJFSl9ArISaPcBdoOdP4jX1SDAxCtLv80kdnqgfxqejZkeVK8Dr
         1qSbdG5PVML8gIAK2mtsZlsFS3Ege/Q3pT+HLIPFg5AKuk49iKFo/GrUvhJ3w/rJ3vlb
         Tuh6inFRswC+h53iRgRJPjrJBeB7t+T3ZE6ijXz9T3eyepS6VUDenDiDDy0ImCUkwaN0
         8NEopfwb0O7l/QZ5RY84W3ft6aPTskb0Vl5+uIVtchApO7uOjs/JBm8Gs9uexal5+0xq
         TWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329473; x=1693934273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dS+cPFrn5V/oSL99Q2BbWTKIW7SUu4ItJIJ2pH0oI9I=;
        b=MNvW2/7epu2hV3VRzX592yzdBV79ADc//KQoLb3IrVZ0iNdT3fBIPuN9M2O5YgiCuQ
         hyZ38gIumB0pPjjj9TNzoEw2s1Oj6Kj9o8aEeqvBbQ+pzW9D5FNxN4ioABA5eqkgimkO
         I2Lduoi92vmc9Pe5I6+LmT2oSfkB1HppuRF7VqD5jqQMTewiglDVawB/oGx2MJqEstaz
         UTLGld8Em7uHTtH43Rf3UjDqBHC6BGfk5HNvAHrSHkyDF3V6vrYLT/rfdXF4w1JuSu0v
         X0azb2q5/zCp3+oDo/5gnxyBnIOr0TTGB9GWNuxzM+1kxEbM0EIqpz4Tea0W5Sa9GbON
         k42Q==
X-Gm-Message-State: AOJu0YwcdmIoPShI0H6HBnx3VD2/spjOTkE1xOOqul3OVW1/Gk8rLJgF
        N4WTYrkD0wRPHNnvJiVp6A==
X-Google-Smtp-Source: AGHT+IGcrzem3XmHh2sQJCxUgf3Dq9aCyWk4H3R61SzzGzQKcWYq2aZscEw/gTmdQ+TjCJfx6SK5jg==
X-Received: by 2002:a17:906:3018:b0:99c:ad52:b00 with SMTP id 24-20020a170906301800b0099cad520b00mr20752169ejz.6.1693329473271;
        Tue, 29 Aug 2023 10:17:53 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:52 -0700 (PDT)
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
Subject: [PATCH 29/31] ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK312x
Date:   Tue, 29 Aug 2023 19:16:45 +0200
Message-ID: <20230829171647.187787-30-knaerzche@gmail.com>
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

Without setting the parent for SCLK_USB480M the clock will use xin24m as
it's default parent. While this is generally not an issue for the usb
blocks to work, but the clock driver will "think" it runs at 24 MHz.
That becomes an issue for RK312x since SCLK_USB480M can be a parent for
other HW blocks (users of mux_pll_src_5plls_p) but they never will choose
this clock as their parent, because it runs at OSC frequency.

This sets usb480m_phy as SCLK_USB480M's parent, which now runs and outputs
the expected frequency of 480 MHz and the other blocks can choose
SCLK_USB480M as their parent if needed.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index b13957d55500..19bd6448d122 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -293,6 +293,8 @@ usb_host_ehci: usb@101c0000 {
 		reg = <0x101c0000 0x20000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST2>;
+		assigned-clocks = <&cru SCLK_USB480M>;
+		assigned-clock-parents = <&usb2phy>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -303,6 +305,8 @@ usb_host_ohci: usb@101e0000 {
 		reg = <0x101e0000 0x20000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST2>;
+		assigned-clocks = <&cru SCLK_USB480M>;
+		assigned-clock-parents = <&usb2phy>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.42.0

