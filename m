Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8911C78CDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbjH2UkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbjH2Ujt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:39:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A41BC;
        Tue, 29 Aug 2023 13:39:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1f6f3884so609414666b.0;
        Tue, 29 Aug 2023 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341585; x=1693946385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sorglNdzyV/pWO7YMPt4RJRiShdjAUubPesOLMeqaVk=;
        b=ScuSVOHA6ravgEoRv4p3uHrGtMGXKcgVAKZE3VsYDqgh23mrvDhaMRcngDcJ7N789o
         fYnDysJSvltkGLyp//ayxSn4cpcu/40F8UWjRr2OALFcmeUetnesON9K4n8qUXFnlWkI
         siutFLEzhdKiAy+82hjKIVAn7qoMasim3qCZwKL9nwho8tkHKiUnk/0invOtUdnVBXzT
         aqprdQ5cL8Mdsb6NSwS0jS/UYGpL1chdML+1S+xs6/WnGfH4BZG9bRSV7OOpWMwcmHmn
         rw9jjNDO2EDnNVtxh+AB0HcuE0GQnyVge2kp60+rax0odl688estv1JxP53WWbMRzdZx
         6EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341585; x=1693946385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sorglNdzyV/pWO7YMPt4RJRiShdjAUubPesOLMeqaVk=;
        b=IHRSjKblKLeJzCAbgDutbfHX/rVD4llbSH/iLxSFD2ehXIp+OK7RMTEfOXx3260vRZ
         71T7eHlQm6oFcCuzYG6bkQD2ozCviZxA5+gQVjJOkEJ05oV653J5b2Weg8EX8UvKwuhf
         S7IhRlFss9FuWh9QshVA/4jNgtqsTIUA45rqwPPPtEceLA7x6Ev6tjdBR3c0pkBlrVAx
         mjAV1D0v/15a+yDTdyuLdUM5lVPP5n2KgWX+m4RYcPm2UnmUK5zUP70Ue/bisobNUIz8
         46mYi65qOiytx40Ng+k86ePfmfektz/5VxzD8pwq6jl1314jHlNArzFg5+SmdT5igt+f
         ArxQ==
X-Gm-Message-State: AOJu0YywHM0Gu/Apu+5ez4NMltZ1OTmzATF23fY1V3jqQ6R8Lqx4t6a5
        PNFBx+CJb01qkwLBXGUmeA==
X-Google-Smtp-Source: AGHT+IH31n7PDUa4uJw+PjCrd2GZUoofcWejfASdpqTgb8iHtMdCv2N8O7FuhMI55faF2RTxe1Mbuw==
X-Received: by 2002:a17:906:cc5e:b0:9a1:c42e:5e5e with SMTP id mm30-20020a170906cc5e00b009a1c42e5e5emr96025ejb.42.1693341584582;
        Tue, 29 Aug 2023 13:39:44 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:39:44 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 5/5] ARM: dts: rockchip: Disable non-required timers for RK3128
Date:   Tue, 29 Aug 2023 22:37:29 +0200
Message-ID: <20230829203721.281455-14-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829203721.281455-4-knaerzche@gmail.com>
References: <20230829203721.281455-4-knaerzche@gmail.com>
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

The Rockchip timer linux driver can handle a maximum of 2 timers and will
get confused if more of them exist.
RK3128 only needs timer0, timer1 and timer5. The latter is the source
for the arm-timer and it's clock is prevented from being disabled in the
clock driver so it can get disabled in the device tree, too.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 88a4b0d6d928..f3f0788195d2 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -252,6 +252,7 @@ timer2: timer@20044040 {
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER2>;
 		clock-names = "pclk", "timer";
+		status = "disabled";
 	};
 
 	timer3: timer@20044060 {
@@ -260,6 +261,7 @@ timer3: timer@20044060 {
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER3>;
 		clock-names = "pclk", "timer";
+		status = "disabled";
 	};
 
 	timer4: timer@20044080 {
@@ -268,6 +270,7 @@ timer4: timer@20044080 {
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER4>;
 		clock-names = "pclk", "timer";
+		status = "disabled";
 	};
 
 	timer5: timer@200440a0 {
@@ -276,6 +279,7 @@ timer5: timer@200440a0 {
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER5>;
 		clock-names = "pclk", "timer";
+		status = "disabled";
 	};
 
 	watchdog: watchdog@2004c000 {
-- 
2.42.0

