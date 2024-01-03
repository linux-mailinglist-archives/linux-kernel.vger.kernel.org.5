Return-Path: <linux-kernel+bounces-15671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44962822FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17C32823E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8A1A711;
	Wed,  3 Jan 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHgYLyTf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8851A5B9;
	Wed,  3 Jan 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704293532; x=1735829532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4+titHYTzQHNaVlm+l9TYXk9CDAS8vlfMiQY4I4TOrQ=;
  b=YHgYLyTfXRrD79dMVDEzsQKJuMSfvXre0ZxRzBmXOe6R2JJXDmt+A15Y
   Ccznz38MnOHB7aTbg28RVarZw3299SNjNHcz8IfpJYK1K8Tpng784Tq8R
   a+VE4ANM6lYHpK4czHg7bn6/YQXkszF0Qm6UhOu4N8WbStlLkWqK2IN47
   EUJ8Sn8UHFdXT2OPU/luJpheaAiRAPB/GKBQyda5nUZJHjBXSkHoo0dQm
   bhuVTDGJ9cn1bMehjWUq7hr8097gdOSUgvdqayLb7PdVuBIHAij63p3/J
   T082fc6y5FhN79xsSN9HgOqJ0GQwMFnwrNkpt06ppAf3cA9KY8x47mNv5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="377172599"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="377172599"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="814277347"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="814277347"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 06:52:07 -0800
Message-ID: <d03dea3e-2ad5-4213-bf88-38a96693e5a3@intel.com>
Date: Wed, 3 Jan 2024 16:52:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Content-Language: en-US
To: Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, alcooperx@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 Kamal Dasu <kdasu@broadcom.com>
References: <20240102160910.15485-1-kamal.dasu@broadcom.com>
 <20240102160910.15485-3-kamal.dasu@broadcom.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240102160910.15485-3-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/01/24 18:09, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> 74165b0 shall use a new sdio controller core version which
> requires a different reset sequence. For core reset we use
> sdhci_reset. For CMD and/or DATA reset added a new function
> to also enable SDHCI clocks SDHCI_CLOCK_CARD_EN
> SDHCI_CLOCK_INT_EN along with the SDHCI_RESET_CMD and/or
> SDHCI_RESET_DATA fields.
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>

Subject should start "mmc: sdhci-brcmstb: " otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index c23251bb95f3..9053526fa212 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -44,8 +45,13 @@ struct brcmstb_match_priv {
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
> @@ -53,14 +59,53 @@ static inline void enable_clock_gating(struct sdhci_host *host)
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
> +	u32 new_mask = (mask &  (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) << 24;
> +	int ret;
> +	u32 reg;
> +
> +	/*
> +	 * SDHCI_CLOCK_CONTROL register CARD_EN and CLOCK_INT_EN bits shall
> +	 * be set along with SOFTWARE_RESET register RESET_CMD or RESET_DATA
> +	 * bits, hence access SDHCI_CLOCK_CONTROL register as 32-bit register
> +	 */
> +	new_mask |= SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN;
> +	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
> +	sdhci_writel(host, reg | new_mask, SDHCI_CLOCK_CONTROL);
> +
> +	reg = sdhci_readb(host, SDHCI_SOFTWARE_RESET);
> +
> +	ret = read_poll_timeout_atomic(sdhci_readb, reg, !(reg & mask),
> +				       10, 10000, false,
> +				       host, SDHCI_SOFTWARE_RESET);
> +
> +	if (ret) {
> +		pr_err("%s: Reset 0x%x never completed.\n",
> +		       mmc_hostname(host->mmc), (int)mask);
> +		sdhci_err_stats_inc(host, CTRL_TIMEOUT);
> +		sdhci_dumpregs(host);
> +	}
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


