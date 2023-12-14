Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2816812F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444176AbjLNLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444087AbjLNLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:51:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBA11A;
        Thu, 14 Dec 2023 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702554672; x=1734090672;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BhZf7wz/FDt/FQmzz/IDWDH8og7hknv+Q19tZaOh3wA=;
  b=jLmFwZu9TRdpJhDYpUwtdR/Ras5F9Mk//bdX9vsWVSbkGuPZ16yg/6W6
   jSXmEGvJLCHgapGU3L+gQmIOX59DwFzsYklwX29DteDRfR1JX/djFE0dU
   soUyJLS8YWV4jZgXkFV9w+qt3/Q7qyvTz75/v6M8Uj9wfPCBX2LD8/NSD
   ejyKIqke6qqSHKUdY+zN2qzLolJ6gP6HfLe7O8iWElvLzpqcAzLEeJUvK
   fyK5w6gh5fPOjTD7ljfBXpyMLwNBXWrwFO7dPbdRxD7caLdionG4DCfss
   ETmArdn+golZBK2P5H16lYgV+onHBRaa6RIQtdSublPSnR0emzUKYBAcB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16658808"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="16658808"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="844679349"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="844679349"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.119])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 03:51:07 -0800
Message-ID: <e9ef79c4-c769-49d3-813b-0d78d1e4ede1@intel.com>
Date:   Thu, 14 Dec 2023 13:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V3, 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Content-Language: en-US
To:     Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu@broadcom.com>
References: <20231209165816.39044-1-kamal.dasu@broadcom.com>
 <20231209165816.39044-2-kamal.dasu@broadcom.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231209165816.39044-2-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 18:58, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> 74165b0 shall use a new sdio controller core version which
> requires a different reset sequence. For core reset we use
> sdhci_reset. For CMD and/or DATA reset added a new function
> to also enable SDCHI clocks SDHCI_CLOCK_CARD_EN

SDCHI -> SDHCI

> SDHCI_CLOCK_INT_EN along with the SDHCI_RESET_CMD and/or
> SDHCI_RESET_DATA fields.
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312091608.0VbkRxlh-lkp@intel.com/
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202312091905.UGzltx8A-lkp@intel.com/``````````````

???

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index c23251bb95f3..d4bd5b3c0fa4 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -44,8 +44,13 @@ struct brcmstb_match_priv {
>  
>  static inline void enable_clock_gating(struct sdhci_host *host)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 reg;
>  
> +	if (!(priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK))
> +		return;
> +
>  	reg = sdhci_readl(host, SDHCI_VENDOR);
>  	reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
>  	sdhci_writel(host, reg, SDHCI_VENDOR);
> @@ -53,14 +58,54 @@ static inline void enable_clock_gating(struct sdhci_host *host)
>  
>  static void brcmstb_reset(struct sdhci_host *host, u8 mask)
>  {
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -
>  	sdhci_and_cqhci_reset(host, mask);
>  
>  	/* Reset will clear this, so re-enable it */
> -	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
> -		enable_clock_gating(host);
> +	enable_clock_gating(host);
> +}
> +
> +static void brcmstb_sdhci_reset_cmd_data(struct sdhci_host *host, u8 mask)
> +{
> +	ktime_t timeout;
> +	u32 reg;
> +	u32 new_mask = (mask &  (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) << 24;
> +
> +	new_mask |= SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN;
> +	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);

Is it really necessary to write both registers together?  If
so, maybe add a comment.

> +	sdhci_writel(host, reg | new_mask, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 10 ms */
> +	timeout = ktime_add_ms(ktime_get(), 10);
> +
> +	/* hw clears the bit when it's done */
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Reset 0x%x never completed.\n",
> +				mmc_hostname(host->mmc), (int)mask);
> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}

For new code we should try to use read_poll_timeout_atomic() or other.

> +}
> +
> +static void brcmstb_reset_74165b0(struct sdhci_host *host, u8 mask)
> +{
> +	/* take care of RESET_ALL as usual */
> +	if (mask & SDHCI_RESET_ALL)
> +		sdhci_and_cqhci_reset(host, SDHCI_RESET_ALL);
> +
> +	/* cmd and/or data treated differently on this core */
> +	if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))
> +		brcmstb_sdhci_reset_cmd_data(host, mask);
> +
> +	/* Reset will clear this, so re-enable it */
> +	enable_clock_gating(host);
>  }
>  
>  static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -162,6 +207,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
>  };
>  
> +static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
> +	.set_clock = sdhci_brcmstb_set_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = brcmstb_reset_74165b0,
> +	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
> +};
> +
>  static struct brcmstb_match_priv match_priv_7425 = {
>  	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
>  	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
> @@ -179,10 +231,17 @@ static const struct brcmstb_match_priv match_priv_7216 = {
>  	.ops = &sdhci_brcmstb_ops_7216,
>  };
>  
> +static struct brcmstb_match_priv match_priv_74165b0 = {
> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
> +	.hs400es = sdhci_brcmstb_hs400es,
> +	.ops = &sdhci_brcmstb_ops_74165b0,
> +};
> +
>  static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
>  	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
>  	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
>  	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
> +	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
>  	{},
>  };
>  

