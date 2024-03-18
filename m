Return-Path: <linux-kernel+bounces-106191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCA87EA88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E641E2816A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857EC4D9F7;
	Mon, 18 Mar 2024 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mof7LKvn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8224D11F;
	Mon, 18 Mar 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770670; cv=none; b=slZKqdNGYnXJPMOINUHhVljJ/G3gemj/Uf/sk8yI3dkmjDz/9S8l3/SSbWRE22c6g4LaunWn6q/86Pph3ZUOUPGS3Y9FpTz1WSks2zbQ1AsQxploJf/7AZtxbOqkKfkfuF0TqDQQMzpmg9aU4bnNJNSm6YVBCrjmNVK8ba5gGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770670; c=relaxed/simple;
	bh=MT+8lBT8cJcpk+YXvh52HjX2o1Sl9MZSarUXgdolC9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F1r3HWBASR2z5S5cg9FM2nbb2SZ0uJ3HW5x9ZR3zXREZNgQDx24uwG9HejKnlNOwkp9Fgx+lsjzTxESBRR4rxFppjG9maSTpY/j4lS139YVq8uDVE1v5+fd6MAgIgW1RT4YmIkwZ4LHM+jfAuMUZOnyAck6WD9rLe7tFyJxS4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mof7LKvn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IE4NJG070166;
	Mon, 18 Mar 2024 09:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710770663;
	bh=gKn3j6OpVrtOVzh71kMc8b65L9lfAR4ky93dJ+Ff/GU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mof7LKvn1YwbKBuli1EKIVLDxkHlVjUkSscK75EoIwheuq+nKEepWJLuHYuzMOAXe
	 7AQziJiZiZU4tB64TRFRw3SYS+sHsMAypUauvXFHcLKGifkDU5VXCDaSkw/Es3BxOY
	 vGEwFGdRHlfk8ZBSQqNdGCOEXPNpnvuL5ZOeL6AM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IE4Nxi116926
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 09:04:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 09:04:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 09:04:22 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IE4MVm128606;
	Mon, 18 Mar 2024 09:04:22 -0500
Message-ID: <8e8edccd-49d4-4157-b92d-8dd0630d52ac@ti.com>
Date: Mon, 18 Mar 2024 09:04:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <20240308005746.1059813-1-jm@ti.com>
 <20240308005746.1059813-2-jm@ti.com>
 <e0ae65bf-9cca-4dd7-9915-dd9ad67cfb35@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <e0ae65bf-9cca-4dd7-9915-dd9ad67cfb35@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 3/14/24 9:18 AM, Adrian Hunter wrote:
> On 8/03/24 02:57, Judith Mendez wrote:
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
> 
> One question further below, and one cosmetic change, but resolve
> those and you may add to all patches in this patch set:

Appreciate your review, thanks.

> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>> Changelog:
>> v2->v3:
>> - Fix return for tuning algorithm
>> - Fix ITAPDLY_LAST_INDEX
>> - Use reverse fir tree order for variable declarations
>> - Remove unnecessary parenthesis
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 112 +++++++++++++++++++++++++++------
>>   1 file changed, 92 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index d659c59422e1..d11b0d769e6c 100644
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
>> @@ -290,10 +297,12 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
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
> 
> V2 patch had here:
> 
> 		sdhci_am654->dll_enable = false;
> 
> Was its removal intended?

I did remove on purpose since it did not seem to be necessary.

> 
>> +	}
>>   
>>   	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>>   			   sdhci_am654->clkbuf_sel);
>> @@ -408,39 +417,102 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>>   	return 0;
>>   }
>>   
>> -#define ITAP_MAX	32
>> +#define ITAPDLY_LENGTH 32
>> +#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
>> +
>> +static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>> +			  *fail_window, u8 num_fails, bool circular_buffer)
>> +{
>> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
>> +	u8 first_fail_start = 0, last_fail_end = 0;
>> +	struct device *dev = mmc_dev(host->mmc);
>> +	struct window pass_window = {0, 0, 0};
>> +	int prev_fail_end = -1;
>> +
> 
> Unnecessary blank line

Will remove for v4.

> 
>> +	u8 i;
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
>> +	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
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
>> +	u8 curr_pass, itap;
>> +	u8 fail_index = 0;
>> +	u8 prev_pass = 1;
>> +
>> +	memset(fail_window, 0, sizeof(fail_window));
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
>> +					  sdhci_am654->dll_enable);
>> +
>>   	sdhci_am654_write_itapdly(sdhci_am654, itap);
>>   
>>   	return 0;
> 


