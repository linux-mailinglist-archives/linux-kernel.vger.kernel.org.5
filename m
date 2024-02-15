Return-Path: <linux-kernel+bounces-67661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76687856EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180AC1F27C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002913B28B;
	Thu, 15 Feb 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHmBjrL6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BE1386A2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708029652; cv=none; b=VS//HnA54jF8dwz5fkNpMc59Z1sGTMTSAIrGSwJ130qg6QD6u47xzekt7XCTaQJCoLw+oa2AcKoymIXkPOfbyJOIj+NtqVwyEwYBXc0xBO187DtlcM171sgX+xDSQYBfzQe4FH6CZAMU4Rp5TQDS8pwK6u3HUXArggtP3HJW6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708029652; c=relaxed/simple;
	bh=RNbgm2PSnyK3LVzCwTFXtsWgZ5d1/ZKQNi1RrhGFaSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9E01QJBFma3c71jyypoHvLgmv48wMEungmp5Hav85FZIMGqgYVHCnxl1kaW1hMQO+MYEkLgl2FDF2cVvfuVuUkFBTW4MI5nj2RaStfJe9bVpbosomr9vpwdYR3frUaSnNVK9oFVpb48KLjvnc6apvUxMhzY/WATRNLq4LDrODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHmBjrL6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708029651; x=1739565651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RNbgm2PSnyK3LVzCwTFXtsWgZ5d1/ZKQNi1RrhGFaSM=;
  b=VHmBjrL6QVsFhJ/vhxyGS+4Godmmiq/RhIBZgF4dfLZITbEJcIn8pnxW
   cfhPuUPWoM05t+efVgitwStl3+tj2jBNqJ20N3f6e2l3atK2X8a7yjn9w
   VQ54l0qE3t6ai1xSmGoDVmzUE8AKWF85Uup4k0XcGsYFxxRpz/1hWIWoA
   b5nB5et3auhR12NcN8uTXt2Z+rK+r40RsuceRZQGY/J4AM79+Dqlsx6JN
   zzjazI6kW3AaQaKTCvtqSe/yaAOYVrZQm6gFYZQ/o4iG7GHo5fk8WSFaU
   TtRFEc4uBG8LJ4IT9ccMuWRrEWom/O4FySDxqbtSG9PvIuw0S3glcBXAz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5927781"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5927781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 12:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3733053"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 15 Feb 2024 12:40:43 -0800
Received: from [10.249.139.11] (mwajdecz-MOBL.ger.corp.intel.com [10.249.139.11])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2F98F2818D;
	Thu, 15 Feb 2024 20:40:41 +0000 (GMT)
Message-ID: <a6652e88-c66f-44d5-93a4-be9fa7a4623d@intel.com>
Date: Thu, 15 Feb 2024 21:40:40 +0100
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
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <202402141408.0E78D47@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2024 23:09, Kees Cook wrote:
> On Wed, Feb 14, 2024 at 10:46:53PM +0100, Michal Wajdeczko wrote:
>> It is quite common practice to make u16, u32 or u64 values from
>> smaller words.  Add simple helpers for that.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> ---
>> v2: new macro names due to conflict with crypto/aria.h
>>     explicit cast and truncation everywhere (Alexey)
>>     moved to wordpart.h (Andy)
>> ---
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
>> index f6f8f83b15b0..8c75a5355112 100644
>> --- a/include/linux/wordpart.h
>> +++ b/include/linux/wordpart.h
>> @@ -31,6 +31,38 @@
>>   */
>>  #define lower_16_bits(n) ((u16)((n) & 0xffff))
>>  
>> +/**
>> + * make_u16_from_u8 - make u16 value from two u8 values
>> + * @hi: value representing upper 8 bits
>> + * @lo: value representing lower 8 bits
>> + */
>> +#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))
> 
> Do we want to actually do type validation here? Right now it's just
> cast/truncating, which based on the version log is by design. Is silent
> truncation the right thing to do?

note that even FIELD_PREP() is doing silent truncation and these macros
here could be treated as specialized/simplified variants of FIELD_PREP()
as alternate implementation can look like:

#define make_u16_from_u8(hi, lo) \
	((u16)(FIELD_PREP_CONST(GENMASK(15, 8), (hi)) | \
	       FIELD_PREP_CONST(GENMASK(7, 0), (lo))))

#define make_u32_from_u16(hi, lo) \
	((u32)(FIELD_PREP_CONST(GENMASK(31, 16), (hi)) | \
	       FIELD_PREP_CONST(GENMASK(15, 0), (lo))))

#define make_u64_from_u32(hi, lo) \
	((u64)(FIELD_PREP_CONST(GENMASK_ULL(63, 32), (hi)) | \
	       FIELD_PREP_CONST(GENMASK_ULL(31, 0), (lo))))

but then it will not match simplicity of the lower|upper_XX_bits macros


