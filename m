Return-Path: <linux-kernel+bounces-85083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1686B024
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DF91C220AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CE14AD3A;
	Wed, 28 Feb 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXVIzGis"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB32151CC6;
	Wed, 28 Feb 2024 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126525; cv=none; b=HVlmBncVOzsqPO+DSUeOexUZYiPTBi1wK0Q2+eshPHgyBaD7wsUIaWvfXguUCrrOeX6jXAKFWu3QB/xavmNf+1usNIp066g+VBqnG0sHlxHgnPPRaGoOp/x3EZXpIJrjLrbxdCZ56IA3qtKkzH2y4ATOOGs7PLeVQgctcbctZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126525; c=relaxed/simple;
	bh=hvaT5h5I7KlalGKzNJnxpTCz4QTibW8laVj6jtPgz6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esocvxnU/pZt0UC67+3aL3YYo8ShULQijBJ9U0g9yLXPOg7CNDDay1OTzR7jPNiPGg+VaUB67iO96HgAg5qdv20AfPcVaEkAzRA3HWlt1FRhtYjP5otNDMPd+/o5cmEgI2vyRQ9m1/7rR7Nou98VfskB3VyG1mo2F5xxcP/+Wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXVIzGis; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709126523; x=1740662523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hvaT5h5I7KlalGKzNJnxpTCz4QTibW8laVj6jtPgz6k=;
  b=BXVIzGisyGJOOT2k6brCbVc3SKHCAJLDAyp64UVzK5nlSiUapEo1Y3Z/
   Poz5SITUtZ3EKdGss5donCdX/WotcTKnw59w94/iZTCNXpFSQPBB37WLJ
   RIoQsT0aXtu18U9x0b0+2Fc6eiz8lMBAOvCzJsozHRxNu5appBOSCfkHo
   1hAItoLWshmkZRl+FFXjrGcniq4wQF4nNrd69lW62AU1guxxni/MENxoK
   4gyz/zEuPHDfp5IAubD9LP92j4AiYUS/qNRjyZXJwTfPdlr3ZW8YNU2cE
   xkrzb0mTHP9nz3UZipLgNVDb9dY1gJOP8BSBr57TD9ra7nIpReOZmREk0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3398030"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3398030"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 05:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12100742"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.3])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 05:22:00 -0800
Message-ID: <00d4a5fe-2a9d-41c6-8f40-df657fd277d8@intel.com>
Date: Wed, 28 Feb 2024 15:21:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
 <82463a28-822b-4612-aed5-1be21c13acf4@intel.com>
 <b8b9a7d2-6b1c-4cb1-a41e-55a2e31c25f5@ti.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <b8b9a7d2-6b1c-4cb1-a41e-55a2e31c25f5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/02/24 23:05, Judith Mendez wrote:
> Hi Adrian,
> 
> On 2/16/24 11:09 AM, Adrian Hunter wrote:
>> On 7/02/24 03:15, Judith Mendez wrote:
>>> For DDR52 timing, DLL is enabled but tuning is not carried
>>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>>
>>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
>>
>> Note that the Fixes tags make a different ordering
>> than the patch order i.e.
>>
>> Patch    Fixes        in version
>> 1     13ebeae68ac9     v5.10-rc1
>> 2     a161c45f2979     v5.7-rc1
>> 3     8ee5fc0e0b3b     v5.7-rc1
>> 4     8ee5fc0e0b3b     v5.7-rc1
>> 4     a0a62497f6aa     v5.10-rc1
>> 5     fe52e2fbc6ef     v5.9-rc1
>> 6     1accbced1c32     v5.3-rc1
>> 7     a161c45f2979     v5.7-rc1
>>
>> That might make backporting these patches more challenging.
> 
> Are you suggesting to remove the fixes tag here?

No, it is just something to think about if you intend to
backport these patches to older kernels.

> 
>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> Changelog:
>>> v1->v2:
>>> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>>>   instead of sdhci_am654_setup_dll()
>>> ---
>>>   drivers/mmc/host/sdhci_am654.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>> index 2c66a965c225..b50db5d4a452 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>>         if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>>           sdhci_am654_setup_dll(host, clock);
>>> +        sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>>>           sdhci_am654->dll_enable = true;
>>>       } else {
>>>           sdhci_am654_setup_delay_chain(sdhci_am654, timing);
>>
> 
> ~ Judith


