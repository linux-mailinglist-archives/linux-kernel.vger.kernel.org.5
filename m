Return-Path: <linux-kernel+bounces-7417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA781A7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6514F1C22B79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C20498AE;
	Wed, 20 Dec 2023 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBdbD/Ad"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E034879E;
	Wed, 20 Dec 2023 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso1244275e9.3;
        Wed, 20 Dec 2023 12:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703104573; x=1703709373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAeNatgENX3HfSxaqLZ4jbMgumQ+tBQiP8BhXetmc10=;
        b=VBdbD/AdvH8TniTMaaMSMJRNBP1KZXOKdwS9m1vJXG0LbfQt5wNWMEkDok91i8TeS0
         exUXWJZe6J/ipgZYrx9TY8Mzxi8fyt5dZaQkW100rjMWVVX1r8G4HvDVYDfeXD9cUIVT
         k6FKTqfKABffUvdfDzGiSJoBqRH32NIOQBSAlYFozgzmI8P3P0Uxj3ZlybGErYancdzu
         BnfgoCEiwuog97FjqFpPgU/vf4x/PZKDhsRm/mcciomE8wQAVeTN4VY7eqPvLW568qkH
         OlK24bzjHmm+g2+NEU1J/oVw67sxNi6hK085KfXVM/phjRAIKctmCsrU54enJcHgS5w4
         5CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703104573; x=1703709373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAeNatgENX3HfSxaqLZ4jbMgumQ+tBQiP8BhXetmc10=;
        b=cXwigdYdVkvrlMbL47DCZGQWeSFZ83pe3R3JnMbwyWCAZAk4Oml4OEtD5RO+y9d59W
         LveGojQnPJyRko14HtEcdt652jOFEo/vCjBXUzq2KQy42FEMTJbt3dg3QylFhMG+LXpg
         OHRq8ciBtdnaoK9+VTXtEs6bFQpXL4+0T0NF1rnYxAiFHLCA3a6VULlgG3WlNiUFSgGK
         sBufV9EkuXnHtaywlWRezgWhIhb1Blznq43np96Cmu5OnL0Blv3Tf3+n5DWPmNECCddd
         j+Ko2VIy+g2E6daw6228WlTvVG3mYPjj0B6UQhmg4KawJShmmiYNscyll5V6OM3oGaXP
         w/Gg==
X-Gm-Message-State: AOJu0YwsjXVb4oSK4YqZVgTh/U7Q1RykOZOVdntavGiEfIi4837HmJN7
	Arb97wAfs8TLPuaG4cZBd1s=
X-Google-Smtp-Source: AGHT+IG8O/e8IeFMn3xNIU6oCdHt0cDdgg6cfuGKM3ycqPI/asSdTF9PcYT8bYSKYB/qauPHaDDUKQ==
X-Received: by 2002:a05:600c:ad4:b0:40c:711:f492 with SMTP id c20-20020a05600c0ad400b0040c0711f492mr146701wmr.181.1703104572845;
        Wed, 20 Dec 2023 12:36:12 -0800 (PST)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8703224wmn.14.2023.12.20.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 12:36:12 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	wens@csie.org,
	samuel@sholland.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v5 2/3] arm64: dts: allwinner: orange-pi-3: Enable ethernet
Date: Wed, 20 Dec 2023 21:35:36 +0100
Message-ID: <20231220203537.83479-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220203537.83479-1-jernej.skrabec@gmail.com>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Orange Pi 3 has two regulators that power the Realtek RTL8211E
PHY. According to the datasheet, both regulators need to be enabled
at the same time, or that "phy-io" should be enabled slightly earlier
than "ephy" regulator.

RTL8211E/RTL8211EG datasheet says:

  Note 4: 2.5V (or 1.8/1.5V) RGMII power should be risen simultaneously
  or slightly earlier than 3.3V power. Rising 2.5V (or 1.8/1.5V) power
  later than 3.3V power may lead to errors.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 6fc65e8db220..6ed8613a3169 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -13,6 +13,7 @@ / {
 	compatible = "xunlong,orangepi-3", "allwinner,sun50i-h6";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 		serial1 = &uart1;
 	};
@@ -55,6 +56,17 @@ led-1 {
 		};
 	};
 
+	reg_gmac_2v5: gmac-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		off-on-delay-us = <100000>;
+		vin-supply = <&reg_vcc5v>;
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply directly from the DC jack */
 		compatible = "regulator-fixed";
@@ -113,6 +125,33 @@ &ehci3 {
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		/*
+		 * The board uses 2.5V RGMII signalling. Power sequence to enable
+		 * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
+		 * at the same time and to wait 100ms. The driver enables phy-io
+		 * first. Delay is achieved with enable-ramp-delay on reg_aldo2.
+		 */
+		phy-io-supply = <&reg_gmac_2v5>;
+		ephy-supply = <&reg_aldo2>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <40000>;
+	};
+};
+
 &gpu {
 	mali-supply = <&reg_dcdcc>;
 	status = "okay";
@@ -211,6 +250,7 @@ reg_aldo2: aldo2 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc33-audio-tv-ephy-mac";
+				regulator-enable-ramp-delay = <100000>;
 			};
 
 			/* ALDO3 is shorted to CLDO1 */
-- 
2.43.0


