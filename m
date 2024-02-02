Return-Path: <linux-kernel+bounces-49635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A127846D31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E4D1F26C33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBFD7A71D;
	Fri,  2 Feb 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewxJLt21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741161682;
	Fri,  2 Feb 2024 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868056; cv=none; b=Gjyag6v34rGPU+rCcb+MNqI9nBx4rgf1jQgrlQveuGhsvO+DeLBZqYiRmOPI+yjXadw8BUqC60fabPh67qG7hwYWI4f9QrQ9BJiLs+GZ6aLGLDC5z12bpZNgjDXN8xVz9YBEae6BbUU5QYGdGYs7EAJPq9TsR49LqLjcOFnKCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868056; c=relaxed/simple;
	bh=V7I2689xpU2dX0rLsg9yxEZw1ZOg5TXlkDJscF+cnWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV4UK82lDBKBOSU/2dgsTwHLEPppQ2CgyYdX8TLendG3WpifgNHqUgFALCCYx5noW52oh4lmnzcXfWmZIUwt2xyvT6wmdlsMbw2x1KHtlO9e52OOSZ7Y+48b7OnIGxX5MK3z+oJLHg0QO6TvwRBj+6WoeOUl+gmzeeHp05ipQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewxJLt21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431BCC43390;
	Fri,  2 Feb 2024 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868055;
	bh=V7I2689xpU2dX0rLsg9yxEZw1ZOg5TXlkDJscF+cnWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ewxJLt21OtwgqH2BOw4HZa9su3fc4MZgi/Bujdi3RIUt4EJs44sA6/F8QN+eMc8qZ
	 bfFL1KhnQ3aEXbTwUIZkVvdZsJofgQTlSFQJ0VdcBzA1nPuJC0cj0aen3yNDnvRVgN
	 aTUtli/lT5rm7zBWmEPYRRe82Q5L9aVY68yaetpgZVJgWMqE492jFJo6aT5Tgsu8xZ
	 vyQdHfmAJLuxQ0AG/cT9hGLk5CWdCgwtGW38atgLY7sAbLLCcOsh+gVsJMYSg/M/bM
	 Mx2ALUsJO6m54cdOwv44j9Q6IU4SnQNAhhPp1svKgZ3LLUUD0nNFXsJqA+0N5nwif0
	 OUdb3xuvOEJ5g==
Message-ID: <52dd4327-2abb-4ff2-982d-8b02e381a34b@kernel.org>
Date: Fri, 2 Feb 2024 12:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/13] drivers: mmc: host: sdhci_am654: Add tuning
 algorithm for delay chain
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, devicetree@vger.kernel.org,
 Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <20240131003714.2779593-2-jm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240131003714.2779593-2-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/01/2024 02:37, Judith Mendez wrote:
> Currently the sdhci_am654 driver only supports one tuning
> algorithm which should be used only when DLL is enabled. The

What does DLL stand for?

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
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 128 +++++++++++++++++++++++++++------
>  1 file changed, 108 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index d659c59422e1..59d205511312 100644
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
> @@ -408,39 +418,117 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> -#define ITAP_MAX	32
> +#define ITAPDLY_LENGTH 32
> +#define ITAPDLY_LAST_INDEX 31
> +static u32 calculate_itap(struct sdhci_host *host, struct window *fail_window,
> +			  u8 num_fails, bool circular_buffer)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct window pass_window, first_fail, last_fail;
> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
> +	int prev_end_fail = -1;
> +
> +	memset(&pass_window, 0, sizeof(pass_window));
> +	memset(&first_fail, 0, sizeof(first_fail));
> +	memset(&last_fail, 0, sizeof(last_fail));
> +
> +	if (!num_fails) {
> +		return ITAPDLY_LAST_INDEX >> 1;
> +	} else if (fail_window->length == ITAPDLY_LENGTH) {
> +		dev_warn(dev, "No passing ITAPDLY, return 0\n");

This is a helper function, instead of printing a warning here,
you should return an error value, and allow the caller to decide
what to print and if this is serious enough to bail out.

> +		return 0;
> +	} else {
> +		for (int i = 0; i < num_fails; i++) {
> +			start_fail = fail_window[i].start;
> +			end_fail = fail_window[i].end;
> +
> +			if (i == 0) {
> +				first_fail.start = start_fail;
> +				first_fail.end = end_fail;
> +				first_fail.length = fail_window[0].length;
> +			}
> +
> +			if (i == num_fails - 1) {
> +				last_fail.start = start_fail;
> +				last_fail.end = end_fail;
> +				last_fail.length = fail_window[i].length;
> +			}
> +
> +			pass_length = start_fail - (prev_end_fail + 1);
> +			if (pass_length > pass_window.length) {
> +				pass_window.start = prev_end_fail + 1;
> +				pass_window.length = pass_length;
> +			}
> +			prev_end_fail = end_fail;
> +		}
> +
> +		if (!circular_buffer) {
> +			if (ITAPDLY_LAST_INDEX - end_fail > pass_window.length) {
> +				pass_window.start = end_fail + 1;
> +				pass_window.length = ITAPDLY_LAST_INDEX - end_fail;
> +			}
> +		} else {
> +			pass_length = ITAPDLY_LAST_INDEX - end_fail + first_fail.start;
> +			if (pass_length > pass_window.length) {
> +				pass_window.start = last_fail.end + 1;
> +				pass_window.length = pass_length;
> +			}
> +		}
> +	}
> +
> +	if (!circular_buffer)
> +		itap = pass_window.start + (pass_window.length >> 1);
> +	else
> +		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
> +
> +	if (itap < 0 || itap > ITAPDLY_LAST_INDEX)
> +		itap = 0;
> +
> +	return itap;
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
> +	u8 curr_pass, itap, i;
> +
> +	for (i = 0; i < ITAPDLY_LENGTH; i++)
> +		memset(&fail_window[i], 0, sizeof(fail_window[0]));
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
> +        fail_index++;
> +
> +	itap = calculate_itap(host, &fail_window[0], fail_index,
> +			      (sdhci_am654->dll_enable ? true : false));
> +

If calculate_itap fails, you should return error
so caller can decide what to do.

>  	sdhci_am654_write_itapdly(sdhci_am654, itap);
>  
>  	return 0;

-- 
cheers,
-roger

