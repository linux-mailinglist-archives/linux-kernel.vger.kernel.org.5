Return-Path: <linux-kernel+bounces-36088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1D839B6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35D328D1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81345C12;
	Tue, 23 Jan 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Co6aqA"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD34D5BF;
	Tue, 23 Jan 2024 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046493; cv=none; b=be5XEnuG+eflRaE7NQvSjkWlrlNafB8J8etH0MDSGXe1ekNO2JJovgp+FWG185LORWbK8oquNmPEr5kMu74P1OOrFq8LKUt5xLYeatlEFKppLzxM7QKR7N6bvU5qIiUjSSrIdTjeKP2uwRUi71g4fhOpvUrFg5jNBFl4rAwIsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046493; c=relaxed/simple;
	bh=cot/RLa5B+VvYdjsSjzRhdQNUXnW5oMxtw+aZzsx/eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1CKlPiJ1hyKYtGOgGCrvMUGvv+A7txELCoGQubQvHm/3RwiEDu0vlb63dkgqH0TxWBurc0+SYAGnrPnbK2ngp9W4QVoowBqf5TbXu1PsqD831uwiBUi0On4SSgNM3EtR6gvqrJ+ShY6RFMfSAkQby3jn5SIz18wQd0NURVSTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Co6aqA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eabd1c701so5413449e87.3;
        Tue, 23 Jan 2024 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046490; x=1706651290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxTUu07Tw3JZQ4EBg2GvG/6CFogECC0naJLXgFJuN6s=;
        b=F/Co6aqAvuJqfeuTjTuu87DQGc9AEEvs/vOkBdY5dDnOWmA0qGN9mCEls1xTGUQoRw
         V4pmAK4601QdSnwIV74zEsD2HxTGRVBKk9A+8gAplBtLx+zZiLwvBPfrH23eLNdK2Upp
         uZguPYQAI5D+p7jyTox4OLsDDJf067J7nv62ZLLsqFcjODapSKtPBESmyO+UmwHXRxXR
         rp+P8HCOnS1ugTJcTNhrTygMxK6lPcxDNYqNtN0KtQUL1wxRlKDNma1voOFlHIs7uASZ
         +HNZA4L+QesAlwEAZQYSgX1Uc/3wVn6TRyhoN27EFtP4gc8J4FZyV/2yFyPRy8GXfb7c
         dvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046490; x=1706651290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxTUu07Tw3JZQ4EBg2GvG/6CFogECC0naJLXgFJuN6s=;
        b=F/NIBHgJ/80miEuAFf6JVDdxDq4au8XI8FUpE6jb8T5M9g1i8SENCE/Pjp7anYcirJ
         2Mr9+SFkrVaq9Z1wlGsJJpo3bWwEj62ZynaPCiz6CLWhDsRFPIbfOBfj3Dqf5c5wO3bn
         r5mWRcRAjJnajquzsRj4eNpv7Ru7fDRkPOrNq022h/WfyyYRgDtcHp8vZTBC4gM5VxXH
         J1RG6qkJ325lNEjxzI9R0BOgLlZvDd3h6g2EQjV1Mscii61I75m9CkzENE/MV8WVPSBF
         yIFD+8JRggjl0x/2f2pAHFj5ZylK85q6GAISN/jhT5wbPJl61rLcBWPZcqyqYjD0AOMq
         Ddjg==
X-Gm-Message-State: AOJu0Yy84J6f5Xj5JEQrugxpI4QOxc7U4vWvbSARdKNKjVg33ILLrFE7
	I/GuCJzIPkGg9+drjRuy7Ti+E472yjhVE/B9fhCFiqW2vFM0gJud
X-Google-Smtp-Source: AGHT+IHZ4f7jIFRNJ+6G/KFQ8DhBSxZWT2NG2LD0URxwP0fjG+Ik3wpsd03v9PwttJz5KM4uopPA3g==
X-Received: by 2002:a05:6512:ba5:b0:50e:8e74:6406 with SMTP id b37-20020a0565120ba500b0050e8e746406mr4251539lfv.36.1706046489310;
        Tue, 23 Jan 2024 13:48:09 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b005100c6c925csm133993lfh.88.2024.01.23.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:48:08 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] arm64: dts: sun50i-a64-pinephone: Add front/back cameras
Date: Wed, 24 Jan 2024 00:47:29 +0300
Message-ID: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondřej Jirman <megi@xff.cz>

Pinephone has OV5640 back camera and GC2145 front camera. Add support
for both.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..4104a136ff75 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -36,6 +36,15 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c_csi: i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE13 */
+		scl-gpios = <&pio 4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE12 */
+		i2c-gpio,delay-us = <3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -124,6 +133,36 @@ &cpu3 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&csi {
+	pinctrl-0 = <&csi_pins>, <&csi_mclk_pin>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ov5640_ep: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+
+		csi_gc2145_ep: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&gc2145_ep>;
+			bus-width = <8>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+			data-active = <1>;
+			pclk-sample = <1>;
+		};
+	};
+};
+
 &dai {
 	status = "okay";
 };
@@ -158,6 +197,58 @@ &ehci1 {
 	status = "okay";
 };
 
+&i2c_csi {
+	gc2145: front-camera@3c {
+		compatible = "galaxycore,gc2145";
+		reg = <0x3c>;
+		clocks = <&ccu CLK_CSI_MCLK>;
+		clock-names = "xclk";
+		avdd-supply = <&reg_dldo3>;
+		dvdd-supply = <&reg_aldo1>;
+		iovdd-supply = <&reg_eldo3>;
+		reset-gpios = <&pio 4 16 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PE16 */
+		powerdown-gpios = <&pio 4 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PE17 */
+		rotation = <270>;
+		orientation = <0>;
+
+		port {
+			gc2145_ep: endpoint {
+				remote-endpoint = <&csi_gc2145_ep>;
+				bus-width = <8>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				data-active = <1>;
+				pclk-sample = <1>;
+			};
+		};
+	};
+
+	ov5640: rear-camera@4c {
+		compatible = "ovti,ov5640";
+		reg = <0x4c>;
+		clocks = <&ccu CLK_CSI_MCLK>;
+		clock-names = "xclk";
+		AVDD-supply = <&reg_dldo3>;
+		DOVDD-supply = <&reg_aldo1>; /* shared with AFVCC */
+		DVDD-supply = <&reg_eldo3>;
+		reset-gpios = <&pio 3 3 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>; /* PD3 */
+		powerdown-gpios = <&pio 2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>; /* PC0 */
+		rotation = <90>;
+		orientation = <1>;
+
+		port {
+			ov5640_ep: endpoint {
+				remote-endpoint = <&csi_ov5640_ep>;
+				bus-width = <8>;
+				hsync-active = <1>; /* Active high */
+				vsync-active = <0>; /* Active low */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.43.0


