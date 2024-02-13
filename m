Return-Path: <linux-kernel+bounces-63709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2BA853380
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A51FB274AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB658109;
	Tue, 13 Feb 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdU91LOE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939F3EA78
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835604; cv=none; b=c0V9++nNnELDrvoRLW2W8HRcP5i7veD3IvLgh00WaEHWL0nh3t9u92pSd3EAivwKQO95ViBOXOESEohceWgPu0r0+OTsVZZaB+xgTiFmpy9FaY5dSim6MhYZWFuyTEIDQXdCI+mK1+H3Nv22pGNqp0YXl4mQRR2w3LoUprpq8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835604; c=relaxed/simple;
	bh=L9qZ+Wg+5t9k9HytAy0yFa2WyzpGe8RK/BTAHT1RwIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huCQ6vR2+npMMsIruAvdEdQrYLvPaCIh0GARdHCqB9U1cEn6dxu86GB8kPSngUZXalJI1hH+0awsD0MV7CFuwZiBVr4TKEtFB9NcM7KwcFbSyGuTrCIXc4q++4lo8lExv3MEdz78gV6Me5UlfJNsb4ltRYFRMo8SbYanVBh3kOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdU91LOE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ce2d1ab86so132733f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707835601; x=1708440401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir8zpBgLqK+Si36wMIN5F8HTmTu0B6WTLwvEQnIKe7U=;
        b=MdU91LOEa5zG29yjsLXsRFlk3U4Z/C1k0f0axKkyvheRD8Jhl/i2b9ud0WxDr40YRm
         jEPvkwng9zthZnEPm+ojxOOzLvtbD4xbHpmKbhHO88EI4esimEoEB3ni9k0F8ukXB5rt
         4QOzlGkSZeRQM0mJFlAzYBQpGKRVaTtJZfDTAdz+2l2diz542Oe4D0eD1nL8zvrfLa30
         UGbwT1I/u8jTsER0MISXYKoxAYr6+fX2CnjqorXDqVzRtWlsk3GiEh0aEPpbBTz/6OI9
         idXzmFOFz7I4xKVGrrNbeatJzE0GpuZb46Ei4k78lkKTu/oNPNmGcs3R2OVfxyKaGf4Y
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835601; x=1708440401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ir8zpBgLqK+Si36wMIN5F8HTmTu0B6WTLwvEQnIKe7U=;
        b=UJQoclM7HHTQU0WlwhYM/qXRA9VDfJEekAitx/y9wXpyfb7ayTPdJCM0xPmyewMQ7y
         E6j6aXcG96A5jmCKuuTNWY2vvIqI/CQ6um4CiFA1hDOtozB5TctiZgRpHrn9kZjHfGxf
         eby0xvHx6HmDI6Cj7p6awrsZoGlwV4I1eelbGwPFlc26dvRUb9AIC1JF5q4ekqJZMKYs
         M+UV+o/oWa4yOunc3MGoCMs4cq7U/Asvoedg/s6ukt0dOlLfBZCOV6OaMq58Cdl2AEwt
         Ya7kRgnLUyq8VqZIt8dzpDeB5oSOQ9ul+Q7+jgTIt7q0UpJJ2lKJhPdv17OPVkcWoRTF
         AImA==
X-Gm-Message-State: AOJu0YxQ9ptxEvvWteHyUIe9OkTwyaNOusZ606ccNp2vy0qcyKfNjbUI
	SVQXAJatRmYltLIqtab+hii27zNPodp488TCDhIiMEaQHZn8s+8fg108gNufX3k=
X-Google-Smtp-Source: AGHT+IEkjtnuspwt+t5YxwSUUxNYqjk5HfcCDkGYBdBQ4TZ0L9nsjc+2ejUhCa/bIvPpauYP32R9SQ==
X-Received: by 2002:a5d:540d:0:b0:33c:ddc9:6926 with SMTP id g13-20020a5d540d000000b0033cddc96926mr1003777wrv.4.1707835601204;
        Tue, 13 Feb 2024 06:46:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXumOGyL64U4UnNmJmEmjj2qONvdl6skdM6eE+twVkvnip6Yf5yJlw/Fmeu4B83NhNzLAJwV+X7VfUvxitIWlLmVeSxeKhMoYQaEtY/zqfPZg7fVpuW1go+ujSfvx0hkMrHRDF3v44RbrW9tYKPubGKSQ2lBfF0HbEAqU4/UvbIyb5Odnx/NnFLyXmsL5s5LZBnNPTd4wFSRu4LeFS752ZhqognFMTNbJvdrysdVd8V9vWU/JaaFCUhLhDfWlmcjqiRibDAxEAqb3OXWBlgMRGEuWx130Rf3BiUD9OoQseymiXcKt21n5ApjBatDDmZ+HpB2eA3
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d67d0000000b0033af26545c8sm9714280wrw.50.2024.02.13.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:46:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] riscv: dts: starfive: replace underscores in node names
Date: Tue, 13 Feb 2024 15:46:38 +0100
Message-Id: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Underscores should not be used in node names (dtc with W=2 warns about
them), so replace them with hyphens.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 12 ++++++------
 arch/riscv/boot/dts/starfive/jh7110.dtsi |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 14d553047e84..90149e379c10 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -96,14 +96,14 @@ cpu-thermal {
 			thermal-sensors = <&sfctemp>;
 
 			trips {
-				cpu_alert0 {
+				cpu-alert0 {
 					/* milliCelsius */
 					temperature = <75000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit {
+				cpu-crit {
 					/* milliCelsius */
 					temperature = <90000>;
 					hysteresis = <2000>;
@@ -113,28 +113,28 @@ cpu_crit {
 		};
 	};
 
-	osc_sys: osc_sys {
+	osc_sys: osc-sys {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		/* This value must be overridden by the board */
 		clock-frequency = <0>;
 	};
 
-	osc_aud: osc_aud {
+	osc_aud: osc-aud {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		/* This value must be overridden by the board */
 		clock-frequency = <0>;
 	};
 
-	gmac_rmii_ref: gmac_rmii_ref {
+	gmac_rmii_ref: gmac-rmii-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		/* Should be overridden by the board when needed */
 		clock-frequency = <0>;
 	};
 
-	gmac_gr_mii_rxclk: gmac_gr_mii_rxclk {
+	gmac_gr_mii_rxclk: gmac-gr-mii-rxclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		/* Should be overridden by the board when needed */
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 1b782f2c1395..8e7f5dec6286 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -237,14 +237,14 @@ map0 {
 			};
 
 			trips {
-				cpu_alert0: cpu_alert0 {
+				cpu_alert0: cpu-alert0 {
 					/* milliCelsius */
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit {
+				cpu-crit {
 					/* milliCelsius */
 					temperature = <100000>;
 					hysteresis = <2000>;
-- 
2.34.1


