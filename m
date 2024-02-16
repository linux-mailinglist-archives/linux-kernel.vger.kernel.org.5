Return-Path: <linux-kernel+bounces-68701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9998857EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC2D1C25705
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B512E1E6;
	Fri, 16 Feb 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1FJGFiP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516D12D765
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092304; cv=none; b=UEsQDNfqpP6OVleeBj8OTlyIVIUjGc0/7dkpx9KeEzCNxXzf6CezR3j11FVTat86UxpfUaW5mAte2qf5CC5d2cgIMlByfqzm3fc5rcWNoNlyQerLUDpUTdghRK38GwvKkXAxoMJa/hK7ikYlqE7qNF+G7eianFhN60swYgc6b68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092304; c=relaxed/simple;
	bh=pbz+IkgS7dGub+xGhkr3c/sezMbM4xsciLvnrgZeQc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxaKZkA8LGZGs/oWn7rDbAc/VBGME4cVch51TexqgcwLfWp07TggenDtl/Bg4Vi369BDUW/iVaeOSAaL2KG6JEyJE8bWxFYjdoVlu8FK0Qa2+giTMIKupN4NVSlI/r5Bq1eeMQw0JbCoFexiWZinkL/LOM3hg4kxCtC8EInxO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1FJGFiP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so17963965e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708092300; x=1708697100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpbLWzMyYPwodhbzPXYFFQOvyF35F7rYtI5CvxnVpBk=;
        b=l1FJGFiPX17vy7Z59VSB8TMjXtvlZB3N1hOxhwbu1mtzx4ez9d866aDsF3wymWaP/E
         AdLS1cOrgD3GfDY3dLxcywAn/5QEuqiziYhO7/SY34DB/Q6KPngDcP4uvr8n+TpaWaZh
         3FYZWsdQd0VR8Tp8M/qVP1/lE0PgzdI2EMNYA8UgR0JRmaGpb39lgEFMYXls7QK0ITvM
         5lXXobfozRcxUxn6nSarCn6HwqAwmCfzailsKm5nj8vTo6tFeyjJZ3XYxTtIb5SriL5z
         6wl/n6toE9Zoaw+aqWEl1ksU8yZbXVdenQ7It7YQSA0soszxhQSvxpPGNAkMOd7IAO5M
         POLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092300; x=1708697100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpbLWzMyYPwodhbzPXYFFQOvyF35F7rYtI5CvxnVpBk=;
        b=qJReGZGGzK1njILHJ2L2v73iXB2PyLi0miYTlycMMtorgOwz0FW7VHV+GHZ2ACtAru
         +QpVAU9Bni3JpqHIavRoHe1dfnKzHU77Q/KwiGS1E471L/gLkw1+F1Fgv0At3BG96cbB
         jDixxcc3xzNVyB8mfrkEGlFoH8mMmd5QgxkbTpaWIQcJw61hxeZnuhnlHs/YyNdflXUK
         9i2j0636p35y0Lb/JB+BRQoPYFAX5mxCbgT2Oy8B14T51ESJak9SrBgicTxiTpY/1Vzc
         yyIJA2L68/D2inbzGw6leALB3l0if8MNw+KEQn/TnjNAzYYaOst7F7OGLGTgefGOauFi
         ZQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3EoWwIdxuN4ai57FZSiCdiS+ZMeSMi5q51XX+eMyltTLmRDH5dVea2MbQ65s+e601PMdDH0lHiC0679BE47FIRrDPnj2Qq/GAKwon
X-Gm-Message-State: AOJu0YwWAyNj+1g9fQV9pL7Q2L9u2i8b0Wr8N+nbM6Jw/i370FE8OtPG
	A4sgEBJNWBtuQSSHT9UNO6cws52YTI9q8K24eIfywLdCBed8lRIiQM+oFFdT+OmA34QrqKyqgTI
	IbxQ=
X-Google-Smtp-Source: AGHT+IHWdUB9E6Xmity8dCJxxH0CAvh8LXlNHW0BGR1UNv3oA+Bl9EEpasEs2AkAdEbHy98zpO3UGg==
X-Received: by 2002:a05:600c:1d81:b0:412:107d:cd69 with SMTP id p1-20020a05600c1d8100b00412107dcd69mr4569337wms.1.1708092299870;
        Fri, 16 Feb 2024 06:04:59 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id az5-20020a05600c600500b0040e4733aecbsm2516628wmb.15.2024.02.16.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:04:58 -0800 (PST)
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
Subject: [PATCH v2 5/7] ARM: dts: samsung: exynos5433: specify the SPI FIFO depth
Date: Fri, 16 Feb 2024 14:04:47 +0000
Message-ID: <20240216140449.2564625-6-tudor.ambarus@linaro.org>
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
the SPI driver to determine the SPI FIFO depthj Drop the dependency on
the SPI alias and specify the SPI FIFO depth directly into the SPI node.

The FIFO depth were determined based on the SPI aliases that are defined
in exynos5433-tm2-common.dtsi:
	spi0 = &spi_0;
	spi1 = &spi_1;
	spi2 = &spi_2;
	spi3 = &spi_3;
	spi4 = &spi_4;
spi-s3c64xx.c driver defines the following fifo_lvl_mask for the
"samsung,exynos5433-spi" compatible:
	.fifo_lvl_mask  = { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
Thus spi{0, 4} were considered having 256 byte FIFO depths, and
spi{1, 2, 3} having 64 byte FIFO depths. Update device tree with these
FIFO depths. No functional change expected.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 7fbbec04bff0..0b9053b9b2b5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1468,6 +1468,7 @@ spi_0: spi@14d20000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
 			num-cs = <1>;
+			fifo-depth = <256>;
 			status = "disabled";
 		};
 
@@ -1487,6 +1488,7 @@ spi_1: spi@14d30000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
 			num-cs = <1>;
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
@@ -1506,6 +1508,7 @@ spi_2: spi@14d40000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi2_bus>;
 			num-cs = <1>;
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
@@ -1525,6 +1528,7 @@ spi_3: spi@14d50000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi3_bus>;
 			num-cs = <1>;
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
@@ -1544,6 +1548,7 @@ spi_4: spi@14d00000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi4_bus>;
 			num-cs = <1>;
+			fifo-depth = <64>;
 			status = "disabled";
 		};
 
-- 
2.44.0.rc0.258.g7320e95886-goog


