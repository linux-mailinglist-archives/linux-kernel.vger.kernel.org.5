Return-Path: <linux-kernel+bounces-68697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14ED857E94
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1079B1C20D88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581812CD96;
	Fri, 16 Feb 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdMyNwUa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928D12C55A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092298; cv=none; b=iVnXPOcPBruB/q5OJL+EwuEVkv2oZJuJQGXm+m9qwfc+pHnVL9qgnHkRWtBxhWcwgC5sDd/7unSguvSOXst8GrtnmQQVc7/GpBxuubXpBypV31wsuW7QlBj0w3eZedFgVeZG7i9aU4N3WgXZFgKQYThuUy7R4EpCCtA8+tq7rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092298; c=relaxed/simple;
	bh=HDNgmS+3ogSjgiCNBf1Deadap09cRpyjDSGis2o1YZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbeAyETeCLtQ0zym3n068yLTk2V1kou9n5tFPTBokKZ/JIkXESGYNXlXtbyOs/bIVEAcCBHsRbf5Bpoim8cn9b2giD7tw3HuzsYnC5NN+4lCjDS87s0TrXDISe8Swl0XNuV6MYwWHdvbJjRakkr/PTyKJdk1CMe6zO28UKCqyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdMyNwUa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412345cca4eso8511675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708092294; x=1708697094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrxlwaASewIQ6feU++ZcduImlXFDGQ5ONYqoRVrmdoU=;
        b=cdMyNwUafbA9hqcDSAh8tedNTm3w87lEPlgDIYMSuut5z72gXUDOFjj4mSEkZ3SxU2
         yaVbS9IPSoqc2xzTvU6GEzdOJwjV2zNJ/QLN7PK0eQMy11BXwjTHazUC28IWbh/jkrc8
         iEo1OMqo7GfkgNXuKPUvUgjJq2KkpCiW9vSNkF15Ki97vbNpknriJaLKGyXGH7ktb/4a
         U1GFH5BqaDtbBU8E2NzjqSaMth6yKH2FEesnHthE4Sr8jdJhA1cPF1u3cJ4nMvpn8xLH
         poRgn5e7r4bibPXwujI6ln02HubIR7W0LkEeKa/3cgm3KTNUe8jihB0W3VQctaZQ5w6S
         ngOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092294; x=1708697094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrxlwaASewIQ6feU++ZcduImlXFDGQ5ONYqoRVrmdoU=;
        b=qO2ZrbfzgKx8zyY3JMVdsF45tZaRfuqidRLh2asUNKnXTnzoEWoMHwU1uu6UG49yIL
         g+jfEAbl2jTwyrNCMFPIGWE3aMebuBHDAG1TVQsDGse3kiIaV0bPykuafMiKISpl+Zwv
         dZVjXCcRB1lVOaccC68VURY9Pw2fYtIYCZqFgJ9IYAQ6Dt17sop6Quti8voZLtq62+Gx
         FNzb8p8U9Dfp+AXvVLTCOmqStNnpUiyW4iHXyScewTCFMUh/SPYYxmvq9q6ttqxwWtv5
         TrOSJxUMc+pv4aXBk19QY4GKZTVuM2SA02ohX9C/3EIi+JOWtCXC7/JCI7VyPXc3GZE0
         rS5g==
X-Forwarded-Encrypted: i=1; AJvYcCVrI7ow6Pv6rZOZOyN/7gwGAg7rrkVBJHiSrHQM59N4j2lcUj/RfuYf1GZcPc/b431W1uuRjTLC6moust8y3WPmDv0V7bW53bgtpTWx
X-Gm-Message-State: AOJu0YxfSwtgwtNR+AHkThbVy4dbri6rGKWxEZN6grJR54hHsbiWZgvu
	nOY9+khUX3IMjQabPQZl2aoF8SVlbcGJGtOpjb0WFYTZqKnpyuZdWJ3KYTNnA7E=
X-Google-Smtp-Source: AGHT+IHSlJ3rucUOL0Zw2GCONTp7NyIN4EdB7mlSGdfVkmD/nmUTez9Qm1aP3coAcdNLg1PVao+wKA==
X-Received: by 2002:a05:600c:6019:b0:411:6f3f:4950 with SMTP id az25-20020a05600c601900b004116f3f4950mr3966135wmb.32.1708092294570;
        Fri, 16 Feb 2024 06:04:54 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b0040e4733aecbsm2516628wmb.15.2024.02.16.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:04:53 -0800 (PST)
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
Subject: [PATCH v2 1/7] ARM: dts: samsung: exynos3250: specify the SPI FIFO depth
Date: Fri, 16 Feb 2024 14:04:43 +0000
Message-ID: <20240216140449.2564625-2-tudor.ambarus@linaro.org>
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

exynos3250.dtsi defines the following aliases:
	spi0 = &spi_0;
	spi1 = &spi_1;
spi-s3c64xx.c driver defines the following fifo_lvl_mask for the
"samsung,exynos4210-spi" compatible:
	.fifo_lvl_mask  = { 0x1ff, 0x7F, 0x7F },
Thus spi0 was considered having a 256 byte FIFO depth, and spi1 a 64
byte FIFO depth. Update device tree with these FIFO depths. No
functional change expected.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos3250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos3250.dtsi b/arch/arm/boot/dts/samsung/exynos3250.dtsi
index 3f1015edab43..b6c3826a9424 100644
--- a/arch/arm/boot/dts/samsung/exynos3250.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos3250.dtsi
@@ -826,6 +826,7 @@ spi_0: spi@13920000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
+			fifo-depth = <256>;
 			status = "disabled";
 		};
 
@@ -842,6 +843,7 @@ spi_1: spi@13930000 {
 			samsung,spi-src-clk = <0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
-- 
2.44.0.rc0.258.g7320e95886-goog


