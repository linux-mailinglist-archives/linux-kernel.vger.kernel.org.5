Return-Path: <linux-kernel+bounces-44014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEFC841C36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802EF1C22C30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C5433BD;
	Tue, 30 Jan 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUaw//+T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C523C689;
	Tue, 30 Jan 2024 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597665; cv=none; b=t3uqxji1ls+JUIGXEZF4lzv98v6gpJ6uS67h0Uzclr9ahlzp/p38iq/NImtiDvDMgAdaNdV+B6HGCMBRxWdrbJ4wHdNktw516yOA8cM6G7GyhbDljkTCe9gn9d0BvzHw7zqdBBi9ollkNsiFeB9mHNScOySCtHXW4+k2De6CluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597665; c=relaxed/simple;
	bh=QNAhnh/68uQzWvdCvNgp/thk2nlNcJE1SEfmw284rGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uTLXmgCFGSY7vn1TStKQ+7UDzWmvWHwkBxWvmR1KenR1bAS26TquYB6098u7dPw61khJlytVnRlL0VY6eT4LpOPj6h7z8MGM/OiUSXia51+qOKk9Bq2iBAwstxUPYv1WRoe2gUhUT17efNd8Wkz7rIG7MJnsUHmzNW247NUoz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUaw//+T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706597663; x=1738133663;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QNAhnh/68uQzWvdCvNgp/thk2nlNcJE1SEfmw284rGc=;
  b=NUaw//+TSdl8qLF+xFGIIbe5ST+pMYFni8zsFGnogT3QD3zSsoFMOzG3
   49yOvVb+VIaM7pYlF3EILiufx3X50s4xuD5We9Y6iiR3zAKqNZpRR5A2w
   G7+AhHsRxNZBGUTjnYnMePkrYffXPpdI/z5xie9oZG3Thz/C4ewWGIa+u
   yz0LxhgcpZyK7IkFfAfBmcMEPF+J4XA3Tghgb+2mtw7OLb8ODycAtPrX6
   8mjH57FirYSjOTMfFHRT0eWBglVMO0uJkKzmlvsGiq95r5Q6OwIdySME/
   iAbU23mUzKOZ9eU+kxCmMuiq3qwFT3oM34g7HvWKgSwo8z9uWCTECQkyj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3062893"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3062893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737678149"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737678149"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.217.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:54:20 -0800
Message-ID: <fdf7a8c3-3137-4090-ba41-a7b84e3a695a@intel.com>
Date: Tue, 30 Jan 2024 08:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci: fix max req size based on spec
To: Shengyu Qu <wiagn233@outlook.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TY3P286MB2611D07641D842BD373FD3A8987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <TY3P286MB2611D07641D842BD373FD3A8987F2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/24 12:01, Shengyu Qu wrote:
> For almost 2 decades, the max allowed requests were limited to 512KB
> because of SDMA's max 512KiB boundary limit.

It is not limited by SDMA.  It is limited by choice.

> 
> ADMA2 and ADMA3 do not have such limit and were effectively made so any
> kind of block count would not impose interrupt and managing stress to the
> host.

The main benefit of ADMA is that it provides scatter/gather and so does
not need a bounce buffer.

> 
> By limiting that to 512KiB, it effectively downgrades these DMA modes to
> SDMA.

Not really.

> 
> Fix that by actually following the spec:
> When ADMA is selected tuning mode is advised. On lesser modes, 4MiB
> transfer is selected as max, so re-tuning if timer trigger or if requested
> by host interrupt, can be done in time. Otherwise, the only limit is the
> variable size of types used. In this implementation, 16MiB is used as
> maximum since tests showed that after that point, there are diminishing
> returns.
> 
> Also 16MiB in worst case scenarios, when card is eMMC and its max speed is
> a generous 350MiB/s, will generate interrupts every 45ms on huge data
> transfers.
> 
> A new `adma_get_req_limit` sdhci host function was also introduced, to let
> vendors override imposed limits by the generic implementation if needed.

Not in this patch?

> 
> For example, on local tests with rigorous CPU/GPU burn-in tests and abrupt
> cut-offs to generate huge temperature changes (upwards/downwards) to the
> card, tested host was fine up to 128MB/s transfers on slow cards that used
> SDR104 bus timing without re-tuning.
> In that case the 4MiB limit was overridden with a more than safe 8MiB
> value.
> 
> In all testing cases and boards, that change brought the following:

"all testing cases and boards" doesn't mean much to anyone else. You
need to be more explicit.

> 
> Depending on bus timing and eMMC/SD specs:
> * Max Read throughput increased by 2-20%
> * Max Write throughput increased by 50-200%
> Depending on CPU frequency and transfer sizes:
> * Reduced mmcqd cpu core usage by 4-50%

The main issue with increasing the request size is that it introduces much
more latency for synchronous reads e.g. a synchronous read may have to wait
for a large write operation.  Generally, that is probably a show-stopper
for unconditionally increasing the maximum request size.

> 
> Above commit message comes from original author whose id is CTCaer, with
> SoB email address ctcaer@gmail.com. I tried to contact with the author 1
> month ago to ask for sending it to mainline or get the authority to submit
> by myself, but I didn't get any reply, so I decided to send this patch by
> myself. Original commit is here[1].

Ok, so it is not your patch and the original author is out of touch.

Is there a particular reason you wanted this patch?

> 
> The author also has a patch[2] applied after this patch, which overrides
> adma size on tegra device from device tree property. But I don't have a
> tegra device to actually test that, so it is not sent, and
> adma_get_req_limit part is not included in this version of patch.

Does that mean you haven't tested this patch yourself at all?

> 
> [1]: https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/fa86ebbd56d30b3b6af26e1d1c3f9c411a47e98e
> [2]: https://github.com/CTCaer/switch-l4t-kernel-4.9/commit/385f9335b9a60ce471ac3291f202b1326212be3e
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  drivers/mmc/host/sdhci.c | 17 ++++++++++++-----
>  drivers/mmc/host/sdhci.h |  4 ++--
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c79f73459915..f546b675c7b9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1081,7 +1081,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
>  	WARN_ON(host->data);
>  
>  	/* Sanity checks */
> -	BUG_ON(data->blksz * data->blocks > 524288);
> +	BUG_ON(data->blksz * data->blocks > host->mmc->max_req_size);
>  	BUG_ON(data->blksz > host->mmc->max_blk_size);
>  	BUG_ON(data->blocks > 65535);
>  
> @@ -4690,11 +4690,18 @@ int sdhci_setup_host(struct sdhci_host *host)
>  
>  	/*
>  	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
> -	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
> -	 * is less anyway.
> +	 * size and by tuning modes on ADMA. On tuning mode 3 16MiB is more than
> +	 * enough to cover big data transfers.
>  	 */
> -	mmc->max_req_size = 524288;
> -
> +	if (host->flags & SDHCI_USE_ADMA) {
> +		if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +			mmc->max_req_size = SZ_4M;
> +		else
> +			mmc->max_req_size = SZ_16M;
> +	} else {
> +		/* On PIO/SDMA use SDMA boundary size (512KiB). */
> +		mmc->max_req_size = SZ_512K;
> +	}
>  	/*
>  	 * Maximum number of segments. Depends on if the hardware
>  	 * can do scatter/gather or not.
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a20864fc0641..98252c427feb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -346,11 +346,11 @@ struct sdhci_adma2_64_desc {
>  #define ADMA2_END		0x2
>  
>  /*
> - * Maximum segments assuming a 512KiB maximum requisition size and a minimum
> + * Maximum segments assuming a 16MiB maximum requisition size and a minimum
>   * 4KiB page size. Note this also allows enough for multiple descriptors in
>   * case of PAGE_SIZE >= 64KiB.
>   */
> -#define SDHCI_MAX_SEGS		128
> +#define SDHCI_MAX_SEGS		4096
>  
>  /* Allow for a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS		2


