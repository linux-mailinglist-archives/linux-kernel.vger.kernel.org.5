Return-Path: <linux-kernel+bounces-12409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4E981F460
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F60283AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D115B3;
	Thu, 28 Dec 2023 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr1s9yot"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A333C07;
	Thu, 28 Dec 2023 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-781708819c4so25624585a.1;
        Wed, 27 Dec 2023 19:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703733693; x=1704338493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+46J6+2KoeZZSgHS8eqkcEN7H/BVTk49hUInsE7T38=;
        b=Nr1s9yotz+cfodwH5AXc/kptGFXXqtj/HZa37anNUrQnETggAhauodpOTOaWtGS0WO
         HC+jxBOeMg23YPFeGtJj66njE/2gM0k5BQPu7gVwsQ5R2dFfRyiLpP5iJXdFF25eWob2
         fhPG07ZxiYyYmmrGmTaUYf1KCvKvWcWAwRWIjFh/HsROqu4kdOYBeABVdWX6PjOXu6jZ
         NAmzZ8h2e8/pXuC0Najrh6T3qStjXq46yogofj3ME7mhiaWQH7CyW3jdx2BOXNRQYypA
         YgEY3soY07BsMXX+Trcy7b2bP9PLFDNbaHb5Xt5XuJfCCsxRw8V7/E1bh8nYOq/zAdDM
         rPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703733693; x=1704338493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+46J6+2KoeZZSgHS8eqkcEN7H/BVTk49hUInsE7T38=;
        b=dQYgTXXntV4TVJDq9yOAkpXSHj6GCCn9kxy3hS8SuRwoayoPmXpkAe3cWeg48s4Afq
         4R7rRFcZUiicVPZt/06Aba+7N0bMDaLMscd0+ocee/gnSmx7fxAN455LMlHZUuVfs2K2
         KBtOmZlnqueLStHdedFdl/JEfNOnkdFvKYzi9ASR5MBc+HByUl3VqjeY/GxhzykDxXvx
         bW8CJYnOHcwwrI+WyyamQxoIEJg+NhbmiHi1jQc26yvBtS7QJVbWasUKPOqW2imNMxNc
         5G1LKCm9AuBa5qhpwDC6GiI17g+gEKJzFqzkLi7HixehWRMC9xFZERPjwWsY0OyXyVMw
         vFow==
X-Gm-Message-State: AOJu0Yw/gLLtsjuOiaAzgbXqIafckNx1TwIT1Kdj62UvFjALZVu/EFUs
	HESBXn8W4PUJazDa+iub8mU6Nxzv3FJpjA==
X-Google-Smtp-Source: AGHT+IEh/GynUMc484RkLckzzPYuuSTDz6/asR0WgSk8uLlMI48DAARuq7L2QIzSjOBuY2Ivj3ds9g==
X-Received: by 2002:ac8:5847:0:b0:427:ecee:fd01 with SMTP id h7-20020ac85847000000b00427eceefd01mr1795965qth.72.1703733693496;
        Wed, 27 Dec 2023 19:21:33 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id eq20-20020a05622a5e1400b004278e7f122esm3382294qtb.25.2023.12.27.19.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 19:21:33 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: "Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: nanopc-t6 sdmmc device tuning
Date: Thu, 28 Dec 2023 03:21:13 +0000
Message-ID: <20231228032114.1157-1-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1) sdmmc on the nanopc-t6 is powered by vcc3v3_sd_s0, not vcc_3v3_s3
   add the supply vcc3v3_sd_s0, and control it with gpio4_a5
2) add the card detection property gpio0_a4
3) drop max-frequency = <200000000> as it is already defined in rk3588s.dtsi
4) order no-sdio & no-mmc properties while we are here

Signed-off-by: John Clark <inindev@gmail.com>
---
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index e83b71510a47..2360735e58a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -159,6 +159,19 @@ vcc3v3_pcie30: vcc3v3-pcie30-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	vcc3v3_sd_s0: vcc3v3-sd-s0-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd_s0_pwren>;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_sd_s0";
+		vin-supply = <&vcc_3v3_s3>;
+	};
 };
 
 &combphy0_ps {
@@ -503,6 +516,12 @@ pcie_m2_1_pwren: pcie-m21-pwren {
 		};
 	};
 
+	sdmmc {
+		sd_s0_pwren: sd-s0-pwren {
+			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
 	usb {
 		typec5v_pwren: typec5v-pwren {
 			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -536,15 +555,15 @@ &sdhci {
 };
 
 &sdmmc {
-	max-frequency = <200000000>;
-	no-sdio;
-	no-mmc;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	no-mmc;
+	no-sdio;
 	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_3v3_s3>;
+	vmmc-supply = <&vcc3v3_sd_s0>;
 	vqmmc-supply = <&vccio_sd_s0>;
 	status = "okay";
 };
-- 
2.43.0


