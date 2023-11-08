Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7027C7E5884
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjKHOSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjKHOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:18:42 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237EC1FC1;
        Wed,  8 Nov 2023 06:18:39 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8CPNBh030956;
        Wed, 8 Nov 2023 15:16:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=NspPtzR
        PilZb1+CGUuexq7s4WpKeTVApUDMwx70RC58=; b=JrWqmV1xZZJFuJI2sjGftax
        lY4JkdRsW8PzKNHlSSdmIn9U5aCs44nCz9/0liP4e5b0DZDS2AG+pPLy0lMPH3ZQ
        C/GRXSCH7w1XrwRfxLLVq9Nden40wyDsd5kaihwCcfsI3eO4YPa8YfKZl3riNWWF
        5zbNle5aTV81uh1xJfG+/c8f/gNdizu4FmYHQzvll8RP1DGbqGq4KbzlJDxphM0U
        lMQQ1mfEkBbC0A6tB+JXoFwEZkorNeoZqGP7H1UUqPkD/2Zmf4CjKmHrB6DcBZ55
        WNJ+RynN2Bc1/gcRqbc/yagHWrbS+/kpym9Vp3lklXmQ1t07s2rgIrKjBJ0n8kQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26bsmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 15:16:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53D22100051;
        Wed,  8 Nov 2023 15:16:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F6F4237D97;
        Wed,  8 Nov 2023 15:16:40 +0100 (CET)
Received: from localhost (10.252.14.202) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 Nov
 2023 15:16:39 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-mmc@vger.kernel.org>
CC:     Yang Yingliang <yangyingliang@huawei.com>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH v3] mmc: mmci: stm32: add SDIO in-band interrupt mode
Date:   Wed, 8 Nov 2023 15:16:37 +0100
Message-ID: <20231108141637.119497-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.14.202]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_02,2023-11-08_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Kerello <christophe.kerello@foss.st.com>

Add the support of SDIO in-band interrupt mode for STM32 and Ux500
variants.
It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
It is not enabled by default on Ux500 variant as this is unstable and
Ux500 users should use out-of-band IRQs.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
Updates on v3:
* remove variant ops enable_sdio_irq & sdio_irq and use common
functions (mmci_write_sdio_irq_bit() & mmci_signal_sdio_irq())
* enable datactrl_mask_sdio during probe if relevant and keep it
enabled in mmci_write_datactrlreg().

Updates on v2:
* rename use_sdio_irq to supports_sdio_irq and change it to bool
* use common code for ux500 and stm32 variants

---
 drivers/mmc/host/mmci.c | 69 +++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e967cca7a16f..b790c3c3c8f9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -273,6 +273,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.stm32_idmabsize_align	= BIT(5),
+	.supports_sdio_irq	= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
@@ -300,6 +301,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 5),
 	.stm32_idmabsize_align	= BIT(5),
+	.supports_sdio_irq	= true,
 	.dma_lli		= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
@@ -328,6 +330,7 @@ static struct variant_data variant_stm32_sdmmcv3 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 6),
 	.stm32_idmabsize_align	= BIT(6),
+	.supports_sdio_irq	= true,
 	.dma_lli		= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
@@ -421,8 +424,9 @@ void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
  */
 static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 {
-	/* Keep busy mode in DPSM if enabled */
-	datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
+	/* Keep busy mode in DPSM and SDIO mask if enabled */
+	datactrl |= host->datactrl_reg & (host->variant->busy_dpsm_flag |
+					  host->variant->datactrl_mask_sdio);
 
 	if (host->datactrl_reg != datactrl) {
 		host->datactrl_reg = datactrl;
@@ -1762,6 +1766,25 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void mmci_write_sdio_irq_bit(struct mmci_host *host, int enable)
+{
+	void __iomem *base = host->base;
+	u32 mask = readl_relaxed(base + MMCIMASK0);
+
+	if (enable)
+		writel_relaxed(mask | MCI_ST_SDIOITMASK, base + MMCIMASK0);
+	else
+		writel_relaxed(mask & ~MCI_ST_SDIOITMASK, base + MMCIMASK0);
+}
+
+static void mmci_signal_sdio_irq(struct mmci_host *host, u32 status)
+{
+	if (status & MCI_ST_SDIOIT) {
+		mmci_write_sdio_irq_bit(host, 0);
+		sdio_signal_irq(host->mmc);
+	}
+}
+
 /*
  * Handle completion of command and data transfers.
  */
@@ -1806,6 +1829,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			mmci_data_irq(host, host->data, status);
 		}
 
+		if (host->variant->supports_sdio_irq)
+			mmci_signal_sdio_irq(host, status);
+
 		/*
 		 * Busy detection has been handled by mmci_cmd_irq() above.
 		 * Clear the status bit to prevent polling in IRQ context.
@@ -2042,6 +2068,35 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static void mmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	if (enable)
+		/* Keep the SDIO mode bit if SDIO irqs are enabled */
+		pm_runtime_get_sync(mmc_dev(mmc));
+
+	spin_lock_irqsave(&host->lock, flags);
+	mmci_write_sdio_irq_bit(host, enable);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!enable) {
+		pm_runtime_mark_last_busy(mmc_dev(mmc));
+		pm_runtime_put_autosuspend(mmc_dev(mmc));
+	}
+}
+
+static void mmci_ack_sdio_irq(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	mmci_write_sdio_irq_bit(host, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
@@ -2317,6 +2372,16 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	}
 
+	if (variant->supports_sdio_irq && host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
+		mmci_ops.enable_sdio_irq = mmci_enable_sdio_irq;
+		mmci_ops.ack_sdio_irq	= mmci_ack_sdio_irq;
+
+		mmci_write_datactrlreg(host,
+				       host->variant->datactrl_mask_sdio);
+	}
+
 	/* Variants with mandatory busy timeout in HW needs R1B responses. */
 	if (variant->busy_timeout)
 		mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 34d9897c289b..a5eb4ced4d5d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -331,6 +331,7 @@ enum mmci_busy_state {
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @dma_lli: true if variant has dma link list feature.
+ * @supports_sdio_irq: allow SD I/O card to interrupt the host
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
  * @dma_flow_controller: use peripheral as flow controller for DMA.
  */
@@ -377,6 +378,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	u8			dma_lli:1;
+	bool			supports_sdio_irq;
 	u32			stm32_idmabsize_mask;
 	u32			stm32_idmabsize_align;
 	bool			dma_flow_controller;
-- 
2.34.1

