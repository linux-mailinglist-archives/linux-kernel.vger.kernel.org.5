Return-Path: <linux-kernel+bounces-58089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155F084E128
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CD828DE4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E1763E5;
	Thu,  8 Feb 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KKJuxj0d"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFF7EF06
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396265; cv=none; b=nKCnIQO9B8Pb7fMWvzzmDNBAoSRtH1DOPOFXZoPjRttxSmGBwZWSU7xx+ZegTP5etIoygJE5CvQL7CctAR5tn+8H1khYvEJGnh4kqop1PT2sMrSFpNvdb7HLzcq3hBnmjaCFvuo8Ve/pED6jMr06pliuFB+zI7Jy3xkNopdT340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396265; c=relaxed/simple;
	bh=gRX2x88FqVLUStqN8zuHyneH2upnBTYGjfOVYMyFZ0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikqFNv2jh4168jh+xY0cZ3jPffQO59etB4//BGJPVujJgfTHPOBgVqQr+cpsfVlGwkxyB9YGOQs07lbLOSL/eDp39AwQcSemMMBrmVSJw8jxGqdP8dIXTxGAW0vOFoHcTNsm8whhGS4++Wya6aIsqikQSIa2jWsFELTTQ9TOdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KKJuxj0d; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41008ab427fso16158805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707396261; x=1708001061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yTEa4/lsVRh49barZX5/hHwmF5ODn+0XbIAzs9ib3A=;
        b=KKJuxj0d3E7VI/zgAkCYq9iS28icvQc3wktVef55AGsDGZgWHKVJe+dQX4GUCCoDGM
         zONbRMFr4bDbPYkT7u2D+nh2HerfwtkxgrJIirDXYFrAGCa8YX8w73vTeGZZhlmYbwcQ
         /By6OAPXb3e5wnhInvQc3UEz6coIW8UAo6y/ep0lAf8e8X69GUDiKUEpUe0shoXKD8Rq
         6OwZkiopObf0sFrH/LbF51tgjI9l8I/JD2TH5aRx2EG5sELqZ2P/76aaX4euJecJ2949
         QI1i16pl3rEbmCGSI0WYdVlmlULbo3r+auNKFvwtu7gWbUYNIUL26CVnrkIct8HG8fJS
         yVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396261; x=1708001061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yTEa4/lsVRh49barZX5/hHwmF5ODn+0XbIAzs9ib3A=;
        b=blg1BJnvuxRtvs8idE2Cl5pbbR4WsR2Jhs6wiT/PqNdmT7HwnbK3wdx0dxrWxJVJ2o
         l/qWtep037jhkSBVYtRLaoPhXYPlE0Qj7IVkF7k+FzZH9Pd7LRcXkDmN0RW+sngUTKk3
         6iY5CqHC96PV3l+1SvSxw41mE8K4I/ekBjZVxVMeXmNyf5SM7dEFC1IdNkhotALWkSVK
         HxHVey6wkczZ+CHjTS1lXMHiNkeMWuWj15/IbgPUbSKVpSqJ01OzFXesjA3lFtlAqHNm
         1/9d/EkIYtwemniaKbJpwZcOkH31VUB4Tk7yHMqPah0aI7lUkxQUFDebq7YayFo8FiLH
         0eMA==
X-Forwarded-Encrypted: i=1; AJvYcCV0C9+OdcQ95gvLnzNkOZ/6Vf4gmMWyt2Zns5ruK0VyFhC5yvA6QwQVO/deUovIn9yGpNCI3zh0SSIXMR8HlEgVfWmMj+aYML5ty88x
X-Gm-Message-State: AOJu0YzgSM2vkBzL95hy0+PPvjDKA8bblHqDZud+7b4ccpgxE+vceA3C
	zBiqtJLE2AHp0sXYDnN61sr7JYoQaEYFz57joT803GjiGRS+VZSgsSyfL7wclXk=
X-Google-Smtp-Source: AGHT+IGANbj1iqOytgIwqTg4Mq/0gpcdPMAp60+0punCG5pjW18WFbjKTwZGb5kh4i/RgdGw5GaHyw==
X-Received: by 2002:a05:600c:1c9e:b0:40f:c1b7:2556 with SMTP id k30-20020a05600c1c9e00b0040fc1b72556mr7366673wms.11.1707396261396;
        Thu, 08 Feb 2024 04:44:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9Sr/LYarYn0Ydw9Z5UndLl0lPc2rf5eImobbDtGEveI/5qBkV4OQYupRBQfDCMJRJ35YozSSMZas9QWzlnjzZVptnk7zkEZazrYTVw86UYlPS3AI0amTEsE6I1FZTTCY+hKtcasM7WBV0CBCiw8LWCK5V8+EBrXoy+b097mnpz/r7tCy6nox9rqP8L6C/nTjqQwSbamMiJThJ8fRRSO1vtaaCazKwu8e2vMsvJBixIu9GxEvggwQmByZNF0Ftcn2PZ+sei2Tg2ED43jC+Pkt/GSwfzj4BqqDpmdcS/ligPgbTVv4N94S7AmYojqC3XPwLYcTPlsGwptui7xpDuKnOfdMoU91UuSuawHavUuKJrBzwPp3Gk8VKSIXbo2O13LQPhV7Rrq5vTtcWY2ksYI7gP3GUlsypZNX08ORpOoYrg0q6+EI8xVUSuGbFdrQeqxp/s1UyKIEqYLsn9o0yOymBeDmq7b0rAXaZJ+wGnPwDdhKPP0W9GZMM1Ow3IYm8P5oq0ulAfZVqpmXZbInU1pEw6JiKqDGpNY1BXjMkk/DzWiFO5eVGwKSTxx5g6mbiqdQ=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0041047382b76sm790244wmq.37.2024.02.08.04.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 04:44:20 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 17/17] arm64: dts: renesas: r9a09g011: Update #power-domain-cells = <1>
Date: Thu,  8 Feb 2024 14:43:00 +0200
Message-Id: <20240208124300.2740313-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
always on power domain as the driver has been modified to support multiple
power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 50ed66d42a24..74af0f730b89 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -81,7 +81,7 @@ sdhi0: mmc@85000000 {
 				 <&cpg CPG_MOD R9A09G011_SDI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A09G011_SDI0_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -97,7 +97,7 @@ sdhi1: mmc@85010000  {
 				 <&cpg CPG_MOD R9A09G011_SDI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A09G011_SDI1_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -113,7 +113,7 @@ emmc: mmc@85020000  {
 				 <&cpg CPG_MOD R9A09G011_EMM_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A09G011_EMM_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -129,7 +129,7 @@ usb3drd: usb3drd@85070400 {
 				 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
 			clock-names = "axi", "reg";
 			resets = <&cpg R9A09G011_USB_DRD_RESET>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			ranges;
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -144,7 +144,7 @@ usb3host: usb@85060000 {
 					 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
 				clock-names = "axi", "reg";
 				resets = <&cpg R9A09G011_USB_ARESETN_H>;
-				power-domains = <&cpg>;
+				power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 				status = "disabled";
 			};
 
@@ -157,7 +157,7 @@ usb3peri: usb3peri@85070000 {
 					 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
 				clock-names = "axi", "reg";
 				resets = <&cpg R9A09G011_USB_ARESETN_P>;
-				power-domains = <&cpg>;
+				power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 				status = "disabled";
 			};
 		};
@@ -207,7 +207,7 @@ avb: ethernet@a3300000 {
 				 <&cpg CPG_MOD R9A09G011_ETH0_GPTP_EXT>;
 			clock-names = "axi", "chi", "gptp";
 			resets = <&cpg R9A09G011_ETH0_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -220,7 +220,7 @@ cpg: clock-controller@a3500000 {
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
-			#power-domain-cells = <0>;
+			#power-domain-cells = <1>;
 		};
 
 		pwc: pwc@a3700000 {
@@ -244,7 +244,7 @@ csi0: spi@a4020000 {
 				 <&cpg CPG_MOD R9A09G011_CPERI_GRPG_PCLK>;
 			clock-names = "csiclk", "pclk";
 			resets = <&cpg R9A09G011_CSI_GPG_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -258,7 +258,7 @@ csi4: spi@a4020200 {
 				 <&cpg CPG_MOD R9A09G011_CPERI_GRPH_PCLK>;
 			clock-names = "csiclk", "pclk";
 			resets = <&cpg R9A09G011_CSI_GPH_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -274,7 +274,7 @@ i2c0: i2c@a4030000 {
 			interrupt-names = "tia", "tis";
 			clocks = <&cpg CPG_MOD R9A09G011_IIC_PCLK0>;
 			resets = <&cpg R9A09G011_IIC_GPA_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -288,7 +288,7 @@ i2c2: i2c@a4030100 {
 			interrupt-names = "tia", "tis";
 			clocks = <&cpg CPG_MOD R9A09G011_IIC_PCLK1>;
 			resets = <&cpg R9A09G011_IIC_GPB_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -311,7 +311,7 @@ wdt0: watchdog@a4050000 {
 			clock-names = "pclk", "oscclk";
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&cpg R9A09G011_WDT0_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -361,7 +361,7 @@ pinctrl: pinctrl@b6250000 {
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD R9A09G011_PFC_PCLK>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A09G011_PD_ALWAYS_ON>;
 			resets = <&cpg R9A09G011_PFC_PRESETN>;
 		};
 	};
-- 
2.39.2


