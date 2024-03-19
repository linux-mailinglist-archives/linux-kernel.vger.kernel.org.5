Return-Path: <linux-kernel+bounces-107538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF38687FDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32241C21DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F43F9D6;
	Tue, 19 Mar 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/H5Z6Gs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705B3A1B9;
	Tue, 19 Mar 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852832; cv=none; b=urAdLufx9FFn3Dfb1nn5B50RZ2blaynaSFhZfyVI5IIWHrrsaC+ypNE97ULDZM2iDKaWzcdWKfAZIiZT9tkzVhn4Z5Dvh6RFJoGAII+Ok1DrnCVRpQQJs0AdV46WO3eRO0MWc5ROnSAtU/rrHOuAkhKeL+B0QqtvzQ3YHWUiud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852832; c=relaxed/simple;
	bh=DzRtNxr0WdrIq3SArZQKMFrgnAIlu1tHahAZD0eUJII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5Zf32E3qG48sEoFDamOcT8MB5C+DTvqciC8xo9Laj94PbFhO21NF7NIu4+TQ9J1yPyClDeumcc0Ckf2CNpvwCwUUb16BI3IrOuulASekvTHeAM3eHCc1A8tyDNPp3nkoXTB3MVH8HX+0VQ1mcE0XGoEiI3u/KSsoX68b6OgBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/H5Z6Gs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710852829; x=1742388829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DzRtNxr0WdrIq3SArZQKMFrgnAIlu1tHahAZD0eUJII=;
  b=G/H5Z6GspaCenSVQOWoriN9F5ZFDnPQCZJLEL3SdQXFzHHKTneRS/jFC
   v57c3qNFfyBsRyviS934lg+lS8rQ70+tIVJ9K7jOd3bRbgWPymcvcFp//
   stAkgR8UqBSuDUA7cY5r6OMbrCQICupL0456fRFQdshuvn3AoJCakZZw+
   bdXClDJyulMLEQ8tjjgUad3doAWqWIGwLH0VCEzain3Ov9y8WF29i11z0
   yMRxLuUPrjd+RWJFQ8vtgN6VpxJBQaS5+adWGp4itbwhAPlY2Y22JfS5B
   TlpLonA36+qV1pRoC6m/Y/zLEKzmzk1/ha7mAhq1ZWtd90k/OrscW7nKh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5839716"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5839716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="18524408"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.47.203])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:53:45 -0700
Message-ID: <d44c1497-c6fc-4f50-82cf-5405ce95982b@intel.com>
Date: Tue, 19 Mar 2024 14:53:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support
To: Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jyan Chou <jyanchou@realtek.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>
References: <20240319115932.4108904-1-serghox@gmail.com>
 <20240319115932.4108904-3-serghox@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240319115932.4108904-3-serghox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/24 13:59, Sergey Khimich wrote:
> From: Sergey Khimich <serghox@gmail.com>
> 
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
> 
> Signed-off-by: Sergey Khimich <serghox@gmail.com>

Seems like it needs a re-base on latest mmc next, but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig            |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 191 +++++++++++++++++++++++++++-
>  2 files changed, 190 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 81f2c4e05287..554dbf7f2fa4 100644
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
> index a1f57af6acfb..8d6cfb648096 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -21,6 +21,7 @@
>  #include <linux/sizes.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>  
>  #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>  
> @@ -52,6 +53,9 @@
>  #define AT_CTRL_SWIN_TH_VAL_MASK	GENMASK(31, 24) /* bits [31:24] */
>  #define AT_CTRL_SWIN_TH_VAL		0x9  /* sampling window threshold */
>  
> +/* DWC IP vendor area 2 pointer */
> +#define DWCMSHC_P_VENDOR_AREA2		0xea
> +
>  /* Rockchip specific Registers */
>  #define DWCMSHC_EMMC_DLL_CTRL		0x800
>  #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> @@ -167,6 +171,10 @@
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
> @@ -182,7 +190,9 @@ struct rk35xx_priv {
>  
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
> -	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> +	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
> +	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
> +
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> @@ -441,6 +451,90 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	sdhci_writel(host, vendor, reg);
>  }
>  
> +static int dwcmshc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	int err = sdhci_execute_tuning(mmc, opcode);
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Tuning can leave the IP in an active state (Buffer Read Enable bit
> +	 * set) which prevents the entry to low power states (i.e. S0i3). Data
> +	 * reset will clear it.
> +	 */
> +	sdhci_reset(host, SDHCI_RESET_DATA);
> +
> +	return 0;
> +}
> +
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
> +	u8 ctrl;
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
> +static void dwcmshc_set_tran_desc(struct cqhci_host *cq_host, u8 **desc,
> +				  dma_addr_t addr, int len, bool end, bool dma64)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> +		cqhci_set_tran_desc(*desc, addr, len, end, dma64);
> +		return;
> +	}
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	cqhci_set_tran_desc(*desc, addr, tmplen, false, dma64);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	*desc += cq_host->trans_desc_len;
> +	cqhci_set_tran_desc(*desc, addr, len, end, dma64);
> +}
> +
> +static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
>  static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -649,6 +743,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
>  };
>  
>  static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
> @@ -700,6 +795,73 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
> +	.enable		= dwcmshc_sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
> +	.set_tran_desc	= dwcmshc_set_tran_desc,
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
> +		goto dsbl_cqe_caps;
> +	}
> +
> +	/*
> +	 * For dwcmshc host controller we have to enable internal clock
> +	 * before access to some registers from Vendor Specific Area 2.
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
> +		goto int_clock_disable;
> +	}
> +
> +	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
> +
> +	return;
> +
> +int_clock_disable:
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +free_cq_host:
> +	devm_kfree(&pdev->dev, cq_host);
> +
> +dsbl_cqe_caps:
> +	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
> +}
> +
>  static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
> @@ -796,7 +958,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct rk35xx_priv *rk_priv = NULL;
>  	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
> -	u32 extra;
> +	u32 extra, caps;
>  
>  	pltfm_data = device_get_match_data(&pdev->dev);
>  	if (!pltfm_data) {
> @@ -847,6 +1009,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	host->mmc_host_ops.request = dwcmshc_request;
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
> +	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
>  	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
>  		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> @@ -896,6 +1059,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
> @@ -906,6 +1073,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_rpm;
>  
> +	/* Setup Command Queue Engine if enabled */
> +	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> +		priv->vendor_specific_area2 =
> +			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
> +
> +		dwcmshc_cqhci_init(host, pdev);
> +	}
> +
>  	if (rk_priv)
>  		dwcmshc_rk35xx_postinit(host, priv);
>  
> @@ -961,6 +1136,12 @@ static int dwcmshc_suspend(struct device *dev)
>  
>  	pm_runtime_resume(dev);
>  
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = sdhci_suspend_host(host);
>  	if (ret)
>  		return ret;
> @@ -1005,6 +1186,12 @@ static int dwcmshc_resume(struct device *dev)
>  	if (ret)
>  		goto disable_rockchip_clks;
>  
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret = cqhci_resume(host->mmc);
> +		if (ret)
> +			goto disable_rockchip_clks;
> +	}
> +
>  	return 0;
>  
>  disable_rockchip_clks:


