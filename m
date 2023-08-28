Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BC78A6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjH1HtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjH1Hsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:48:50 -0400
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC5114;
        Mon, 28 Aug 2023 00:48:45 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 9CB7020B2B;
        Mon, 28 Aug 2023 15:48:39 +0800 (CST)
Message-ID: <cf81c490-098b-4d2b-1129-8297ccf14090@rock-chips.com>
Date:   Mon, 28 Aug 2023 15:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Jyan Chou <jyanchou@realtek.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add CQE support
Content-Language: en-GB
To:     Sergey Khimich <serghox@gmail.com>
References: <20230825143525.869906-1-serghox@gmail.com>
 <20230825143525.869906-2-serghox@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20230825143525.869906-2-serghox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sZQlZJTE4ZQhgYT0tKS0JVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQ
        Y+
X-HM-Tid: 0a8a3b1dbf122eb6kusn9cb7020b2b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6Mio*Mz0BLzINEy0cPjYS
        HzdPCjJVSlVKTUJISUtDQklLTkNMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpLTUJINwY+
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jyan Chou

On 2023/8/25 22:35, Sergey Khimich wrote:
> Implement SDHCI CQE support for DesignWare SDHCI.
> For enabling CQE support just set 'supports-cqe' in your DevTree file
> for appropriate mmc node.
> 

Hi Sergey

Jyan had pushed a version to support it:
https://patchwork.kernel.org/project/linux-mmc/patch/20230616063731.17591-1-jyanchou@realtek.com/

And obviously there are some special limitations from IP vendor
you need to address such as 128MB DMA boundary.

> Signed-off-by: Sergey Khimich <serghox@gmail.com>
> ---
>   drivers/mmc/host/Kconfig            |   1 +
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 154 +++++++++++++++++++++++++++-
>   2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490ae..c9fc790d7dba 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -233,6 +233,7 @@ config MMC_SDHCI_OF_DWCMSHC
>   	depends on MMC_SDHCI_PLTFM
>   	depends on OF
>   	depends on COMMON_CLK
> +	select MMC_CQHCI
>   	help
>   	  This selects Synopsys DesignWare Cores Mobile Storage Controller
>   	  support.
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..5ee8954a8f5a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -19,6 +19,7 @@
>   #include <linux/sizes.h>
>   
>   #include "sdhci-pltfm.h"
> +#include "cqhci.h"
>   
>   #define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
>   
> @@ -35,6 +36,9 @@
>   #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>   #define DWCMSHC_EMMC_ATCTRL		0x40
>   
> +/* DWC IP vendor area 2 pointer */
> +#define DWCMSHC_P_VENDOR_AREA2		0xea
> +
>   /* Rockchip specific Registers */
>   #define DWCMSHC_EMMC_DLL_CTRL		0x800
>   #define DWCMSHC_EMMC_DLL_RXCLK		0x804
> @@ -74,6 +78,10 @@
>   #define BOUNDARY_OK(addr, len) \
>   	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>   
> +#define DWCMCHC_SDHCI_CQE_TRNS_MODE	(SDHCI_TRNS_MULTI | \
> +					 SDHCI_TRNS_BLK_CNT_EN | \
> +					 SDHCI_TRNS_DMA)
> +
>   enum dwcmshc_rk_type {
>   	DWCMSHC_RK3568,
>   	DWCMSHC_RK3588,
> @@ -89,7 +97,8 @@ struct rk35xx_priv {
>   
>   struct dwcmshc_priv {
>   	struct clk	*bus_clk;
> -	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> +	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
> +	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>   	void *priv; /* pointer to SoC private stuff */
>   };
>   
> @@ -209,6 +218,65 @@ static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
>   	sdhci_writel(host, vendor, reg);
>   }
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
> +
> +	sdhci_writew(host, DWCMCHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
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
>   static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -344,6 +412,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>   	.get_max_clock		= dwcmshc_get_max_clock,
>   	.reset			= sdhci_reset,
>   	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
>   };
>   
>   static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
> @@ -378,6 +447,74 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>   		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>   };
>   
> +static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
> +	.enable		= dwcmshc_sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +	.dumpregs	= dwcmshc_cqhci_dumpregs,
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
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +free_cq_host:
> +	devm_kfree(&pdev->dev, cq_host);
> +}
> +
>   static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>   {
>   	int err;
> @@ -471,6 +608,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>   	const struct sdhci_pltfm_data *pltfm_data;
>   	int err;
>   	u32 extra;
> +	u32 caps;
>   
>   	pltfm_data = device_get_match_data(&pdev->dev);
>   	if (!pltfm_data) {
> @@ -518,6 +656,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>   
>   	priv->vendor_specific_area1 =
>   		sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
> +	priv->vendor_specific_area2 =
> +		sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
>   
>   	host->mmc_host_ops.request = dwcmshc_request;
>   	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
> @@ -546,12 +686,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
>   		sdhci_enable_v4_mode(host);
>   #endif
>   
> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (caps & SDHCI_CAN_64BIT_V4)
> +		sdhci_enable_v4_mode(host);
> +
>   	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>   
>   	err = sdhci_setup_host(host);
>   	if (err)
>   		goto err_clk;
>   
> +	/* Setup Command Queue Engine if enabled */
> +	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> +		if (caps & SDHCI_CAN_64BIT_V4)
> +			dwcmshc_cqhci_init(host, pdev);
> +		else
> +			dev_warn(dev, "Cannot enable CQE without V4 mode support\n");
> +	}
> +
>   	if (rk_priv)
>   		dwcmshc_rk35xx_postinit(host, priv);
>   
