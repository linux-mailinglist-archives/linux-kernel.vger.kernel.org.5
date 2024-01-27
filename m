Return-Path: <linux-kernel+bounces-40927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3683E839
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA781F22DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7AE4A30;
	Sat, 27 Jan 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZ49ZcO8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DEAA41
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314786; cv=none; b=DyTHWN2WiY4qRimNrm+edxIqdgStY4VScMx4fFpX8bie1aRASM68UZtNC3oNun/a7nEU0m+66rb2DdAM72PHdgsqJYmQ7I3R3VYUOLPrv5lVFJDGy0XBjyx6/Zt7mwOTiTLXMZSckUW81oqj7QL3Sy9U5K/1IGHleBjciVN6SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314786; c=relaxed/simple;
	bh=mt1OryDuqs3DMet12h/rXClGc4vsyv7QCDia4nAgj+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdXtAEbW+RDq2YCMif/eZycG26989j8JgrCgsICAnFS00A8VkGVoqkbecDChYYWzvqjJwsysPzAvLLvz2G5pB/JvLAiqtTHZdUqz2nA0YHm+5NDULWjoqkms2XHWqbqG9EQWpHjpsU+6V7waCw+y2PTUFgjX4TCM2QOi1NaoQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZ49ZcO8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ee9e21fcdso6859105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314782; x=1706919582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBB7Jgkv6YOdgGWMgcMeXyvXxAhw3u0NdEnmPufvl1Q=;
        b=ZZ49ZcO81JcUtBMNcu+dPNakqblMkjvhOKYMXhOi+Wu/uuNOe/rCXDnCG8jVDRGrad
         O+uXzOzL2oPikGMmBj44XTvC4bZyoXmMuDSHv7QRGBHwYbkYCZxr7L8wBhVdbgSuxC41
         ubtuk9heUrpGDOqtxEbDgsaSNb/ST61pXzfgywPUzxL07STg/SMRZqtNkRemgnQ/Aay4
         iT1luZEUOGXtnYQ99OJRXMFS1vFfD/1MImXbYwm48MFoO90CKBLr/bwPHFt1uy+KICto
         V66IzfZAmAPu5C29T6SZjCL1O5kPmCp44WLug9yAuyGtzQfTYyfzsgqV5EozXViU3Ixy
         1RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314782; x=1706919582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBB7Jgkv6YOdgGWMgcMeXyvXxAhw3u0NdEnmPufvl1Q=;
        b=dsTEPxQunZEK+t58HemgH9TAin4D8m4lStPXUq8UEfezxTIeTDsFKPj1u+0wtVcGph
         rDthG16s/PeyHbbuT2oBumOF40tiLsii+xNNv3e+8UZKbXuVoJ4CoPDtPalrAH4DeczQ
         67xIYd1l9XcBtWSON6DBylO2q2O4Ees8H+TtU65AFM7xWpYU88uifC0Bice5aRz2Nmuy
         A73KOKYx7Mzus0Rbon+ckmh5jej9S91kFfmb53oedjln7QjYS4aJqwnxyKqI71bUGoFM
         RXmPhZi1PhBYcnpAmCDnN30ON5Oe8/uCOagLsGpLN4OQNkoB1+SwUmz2pL3Bl1YPfduq
         eLsQ==
X-Gm-Message-State: AOJu0Yw6N07rp4PNXVFse/F4qQX6Jp7AIttnUcJfNJm+VaHaNp7JjYBV
	9Yre05Es5YJWd1XWy1kOOLD/AT1noBp+y42Mck7OrJcqKS/XF2JfuInpXsDn1MY=
X-Google-Smtp-Source: AGHT+IGiuExD6H+bO6/CNQBCw687J1YSJISaCGJ3M37DMubNfPY/sxFqr3y8lM7mLu9MRbtGEymu3g==
X-Received: by 2002:a05:600c:2301:b0:40e:692b:1b09 with SMTP id 1-20020a05600c230100b0040e692b1b09mr408211wmo.248.1706314782134;
        Fri, 26 Jan 2024 16:19:42 -0800 (PST)
Received: from puffmais.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a339d705a10sm1141359ejb.80.2024.01.26.16.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:19:41 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/9] arm64: dts: exynos: gs101: define USI12 with I2C configuration
Date: Sat, 27 Jan 2024 00:19:09 +0000
Message-ID: <20240127001926.495769-6-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240127001926.495769-1-andre.draszik@linaro.org>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On the gs101-oriole board, i2c bus 12 has various USB-related
controllers attached to it.

Note the selection of the USI protocol is intentionally left for the
board dts file.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 5088c81fd6aa..d66590fa922f 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -450,6 +450,36 @@ pinctrl_peric1: pinctrl@10c40000 {
 			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		usi12: usi@10d500c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d500c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1010>;
+			samsung,mode = <USI_V2_NONE>;
+			status = "disabled";
+
+			hsi2c_12: i2c@10d50000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d50000 0xc0>;
+				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c12_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+		};
+
 		pinctrl_hsi1: pinctrl@11840000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x11840000 0x00001000>;
-- 
2.43.0.429.g432eaa2c6b-goog


