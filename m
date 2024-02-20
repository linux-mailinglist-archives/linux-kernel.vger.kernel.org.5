Return-Path: <linux-kernel+bounces-73659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8D85C598
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EB92824CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E95B1339A6;
	Tue, 20 Feb 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xiZe4hHu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091114A4E9;
	Tue, 20 Feb 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460089; cv=none; b=U83xTfgxbqoaeG6Pxigp0qvo4TKdxRRPjKH/RzH6vF7Hy4uJ4wcMNC25E5uo+adNTjr+jTtcxOtXrPcsu3Y4LJxlohTs5WREE6wXBmaTf5rhnUPxJo326Gu7AjZYgweumViWpwKHblSxmQ8kCAxG0dk3snC7chnwk07HxQbkY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460089; c=relaxed/simple;
	bh=ZulPJZp83geGrbPeNrv6JHKGHWpaxT+n5GXqHGTV/oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OquU7y+J9JQn/JyHNQVW8xUiW4iYX0EndzJQPJEFJiOqu3aEWjVPN+wh1BXLtm3csJGTskbUCjkP8o/PSk8Ih4tVOT4asb+iRxtrHQ80r1Kl6KpT+J0N4mlSF5GlA5HA4IyxQXV7rQPQD0c//Owpf1c8ZS59epvOfLsmvvbBEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xiZe4hHu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KKEiHD017980;
	Tue, 20 Feb 2024 14:14:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708460084;
	bh=3ycyY5DdZlavliruePXXXgZtpqIFfY6COK2s5lQAULI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xiZe4hHu/6TkmfWmAR9PTyEA4lLVVuoBikFcaPkCnRW3ueSjmIRit7C22O3px+it4
	 P8wpm8IWyydmZuybaJDe6zqJXvSfKOnRhfnFHczmqYh/oAOn2VKKDxP3I+Hhbbnnsh
	 dHPnNguYlyg1ST7dMYi+xDVSKP2jVxiZct3oSZHE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KKEiqc005246
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 14:14:44 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 14:14:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 14:14:44 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KKE7Ro120357;
	Tue, 20 Feb 2024 14:14:44 -0600
Message-ID: <20c93f08-b583-4cb1-98a1-86dd4313e693@ti.com>
Date: Tue, 20 Feb 2024 14:14:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mmc: sdhci_am654: Update comments in
 sdhci_am654_set_clock
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-6-jm@ti.com>
 <d1247dbd-0672-443b-9719-3d6d52833c37@intel.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <d1247dbd-0672-443b-9719-3d6d52833c37@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 2/16/24 11:11 AM, Adrian Hunter wrote:
> On 7/02/24 03:15, Judith Mendez wrote:
>> The sdhci_am654_set_clock function is also used to enable
>> delay chain, therefore fix comments to be more generic in
>> case we are not enabling DLL.
>>
>> Fixes: fe52e2fbc6ef ("mmc: sdhci_am654: Fix conditions for enabling dll")
> 
> Similar to patch 4, Fixes tag is probably not warranted.

Will fix for V3, thanks.

> 
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 35ba7d921690..3755a015f328 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -279,7 +279,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>   
>>   	sdhci_set_clock(host, clock);
>>   
>> -	/* Setup DLL Output TAP delay */
>> +	/* Setup Output TAP delay */
>>   	otap_del_sel = sdhci_am654->otap_del_sel[timing];
>>   
>>   	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>> @@ -322,7 +322,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>   	u32 itap_del_ena;
>>   	u32 mask, val;
>>   
>> -	/* Setup DLL Output TAP delay */
>> +	/* Setup Output TAP delay */
>>   	otap_del_sel = sdhci_am654->otap_del_sel[timing];
>>   
>>   	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> 

~ Judith

