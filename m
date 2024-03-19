Return-Path: <linux-kernel+bounces-107863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC7A8802B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCC2846BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BF12B89;
	Tue, 19 Mar 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rq+R3tV3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653D1118E;
	Tue, 19 Mar 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866857; cv=none; b=EQ5/ClHDi6dc9QE4AtbWijQveoPdHAh9H+pb0+EPkgT2/VF2SwprvLwbbqEOnsk+AVCKq/IzLROJIGyBdQJHw4jfQ1I7WvLRqpgNDtalGpmmmneB1mi/nN+i91H8VB3/phPBWkrxrSlfn6noIEXzzvocSvC8rI6yVn9wIuWzo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866857; c=relaxed/simple;
	bh=/nfXULMD8EDgASL0iRHsNMXIgHKM7as2goLuu9NzFO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gw1fu8BYk8v9Z+2CpJ65jfs+F35DU9TKYKXoP10ibPheepnv1wLm0uCZoBfRLY9+sa4FgIStxC4AdHHLU/b1N/dJyAuQ1Bw3zByxP6wjg4qbsESJesWMFEqj8lsOhvPxtIyFh2LVHKX3Rlq8T34FUkHxannsgrW8SKB4PIZpm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rq+R3tV3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JGlVWS059442;
	Tue, 19 Mar 2024 11:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710866852;
	bh=MOQMAwUNy7kV75f8NHL48jlWHZjYdpnWJReCTjcS1ww=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Rq+R3tV3yUokJ8CyPWi8fH6LgzPviCerkYkd4PyTD2FqkedXRgfzZBP516M3H6msa
	 DSeLtspqRWYfol00ac1NAlmsNFSDsjNF7piEnP36QZ71e6jRY/2XdmBd1lA6DtevZc
	 VpzBXffNjdHa+k1eFJbjzxEKnqgN/5scgHsHikw0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JGlVId113113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 11:47:31 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 11:47:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 11:47:31 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JGlVe1118632;
	Tue, 19 Mar 2024 11:47:31 -0500
Message-ID: <49bae1b1-941f-4501-a7b8-2e90bdc20a72@ti.com>
Date: Tue, 19 Mar 2024 11:47:31 -0500
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
 <8e8edccd-49d4-4157-b92d-8dd0630d52ac@ti.com>
 <f4392550-bbec-4c26-a5de-ce29e9f34551@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <f4392550-bbec-4c26-a5de-ce29e9f34551@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/19/24 1:35 AM, Adrian Hunter wrote:
> On 18/03/24 16:04, Judith Mendez wrote:
>> On 3/14/24 9:18 AM, Adrian Hunter wrote:
>>> On 8/03/24 02:57, Judith Mendez wrote:
>>>> @@ -290,10 +297,12 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>          regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>>>    -    if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
>>>> +    if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>>>            sdhci_am654_setup_dll(host, clock);
>>>> -    else
>>>> +        sdhci_am654->dll_enable = true;
>>>> +    } else {
>>>>            sdhci_am654_setup_delay_chain(sdhci_am654, timing);
>>>
>>> V2 patch had here:
>>>
>>>          sdhci_am654->dll_enable = false;
>>>
>>> Was its removal intended?
>>
>> I did remove on purpose since it did not seem to be necessary.
> 
> I suspect it is necessary because ->set_clock() can be called in
> when the timing has changed (e.g. recovery resets and reinitializes
> the card device, or the card changes etc.) but it seems like
> dll_enable would be stuck as always true once it is set to true.
> 
Thinking about this some more, you are right. Will add back, thanks.

~ Judith

