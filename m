Return-Path: <linux-kernel+bounces-48700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F77845FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109D41C23B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012B82C69;
	Thu,  1 Feb 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFKsMsxv"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B15A4E3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812229; cv=none; b=Wje6li+IhPqx76nZ0+iFBMQ8MVU6OCVmv4jtxhrrboEhzBK2AJSjBxZbPztTSJY/BNrEfZzad5j07mM/jVlKMmD3BRDR9pJ7RymCm+uFY3Gh4Pp7uLLysN+OzoLU4ZWzIfvzzSlF254SGk1iiP/+h8w6pJthcB5ZApjkF3XaBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812229; c=relaxed/simple;
	bh=YOpG66inrFrMSwtv9eZafv0ehvPXILbRNjY8udD6h50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hsSYlvvszODYwlUmIAv2ggbSNV9vHAmP3PtuknuZyRTxs7kEvauqm1pmDc1COs2yncjZMHPMrnTtWPn85/9yFWahuRWN6rBgywtY6olV8aHFCGoAn/8BLBfDXA7QC9tnIbcAozMe3Xn+qNasBgwLSozj3q9SGsThZiXw+jA6MTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFKsMsxv; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21432e87455so496330fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706812226; x=1707417026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEBlakKpXhkMju4MTgD7U/BUFtYGwg9dDqJk1HWfuik=;
        b=iFKsMsxvs4hQhVBixJNqD+meKjiPJkTBf4auOjSJzwZYT8k+9uYkdO/7FzLcgZmrqV
         1YOBo3xYIyl6eh/ret3TSopf884h2UO0/ytUBMtod/YvWIABswoBVe7mnJhr4mIA0ls0
         u4hClDGnvTHQMBzJV6azzo3uDkZLerziL7+Xi0QTxOzbU03/c7YnXUeVR5WXmP252Wo4
         0yGOkBXDiEl/hJ47Ns2zLwZRNEgHM6EbfnBoGepUw+BGy4Q2IdCMRxdS4xTFNrHPY/15
         YxPdUXNzHUANVV/sV9kOYB8szcZ+qNL2Z5nnQXmrCtEgRJbJ96wCXafOnub8O2SvT83Q
         DN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812226; x=1707417026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEBlakKpXhkMju4MTgD7U/BUFtYGwg9dDqJk1HWfuik=;
        b=ez5Sg3g1wEpiHqrGXGKmQuk86ygsjefD0d7e3d+GBdey2Got13HiL0WFZT8q5op7/S
         Z6BDlrGpd7OU9T9707wt+6YGoTdqQNDV6QOk7bu9nhraJIXaO1uyZ30sKy8e7m/GOlRB
         +GlH+Ty7Apb4CNf36eEqdOGvFuNK/7K67e3xmFO6UKMdpUrYX4uj/BYUIIg/c/r50rif
         dVBv2894iTmjMtvttHqs3/9Y5PVU1ePuECDlUZIOdEzdCaGVFBHKkcvjM0OkFoa17WXA
         g2u7z36M1WCMOdJQbf63lgPOGr8Jw+5+XNUf2rU5rrlqNdTpL2/nuN0siUKge7jLDDtE
         ZK6A==
X-Gm-Message-State: AOJu0Yys3b6j9RnrfUC4MjFMcO6HmmPmVb4iX3DHjdvWXt5BDGPueP0h
	iJjEeDmVoxfvGY+YSs881yDbL3qFJDUduoMOZwIsL2nKCxCbZnJGlbyOONf6NXI=
X-Google-Smtp-Source: AGHT+IGvU1Hr9KV+JcFuynpKsFYqhObRqS3gz9n5UpwTaJGoNK/wmEI63CqcjSmn2b7HBkwokd9R+w==
X-Received: by 2002:a05:6870:89a4:b0:218:6d38:1634 with SMTP id f36-20020a05687089a400b002186d381634mr6558727oaq.3.1706812226468;
        Thu, 01 Feb 2024 10:30:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPxLRHwJnG71yuUhivG/Ed9sMCzqJ70Kw/+v8sZgZcIEeNLyMLrW3BuRXquOnPRHJS21n4dMXUsBLAf/JZhzoVGMYa9cZxe6zp/zj+a7dJJJjK4QtwVLeHhvDkZCTWEuBaMaK9mti9c+Dk5U1++pslPZCmyi3PiaOD7sejkZIxDMYaDHqN45hY3cy3Fcwb1CvMdzwbjeQtooVc/2ykAg2P+u5ETT22RvAxxQ3u/7sGetw=
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id z5-20020a05683008c500b006e11d2e358bsm56737otg.40.2024.02.01.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:30:26 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: exynos: Add SPI nodes for Exynos850
Date: Thu,  1 Feb 2024 12:30:25 -0600
Message-Id: <20240201183025.14566-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some USI blocks can be configured as SPI controllers. Add corresponding
SPI nodes to Exynos850 SoC device tree.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20240125013858.3986-4-semen.protsenko@linaro.org
[krzysztof: order properties according to DTS coding style]
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - Fix dtschema warnings by specifying "spi" as a first clock

Changes in v2:
  - Sorted pinctrl properties properly

 arch/arm64/boot/dts/exynos/exynos850.dtsi | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index e7e1171a3864..2ba67c3d0681 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -738,6 +738,24 @@ usi_spi_0: usi@139400c0 {
 				 <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
 			clock-names = "pclk", "ipclk";
 			status = "disabled";
+
+			spi_0: spi@13940000 {
+				compatible = "samsung,exynos850-spi";
+				reg = <0x13940000 0x30>;
+				clocks = <&cmu_peri CLK_GOUT_SPI0_PCLK>,
+					 <&cmu_peri CLK_GOUT_SPI0_IPCLK>;
+				clock-names = "spi", "spi_busclk0";
+				dmas = <&pdma0 5>, <&pdma0 4>;
+				dma-names = "tx", "rx";
+				interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi0_pins>;
+				pinctrl-names = "default";
+				num-cs = <1>;
+				samsung,spi-src-clk = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		usi_cmgp0: usi@11d000c0 {
@@ -779,6 +797,24 @@ serial_1: serial@11d00000 {
 				clock-names = "uart", "clk_uart_baud0";
 				status = "disabled";
 			};
+
+			spi_1: spi@11d00000 {
+				compatible = "samsung,exynos850-spi";
+				reg = <0x11d00000 0x30>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI0_PCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI0_IPCLK>;
+				clock-names = "spi", "spi_busclk0";
+				dmas = <&pdma0 12>, <&pdma0 13>;
+				dma-names = "tx", "rx";
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi1_pins>;
+				pinctrl-names = "default";
+				num-cs = <1>;
+				samsung,spi-src-clk = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		usi_cmgp1: usi@11d200c0 {
@@ -820,6 +856,24 @@ serial_2: serial@11d20000 {
 				clock-names = "uart", "clk_uart_baud0";
 				status = "disabled";
 			};
+
+			spi_2: spi@11d20000 {
+				compatible = "samsung,exynos850-spi";
+				reg = <0x11d20000 0x30>;
+				clocks = <&cmu_cmgp CLK_GOUT_CMGP_USI1_PCLK>,
+					 <&cmu_cmgp CLK_GOUT_CMGP_USI1_IPCLK>;
+				clock-names = "spi", "spi_busclk0";
+				dmas = <&pdma0 14>, <&pdma0 15>;
+				dma-names = "tx", "rx";
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-0 = <&spi2_pins>;
+				pinctrl-names = "default";
+				num-cs = <1>;
+				samsung,spi-src-clk = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.39.2


