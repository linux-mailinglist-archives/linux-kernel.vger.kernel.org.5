Return-Path: <linux-kernel+bounces-55661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF2484BFA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6366B1C23434
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD41BC40;
	Tue,  6 Feb 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IEkywauR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DED1B949;
	Tue,  6 Feb 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256834; cv=none; b=fNJPumJwcMTDUekuLgew0YvAFF//uOcJxTzCvJ5DzHx2QpUZd/cd1O4goQRsuZLP+w1UAkp3/QGZr9P/nP+30yQ96OF8T9hmRpo3riutsljF9gGhlkMOiF1nshVG+fsEosqgfe6Ocy2SvZk5kDS8pZ5oDjNTfbFcWcZ9vF6rVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256834; c=relaxed/simple;
	bh=AFCw0rJom84GqaFUtUA9Dz/wYNOn/LgRC/3cuFIm9rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E0fxvjUKfC6n7QoVH+SqY3lSwnkpl7bfyhOOUF23FDCgwrtYQoSRC1dqHpiaR1ns6JJmcDk4T/PWHwLpwTkeS89BE+mio+O7kbgu0ZRdvvfzD208CH+8JQoFGwrH2Xz2UkONFo0viP1UDn7JEbZCljXKz8odOpEMxRLlWiqUFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IEkywauR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416M0TOe008499;
	Tue, 6 Feb 2024 16:00:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707256829;
	bh=VsKXe09fNmoCm90qcz7OEFgH2ZmEG2Sx4NvQW2ASYeo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IEkywauROl6b904CM7Fbh1oGskUHdgBHYyHeMeuBoMXZB/OwAXL0PCwnu0Nf6Vq/v
	 6C9LSTRtHfDd12tmN+oBS7ZlZrk09sdwbS+3oWiJLJxIn1I7dd0GXlUsAwGmpdRU+0
	 LiP+kmrffXPY69Fx1EXXNKhJSi4yDYIMjaWIqSwM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416M0Sqn028907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 16:00:28 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 16:00:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 16:00:28 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416M0Sbl001537;
	Tue, 6 Feb 2024 16:00:28 -0600
Message-ID: <51b94d6a-b5e6-428e-81fb-3c21f7fa3d0a@ti.com>
Date: Tue, 6 Feb 2024 16:00:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] mmc: sdhci_am654: Add missing OTAP/ITAP enable
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-4-jm@ti.com>
 <8cb4d505-77b7-4f63-91b4-f9f8a71df17d@ti.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <8cb4d505-77b7-4f63-91b4-f9f8a71df17d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 2/1/24 1:46 PM, Andrew Davis wrote:
> On 1/31/24 3:50 PM, Judith Mendez wrote:
>> Currently the OTAP/ITAP delay enable functionality is missing in
>> the am654_set_clock function which is used for MMC0 on AM62p
>> and AM64x devices. The OTAP delay is not enabled when timing <
>> SDR25 bus speed mode. The ITAP delay is not enabled for all bus
>> speed modes.
>>
>> Add this OTAP/ITAP delay functionality according to the datasheet
>> [1] OTAPDLYENA and ITAPDLYENA for MMC0.
>>
>> [1] https://www.ti.com/lit/ds/symlink/am62p.pdf
>>
>> Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 48 +++++++++++++++++++---------------
>>   1 file changed, 27 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c 
>> b/drivers/mmc/host/sdhci_am654.c
>> index ff18a274b6f2..5ac82bc70706 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -143,6 +143,7 @@ struct sdhci_am654_data {
>>       struct regmap *base;
>>       int otap_del_sel[ARRAY_SIZE(td)];
>>       int itap_del_sel[ARRAY_SIZE(td)];
>> +    u8 itap_del_ena[ARRAY_SIZE(td)];
> 
> Why u8? Seems this is always manipulated as a u32. In fact
> the same is true for `otap_del_sel` and `itap_del_sel` above.
> Those needed fixed also.

Sure, I can fix for v2.

> 
>>       int clkbuf_sel;
>>       int trm_icp;
>>       int drv_strength;
>> @@ -171,11 +172,13 @@ struct sdhci_am654_driver_data {
>>   };
>>   static void sdhci_am654_write_itapdly(struct sdhci_am654_data 
>> *sdhci_am654,
>> -                      u32 itapdly)
>> +                      u32 itapdly, u32 enable)
>>   {
>>       /* Set ITAPCHGWIN before writing to ITAPDLY */
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>>                  0x1 << ITAPCHGWIN_SHIFT);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
>> +               enable << ITAPDLYENA_SHIFT);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
>>                  itapdly << ITAPDLYSEL_SHIFT);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, 
>> ITAPCHGWIN_MASK, 0);
>> @@ -249,7 +252,8 @@ static void sdhci_am654_setup_dll(struct 
>> sdhci_host *host, unsigned int clock,
>>           return;
>>       }
>> -    sdhci_am654_write_itapdly(sdhci_am654, 
>> sdhci_am654->itap_del_sel[timing]);
>> +    sdhci_am654_write_itapdly(sdhci_am654, 
>> sdhci_am654->itap_del_sel[timing],
>> +                  sdhci_am654->itap_del_ena[timing]);
>>   }
>>   static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data 
>> *sdhci_am654,
>> @@ -263,8 +267,8 @@ static void sdhci_am654_setup_delay_chain(struct 
>> sdhci_am654_data *sdhci_am654,
>>       mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
>> -    sdhci_am654_write_itapdly(sdhci_am654,
>> -                  sdhci_am654->itap_del_sel[timing]);
>> +    sdhci_am654_write_itapdly(sdhci_am654, 
>> sdhci_am654->itap_del_sel[timing],
>> +                  sdhci_am654->itap_del_ena[timing]);
>>   }
>>   static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned 
>> int clock)
>> @@ -273,20 +277,17 @@ static void sdhci_am654_set_clock(struct 
>> sdhci_host *host, unsigned int clock)
>>       struct sdhci_am654_data *sdhci_am654 = 
>> sdhci_pltfm_priv(pltfm_host);
>>       unsigned char timing = host->mmc->ios.timing;
>>       u32 otap_del_sel;
>> -    u32 otap_del_ena;
>>       u32 mask, val;
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
>>       sdhci_set_clock(host, clock);
>> -    /* Setup DLL Output TAP delay */
>> +    /* Setup Output TAP delay */
>>       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>> -    otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
>>       mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>> -    val = (otap_del_ena << OTAPDLYENA_SHIFT) |
>> -          (otap_del_sel << OTAPDLYSEL_SHIFT);
>> +    val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << 
>> OTAPDLYSEL_SHIFT);
>>       /* Write to STRBSEL for HS400 speed mode */
>>       if (timing == MMC_TIMING_MMC_HS400) {
>> @@ -319,14 +320,20 @@ static void sdhci_j721e_4bit_set_clock(struct 
>> sdhci_host *host,
>>       struct sdhci_am654_data *sdhci_am654 = 
>> sdhci_pltfm_priv(pltfm_host);
>>       unsigned char timing = host->mmc->ios.timing;
>>       u32 otap_del_sel;
>> +    u32 itap_del_ena;
>>       u32 mask, val;
>> -    /* Setup DLL Output TAP delay */
>> +    /* Setup Output TAP delay */
>>       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>>       mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>> -    val = (0x1 << OTAPDLYENA_SHIFT) |
>> -          (otap_del_sel << OTAPDLYSEL_SHIFT);
>> +    val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << 
>> OTAPDLYSEL_SHIFT);
> 
> You are not changing anything in this line, so why reformat it? If
> you want to do some reformatting put it in a separate patch. And in
> this case, I like it better how it was.

Ok, I thought it was easier to read, but I can revert for v2.

~ judith

> 
> Andrew
> 
>> +
>> +    itap_del_ena = sdhci_am654->itap_del_ena[timing];
>> +
>> +    mask |= ITAPDLYENA_MASK;
>> +    val |= (itap_del_ena << ITAPDLYENA_SHIFT);
>> +
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>> @@ -503,12 +510,8 @@ static int 
>> sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>       memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);
>> -    /* Enable ITAPDLY */
>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
>> -               1 << ITAPDLYENA_SHIFT);
>> -
>>       for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>> -        sdhci_am654_write_itapdly(sdhci_am654, itap);
>> +        sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
>>           curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
>> @@ -532,7 +535,7 @@ static int 
>> sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>>       itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
>>                         (sdhci_am654->dll_enable ? true : false));
>> -    sdhci_am654_write_itapdly(sdhci_am654, itap);
>> +    sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
>>       return 0;
>>   }
>> @@ -681,9 +684,12 @@ static int sdhci_am654_get_otap_delay(struct 
>> sdhci_host *host,
>>                   host->mmc->caps2 &= ~td[i].capability;
>>           }
>> -        if (td[i].itap_binding)
>> -            device_property_read_u32(dev, td[i].itap_binding,
>> -                         &sdhci_am654->itap_del_sel[i]);
>> +        if (td[i].itap_binding) {
>> +            ret = device_property_read_u32(dev, td[i].itap_binding,
>> +                               &sdhci_am654->itap_del_sel[i]);
>> +                if (!ret)
>> +                    sdhci_am654->itap_del_ena[i] = 0x1;
>> +        }
>>       }
>>       return 0;


