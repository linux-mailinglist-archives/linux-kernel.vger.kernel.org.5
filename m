Return-Path: <linux-kernel+bounces-7887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B643781AEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B161C22CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE1B66F;
	Thu, 21 Dec 2023 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYrgUvGK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617CD29B;
	Thu, 21 Dec 2023 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4258e0a0dc1so2722621cf.2;
        Wed, 20 Dec 2023 22:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703139772; x=1703744572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oicQw30BJ+q561uERyycEbFIITiqVpsdX1mLBXefP0=;
        b=eYrgUvGKD6Uj6I6wwX1D6YZ/YnY7lLr7ygMiXZgW/oZflQBUZ2Ajt4IAxnB6+qq8KE
         tGy/U5vNFJv+6Ulyj33yAeZs5SU95sq2hqFhiKfGLE/C22Zi0xuK4utXW9XxXqHbdUCM
         mscvH+oHMXWdRiGgElXyyXRZStCFtyzBrNB5aleeNTJMU72kb4WL2D4Fl24Y4lyLyFuC
         Cio5H6ZejtNzaCYVJ5uZoQFhv9jZBlrUZcgusNNDaUebanBB7Wahdvaxrtv/J9gSzLwF
         tukaYlhn6VLg056JzGTfwI3uLCnsVxnAIGeejcqUsE7e8b2nc+9P3JI150SF6ffhEqWJ
         xYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703139772; x=1703744572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oicQw30BJ+q561uERyycEbFIITiqVpsdX1mLBXefP0=;
        b=qvuAvFx8iatPjE9HiZoX97WI6SzymVVIBZSYHecO85OOslwgimPj3/Qx882O1PnQTt
         n/dV/xMz1/gwfQ0RNOYtHjXcVdDQ46xv/LfU9MrKoEVEM7+iBj1JOURR4sATqrnlDFj0
         6O6ZAeC8MYFk3+LBQTBIaLOt+Z7fVkSLz5+3Bx1L0Ob5F4ZiZpEjN49pyxLENs1jE5/A
         p2mp7Du7nrP4JPyCBcsr08HuRL6y5r92U1ExkNiJvQvt9v1jTqtPQoo7MPUmQOKyRBtS
         fvgXg7KtH9voRQl1PzCPtJDIxJBwuIx444XZaF3N9oyDo4fOpNaIUxlWoDRKGz/cvXI2
         tarA==
X-Gm-Message-State: AOJu0YyEt0aWerpW09sfeyQsQ9gRRLs1H2KNwa1bLjjEW2omqWQO21Ae
	3SBAGDz14Ha+ESmJlw3/i1gaX1d1XPY=
X-Google-Smtp-Source: AGHT+IGGrXr6od3Xnzv0hQ58M53pYl57Os9KxVGrAWT80bNwlHb5oG8VG8zNQqoXIT8baQRc+vwU6g==
X-Received: by 2002:a05:622a:1485:b0:427:7319:69f0 with SMTP id t5-20020a05622a148500b00427731969f0mr5578789qtx.77.1703139771551;
        Wed, 20 Dec 2023 22:22:51 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id t10-20020ac86a0a000000b0042596cbb8f0sm556928qtr.36.2023.12.20.22.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 22:22:50 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: rockchip: dts: rk3328-rock-pi-e: enable GbE eth
Date: Thu, 21 Dec 2023 01:22:43 -0500
Message-ID: <20231221062244.11871-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the device-tree to get the GbE interface working using a patch found
on the Radxa forum.

Link: https://forum.radxa.com/t/rock-pi-e-board-version-1-21-ethhernet-not-working-in-armbian/15061/3
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 3cda6c627b68..41224a222048 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -148,7 +148,7 @@ &gmac2io {
 	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
 	assigned-clock-parents = <&gmac_clkin>, <&gmac_clkin>;
 	clock_in_out = "input";
-	phy-handle = <&rtl8211e>;
+	phy-handle = <&rtl8211f>;
 	phy-mode = "rgmii";
 	phy-supply = <&vcc_io>;
 	pinctrl-names = "default";
@@ -156,8 +156,8 @@ &gmac2io {
 	snps,aal;
 	snps,rxpbl = <0x4>;
 	snps,txpbl = <0x4>;
-	tx_delay = <0x26>;
-	rx_delay = <0x11>;
+	tx_delay = <0x1a>;
+	rx_delay = <0x14>;
 	status = "okay";
 
 	mdio {
@@ -165,15 +165,17 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rtl8211e: ethernet-phy@1 {
+		rtl8211f: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
 			pinctrl-names = "default";
 			interrupt-parent = <&gpio1>;
 			interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <50000>;
+			reset-assert-us = <20000>;
+			reset-deassert-us = <100000>;
 			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+			max-speed = <1000>;
 		};
 	};
 };
-- 
2.43.0.76.g1a87c842ece3


