Return-Path: <linux-kernel+bounces-69031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EAE858393
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B721C2312D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A3130E44;
	Fri, 16 Feb 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNYLwFN7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07602E641;
	Fri, 16 Feb 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103383; cv=none; b=Tbrfua0f+ryuuslT1cxdZvRHuDlKYiTbLnKS45AuhklAO+CGuj8C8g8OuniNT4eh6y8Qfq3q/EVlRDxgiXcHRpiX+AvZZ/zEAoEOxhJQFR29T/SpQSINd3nDgSL2XsE2yJ9A6S5WLLAvNwnZCCA7tYhSgUWNHQlmAyGylPGGY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103383; c=relaxed/simple;
	bh=cepp9LRH1Dl69gX9yqoup/f4c1VayRn76uLX1TsKbHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yyv5/jf+2YQU8D7Ysu63LyR0B9nMsRp+mqDpQVFy8/nkifT1sUH+dV/0Vb8LwjsOwkkBUfCyiJNYc1FW2UiIi61ClQBz94OWcVMoyNLZVsCLfwC6tIQsJtBnPzBOjwGy4WcfbQT3ggLhrkrzMFZJ+xr0HM/Mt1OdeRHXXUUO2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNYLwFN7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708103381; x=1739639381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cepp9LRH1Dl69gX9yqoup/f4c1VayRn76uLX1TsKbHk=;
  b=lNYLwFN7jGsoqfo3Cue7q9S/HuWOKJ+zJzI578dKT24sdA9aLFnVH/hX
   okuzFlqVKhs4dt6LfY2O/Jyd5F2muV9sLQoZOO0o8VgZKjyuCaqBuxBXM
   +EVBcsdY/Vhl6GcRTuHuqZU/VFCCCPhARAgoGFl2CMDsx/62vHxJWxRGX
   hM4otOof/VYV5CBeLBRWjIJhDveyRoz3Utf6dEOcPzpE3nimefyQHaO2V
   DUN0jODmtEk/s+056EAGJUL5lZz3L89mYEQl098YSWE27Tub0s3vqAUlD
   B1fdBRHHjrfC72kjM40st+R3n23dYIfx3fXBvly02aA6JTLmPvV5IOW2L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6065356"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6065356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8578404"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.220.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:09:28 -0800
Message-ID: <461a19cd-36ce-4c34-890e-655a05a81c58@intel.com>
Date: Fri, 16 Feb 2024 19:09:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-2-jm@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240207011520.3128382-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/02/24 03:15, Judith Mendez wrote:
> Currently the sdhci_am654 driver only supports one tuning
> algorithm which should be used only when DLL is enabled. The
> ITAPDLY is selected from the largest passing window and the
> buffer is viewed as a circular buffer.
> 
> The new algorithm should be used when the delay chain
> is enabled. The ITAPDLY is selected from the largest passing
> window and the buffer is not viewed as a circular buffer.
> 
> This implementation is based off of the following paper: [1].
> 
> Also add support for multiple failing windows.
> 
> [1] https://www.ti.com/lit/an/spract9/spract9.pdf
> 
> Fixes: 13ebeae68ac9 ("mmc: sdhci_am654: Add support for software tuning")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changelog:
> v1->v2:
> - Remove unnecessary indentations and if/else in
>  sdhci_am654_calculate_itap()
> - Optimize sdhci_am654_calculate_itap()
> ---
>  drivers/mmc/host/sdhci_am654.c | 111 +++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index d659c59422e1..2c66a965c225 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -149,10 +149,17 @@ struct sdhci_am654_data {
>  	int strb_sel;
>  	u32 flags;
>  	u32 quirks;
> +	bool dll_enable;
>  
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>  };
>  
> +struct window {
> +	u8 start;
> +	u8 end;
> +	u8 length;
> +};
> +
>  struct sdhci_am654_driver_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 flags;
> @@ -290,10 +297,13 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>  
> -	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
> +	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>  		sdhci_am654_setup_dll(host, clock);
> -	else
> +		sdhci_am654->dll_enable = true;
> +	} else {
>  		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
> +		sdhci_am654->dll_enable = false;
> +	}
>  
>  	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>  			   sdhci_am654->clkbuf_sel);
> @@ -408,39 +418,100 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> -#define ITAP_MAX	32
> +#define ITAPDLY_LENGTH 32
> +#define ITAPDLY_LAST_INDEX 31

Presumably ITAPDLY_LAST_INDEX == ITAPDLY_LENGTH - 1, so perhaps:

#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)

Blank line here perhaps.

> +static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
> +			  *fail_window, u8 num_fails, bool circular_buffer)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct window pass_window = {0, 0, 0};
> +	u8 first_fail_start = 0, last_fail_end = 0;
> +	int prev_fail_end = -1;
> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
> +	u8 i;

Some prefer ordering of variable declarations at the beginning of a
function to be "reverse fir tree" order, in other words, longer lines
first, e.g.

	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
	u8 first_fail_start = 0, last_fail_end = 0;
	struct device *dev = mmc_dev(host->mmc);
	struct window pass_window = {0, 0, 0};
	int prev_fail_end = -1;
	u8 i;

> +
> +	if (!num_fails)
> +		return ITAPDLY_LAST_INDEX >> 1;
> +
> +	if (fail_window->length == ITAPDLY_LENGTH) {
> +		dev_err(dev, "No passing ITAPDLY, return 0\n");
> +		return 0;
> +	}
> +
> +	first_fail_start = fail_window->start;
> +	last_fail_end = fail_window[num_fails - 1].end;
> +
> +	for (i = 0; i < num_fails; i++) {
> +		start_fail = fail_window[i].start;
> +		end_fail = fail_window[i].end;
> +		pass_length = start_fail - (prev_fail_end + 1);
> +
> +		if (pass_length > pass_window.length) {
> +			pass_window.start = prev_fail_end + 1;
> +			pass_window.length = pass_length;
> +		}
> +		prev_fail_end = end_fail;
> +	}
> +
> +	if (!circular_buffer)
> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
> +	else
> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
> +
> +	if (pass_length > pass_window.length) {
> +		pass_window.start = last_fail_end + 1;
> +		pass_window.length = pass_length;
> +	}
> +
> +	if (!circular_buffer)
> +		itap = pass_window.start + (pass_window.length >> 1);
> +	else
> +		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
> +
> +	return (itap < 0 || itap > ITAPDLY_LAST_INDEX ? 0 : itap);

Parentheses are not needed where they are but putting
them around the condition would make it more readable e.g.

	return (itap < 0 || itap > ITAPDLY_LAST_INDEX) ? 0 : itap;

However (itap < 0) is not possible because itap is an unsigned type
and if (itap > ITAPDLY_LAST_INDEX) then maybe it would be better
to return ITAPDLY_LAST_INDEX

> +}
> +
>  static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>  					       u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
> -	u32 itap;
> +	struct window fail_window[ITAPDLY_LENGTH];
> +	u8 prev_pass = 1;
> +	u8 fail_index = 0;
> +	u8 curr_pass, itap;

Perhaps reverse fir tree

> +
> +	memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);

This can be:

	memset(fail_window, 0, sizeof(fail_window));

>  
>  	/* Enable ITAPDLY */
>  	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
>  			   1 << ITAPDLYENA_SHIFT);
>  
> -	for (itap = 0; itap < ITAP_MAX; itap++) {
> +	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>  		sdhci_am654_write_itapdly(sdhci_am654, itap);
>  
> -		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
> -		if (cur_val && !prev_val)
> -			pass_window = itap;
> +		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
>  
> -		if (!cur_val)
> -			fail_len++;
> +		if (!curr_pass && prev_pass)
> +			fail_window[fail_index].start = itap;
>  
> -		prev_val = cur_val;
> +		if (!curr_pass) {
> +			fail_window[fail_index].end = itap;
> +			fail_window[fail_index].length++;
> +		}
> +
> +		if (curr_pass && !prev_pass)
> +			fail_index++;
> +
> +		prev_pass = curr_pass;
>  	}
> -	/*
> -	 * Having determined the length of the failing window and start of
> -	 * the passing window calculate the length of the passing window and
> -	 * set the final value halfway through it considering the range as a
> -	 * circular buffer
> -	 */
> -	pass_len = ITAP_MAX - fail_len;
> -	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
> +
> +	if (fail_window[fail_index].length != 0)
> +		fail_index++;
> +
> +	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
> +					  (sdhci_am654->dll_enable));

Parentheses around sdhci_am654->dll_enable are not needed.

> +
>  	sdhci_am654_write_itapdly(sdhci_am654, itap);
>  
>  	return 0;


