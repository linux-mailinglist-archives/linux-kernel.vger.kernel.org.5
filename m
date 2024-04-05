Return-Path: <linux-kernel+bounces-133313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802E89A21A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C929A1C21EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53117166E;
	Fri,  5 Apr 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfTxJOBo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159E171079;
	Fri,  5 Apr 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333259; cv=none; b=p4qoB7TnE6m6ZyKm4YkX7AlXJrvXyNd+vwaPfjtu0qIfdLBR//XdNzgJEwrkanKoQSLRBxoGxyieAlGFfodRZGDgWO8B+sUFMRneD8+8hsfpZnvHSpIADfLww12LAroG1LkBniLpC3V8k6TgKIbPMT2ZDK5tusEbu2H67Rm027o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333259; c=relaxed/simple;
	bh=qBYmF0xGWXhV6hUCfu3HKLzpWqtGV+Hfy6dq9NOruFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESWiaj+sFEo3qKGd2+eDqygiTmyy10Ndl1GzooLXdE2d6TKGEsEqu3BWGCA4ArXpTNnjKCKLYEOJOpp/6gBbWxVLoMaEOS44UT93DKe6x/0QRNw/zCWdJJgQAEIyTPVPN6HMaTFp4JyHLbiU7/odNyAiumo/su2fmPDQfX1J7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfTxJOBo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4162e8210b6so7132425e9.0;
        Fri, 05 Apr 2024 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333256; x=1712938056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOce/01hbDzl8+x1yOJ/1AVGMenhuK+vsq/FsL52bf0=;
        b=QfTxJOBoC44vybqeQUC2SCY30Le0LyWnEt+EMLGBUUDvuk2wlvr7REnZ/bHPBx2Q76
         6c6/QZ5HSNR7UiNFdo204jUD3tqZTCVohec319Lql+q1PR9yb/lkP6PVM2h1ykjW8mph
         kvk3G5M0q4BUCN5wY97iOGfpFMC75ykCRCKZq7BrcGSX2nmN3Vc5wsDirzaRd1DW/mVW
         tMJLdmCPxYawOutpqbHC7OgXA6P3GBizXGsdUImZ8nMC7kD+UgyKN+Y4QfGyJ58MKL+P
         kYqNIit52Pfv/8yYt2EC9kmVPSqJ5/Zwl8ZBQHRTZGNIrqehGZfhU7xyWu4xmHlBzDow
         5qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333256; x=1712938056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOce/01hbDzl8+x1yOJ/1AVGMenhuK+vsq/FsL52bf0=;
        b=hcEUV2erkTE5UH5vfvePXgN4As6ErCnTMMXTNj0RnUaiMlZWQqgNR1i2MOCNWAgWng
         14CLE4irIHWjQIK6F3kkEyEbyC6bz0Zl4aGXcK+ZPrwSuY5HPYevv2k6csyEYcgGWkVv
         fL8X5eUMwQ7l/nI2wZGKNOGVNm/0JgOxyKK1Hr37DdsPwPisqHJwbGqsVbM7GbFoDRqF
         eu3Xfj3NByUwtSEipLm2AUECR2cnfp2ud57onKYsbVbuMmt/wZEpecoVYamB7S/n+kaI
         oBZLlLzYHz2b/wtTTqa1Q2QTNzjE/9cGDFKh7lfcuvO8rKOwG00Gz1U0zv6XUE91yLb1
         d39Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7diE6V2qRHxjuteIr0R0F0gLpYyWoL77s+zXpsQPbIkhqf+smFsU222BQKHOkvvgdFWTeHvVefhzoMgec2DyhRCSzFfurnBj6Ib7I
X-Gm-Message-State: AOJu0YzGAvOpC3HxeqsaKY22pQWvkqmmr5BN6+0duvtHpqqfbSoQFmoi
	+GLky/buD0NyIcLrK2xNbjB4yDdGpL0dLt+M1g7hV+m9o3B0wm1O
X-Google-Smtp-Source: AGHT+IHX223U4DsZ/xQPDPFZTq5ivcV0JxX0dpOp4Q0Djfm9YV+NtF1fazKA8gfSCWvEVdck2JLcjA==
X-Received: by 2002:a05:600c:3d88:b0:415:52f8:ca74 with SMTP id bi8-20020a05600c3d8800b0041552f8ca74mr1533482wmb.36.1712333256089;
        Fri, 05 Apr 2024 09:07:36 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:f624:ad13:2091:c808])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b004156c501e24sm6902651wms.12.2024.04.05.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:07:34 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 1/4] arm64: dts: freescale: imx8mp-verdin: replace sleep-moci hog with regulator
Date: Fri,  5 Apr 2024 18:07:17 +0200
Message-Id: <20240405160720.5977-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405160720.5977-1-eichest@gmail.com>
References: <20240405160720.5977-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The Verdin family has a signal called sleep-moci which can be used to
turn off peripherals on the carrier board when the SoM goes into
suspend. So far we have hogged this signal, which means the peripherals
are always on and it is not possible to add peripherals that depend on
the sleep-moci to be on. With this change, we replace the hog with a
regulator so that peripherals can add their own regulators that use the
same gpio. Carrier boards that allow peripherals to be powered off in
suspend can disable this regulator and implement their own regulator to
control the sleep-moci.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   |  5 ++++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi |  5 ++++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    |  5 ++++
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 26 ++++++++++++-------
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 7e9e4b13b5c5..e68e0e6f21e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -70,6 +70,11 @@ &flexspi {
 	status = "okay";
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+};
+
 /* Current measurement into module VCC */
 &hwmon {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index a509b2b7fa85..1a2520d4d6cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -93,6 +93,11 @@ &flexspi {
 	status = "okay";
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+};
+
 &gpio_expander_21 {
 	status = "okay";
 	vcc-supply = <&reg_1p8v>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index db1722f0d80e..27160024d5b5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -100,6 +100,11 @@ &flexcan1 {
 	status = "okay";
 };
 
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+};
+
 &hwmon_temp {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index faa17cbbe2fd..e523762947aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -116,6 +116,22 @@ reg_module_eth1phy: regulator-module-eth1phy {
 		vin-supply = <&reg_vdd_3v3>;
 	};
 
+	/*
+	 * By default we enable CTRL_SLEEP_MOCI#, this is required to have
+	 * peripherals on the carrier board powered.
+	 * If more granularity or power saving is required this can be disabled
+	 * in the carrier board device tree files.
+	 */
+	reg_force_sleep_moci: regulator-force-sleep-moci {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "CTRL_SLEEP_MOCI#";
+	};
+
 	reg_usb1_vbus: regulator-usb1-vbus {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -439,16 +455,6 @@ &gpio4 {
 			  "SODIMM_256",
 			  "SODIMM_48",
 			  "SODIMM_44";
-
-	ctrl-sleep-moci-hog {
-		gpio-hog;
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpios = <29 GPIO_ACTIVE_HIGH>;
-		line-name = "CTRL_SLEEP_MOCI#";
-		output-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
-	};
 };
 
 /* On-module I2C */
-- 
2.40.1


