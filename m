Return-Path: <linux-kernel+bounces-109982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37488588C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B29A1C21962
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF34E59154;
	Thu, 21 Mar 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI1sRIDd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610D58ACE;
	Thu, 21 Mar 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021595; cv=none; b=OmI1MapN4MyZ3Wv9+5qsBcG1rM57F2aeai0Tn9K8Un8PP/54vQKDAX/WAgfagfPOFr45UtnMTQHT/x5M9VPybTzIawRSDIhuitA7IWzK3QbDR7XsWWM910FLzTHNb0gNbxoi4MijQa0+jpO01ppSGciStAgJjM5DL4NoadWQX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021595; c=relaxed/simple;
	bh=888lv1hY5WL63q1oVRC74LdaqPXZGJQmkKsdDuD3JPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLw8gKM1BcLsme4dIuiE3IEGTpTPnZ5A0u1p/JF5WIlr5aQgQvSIzWoTh9bPSZg6PixuyW3Vm22qJOZLj1PeBQph5tUuMGFPH0JOsjG1yvvjuZpGH4efP913lJ5pVarwOxgs4JITb+V20qXskLU0bgBvFZWvhTOuGm6WlSLZp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI1sRIDd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711021594; x=1742557594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=888lv1hY5WL63q1oVRC74LdaqPXZGJQmkKsdDuD3JPU=;
  b=LI1sRIDdvROE6EMnbWTEQKyk1DRHcjz+Q+ZAgF07I77khAOf2+448+ol
   KLAwBZ3Rup+A9QEiUv3F7o+LSUmiUh3xzSqFb6TVPiOD0uj2e0OJ1xpZD
   wPeyfpU0zO8DuN31yfNDRSZGX1lDzriZm0/J1hgJ80Uf8BAIx+1Tl7rEw
   F03JTHfIQVJh4U9Zb5EbDBBCU91L5TRKFVa+SRf2lbGF3HV4UBFaQJw28
   +r5fH9O+tBgiryd90FyUznwAnDN3CB5gwA//kEfXvH11Sr5g63j6gycnM
   KIPZIc3Cbzh9ZoJ6bb9EQUunya3UPQwXNKTcLteRUkgvd6Q0ntyksKU/Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6128614"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6128614"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19055468"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.210.179])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:46:31 -0700
Message-ID: <22e6ab4c-be8d-44d5-b430-e7282bae34ab@intel.com>
Date: Thu, 21 Mar 2024 13:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] sdhci-of-dwcmshc: disable PM runtime in
 dwcmshc_remove()
To: Liming Sun <limings@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Thompson <davthompson@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/24 18:16, Liming Sun wrote:
> This commit disables PM runtime in dwcmshc_remove() to avoid the
> error message below when reloading the sdhci-of-dwcmshc.ko
> 
>   sdhci-dwcmshc MLNXBF30:00: Unbalanced pm_runtime_enable!
> 
> Fixes: 48fe8fadbe5e ("mmc: sdhci-of-dwcmshc: Add runtime PM operations")
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ab4b964d4058..1d8f5a76096a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -999,6 +999,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
>  static void dwcmshc_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> @@ -1006,8 +1017,14 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *rk_priv = priv->priv;
>  
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
>  	sdhci_remove_host(host, 0);
>  
> +	dwcmshc_disable_card_clk(host);
> +
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
>  	if (rk_priv)
> @@ -1099,17 +1116,6 @@ static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  	}
>  }
>  
> -static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> -{
> -	u16 ctrl;
> -
> -	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> -		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -	}
> -}
> -
>  static int dwcmshc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);


