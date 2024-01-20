Return-Path: <linux-kernel+bounces-31660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168B833224
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1BF1F222E4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891B15CA;
	Sat, 20 Jan 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duBD1kdC"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A047FC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714192; cv=none; b=GZDS8TmHzw8e3PnmhW+Sl0mzFBH8NmjLvthctk54wS4SmdAY62J8MJ6giC/efo2bbnhnT2O4cc19NJj2rxBvzxPkou4pTNYtnb/V0dvP6pjFeDMK5mHlAA42enK49OKQdAESiCWKImZPeIvSBaDP3NvA6MLHcj5U0MoGc/OMZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714192; c=relaxed/simple;
	bh=LHbVNbEqiEdv1CSExJcpwn/LewgdPyKKUCS/0i81HZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r4UlKmDyIoBtZqj5lzW0yDhKq4PubjIEN8QWXLB/1q64hGipzLJrxZABsiDPxF9WpMcv3JAVuzKenrqaco3e/34QakHQSP9pzwPja9vbFAQ0NslslC91wcCvfV0Vxb2zqV4veYpcbdqOuCRrrzPLfqBkVm7RP7VFaD4TeFSdnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duBD1kdC; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2107f19e331so825237fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705714189; x=1706318989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XgpzCQt3hEaot8WdGgVBTF9LHrWRexjtDxlqMh/xJU=;
        b=duBD1kdCeWgWjEV5qGR90JmzfenHZg0qRMJYdDw1EPyWQcvy7CYShebuJZO8cL6iqG
         5ieR20tBBhOWjs5XVhcWi1sjsUdffHEwQIEiaCCjFsrGmYHGAS7bwP5zLjNKY8smzo8J
         f/aLT7MaEiuPzBUuJ4WwJzhcmm2IdX24DlKc/bIV7FmgMNmr26upBIJn/7XfXBTpHuKK
         iB048IThwRvi1jaztLPxq+k8YlJWkalnB3rZlgx57NqKsR2HWui1w+tL9/qCo5doWfSx
         05UOgjk9/UweYIoFFjXq/AmXawPEPg5X95vY54UIctTLcq5F16K8Sf4ItGmJNQ0yERTp
         SuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714189; x=1706318989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XgpzCQt3hEaot8WdGgVBTF9LHrWRexjtDxlqMh/xJU=;
        b=ID7rRwGMjT5qJWimj5IS8zN48VM3ftDO+Z+UpzeymIxawL+DNp8KpPdNaxaJdhE3Dl
         avMv/nM/F6E8bgJqAPCkOyu/TJSgOZIHn2DQAhpeIHJRwrpNuYJbJGkPorJ6qg3twR99
         PJn3SWgZqsugLoqz6Nn9UnA90mSvCofUXIr8EFsrpzCommGAooiQIgCi33zbAzrj/+jX
         bN5FpgVNqRrvqgv/PeOCTohIm0IYkRWfE4k/txtD5o8+CJzWrpvSD4IQvFBfV32tX2xj
         tG3fk7ZZHsdlwhAI5V2b8UJq9qZ4B21FGNDkbxrS5DBTQoXAIrMm+73bcgLOgMfbILSo
         Qm6A==
X-Gm-Message-State: AOJu0Yy+7yqGK3P1fK8AuQj2wUkyLLJS/Zptuqpj2Hx7VD9NVXeb6NjT
	Du18gfH0jcmcIfZ6LeTWosY0s80TriSSwm1ZZ8F4rGConBUsuMl5Z4F1ukFOnhg=
X-Google-Smtp-Source: AGHT+IHU9udcHqikg63izQDnv1b9lXiOAxuqYd7ib9PcxDQO3FZ7P2CFmm9WAgdTurKsAQQON0aRaA==
X-Received: by 2002:a05:6870:718b:b0:207:a3a6:ef9c with SMTP id d11-20020a056870718b00b00207a3a6ef9cmr700537oah.40.1705714189046;
        Fri, 19 Jan 2024 17:29:49 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id fu12-20020a0568705d8c00b00210bc7a74e7sm1016603oab.6.2024.01.19.17.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:29:48 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/7] arm64: exynos: Enable SPI for Exynos850
Date: Fri, 19 Jan 2024 19:29:41 -0600
Message-Id: <20240120012948.8836-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables SPI for Exynos850 SoC. The summary:

  1. Enable PDMA, it's needed for SPI (dts, clk)
  2. Propagate SPI src clock rate change up to DIV clocks, to make it
     possible to change SPI frequency (clk driver)
  3. Add Exynos850 support in SPI driver
  4. Add SPI nodes to Exynos850 SoC dtsi

All SPI instances were tested using `spidev_test' tool in all 3 possible
modes:

  - Polling mode: xfer_size <= 32
  - IRQ mode: 64 >= xfer_size >= 32
  - DMA mode: xfer_size > 64

with 200 kHz ... 49.9 MHz SPI frequencies. The next 3 approaches were
used:

  1. Software loopback ('-l' option for `spidev_test' tool)
  2. Hardware loopback (by connecting MISO line to MOSI)
  3. By communicating with ATMega found on Sensors Mezzanine board [1],
     programmed to act as an SPI slave device

and all the transactions were additionally checked on my Logic Analyzer
to make sure the SCK frequencies were actually correct.

[1] https://www.96boards.org/product/sensors-mezzanine/

Sam Protsenko (7):
  dt-bindings: clock: exynos850: Add PDMA clocks
  dt-bindings: spi: samsung: Add Exynos850 SPI
  clk: samsung: exynos850: Add PDMA clocks
  clk: samsung: exynos850: Propagate SPI IPCLK rate change
  spi: s3c64xx: Add Exynos850 support
  arm64: dts: exynos: Add PDMA node for Exynos850
  arm64: dts: exynos: Add SPI nodes for Exynos850

 .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
 arch/arm64/boot/dts/exynos/exynos850.dtsi     | 64 +++++++++++++++++++
 drivers/clk/samsung/clk-exynos850.c           | 42 +++++++-----
 drivers/spi/spi-s3c64xx.c                     | 14 ++++
 include/dt-bindings/clock/exynos850.h         |  2 +
 5 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.39.2


