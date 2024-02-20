Return-Path: <linux-kernel+bounces-73711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C085C6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602211C21CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AA151CE3;
	Tue, 20 Feb 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HEU9cnci"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DE151CD8;
	Tue, 20 Feb 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463134; cv=none; b=orXVhev3TEM85AGIAMJKNye3KsiokQYcamCdg2HK3237+U/qzvwMm2SnYpQSocJfRvnWiKSaYcsOKjbzI078jI3vigmAAckCu4sYWBPcn2bHDAoYOTgu5+HpJm6kVfVenPz13DQ4eqrsGFnIAgAS4lhwcqr23pVGDURponcPeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463134; c=relaxed/simple;
	bh=zkS+zE4YmCs3wyzGRmVgyP3faDN1InmWrl55KLFtRHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UaMCz6W+AZ3USe3jV/TSCbYOiqakNIZH00on1NP0UMvo9FDoLCUhA/brbn3m/BdMyWqtHIxa4D5ayg5mKfLtKNCDQA3ViYxb+iboMYfyOxVbvoytVpRjz5oJZzoAPvVL7pFlHUNOssOhD07Hr8+nOmbFKQsIuZGwXaOCHqQXsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HEU9cnci; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KL5TBa033271;
	Tue, 20 Feb 2024 15:05:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708463129;
	bh=m0xPP1uguUS0gBXvFf8RHfRquJ0dbFKDfsHYvFE7L70=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HEU9cncipPrxb77+KpFp01hHx2xnZ2d6VC3UtFAgkQIdeEKmwGxis5QM7mH/uEwUS
	 IC0xSHT+Bofu3C+oHkv2NPaQv4NI40LhTFd8rgnq6dHMLUV2eVGgWM5nguUWz/nXU9
	 xTrWszWzm0DLTvMF8X9RPKZDRV9mf7icHFg5AIM0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KL5T7d009111
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 15:05:29 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 15:05:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 15:05:29 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KL5TUd073492;
	Tue, 20 Feb 2024 15:05:29 -0600
Message-ID: <b8b9a7d2-6b1c-4cb1-a41e-55a2e31c25f5@ti.com>
Date: Tue, 20 Feb 2024 15:05:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
 <82463a28-822b-4612-aed5-1be21c13acf4@intel.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <82463a28-822b-4612-aed5-1be21c13acf4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 2/16/24 11:09 AM, Adrian Hunter wrote:
> On 7/02/24 03:15, Judith Mendez wrote:
>> For DDR52 timing, DLL is enabled but tuning is not carried
>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>
>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
> 
> Note that the Fixes tags make a different ordering
> than the patch order i.e.
> 
> Patch	Fixes		in version
> 1 	13ebeae68ac9 	v5.10-rc1
> 2 	a161c45f2979 	v5.7-rc1
> 3 	8ee5fc0e0b3b 	v5.7-rc1
> 4 	8ee5fc0e0b3b 	v5.7-rc1
> 4 	a0a62497f6aa 	v5.10-rc1
> 5 	fe52e2fbc6ef 	v5.9-rc1
> 6 	1accbced1c32 	v5.3-rc1
> 7 	a161c45f2979 	v5.7-rc1
> 
> That might make backporting these patches more challenging.

Are you suggesting to remove the fixes tag here?

> 
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changelog:
>> v1->v2:
>> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>>   instead of sdhci_am654_setup_dll()
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 2c66a965c225..b50db5d4a452 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>   
>>   	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>   		sdhci_am654_setup_dll(host, clock);
>> +		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>>   		sdhci_am654->dll_enable = true;
>>   	} else {
>>   		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
> 

~ Judith

