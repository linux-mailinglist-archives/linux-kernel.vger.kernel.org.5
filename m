Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B397A08AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbjINPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjINPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:09:40 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595D01FDE;
        Thu, 14 Sep 2023 08:09:36 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EDUaQk012973;
        Thu, 14 Sep 2023 17:09:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=Llasz91
        kExcUst5D/Q+VIfLb+oe3DIWGDBBs81P3iKY=; b=K8Pt3zXQYHJFdM7aTiuQlNI
        60uLlqpOD0OMbYYsf+S5/Yf5if/kGhu8xJnfqMcx8cC7fiGorFEU0fLgPkH1ukyW
        wzhd0t7jNL+5zFLaE9Dp1t9tf5oy2k+M2BIVwe6VHGi/T7axfIyyUvrS/9UUchvR
        0AFr2D46MCZInBFP5Osf2Ejcr6WPvkA1Isp2+gJ3M4cC+JfnHaohYUdzY4K9JfCM
        /zxFY/Fp4ASe6V3wDqMdbiYeshfz0HizrR6umCyxG9NiETVzAxgOZfiusakkqLcA
        MdgtyAXqKtwc0xHpCjDH5mu5l7HymfhJk2CmPeWxvA6dhvxGOHA6QriS5BkogBQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t434d0ec4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:09:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D332910005A;
        Thu, 14 Sep 2023 17:09:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C56B925AF19;
        Thu, 14 Sep 2023 17:09:10 +0200 (CEST)
Received: from localhost (10.201.20.125) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:09:07 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH v2] mmc: mmci: stm32: add SDIO in-band interrupt mode
Date:   Thu, 14 Sep 2023 17:09:04 +0200
Message-ID: <20230914150904.155630-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.125]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
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
Updates on v2:
* rename use_sdio_irq to supports_sdio_irq and change it to bool
* use common code for ux500 and stm32 variants

---
 drivers/mmc/host/mmci.c             | 85 +++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h             |  7 +++
 drivers/mmc/host/mmci_stm32_sdmmc.c |  2 +
 3 files changed, 94 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index dda756a563793..65cc03ee7f23b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -272,6 +272,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.stm32_idmabsize_align	= BIT(5),
+	.supports_sdio_irq	= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
@@ -299,6 +300,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 5),
 	.stm32_idmabsize_align	= BIT(5),
+	.supports_sdio_irq	= true,
 	.dma_lli		= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
@@ -327,6 +329,7 @@ static struct variant_data variant_stm32_sdmmcv3 = {
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.stm32_idmabsize_mask	= GENMASK(16, 6),
 	.stm32_idmabsize_align	= BIT(6),
+	.supports_sdio_irq	= true,
 	.dma_lli		= true,
 	.busy_timeout		= true,
 	.busy_detect		= true,
@@ -423,6 +426,11 @@ static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 	/* Keep busy mode in DPSM if enabled */
 	datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
 
+	/* Keep SD I/O interrupt mode enabled */
+	if (host->variant->supports_sdio_irq &&
+	    host->mmc->caps & MMC_CAP_SDIO_IRQ)
+		datactrl |= host->variant->datactrl_mask_sdio;
+
 	if (host->datactrl_reg != datactrl) {
 		host->datactrl_reg = datactrl;
 		writel(datactrl, host->base + MMCIDATACTRL);
@@ -817,6 +825,25 @@ static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
 	return (host->busy_state == MMCI_BUSY_DONE);
 }
 
+void ux500_and_stm32_enable_sdio_irq(struct mmci_host *host, int enable)
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
+void ux500_and_stm32_sdio_irq(struct mmci_host *host, u32 status)
+{
+	if (status & MCI_ST_SDIOIT) {
+		ux500_and_stm32_enable_sdio_irq(host, 0);
+		sdio_signal_irq(host->mmc);
+	}
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -1191,6 +1218,8 @@ static void ux500_variant_init(struct mmci_host *host)
 {
 	host->ops = &mmci_variant_ops;
 	host->ops->busy_complete = ux500_busy_complete;
+	host->ops->enable_sdio_irq = ux500_and_stm32_enable_sdio_irq;
+	host->ops->sdio_irq = ux500_and_stm32_sdio_irq;
 }
 
 static void ux500v2_variant_init(struct mmci_host *host)
@@ -1198,6 +1227,8 @@ static void ux500v2_variant_init(struct mmci_host *host)
 	host->ops = &mmci_variant_ops;
 	host->ops->busy_complete = ux500_busy_complete;
 	host->ops->get_datactrl_cfg = ux500v2_get_dctrl_cfg;
+	host->ops->enable_sdio_irq = ux500_and_stm32_enable_sdio_irq;
+	host->ops->sdio_irq = ux500_and_stm32_sdio_irq;
 }
 
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1805,6 +1836,11 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 			mmci_data_irq(host, host->data, status);
 		}
 
+		if (host->variant->supports_sdio_irq &&
+		    host->mmc->caps & MMC_CAP_SDIO_IRQ &&
+		    host->ops && host->ops->sdio_irq)
+			host->ops->sdio_irq(host, status);
+
 		/*
 		 * Busy detection has been handled by mmci_cmd_irq() above.
 		 * Clear the status bit to prevent polling in IRQ context.
@@ -2041,6 +2077,45 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static void mmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	if (!host->variant->supports_sdio_irq)
+		return;
+
+	if (host->ops && host->ops->enable_sdio_irq) {
+		if (enable)
+			/* Keep device active while SDIO IRQ is enabled */
+			pm_runtime_get_sync(mmc_dev(mmc));
+
+		spin_lock_irqsave(&host->lock, flags);
+		host->ops->enable_sdio_irq(host, enable);
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		if (!enable) {
+			pm_runtime_mark_last_busy(mmc_dev(mmc));
+			pm_runtime_put_autosuspend(mmc_dev(mmc));
+		}
+	}
+}
+
+static void mmci_ack_sdio_irq(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	if (!host->variant->supports_sdio_irq)
+		return;
+
+	if (host->ops && host->ops->enable_sdio_irq) {
+		spin_lock_irqsave(&host->lock, flags);
+		host->ops->enable_sdio_irq(host, 1);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
+
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
@@ -2049,6 +2124,8 @@ static struct mmc_host_ops mmci_ops = {
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmci_get_cd,
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
+	.enable_sdio_irq = mmci_enable_sdio_irq,
+	.ack_sdio_irq	= mmci_ack_sdio_irq,
 };
 
 static void mmci_probe_level_translator(struct mmc_host *mmc)
@@ -2316,6 +2393,14 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 	}
 
+	if (variant->supports_sdio_irq && host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
+		if (variant->datactrl_mask_sdio)
+			mmci_write_datactrlreg(host,
+					       host->variant->datactrl_mask_sdio);
+	}
+
 	/* Variants with mandatory busy timeout in HW needs R1B responses. */
 	if (variant->busy_timeout)
 		mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 253197f132fca..5ea4975c18ec5 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -331,6 +331,7 @@ enum mmci_busy_state {
  *	       register.
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @dma_lli: true if variant has dma link list feature.
+ * @supports_sdio_irq: allow SD I/O card to interrupt the host
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
  */
 struct variant_data {
@@ -376,6 +377,7 @@ struct variant_data {
 	u32			start_err;
 	u32			opendrain;
 	u8			dma_lli:1;
+	bool			supports_sdio_irq;
 	u32			stm32_idmabsize_mask;
 	u32			stm32_idmabsize_align;
 	void (*init)(struct mmci_host *host);
@@ -400,6 +402,8 @@ struct mmci_host_ops {
 	bool (*busy_complete)(struct mmci_host *host, struct mmc_command *cmd, u32 status, u32 err_msk);
 	void (*pre_sig_volt_switch)(struct mmci_host *host);
 	int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
+	void (*enable_sdio_irq)(struct mmci_host *host, int enable);
+	void (*sdio_irq)(struct mmci_host *host, u32 status);
 };
 
 struct mmci_host {
@@ -481,6 +485,9 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
 void mmci_dmae_error(struct mmci_host *host);
 #endif
 
+void ux500_and_stm32_enable_sdio_irq(struct mmci_host *host, int enable);
+void ux500_and_stm32_sdio_irq(struct mmci_host *host, u32 status);
+
 #ifdef CONFIG_MMC_QCOM_DML
 void qcom_variant_init(struct mmci_host *host);
 #else
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 35067e1e6cd80..fbfaa0bcec51e 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -681,6 +681,8 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.busy_complete = sdmmc_busy_complete,
 	.pre_sig_volt_switch = sdmmc_pre_sig_volt_vswitch,
 	.post_sig_volt_switch = sdmmc_post_sig_volt_switch,
+	.enable_sdio_irq = ux500_and_stm32_enable_sdio_irq,
+	.sdio_irq = ux500_and_stm32_sdio_irq,
 };
 
 static struct sdmmc_tuning_ops dlyb_tuning_mp15_ops = {
-- 
2.34.1

