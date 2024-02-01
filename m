Return-Path: <linux-kernel+bounces-48894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CCE8462E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4310BB23CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1A3F8D4;
	Thu,  1 Feb 2024 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qb2OYfPm"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A73F8C2;
	Thu,  1 Feb 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824357; cv=none; b=oNfuQ935PgH3hRF5ilZ9MczbcXF/Y7GWsopicemAnQhwKXzr8SS6XrU1M5fD0hPIOgF6ZQBgw/0wPyq7Yyhzz3xCTjj500iXq9y4sKAf4sE7gUFUfSaIu/R+JCzDXvX1QXSwcU32rn2mszBFTKj7M7Bg0s7nOPuiF5dIKZA0TeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824357; c=relaxed/simple;
	bh=Qa1THVnsyEKM50hLOG+BiQVCaCJs1LkH+TNg0nMaur4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D/NUWTWUhGZF273hiqHEAdMHVTFdKYF4/dLA0tGGuAlkUw9tqKNPNcWCdHcMITDMdqIS8wogg6NA9A7+o3QUDUuu2LC3sm9jJVBh3SP2g2K31O2PySJN5oAiAL1iDd3mdhcI8jWjc09NGJaTE5x/MUrX7nloXG29dfamL9nySoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qb2OYfPm; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411LqRYD128946;
	Thu, 1 Feb 2024 15:52:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706824347;
	bh=vwgEMwf9A/5QdFo7Zy4CwJZYNLqG5d0aB4Dwlg0qbMI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Qb2OYfPm19QqKAYDhihML00dLWmG7jKncn3Z6P06li5vHzOK6bTp+p73pW5Y5WWAw
	 IGUUQ8KWtbqitiiQxU6wTAg/ahrzBnbslH0Dt/D5OgYATUzEoOyQHZlQxjNbT5gXnj
	 PL0GGXR7B0DSbPvAc0SyOp/DEbCys8iXiVRfwyfE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411LqREY026351
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 15:52:27 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 15:52:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 15:52:27 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411LqRhn098137;
	Thu, 1 Feb 2024 15:52:27 -0600
Message-ID: <866dc9ae-89be-4a6e-974b-d878af5e71d0@ti.com>
Date: Thu, 1 Feb 2024 15:52:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] mmc: sdhci_am654: Add ITAPDLYSEL in
 sdhci_j721e_4bit_set_clock
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-5-jm@ti.com>
 <7c40a415-f2d5-4a39-8c7e-7e7a05e0bdb3@ti.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <7c40a415-f2d5-4a39-8c7e-7e7a05e0bdb3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 2/1/24 1:57 PM, Andrew Davis wrote:
> On 1/31/24 3:50 PM, Judith Mendez wrote:
>> Add ITAPDLYSEL to sdhci_j721e_4bit_set_clock function.
>> This allows to set the correct ITAPDLY for timings that
>> do not carry out tuning.
>>
>> Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on 
>> J721E")
> 
> You are adding this as a new feature, and not having a feature doesn't mean
> the initial patch was broken. If this patch was backported to kernels only
> containing the above patch it would cause more issues, so no need for the
> fixes tags on this nor the last patch.
> 

Sure, will fix, thanks.

>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c 
>> b/drivers/mmc/host/sdhci_am654.c
>> index 5ac82bc70706..f5dc981c470d 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -321,6 +321,7 @@ static void sdhci_j721e_4bit_set_clock(struct 
>> sdhci_host *host,
>>       unsigned char timing = host->mmc->ios.timing;
>>       u32 otap_del_sel;
>>       u32 itap_del_ena;
>> +    u32 itap_del_sel;
>>       u32 mask, val;
>>       /* Setup Output TAP delay */
>> @@ -329,12 +330,17 @@ static void sdhci_j721e_4bit_set_clock(struct 
>> sdhci_host *host,
>>       mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>>       val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << 
>> OTAPDLYSEL_SHIFT);
>> +    /* Setup Input TAP delay */
>>       itap_del_ena = sdhci_am654->itap_del_ena[timing];
>> +    itap_del_sel = sdhci_am654->itap_del_sel[timing];
>> -    mask |= ITAPDLYENA_MASK;
>> -    val |= (itap_del_ena << ITAPDLYENA_SHIFT);
>> +    mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
>> +    val |= (itap_del_ena << ITAPDLYENA_SHIFT) | (itap_del_sel << 
>> ITAPDLYSEL_SHIFT);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> +               1 << ITAPCHGWIN_SHIFT);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 
>> 0);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>>                  sdhci_am654->clkbuf_sel);

~ Judith

