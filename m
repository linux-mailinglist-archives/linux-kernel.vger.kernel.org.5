Return-Path: <linux-kernel+bounces-47811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A8584532C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC74B215AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC915AABD;
	Thu,  1 Feb 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ1MULe6"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86101158D9B;
	Thu,  1 Feb 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777685; cv=none; b=Um0N9cjk2uXObnuGKtjGIfPMyLQVoEXDHsZVGifD3CZvHwUF+6i+4hsCSK4KZNBXgi6TPYcELWjriT4EX3yEUqjQ0j+bCfJcCEU1XYyqrWvw7yVk0ovhYSMDahr4CVKKvSuivaX3yA79/s45POyq5uKatOZVwXqusxvwq3VXAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777685; c=relaxed/simple;
	bh=ZYTPFYWIhU6NVatVJgH96At0DlWX7QBubehHR0HaCZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKdAu07DvJbY9iD3MNobs7Y0yyYIrxCpZOgXK50xP2OzxgzsKIA0kb5K4QCo5v1gbNy+IbDsOClyJ+Yj/PzMLjxiISEnRa6TObKdPZAsjfml9dc2xbGqCQ9OVSU0tSUWaohw/Fx3lj2cxQkLIJruIHO/kwS09iTrLQ8aA8LNbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ1MULe6; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706777683; x=1738313683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZYTPFYWIhU6NVatVJgH96At0DlWX7QBubehHR0HaCZk=;
  b=oJ1MULe6UxL3wl+DLDe/3bZwI9L8ZaVtg5R15dQoBLmPSufOuid0tGoE
   sIgIupUFn19UJg1TU4a7BCIfcfVBjzUg+uFRuw+XMH5UDrmv642AESrT2
   azhBkAIMloZLbHTOYPTYDvmtsOIFpdey1b4kIWbmPDOOUwQkIk0O7XBAG
   ydDEssic9ec93Uy1p3CHRKoZMVZ2suCGJPyp/ZZ38ITnqQaLFoPCDcgRT
   qfANdbD2Gzwy811nU5bsFKAKCSIERx1HkmIhwAceEv9mIe1tIiMFnbaqa
   kl6K0ckZXU/Ug+W5OTMIDOnAIIpH6+I95rXisdVvv1HPVbZu4vK25oST4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407564466"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407564466"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="30089"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:54:41 -0800
Message-ID: <b8761b25-9754-45be-9025-e03c474b955b@linux.intel.com>
Date: Thu, 1 Feb 2024 09:54:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
Content-Language: en-US
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
 <3b5bf4b7-a4ec-44be-975b-04590777a965@linux.intel.com>
 <c4498c59-cf64-4a8b-82b9-01d0571779c7@gmail.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <c4498c59-cf64-4a8b-82b9-01d0571779c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/31/2024 6:41 PM, Ivan Orlov wrote:
> On 1/26/24 09:01, Amadeusz Sławiński wrote:
>> On 1/25/2024 11:35 PM, Ivan Orlov wrote:
>>> Add 4 missing formats to 'snd_pcm_format_names' array in order to be
>>> able to get their names with 'snd_pcm_format_name' function.
>>>
>>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>> ---
>>>   sound/core/pcm.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
>>> index a09f0154e6a7..d0788126cbab 100644
>>> --- a/sound/core/pcm.c
>>> +++ b/sound/core/pcm.c
>>> @@ -211,6 +211,10 @@ static const char * const snd_pcm_format_names[] 
>>> = {
>>>       FORMAT(DSD_U32_LE),
>>>       FORMAT(DSD_U16_BE),
>>>       FORMAT(DSD_U32_BE),
>>> +    FORMAT(S20_LE),
>>> +    FORMAT(S20_BE),
>>> +    FORMAT(U20_LE),
>>> +    FORMAT(U20_BE),
>>>   };
>>>   /**
>>
>> Maybe we can also add some kind of static_assert to check at compile 
>> time that all formats are handled, something like:
>> static_assert(ARRAY_SIZE(snd_pcm_format_names) == 
>> SNDRV_PCM_FORMAT_LAST + 1);
>>
>> Although looking at definitions there is a hole between 
>> SNDRV_PCM_FORMAT_U20_BE & SNDRV_PCM_FORMAT_SPECIAL, which will cause 
>> this idea to fail.
>>
>> Perhaps with comment:
>> static_assert(ARRAY_SIZE(snd_pcm_format_names) == 
>> SNDRV_PCM_FORMAT_LAST + 1 - 2); /* -2 for formats reserved for future 
>> use */
>> ?
> 
> Hi Amadeusz,
> 
> Thank you for the review and sorry for the late answer. Yes, I believe 
> it could be a nice improvement! Could I send a patch and specify you in 
> Suggested-by tag?
> 

Hi,

yes, go for it!

Amadeusz

