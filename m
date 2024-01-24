Return-Path: <linux-kernel+bounces-36874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51783A7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5461F236D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D63E3D558;
	Wed, 24 Jan 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YjYtRE30"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21020B27
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096031; cv=none; b=gYTcAC5xBNbPI8myrEmfzt/+LcsV9ihlXILaA4aMyZa7IoVhZjLP33yuN9qhtB/REBGuxuVuELfR6BtYmp+ov30QRDKympr5TeUhBTYqGEjobTecyhELFIgNbuLU7yf1EpMkCrkTBLPiz2oEKwahaCyFC3GvbYrLlppQ1dEAf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096031; c=relaxed/simple;
	bh=ehzpk2SH4lnyatP6zppqCWCZjaU1XqDFcQhxQUG8cxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7dt3uOogw45D6niHyKIzlEvkcK52lARzRtIWwKJ9VPqgkx5wYct9VmBz61suuxadNxnhzEQnSgYZjEHMa97fWfjw+78PAsNwZBGdmySz1zyi5eWKzr2F68ap6Ecsbq4fU0zMO1bdATXKtd2PaAi4NekJ/5RZY9MTwgz7V4zIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=YjYtRE30; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3394b892691so476595f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706096027; x=1706700827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4WZCMaxTTTK5Kb267g6Dn7+KP5+NrOJpg31LGj1mtM=;
        b=YjYtRE30R8EIrBoHNw+yX1foXrMfGlha5WnJ6gYR9W1fs6HqhWg3+BOEzrBn6n0Svg
         JLjW7crQZ569HaiWB/g7tT8+VjJJDCPUewxhyRCWhgxVS1cAn0IX/OhnEcSU/0c8NMrr
         XXeFT5JErTuYMULgPvvKmaoigan9+kqskkHvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706096027; x=1706700827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4WZCMaxTTTK5Kb267g6Dn7+KP5+NrOJpg31LGj1mtM=;
        b=vLFDslf3k3oinsxl267+9mnQENIrhZ4YwgLMd3jSwJQMdOJGH8B52dfJUqENs04Ybk
         cMWbFrYlfmPSGsqFQb+mD5hiJ0DJerF7/8XbSfJRUQIGK5w2gtyPfwgJ7MIQF23LI/xl
         QRBYTznlE+els0Dnwh+ASNXfqeqTCQ773ZnSw+rSyoeFqj6Rqe1J9UW0BWzk0jxXmXTB
         AE6lLtc4zbWHapaCsR0Z5df5i/rWgfb9jB/Yy8PHa9i5HgQci6nAk7J1S3oXA3uhZz0d
         mezFNwLfv/xhslSugxyC66EkS39/q4KGuZe9pra1DYZ3pY52aUKPW/u3nBBY1w2N0lg+
         zljw==
X-Gm-Message-State: AOJu0YwFvSkX0p+cqZtHEeYL0cDxb7Xz9OpAc5HzBngN2Ia6iAGV4Stp
	9wh2Mod5ZHH/BWxRITZjkPwMCFnAN7F6MtZWgf4OE+VksAd/AAt4YilLJ2s17sNr9NuPmwWsL5W
	9
X-Google-Smtp-Source: AGHT+IHURO/tYhzfPC+IgWh67nNUSW55NggO77fT58jLSJX4dJeQmpyxblqNyMGzgHtbUJl5bEXA3A==
X-Received: by 2002:a5d:4c52:0:b0:339:534e:975f with SMTP id n18-20020a5d4c52000000b00339534e975fmr311120wrt.25.1706096027752;
        Wed, 24 Jan 2024 03:33:47 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.. (mob-5-90-60-192.net.vodafone.it. [5.90.60.192])
        by smtp.gmail.com with ESMTPSA id i18-20020adffdd2000000b003393249d5dbsm8447950wrs.4.2024.01.24.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:33:47 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v9 4/5] ARM: dts: stm32: add display support on stm32f769-disco
Date: Wed, 24 Jan 2024 12:33:13 +0100
Message-ID: <20240124113336.658198-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124113336.658198-1-dario.binacchi@amarulasolutions.com>
References: <20240124113336.658198-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds display support on the stm32f769-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v9:
- Rename panel-dsi@0 to panel@0 to fix yaml warnings

Changes in v8:
- Remove unit name from 'ltdc/port/endpoint@0' to fix the compiling
  warning:
  ../arch/arm/boot/dts/st/stm32f769-disco.dts:189.28-191.5: Warning
  (unit_address_vs_reg): /soc/display-controller@40016800/port/endpoint@0: node
  has a unit name, but no reg or ranges property

 arch/arm/boot/dts/st/stm32f769-disco.dts | 72 +++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 660f85984164..43479b0804c2 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -41,7 +41,7 @@
  */
 
 /dts-v1/;
-#include "stm32f746.dtsi"
+#include "stm32f769.dtsi"
 #include "stm32f769-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -60,6 +60,19 @@ memory@c0000000 {
 		reg = <0xC0000000 0x1000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			linux,dma-default;
+			no-map;
+			size = <0x100000>;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
@@ -85,6 +98,13 @@ button-0 {
 		};
 	};
 
+	panel_backlight: panel-backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpioi 14 GPIO_ACTIVE_HIGH>;
+		default-on;
+		status = "okay";
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -114,6 +134,46 @@ &clk_hse {
 	clock-frequency = <25000000>;
 };
 
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dsi_in: endpoint {
+				remote-endpoint = <&ltdc_out_dsi>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dsi_out: endpoint {
+				remote-endpoint = <&dsi_panel_in>;
+			};
+		};
+	};
+
+	panel0: panel@0 {
+		compatible = "orisetech,otm8009a";
+		reg = <0>; /* dsi virtual channel (0..3) */
+		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
+		power-supply = <&vcc_3v3>;
+		backlight = <&panel_backlight>;
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins_b>;
 	pinctrl-names = "default";
@@ -122,6 +182,16 @@ &i2c1 {
 	status = "okay";
 };
 
+&ltdc {
+	status = "okay";
+
+	port {
+		ltdc_out_dsi: endpoint {
+			remote-endpoint = <&dsi_in>;
+		};
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.43.0


