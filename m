Return-Path: <linux-kernel+bounces-73657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401A85C591
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52A9B21030
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895FD14A4F3;
	Tue, 20 Feb 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qgwk/qWY"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE29612D7;
	Tue, 20 Feb 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460052; cv=none; b=VT5pfyCjvORDynTNfh0lj5U9et6guAHrs6X7sLGHRNIkcKThgjymvPJgcE/jgdAYwQ/ABajS9fmrjT5HAj24B/ix+x+Tdf5tm8/vgzkbjI+GDpU6KlP68QtVDidBV0lZ2Twtyq9ElaZtyHmje9MmkRQTli/V5I2gm499luu9hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460052; c=relaxed/simple;
	bh=UIBnmYHJX33/NIl8avPkWKY89ADvShl3mbypi3j3H4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SH4eb+h8OyUlDKeNRVj6ThZrq7RhMTIgvNgbHHqggWhUEI0+iFX9X1NqflfD/VsmC40RD6wSUlAamleHVjT9if8dGdONX+5IG0BISedqVWTsdrF6/6QVJ1yN+AuqMgX9F2ahaB7rzdA7pcySlgJa226+1/N/4jDeWEGvSdOtnfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qgwk/qWY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KKE75p103353;
	Tue, 20 Feb 2024 14:14:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708460047;
	bh=esh6Csnjg2kLzkpcDrhWMiwHx1bsnLK5SS1TCHWDxLQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qgwk/qWY9ukKv/iP2KPjgSW40IF+TYDvKDcA7n3Jlz/c7F+vo3SCfIt47hPmtSi9m
	 rkatIWh2wXfio1vk8IDmPiBnhvpkU0r6t0L1dnT34Qv+CBxxgVJOrsUqb3+fXnDjTm
	 x8O8iRiq03xB5FNaVmDxSGMisar6JnQ35G/cHTfo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KKE7PY004552
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 14:14:07 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 14:14:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 14:14:07 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KKE7Rn120357;
	Tue, 20 Feb 2024 14:14:07 -0600
Message-ID: <954f09c0-9486-4830-a8ae-c5172f74bdc7@ti.com>
Date: Tue, 20 Feb 2024 14:14:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mmc: sdhci_am654: Fix itapdly/otapdly array type
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-5-jm@ti.com>
 <ea3f337b-8e8f-4813-b0d7-aff0f08c5a5c@intel.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <ea3f337b-8e8f-4813-b0d7-aff0f08c5a5c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 2/16/24 11:10 AM, Adrian Hunter wrote:
> On 7/02/24 03:15, Judith Mendez wrote:
>> While integer type works, the otap_del_sel and itap_del_sel
>> arrays are manipulated as u32, so change array types to u32.
> 
> If it doesn't make any practical difference, then it is not
> generally considered a "fix", at least according to stable
> kernel rules, so Fixes tags are probably not warranted here.

Understood, will remove fixes tag here then, thanks.

> 
>>
>> Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
>> Fixes: a0a62497f6aa ("mmc: sdhci_am654: Add support for input tap delay")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 935f581c05d8..35ba7d921690 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -141,8 +141,8 @@ static const struct timing_data td[] = {
>>   
>>   struct sdhci_am654_data {
>>   	struct regmap *base;
>> -	int otap_del_sel[ARRAY_SIZE(td)];
>> -	int itap_del_sel[ARRAY_SIZE(td)];
>> +	u32 otap_del_sel[ARRAY_SIZE(td)];
>> +	u32 itap_del_sel[ARRAY_SIZE(td)];
>>   	u32 itap_del_ena[ARRAY_SIZE(td)];
>>   	int clkbuf_sel;
>>   	int trm_icp;
> 

~ Judith

