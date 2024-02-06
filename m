Return-Path: <linux-kernel+bounces-55676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D784BFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594DD1C240F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC21BF20;
	Tue,  6 Feb 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uXUIalSW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D91BC3C;
	Tue,  6 Feb 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257443; cv=none; b=Bim9yoDvYASMWhb6Fs6H5l5+mX6l2VeTSK/YMSLUcolN/+kgRCsaslIVzEVOynyxu+S3LSDBBpZ3cRKsd/6M08gqKpMHFH+zUbsKhMT0VaWKMsFkPecQsFW9r0VPwSiUV24gu0jKu/mXIXKVTd2M6m48td9aTNB/TpO0DIO73FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257443; c=relaxed/simple;
	bh=mEm6lEIKUnmm3MKFJcqd+RobgDKepf6Ct1cJxtyjksw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mnFCBddCZ0sysDy7rX1jIp9o2fRvYweyLEeSqdNSGLCW/5KNJR6Jjo2GtQvylyPrvj6NB6s9Xh8iujHwezn7nq0OlBx/wP8VmL0XL2Qukpisl4y2PszEH0yhMkQ87yIAEpfdJJ6b0GZR1jbZLqOfVqz/wYp3WA7+u/YEGurCdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uXUIalSW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416MAcIf010841;
	Tue, 6 Feb 2024 16:10:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707257438;
	bh=Mcz5D0g4BHyRQnc3gCk6hBip0QzXdbt1TI5pKNgciC4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=uXUIalSWNwr6KT8We8G1DqLMXzSaDxt11rjHZpNG/YVUuVPDB7FoKk6r/2A/ujHhk
	 yhvX6cgit/wwvGqoW2L6f9YeFbuaPWgQpfQOcrhpXjF+atWO7RGjrxbnl4W1KEUsAh
	 mmDhMTkovtKtBpBk4ekHYmRVlekUhtvYMyZXyuew=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416MAcsu028596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 16:10:38 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 16:10:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 16:10:38 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416MAc6t116843;
	Tue, 6 Feb 2024 16:10:38 -0600
Message-ID: <66265f27-2314-40e3-a653-35e037685c1d@ti.com>
Date: Tue, 6 Feb 2024 16:10:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-3-jm@ti.com>
 <54161b26-329c-4faa-b6f7-73fe82efb525@ti.com>
 <fb524ead-0560-44b4-8e49-27618d53d263@ti.com>
In-Reply-To: <fb524ead-0560-44b4-8e49-27618d53d263@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/6/24 3:58 PM, Judith Mendez wrote:
> Hi Andrew,
> 
> On 2/1/24 1:36 PM, Andrew Davis wrote:
>> On 1/31/24 3:50 PM, Judith Mendez wrote:
>>> For DDR52 timing, DLL is enabled but tuning is not carried
>>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>>
>>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some 
>>> speed modes")
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>   drivers/mmc/host/sdhci_am654.c | 27 +++++++++++++++------------
>>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c 
>>> b/drivers/mmc/host/sdhci_am654.c
>>> index a3798c9912f6..ff18a274b6f2 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -170,7 +170,19 @@ struct sdhci_am654_driver_data {
>>>   #define DLL_CALIB    (1 << 4)
>>>   };
>>> -static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned 
>>> int clock)
>>> +static void sdhci_am654_write_itapdly(struct sdhci_am654_data 
>>> *sdhci_am654,
>>> +                      u32 itapdly)
>>
>> This patch is confusing, looks like you switched the place of these two
>> functions, but diff is not really liking that. You can mess with
>> --diff-algorithm and the like to get a more readable patch. But in
>> this case why switch their spots at all?
>>
>> Seems to be so you can call sdhci_am654_write_itapdly() from
>> sdhci_am654_setup_dll() without a forward declaration, instead
>> why not just call sdhci_am654_write_itapdly() after calling
>> sdhci_am654_setup_dll() below. That also saves to from having
>> to pass in `timing` to sdhci_am654_write_itapdly() just to
>> have it pass it right through to sdhci_am654_setup_dll().
> 
> Really the only reason I did this is because we call
> sdhci_am654_write_itapdly() in sdhci_am654_setup_delay_chain and
> I wanted to keep the flow for setting up DLL the same.
> I agree the patch looks confusing, so I will fix this for v2.

TBH I think it is a good idea to keep the flow the same as it
is for sdhci_am654_setup_delay_chain(). Unless you know of a
strong enough reason to change, I am leaning towards leaving the
patch as is.

> 
> ~ Judith
> 
>> Andrew
>>
>>> +{
>>> +    /* Set ITAPCHGWIN before writing to ITAPDLY */
>>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>>> +               0x1 << ITAPCHGWIN_SHIFT);
>>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
>>> +               itapdly << ITAPDLYSEL_SHIFT);
>>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, 
>>> ITAPCHGWIN_MASK, 0);
>>> +}
>>> +
>>> +static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned 
>>> int clock,
>>> +                  unsigned char timing)
>>>   {
>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>       struct sdhci_am654_data *sdhci_am654 = 
>>> sdhci_pltfm_priv(pltfm_host);
>>> @@ -236,17 +248,8 @@ static void sdhci_am654_setup_dll(struct 
>>> sdhci_host *host, unsigned int clock)
>>>           dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
>>>           return;
>>>       }
>>> -}
>>> -static void sdhci_am654_write_itapdly(struct sdhci_am654_data 
>>> *sdhci_am654,
>>> -                      u32 itapdly)
>>> -{
>>> -    /* Set ITAPCHGWIN before writing to ITAPDLY */
>>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>>> -               1 << ITAPCHGWIN_SHIFT);
>>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
>>> -               itapdly << ITAPDLYSEL_SHIFT);
>>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, 
>>> ITAPCHGWIN_MASK, 0);
>>> +    sdhci_am654_write_itapdly(sdhci_am654, 
>>> sdhci_am654->itap_del_sel[timing]);
>>>   }
>>>   static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data 
>>> *sdhci_am654,
>>> @@ -298,7 +301,7 @@ static void sdhci_am654_set_clock(struct 
>>> sdhci_host *host, unsigned int clock)
>>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>>       if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>> -        sdhci_am654_setup_dll(host, clock);
>>> +        sdhci_am654_setup_dll(host, clock, timing);
>>>           sdhci_am654->dll_enable = true;
>>>       } else {
>>>           sdhci_am654_setup_delay_chain(sdhci_am654, timing);
> 
> 


