Return-Path: <linux-kernel+bounces-31663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068683323B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E25B22BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3125D27E;
	Sat, 20 Jan 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTAzW3rF"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133F137D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714195; cv=none; b=W4WQHmih9fvvW1227nGmkV+w5yo9FCE3rZf11Iq9pJX6n5QXLAZnx2LfQT4Ja5XYEj5unokYJJ1WbzNUe4SpPx1rAnyPpnjfaG9CLjgIuniPVNvBxq7OGfcl3Ycmc5xJRfD9lWJ9mFS+4fcyZ1J1Ffqvob4EZd+GFhq7ed6KpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714195; c=relaxed/simple;
	bh=fmZuo3MrMT7m1VzAaoEXXShJ/CMEiRm/YGUn6I/FsxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl1ZUe089Crevu+2jDxAabTmCBOsfdD2RRTZWd8FqejRbhSwbWXXM50RI/ohdZMu/NCBCaFX9G3+iBbxt5XgbzoR8ups4neXvt3Szv2zOcymrPM/INqmdSJ9JQg50yXYprwTsttr3P1i8YsVRMEgtqfFkWaXpkjSKGU+qIA2Xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GTAzW3rF; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5988e55ede0so647808eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705714192; x=1706318992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4kmnGW+syMx6+ePR/dJeXumdAQD9FzNiPa26DzNGl4=;
        b=GTAzW3rFJpdhONblMmNHGuDmmKhH2YBgd5Jb/qanlXb1XdSKQP9G8oj4NX2nfnFYcc
         YrbyUv14sa9P6+ypEwHIxXUSI0wfW5XAtKkbHhRlhIqgwzO4ecjLkBBwV7HWk9SBCtZW
         nKDf1sLcXHKV+jIRO9AfH5Y3QeYyVBcpgeGYoIOr9wdm0Ot+XxekqjdnxMEDJmAWAYPX
         AQihUITVzgekhKYjoiXaRzDy1JM3mt+6/ua7QQeTw+HXdeSbRnElV1oQXnnNdjpvGwxh
         Xu+GrnnxbLSWKEPNM1s4bJcYNZvd9Jzts0ghkqpIAbBM4IBF87UJ1P2+LwQD7Ai9VnLh
         TvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714192; x=1706318992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4kmnGW+syMx6+ePR/dJeXumdAQD9FzNiPa26DzNGl4=;
        b=daLCyDOn+dQDU0CCxSCbY08ikb2J+4q/GtRY2VMoGSqvvEvDQ59J+4bNKr29GXUMCm
         19n8iLZYCt1Cy6RpvJ8M8+IJyKT7/OshqBanuusHAaFuJ7pppAQryz6HiZkNA4N8qqIr
         RX4zCuomc2BYRnHalfuZVfLWH84sAa9mDIlg2SgV6a4HcIe1Ge88nSftn6MWISDWMclW
         PafxcoKaVx8RaX03WvW5phWlAt3vHTd44+xBujBMXhi3f0Y6TZRgnt7QWVvJdFmFnfy5
         bCrtt2iYwipnpEgkuEyC2VMRYjBwb6SAZrPYHZCtgqXpZOTnm0otoU/ELR/sdsHX1z4d
         HrXQ==
X-Gm-Message-State: AOJu0YyDkJsGfi3KPseqvAXw49qEUh4p0bUOGcntW1h7ebb+mWzt67HQ
	eQK8svU0h+RUb1ek1Aba0R6AxmZg7yP+yK6Up+FmgZJjVwOuNZtXkCnzQT1X+G8=
X-Google-Smtp-Source: AGHT+IH5/JX9LSbW5wTrCYXWFxWn7qX6WUiumWLUKYHOjovq6UJrsGgv0XJWVjmB230rfB8b0b/pOw==
X-Received: by 2002:a05:6808:1691:b0:3bd:a8a3:7237 with SMTP id bb17-20020a056808169100b003bda8a37237mr728996oib.10.1705714192322;
        Fri, 19 Jan 2024 17:29:52 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id zd27-20020a056871279b00b00210b451fe96sm1088971oab.47.2024.01.19.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:29:51 -0800 (PST)
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
Subject: [PATCH 4/7] clk: samsung: exynos850: Propagate SPI IPCLK rate change
Date: Fri, 19 Jan 2024 19:29:45 -0600
Message-Id: <20240120012948.8836-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120012948.8836-1-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
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
 drivers/clk/samsung/clk-exynos850.c | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 01913dc4eb27..32a8cb861702 100644
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
+	    CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP0, 0, 1, CLK_SET_RATE_PARENT, 0),
+	MUX_F(CLK_MOUT_CMGP_USI1, "mout_cmgp_usi1", mout_cmgp_usi1_p,
+	    CLK_CON_MUX_MUX_CLK_CMGP_USI_CMGP1, 0, 1, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_div_clock cmgp_div_clks[] __initconst = {
 	DIV(CLK_DOUT_CMGP_ADC, "dout_cmgp_adc", "gout_clkcmu_cmgp_bus",
 	    CLK_CON_DIV_DIV_CLK_CMGP_ADC, 0, 4),
-	DIV(CLK_DOUT_CMGP_USI0, "dout_cmgp_usi0", "mout_cmgp_usi0",
-	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP0, 0, 5),
-	DIV(CLK_DOUT_CMGP_USI1, "dout_cmgp_usi1", "mout_cmgp_usi1",
-	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP1, 0, 5),
+	DIV_F(CLK_DOUT_CMGP_USI0, "dout_cmgp_usi0", "mout_cmgp_usi0",
+	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP0, 0, 5, CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_DOUT_CMGP_USI1, "dout_cmgp_usi1", "mout_cmgp_usi1",
+	    CLK_CON_DIV_DIV_CLK_CMGP_USI_CMGP1, 0, 5, CLK_SET_RATE_PARENT, 0),
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
@@ -1557,8 +1557,8 @@ static const struct samsung_mux_clock peri_mux_clks[] __initconst = {
 	    mout_peri_uart_user_p, PLL_CON0_MUX_CLKCMU_PERI_UART_USER, 4, 1),
 	MUX(CLK_MOUT_PERI_HSI2C_USER, "mout_peri_hsi2c_user",
 	    mout_peri_hsi2c_user_p, PLL_CON0_MUX_CLKCMU_PERI_HSI2C_USER, 4, 1),
-	MUX(CLK_MOUT_PERI_SPI_USER, "mout_peri_spi_user", mout_peri_spi_user_p,
-	    PLL_CON0_MUX_CLKCMU_PERI_SPI_USER, 4, 1),
+	MUX_F(CLK_MOUT_PERI_SPI_USER, "mout_peri_spi_user", mout_peri_spi_user_p,
+	    PLL_CON0_MUX_CLKCMU_PERI_SPI_USER, 4, 1, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_div_clock peri_div_clks[] __initconst = {
@@ -1568,8 +1568,8 @@ static const struct samsung_div_clock peri_div_clks[] __initconst = {
 	    CLK_CON_DIV_DIV_CLK_PERI_HSI2C_1, 0, 5),
 	DIV(CLK_DOUT_PERI_HSI2C2, "dout_peri_hsi2c2", "gout_peri_hsi2c2",
 	    CLK_CON_DIV_DIV_CLK_PERI_HSI2C_2, 0, 5),
-	DIV(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "mout_peri_spi_user",
-	    CLK_CON_DIV_DIV_CLK_PERI_SPI_0, 0, 5),
+	DIV_F(CLK_DOUT_PERI_SPI0, "dout_peri_spi0", "mout_peri_spi_user",
+	    CLK_CON_DIV_DIV_CLK_PERI_SPI_0, 0, 5, CLK_SET_RATE_PARENT, 0),
 };
 
 static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
@@ -1611,7 +1611,7 @@ static const struct samsung_gate_clock peri_gate_clks[] __initconst = {
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


