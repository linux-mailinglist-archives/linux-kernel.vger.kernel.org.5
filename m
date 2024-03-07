Return-Path: <linux-kernel+bounces-95704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAD875181
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854171C245D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C50131723;
	Thu,  7 Mar 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AGZkRS19"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD670130AE6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820484; cv=none; b=RWr5W+bm/1lqtu6d5cqo3zWJnZtcR6xJ912kWQwV9qqLaZr+d2iSPMUTqkAFfR1eZ5OioXGCn51xlE4NlwiEvivkeeaLB/iFYxg3/SheSzi/27C0k5lYysLJAfPjWEi5A9T45FxH/3UCfN95VFo3IFXWv9978GtnUp7nw6pmasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820484; c=relaxed/simple;
	bh=PEMKuouqVKmmpKoVkq3vAFTw0XHIm6pIPcKox0E3AAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9AWww6CsyS2QXI2QBfhxu/wFM/czKxeb1vSm2Hh9fpTr+xXeXApcRYTE14M9OD2y2L3HiyDdlZGDU33XqteY4nLdjzMoZLZAVcb9vJpE7rRSulE89jOZIyrbo4QBmpQmdf2kxlZyss1F1VcHf6W8KRsWIJORkhwGxs+Fhf9wXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AGZkRS19; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so1245068a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820481; x=1710425281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpzyVLIzoJjoH1dmsrwx7exqYjIDge6ltNcGIu8yesY=;
        b=AGZkRS1994Q9dicDpXIxvRfNSOM0EKaWJbMEXvWxd2YuiZD8wCeUlBp7khSlEzJvBT
         LT8yQ/1in+Uyh4+2XesXpgmT2bwjVsXEEBUdPn0DU1YCPzOUU/ofUKiL7CyHBJQS4R8+
         ur/dZi6BDG3ne5LMjkNn4T/a7lhTGhmHFBwMlr+OWE+/RfYXSsi5/Us4bxMPGbWwbTBW
         +fxRyGrO/IFuwyh2XwCTVRVRsd72IqwbW9pobSQIyWZjkImgYtP9m+5UmwUN5gqpoW5i
         ub6AfwNsefprL1vcbzAUiXicnH+7rNXNAvefYt0hXPqL7eqIZpikR93TkJK+KBzs6Ege
         Og4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820481; x=1710425281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpzyVLIzoJjoH1dmsrwx7exqYjIDge6ltNcGIu8yesY=;
        b=i1YBDvoE43XV80D9UuQcSZ+TlYyFUkhr8tOmWjK2IXJ7XXQwu5Vrwsilpnt5axP0l7
         ski/DRIlcv3SjntPZBmd/fb/fjN+rHCsDbHZy51Cf1BY25I1WTj7A1b9xgDe+6DqIM5l
         uhAU2VM/LejLGfmvF4VsaeAkdhFhkv5H15HSj841vI7SS5/yqeN7sg/JhXlZX26bOs83
         0d8b+2fZ2gLPg0TMeKsI9w696Zzp9CY05NZT7aOh4ibw4tZB542agxQUnQcuZsVhl/oB
         ChHoXvaVtW5yzkSSDaS5Z/8RBkfR+9+7hbf6KXyYZnmm+cG+f6qr00XsVSgtcP9wO5Fa
         Mx2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmisrvmBXndr6ELaq1UMCvawz1DDGmptYz79WGaZSwpgVQ5Z0fFSZdhNaRgcz2kHC4blNtUQLTA+xrRiSIQzv9OatNpH3hBWhlMSfk
X-Gm-Message-State: AOJu0Yye4yIASUHfKMAIKG2yzPARHN+5FuqaQxvxMgTVxZK1/zl3MRMR
	1/0JOPa9GuIAZ8TBHoidqouU1gVgwccJtUk4WHekuBo0hHCDaJ3J3/LnxzDBG5o=
X-Google-Smtp-Source: AGHT+IH383qSNmyroOVk8Z2J3JB8DfKL5t+7aDSA7RmXDdNZsBGBQvrJfyji96J2AnloEHn/Ij+c3Q==
X-Received: by 2002:a17:907:100a:b0:a44:4e9a:8cc2 with SMTP id ox10-20020a170907100a00b00a444e9a8cc2mr12771230ejb.58.1709820481472;
        Thu, 07 Mar 2024 06:08:01 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:08:00 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 10/10] arm64: dts: renesas: r9a08g045: Update #power-domain-cells = <1>
Date: Thu,  7 Mar 2024 16:07:28 +0200
Message-Id: <20240307140728.190184-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
IP specific power domain as the driver has been modified to support
multiple power domains.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- used proper domain ID for IA55 interrupt controller

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 19bbcae01d80..f7a45fca5406 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -67,7 +67,7 @@ scif0: serial@1004b800 {
 					  "bri", "dri", "tei";
 			clocks = <&cpg CPG_MOD R9A08G045_SCIF0_CLK_PCK>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_SCIF0>;
 			resets = <&cpg R9A08G045_SCIF0_RST_SYSTEM_N>;
 			status = "disabled";
 		};
@@ -79,7 +79,7 @@ cpg: clock-controller@11010000 {
 			clock-names = "extal";
 			#clock-cells = <2>;
 			#reset-cells = <1>;
-			#power-domain-cells = <0>;
+			#power-domain-cells = <1>;
 		};
 
 		sysc: system-controller@11020000 {
@@ -104,7 +104,7 @@ pinctrl: pinctrl@11030000 {
 			interrupt-parent = <&irqc>;
 			gpio-ranges = <&pinctrl 0 0 152>;
 			clocks = <&cpg CPG_MOD R9A08G045_GPIO_HCLK>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_ALWAYS_ON>;
 			resets = <&cpg R9A08G045_GPIO_RSTN>,
 				 <&cpg R9A08G045_GPIO_PORT_RESETN>,
 				 <&cpg R9A08G045_GPIO_SPARE_RESETN>;
@@ -173,7 +173,7 @@ irqc: interrupt-controller@11050000 {
 			clocks = <&cpg CPG_MOD R9A08G045_IA55_CLK>,
 				 <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_IA55>;
 			resets = <&cpg R9A08G045_IA55_RESETN>;
 		};
 
@@ -188,7 +188,7 @@ sdhi0: mmc@11c00000  {
 				 <&cpg CPG_MOD R9A08G045_SDHI0_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A08G045_SDHI0_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_SDHI0>;
 			status = "disabled";
 		};
 
@@ -203,7 +203,7 @@ sdhi1: mmc@11c10000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI1_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A08G045_SDHI1_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_SDHI1>;
 			status = "disabled";
 		};
 
@@ -218,7 +218,7 @@ sdhi2: mmc@11c20000 {
 				 <&cpg CPG_MOD R9A08G045_SDHI2_ACLK>;
 			clock-names = "core", "clkh", "cd", "aclk";
 			resets = <&cpg R9A08G045_SDHI2_IXRST>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_SDHI2>;
 			status = "disabled";
 		};
 
@@ -235,7 +235,7 @@ eth0: ethernet@11c30000 {
 				 <&cpg CPG_MOD R9A08G045_ETH0_REFCLK>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A08G045_ETH0_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_ETHER0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -254,7 +254,7 @@ eth1: ethernet@11c40000 {
 				 <&cpg CPG_MOD R9A08G045_ETH1_REFCLK>;
 			clock-names = "axi", "chi", "refclk";
 			resets = <&cpg R9A08G045_ETH1_RST_HW_N>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_ETHER1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -280,7 +280,7 @@ wdt0: watchdog@12800800 {
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "wdt", "perrout";
 			resets = <&cpg R9A08G045_WDT0_PRESETN>;
-			power-domains = <&cpg>;
+			power-domains = <&cpg R9A08G045_PD_WDT0>;
 			status = "disabled";
 		};
 	};
-- 
2.39.2


