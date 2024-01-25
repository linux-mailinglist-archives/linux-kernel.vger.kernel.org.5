Return-Path: <linux-kernel+bounces-37865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A283B6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1EF1C21D91
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33CA6AAD;
	Thu, 25 Jan 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUOPY/HX"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C3A3D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146742; cv=none; b=eJYSQs1p/BUKzRoXYd5UCdEh+ArvIQ8vd0UoXaFahcupnxj0CTjfdJN5moKA8Nua6uz84WjNmaBt7F/or9lVFMPNLlJB/FwITFQGw8M1laA3deN9wFkyzClc+KfjGF9PxMi8XhTNPhulmzRkSzu9K/JN4IJVM6xSpfKeVXi4SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146742; c=relaxed/simple;
	bh=dPVr17aqx+Z3Or7Se5pT4w8/UDBgWm2XP0Wk1/C5/1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ycl4sb/t/31t6LoPjGriadosJVZBua43RLp1k+csBg2nWK7oxK1U5IfYTDMkG8apIw/F2ZBKTpcGM/fZ6KZBT0gvVpy5C5MltLqX196T56SBDcjOWotswLC7XpPkmWArzB5vNiXtdqWuNZilPULbLfpeZc+664RG3MZJqKPHdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUOPY/HX; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21080bacc6fso3519817fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146740; x=1706751540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbkciqRfm8GdMwfcdSYDPiyMLtZNsxcN/vnLydy6v50=;
        b=IUOPY/HXMAsZ9AnqgrrNsI4BVZ4K+yEaQv2eH/p8oDYxxQbJuhgr2MRg3aTBMdrwec
         0TPOmWHfie0p03JdJyg1Mc6Z4hs8A+Oe5Mz5+fJJuT5qNMopeNYyxoYTlqxO31zeLl3J
         X7AnFB7sVn4eBZXBcmWtLUfrv9ecBtwzwwxuo1aO99X4dtQCkvUabUkFQaczjHydOPrX
         EtEsuXhPmqd/+3elIjijoalLPYXYpJttLfZ6+KuIai+2Imv/D7m25vUbGJF5SdertPa1
         Oywwt00EBf4PSvZrzLvZO0CpS63q6QinyHYbJqWEbvsFS7MoGyuFyKcVgI2+aeP2CS8w
         BG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146740; x=1706751540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbkciqRfm8GdMwfcdSYDPiyMLtZNsxcN/vnLydy6v50=;
        b=bR3Sqta/okXw4NtCU+ZzWhtnwWW/+An7cQh7Oi43b9EsGzqeeMhLvjD4nEOLGH6EvA
         cK+LdPz2dcuzMDhmHZRyt0hnfJvkAOjz6IkPPkZvBRmj3MuUQijTVL3Vd2FvQepsEO/Z
         qR7gH/DKSA53+yJnafOCPnIxrGsIPBu2677Eu4s+CIMk+ISBonIWMofLYbYvg6yktsOB
         gXDzzJrsoGV/5g+q1ogjbZyhCSEUC/GRvTIwS4q+QNY7kTPa7WTHfPyQUQxgfuIM1AFm
         lFDm4r3D3PsQ/jbVHBqrjUWoFHBsPuQJqq4u27ttN8krtGgvLyiEi9oADTB6MDdu+tC0
         Jwrw==
X-Gm-Message-State: AOJu0YyqhwjqidVRjc8cYedl9Zw2pSiWj91OYJHgXpH/8UIIJXUBLLsR
	vIPapUJfqRXyxFa6aXMIP2QqmmAxnLJVnsLtkebVHWPt0sPMty8PO5ePSliG1PY=
X-Google-Smtp-Source: AGHT+IFCObCV5HEPsf4qnfP/tEIaVZedjITrOZox3R8ZzI3xaRoxxcdT4OzrdyguahWBbH54T0BpHA==
X-Received: by 2002:a05:6871:e405:b0:214:b2c1:ee59 with SMTP id py5-20020a056871e40500b00214b2c1ee59mr237207oac.2.1706146740072;
        Wed, 24 Jan 2024 17:39:00 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id mk4-20020a0568700d0400b00214a5942ab1sm702254oab.11.2024.01.24.17.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:38:59 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] clk: samsung: exynos850: Propagate SPI IPCLK rate change
Date: Wed, 24 Jan 2024 19:38:56 -0600
Message-Id: <20240125013858.3986-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125013858.3986-1-semen.protsenko@linaro.org>
References: <20240125013858.3986-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SPI transfer is being prepared, the spi-s3c64xx driver will call
clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
is a gate (leaf) clock, so it must propagate the rate change up the
clock tree, so that corresponding DIV clocks can actually change their
divider values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
all SPI instances in Exynos850 (spi_0, spi_1 and spi_2) to make it
possible. This change involves next clocks:

usi_spi_0:

    Clock                  Block       Div range
    --------------------------------------------
    gout_spi0_ipclk        CMU_PERI    -
    dout_peri_spi0         CMU_PERI    /1..32
    mout_peri_spi_user     CMU_PERI    -
    dout_peri_ip           CMU_TOP     /1..16

usi_cmgp0:

    Clock                  Block       Div range
    --------------------------------------------
    gout_cmgp_usi0_ipclk   CMU_CMGP    -
    dout_cmgp_usi0         CMU_CMGP    /1..32
    mout_cmgp_usi0         CMU_CMGP    -
    gout_clkcmu_cmgp_bus   CMU_APM     -
    dout_apm_bus           CMU_APM     /1..8

usi_cmgp1:

    Clock                  Block       Div range
    --------------------------------------------
    gout_cmgp_usi1_ipclk   CMU_CMGP    -
    dout_cmgp_usi1         CMU_CMGP    /1..32
    mout_cmgp_usi1         CMU_CMGP    -
    gout_clkcmu_cmgp_bus   CMU_APM     -
    dout_apm_bus           CMU_APM     /1..8

With input clock of 400 MHz, this scheme provides next IPCLK rate range,
for each SPI block:

    SPI0:   781 kHz ... 400 MHz
    SPI1/2: 1.6 MHz ... 400 MHz

Accounting for internal /4 divider in SPI blocks, and because the max
SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:

    SPI0:   200 kHz ... 49.9 MHz
    SPI1/2: 400 kHz ... 49.9 MHz

Which should cover all possible applications of SPI bus. Of course,
setting SPI frequency to values as low as 500 kHz will also affect the
common bus dividers (dout_apm_bus or dout_peri_ip), which in turn
effectively lowers the rates for all leaf bus clocks derived from those
dividers, like HSI2C and I3C clocks. But at least it gives the board
designer a choice, whether to keep all clocks (SPI/HSI2C/I3C) at high
frequencies, or make all those clocks have lower frequencies. Not
propagating the rate change to those common dividers would limit this
choice to "only high frequencies are allowed for SPI/HSI2C/I3C" option,
making the common dividers useless. This decision follows the "Worse is
better" approach, relying on the users/engineers to know the system
internals when working with such low-level features, instead of trying
to account for all possible use-cases.

Fixes: 7dd05578198b ("clk: samsung: Introduce Exynos850 clock driver")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Fixed indentation to make checkpatch strict happy

 drivers/clk/samsung/clk-exynos850.c | 33 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 01913dc4eb27..82cfa22c0788 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -605,7 +605,7 @@ static const struct samsung_div_clock apm_div_clks[] __initconst = {
 
 static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
 	GATE(CLK_GOUT_CLKCMU_CMGP_BUS, "gout_clkcmu_cmgp_bus", "dout_apm_bus",
-	     CLK_CON_GAT_CLKCMU_CMGP_BUS, 21, 0, 0),
+	     CLK_CON_GAT_CLKCMU_CMGP_BUS, 21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_CLKCMU_CHUB_BUS, "gout_clkcmu_chub_bus",
 	     "mout_clkcmu_chub_bus",
 	     CLK_CON_GAT_GATE_CLKCMU_CHUB_BUS, 21, 0, 0),
@@ -974,19 +974,19 @@ static const struct samsung_fixed_rate_clock cmgp_fixed_clks[] __initconst = {
 static const struct samsung_mux_clock cmgp_mux_clks[] __initconst = {
 	MUX(CLK_MOUT_CMGP_ADC, "mout_cmgp_adc", mout_cmgp_adc_p,
 	    CLK_CON_MUX_CLK_CMGP_ADC, 0, 1),
-	MUX(CLK_MOUT_CMGP_USI0, "mout_cmgp_usi0", mout_cmgp_usi0_p,
-	    CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP0, 0, 1),
-	MUX(CLK_MOUT_CMGP_USI1, "mout_cmgp_usi1", mout_cmgp_usi1_p,
-	    CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP1, 0, 1),
+	MUX_F(CLK_MOUT_CMGP_USI0, "mout_cmgp_usi0", mout_cmgp_usi0_p,
+	      CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP0, 0, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_CMGP_USI1, "mout_cmgp_usi1", mout_cmgp_usi1_p,
+	      CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP1, 0, 1, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_div_clock cmgp_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CMGP_ADC, "dout_cmgp_adc", "gout_clkcmu_cmgp_bus",
 	    CLK_CON_DIV_DIV_CLK_CMGP_ADC, 0, 4),
-	DIV(CLK_DOUT_CMGP_USI0, "dout_cmgp_usi0", "mout_cmgp_usi0",
-	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP0, 0, 5),
-	DIV(CLK_DOUT_CMGP_USI1, "dout_cmgp_usi1", "mout_cmgp_usi1",
-	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP1, 0, 5),
+	DIV_F(CLK_DOUT_CMGP_USI0, "dout_cmgp_usi0", "mout_cmgp_usi0",
+	      CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP0, 0, 5, CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_CMGP_USI1, "dout_cmgp_usi1", "mout_cmgp_usi1",
+	      CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP1, 0, 5, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock cmgp_gate_clks[] __initconst = {
@@ -1001,12 +1001,12 @@ static const struct samsung_gate_clock cmgp_gate_clks[] __initconst = {
 	     "gout_clkcmu_cmgp_bus",
 	     CLK_CON_GAT_GOUT_CMGP_GPIO_PCLK, 21, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_GOUT_CMGP_USI0_IPCLK, "gout_cmgp_usi0_ipclk", "dout_cmgp_usi0",
-	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK, 21, 0, 0),
+	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_IPCLK, 21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_CMGP_USI0_PCLK, "gout_cmgp_usi0_pclk",
 	     "gout_clkcmu_cmgp_bus",
 	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP0_PCLK, 21, 0, 0),
 	GATE(CLK_GOUT_CMGP_USI1_IPCLK, "gout_cmgp_usi1_ipclk", "dout_cmgp_usi1",
-	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK, 21, 0, 0),
+	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_IPCLK, 21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_CMGP_USI1_PCLK, "gout_cmgp_usi1_pclk",
 	     "gout_clkcmu_cmgp_bus",
 	     CLK_CON_GAT_GOUT_CMGP_USI_CMGP1_PCLK, 21, 0, 0),
@@ -1557,8 +1557,9 @@ static const struct samsung_mux_clock peri_mux_clks[] __initconst = {
 	    mout_peri_uart_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART_USER, 4, 1),
 	MUX(CLK_MOUT_PERI_HSI2C_USER, "mout_peri_hsi2c_user",
 	    mout_peri_hsi2c_user_p, PLL_CON0_MUX_CLKCMU_PERI_HSI2C_USER, 4, 1),
-	MUX(CLK_MOUT_PERI_SPI_USER, "mout_peri_spi_user", mout_peri_spi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERI_SPI_USER, 4, 1),
+	MUX_F(CLK_MOUT_PERI_SPI_USER, "mout_peri_spi_user",
+	      mout_peri_spi_user_p, PLL_CON0_MUX_CLKCMU_PERI_SPI_USER, 4, 1,
+	      CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_div_clock peri_div_clks[] __initconst = {
@@ -1568,8 +1569,8 @@ static const struct samsung_div_clock peri_div_clks[] __initconst = {
 	    CLK_CON_DIV_DIV_CLK_PERI_HSI2C_1, 0, 5),
 	DIV(CLK_DOUT_PERI_HSI2C2, "dout_peri_hsi2c2", "gout_peri_hsi2c2",
 	    CLK_CON_DIV_DIV_CLK_PERI_HSI2C_2, 0, 5),
-	DIV(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "mout_peri_spi_user",
-	    CLK_CON_DIV_DIV_CLK_PERI_SPI_0, 0, 5),
+	DIV_F(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "mout_peri_spi_user",
+	      CLK_CON_DIV_DIV_CLK_PERI_SPI_0, 0, 5, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
@@ -1611,7 +1612,7 @@ static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
 	     "mout_peri_bus_user",
 	     CLK_CON_GAT_GOUT_PERI_PWM_MOTOR_PCLK, 21, 0, 0),
 	GATE(CLK_GOUT_SPI0_IPCLK, "gout_spi0_ipclk", "dout_peri_spi0",
-	     CLK_CON_GAT_GOUT_PERI_SPI_0_IPCLK, 21, 0, 0),
+	     CLK_CON_GAT_GOUT_PERI_SPI_0_IPCLK, 21, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_GOUT_SPI0_PCLK, "gout_spi0_pclk", "mout_peri_bus_user",
 	     CLK_CON_GAT_GOUT_PERI_SPI_0_PCLK, 21, 0, 0),
 	GATE(CLK_GOUT_SYSREG_PERI_PCLK, "gout_sysreg_peri_pclk",
-- 
2.39.2


