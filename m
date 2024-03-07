Return-Path: <linux-kernel+bounces-95671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A787511A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A451F246CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2912D776;
	Thu,  7 Mar 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K001xyx0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594384FAF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819959; cv=none; b=SvWWcd5mBcCztllx8WUXTrjpNnzU+aAlDxPSj67b9rVCxJ0qr8MCFBxFpmp2ylVIK9veb9cVnC567krYpD16V77HkV3ptzBd5cU7BQMDA+5BIvkXMq0RXQXp4/BY8KybHcsyenjzt1YiEuWuDyLbbFxQi3JHY3UHfHONKt77ZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819959; c=relaxed/simple;
	bh=Q8yPhYunCvRtCEt5j0Lyn+xfPTEUjNIl+V+OS7iUpZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGS3sBEubXTg5q1Nip+VJWTEW5sZK7aho6ybP/7AAYeV7VX1OaZGRmD18jlBo8ORmfTRW8iiPUMpyT1mFjUXMp6itr6XLBOivSiA8PI/z3+NbQF3+K7dAmWiU3fZsDUv03wMJ+s1ZS+fAQ3e2TlxlRANKyNkh01Xhdyk+zFyIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K001xyx0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412f988b601so7675505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709819955; x=1710424755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dB9LeY93KgRhL8X6WzeK0B0CPWFmXsURfjFByNZIKL4=;
        b=K001xyx0Co4cLfVzrBUAUfNgWR4B5VpMtaMWZFUwawLKaZ3/CzriGK3CyUirPAv7lj
         5zUh9wU/HQC2kmUOh+MNWSSG3cZvPdh2AtRiyENiS6TWtWiOc6dxjoHDo2hEOMorrIOe
         jk0Mz2TfJgXOyYlBQVMXg6KYnYj1QXo8NzruGMVF5cJnfSLu/XOaZuwenRAXZu06CtGc
         XkoUnFxvS9JKcGwqH54XCSHzEYvLNoM3uWicdxGZCC9bldoJsfZ0ZcNdqnOZTSPCreJq
         Y3QqQPv2HDtuSo1NU/AsX94rP3gx4NLw+0uI2tb1QKQ6nJ46bkjoR6yPy41hYAYSgZ2g
         MMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709819955; x=1710424755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB9LeY93KgRhL8X6WzeK0B0CPWFmXsURfjFByNZIKL4=;
        b=hNcOCgh7XSDg3nXl8IAuNA9eHqoNJ9A4jCTb8CL7t0Jgdnq1p0LhoFc3e1kx4WzolC
         6nwjiQ5iqQ60QCemrGaAsVL3uAzodUuzkZH33gAev+RY+7z7xHF3+KLWLzIVlqQ24Fmw
         ZMcE3PSPS9GfJZws269puAgy2wbY9SqE8/Mq/lLIzHGT1bhxjoCLfmW+F44Z5obMOC1i
         DeV4Msutf6W6cvCx+8PD40mVXwc7CiTtgCmusrIlo79wS0bFCOzzwUeEeXEoa+Lkfa9N
         7ZMAtezboBYiYe3IM9UqzPqu3RqJWOCi4fFhFvN/KWw9x2TjpZvlBD5BY4TCfUvaz108
         Rxxg==
X-Forwarded-Encrypted: i=1; AJvYcCU6AjPSPYHkoJzJaTVkIlSCgJvQdExMZjjjKDSuweKqmi8zP5XOWN0iXQxvpGuJsdTzdtHhIOLI2KPiEfWPVVPj5VzVACSeAoDk+eTJ
X-Gm-Message-State: AOJu0YyCRi98N+XHZSRA4eG888pqVLI7pAhAFdkf8KqntvunMj0gR8SQ
	lZZhY3vT9JvTwtHUERLhNrQlEoq7CusF7Y3Crrm81sQgreT//T1NGXCjkT2iOGM=
X-Google-Smtp-Source: AGHT+IHCaOKUkwvr/ycYH5nl2xFHhSW3z6SJcU9zd7ngoCL4WiLC9L473cYvrnUzGtoOHOsmwb5mQw==
X-Received: by 2002:a05:600c:4586:b0:412:f8cd:cda4 with SMTP id r6-20020a05600c458600b00412f8cdcda4mr3120764wmo.14.1709819954703;
        Thu, 07 Mar 2024 05:59:14 -0800 (PST)
Received: from ta2.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c419300b0041294d015fbsm2690328wmh.40.2024.03.07.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:59:14 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] arm64: dts: exynos: gs101: define all PERIC USI nodes
Date: Thu,  7 Mar 2024 13:59:12 +0000
Message-ID: <20240307135912.163996-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Universal Serial Interface (USI) supports three types of serial
interface such as UART, SPI and I2C. Each protocol works independently.
USI can be configured to work as one of these protocols. Define all the
USI nodes from the PERIC blocks (USI0-14), in all their possible
configurations. These blocks have the TX/RX FIFO depth of 64 bytes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Please note that:
- google,gs101-spi compatible was queued through the SPI tree:
  https://lore.kernel.org/linux-arm-kernel/170742731537.2266792.3851016361229293846.b4-ty@kernel.org/
- SPI dma properties were marked as not requiered. Queued through the
  SPI tree:
  https://lore.kernel.org/linux-spi/170967132774.228925.1759895846287455970.b4-ty@kernel.org/

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 782 +++++++++++++++++++
 1 file changed, 782 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index ee65ed9d2cfc..d7ecfbc7e440 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -373,6 +373,398 @@ pinctrl_peric0: pinctrl@10840000 {
 			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		usi1: usi@109000c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109000c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1000>;
+			status = "disabled";
+
+			hsi2c_1: i2c@10900000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10900000 0xc0>;
+				interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c1_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_1: serial@10900000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10900000 0xc0>;
+				interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_1: spi@10900000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10900000 0x30>;
+				interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi1_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_0>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_0>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi2: usi@109100c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109100c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_1>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1004>;
+			status = "disabled";
+
+			hsi2c_2: i2c@10910000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10910000 0xc0>;
+				interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c2_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_1>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_2: serial@10910000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10910000 0xc0>;
+				interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart2_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_1>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_2: spi@10910000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10910000 0x30>;
+				interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_1>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_1>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi3: usi@109200c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109200c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_2>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1008>;
+			status = "disabled";
+
+			hsi2c_3: i2c@10920000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10920000 0xc0>;
+				interrupts = <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c3_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_2>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_3: serial@10920000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10920000 0xc0>;
+				interrupts = <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart3_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_3: spi@10920000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10920000 0x30>;
+				interrupts = <GIC_SPI 637 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi3_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_2>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi4: usi@109300c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109300c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_3>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x100c>;
+			status = "disabled";
+
+			hsi2c_4: i2c@10930000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10930000 0xc0>;
+				interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c4_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_3>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_4: serial@10930000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10930000 0xc0>;
+				interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart4_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_3>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_4: spi@10930000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10930000 0x30>;
+				interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi4_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_3>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_3>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi5: usi@109400c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109400c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_4>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1010>;
+			status = "disabled";
+
+			hsi2c_5: i2c@10940000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10940000 0xc0>;
+				interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c5_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_4>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_5: serial@10940000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10940000 0xc0>;
+				interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart5_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_4>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_5: spi@10940000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10940000 0x30>;
+				interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi5_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_4>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_4>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi6: usi@109500c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109500c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_5>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1014>;
+			status = "disabled";
+
+			hsi2c_6: i2c@10950000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10950000 0xc0>;
+				interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c6_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_5>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_6: serial@10950000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10950000 0xc0>;
+				interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart6_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_5>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_6: spi@10950000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10950000 0x30>;
+				interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi6_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_5>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_5>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi7: usi@109600c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109600c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_6>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1018>;
+			status = "disabled";
+
+			hsi2c_7: i2c@10960000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10960000 0xc0>;
+				interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c7_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_6>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_7: serial@10960000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10960000 0xc0>;
+				interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart7_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_6>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_7: spi@10960000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10960000 0x30>;
+				interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi7_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_6>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_6>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		usi8: usi@109700c0 {
 			compatible = "google,gs101-usi",
 				     "samsung,exynos850-usi";
@@ -400,6 +792,33 @@ hsi2c_8: i2c@10970000 {
 				clock-names = "hsi2c", "hsi2c_pclk";
 				status = "disabled";
 			};
+
+			serial_8: serial@10970000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10970000 0xc0>;
+				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart8_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_8: spi@10970000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10970000 0x30>;
+				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi8_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		usi_uart: usi@10a000c0 {
@@ -431,6 +850,62 @@ serial_0: serial@10a00000 {
 			};
 		};
 
+		usi14: usi@10a200c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10a200c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1028>;
+			status = "disabled";
+
+			hsi2c_14: i2c@10a20000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10a20000 0xc0>;
+				interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c14_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_14: serial@10a20000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10a20000 0xc0>;
+				interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart14_bus_single>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_14: spi@10a20000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10a20000 0x30>;
+				interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi14_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		cmu_peric1: clock-controller@10c00000 {
 			compatible = "google,gs101-cmu-peric1";
 			reg = <0x10c00000 0x4000>;
@@ -453,6 +928,230 @@ pinctrl_peric1: pinctrl@10c40000 {
 			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		usi0: usi@10d100c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d100c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1000>;
+			status = "disabled";
+
+			hsi2c_0: i2c@10d10000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d10000 0xc0>;
+				interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c0_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_usi0: serial@10d10000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d10000 0xc0>;
+				interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_0: spi@10d10000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d10000 0x30>;
+				interrupts = <GIC_SPI 651 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi0_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_1>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_1>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi9: usi@10d200c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d200c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1004>;
+			status = "disabled";
+
+			hsi2c_9: i2c@10d20000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d20000 0xc0>;
+				interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c9_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_9: serial@10d20000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d20000 0xc0>;
+				interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart9_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_9: spi@10d20000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d20000 0x30>;
+				interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi9_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_2>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_2>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi10: usi@10d300c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d300c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1008>;
+			status = "disabled";
+
+			hsi2c_10: i2c@10d30000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d30000 0xc0>;
+				interrupts = <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c10_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_10: serial@10d30000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d30000 0xc0>;
+				interrupts = <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart10_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_10: spi@10d30000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d30000 0x30>;
+				interrupts = <GIC_SPI 653 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi10_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_3>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_3>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi11: usi@10d400c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d400c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x100c>;
+			status = "disabled";
+
+			hsi2c_11: i2c@10d40000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d40000 0xc0>;
+				interrupts = <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c11_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_11: serial@10d40000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d40000 0xc0>;
+				interrupts = <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart11_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_11: spi@10d40000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d40000 0x30>;
+				interrupts = <GIC_SPI 654 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi11_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_4>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_4>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		usi12: usi@10d500c0 {
 			compatible = "google,gs101-usi",
 				     "samsung,exynos850-usi";
@@ -480,6 +1179,89 @@ hsi2c_12: i2c@10d50000 {
 				clock-names = "hsi2c", "hsi2c_pclk";
 				status = "disabled";
 			};
+
+			serial_12: serial@10d50000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d50000 0xc0>;
+				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart12_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_12: spi@10d50000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d50000 0x30>;
+				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi12_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		usi13: usi@10d600c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x10d600c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1014>;
+			status = "disabled";
+
+			hsi2c_13: i2c@10d60000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10d60000 0xc0>;
+				interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-0 = <&hsi2c13_bus>;
+				pinctrl-names = "default";
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+
+			serial_13: serial@10d60000 {
+				compatible = "google,gs101-uart";
+				reg = <0x10d60000 0xc0>;
+				interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart13_bus_single>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6>;
+				clock-names = "uart", "clk_uart_baud0";
+				samsung,uart-fifosize = <64>;
+				status = "disabled";
+			};
+
+			spi_13: spi@10d60000 {
+				compatible = "google,gs101-spi";
+				reg = <0x10d60000 0x30>;
+				interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi13_bus>;
+				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_6>,
+					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_6>;
+				clock-names = "spi", "spi_busclk0";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		pinctrl_hsi1: pinctrl@11840000 {
-- 
2.44.0.278.ge034bb2e1d-goog


