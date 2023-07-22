Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBBA75DE7B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGVUUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVUUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:20:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D989E58
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:20:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-316eabffaa6so2228838f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690057244; x=1690662044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqgsDoxp+a0ulkkTMnYutRgTki2aDg/PYW80rkVVPp8=;
        b=kYZne3f9yGRgh6iPxanTdnhcjLJm2mlrZslm1lNk8kQmuV2BBbGujayti+IPSxQ8OX
         JPWq6WIGuSfOlZS0iNpb1PWMJ/4sKGSHVt63UEfoN5633s0LU1FlFlCLlpPdE/GsjnIu
         9EjVJY3hgmRiGMWNABQfG+dvUF/WpEI6/ugsG1mCFPiqjDo6eprxME1Y/ZFcW6U7VP2b
         +rJYg3CXgGkJpzrGlJCGYBHVhgcvsbLFcIKtKlt1zHPIqb5aWn3IyT3xdJjQ3TygYN5A
         X3FC7VQ3guZTZNYdZoJMrDJm/MtdyL/fIHpOyqNpzTB+K1hdxTiG3EC+QbNFtm7EmFbJ
         p3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690057244; x=1690662044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqgsDoxp+a0ulkkTMnYutRgTki2aDg/PYW80rkVVPp8=;
        b=iRMuJG2UddTxTxArma0pNo/q0ew3m8HcKfnVMkBnZH7YWX5OmxKDhd4t0/O6qX2Pe6
         mKX45/kuLQ/FVP/cUH15iN+tOA14knPO8pjKsednM6XWOGqtPpr+pcZ7YPyLbmO6hed9
         GhChkUik/WW7SZbKsWCikUZf9SnoCHBKXddfikgK5lOFCmZAOwnJWHe6tA4oW0dWN+1u
         kFlmgiWaEFRZeKoqjMFibTX6ZmS1kyY4cDDEJ/t1yIaRmjzOk/L2vW66Fxt0Tp5kC8+F
         cfUIXUYXBYTz28kkeneW7sjjeW60gx7+8Q2C1pVanat+L1AKkWZZGZvkfaI1hD4he28F
         ypHg==
X-Gm-Message-State: ABy/qLYkr/cRMwm+8ojUNczCYpqj+//KZLmnHWvil1HR9WOooc38U668
        Io6vFGP2RTKk8zUG9hEU3RF2zg==
X-Google-Smtp-Source: APBJJlHtGR5LPmf1KqxQqGuubWj7q/2swHpo0BwtoPPXrcKJwOgxc6GbBBBkKHLogidNI3C5Z/BtHA==
X-Received: by 2002:adf:f8d1:0:b0:316:ee7f:f9bb with SMTP id f17-20020adff8d1000000b00316ee7ff9bbmr3436488wrq.65.1690057243072;
        Sat, 22 Jul 2023 13:20:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b003140f47224csm7773076wrk.15.2023.07.22.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 13:20:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH RFT] ARM: dts: samsung: exynos4412-midas: add USB connector and USB OTG
Date:   Sat, 22 Jul 2023 22:20:39 +0200
Message-Id: <20230722202039.35877-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add full description of USB-MUIC and MUIC-MHL connections, along with
proper USB connector and OTG mode for DWC2 USB controller.

This fixes dtc W=1 warnings:

  Warning (graph_child_address): /i2c-mhl/hdmi-bridge@39/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: replicant@osuosl.org
Cc: phone-devel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: Martin Jücker <martin.juecker@gmail.com>
Cc: Henrik Grimler <henrik@grimler.se>
Cc: Artur Weber <aweber.kernel@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware. Please kindly check if peripheral mode is not
broken. Or maybe OTG started to work?
---
 .../boot/dts/samsung/exynos4412-midas.dtsi    | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
index 57836d5554d0..6057f9d9811e 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-midas.dtsi
@@ -182,6 +182,34 @@ pmic@66 {
 			pinctrl-0 = <&max77693_irq>;
 			reg = <0x66>;
 
+			connector {
+				compatible = "samsung,usb-connector-11pin",
+					     "usb-b-connector";
+				label = "micro-USB";
+				type = "micro";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						muic_to_usb: endpoint {
+							remote-endpoint = <&usb_to_muic>;
+						};
+					};
+
+					port@3 {
+						reg = <3>;
+
+						muic_to_mhl: endpoint {
+							remote-endpoint = <&mhl_to_muic>;
+						};
+					};
+				};
+			};
+
 			regulators {
 				esafeout1_reg: ESAFEOUT1 {
 					regulator-name = "ESAFEOUT1";
@@ -287,6 +315,14 @@ mhl_to_hdmi: endpoint {
 						remote-endpoint = <&hdmi_to_mhl>;
 					};
 				};
+
+				port@1 {
+					reg = <1>;
+
+					mhl_to_muic: endpoint {
+						remote-endpoint = <&muic_to_mhl>;
+					};
+				};
 			};
 		};
 	};
@@ -545,8 +581,16 @@ hdmi_to_mhl: endpoint {
 &hsotg {
 	vusb_d-supply = <&ldo15_reg>;
 	vusb_a-supply = <&ldo12_reg>;
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	role-switch-default-mode = "peripheral";
+	usb-role-switch;
 	status = "okay";
+
+	port {
+		usb_to_muic: endpoint {
+			remote-endpoint = <&muic_to_usb>;
+		};
+	};
 };
 
 &i2c_0 {
-- 
2.34.1

