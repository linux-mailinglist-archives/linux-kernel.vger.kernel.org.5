Return-Path: <linux-kernel+bounces-119635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED088CB67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FF71F821DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DF208B4;
	Tue, 26 Mar 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lizna5Tv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5271C6A4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475905; cv=none; b=PjjPb9AChPEhzI6Ctn5qJV6Op8PAqTaXw+y3coSUgU1b+mJWOz74+KY8a6JLNMagmICd/nIHwKKlSeVEbVVKzPL21ClVGuON7/F5AQJozgMl6sF2YRoNNdnAFK3vj8A0h50yX6XIU8Uul/dq6dwTX0MzOsG9PeCN3iah7qP6Zqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475905; c=relaxed/simple;
	bh=imhNP8y+g5T4b+no8Hjc+kCYVt8bGQtnN/kFSTFcj1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Heq/WDe/BcgFxhNwt4nIWIsaJ3TKSyPrEEdCqfkeDNqXBjplf2c7Q/j6k3sXZrBybEg2IPwpDJSjm9LCPyg9whJrG1PPCLr+QsikOc2EgDSV9G0TSTF8g/3ElIeWJRLJiIquK/jNQLIPTqudbjNfge3tf6/cZxlK5qUBEuHezBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lizna5Tv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475902; x=1743011902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=imhNP8y+g5T4b+no8Hjc+kCYVt8bGQtnN/kFSTFcj1s=;
  b=lizna5TvA0L3FXI3nS4cbaFWBOeeCguca6AD2mKZ7IGUkjX1jStkzfuQ
   9jN7pyG+giYfNg4CV8iq05ZsViX2Q5eQCDSZTuSrjzkg4CLJhdcPJO9Du
   UsgpgOfOk2yG/hv0RQn30eyzLB0b3ey3HQd5RkZn0kRkIgVACX2+cvebM
   5fUpYSacA72WqeV2LnAVqsu0m9NAwLQE6B6a0IG92jlrqcBavLFws2mpU
   UDgqD8mi+hngVZFFd7UBd9n4h1A10JerZYTsu4+EI114Fazx721D/+RE3
   L3CzQlksu2z/qHAvQOoUtH9fwmMAqRhvravrBlpDFQQscrQxkmvkLIghI
   w==;
X-CSE-ConnectionGUID: klFhrPKfRwW2H6sfp4oVog==
X-CSE-MsgGUID: 1J6+whn7S7u/VclVNSfsdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17092337"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17092337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20757732"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 10:58:22 -0700
Received: from [10.249.156.251] (unknown [10.249.156.251])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E276A2876B;
	Tue, 26 Mar 2024 17:58:19 +0000 (GMT)
Message-ID: <11c0a997-f283-476b-bdf6-47b440538f8b@intel.com>
Date: Tue, 26 Mar 2024 18:58:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wordpart.h: Helpers for making u16/u32/u64 values
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Jani Nikula <jani.nikula@intel.com>
References: <20240214214654.1700-1-michal.wajdeczko@intel.com>
 <202402141408.0E78D47@keescook>
 <a6652e88-c66f-44d5-93a4-be9fa7a4623d@intel.com>
 <202402151446.D9AE0626@keescook>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <202402151446.D9AE0626@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.02.2024 23:47, Kees Cook wrote:
> On Thu, Feb 15, 2024 at 09:40:40PM +0100, Michal Wajdeczko wrote:
>> On 14.02.2024 23:09, Kees Cook wrote:
>>> On Wed, Feb 14, 2024 at 10:46:53PM +0100, Michal Wajdeczko wrote:
>>>> It is quite common practice to make u16, u32 or u64 values from
>>>> smaller words.  Add simple helpers for that.
>>>>
>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>> ---
>>>> v2: new macro names due to conflict with crypto/aria.h
>>>>     explicit cast and truncation everywhere (Alexey)
>>>>     moved to wordpart.h (Andy)
>>>> ---
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>> ---
>>>>  include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
>>>>  1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
>>>> index f6f8f83b15b0..8c75a5355112 100644
>>>> --- a/include/linux/wordpart.h
>>>> +++ b/include/linux/wordpart.h
>>>> @@ -31,6 +31,38 @@
>>>>   */
>>>>  #define lower_16_bits(n) ((u16)((n) & 0xffff))
>>>>  
>>>> +/**
>>>> + * make_u16_from_u8 - make u16 value from two u8 values
>>>> + * @hi: value representing upper 8 bits
>>>> + * @lo: value representing lower 8 bits
>>>> + */
>>>> +#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))
>>>
>>> Do we want to actually do type validation here? Right now it's just
>>> cast/truncating, which based on the version log is by design. Is silent
>>> truncation the right thing to do?
>>
>> note that even FIELD_PREP() is doing silent truncation and these macros
>> here could be treated as specialized/simplified variants of FIELD_PREP()
>> as alternate implementation can look like:
> 
> Also, isn't all of this endian-specific?

endianness shouldn't matter here

so I guess the only question now is whether we want to have simple
direct macros like lower|upper_bits() or go with macros build on top of
the FIELD_PREP_CONST() or drop the idea completely and force the drivers
to invent the wheel on its own

