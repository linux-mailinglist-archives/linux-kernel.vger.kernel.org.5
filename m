Return-Path: <linux-kernel+bounces-135433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3E89C242
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500F5283769
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A48823A2;
	Mon,  8 Apr 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dow6Uu4x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC38121A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582666; cv=none; b=D2BAOa6qXiXAmnPiPl1LkH4W1MhJvTkF4LxPNoNIVqpJs7Re4XB7f8eBhmRYnIfv4nGcr79Jbkr++ZHt+J2Q0cnvBoQKIhrjulc0dzEI5cTrpFIw9pTIpp+QiTL6PslyUJeFyL8j3FB0wJhbzwNm8Wi/RdWENvHNgNh5c5STyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582666; c=relaxed/simple;
	bh=qMVsLpScZjtk/kTqxB0Im0Ne05HaP9RuQC72PLFA+KU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gz8SOzf4eM+J7AKlKf3SXZUul6Gan+eVVLCtkXkk8zt7z3ha0D5sk3ODybsDLeYIP5jelSpC7EOY6k67+yO8/hPS4JSnfrwdd1z/Sk4At1G8XN223oiD0candNHjaHoOnAYw+lA8o3JoMeL6Ya8/OVLytDpDfk3+4iwIMNdkNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dow6Uu4x; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712582664; x=1744118664;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qMVsLpScZjtk/kTqxB0Im0Ne05HaP9RuQC72PLFA+KU=;
  b=Dow6Uu4x2EYF7L04jexTa/oCYLGeoVa+t6QtJA3V29sByMzfUktx0QmE
   yaj/hFLmb14KQUflpWGmlYmaNxLAHV0C+QkiiueDM4it58VdwkxECu7OE
   pyYuITnL4B3sBbravt3iL2Sfru2eXdzWR8EaNvWMI5+C6c/0kOfaINjwr
   t7GRj9OQXcIgdxhhDWTuPYX6dBhK/5aUdRTP8xAkjMCO2P/03oQtxlT5A
   uJSInWNthDAZn+poSe8HFVOj8kOycC7wJFCyTP6mjgZGQ/uEl9Mx8DkRK
   Avfi1IMHQbV1Qw50jSPX9qSXacx2YyFoqHUB7+THpU9tWzBUIxt/zVuYp
   g==;
X-CSE-ConnectionGUID: vLZkmJ+ARnCgTJ4gDZhoMQ==
X-CSE-MsgGUID: +4+cBrN3RxelF8yxXcAu7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7724081"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7724081"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 06:24:23 -0700
X-CSE-ConnectionGUID: r7GsjWDIQv6OcBIrxS8waA==
X-CSE-MsgGUID: 443Jqdc0So+NJFQCBzKgmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19837617"
Received: from bauinger-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 06:24:21 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>, Kees Cook
 <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/2] wordpart.h: Helpers for making u16/u32/u64 values
In-Reply-To: <11c0a997-f283-476b-bdf6-47b440538f8b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240214214654.1700-1-michal.wajdeczko@intel.com>
 <202402141408.0E78D47@keescook>
 <a6652e88-c66f-44d5-93a4-be9fa7a4623d@intel.com>
 <202402151446.D9AE0626@keescook>
 <11c0a997-f283-476b-bdf6-47b440538f8b@intel.com>
Date: Mon, 08 Apr 2024 16:24:18 +0300
Message-ID: <87le5o9ed9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 26 Mar 2024, Michal Wajdeczko <michal.wajdeczko@intel.com> wrote:
> On 15.02.2024 23:47, Kees Cook wrote:
>> On Thu, Feb 15, 2024 at 09:40:40PM +0100, Michal Wajdeczko wrote:
>>> On 14.02.2024 23:09, Kees Cook wrote:
>>>> On Wed, Feb 14, 2024 at 10:46:53PM +0100, Michal Wajdeczko wrote:
>>>>> It is quite common practice to make u16, u32 or u64 values from
>>>>> smaller words.  Add simple helpers for that.
>>>>>
>>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>>> ---
>>>>> v2: new macro names due to conflict with crypto/aria.h
>>>>>     explicit cast and truncation everywhere (Alexey)
>>>>>     moved to wordpart.h (Andy)
>>>>> ---
>>>>> Cc: Kees Cook <keescook@chromium.org>
>>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>> ---
>>>>>  include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
>>>>> index f6f8f83b15b0..8c75a5355112 100644
>>>>> --- a/include/linux/wordpart.h
>>>>> +++ b/include/linux/wordpart.h
>>>>> @@ -31,6 +31,38 @@
>>>>>   */
>>>>>  #define lower_16_bits(n) ((u16)((n) & 0xffff))
>>>>>  
>>>>> +/**
>>>>> + * make_u16_from_u8 - make u16 value from two u8 values
>>>>> + * @hi: value representing upper 8 bits
>>>>> + * @lo: value representing lower 8 bits
>>>>> + */
>>>>> +#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))
>>>>
>>>> Do we want to actually do type validation here? Right now it's just
>>>> cast/truncating, which based on the version log is by design. Is silent
>>>> truncation the right thing to do?

Doesn't the name imply strongly enough that we're only interested in the
N bits from each parameter? I think not truncating makes these harder to
use (if it means e.g. casting on the caller side).

>>>
>>> note that even FIELD_PREP() is doing silent truncation and these macros
>>> here could be treated as specialized/simplified variants of FIELD_PREP()
>>> as alternate implementation can look like:
>> 
>> Also, isn't all of this endian-specific?

None of this assumes endianness.

> endianness shouldn't matter here
>
> so I guess the only question now is whether we want to have simple
> direct macros like lower|upper_bits() or go with macros build on top of
> the FIELD_PREP_CONST() or drop the idea completely and force the drivers
> to invent the wheel on its own

Yeah, please let's do this so we don't have to keep adding them to
drivers.

BR,
Jani.


-- 
Jani Nikula, Intel

