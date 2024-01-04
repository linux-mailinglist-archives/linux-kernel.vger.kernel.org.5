Return-Path: <linux-kernel+bounces-17111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6482486D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72F31F230F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840728E39;
	Thu,  4 Jan 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc5zsG09"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38C28E1C;
	Thu,  4 Jan 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704394349; x=1735930349;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pYej2JV0JxSIfj3YGPhrGCem9gjewaNhV64H8Y3jT9s=;
  b=bc5zsG09Tsfijc5EwlsT2V1JRSiO023Mngf7HuIDgH3pxq0mbDNVEbRG
   WnO0yGofWtFNts54d8x4eUrf0fYsanAzAt+bv4AKmJWK6f9plovAPRpMN
   ZNICb1AjUljZNESQqYjG2VDZs9yi6xv05xPRwcqJoV9fmIvaIZP+qrgSs
   qkECYiyJjw6IWJYb8R1rDbDJREoKN94YADTae4LdyfeOY2IOZseNE8WvZ
   id+pfcywdV9wpP8WPGwJY5B+dtuQyZeih788UhXHEb5wr61fcLy9WgcgU
   Um6/bHGK1juPtZuTbOn1ovJ4aSe7BWDZCzzZ4Q2FUysZYtGwxUUkM8yuh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401120795"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="401120795"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="780504832"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="780504832"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:52:26 -0800
Message-ID: <3287e3d3-595a-404f-b46c-6cf82e955632@intel.com>
Date: Thu, 4 Jan 2024 20:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: xenon: Add ac5 support via bounce buffer
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, huziji@marvell.com,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104173033.2836110-1-enachman@marvell.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240104173033.2836110-1-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/01/24 19:30, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> AC5/X/IM SOCs has a variant of the Xenon eMMC controller,
> in which only 31-bit of addressing pass from the controller
> on the AXI bus.
> Since we cannot guarantee that only buffers from the first 2GB
> of memory will reach the driver, the driver is configured for
> SDMA mode, without 64-bit mode, overriding the DMA mask to 34-bit
> to support the DDR memory mapping, which starts at offset 8GB.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon.c | 31 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 25ba7aecc3be..0e52867f6e91 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -18,6 +18,8 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -422,6 +424,7 @@ static int xenon_probe_params(struct platform_device *pdev)
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 sdhc_id, nr_sdhc;
>  	u32 tuning_count;
> +	struct sysinfo si;
>  
>  	/* Disable HS200 on Armada AP806 */
>  	if (priv->hw_version == XENON_AP806)
> @@ -450,6 +453,23 @@ static int xenon_probe_params(struct platform_device *pdev)
>  	}
>  	priv->tuning_count = tuning_count;
>  
> +	/*
> +	 * AC5/X/IM HW has only 31-bits passed in the crossbar switch.
> +	 * If we have more than 2GB of memory, this means we might pass
> +	 * memory pointers which are above 2GB and which cannot be properly
> +	 * represented. In this case, disable ADMA, 64-bit DMA and allow only SDMA.
> +	 * This effectively will enable bounce buffer quirk in the
> +	 * generic SDHCI driver, which will make sure DMA is only done
> +	 * from supported memory regions:
> +	 */
> +	if (priv->hw_version == XENON_AC5) {
> +		si_meminfo(&si);
> +		if (si.totalram * si.mem_unit > SZ_2G) {
> +			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +			host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
> +		}
> +	}
> +
>  	return xenon_phy_parse_params(dev, host);
>  }
>  
> @@ -562,6 +582,16 @@ static int xenon_probe(struct platform_device *pdev)
>  		goto remove_sdhc;
>  
>  	pm_runtime_put_autosuspend(&pdev->dev);
> +	/*
> +	 * If we previously detected AC5 with over 2GB of memory,
> +	 * then we disable ADMA and 64-bit DMA.
> +	 * This means generic SDHCI driver has set the DMA mask to
> +	 * 32-bit. Since DDR starts at 0x2_0000_0000, we must use
> +	 * 34-bit DMA mask to access this DDR memory:
> +	 */
> +	if (priv->hw_version == XENON_AC5 &&
> +	    host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
> +		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
>  
>  	return 0;
>  
> @@ -680,6 +710,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +	{ .compatible = "marvell,ac5-sdhci",	     .data =  (void *)XENON_AC5},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 3e9c6c908a79..0460d97aad26 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -57,7 +57,8 @@ enum xenon_variant {
>  	XENON_A3700,
>  	XENON_AP806,
>  	XENON_AP807,
> -	XENON_CP110
> +	XENON_CP110,
> +	XENON_AC5
>  };
>  
>  struct xenon_priv {


