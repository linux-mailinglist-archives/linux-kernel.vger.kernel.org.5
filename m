Return-Path: <linux-kernel+bounces-103376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFE87BEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870FFB217DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB366FE22;
	Thu, 14 Mar 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkfJm3tY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99B6FE1E;
	Thu, 14 Mar 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425892; cv=none; b=joa2tYY2k22EKz+ZVYTavL1HcIVkRiAghy7HQG5iK5CsTB2XbSHbRYjSmUKpCP6EPDuRMIkvWpNPKM8GKnxX4TKFvGkAcLGJ27wK0897cuVvgRaS7EUjX4fYCRrRw8zEKmdgo4j3kO4IfaxAGtcTbifoNbtuz45/aMZbby4bp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425892; c=relaxed/simple;
	bh=OTkP1n3C9jAyH61FpbIq2rfeXyZpSbVstp1ZWMRVwtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtMSG9re8jcpBIHK0Ei9UpYCNbIwEGEAKLTlaF49AXeJ//zjFGKhfXc3zUfRgW7BXcTfbSNLJiJgkWijhzB0m/ozYs9ssG0L6ziXyX3CJJW/IIuACm98OHSN+1MrNx0QKpVdpWQR877jlh+ZhaHfY0g/vSNHl+Jfyim0+DadgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkfJm3tY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710425890; x=1741961890;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OTkP1n3C9jAyH61FpbIq2rfeXyZpSbVstp1ZWMRVwtc=;
  b=bkfJm3tYH3mvOdHeSMRlxNwN2lejAv07kBJG79H4f7MTLtg0T+29oKoj
   3rNjHZGMgYjOp9YLISndYIoMgmTXFsGTVIA0/3HyCfGAepVqcY3Yxw6wk
   ECP0Y0Yf5czmKqBo+3F8C/pxNbScWQvmU/XADIu5iAkROM9lKs5OYjx0m
   v6/BVaXJxyBc7m1rfNTVAAIsPdDN825t7ya1/GrNkjDNb1n0SfcDfDy1T
   eXSiUpEDyUyLn8QreZ9Z2uSLALSubZ2Rdx9CvyZlBaX/SUy5/oFF+whs4
   TudiosNWgVSo2oam2L13UPwBwbszHE+fjNp5v92OdL6nvT0EBrHrAUWyK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5102494"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5102494"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 07:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="43224022"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.237])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 07:18:07 -0700
Message-ID: <e0ae65bf-9cca-4dd7-9915-dd9ad67cfb35@intel.com>
Date: Thu, 14 Mar 2024 16:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: Andrew Davis <afd@ti.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20240308005746.1059813-1-jm@ti.com>
 <20240308005746.1059813-2-jm@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240308005746.1059813-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/03/24 02:57, Judith Mendez wrote:
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

One question further below, and one cosmetic change, but resolve
those and you may add to all patches in this patch set:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v2->v3:
> - Fix return for tuning algorithm
> - Fix ITAPDLY_LAST_INDEX
> - Use reverse fir tree order for variable declarations
> - Remove unnecessary parenthesis
> ---
>  drivers/mmc/host/sdhci_am654.c | 112 +++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index d659c59422e1..d11b0d769e6c 100644
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
> @@ -290,10 +297,12 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
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

V2 patch had here:

		sdhci_am654->dll_enable = false;

Was its removal intended?

> +	}
>  
>  	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>  			   sdhci_am654->clkbuf_sel);
> @@ -408,39 +417,102 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> -#define ITAP_MAX	32
> +#define ITAPDLY_LENGTH 32
> +#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
> +
> +static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
> +			  *fail_window, u8 num_fails, bool circular_buffer)
> +{
> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
> +	u8 first_fail_start = 0, last_fail_end = 0;
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct window pass_window = {0, 0, 0};
> +	int prev_fail_end = -1;
> +

Unnecessary blank line

> +	u8 i;
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
> +	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
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
> +	u8 curr_pass, itap;
> +	u8 fail_index = 0;
> +	u8 prev_pass = 1;
> +
> +	memset(fail_window, 0, sizeof(fail_window));
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
> +					  sdhci_am654->dll_enable);
> +
>  	sdhci_am654_write_itapdly(sdhci_am654, itap);
>  
>  	return 0;


