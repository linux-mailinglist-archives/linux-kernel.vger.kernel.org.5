Return-Path: <linux-kernel+bounces-55660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A101384BF9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5313E288F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856BE1BC30;
	Tue,  6 Feb 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nBGKjew1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874B1B948;
	Tue,  6 Feb 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256700; cv=none; b=EoAln9owmWgT0KPdQM/WBnwd1NHbzrHQBw1mjr6L2xYNaZXhHmepi2zSgDhJyZ/FXwusR3FETL5gzBet+ebkQDOS4dwi1zavOwm1FkpTMHRcdtYBKFTFkN7rdAFPk2PEmuxUdnWrSXZYeuS4a7Si5dtkNW8RsMu9U9RZS81M9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256700; c=relaxed/simple;
	bh=hqJ1SlImOe9JvV0wm/kF77N7yTOOfyQP6epyE53p3LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZDx4CnzbnmCWJMHvTNtI1yEwkUe/EMhGzk5nP1zPCXmdg/pTaKLBaXb9/18mMEh4pcibb+yU68ARurmZop4ljMP00wV/yXkoeft/7YSS5NckrDdYTStjgC/STBaxT5NqTNMwSkgtG3DWuvjTKdcWv+LmRZcX6cnsXvEhYQx9rIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nBGKjew1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416LwGA1007895;
	Tue, 6 Feb 2024 15:58:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707256696;
	bh=b1s9rfXj+N0sFH6z6mNwZwYz8hF7sawp1kD2vIthMvM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nBGKjew1S0BDGYgcTXjKc5yTdR9i14F/gwHXCQWDkDonxcKowEA0t3X9OtZnSQCKI
	 2jVosEb3wPIJHXWlSM4hZ9WBO2g83xBbdN/mokGmHVJ0dYx8qgBL+ZQgB4yWqdR7k/
	 jnIQGwI3uaxhcCyyZqhu0E2VB6UKjxUScCpRLa2k=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416LwGPP048045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 15:58:16 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 15:58:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 15:58:16 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416LwFuR127714;
	Tue, 6 Feb 2024 15:58:15 -0600
Message-ID: <fb524ead-0560-44b4-8e49-27618d53d263@ti.com>
Date: Tue, 6 Feb 2024 15:58:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-3-jm@ti.com>
 <54161b26-329c-4faa-b6f7-73fe82efb525@ti.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <54161b26-329c-4faa-b6f7-73fe82efb525@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 2/1/24 1:36 PM, Andrew Davis wrote:
> On 1/31/24 3:50 PM, Judith Mendez wrote:
>> For DDR52 timing, DLL is enabled but tuning is not carried
>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>
>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed 
>> modes")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c 
>> b/drivers/mmc/host/sdhci_am654.c
>> index a3798c9912f6..ff18a274b6f2 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -170,7 +170,19 @@ struct sdhci_am654_driver_data {
>>   #define DLL_CALIB    (1 << 4)
>>   };
>> -static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned 
>> int clock)
>> +static void sdhci_am654_write_itapdly(struct sdhci_am654_data 
>> *sdhci_am654,
>> +                      u32 itapdly)
> 
> This patch is confusing, looks like you switched the place of these two
> functions, but diff is not really liking that. You can mess with
> --diff-algorithm and the like to get a more readable patch. But in
> this case why switch their spots at all?
> 
> Seems to be so you can call sdhci_am654_write_itapdly() from
> sdhci_am654_setup_dll() without a forward declaration, instead
> why not just call sdhci_am654_write_itapdly() after calling
> sdhci_am654_setup_dll() below. That also saves to from having
> to pass in `timing` to sdhci_am654_write_itapdly() just to
> have it pass it right through to sdhci_am654_setup_dll().

Really the only reason I did this is because we call
sdhci_am654_write_itapdly() in sdhci_am654_setup_delay_chain and
I wanted to keep the flow for setting up DLL the same.
I agree the patch looks confusing, so I will fix this for v2.

~ Judith

> Andrew
> 
>> +{
>> +    /* Set ITAPCHGWIN before writing to ITAPDLY */
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> +               0x1 << ITAPCHGWIN_SHIFT);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
>> +               itapdly << ITAPDLYSEL_SHIFT);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 
>> 0);
>> +}
>> +
>> +static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned 
>> int clock,
>> +                  unsigned char timing)
>>   {
>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>       struct sdhci_am654_data *sdhci_am654 = 
>> sdhci_pltfm_priv(pltfm_host);
>> @@ -236,17 +248,8 @@ static void sdhci_am654_setup_dll(struct 
>> sdhci_host *host, unsigned int clock)
>>           dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
>>           return;
>>       }
>> -}
>> -static void sdhci_am654_write_itapdly(struct sdhci_am654_data 
>> *sdhci_am654,
>> -                      u32 itapdly)
>> -{
>> -    /* Set ITAPCHGWIN before writing to ITAPDLY */
>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> -               1 << ITAPCHGWIN_SHIFT);
>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
>> -               itapdly << ITAPDLYSEL_SHIFT);
>> -    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 
>> 0);
>> +    sdhci_am654_write_itapdly(sdhci_am654, 
>> sdhci_am654->itap_del_sel[timing]);
>>   }
>>   static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data 
>> *sdhci_am654,
>> @@ -298,7 +301,7 @@ static void sdhci_am654_set_clock(struct 
>> sdhci_host *host, unsigned int clock)
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>       if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>> -        sdhci_am654_setup_dll(host, clock);
>> +        sdhci_am654_setup_dll(host, clock, timing);
>>           sdhci_am654->dll_enable = true;
>>       } else {
>>           sdhci_am654_setup_delay_chain(sdhci_am654, timing);


