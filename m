Return-Path: <linux-kernel+bounces-48777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8446184610F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64E41C222BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572058527E;
	Thu,  1 Feb 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oEyiAhnI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEF85622;
	Thu,  1 Feb 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816206; cv=none; b=Pd9GNe0pUN2rf+Ntb7ZXCv0kOlzE9UkE5CCiA+8LvmoiRpSUrIMP+SlMGpHGEuIZOy8XyZk5CGaITn2LNXWOq7a4DRYEb/4hfEXzKUgZLcu1yzf+VRRlZeg20yE/Nixe1ZzWvsqBksQiTCK4xxhT2Eydn8EyKXrY4ev+7sAnOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816206; c=relaxed/simple;
	bh=ankfZc7iRLTEJBMFjGLfV0NhiS117eh39H3c+xq9XJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LI6+zHQf3H/2F7wa5aQxqUfd1oCV019CrnIfnbjEf+IhfUsI/iCHNeZ2Bj2GJCb/pRw5U0FegDxZEY616/X6lpnMYO6Phn47h4CymMCjaUnb74aWW5d0Zl0fMVtW2nG/hnDa28+QfU0ri1EM/6pamDMn/5zxiqEyXOFRpn+J7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oEyiAhnI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411JafP1095297;
	Thu, 1 Feb 2024 13:36:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706816201;
	bh=SQ5y3kDSRpyJYfnU8Ihu5tFQbqlEUZZH5whWOT0PNCo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oEyiAhnI/blup1CgeEc8CeMo8PaNwBJyuuNDliHDdRHlPc+/Dlme18V9nbIjSIrnN
	 3u8vERswqra84+x09ErKOMxV9LVQmixKVyWPXdwiG0JUaNOX6zB1jNuHTLvalP45R5
	 JtoHQPglquudX/fiNwiY/feVVHNogoTowR9OWZjE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Jafxm021261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 13:36:41 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 13:36:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 13:36:41 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411Jae9c113425;
	Thu, 1 Feb 2024 13:36:40 -0600
Message-ID: <54161b26-329c-4faa-b6f7-73fe82efb525@ti.com>
Date: Thu, 1 Feb 2024 13:36:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-3-jm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131215044.3163469-3-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 3:50 PM, Judith Mendez wrote:
> For DDR52 timing, DLL is enabled but tuning is not carried
> out, therefore the ITAPDLY value in PHY CTRL 4 register is
> not correct. Fix this by writing ITAPDLY after enabling DLL.
> 
> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/mmc/host/sdhci_am654.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index a3798c9912f6..ff18a274b6f2 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -170,7 +170,19 @@ struct sdhci_am654_driver_data {
>   #define DLL_CALIB	(1 << 4)
>   };
>   
> -static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
> +static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
> +				      u32 itapdly)

This patch is confusing, looks like you switched the place of these two
functions, but diff is not really liking that. You can mess with
--diff-algorithm and the like to get a more readable patch. But in
this case why switch their spots at all?

Seems to be so you can call sdhci_am654_write_itapdly() from
sdhci_am654_setup_dll() without a forward declaration, instead
why not just call sdhci_am654_write_itapdly() after calling
sdhci_am654_setup_dll() below. That also saves to from having
to pass in `timing` to sdhci_am654_write_itapdly() just to
have it pass it right through to sdhci_am654_setup_dll().

Andrew

> +{
> +	/* Set ITAPCHGWIN before writing to ITAPDLY */
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
> +			   0x1 << ITAPCHGWIN_SHIFT);
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
> +			   itapdly << ITAPDLYSEL_SHIFT);
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
> +}
> +
> +static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock,
> +				  unsigned char timing)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> @@ -236,17 +248,8 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
>   		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
>   		return;
>   	}
> -}
>   
> -static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
> -				      u32 itapdly)
> -{
> -	/* Set ITAPCHGWIN before writing to ITAPDLY */
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
> -			   1 << ITAPCHGWIN_SHIFT);
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
> -			   itapdly << ITAPDLYSEL_SHIFT);
> -	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
> +	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>   }
>   
>   static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
> @@ -298,7 +301,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>   
>   	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
> -		sdhci_am654_setup_dll(host, clock);
> +		sdhci_am654_setup_dll(host, clock, timing);
>   		sdhci_am654->dll_enable = true;
>   	} else {
>   		sdhci_am654_setup_delay_chain(sdhci_am654, timing);

