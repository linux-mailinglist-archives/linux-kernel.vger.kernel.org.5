Return-Path: <linux-kernel+bounces-58717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293C84EA70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F779B2D60E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A704F1EA;
	Thu,  8 Feb 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKLhUvec"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464A4EB2B;
	Thu,  8 Feb 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427459; cv=none; b=Q4EdPhtX/CJbKWmGiqoocnuNDZe5K6ze1iOHLWbWpjQMHUBrjHdJXcrLsRkxICpXueNGlsZ8eONARQN1elPpOj9PH9DryTcgtuq5w1jAX53XeiM1RD1M9iu2WTjrr9f0DH3fWB9Nv3PwyKY9iHs/wdmdMwrST22K0awkBOmaYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427459; c=relaxed/simple;
	bh=frPdqqG1YKNdtIk5CAd6WN9XFfSGVfMUkf3tKpexX44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWMJMf/OEAWh4M6uCkTzGqxmlhWLx6untMM4Q4H5MSVJGTvl/wtpgt77yh/zIHx/0r6IwtF2SyF2zMgWDmViU6DtOvbWUcJvyRv93k6exwc9YqxQlXcLonfv6ukawiPkQcHbcCqxvp1/kFo8LSLKXCgmjBM7zjBtvDuUKJWMWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKLhUvec; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707427458; x=1738963458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frPdqqG1YKNdtIk5CAd6WN9XFfSGVfMUkf3tKpexX44=;
  b=QKLhUvec/FQpJBX6R323X91MIO2dviOko1FLedF/d5DKdfm0tOxuOEsW
   FQjKZd6gbzkNTJeb28Thjf8VxJ1KwK/BRTyvWyUlliRBOjsPDvqvEeUEK
   ePOnXuXfklV34vDBWvLcwZIemNuP8LIigdLaGi3b5iqEQknFkqE7n6A5y
   cGIyTgTl7+RjNG7S4bw/Ru3kee40IhjR4DVLABT3DtCOd2bi5vVA08+oY
   mPkn8cctJWLgzSXZnF/M6AFytpuCh0TYsSJJ7rdaR938ci8/ulzjw0NEy
   3G1T1SwfUSfd7h4XvyEy5KatcqxoQw6aXtqYBumGFjC9qHEZYN1VE+PzR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5115478"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="5115478"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:24:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1744220"
Received: from millermi-mobl1.amr.corp.intel.com (HELO [10.255.229.182]) ([10.255.229.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:24:16 -0800
Message-ID: <b1a8dbe8-a5c1-4462-993e-ba0888c5b23c@linux.intel.com>
Date: Thu, 8 Feb 2024 13:24:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Make input buffer madatory when
 evaulating methods
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207202012.3506-1-W_Armin@gmx.de>
 <6360f90f-1aca-4355-aa19-661c2925dd24@linux.intel.com>
 <d82f47fa-a126-4242-b4c3-83ba2c37fd95@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d82f47fa-a126-4242-b4c3-83ba2c37fd95@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/8/24 10:22 AM, Armin Wolf wrote:
> Am 08.02.24 um 03:41 schrieb Kuppuswamy Sathyanarayanan:
>
>> On 2/7/24 12:20 PM, Armin Wolf wrote:
>>> The ACPI-WMI specification declares that a WMxx control method takes
>>> 3 arguments: instance, method id and argument buffer. This is also
>>> the case even when the underlying WMI method does not have any
>>> input arguments.
>> It would be better if you include specification version and section
>> title for reference.
>
> The ACPI-WMI specification is not part of the ACPI specification. It
> consists of a single whitepaper published by Microsoft:
>
> https://github.com/microsoft/Windows-driver-samples/blob/main/wmi/wmiacpi/wmi-acpi.htm
>
> The section describing the ACPI control methods is called
> "ACPI Control Method Naming Conventions and Functionality for Windows 2000 Instrumentation".
>
> I do not thing that mentioning this in the commit message would be of any use.

I think it is better to include this detail. But, since it is not a standard specification,
I will let maintainer make this call.

>
>>> So if a WMI driver evaluates a WMI method without passing an input
>>> buffer, ACPICA will log a warning complaining that the third argument
>>> is missing.
>> I assume it is a compile warning. Can you copy the warning message?
>
> Its not a compiler warning.
>
> The ACPI control method is being evaluated at runtime, so the warning message
> will also be generated at runtime (when interpreting the AML bytecode).
>

Got it.

> Thanks,
> Armin Wolf
>
>>> Prevent this by checking that a input buffer was passed, and return
>>> an error if this was not the case.
>>>
>>> Tested on a Asus PRIME B650-Plus.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>
>> With above fixed,
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>>>   drivers/platform/x86/wmi.c | 21 ++++++++++-----------
>>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>>> index 63906fdd0abf..f9e23d491dd9 100644
>>> --- a/drivers/platform/x86/wmi.c
>>> +++ b/drivers/platform/x86/wmi.c
>>> @@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(wmidev_instance_count);
>>>    * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>>>    * @instance: Instance index
>>>    * @method_id: Method ID to call
>>> - * @in: Buffer containing input for the method call
>>> + * @in: Mandatory buffer containing input for the method call
>>>    * @out: Empty buffer to return the method results
>>>    *
>>>    * Call an ACPI-WMI method, the caller must free @out.
>>> @@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
>>>    * @wdev: A wmi bus device from a driver
>>>    * @instance: Instance index
>>>    * @method_id: Method ID to call
>>> - * @in: Buffer containing input for the method call
>>> + * @in: Mandatory buffer containing input for the method call
>>>    * @out: Empty buffer to return the method results
>>>    *
>>>    * Call an ACPI-WMI method, the caller must free @out.
>>> @@ -347,26 +347,25 @@ acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, u32 met
>>>       block = &wblock->gblock;
>>>       handle = wblock->acpi_device->handle;
>>>
>>> +    if (!in)
>>> +        return AE_BAD_DATA;
>>> +
>>>       if (!(block->flags & ACPI_WMI_METHOD))
>>>           return AE_BAD_DATA;
>>>
>>>       if (block->instance_count <= instance)
>>>           return AE_BAD_PARAMETER;
>>>
>>> -    input.count = 2;
>>> +    input.count = 3;
>>>       input.pointer = params;
>>> +
>>>       params[0].type = ACPI_TYPE_INTEGER;
>>>       params[0].integer.value = instance;
>>>       params[1].type = ACPI_TYPE_INTEGER;
>>>       params[1].integer.value = method_id;
>>> -
>>> -    if (in) {
>>> -        input.count = 3;
>>> -
>>> -        params[2].type = get_param_acpi_type(wblock);
>>> -        params[2].buffer.length = in->length;
>>> -        params[2].buffer.pointer = in->pointer;
>>> -    }
>>> +    params[2].type = get_param_acpi_type(wblock);
>>> +    params[2].buffer.length = in->length;
>>> +    params[2].buffer.pointer = in->pointer;
>>>
>>>       get_acpi_method_name(wblock, 'M', method);
>>>
>>> -- 
>>> 2.39.2
>>>
>>>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


