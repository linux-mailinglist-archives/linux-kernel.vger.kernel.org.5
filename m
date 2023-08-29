Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15F78CDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbjH2Ujh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbjH2UjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:39:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C01BB;
        Tue, 29 Aug 2023 13:39:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so6354479a12.3;
        Tue, 29 Aug 2023 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341561; x=1693946361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/S078uVn7am6W43PcbwitpWSJn3a9dUt4aJRXNiiV8=;
        b=qCv7/JiFsWP9GL4LlPjBs31n5LWTcm5kr2RKXQlXDV1rF3Vd88u/xxVFTDbzZoQPOg
         SEJ1v7uG0AX4d0sSjGgZiTjGnMfN1qVwM5BvUbhEFCOWQTNGNecXPbq92JSZPe/XIBF+
         JfViVTM4DdQFkETXh2rt1h6dvHJZWnzBwPmm0BGtryRJ09YjZ1f4DBovSxbMDJChglGs
         yefU8f+deS6AfWkTuY8V+WEUkwMeIeR0aR8tiPFQPUui9t9WdV/O7716nmid2G32BeNq
         gyb+gEE9bUrgIm+Dw/KAg0xy5zfw0CoUwakJoGoML9gbZZ1urjFVc2VrW7JN0BBj2h1m
         lJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341561; x=1693946361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/S078uVn7am6W43PcbwitpWSJn3a9dUt4aJRXNiiV8=;
        b=GZbXX/+YeoapV8XdEfL35b+/Ih1owrMlVNhC2z2M3RnajJo5vL91GaCsVvScZWYPH9
         LjDmWet4n7seHFa67ZmIau41lN40wLPwrsXcg+m2sjOASuvIiRtT/TSHkbweJ5g53wUg
         aaiXoA1VAa7WdCd1pt8et49DB4vuqFNxg0x3MbMWsZvDzV3YlqmeuJhF4zA3BemQt2Bw
         g0sVkOnBjXbLnD9Iupqqs0mloKgGYO5Kp8ReirRpAYFUW7WiHiiVtu0b0DkrwTDHbqv0
         38ISFcZ5xsogH8188/ZkhzzaVnyBNUqOi1v8WXzWn/Sl4Mwi1G+FeZl2W7ylwP/MOwco
         3FAA==
X-Gm-Message-State: AOJu0YwU6OvtvyWDZKOY8bO2zi4y4fqEqpsIUy7VzsVa9ddRbCea9nsH
        4YGdXpJ9OXLe6vJPbLh2pA==
X-Google-Smtp-Source: AGHT+IH0JPsXYQ46Kp00OCfZE6ki6jFotggl9aujrYzmo9vKs9nW7bi7ETeXiVcS8/E2zZTgTVWerA==
X-Received: by 2002:a17:907:7758:b0:992:3897:1985 with SMTP id kx24-20020a170907775800b0099238971985mr87579ejc.43.1693341560769;
        Tue, 29 Aug 2023 13:39:20 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:39:20 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/5] ARM: dts: rockchip: Fix timer clocks for RK3128
Date:   Tue, 29 Aug 2023 22:37:27 +0200
Message-ID: <20230829203721.281455-12-knaerzche@gmail.com>
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

Currently the Rockchip timer source clocks are set to xin24 for no obvious
reason and the actual timer clocks (SCLK_TIMER*) will get disabled during
boot process as the have no user. That will make the SoC stuck as no timer
source exists.

Fixes: a0201bff6259 ("ARM: dts: rockchip: add rk3128 soc dtsi")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 9125bf22e971..88a4b0d6d928 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -234,7 +234,7 @@ timer0: timer@20044000 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044000 0x20>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER0>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -242,7 +242,7 @@ timer1: timer@20044020 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044020 0x20>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER1>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -250,7 +250,7 @@ timer2: timer@20044040 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044040 0x20>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER2>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -258,7 +258,7 @@ timer3: timer@20044060 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044060 0x20>;
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER3>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -266,7 +266,7 @@ timer4: timer@20044080 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x20044080 0x20>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER4>;
 		clock-names = "pclk", "timer";
 	};
 
@@ -274,7 +274,7 @@ timer5: timer@200440a0 {
 		compatible = "rockchip,rk3128-timer", "rockchip,rk3288-timer";
 		reg = <0x200440a0 0x20>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru PCLK_TIMER>, <&xin24m>;
+		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER5>;
 		clock-names = "pclk", "timer";
 	};
 
-- 
2.42.0

