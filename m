Return-Path: <linux-kernel+bounces-49195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D884670D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8A51F22878
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE31168B8;
	Fri,  2 Feb 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J0oO7P36"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961C16415;
	Fri,  2 Feb 2024 04:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848972; cv=none; b=RUdUW4zFdL3M61sbRojGdYhFgTloJ8vhtnsvbOIIgV5BiNL4GMlsWcTn5sIfs0F/g3DGqR25pEugt1BzE6EMkilPx5JZHsTvKvpQ/vApqv9/lzubx+m+8UrVkxJA2AtbFfQgWlxIl0HoSZKdzHAX2dGvmLBtxt5R6nX7Xpz0je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848972; c=relaxed/simple;
	bh=N4g6xs7GoH3hDpSrDSPdvdDkuQkcPXFHbaHv+QrgtZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OyNbzaSIL/a10vIohtuIz5YMfGU00OnaVwk/gcDAB+zKzvnNHaerNkJGGl5B7EA1y8boPjNaLWpR9vicEILu2g5cHDvgFttgP3u4rV8VSGw7mKXA+CzXyqx91KudQBo7ab/BK2kaaE8tDeQRflg3+FhVCikKWK4jJgL3xJX/EIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J0oO7P36; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4124glIF075956;
	Thu, 1 Feb 2024 22:42:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706848967;
	bh=faqVeFHsLqjdy1Hajy1RkDTBG7nwq84y3RaAXi/3lvw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J0oO7P36ljkKBv5TiEgIoFKdYVXHBPiYDhg0PrwwBljVEuTWe9n236HHeJyq7mA3a
	 Cd0cs/VQ5Qat8tyr8U73Tigczz9KnA9vmub1/KN5OhhvTTqW3X+N67PDCFe20n1i5j
	 wBJiDjVQWSUqeHiKGmDrDxfGiqe1bm2zzNi/afu8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4124gl1C068163
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 22:42:47 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 22:42:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 22:42:47 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4124giHq125838;
	Thu, 1 Feb 2024 22:42:45 -0600
Message-ID: <f92bd805-2017-4f40-ad79-30b6ff9b9e44@ti.com>
Date: Fri, 2 Feb 2024 10:12:43 +0530
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
To: Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
 <20240131215044.3163469-5-jm@ti.com>
 <7c40a415-f2d5-4a39-8c7e-7e7a05e0bdb3@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <7c40a415-f2d5-4a39-8c7e-7e7a05e0bdb3@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 02/02/24 01:27, Andrew Davis wrote:
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

Not really a new features. Devices Datasheets have always been clear
that static ITAPDLY needs to be configured when tuning isn't performed.
Hence a bug as the initial patch (Fixes line) does enable such
(affected) modes where tuning isn't performed but ITAPDLY isn't set either.

> Andrew
> 
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
>>         /* Setup Output TAP delay */
>> @@ -329,12 +330,17 @@ static void sdhci_j721e_4bit_set_clock(struct
>> sdhci_host *host,
>>       mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>>       val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel <<
>> OTAPDLYSEL_SHIFT);
>>   +    /* Setup Input TAP delay */
>>       itap_del_ena = sdhci_am654->itap_del_ena[timing];
>> +    itap_del_sel = sdhci_am654->itap_del_sel[timing];
>>   -    mask |= ITAPDLYENA_MASK;
>> -    val |= (itap_del_ena << ITAPDLYENA_SHIFT);
>> +    mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
>> +    val |= (itap_del_ena << ITAPDLYENA_SHIFT) | (itap_del_sel <<
>> ITAPDLYSEL_SHIFT);
>>   +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> +               1 << ITAPCHGWIN_SHIFT);
>>       regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>> +    regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
>> 0);
>>         regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
>>                  sdhci_am654->clkbuf_sel);

-- 
Regards
Vignesh

