Return-Path: <linux-kernel+bounces-68700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CE857E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB81286D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6DE12DD98;
	Fri, 16 Feb 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5kRviix"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ADE12CDB5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092302; cv=none; b=vDM9SKXan5mbEeWBzrwONb0laqhJzFmWhO38mc8EDsCdxfZ3pznkiA8HtAVyCBBlcls1hJNn4yPqtjCocbr0FqxR15t8x1w8LIx85IDwnkmoQWGNWUirb2tNEnkKCMuHvqI5Wg3GVOCxUKgrbp9ZqpNLPwFDTccKtOm4IIEpro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092302; c=relaxed/simple;
	bh=GrK2q7DlbtQY1WTzK5R2HznL/kcWzqoRab2apDhvAwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdvXJwPf3CbexGmqh1PgGAqH452IF1rjdoXCooNUihu+WmgqUQ55Ye+4guJ8kvc73Y1gVTva7dQ3M1dP0ABjAhM5x1Y4+FQ7z6rtXU60LZv514Gb1CHZ675pvP9W7zjAyXEg3I1d5fW9CtqOultFcQ+w1PJAkNmA5tsR+x31wMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5kRviix; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d10ae127ffso26405281fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708092298; x=1708697098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ7Tgql1DL0Frghi7Oag5F57dXBGRkIPbGxxgHm6Hxc=;
        b=F5kRviixUT2g4dXXaYzE5Qi4U7r2Fs9lIXFAJhsNm4wJtRp4l8gNFAt5guF2WeizA7
         DIiL33iiWT0KoO3XAhvBPhgDaDS07TTHZHoWo6mdpo7Ikw6AKyf1DfNEwOBcyUKzKfd3
         5SwIoUMli8IPxsh4YENSCJ5bswBmMNKv4xyGPz/FDCqU90wPDbrEYp4sLtRWxW/eE6RK
         ZzSiIzbQiL5GE9xo7+Avlf88zpNcNWXo9206uScGpAg/uAi116AgpXHII9EyLMHX6gxo
         VN0dAyDM/iINvkQoypyfXgHOGlN4FInoUujg69cklkU51sV4QExPm4Cm2npOD8PJKEWP
         dR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092298; x=1708697098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ7Tgql1DL0Frghi7Oag5F57dXBGRkIPbGxxgHm6Hxc=;
        b=B/U7SQoq0dXI941FbJjoP2c5SBf4dZBAVVSHla/aws0r1joCpNcyqBzCB3PTfxLEmd
         Di9U/K7BPbaFl3QCo0KBgbc6rq1Mc5pODomsQ2M5bFj8E677flal5kp39PbpYNoX5Cp7
         g8UEAKwx7jqbTzHSqTsDuT4CLAQ6FAjRH6oZ6CslICxhG+XJddDntoP82X5Sp/qW/hfP
         8u5cBIzP9x/oloqLGUs5qkLvzyf51Bmivo0H5MN+haRU4A7wpJz2QBgpWJE30Vaag+YJ
         hMSEPV21Bde61+4UFHdDHg8ByAlw89TgNC5wK71Y589IQEyN3b9a6J42k5xBK01d2g+U
         975g==
X-Forwarded-Encrypted: i=1; AJvYcCVrEmpb7Z+oYqTZ85f0NqMdsn6GI5dg/RaHyrj2kpohE30wDgsJUI9Zmz9gOAollDkcAj4MxPwXUqwt18JohprH/E1rfQ+r4FrEQTEn
X-Gm-Message-State: AOJu0YyIzgT2XXOYtbJmVPac+lUYeVQjw2B896jyqAnO0s4NQEc5/y1k
	3deKjc/7JxzXem3acJMyfv4EPwK2WTF5QDo2WeiOQE0x7MH5t9Gq9mq2jTqlKS0=
X-Google-Smtp-Source: AGHT+IGa96Bfo9g5nXjjGLG0eTx75/Ggxg2VA+hGJqraejkAQYX30I75/4p3/e+XG2Q57P8TXVx7Bg==
X-Received: by 2002:a2e:a686:0:b0:2cd:706a:8ec8 with SMTP id q6-20020a2ea686000000b002cd706a8ec8mr3392254lje.10.1708092298240;
        Fri, 16 Feb 2024 06:04:58 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b0040e4733aecbsm2516628wmb.15.2024.02.16.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:04:57 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 4/7] ARM: dts: samsung: exynos5420: specify the SPI FIFO depth
Date: Fri, 16 Feb 2024 14:04:46 +0000
Message-ID: <20240216140449.2564625-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
References: <20240216140449.2564625-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO depth. Drop the dependency on
the SPI alias and specify the SPI FIFO depth directly into the SPI node.

exynos5420.dtsi defines the following aliases:
	spi0 = &spi_0;
	spi1 = &spi_1;
	spi2 = &spi_2;
spi-s3c64xx.c driver defines the following fifo_lvl_mask for the
"samsung,exynos4210-spi" compatible:
	.fifo_lvl_mask  = { 0x1ff, 0x7F, 0x7F },
Thus spi0 was considered having a 256 byte FIFO depth, and spi1 and spi2
having 64 byte FIFO depth each. Update device tree with these FIFO depths.
No functional change expected.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos5420.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos5420.dtsi b/arch/arm/boot/dts/samsung/exynos5420.dtsi
index 25ed90374679..196c6d04675a 100644
--- a/arch/arm/boot/dts/samsung/exynos5420.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5420.dtsi
@@ -658,6 +658,7 @@ spi_0: spi@12d20000 {
 			pinctrl-0 = <&spi0_bus>;
 			clocks = <&clock CLK_SPI0>, <&clock CLK_SCLK_SPI0>;
 			clock-names = "spi", "spi_busclk0";
+			fifo-depth = <256>;
 			status = "disabled";
 		};
 
@@ -674,6 +675,7 @@ spi_1: spi@12d30000 {
 			pinctrl-0 = <&spi1_bus>;
 			clocks = <&clock CLK_SPI1>, <&clock CLK_SCLK_SPI1>;
 			clock-names = "spi", "spi_busclk0";
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
@@ -690,6 +692,7 @@ spi_2: spi@12d40000 {
 			pinctrl-0 = <&spi2_bus>;
 			clocks = <&clock CLK_SPI2>, <&clock CLK_SCLK_SPI2>;
 			clock-names = "spi", "spi_busclk0";
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
-- 
2.44.0.rc0.258.g7320e95886-goog


