Return-Path: <linux-kernel+bounces-16539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F7823FE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84301282BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4920420DEF;
	Thu,  4 Jan 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeC8doGE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95620DD6;
	Thu,  4 Jan 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704365447; x=1735901447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=783NzBy3M7MqOSyZDODCfrbGjFcGEzOaO/feDRZVE/Q=;
  b=eeC8doGEZO7YcpTG2X7KyQNSW3vkP4W4tK9JiATGiiaK/cGZtBI+VmYx
   KHEB+3dibRyR4qQQjYaa8GHNS6vAin2m15vpPUAazR8O2cTail/lHfMxu
   IOSFFBdWKr9+4Y6uf7X8JVWiym1PrMhnSg1Fdhsl2hwejqRMUf4UZzfcS
   SJWE5VCZ1i+3yHakXj32YQ9js4WpxMzcD6/7f35rvOFJhL+sqCUeAQTaY
   5nXFtEKBRwAHvLvnSqdCHTF4gNXvYdz/9H0Rs8WbP5Oz+U9XueARmS8cb
   hVYhnQcgFP4ocKJZbtK1VMzpIrV1tE4oLvfIff8mxKVlvQil/RRvcou3T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10775599"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="10775599"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 02:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="28741052"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 02:50:40 -0800
Message-ID: <d3208fee-9784-4dee-994d-ac1f7c526e74@intel.com>
Date: Thu, 4 Jan 2024 12:50:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mmc: xenon: Add ac5 support via bounce buffer
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 huziji@marvell.com, ulf.hansson@linaro.org, catalin.marinas@arm.com,
 will@kernel.org, thunder.leizhen@huawei.com, bhe@redhat.com,
 akpm@linux-foundation.org, yajun.deng@linux.dev, chris.zjh@huawei.com,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cyuval@marvell.com
References: <20231227123257.1170590-1-enachman@marvell.com>
 <20231227123257.1170590-5-enachman@marvell.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231227123257.1170590-5-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/23 14:32, Elad Nachman wrote:
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

One minor comment below otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon.c | 33 ++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 25ba7aecc3be..4d6df1815da1 100644
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
> @@ -562,7 +582,17 @@ static int xenon_probe(struct platform_device *pdev)
>  		goto remove_sdhc;
>  
>  	pm_runtime_put_autosuspend(&pdev->dev);
> -
> +	/*
> +	 * If we previously detected AC5 with over 2GB of memory,
> +	 * then we disable ADMA and 64-bit DMA.
> +	 * This means generic SDHCI driver has set the DMA mask to
> +	 * 32-bit. Since DDR starts at 0x2_0000_0000, we must use
> +	 * 34-bit DMA mask to access this DDR memory:
> +	 */
> +	if (priv->hw_version == XENON_AC5) {
> +		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)

Kernel style is to avoid nested if-statements i.e.

	if (priv->hw_version == XENON_AC5 &&
	    host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));

> +			dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
> +	}
>  	return 0;
>  
>  remove_sdhc:
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


