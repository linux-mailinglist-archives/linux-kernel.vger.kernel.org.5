Return-Path: <linux-kernel+bounces-107109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E91387F796
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EA11F2501C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E69548F8;
	Tue, 19 Mar 2024 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Unb7/JgK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430553E3B;
	Tue, 19 Mar 2024 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830120; cv=none; b=PPSxUlQAniKl1SqNkJs6PcFbU71pClcDQIOPhKLkuW9n8eUBWjUof0tPuTmj9msOFjGWSsxN/lG8Z27MwSHS63wf3XmQhZSLqxomp+TIL/O8xn4IW0A2hk5HUjm0YeT3boZTrepfsb+St2eabuv4V9VoDrGr80iuZ1VqvuCFZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830120; c=relaxed/simple;
	bh=6At5zdtZjau/wMd/lI8rbtFMSApBoONr9bvcK65Phl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR4+bDudojM8eK1oKhEd6YCf9qU0nLvaZGa54YrCx5JJFu77FGbjxoBxqm+N6RrrL36FJlLxfH8lybihcP+EVduuyzLnttaRXsDLHoHAJje/T6cGpc0TOW8HAwBNKLQAKv4OYa+pGUG/rB3tNdvnVe3CyxAz+I2m/2nIiie4CSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Unb7/JgK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710830117; x=1742366117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6At5zdtZjau/wMd/lI8rbtFMSApBoONr9bvcK65Phl8=;
  b=Unb7/JgK/JDmMePgj9jPCnk/FTvZCbqEknWTYdkA8/H542gWJYSAKAN6
   VbmAglcx5uua4mL4cesuKmgaqCJePt1fiiHVtSGqaei8e50litqZhstbG
   SkUCI+jWMgZcyiksJj+Xncs5zM+uq6nLXyYBqdaxUZibmDL7lPHbPFYwz
   kyRtIQ2O21yANpHAFHhWjlExCcjIUzklr9YWtcMKPvmHos526UWUNSu0w
   E1Mu87p+SepT8fnB3LDOrZOhj0oCj7JzyQA9T7RkmEMxavn2IrTOiQT5Z
   xRfNrqjlcQjQXJFOI9MjXGI3t12Fp6v6Cr98J2lN8hC7UXO0WkVZhG0/B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5527368"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5527368"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18405790"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.47.203])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 23:35:15 -0700
Message-ID: <f4392550-bbec-4c26-a5de-ce29e9f34551@intel.com>
Date: Tue, 19 Mar 2024 08:35:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mmc: sdhci_am654: Add tuning algorithm for delay
 chain
To: Judith Mendez <jm@ti.com>
Cc: Andrew Davis <afd@ti.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20240308005746.1059813-1-jm@ti.com>
 <20240308005746.1059813-2-jm@ti.com>
 <e0ae65bf-9cca-4dd7-9915-dd9ad67cfb35@intel.com>
 <8e8edccd-49d4-4157-b92d-8dd0630d52ac@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8e8edccd-49d4-4157-b92d-8dd0630d52ac@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/24 16:04, Judith Mendez wrote:
> On 3/14/24 9:18 AM, Adrian Hunter wrote:
>> On 8/03/24 02:57, Judith Mendez wrote:
>>> @@ -290,10 +297,12 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>>         regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>>>   -    if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
>>> +    if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>>           sdhci_am654_setup_dll(host, clock);
>>> -    else
>>> +        sdhci_am654->dll_enable = true;
>>> +    } else {
>>>           sdhci_am654_setup_delay_chain(sdhci_am654, timing);
>>
>> V2 patch had here:
>>
>>         sdhci_am654->dll_enable = false;
>>
>> Was its removal intended?
> 
> I did remove on purpose since it did not seem to be necessary.

I suspect it is necessary because ->set_clock() can be called in
when the timing has changed (e.g. recovery resets and reinitializes
the card device, or the card changes etc.) but it seems like
dll_enable would be stuck as always true once it is set to true.


