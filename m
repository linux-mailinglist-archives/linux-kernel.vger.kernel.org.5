Return-Path: <linux-kernel+bounces-115463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F48894EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0515FB350E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211B21E357;
	Mon, 25 Mar 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfC3mC3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553D1292F9;
	Sun, 24 Mar 2024 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320859; cv=none; b=GB9F9gCR4lQttWKeZbmvP/mu/vKeO9Df5M/ExZv2AhMM3YOT9mIkwQkVMQkcUQHZZEz9FII8KDHuYdpLzh9izx+UDjpA+3fi2MtRu7SxIRnGiZFIiAqt6Uln7TNQmoDahOtL8cdFezKe3wK+AWZxN3umN8K6r4x9M2AxLHft3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320859; c=relaxed/simple;
	bh=k1718tIRVtyBuPuPME4HoGIOwyBFb8V0fUYLmvZcUbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJkBByd5l12dXgkFZlg7WmEcAeUr9GFjVOCfj9X4l56UlV3vK8LfKAJonJMRcXQkist0I7zcrWmLoMlKBJJ+cbw6S9D6v6nB6lMfBptvHLhKCu4UiAF0LoFxdn6zGjxtFHQrznILbQKInYX3v7Yc4k0qhYohrJdNOMMbppmqMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfC3mC3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B927C43394;
	Sun, 24 Mar 2024 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320858;
	bh=k1718tIRVtyBuPuPME4HoGIOwyBFb8V0fUYLmvZcUbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfC3mC3eEA85ZKl85akClyeuxUBFaHXxhZZT9U+rmGe/bZ/lpbjanKWXJNJeDJXXC
	 xpetubJh1fYU1Dr73hOkSnh/L40gEr4RKVshT8o0IdvxbV1BO/9lOsKGY28Up6jDS3
	 JqyCTjFHXuznJIQaSP5SvCadVpYeq2pmB56nMzu5irEzkDIREms70i8b3+aAi/IQSr
	 rukeBKMa7zx+bi7ynBm7lFV0TH02uDLOK3rZvY/ZOVnwoB0x+18Jexw39lpOJS83xf
	 tcMs9ZL2cOo0VR/qOUZO4qsVdvrZhDWY4WByE1ozbI5CtKoRIHM7SOKUInYgJNxoZO
	 R6nkVVlTvOndA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 422/713] clk: samsung: exynos850: Propagate SPI IPCLK rate change
Date: Sun, 24 Mar 2024 18:42:28 -0400
Message-ID: <20240324224720.1345309-423-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sam Protsenko <semen.protsenko@linaro.org>

[ Upstream commit 67c15187d4910ee353374676d4dddf09d8cb227e ]

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
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20240125013858.3986-2-semen.protsenko@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos850.c | 33 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index bdc1eef7d6e54..c7b0b9751307b 100644
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
2.43.0


