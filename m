Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7903978CAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbjH2RTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjH2RSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF6CF2;
        Tue, 29 Aug 2023 10:17:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso70769221fa.1;
        Tue, 29 Aug 2023 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329462; x=1693934262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feXb8mBBSxHC2Wg38x6bXprPMxa/iS7sxw36h6E5GW8=;
        b=h4PyqX0xtB7S2T6VFiGduqml3wx0qswAzQccLxwPFbM0Qk7fnZ8sK0BmODYagHvSJg
         dN0Gkz34UcQ5dALUAS7qkreaFpaJH1/HqwEkvHL6nhuwbhwsUlvgNhtu0JWR/t+byarI
         jO/zOGwOmY8ILY7Yn5zt8RSPxT4JW03j5Tykw5RFZbIchdbUVag5NZphZtJVw8SKgyXA
         StVAmKygz3dt8cdzSI8lWcVBevQXPpttS6lu7dJtB3bq4a2IVYMqqSDw4EMZGzaYGz8o
         MWk29pok/xzUj/XYqYYzaN6bwBumz3ddYzcgcpDsm6KdIhLN5lyBSD70ZFbaayj7BLKq
         o/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329462; x=1693934262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feXb8mBBSxHC2Wg38x6bXprPMxa/iS7sxw36h6E5GW8=;
        b=hQeaSNbk+lRMH4oenE8jHp+vWQJFowBlQwOrh8OJpl5VRhZi5CwvweJS/++IEh3dov
         A06TVAXIMHoHZ/Fg2m0f675P55kGRgHMKQCFlyeKdZc62ZagFriuSc5NpgNz0DgEavNS
         Tyngzpf4rJbVVt5hOz8zstMbiebURLZq3id705Y/C3eXGL9l4ZXHD7wBnm3jGvbY4W/e
         LGVPQgVW7g86b0tuAWdMP8Bmfm9wZoYnHpiS/gRHwaqm/iOEcu0AjkDOQ6u8bKSGhQQf
         rkZzrKTcvMopGWU6Sb1P85j2Ry7lMlXEXoJl0LVf5XEnMzUyVu+gi/yjom+gHEeJt2ri
         1TWQ==
X-Gm-Message-State: AOJu0YwjLrTwHRkowFK8rt3VkTUo8A4IBc9Jhc1Jdi0FRshgc3J8Tho/
        1Og/BIwNOfwzOo318VRisw==
X-Google-Smtp-Source: AGHT+IGy6ebumFaH6aO1ynQk+aNb6IThAySOcLcWyoeDCRfh26m8xsK1Szz112EbWkaHyFlntA3M6Q==
X-Received: by 2002:a2e:9cd8:0:b0:2bb:bdf0:caf2 with SMTP id g24-20020a2e9cd8000000b002bbbdf0caf2mr20698676ljj.25.1693329462298;
        Tue, 29 Aug 2023 10:17:42 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:41 -0700 (PDT)
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
Subject: [PATCH 18/31] ARM: dts: rockchip: Enable SMP bringup for RK312x
Date:   Tue, 29 Aug 2023 19:16:34 +0200
Message-ID: <20230829171647.187787-19-knaerzche@gmail.com>
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

For bringup of the non-boot cpu cores the enable-method for RK3036 can be
re-used.

This adds a (small) chunk  of SRAM for execution of the SMP trampoline code
and the respective enable-method property to the cpus.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index b195ac525c37..08b953b005ff 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -27,6 +27,7 @@ arm-pmu {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "rockchip,rk3036-smp";
 
 		cpu0: cpu@f00 {
 			device_type = "cpu";
@@ -87,6 +88,11 @@ imem: sram@10080000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0x10080000 0x2000>;
+
+		smp-sram@0 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x00 0x10>;
+		};
 	};
 
 	pmu: syscon@100a0000 {
-- 
2.42.0

