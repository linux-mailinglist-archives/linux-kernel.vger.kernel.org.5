Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9176762C85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGZHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGZHEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:04:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F44201
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9891c73e0fbso141838866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354983; x=1690959783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoHCbHpn1OMiPX4TLjnp4qVOzgzg0gHNFxjxNAOLThg=;
        b=cEG5ipcc/AwC9tVUp0WsqJS66XyxYuQHDj5nZ2+1BhA23GZanivVsvIe/FE/X+4kEH
         OGmGOf4FwzyAo+T4la6FM3m96WzSHAQMq67uR0WMB7z02ARTEMIFSD2o5qSqPqZ+q9v7
         SVXFrKq3+EBGO7mHt1Nwo86LKhPA4OAufiH6cEhcg1j2XWw8k5Hh+a9wLTHf+Aw2Flop
         iwMncD4W3IYGxHcKSqFW2NRTNj4iK6fk2UYQ442kUr2ghg3ulD+/aHMqDLJTurgRHIqY
         h4hBOKly5QkGPNXgtQd9/lgY46wbeU5wI6T9dG+AiaRu7nKwb1z9e/WqRjn3l8hONb9H
         +gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354983; x=1690959783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoHCbHpn1OMiPX4TLjnp4qVOzgzg0gHNFxjxNAOLThg=;
        b=KB1FLRsIyWhp7VzomKD9X0sFzyQmDStzdgwdRJ35U9NtA03trXTM96lRgJAu2FyqNa
         d5SKjEJcrOOXKaxlAPSSwx9M+1dCWOcrg9NfO1ED13nlb1tToWrPSCMszoRCUxf9+SAT
         zxLaleLgBWe/hLj16+ndAyMnZDyRLotuLgBBHXFTMr9fcExMAl3AQ1j37/x9gBZK93Ba
         /13exsU+Uvq4PnP7IQQS7Dh7yxeiosukGtqk28yxGflWL8pr42MI7EUAYIIgZ9jALcn2
         60/p/BeWssCvIg+oaHEilMDMnjbcKRoV3hKXH1ki3/irsqLr3+kaOdgePL1R//7La3AW
         nDAw==
X-Gm-Message-State: ABy/qLbv+3kPY9WB5K3e5BQCJ2k/97ienh/+XWJs6suEVJzKhre1nBF0
        vei5+mg6/NqJeDDNhEaYX1c3gV1t5GxTK0uJJLw=
X-Google-Smtp-Source: APBJJlFJv22R95SOe3nTiOB0lJAeIg0+xmGrNoxVP9g6gmozbb3cTpfALjGgyNL+fmurCG1aH9+hLw==
X-Received: by 2002:a17:907:96a2:b0:96f:9cea:a34d with SMTP id hd34-20020a17090796a200b0096f9ceaa34dmr5082585ejc.21.1690354983430;
        Wed, 26 Jul 2023 00:03:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00992b2c55c67sm9249923ejb.156.2023.07.26.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: marvell: armada: drop incorrect reg in fixed regulators
Date:   Wed, 26 Jul 2023 09:02:53 +0200
Message-Id: <20230726070254.103661-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed regulators are not in some bus and bindings do not allow a "reg"
property.  Move them out of "regulators" node to top-level.

  armada-370-dlink-dns327l.dtb: regulator@1: Unevaluated properties are not allowed ('reg' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/marvell/armada-370-dlink-dns327l.dts  |  83 ++++++--------
 .../marvell/armada-370-seagate-nas-4bay.dts   |  43 ++++---
 .../marvell/armada-370-seagate-nas-xbay.dtsi  |  46 ++++----
 ...armada-370-seagate-personal-cloud-2bay.dts |  21 ++--
 .../armada-370-seagate-personal-cloud.dtsi    |  43 +++----
 .../marvell/armada-370-synology-ds213j.dts    |  54 ++++-----
 .../dts/marvell/armada-xp-synology-ds414.dts  | 105 +++++++++---------
 7 files changed, 177 insertions(+), 218 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
index 561195b749eb..d4c4efabd254 100644
--- a/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-dlink-dns327l.dts
@@ -105,54 +105,45 @@ led-backup {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+	usb_power: regulator-1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&xhci_pwr_pin>;
+		pinctrl-names = "default";
+		regulator-name = "USB3.0 Port Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-boot-on;
+		regulator-always-on;
+		gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+	};
 
-		usb_power: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			pinctrl-0 = <&xhci_pwr_pin>;
-			pinctrl-names = "default";
-			regulator-name = "USB3.0 Port Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-boot-on;
-			regulator-always-on;
-			gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
-		};
+	sata_r_power: regulator-2 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&sata_r_pwr_pin>;
+		pinctrl-names = "default";
+		regulator-name = "SATA-R Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <2000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+	};
 
-		sata_r_power: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			pinctrl-0 = <&sata_r_pwr_pin>;
-			pinctrl-names = "default";
-			regulator-name = "SATA-R Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <2000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
-		};
-
-		sata_l_power: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			pinctrl-0 = <&sata_l_pwr_pin>;
-			pinctrl-names = "default";
-			regulator-name = "SATA-L Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <4000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
-		};
+	sata_l_power: regulator-3 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&sata_l_pwr_pin>;
+		pinctrl-names = "default";
+		regulator-name = "SATA-L Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <4000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
index 9cb69999b1db..370ca9c43247 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-4bay.dts
@@ -46,29 +46,26 @@ pca9554: pca9554@21 {
 		};
 	};
 
-	regulators {
-		regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "SATA2 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&pca9554 6 GPIO_ACTIVE_HIGH>;
-		};
-		regulator@4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "SATA3 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&pca9554 7 GPIO_ACTIVE_HIGH>;
-		};
+	regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA2 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&pca9554 6 GPIO_ACTIVE_HIGH>;
+	};
+
+	regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA3 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&pca9554 7 GPIO_ACTIVE_HIGH>;
 	};
 
 	gpio-leds {
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
index 822f10734946..ffb3179033e7 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-nas-xbay.dtsi
@@ -70,34 +70,26 @@ rtc@6f {
 
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
+	regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA0 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+	};
 
-		regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "SATA0 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
-		};
-		regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "SATA1 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
-		};
+	regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA1 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 	};
 
 	gpio-fan {
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
index 5ee572dc9242..45d8ec5dfeb7 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud-2bay.dts
@@ -32,17 +32,14 @@ sata@a0000 {
 		};
 	};
 
-	regulators {
-		regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "SATA1 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
-		};
+	regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA1 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
index 124a8ba279e3..054124857235 100644
--- a/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-370-seagate-personal-cloud.dtsi
@@ -53,32 +53,25 @@ usb@50000 {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+	regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
+	};
 
-		regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "USB Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
-		};
-		regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "SATA0 power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
-		};
+	regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA0 power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
index f0893cc06607..b07d11d1f124 100644
--- a/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/marvell/armada-370-synology-ds213j.dts
@@ -142,38 +142,32 @@ disk2-led-amber {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
+	sata1_regulator: sata1-regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA1 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <2000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata1_pwr_pin>;
 		pinctrl-names = "default";
+	};
 
-		sata1_regulator: sata1-regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "SATA1 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <2000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		};
-
-		sata2_regulator: sata2-regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "SATA2 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <4000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>;
-		};
+	sata2_regulator: sata2-regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA2 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <4000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata2_pwr_pin>;
+		pinctrl-names = "default";
 	};
 };
 
diff --git a/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
index 5551bac1962c..1b65059794bf 100644
--- a/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/marvell/armada-xp-synology-ds414.dts
@@ -109,65 +109,60 @@ ethernet@74000 {
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin
-			     &sata3_pwr_pin &sata4_pwr_pin>;
+	sata1_regulator: sata1-regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA1 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <2000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata1_pwr_pin>;
 		pinctrl-names = "default";
+	};
 
-		sata1_regulator: sata1-regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "SATA1 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <2000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		};
+	sata2_regulator: sata2-regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA2 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <4000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata2_pwr_pin>;
+		pinctrl-names = "default";
+	};
 
-		sata2_regulator: sata2-regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "SATA2 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <4000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-		};
+	sata3_regulator: sata3-regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA3 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <6000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata3_pwr_pin>;
+		pinctrl-names = "default";
+	};
 
-		sata3_regulator: sata3-regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "SATA3 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <6000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		};
-
-		sata4_regulator: sata4-regulator@4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "SATA4 Power";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			startup-delay-us = <8000000>;
-			enable-active-high;
-			regulator-always-on;
-			regulator-boot-on;
-			gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		};
+	sata4_regulator: sata4-regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "SATA4 Power";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <8000000>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&sata4_pwr_pin>;
+		pinctrl-names = "default";
 	};
 };
 
-- 
2.34.1

