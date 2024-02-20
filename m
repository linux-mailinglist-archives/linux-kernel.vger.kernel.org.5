Return-Path: <linux-kernel+bounces-73655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C685C58A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B121C216EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCC14A4F3;
	Tue, 20 Feb 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="odbfd4WT"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94A612D7;
	Tue, 20 Feb 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459825; cv=none; b=IsvdXtBl90f2RhhTPAcaCcEJh2s57VmNf/gmBck2MSsEP6RauEX8DRI58HGMflC6Lt/zWHLnC/VkrNBk6UNk7j1+uFUgkE+0mJa+KLcYJWa3Ybx9+DK1Lw3pa6/h3RVRk4MmYWoL/I4VYxdD4FGTmCpoqsWSb7AUexlui+a/NsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459825; c=relaxed/simple;
	bh=82hADZ69rDVQrmz2v0zCiy9YALtueYMfYJUsNJiyxrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=se3QlkMjbbA4xE20neD6ZvF+TCpPVxC/l8cCZ1XqotQ9KHsURzP5+b6vZxuEGx7ERzRGwjwli3mimU4rSU142myoi1q9MBchzTSImjprZOo3yG5ogbmuGZp55oFZnMBRLgap7o182dUtok1Z9wJ/T7nsHXGCzlfKUSf5clXqLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=odbfd4WT; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KKAKwY017299;
	Tue, 20 Feb 2024 14:10:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708459820;
	bh=PyaEXo2w6LqcxYEv85/7IAjkk4HAnHBvW68xyfp3lWA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=odbfd4WT+c+ImOyDtxGnjVR1BT2UM6zYlDxmO9FeQqSTWAbP18JKc7T4ar9XYBuR6
	 iatBi8lfeDs2q3iL90OqaJu2TXOuT0HpDTqO+ZMFcrrpd8RBoBfBKSYpZDNNfjJUqL
	 jJYmmY4hz1JEkn+5wwo8HnZjOctFU/mlOAPq/8+Q=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KKAK3c000865
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 14:10:20 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 14:10:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 14:10:20 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KKAKr6116253;
	Tue, 20 Feb 2024 14:10:20 -0600
Message-ID: <6d939482-9a3a-4923-b74b-ceb31b0ba7e9@ti.com>
Date: Tue, 20 Feb 2024 14:10:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-2-jm@ti.com>
 <461a19cd-36ce-4c34-890e-655a05a81c58@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <461a19cd-36ce-4c34-890e-655a05a81c58@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Hi Adrian,

On 2/16/24 11:09 AM, Adrian Hunter wrote:
> On 7/02/24 03:15, Judith Mendez wrote:
>> Currently the sdhci_am654 driver only supports one tuning
>> algorithm which should be used only when DLL is enabled. The
>> ITAPDLY is selected from the largest passing window and the
>> buffer is viewed as a circular buffer.
>>
>> The new algorithm should be used when the delay chain
>> is enabled. The ITAPDLY is selected from the largest passing
>> window and the buffer is not viewed as a circular buffer.
>>
>> This implementation is based off of the following paper: [1].
>>
>> Also add support for multiple failing windows.
>>
>> [1] https://www.ti.com/lit/an/spract9/spract9.pdf
>>
>> Fixes: 13ebeae68ac9 ("mmc: sdhci_am654: Add support for software tuning")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changelog:
>> v1->v2:
>> - Remove unnecessary indentations and if/else in
>>   sdhci_am654_calculate_itap()
>> - Optimize sdhci_am654_calculate_itap()
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 111 +++++++++++++++++++++++++++------
>>   1 file changed, 91 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index d659c59422e1..2c66a965c225 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -149,10 +149,17 @@ struct sdhci_am654_data {
>>   	int strb_sel;
>>   	u32 flags;
>>   	u32 quirks;
>> +	bool dll_enable;
>>   
>>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>   };
>>   
>> +struct window {
>> +	u8 start;
>> +	u8 end;
>> +	u8 length;
>> +};
>> +
>>   struct sdhci_am654_driver_data {
>>   	const struct sdhci_pltfm_data *pdata;
>>   	u32 flags;
>> @@ -290,10 +297,13 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>   
>>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>   
>> -	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
>> +	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>   		sdhci_am654_setup_dll(host, clock);
>> -	else
>> +		sdhci_am654->dll_enable = true;
>> +	} else {
>>   		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
>> +		sdhci_am654->dll_enable = false;
>> +	}
>>   
>>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>>   			   sdhci_am654->clkbuf_sel);
>> @@ -408,39 +418,100 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>>   	return 0;
>>   }
>>   
>> -#define ITAP_MAX	32
>> +#define ITAPDLY_LENGTH 32
>> +#define ITAPDLY_LAST_INDEX 31
> 
> Presumably ITAPDLY_LAST_INDEX == ITAPDLY_LENGTH - 1, so perhaps:
> 
> #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
> 
> Blank line here perhaps.

This does seem easier to read, will add for v3.

> 
>> +static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>> +			  *fail_window, u8 num_fails, bool circular_buffer)
>> +{
>> +	struct device *dev = mmc_dev(host->mmc);
>> +	struct window pass_window = {0, 0, 0};
>> +	u8 first_fail_start = 0, last_fail_end = 0;
>> +	int prev_fail_end = -1;
>> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
>> +	u8 i;
> 
> Some prefer ordering of variable declarations at the beginning of a
> function to be "reverse fir tree" order, in other words, longer lines
> first, e.g.
> 
> 	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
> 	u8 first_fail_start = 0, last_fail_end = 0;
> 	struct device *dev = mmc_dev(host->mmc);
> 	struct window pass_window = {0, 0, 0};
> 	int prev_fail_end = -1;
> 	u8 i;

Understood, will add for v3.


> 
>> +
>> +	if (!num_fails)
>> +		return ITAPDLY_LAST_INDEX >> 1;
>> +
>> +	if (fail_window->length == ITAPDLY_LENGTH) {
>> +		dev_err(dev, "No passing ITAPDLY, return 0\n");
>> +		return 0;
>> +	}
>> +
>> +	first_fail_start = fail_window->start;
>> +	last_fail_end = fail_window[num_fails - 1].end;
>> +
>> +	for (i = 0; i < num_fails; i++) {
>> +		start_fail = fail_window[i].start;
>> +		end_fail = fail_window[i].end;
>> +		pass_length = start_fail - (prev_fail_end + 1);
>> +
>> +		if (pass_length > pass_window.length) {
>> +			pass_window.start = prev_fail_end + 1;
>> +			pass_window.length = pass_length;
>> +		}
>> +		prev_fail_end = end_fail;
>> +	}
>> +
>> +	if (!circular_buffer)
>> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
>> +	else
>> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
>> +
>> +	if (pass_length > pass_window.length) {
>> +		pass_window.start = last_fail_end + 1;
>> +		pass_window.length = pass_length;
>> +	}
>> +
>> +	if (!circular_buffer)
>> +		itap = pass_window.start + (pass_window.length >> 1);
>> +	else
>> +		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
>> +
>> +	return (itap < 0 || itap > ITAPDLY_LAST_INDEX ? 0 : itap);
> 
> Parentheses are not needed where they are but putting
> them around the condition would make it more readable e.g.
> 
> 	return (itap < 0 || itap > ITAPDLY_LAST_INDEX) ? 0 : itap;
> 
> However (itap < 0) is not possible because itap is an unsigned type
> and if (itap > ITAPDLY_LAST_INDEX) then maybe it would be better
> to return ITAPDLY_LAST_INDEX

You are right about itap < 0, thanks will fix.

About itap > ITAPDLY_LAST_INDEX, this is an error. Why
return ITAPDLY_LAST_INDEX instead of 0?


> 
>> +}
>> +
>>   static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>   					       u32 opcode)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> -	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
>> -	u32 itap;
>> +	struct window fail_window[ITAPDLY_LENGTH];
>> +	u8 prev_pass = 1;
>> +	u8 fail_index = 0;
>> +	u8 curr_pass, itap;
> 
> Perhaps reverse fir tree

Will add fix here as well.

> 
>> +
>> +	memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);
> 
> This can be:
> 
> 	memset(fail_window, 0, sizeof(fail_window));

This does look simpler, will add for v3.

> 
>>   
>>   	/* Enable ITAPDLY */
>>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
>>   			   1 << ITAPDLYENA_SHIFT);
>>   
>> -	for (itap = 0; itap < ITAP_MAX; itap++) {
>> +	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>>   		sdhci_am654_write_itapdly(sdhci_am654, itap);
>>   
>> -		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
>> -		if (cur_val && !prev_val)
>> -			pass_window = itap;
>> +		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
>>   
>> -		if (!cur_val)
>> -			fail_len++;
>> +		if (!curr_pass && prev_pass)
>> +			fail_window[fail_index].start = itap;
>>   
>> -		prev_val = cur_val;
>> +		if (!curr_pass) {
>> +			fail_window[fail_index].end = itap;
>> +			fail_window[fail_index].length++;
>> +		}
>> +
>> +		if (curr_pass && !prev_pass)
>> +			fail_index++;
>> +
>> +		prev_pass = curr_pass;
>>   	}
>> -	/*
>> -	 * Having determined the length of the failing window and start of
>> -	 * the passing window calculate the length of the passing window and
>> -	 * set the final value halfway through it considering the range as a
>> -	 * circular buffer
>> -	 */
>> -	pass_len = ITAP_MAX - fail_len;
>> -	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
>> +
>> +	if (fail_window[fail_index].length != 0)
>> +		fail_index++;
>> +
>> +	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>> +					  (sdhci_am654->dll_enable));
> 
> Parentheses around sdhci_am654->dll_enable are not needed.

Agree, I can remove for v3.

> 
>> +
>>   	sdhci_am654_write_itapdly(sdhci_am654, itap);
>>   
>>   	return 0;
> 


My apologies for the late reply and thanks for reviewing.

~ Judith

