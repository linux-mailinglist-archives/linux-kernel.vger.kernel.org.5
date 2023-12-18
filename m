Return-Path: <linux-kernel+bounces-4001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2C817686
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A45B20EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645944239F;
	Mon, 18 Dec 2023 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JaOscASu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0814239A;
	Mon, 18 Dec 2023 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BIBNMit005423;
	Mon, 18 Dec 2023 16:58:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=7wFK0+0s9ZcudccEP80hF46pxusGzBaAmfNrbX8D4mY=; b=Ja
	OscASuEN4MoZHMIhC6pZJnQwVKXWKLVHjgkOwgNbrOp/xZOIizTCWu1Jq0MUjiBJ
	x7xMoeXGAfqseSifD4kf7UizqLFzSzAJ0ugGYa1zbM4CO71aXsOpp2TrzbCvlqcf
	8GgIHfbw5rXFICTxZVwDKRD2pb3C5k8lPr3xE9N9YUss/sMZGBX5YpZU+UcvpvIL
	Yc0REkz1lnSAFOrSSxBcvJmnRIAnd4FSTx3cncxweFu0CcUCXPwj7ueiT2LJRbnY
	C/XPPOCOigKe3B5mkMxPXdC/7FQibzXuJSvTZ/Oro8h6iXMb62jnAe5cCu5n/JUg
	S3fP1gThjRMdzPQ15LLw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126ks3h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 16:58:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B48510005E;
	Mon, 18 Dec 2023 16:58:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4EFFF25F4AD;
	Mon, 18 Dec 2023 16:58:23 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Dec
 2023 16:58:23 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat
	<alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>
CC: Valentin Caron <valentin.caron@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc
Date: Mon, 18 Dec 2023 16:57:15 +0100
Message-ID: <20231218155721.359198-4-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218155721.359198-1-alain.volmat@foss.st.com>
References: <20231218155721.359198-1-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_10,2023-12-14_01,2023-05-22_02

From: Valentin Caron <valentin.caron@foss.st.com>

Add support for the STM32MP25:
- Burst should not be enabled with the new DMA used on STM32MP25.
- STM32MP25 SPI8 has a limited feature set, it can only send words of
  8 or 16 bits and with a maximum words number of 1024.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 132 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 120 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index af0c27d8d704..e61302ef3c21 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -154,6 +154,20 @@
 /* STM32H7_SPI_I2SCFGR bit fields */
 #define STM32H7_SPI_I2SCFGR_I2SMOD	BIT(0)
 
+/* STM32MP25 SPI registers bit fields */
+#define STM32MP25_SPI_HWCFGR1			0x3F0
+
+/* STM32MP25_SPI_CR2 bit fields */
+#define STM32MP25_SPI_TSIZE_MAX_LIMITED		GENMASK(9, 0)
+
+/* STM32MP25_SPI_HWCFGR1 */
+#define STM32MP25_SPI_HWCFGR1_FULLCFG		GENMASK(27, 24)
+#define STM32MP25_SPI_HWCFGR1_FULLCFG_LIMITED	0x0
+#define STM32MP25_SPI_HWCFGR1_FULLCFG_FULL	0x1
+#define STM32MP25_SPI_HWCFGR1_DSCFG		GENMASK(19, 16)
+#define STM32MP25_SPI_HWCFGR1_DSCFG_16_B	0x0
+#define STM32MP25_SPI_HWCFGR1_DSCFG_32_B	0x1
+
 /* STM32H7 SPI Master Baud Rate min/max divisor */
 #define STM32H7_SPI_MBR_DIV_MIN		(2 << STM32H7_SPI_CFG1_MBR_MIN)
 #define STM32H7_SPI_MBR_DIV_MAX		(2 << STM32H7_SPI_CFG1_MBR_MAX)
@@ -207,6 +221,7 @@ struct stm32_spi_reg {
  * @br: baud rate register and bitfields
  * @rx: SPI RX data register
  * @tx: SPI TX data register
+ * @fullcfg: SPI full or limited feature set register
  */
 struct stm32_spi_regspec {
 	const struct stm32_spi_reg en;
@@ -219,6 +234,7 @@ struct stm32_spi_regspec {
 	const struct stm32_spi_reg br;
 	const struct stm32_spi_reg rx;
 	const struct stm32_spi_reg tx;
+	const struct stm32_spi_reg fullcfg;
 };
 
 struct stm32_spi;
@@ -250,6 +266,7 @@ struct stm32_spi;
  * @has_fifo: boolean to know if fifo is used for driver
  * @has_device_mode: is this compatible capable to switch on device mode
  * @flags: compatible specific SPI controller flags used at registration time
+ * @prevent_dma_burst: boolean to indicate to prevent DMA burst
  */
 struct stm32_spi_cfg {
 	const struct stm32_spi_regspec *regs;
@@ -274,6 +291,7 @@ struct stm32_spi_cfg {
 	bool has_fifo;
 	bool has_device_mode;
 	u16 flags;
+	bool prevent_dma_burst;
 };
 
 /**
@@ -287,6 +305,8 @@ struct stm32_spi_cfg {
  * @lock: prevent I/O concurrent access
  * @irq: SPI controller interrupt line
  * @fifo_size: size of the embedded fifo in bytes
+ * @t_size_max: maximum number of data of one transfer
+ * @feature_set: SPI full or limited feature set
  * @cur_midi: host inter-data idleness in ns
  * @cur_speed: speed configured in Hz
  * @cur_half_period: time of a half bit in us
@@ -314,6 +334,10 @@ struct stm32_spi {
 	spinlock_t lock; /* prevent I/O concurrent access */
 	int irq;
 	unsigned int fifo_size;
+	unsigned int t_size_max;
+	unsigned int feature_set;
+#define STM32_SPI_FEATURE_LIMITED	STM32MP25_SPI_HWCFGR1_FULLCFG_LIMITED	/* 0x0 */
+#define STM32_SPI_FEATURE_FULL		STM32MP25_SPI_HWCFGR1_FULLCFG_FULL	/* 0x1 */
 
 	unsigned int cur_midi;
 	unsigned int cur_speed;
@@ -371,6 +395,28 @@ static const struct stm32_spi_regspec stm32h7_spi_regspec = {
 	.tx = { STM32H7_SPI_TXDR },
 };
 
+static const struct stm32_spi_regspec stm32mp25_spi_regspec = {
+	/* SPI data transfer is enabled but spi_ker_ck is idle.
+	 * CFG1 and CFG2 registers are write protected when SPE is enabled.
+	 */
+	.en = { STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE },
+
+	.dma_rx_en = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_RXDMAEN },
+	.dma_tx_en = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_TXDMAEN },
+
+	.cpol = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPOL },
+	.cpha = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPHA },
+	.lsb_first = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_LSBFRST },
+	.cs_high = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_SSIOP },
+	.br = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_MBR,
+		STM32H7_SPI_CFG1_MBR_SHIFT },
+
+	.rx = { STM32H7_SPI_RXDR },
+	.tx = { STM32H7_SPI_TXDR },
+
+	.fullcfg = { STM32MP25_SPI_HWCFGR1, STM32MP25_SPI_HWCFGR1_FULLCFG },
+};
+
 static inline void stm32_spi_set_bits(struct stm32_spi *spi,
 				      u32 offset, u32 bits)
 {
@@ -457,6 +503,28 @@ static int stm32h7_spi_get_bpw_mask(struct stm32_spi *spi)
 	return SPI_BPW_RANGE_MASK(4, max_bpw);
 }
 
+/**
+ * stm32mp25_spi_get_bpw_mask - Return bits per word mask
+ * @spi: pointer to the spi controller data structure
+ */
+static int stm32mp25_spi_get_bpw_mask(struct stm32_spi *spi)
+{
+	u32 dscfg, max_bpw;
+
+	if (spi->feature_set == STM32_SPI_FEATURE_LIMITED) {
+		dev_dbg(spi->dev, "8-bit or 16-bit data frame supported\n");
+		return SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	}
+
+	dscfg = FIELD_GET(STM32MP25_SPI_HWCFGR1_DSCFG,
+			  readl_relaxed(spi->base + STM32MP25_SPI_HWCFGR1));
+	max_bpw = 16;
+	if (dscfg == STM32MP25_SPI_HWCFGR1_DSCFG_32_B)
+		max_bpw = 32;
+	dev_dbg(spi->dev, "%d-bit maximum data frame\n", max_bpw);
+	return SPI_BPW_RANGE_MASK(4, max_bpw);
+}
+
 /**
  * stm32_spi_prepare_mbr - Determine baud rate divisor value
  * @spi: pointer to the spi controller data structure
@@ -1103,7 +1171,7 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 		int ret;
 
 		ret = spi_split_transfers_maxwords(ctrl, msg,
-						   STM32H7_SPI_TSIZE_MAX,
+						   spi->t_size_max,
 						   GFP_KERNEL | GFP_DMA);
 		if (ret)
 			return ret;
@@ -1168,7 +1236,7 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 {
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_caps caps;
-	u32 maxburst;
+	u32 maxburst = 1;
 	int ret;
 
 	if (spi->cur_bpw <= 8)
@@ -1178,15 +1246,9 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 	else
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	if (spi->cfg->has_fifo) {
-		/* Valid for DMA Half or Full Fifo threshold */
-		if (spi->cur_fthlv == 2)
-			maxburst = 1;
-		else
-			maxburst = spi->cur_fthlv;
-	} else {
-		maxburst = 1;
-	}
+	/* Valid for DMA Half or Full Fifo threshold */
+	if (!spi->cfg->prevent_dma_burst && spi->cfg->has_fifo && spi->cur_fthlv != 2)
+		maxburst = spi->cur_fthlv;
 
 	/* Get the DMA channel caps, and adjust maxburst if possible */
 	ret = dma_get_slave_caps(dma_chan, &caps);
@@ -1671,7 +1733,7 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
  */
 static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
 {
-	if (nb_words <= STM32H7_SPI_TSIZE_MAX) {
+	if (nb_words <= spi->t_size_max) {
 		writel_relaxed(FIELD_PREP(STM32H7_SPI_CR2_TSIZE, nb_words),
 			       spi->base + STM32H7_SPI_CR2);
 	} else {
@@ -1954,7 +2016,37 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.has_device_mode = true,
 };
 
+/*
+ * STM32MP2 is compatible with the STM32H7 except:
+ * - enforce the DMA maxburst value to 1
+ * - spi8 have limited feature set (TSIZE_MAX = 1024, BPW of 8 OR 16)
+ */
+static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
+	.regs = &stm32mp25_spi_regspec,
+	.get_fifo_size = stm32h7_spi_get_fifo_size,
+	.get_bpw_mask = stm32mp25_spi_get_bpw_mask,
+	.disable = stm32h7_spi_disable,
+	.config = stm32h7_spi_config,
+	.set_bpw = stm32h7_spi_set_bpw,
+	.set_mode = stm32h7_spi_set_mode,
+	.set_data_idleness = stm32h7_spi_data_idleness,
+	.set_number_of_data = stm32h7_spi_number_of_data,
+	.transfer_one_dma_start = stm32h7_spi_transfer_one_dma_start,
+	.dma_rx_cb = stm32_spi_dma_rx_cb,
+	/*
+	 * dma_tx_cb is not necessary since in case of TX, dma is followed by
+	 * SPI access hence handling is performed within the SPI interrupt
+	 */
+	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.irq_handler_thread = stm32h7_spi_irq_thread,
+	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
+	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
+	.has_fifo = true,
+	.prevent_dma_burst = true,
+};
+
 static const struct of_device_id stm32_spi_of_match[] = {
+	{ .compatible = "st,stm32mp25-spi", .data = (void *)&stm32mp25_spi_cfg },
 	{ .compatible = "st,stm32h7-spi", .data = (void *)&stm32h7_spi_cfg },
 	{ .compatible = "st,stm32f4-spi", .data = (void *)&stm32f4_spi_cfg },
 	{ .compatible = "st,stm32f7-spi", .data = (void *)&stm32f7_spi_cfg },
@@ -2058,6 +2150,22 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->cfg->has_fifo)
 		spi->fifo_size = spi->cfg->get_fifo_size(spi);
 
+	spi->feature_set = STM32_SPI_FEATURE_FULL;
+	if (spi->cfg->regs->fullcfg.reg) {
+		spi->feature_set =
+			FIELD_GET(STM32MP25_SPI_HWCFGR1_FULLCFG,
+				  readl_relaxed(spi->base + spi->cfg->regs->fullcfg.reg));
+
+		dev_dbg(spi->dev, "%s feature set\n",
+			spi->feature_set == STM32_SPI_FEATURE_FULL ? "full" : "limited");
+	}
+
+	/* Only for STM32H7 and after */
+	spi->t_size_max = spi->feature_set == STM32_SPI_FEATURE_FULL ?
+				STM32H7_SPI_TSIZE_MAX :
+				STM32MP25_SPI_TSIZE_MAX_LIMITED;
+	dev_dbg(spi->dev, "one message max size %d\n", spi->t_size_max);
+
 	ret = spi->cfg->config(spi);
 	if (ret) {
 		dev_err(&pdev->dev, "controller configuration failed: %d\n",
-- 
2.25.1


