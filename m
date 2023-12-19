Return-Path: <linux-kernel+bounces-6094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E1819490
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B34F1C24C13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025D3EA7E;
	Tue, 19 Dec 2023 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OihbyJPP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC2405C6;
	Tue, 19 Dec 2023 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703028292;
	bh=CBocVsOcxlZSwP3yDO4sO7GLUoyqZqq2dY2ZddXB4eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OihbyJPPJh7qQ56GQ18c8Dj0fGji+Ys1jXVm9ws9canVwLkB4EcJcBZ0DjpAI87W5
	 GV7z4b3lXNLnE1BtOJ+iVtzPrNxEIw3onN6d7cu4/qOFyHTL34cwluwevNHuTH1BE6
	 xA/PCzJlot/QSrmOP//T8l1FY+EXmCjhbrZ7kwMR61AZpH0ZxY5W6BdpESqXxlzjws
	 KMxWVXOf3mUbR5PBsTUc4JSFE54KuEYazwbKVQRoklyv3gVGvqwVzeoYrd2Gpc1/si
	 0CH4NPz/8uH/3rttoyPLObaDYeV8BXSN7XKkH9W3hYtvQY0vtlcBAMliVzcibSc2FK
	 2kTTm4Fh4eIag==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3DDD93781495;
	Tue, 19 Dec 2023 23:24:52 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/2] clk: starfive: Add flags argument to JH71X0__MUX macro
Date: Wed, 20 Dec 2023 01:24:39 +0200
Message-ID: <20231219232442.2460166-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219232442.2460166-1-cristian.ciocaltea@collabora.com>
References: <20231219232442.2460166-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

This flag is needed to add the CLK_SET_RATE_PARENT flag on the gmac_tx
clock on the JH7100, which in turn is needed by the dwmac-starfive
driver to set the clock properly for 1000, 100 and 10 Mbps links.

This change was mostly made using coccinelle:

@ match @
expression idx, name, nparents;
@@
 JH71X0__MUX(
-idx, name, nparents,
+idx, name, 0, nparents,
 ...)

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    | 32 +++++++++----------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  6 ++--
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  2 +-
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 26 +++++++--------
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  4 +--
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index ee4bda14a40e..1fcf4e62f347 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -79,7 +79,7 @@ static const struct jh71x0_clk_data jh7100_audclk_data[] = {
 	JH71X0_GDIV(JH7100_AUDCLK_USB_LPM, "usb_lpm", CLK_IGNORE_UNUSED, 4, JH7100_AUDCLK_USB_APB),
 	JH71X0_GDIV(JH7100_AUDCLK_USB_STB, "usb_stb", CLK_IGNORE_UNUSED, 3, JH7100_AUDCLK_USB_APB),
 	JH71X0__DIV(JH7100_AUDCLK_APB_EN, "apb_en", 8, JH7100_AUDCLK_DOM7AHB_BUS),
-	JH71X0__MUX(JH7100_AUDCLK_VAD_MEM, "vad_mem", 2,
+	JH71X0__MUX(JH7100_AUDCLK_VAD_MEM, "vad_mem", 0, 2,
 		    JH7100_AUDCLK_VAD_INTMEM,
 		    JH7100_AUDCLK_AUDIO_12288),
 };
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 69cc11ea7e33..d3b260c01d5c 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -24,48 +24,48 @@
 #define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + 3)
 
 static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
-	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 4,
+	JH71X0__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 0, 4,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL1_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_DLA_ROOT, "dla_root", 3,
+	JH71X0__MUX(JH7100_CLK_DLA_ROOT, "dla_root", 0, 3,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL1_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_DSP_ROOT, "dsp_root", 4,
+	JH71X0__MUX(JH7100_CLK_DSP_ROOT, "dsp_root", 0, 4,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL1_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_GMACUSB_ROOT, "gmacusb_root", 3,
+	JH71X0__MUX(JH7100_CLK_GMACUSB_ROOT, "gmacusb_root", 0, 3,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_PERH0_ROOT, "perh0_root", 2,
+	JH71X0__MUX(JH7100_CLK_PERH0_ROOT, "perh0_root", 0, 2,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT),
-	JH71X0__MUX(JH7100_CLK_PERH1_ROOT, "perh1_root", 2,
+	JH71X0__MUX(JH7100_CLK_PERH1_ROOT, "perh1_root", 0, 2,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_VIN_ROOT, "vin_root", 3,
+	JH71X0__MUX(JH7100_CLK_VIN_ROOT, "vin_root", 0, 3,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL1_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_VOUT_ROOT, "vout_root", 3,
+	JH71X0__MUX(JH7100_CLK_VOUT_ROOT, "vout_root", 0, 3,
 		    JH7100_CLK_OSC_AUD,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL2_OUT),
 	JH71X0_GDIV(JH7100_CLK_AUDIO_ROOT, "audio_root", 0, 8, JH7100_CLK_PLL0_OUT),
-	JH71X0__MUX(JH7100_CLK_CDECHIFI4_ROOT, "cdechifi4_root", 3,
+	JH71X0__MUX(JH7100_CLK_CDECHIFI4_ROOT, "cdechifi4_root", 0, 3,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL1_OUT,
 		    JH7100_CLK_PLL2_OUT),
-	JH71X0__MUX(JH7100_CLK_CDEC_ROOT, "cdec_root", 3,
+	JH71X0__MUX(JH7100_CLK_CDEC_ROOT, "cdec_root", 0, 3,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL1_OUT),
-	JH71X0__MUX(JH7100_CLK_VOUTBUS_ROOT, "voutbus_root", 3,
+	JH71X0__MUX(JH7100_CLK_VOUTBUS_ROOT, "voutbus_root", 0, 3,
 		    JH7100_CLK_OSC_AUD,
 		    JH7100_CLK_PLL0_OUT,
 		    JH7100_CLK_PLL2_OUT),
@@ -76,7 +76,7 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0_GDIV(JH7100_CLK_PLL0_TESTOUT, "pll0_testout", 0, 31, JH7100_CLK_PERH0_SRC),
 	JH71X0_GDIV(JH7100_CLK_PLL1_TESTOUT, "pll1_testout", 0, 31, JH7100_CLK_DLA_ROOT),
 	JH71X0_GDIV(JH7100_CLK_PLL2_TESTOUT, "pll2_testout", 0, 31, JH7100_CLK_PERH1_SRC),
-	JH71X0__MUX(JH7100_CLK_PLL2_REF, "pll2_refclk", 2,
+	JH71X0__MUX(JH7100_CLK_PLL2_REF, "pll2_refclk", 0, 2,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_OSC_AUD),
 	JH71X0__DIV(JH7100_CLK_CPU_CORE, "cpu_core", 8, JH7100_CLK_CPUNBUS_ROOT_DIV),
@@ -142,7 +142,7 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0__DIV(JH7100_CLK_NOC_COG, "noc_cog", 8, JH7100_CLK_DLA_ROOT),
 	JH71X0_GATE(JH7100_CLK_NNE_AHB, "nne_ahb", 0, JH7100_CLK_AHB_BUS),
 	JH71X0__DIV(JH7100_CLK_NNEBUS_SRC1, "nnebus_src1", 4, JH7100_CLK_DSP_ROOT),
-	JH71X0__MUX(JH7100_CLK_NNE_BUS, "nne_bus", 2,
+	JH71X0__MUX(JH7100_CLK_NNE_BUS, "nne_bus", 0, 2,
 		    JH7100_CLK_CPU_AXI,
 		    JH7100_CLK_NNEBUS_SRC1),
 	JH71X0_GATE(JH7100_CLK_NNE_AXI, "nne_axi", 0, JH7100_CLK_NNE_BUS),
@@ -166,7 +166,7 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0_GDIV(JH7100_CLK_USBPHY_125M, "usbphy_125m", 0, 8, JH7100_CLK_USBPHY_ROOTDIV),
 	JH71X0_GDIV(JH7100_CLK_USBPHY_PLLDIV25M, "usbphy_plldiv25m", 0, 32,
 		    JH7100_CLK_USBPHY_ROOTDIV),
-	JH71X0__MUX(JH7100_CLK_USBPHY_25M, "usbphy_25m", 2,
+	JH71X0__MUX(JH7100_CLK_USBPHY_25M, "usbphy_25m", 0, 2,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_USBPHY_PLLDIV25M),
 	JH71X0_FDIV(JH7100_CLK_AUDIO_DIV, "audio_div", JH7100_CLK_AUDIO_ROOT),
@@ -200,12 +200,12 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0_GDIV(JH7100_CLK_GMAC_GTX, "gmac_gtxclk", 0, 255, JH7100_CLK_GMAC_ROOT_DIV),
 	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_TX, "gmac_rmii_txclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
 	JH71X0_GDIV(JH7100_CLK_GMAC_RMII_RX, "gmac_rmii_rxclk", 0, 8, JH7100_CLK_GMAC_RMII_REF),
-	JH71X0__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", 3,
+	JH71X0__MUX(JH7100_CLK_GMAC_TX, "gmac_tx", 0, 3,
 		    JH7100_CLK_GMAC_GTX,
 		    JH7100_CLK_GMAC_TX_INV,
 		    JH7100_CLK_GMAC_RMII_TX),
 	JH71X0__INV(JH7100_CLK_GMAC_TX_INV, "gmac_tx_inv", JH7100_CLK_GMAC_TX),
-	JH71X0__MUX(JH7100_CLK_GMAC_RX_PRE, "gmac_rx_pre", 2,
+	JH71X0__MUX(JH7100_CLK_GMAC_RX_PRE, "gmac_rx_pre", 0, 2,
 		    JH7100_CLK_GMAC_GR_MII_RX,
 		    JH7100_CLK_GMAC_RMII_RX),
 	JH71X0__INV(JH7100_CLK_GMAC_RX_INV, "gmac_rx_inv", JH7100_CLK_GMAC_RX_PRE),
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index 62954eb7b50a..418efdad719b 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -26,7 +26,7 @@
 static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
 	/* source */
 	JH71X0__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4, JH7110_AONCLK_OSC),
-	JH71X0__MUX(JH7110_AONCLK_APB_FUNC, "apb_func", 2,
+	JH71X0__MUX(JH7110_AONCLK_APB_FUNC, "apb_func", 0, 2,
 		    JH7110_AONCLK_OSC_DIV4,
 		    JH7110_AONCLK_OSC),
 	/* gmac0 */
@@ -39,7 +39,7 @@ static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
 		    JH7110_AONCLK_GMAC0_GTXCLK,
 		    JH7110_AONCLK_GMAC0_RMII_RTX),
 	JH71X0__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv", JH7110_AONCLK_GMAC0_TX),
-	JH71X0__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
+	JH71X0__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 0, 2,
 		    JH7110_AONCLK_GMAC0_RGMII_RXIN,
 		    JH7110_AONCLK_GMAC0_RMII_RTX),
 	JH71X0__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv", JH7110_AONCLK_GMAC0_RX),
@@ -48,7 +48,7 @@ static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
 	/* rtc */
 	JH71X0_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", 0, JH7110_AONCLK_APB_BUS),
 	JH71X0__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022, JH7110_AONCLK_OSC),
-	JH71X0__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
+	JH71X0__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 0, 2,
 		    JH7110_AONCLK_RTC_OSC,
 		    JH7110_AONCLK_RTC_INTERNAL),
 	JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index ce034ed28532..929b8788279e 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -53,7 +53,7 @@ static const struct jh71x0_clk_data jh7110_ispclk_data[] = {
 		    JH7110_ISPCLK_MIPI_RX0_PXL),
 	JH71X0_GATE(JH7110_ISPCLK_VIN_PIXEL_IF3, "vin_pixel_if3", 0,
 		    JH7110_ISPCLK_MIPI_RX0_PXL),
-	JH71X0__MUX(JH7110_ISPCLK_VIN_P_AXI_WR, "vin_p_axi_wr", 2,
+	JH71X0__MUX(JH7110_ISPCLK_VIN_P_AXI_WR, "vin_p_axi_wr", 0, 2,
 		    JH7110_ISPCLK_MIPI_RX0_PXL,
 		    JH7110_ISPCLK_DVP_INV),
 	/* ispv2_top_wrapper */
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 3884eff9fe93..8f5e5abfa178 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -36,18 +36,18 @@
 
 static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	/* root */
-	JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
+	JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 0, 2,
 		    JH7110_SYSCLK_OSC,
 		    JH7110_SYSCLK_PLL0_OUT),
 	JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
 	JH71X0__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2, JH7110_SYSCLK_CPU_CORE),
-	JH71X0__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
+	JH71X0__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 0, 2,
 		    JH7110_SYSCLK_PLL2_OUT,
 		    JH7110_SYSCLK_PLL1_OUT),
 	JH71X0_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
 		    JH7110_SYSCLK_PLL0_OUT,
 		    JH7110_SYSCLK_PLL2_OUT),
-	JH71X0__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
+	JH71X0__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 0, 2,
 		    JH7110_SYSCLK_OSC,
 		    JH7110_SYSCLK_PLL2_OUT),
 	JH71X0__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3, JH7110_SYSCLK_BUS_ROOT),
@@ -62,7 +62,7 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2, JH7110_SYSCLK_PLL2_OUT),
 	JH71X0__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8, JH7110_SYSCLK_PLL2_OUT),
 	JH71X0__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64, JH7110_SYSCLK_AUDIO_ROOT),
-	JH71X0__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
+	JH71X0__MUX(JH7110_SYSCLK_MCLK, "mclk", 0, 2,
 		    JH7110_SYSCLK_MCLK_INNER,
 		    JH7110_SYSCLK_MCLK_EXT),
 	JH71X0_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0, JH7110_SYSCLK_MCLK_INNER),
@@ -96,7 +96,7 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0__DIV(JH7110_SYSCLK_OSC_DIV2, "osc_div2", 2, JH7110_SYSCLK_OSC),
 	JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV4, "pll1_div4", 2, JH7110_SYSCLK_PLL1_DIV2),
 	JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV8, "pll1_div8", 2, JH7110_SYSCLK_PLL1_DIV4),
-	JH71X0__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 4,
+	JH71X0__MUX(JH7110_SYSCLK_DDR_BUS, "ddr_bus", 0, 4,
 		    JH7110_SYSCLK_OSC_DIV2,
 		    JH7110_SYSCLK_PLL1_DIV2,
 		    JH7110_SYSCLK_PLL1_DIV4,
@@ -186,7 +186,7 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0__DIV(JH7110_SYSCLK_GMAC1_RMII_RTX, "gmac1_rmii_rtx", 30,
 		    JH7110_SYSCLK_GMAC1_RMII_REFIN),
 	JH71X0_GDIV(JH7110_SYSCLK_GMAC1_PTP, "gmac1_ptp", 0, 31, JH7110_SYSCLK_GMAC_SRC),
-	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 2,
+	JH71X0__MUX(JH7110_SYSCLK_GMAC1_RX, "gmac1_rx", 0, 2,
 		    JH7110_SYSCLK_GMAC1_RGMII_RXIN,
 		    JH7110_SYSCLK_GMAC1_RMII_RTX),
 	JH71X0__INV(JH7110_SYSCLK_GMAC1_RX_INV, "gmac1_rx_inv", JH7110_SYSCLK_GMAC1_RX),
@@ -270,11 +270,11 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0_MDIV(JH7110_SYSCLK_I2STX0_LRCK_MST, "i2stx0_lrck_mst", 64, 2,
 		    JH7110_SYSCLK_I2STX0_BCLK_MST_INV,
 		    JH7110_SYSCLK_I2STX0_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk",	2,
+	JH71X0__MUX(JH7110_SYSCLK_I2STX0_BCLK, "i2stx0_bclk", 0, 2,
 		    JH7110_SYSCLK_I2STX0_BCLK_MST,
 		    JH7110_SYSCLK_I2STX_BCLK_EXT),
 	JH71X0__INV(JH7110_SYSCLK_I2STX0_BCLK_INV, "i2stx0_bclk_inv", JH7110_SYSCLK_I2STX0_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 2,
+	JH71X0__MUX(JH7110_SYSCLK_I2STX0_LRCK, "i2stx0_lrck", 0, 2,
 		    JH7110_SYSCLK_I2STX0_LRCK_MST,
 		    JH7110_SYSCLK_I2STX_LRCK_EXT),
 	/* i2stx1 */
@@ -285,11 +285,11 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0_MDIV(JH7110_SYSCLK_I2STX1_LRCK_MST, "i2stx1_lrck_mst", 64, 2,
 		    JH7110_SYSCLK_I2STX1_BCLK_MST_INV,
 		    JH7110_SYSCLK_I2STX1_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 2,
+	JH71X0__MUX(JH7110_SYSCLK_I2STX1_BCLK, "i2stx1_bclk", 0, 2,
 		    JH7110_SYSCLK_I2STX1_BCLK_MST,
 		    JH7110_SYSCLK_I2STX_BCLK_EXT),
 	JH71X0__INV(JH7110_SYSCLK_I2STX1_BCLK_INV, "i2stx1_bclk_inv", JH7110_SYSCLK_I2STX1_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 2,
+	JH71X0__MUX(JH7110_SYSCLK_I2STX1_LRCK, "i2stx1_lrck", 0, 2,
 		    JH7110_SYSCLK_I2STX1_LRCK_MST,
 		    JH7110_SYSCLK_I2STX_LRCK_EXT),
 	/* i2srx */
@@ -300,11 +300,11 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0_MDIV(JH7110_SYSCLK_I2SRX_LRCK_MST, "i2srx_lrck_mst", 64, 2,
 		    JH7110_SYSCLK_I2SRX_BCLK_MST_INV,
 		    JH7110_SYSCLK_I2SRX_BCLK_MST),
-	JH71X0__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 2,
+	JH71X0__MUX(JH7110_SYSCLK_I2SRX_BCLK, "i2srx_bclk", 0, 2,
 		    JH7110_SYSCLK_I2SRX_BCLK_MST,
 		    JH7110_SYSCLK_I2SRX_BCLK_EXT),
 	JH71X0__INV(JH7110_SYSCLK_I2SRX_BCLK_INV, "i2srx_bclk_inv", JH7110_SYSCLK_I2SRX_BCLK),
-	JH71X0__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 2,
+	JH71X0__MUX(JH7110_SYSCLK_I2SRX_LRCK, "i2srx_lrck", 0, 2,
 		    JH7110_SYSCLK_I2SRX_LRCK_MST,
 		    JH7110_SYSCLK_I2SRX_LRCK_EXT),
 	/* pdm */
@@ -314,7 +314,7 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	JH71X0_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0, JH7110_SYSCLK_AHB0),
 	JH71X0_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0, JH7110_SYSCLK_APB0),
 	JH71X0_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64, JH7110_SYSCLK_MCLK),
-	JH71X0__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 2,
+	JH71X0__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 0, 2,
 		    JH7110_SYSCLK_TDM_INTERNAL,
 		    JH7110_SYSCLK_TDM_EXT),
 	JH71X0__INV(JH7110_SYSCLK_TDM_TDM_INV, "tdm_tdm_inv", JH7110_SYSCLK_TDM_TDM),
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 34bb11c72eb7..23e052fc1549 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -61,10 +61,10 @@ struct jh71x0_clk_data {
 	.parents = { [0] = _parent },						\
 }
 
-#define JH71X0__MUX(_idx, _name, _nparents, ...)				\
+#define JH71X0__MUX(_idx, _name, _flags, _nparents, ...)			\
 [_idx] = {									\
 	.name = _name,								\
-	.flags = 0,								\
+	.flags = _flags,							\
 	.max = ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
 	.parents = { __VA_ARGS__ },						\
 }
-- 
2.43.0


