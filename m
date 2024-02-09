Return-Path: <linux-kernel+bounces-59329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A784F57E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226231C21A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B015374FB;
	Fri,  9 Feb 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6yUl0uX"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D89C2031E;
	Fri,  9 Feb 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483688; cv=none; b=R7DNRu493FGUe4BFZT8mG97Rifjm5xPrhmMHaY0h+Ghis+MC9GFBvpMjc1EwN6iW9XvUFgVeLvB+3npQCsPDa0YaTbWTyNOuRVq/WWkBCNMFCLbUOW3OHZ1GKtjguE3nhUoCwfwWRvWIDYVaC2LzpidlOStc7KD0vFADSkFqGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483688; c=relaxed/simple;
	bh=AdnfAMS7dtM1+VGdSOASt/rIq0mXghN2Y1xkeAMn750=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHZamyq1XqDvryDVJ/3dpx7SRj7UHryf/Tac1pPtDR1LFBKLhY4BIlgoTW1Thz3vVvL3Bidak9wTZTStBLbyhgL+86t8JkO5seJjtqtJJKlddwoMxn9Ug+Zs1A4557QHSOdKa/w2LWqbr26zrhpi7uJtULp4yWizivx6Yic7nFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6yUl0uX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso1135040a12.2;
        Fri, 09 Feb 2024 05:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707483685; x=1708088485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YxIlgX7MIBkIsXwFEBQ3cAM8/Vkesj2iwEzVJ+cQz8=;
        b=d6yUl0uXbn2FwodfC1nMax+fqvBGpiKmJN8HU1wT0DWle6m+0ylq3N5ZUG5/vnJQuU
         W64EAeucqDSPtYo21kx0YimSDvCbVGN0PmJmskvns+Hy54+GgZrt7BLxM+kHfKJmpbvM
         1nUhMr1yCRavIO3t5V2Zu7AeEQV5H9ADqgM/5XjLNm7fHhQMETQw5gkNo4iC4rWLJqQA
         9cmp5zTpmHYWBy1HbVRiDVIRld6ti/8YaGQrzTJyGpskZ2s5XjMI6ugS4X7IAlzBIwaU
         cqP3NPMMSvz2lgpTGRffyXFF88Ai4LIJ/KRz4o2z5U+XzLE4EPtJ0H9kS+ag8fjgiYQI
         KFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483685; x=1708088485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YxIlgX7MIBkIsXwFEBQ3cAM8/Vkesj2iwEzVJ+cQz8=;
        b=piWn3WXl4YcjZLCUgiUWh7CDexTbvcTeJnisFpJy4d+0XfZe59GFM241K/NAeOBT0F
         D+8PpbCGdmSY1RZvmTJqR48+xjq13erTenR5ZF2cqrNDcWFzLFSkrsm2CjjPj79FyRMx
         TzYPYrZzEAZE5PCdAtk2nE3ETT8Xvs9sCANiSPY1OIM8BeOnci/Jid9XMStqtemV0mWk
         c5a2Qd+1q4kJEotztsb0DmmMM3jUD29zPsQXqm9fjyC4GyHl2QHDmfEIu/26RbOpdlNB
         EhBNgmEhOw1/8d5C1ZbhDt5beCp6XWLlVy4mgZ9h0oTua6xjOyufGf2AUP/RCN//BgtK
         n3KQ==
X-Gm-Message-State: AOJu0Yy9c+jFhJ3UwAsYxLKYuj5NQfpcMwuY4Bgm904VpGVZ7q75iSBu
	EEDalgQlvHq7U7dp0l8z8WYgS9BmvIT7jcUUmH63OqaUoO6Pd/44xeFoddQ6pRM=
X-Google-Smtp-Source: AGHT+IFTds3ak6ncRkRK208oW6UKnBrc9Ce/umGRaNIRrkg65B9BDuYVLd3pHqEe974f6bUb0JLTiQ==
X-Received: by 2002:a17:906:3650:b0:a38:8b64:c8ef with SMTP id r16-20020a170906365000b00a388b64c8efmr1078126ejb.74.1707483684602;
        Fri, 09 Feb 2024 05:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVufDQMr8/+3ia87L8TOJiU5fLNRJSmugCcDcTAH16AQjsNZzvdfBHSYbYRSU//tCqRvzbsklBRzUzbDyaVUNt8cXyW/wto/9YeljLexszAGcsWBOoPpi4cIRIl8nOhocSG53iy11HoWVclJo3o8lH48tBxzyV8H/K42w68f2xaX2/D26sdJ3tHLiP8BUS/dDj0Ac2vENtMuzy/HxIiLPaDsOODFASdOBRPHOhGlWtfmtlJ+3hr+vREc4iqSetpV2Q4T9SFDmRWHo01meYHRrxNhwD/7/pB03xXdI0F9VqmZWEKq5ltIW9cgVdjTtR/SXdKqqAOWCEiERqS9zNLNYjCq7KCtmGSOB/1uRTbGUv5c/5D6i81ct8pPXMU80=
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906ba8200b00a37295502c0sm739495ejd.138.2024.02.09.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 05:01:24 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
Date: Fri,  9 Feb 2024 14:01:06 +0100
Message-Id: <20240209130106.38739-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Add support for Verdin USB1 interface, implements role switch
functionality using "gpio-usb-b-connector", VBUS is also now
controlled with "regulator-fixed" using a standard GPIO.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v1:
 - https://lore.kernel.org/all/20240209110500.22193-1-andrejs.cainikovs@gmail.com/
v2:
 - fix GPIO naming as per rest of the file
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 55 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 6a06724b6d16..7e9bdba438b1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -42,6 +42,22 @@ aliases {
 		usb1 = &usb1;
 	};
 
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_id>;
+		id-gpios = <&main_gpio1 19 GPIO_ACTIVE_HIGH>;
+		label = "USB_1";
+		self-powered;
+		vbus-supply = <&reg_usb0_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb0_ep>;
+			};
+		};
+	};
+
 	verdin_gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -151,6 +167,18 @@ reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
 		vin-supply = <&reg_sd_3v3_1v8>;
 	};
 
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_en>;
+		enable-active-high;
+		/* Verdin USB_1_EN (SODIMM 155) */
+		gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "USB_1_EN";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -436,6 +464,13 @@ AM62X_IOPAD(0x0244, PIN_INPUT_PULLUP, 7) /* (C17) MMC1_SDWP.GPIO1_49 */ /* SODIM
 		>;
 	};
 
+	/* Verdin USB_1_EN */
+	pinctrl_usb0_en: main-gpio1-50-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0254, PIN_INPUT, 7) /* (C20) USB0_DRVVBUS.GPIO1_50 */ /* SODIMM 155 */
+		>;
+	};
+
 	/* On-module I2C - PMIC_I2C */
 	pinctrl_i2c0: main-i2c0-default-pins {
 		pinctrl-single,pins = <
@@ -660,13 +695,6 @@ AM62X_IOPAD(0x0038, PIN_OUTPUT,       5) /* (E24) OSPI0_CSn3.UART5_TXD    */ /*
 		>;
 	};
 
-	/* Verdin USB_1 */
-	pinctrl_usb0: main-usb0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0254, PIN_OUTPUT, 0) /* (C20) USB0_DRVVBUS */ /* SODIMM 155 */
-		>;
-	};
-
 	/* Verdin USB_2 */
 	pinctrl_usb1: main-usb1-default-pins {
 		pinctrl-single,pins = <
@@ -1013,7 +1041,7 @@ &main_gpio1 {
 		"",
 		"",
 		"SODIMM_17",
-		"", /* 50 */
+		"SODIMM_155", /* 50 */
 		"",
 		"",
 		"",
@@ -1428,11 +1456,16 @@ &usbss0 {
 	status = "disabled";
 };
 
-/* TODO: role swich using ID pin */
 &usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb0_id>;
+	adp-disable;
+	usb-role-switch;
 	status = "disabled";
+
+	port {
+		usb0_ep: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
 };
 
 /* Verdin USB_2 */
-- 
2.34.1


