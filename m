Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB178CAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjH2RS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbjH2RSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49962CEA;
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so2562166b.0;
        Tue, 29 Aug 2023 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329458; x=1693934258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPphieGb8xL4eR5mTMzLTUQW79Ts5+jV8h+GajjCpv8=;
        b=dicmkfBsk+tFeRQT4u4wgbcqy092CU3pw2DfTN0XnlBc+B1QpF3wGX3MTAP5G8+6aQ
         kNKigeS7HOumT4S5/HKEuOJtNhWxKA2gIl2CXuN7gbr/RTJHFUuH0RmU254IjeLb9LJz
         olF99rEHc4ufJtFApdSpuNagqis1gVCDNh7SjBUIkl1ArUs/LwHRwrp9coMYbBSnsZWc
         aFN4UjxCgfs97MU9hyOrNaDFeuJgkBBa0bGFU3OSU1U2zv1thSaTuzOxLgCxcBgoTi01
         E2FtkoMkZiGQeEybiyVJPM4hG+GoeObC6gY86cFEXA7gYLXuK0/Eb85wwcBx4uVj53yy
         qr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329458; x=1693934258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPphieGb8xL4eR5mTMzLTUQW79Ts5+jV8h+GajjCpv8=;
        b=C4ItigqKv0xaiH+MwEFjS6kRXDZ3DNcDuqBg3lEyBHZ1zq9jTulIYwVlJ0FbMHuR33
         1YcEwP94dOqkBlo9cWRZ0yHOJqpLXycXlbh0ZbmmX0rpNPM/XpY9+wj9nfeyKKLPlIpy
         RJXcj0jMqXJaw9t6G5SWpHiRPUrFhBtgiY3s+BEVmMTO4UuUPwx7N6qd0gSFUwVXhtfK
         v2eYgG4ibfGnP5sOK8UMY27GyAONT4pF4+lHK0c1h1sUayVXwEvv7zN3JkgfkJTWr085
         ZXU2gktqR4+xCxOptqzwbCfcgUd+uWjKBuiIEsLR6uLaRHByRZqps/pMKsszdkO4nB3K
         zVGA==
X-Gm-Message-State: AOJu0Yzl3WI0Vs8KFshztnYIVHiJYWxZqRoptVqY57O0zeugfySo2GGF
        mY22vHYzFdQz064mjmD3cQ==
X-Google-Smtp-Source: AGHT+IGSTrK9d7vStZC0bzy2T16uTrrd34R83QYESq2KKcyDTtiuTq+EZyCdPP7zwxTKL8JMYzopcA==
X-Received: by 2002:a17:907:d1e:b0:9a5:b247:3ab with SMTP id gn30-20020a1709070d1e00b009a5b24703abmr3596972ejc.19.1693329458114;
        Tue, 29 Aug 2023 10:17:38 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:37 -0700 (PDT)
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
Subject: [PATCH 14/31] ARM: dts: rockchip: Disable non-required timers for RK3128
Date:   Tue, 29 Aug 2023 19:16:30 +0200
Message-ID: <20230829171647.187787-15-knaerzche@gmail.com>
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

The Rockchip timer linux driver can handle a maximum of 2 timers and will
get confused if more of them exist.
RK3128 only needs timer0, timer1 and timer5. The latter is the source
for the arm-timer and its clock is prevented from being disabled in the
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

