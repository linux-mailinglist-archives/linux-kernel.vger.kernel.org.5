Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DCF78CB04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjH2RTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbjH2RSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78011B3;
        Tue, 29 Aug 2023 10:18:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso987307166b.1;
        Tue, 29 Aug 2023 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329470; x=1693934270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCJom29YNAbeZrXkmUSy8bqZVMtySFQVpTmPU7p9fpw=;
        b=BwZxCj4tycBA0cAASNX2rKlNNQ4F85+7OzyOYRgBDcR/r1Rxn3+MRs1cYfJAT1Zw8s
         qzWAc5yCqfuc0FTy+vR8EoxzaVsKwcdFu1OVG8l0nfbEo5kI8FY9U/Yuay5+reM0eeID
         AW9tlmAaDtkLRRcZ+ES8GvOMi5e9uryVYwybOK20XtSY1pFWthL4sX9RAosS4UFFtvRi
         vcSn6VZlfeLJC137N6nXbPmyzbnaRfN2F4CT5bn9HnubxuG3JSvNVW5zEK4VZhV+QNrD
         urnjeTvh5oCBWV8gIrgJ8Ad4xqk5gFbUI+NxC92NqJda/xBtAHf5rIg4y55fDg/WwoTo
         Pb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329470; x=1693934270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCJom29YNAbeZrXkmUSy8bqZVMtySFQVpTmPU7p9fpw=;
        b=X/ZJMDFxoGckdqou8sFjRooBtHKFPTkhilHKA9lsEMG+yA13hDq2VZpeQT5xWCfLJl
         bWwDf9QdSbYhB4X+F4ePZl4aS0EVoe2cZTZzDtq1yVnGzqjFz23aXVAG5anyJYm8Acgp
         oGawwVnPDK61SrToooBiMRnYYl6Ad1k2UVU3gTNqavuOjH37IwCBDzYYPoapm6z/twNv
         UNMZ1Nxi1k4q4d3pupD8CvbkSMgfIxcXJRTLKEYCN0EBGqs85lzCBBgl0JdKoJalQaKx
         nctch/2YQHMVEW4dAk4yhZ2eEQWUXKG5fjUxt30yCuELn+dusydRhxIbMgwIhAxHlQQz
         oRZg==
X-Gm-Message-State: AOJu0YysSdNfZogF9IPsf8nwE8sRvNOeAavWD+n6meHUhqufHppGLQ/r
        XUGu2t3fbZFKrjrNGXu3Vg==
X-Google-Smtp-Source: AGHT+IE5VAqTYu0TpR/gEgBTX4rVF0ZLvuyk9o8kotWD9Y3byxkS/tgqtwzcFS28p1DgLC1+EPXD9Q==
X-Received: by 2002:a17:906:11e:b0:9a5:a543:2744 with SMTP id 30-20020a170906011e00b009a5a5432744mr4088667eje.33.1693329469971;
        Tue, 29 Aug 2023 10:17:49 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:49 -0700 (PDT)
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
Subject: [PATCH 26/31] ARM: dts: rockchip: Add gmac for RK3128
Date:   Tue, 29 Aug 2023 19:16:42 +0200
Message-ID: <20230829171647.187787-27-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gmac node for RK3128 SoC.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 874c97297c63..54a2768153c0 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -63,6 +63,32 @@ uart0: serial@20060000 {
 		reg-shift = <2>;
 		status = "disabled";
 	};
+
+	gmac: ethernet@2008c000 {
+		compatible = "rockchip,rk3128-gmac";
+		reg = <0x2008c000 0x4000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
+		clocks = <&cru SCLK_MAC>,
+			 <&cru SCLK_MAC_RX>, <&cru SCLK_MAC_TX>,
+			 <&cru SCLK_MAC_REF>, <&cru SCLK_MAC_REFOUT>,
+			 <&cru ACLK_GMAC>, <&cru PCLK_GMAC>;
+		clock-names = "stmmaceth",
+			      "mac_clk_rx", "mac_clk_tx",
+			      "clk_mac_ref", "clk_mac_refout",
+			      "aclk_mac", "pclk_mac";
+		resets = <&cru SRST_GMAC>;
+		reset-names = "stmmaceth";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		mdio: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+	};
 };
 
 &cru {
-- 
2.42.0

