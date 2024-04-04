Return-Path: <linux-kernel+bounces-131420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E588987A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34BD1F224E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D1130485;
	Thu,  4 Apr 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ZFzsCa"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79F12AAF6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233618; cv=none; b=S+wBYuqDhykoCHnrBAaRXSPTBxQ9HhhQNku2yQZbRumcVBRybHQ2LyuFh4VGvF1SuvkEykmYJY980xballG/eufnFO/lb5CkPdnCyibV6irGDcXlHitHoSbTafa6dF2bJgaym+hDbTmo7y3INAQNkZ8LzlucktbW6yofAUw5QEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233618; c=relaxed/simple;
	bh=ejQuHEJWi6awMdiuc+k/fjlF4OxL5L0R5RZeKGcDwqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prcbkkRFXseGmxZvzFXwpkNQAGsnIlTm8MYZqnn93wQao5mE1Aih4B6zRh7BMdUWQWRAUChKbW+em7fdis9FTSfzNsqX7rZiRzD1wD28b0UWjTbXcHgr0Ibt56TPOlVWoUsqCMpWJZbAGykL3g9UxOxEAzJSWjLUb4wyWk4+b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7ZFzsCa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3438f079ff5so562038f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233614; x=1712838414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrMh9hwB3p1Mipm20fbzkvpRap7meRfagxDyOlP4O3Q=;
        b=F7ZFzsCalzmyJU527aHXykRjjigxJwGcRkOonkNb23lUSLF4DnjQZiPr3YYpiSSX2C
         37NugQDFudSl2LhaWskfrXxzvFCq2iTSYp9lFcFrVNCBesmIGaN225zAFsKKvEh8jPT0
         qzGiyFecgtSW2mpucBZHgPP/zjlFiU3/C6H4ZCtqmIpQVl8nRMwZv7S1ScUODg1gMRiX
         0SEol1MRa0DaVy5sgu5pUbsGY26r2iXaJteLgR6bkE/7FofvciyRbUNDVsi08efFXvHZ
         vPs0QHhdJDQ51HJQmA5yUPuSpixXU0kNqLNx/HSW7q7gUwRjMMd0nfzjo4rBjWgfgAku
         RCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233614; x=1712838414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrMh9hwB3p1Mipm20fbzkvpRap7meRfagxDyOlP4O3Q=;
        b=vzHgAqhmmkC8qF3saOK8M87rtkM0DCQTgsiILRPZqQ/i6W7GBiNjPyW/t2Mj3JKUWw
         c46KIrF75EUvHUIaAVpRAW9p9SUB2dLHVTSdR/S9WEf2+18Ce0tgrixg1RaB9Y9eIpMv
         QuRonTvW5j/5VgD2AjLV0MHXA93BCTO9FEEONm9m6RvH71TK3Ams9aAprEMPuA595DeH
         MbHNETcUA+XLEvt8ZLhrAqwnjUK6+xvlUUX0J1euHab1ZMUhgzNRqbeUVXNrYVB6Zpip
         5DHQbN2ejHQyz8cqmEPQlrBm2PIrqSMNLZ5P3ZTKsKd4ouiJUJOAd+O/d3nhUVebELQW
         ihzw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHVtlaFa/8KDg+ZJlHY+zhsamm9oMMpqbOdTe78o/zyeFBgT1BnAjaFbdjMCn4EATmpwicz1t8pkYy0k6tfte1+5lTU0l+fAAD/hT
X-Gm-Message-State: AOJu0YxPAi5L6vrAk0TnIwEUR+m9BjM/PyKRdVOXLzRm6njufuOmhl+r
	1iu7i3TQB6HkM5MulbRI9TqhfwY5jvCEo6mY4X+RSB8cUfuolsqYqgXFohdmgeo=
X-Google-Smtp-Source: AGHT+IHRLGlRLu0X30aUGWPe4sFLm60kfPU9BGIq+xTElzJdF2I8vESH0PiWqjgNrWkApBN3qalkxw==
X-Received: by 2002:adf:f392:0:b0:343:67b1:9020 with SMTP id m18-20020adff392000000b0034367b19020mr1665840wro.61.1712233613749;
        Thu, 04 Apr 2024 05:26:53 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:26:53 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 07/17] arm64: dts: exynos: gs101: Add ufs, ufs-phy and ufs regulator dt nodes
Date: Thu,  4 Apr 2024 13:25:49 +0100
Message-ID: <20240404122559.898930-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the ufs controller, ufs phy and ufs regulator in device tree.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../boot/dts/exynos/google/gs101-oriole.dts   | 17 +++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  | 35 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 6be15e990b65..986eb5c9898a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -53,6 +53,14 @@ button-power {
 			wakeup-source;
 		};
 	};
+
+	ufs_0_fixed_vcc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "ufs-vcc";
+		gpio = <&gpp0 1 0>;
+		regulator-boot-on;
+		enable-active-high;
+	};
 };
 
 &ext_24_5m {
@@ -106,6 +114,15 @@ &serial_0 {
 	status = "okay";
 };
 
+&ufs_0 {
+	status = "okay";
+	vcc-supply = <&ufs_0_fixed_vcc_reg>;
+};
+
+&ufs_0_phy {
+	status = "okay";
+};
+
 &usi_uart {
 	samsung,clkreq-on; /* needed for UART mode */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 608369cec47b..9c94829bf14c 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1277,6 +1277,41 @@ pinctrl_hsi2: pinctrl@14440000 {
 			interrupts = <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		ufs_0_phy: phy@17e04000 {
+			compatible = "google,gs101-ufs-phy";
+			reg = <0x14704000 0x3000>;
+			reg-names = "phy-pma";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <0>;
+			clocks = <&ext_24_5m>;
+			clock-names = "ref_clk";
+			status = "disabled";
+		};
+
+		ufs_0: ufs@14700000 {
+			compatible = "google,gs101-ufs";
+
+			reg = <0x14700000 0x200>,
+			      <0x14701100 0x200>,
+			      <0x14780000 0xa000>,
+			      <0x14600000 0x100>;
+			reg-names = "hci", "vs_hci", "unipro", "ufsp";
+			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK>,
+				 <&cmu_hsi2 CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK>;
+			clock-names = "core_clk", "sclk_unipro_main", "fmp", "ufs_aclk", "ufs_pclk";
+			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+			phys = <&ufs_0_phy>;
+			phy-names = "ufs-phy";
+			samsung,sysreg = <&sysreg_hsi2 0x710>;
+			status = "disabled";
+		};
+
 		cmu_apm: clock-controller@17400000 {
 			compatible = "google,gs101-cmu-apm";
 			reg = <0x17400000 0x8000>;
-- 
2.44.0.478.gd926399ef9-goog


