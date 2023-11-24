Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764FE7F7085
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjKXJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjKXJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:37 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197B19BA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b07ba599fso87694a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819442; x=1701424242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qor/r0zOqiLhFxmNXSJ8SXz2GN8hXhjmuYRNu5/p5mA=;
        b=ea5uCM+3ou4ir+Ngwk7j4rZ7QdLmyEkK6Up0tsfoodmiwO0iafDGx4NG8mUx7GKxKd
         JriBrp1rGobf0rd41GeR1VTkcQqhJNWFQnxJIbuMtIq22h9/JCnHrvo3NJzbneoYE0aZ
         RmB2COybHcc3D3ust658gBRF8n07HmZ0lVpMYDb/zPRMFNdvBzf41tzC+9O60Ns4dMYc
         ebRiPHp9igTq8fu5d0mAxNRomy3xpq24ofjYalSw4iyNCDqFdHzrOVWKCgG2klbPcJaH
         r/xNWt0Q7gJ2oleXrGWszeA2xffQlazHEQD6fAdEGhqAa5UgajK/WubhbTtKav9fsyAu
         iLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819442; x=1701424242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qor/r0zOqiLhFxmNXSJ8SXz2GN8hXhjmuYRNu5/p5mA=;
        b=IkCqRKo9IngSsaw4Jso0m8tiazV4FlgTxvJGuCXH8d0blSqCWHR0ERWzJ/9kRgdeSk
         HGHCk6P/dJrHynmlYqbaeN/1GrUhN3MgXQ8BkTKMmRwrr3ogROI/ZkzfgMpcJCM4JClf
         FZNQF50InzeJn/I52QyDWOLv5aHMCVho2F3P5FV2wlz0IRRMNS7dMkljT8qiRjkqaxz4
         CHWsdVdaC82D71ZZvwYat0SMngIxA9jhVMkXoJLIzqxmkajnWwNM7rafgh+n8QlEj1lT
         ILdfCl2YV/i2tdlHLJvdYnrAuyeH2/uJQnWWPrJgTchSZm6dsRUboVYiXr0518I1sa+8
         se/g==
X-Gm-Message-State: AOJu0YzfTluVTUxra6TEgeny/7FRdX9C+3bt+31UvVkEMhto1mpnRnU1
        o6tGT4OPijKJaVh7o829/TmodA==
X-Google-Smtp-Source: AGHT+IF1Omq/eaQPmVm8llzgDUE6BlQzXBZgCbk9ZF2AfikHHCfYcfIe725SN2hIJuRRWO0w5v03Xw==
X-Received: by 2002:a05:6402:1744:b0:54a:fcfd:224 with SMTP id v4-20020a056402174400b0054afcfd0224mr698023edx.17.1700819441954;
        Fri, 24 Nov 2023 01:50:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id g20-20020a50ee14000000b00548af940701sm1612755eds.53.2023.11.24.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:50:31 +0100
Message-Id: <20231124095031.58555-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124095031.58555-1-krzysztof.kozlowski@linaro.org>
References: <20231124095031.58555-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index de0a1f2af983..7d4c5324c61b 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -86,7 +86,7 @@ simple-audio-card,cpu {
 	sgtl5000_clk: sgtl5000-oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency  = <24576000>;
+		clock-frequency = <24576000>;
 	};
 
 	dc_12v: dc-12v-regulator {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index 8f399c4317bd..e3a839a12dc6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -38,7 +38,7 @@ button-recovery {
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 =<&leds_gpio>;
+		pinctrl-0 = <&leds_gpio>;
 
 		led-1 {
 			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

