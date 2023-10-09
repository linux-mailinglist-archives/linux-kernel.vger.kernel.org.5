Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403FA7BE528
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbjJIPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJIPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:39:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCB8F;
        Mon,  9 Oct 2023 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696865984; x=1728401984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XPmcp3QX7RYooYT+lrKkpKzAN+COiquvuJPbaHa8BpE=;
  b=HU2WdFSBPcIRTEnmcstucgYhIHKJE+/KwVytKZq3WhNXIkEywVwVZ+pX
   I+ZAjwHBDL1CJ4ZEztcW1RE4Bq/zL9ED2TXDek3UxYi14xwI6GEc3fXe0
   VtnwjMrnQGhXBPp/4BF3Xb26x95xISmUAlkkXuEVpgvtbY0P+vXupAXCk
   FP0Wo5x4+5PjSV4FwTev5pJ3YjN1LgDQUzUGu+0fatecXpi1Su4vyd/qC
   LO3+A2yT654Uftd28dgehtYPZRcbVsanwDyXnrrE2C6l5gaitYIKUIZuC
   7MZkQ0fdOUHIZg/CyT2QiFXevpGu58CK2TlziIx3BvjL8Vhm2k1iY6fWf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381441116"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="381441116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869293167"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="869293167"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.27])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:39:40 -0700
Message-ID: <0932b124-16da-495c-9706-bbadadb3b076@intel.com>
Date:   Mon, 9 Oct 2023 18:39:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Implement SDHCI CQE support for DesignWare SDHCI.
Content-Language: en-US
To:     Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
References: <20231002113301.1531717-1-serghox@gmail.com>
 <20231002113301.1531717-3-serghox@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231002113301.1531717-3-serghox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 14:33, Sergey Khimich wrote:
> From: Sergey Khimich <serghox@gmail.com>
> 
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
> 
> Signed-off-by: Sergey Khimich <serghox@gmail.com>
> ---
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 233 +++++++++++++++++++++++++++-
>  2 files changed, 232 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 554e67103c1a..f3380b014ca9 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -233,6 +233,7 @@ config MMC_SDHCI_OF_DWCMSHC
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
>  	depends on COMMON_CLK
> +	select MMC_CQHCI
>  	help
>  	  This selects Synopsys DesignWare Cores Mobile Storage Controller
>  	  support.
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 3a3bae6948a8..7d43ae011811 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -20,6 +20,7 @@
>  #include <linux/sizes.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>  
>  #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>  
> @@ -36,6 +37,9 @@
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
>  
> +/* DWC IP vendor area 2 pointer */
> +#define DWCMSHC_P_VENDOR_AREA2		0xea
> +
>  /* Rockchip specific Registers */
>  #define DWCMSHC_EMMC_DLL_CTRL		0x800
>  #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> @@ -75,6 +79,10 @@
>  #define BOUNDARY_OK(addr, len) \
>  	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>  
> +#define DWCMSHC_SDHCI_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
> +					 SDHCI_TRNS_BLK_CNT_EN | \
> +					 SDHCI_TRNS_DMA)
> +
>  enum dwcmshc_rk_type {
>  	DWCMSHC_RK3568,
>  	DWCMSHC_RK3588,
> @@ -90,7 +98,8 @@ struct rk35xx_priv {
>  
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
> -	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> +	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
> +	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>  	void *priv; /* pointer to SoC private stuff */
>  };
>  
> @@ -210,6 +219,147 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	sdhci_writel(host, vendor, reg);
>  }
>  
> +static u32 dwcmshc_cqe_irq_handler(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static void dwcmshc_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 pstate;
> +	u8 ctrl;
> +	int count = 10;
> +
> +	/*
> +	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
> +	 * the case after tuning, so ensure the buffer is drained.
> +	 */
> +	pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (pstate & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		pstate = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +		if (count-- == 0) {
> +			dev_warn(mmc_dev(host->mmc),
> +				 "CQE may get stuck because the Buffer Read Enable bit is set\n");
> +			break;
> +		}
> +		mdelay(1);
> +	}

An alternative, which might be easier, is to do a
data reset which may also help allow the device to
subsequently enter low power states.
Refer commit f8870ae6e2d6be75b1accc2db981169fdfbea7ab
and commit 7b7d57fd1b773d25d8358c6017592b4928bf76ce

> +
> +	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
> +
> +	sdhci_cqe_enable(mmc);
> +
> +	/*
> +	 * The "DesignWare Cores Mobile Storage Host Controller
> +	 * DWC_mshc / DWC_mshc_lite Databook" says:
> +	 * when Host Version 4 Enable" is 1 in Host Control 2 register,
> +	 * SDHCI_CTRL_ADMA32 bit means ADMA2 is selected.
> +	 * Selection of 32-bit/64-bit System Addressing:
> +	 * either 32-bit or 64-bit system addressing is selected by
> +	 * 64-bit Addressing bit in Host Control 2 register.
> +	 *
> +	 * On the other hand the "DesignWare Cores Mobile Storage Host
> +	 * Controller DWC_mshc / DWC_mshc_lite User Guide" says, that we have to
> +	 * set DMA_SEL to ADMA2 _only_ mode in the Host Control 2 register.
> +	 */
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +	ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +	ctrl |= SDHCI_CTRL_ADMA32;
> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
> +static void dwcmshc_sdhci_cqe_disable(struct mmc_host *mmc, bool recovery)
> +{
> +	/*
> +	 * If an ioctl was issued, cqe_disable will be called.
> +	 * For CQE of sdhci-of-dwcmshc, the previous in-flight cmd will be lost quietly.
> +	 * So wait for mmc idle state.

This sounds like it should be fixed in the mmc block driver.
Can you provide an example of when this happens?

> +	 */
> +	mmc->cqe_ops->cqe_wait_for_idle(mmc);
> +
> +	return sdhci_cqe_disable(mmc, recovery);
> +}
> +
> +static void dwcmshc_cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
> +					bool dma64)
> +{
> +	__le32 *attr = (__le32 __force *)desc;
> +
> +	*attr = (CQHCI_VALID(1) |
> +		 CQHCI_END(end ? 1 : 0) |
> +		 CQHCI_INT(0) |
> +		 CQHCI_ACT(0x4) |
> +		 CQHCI_DAT_LENGTH(len));
> +
> +	if (dma64) {
> +		__le64 *dataddr = (__le64 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le64(addr);
> +	} else {
> +		__le32 *dataddr = (__le32 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le32(addr);
> +	}
> +}

This is the same as cqhci_set_tran_desc(). Might as well export that
instead.

> +
> +static void dwcmshc_cqhci_prep_tran_desc(struct mmc_data *data,
> +					 struct cqhci_host *cq_host,
> +					 u8 *desc, int sg_count)
> +{
> +	int i, len, tmplen, offset;
> +	bool end = false;
> +	bool dma64 = cq_host->dma64;
> +	dma_addr_t addr;
> +	struct scatterlist *sg;
> +
> +	for_each_sg(data->sg, sg, sg_count, i) {
> +		addr = sg_dma_address(sg);
> +		len = sg_dma_len(sg);
> +
> +		/*
> +		 * According to the "DesignWare Cores Mobile Storage Host Controller
> +		 * DWC_mshc / DWC_mshc_lite Databook" the host memory data buffer size
> +		 * and start address must not exceed 128 Mb. If it exceeds,
> +		 * the data buffer must be split using two descritors.
> +		 */
> +
> +		if (likely(BOUNDARY_OK(addr, len))) {
> +			if ((i + 1) == sg_count)
> +				end = true;
> +			dwcmshc_cqhci_set_tran_desc(desc, addr, len, end, dma64);
> +			desc += cq_host->trans_desc_len;
> +		} else {
> +			offset = addr & (SZ_128M - 1);
> +			tmplen = SZ_128M - offset;
> +			dwcmshc_cqhci_set_tran_desc(desc, addr, tmplen, end, dma64);
> +			desc += cq_host->trans_desc_len;
> +
> +			if ((i + 1) == sg_count)
> +				end = true;
> +
> +			addr += tmplen;
> +			len -= tmplen;
> +			dwcmshc_cqhci_set_tran_desc(desc, addr, len, end, dma64);
> +			desc += cq_host->trans_desc_len;
> +		}
> +	}
> +}

Could this be done more like dwcmshc_adma_write_desc()

> +
> +static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
>  static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -345,6 +495,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
>  };
>  
>  static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
> @@ -379,6 +530,70 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>  
> +static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
> +	.enable		= dwcmshc_sdhci_cqe_enable,
> +	.disable	= dwcmshc_sdhci_cqe_disable,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
> +	.prep_tran_desc	= dwcmshc_cqhci_prep_tran_desc,
> +};
> +
> +static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	bool dma64 = false;
> +	u16 clk;
> +	int err;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +	cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough memory\n");
> +		return;
> +	}
> +
> +	/*
> +	 * For dwcmshc host controller we have to enable internal clock
> +	 * before access to some registers from Vendor Specific Aria 2.
> +	 */
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (!(clk & SDHCI_CLOCK_INT_EN)) {
> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal clock enable error\n");
> +		goto free_cq_host;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
> +	cq_host->ops = &dwcmshc_cqhci_ops;
> +
> +	/* Enable using of 128-bit task descriptors */
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64) {
> +		dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +	}
> +	err = cqhci_init(cq_host, host->mmc, dma64);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error %d\n", err);
> +		goto int_clok_disable;
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
> +
> +	return;
> +
> +int_clok_disable:

'clok' is an odd abbreviation of 'clock'.  Perhaps 'clk' or just 'clock'

> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +free_cq_host:
> +	devm_kfree(&pdev->dev, cq_host);
> +}
> +
>  static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
> @@ -471,7 +686,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct rk35xx_priv *rk_priv = NULL;
>  	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
> -	u32 extra;
> +	u32 extra, caps;
>  
>  	pltfm_data = device_get_match_data(&pdev->dev);
>  	if (!pltfm_data) {
> @@ -519,6 +734,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	priv->vendor_specific_area1 =
>  		sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
> +	priv->vendor_specific_area2 =
> +		sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>  
>  	host->mmc_host_ops.request = dwcmshc_request;
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
> @@ -547,6 +764,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		sdhci_enable_v4_mode(host);
>  #endif
>  
> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (caps & SDHCI_CAN_64BIT_V4)
> +		sdhci_enable_v4_mode(host);
> +
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
>  	pm_runtime_get_noresume(dev);
> @@ -557,6 +778,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_rpm;
>  
> +	/* Setup Command Queue Engine if enabled */
> +	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> +		if (caps & SDHCI_CAN_64BIT_V4)
> +			dwcmshc_cqhci_init(host, pdev);
> +		else
> +			dev_warn(dev, "Cannot enable CQE without V4 mode support\n");
> +	}
> +
>  	if (rk_priv)
>  		dwcmshc_rk35xx_postinit(host, priv);
>  

