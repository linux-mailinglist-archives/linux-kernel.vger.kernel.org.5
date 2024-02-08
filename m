Return-Path: <linux-kernel+bounces-57397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F084D7EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3350428732A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977691B270;
	Thu,  8 Feb 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iz9FvQbI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A801D525;
	Thu,  8 Feb 2024 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360122; cv=none; b=M6DyiLkOuvoQl2WW2APJb4ZbuG4mOZ5BEWP2c6OVe0xReV6Z09d0PhIo4adGoUoutPEuLVVLxAU3aComrGFaxiNC0AyNKYrBd9Rl+d4RPWUI0qnOstMZBlbrtgGlJz07aZ3pPHEDI58aULIM9ixUGcmTomkA5C/wYB8OZoGqV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360122; c=relaxed/simple;
	bh=HnZVKRgWjaJGnqnfgwePaLGo0wMeQdaMpS2Wqgm09sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFMY2wAvktR1PRcofeiYoAPpXxb9JkYGCgbSSzNuwIQR+BU2dEbcvGQBjZwl9ajoizkBiCZaMWoHAIx1dyjvTZDwJXeY8rN/HIQjaFtlHVx/nnGde3dVeUeM6d3yWOPhLV/jzHoiDwczpccxuPoeeC83u+mNYDUm0zroSoBeSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iz9FvQbI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707360121; x=1738896121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnZVKRgWjaJGnqnfgwePaLGo0wMeQdaMpS2Wqgm09sM=;
  b=iz9FvQbIvO1v+Z4jvNbhj7/jLg6SA9AOUloAhsv1P7MuoDc7a5Ud8lv1
   z9FpwKjxyxqb+b15QNnZiTgtYANFfDlfeQgjGmCVJIAvUKbwKOXZhJ9dk
   XZNRHtFrwPhKyAV1iil2/m4BcRU0x7Wqx/lLUjCt9JAquOK547LLtXQI5
   AcNdjcAdHjEO7Bb/sPDtNeYZJM6jv9mvXQGLFpW4/irs4M6meTLggRRh1
   YNACwsVbvXUAiwo8voHJD4Y2ep5uAPdHbB6fFT0M47MwuMWYPCVKh5Lwz
   qxS3YLVy4+5p+ynXBQgyFAy079Qjz+VKr0YMjANYA8NSSy9VwMGk9wxDT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12487390"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12487390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 18:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6178279"
Received: from srussjr-mobl1.amr.corp.intel.com (HELO [10.209.91.249]) ([10.209.91.249])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 18:42:00 -0800
Message-ID: <6360f90f-1aca-4355-aa19-661c2925dd24@linux.intel.com>
Date: Wed, 7 Feb 2024 18:41:59 -0800
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
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240207202012.3506-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/24 12:20 PM, Armin Wolf wrote:
> The ACPI-WMI specification declares that a WMxx control method takes
> 3 arguments: instance, method id and argument buffer. This is also
> the case even when the underlying WMI method does not have any
> input arguments.

It would be better if you include specification version and section
title for reference.

>
> So if a WMI driver evaluates a WMI method without passing an input
> buffer, ACPICA will log a warning complaining that the third argument
> is missing.

I assume it is a compile warning. Can you copy the warning message?

>
> Prevent this by checking that a input buffer was passed, and return
> an error if this was not the case.
>
> Tested on a Asus PRIME B650-Plus.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---


With above fixed,

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/wmi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 63906fdd0abf..f9e23d491dd9 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(wmidev_instance_count);
>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>   * @instance: Instance index
>   * @method_id: Method ID to call
> - * @in: Buffer containing input for the method call
> + * @in: Mandatory buffer containing input for the method call
>   * @out: Empty buffer to return the method results
>   *
>   * Call an ACPI-WMI method, the caller must free @out.
> @@ -326,7 +326,7 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
>   * @wdev: A wmi bus device from a driver
>   * @instance: Instance index
>   * @method_id: Method ID to call
> - * @in: Buffer containing input for the method call
> + * @in: Mandatory buffer containing input for the method call
>   * @out: Empty buffer to return the method results
>   *
>   * Call an ACPI-WMI method, the caller must free @out.
> @@ -347,26 +347,25 @@ acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, u32 met
>  	block = &wblock->gblock;
>  	handle = wblock->acpi_device->handle;
>
> +	if (!in)
> +		return AE_BAD_DATA;
> +
>  	if (!(block->flags & ACPI_WMI_METHOD))
>  		return AE_BAD_DATA;
>
>  	if (block->instance_count <= instance)
>  		return AE_BAD_PARAMETER;
>
> -	input.count = 2;
> +	input.count = 3;
>  	input.pointer = params;
> +
>  	params[0].type = ACPI_TYPE_INTEGER;
>  	params[0].integer.value = instance;
>  	params[1].type = ACPI_TYPE_INTEGER;
>  	params[1].integer.value = method_id;
> -
> -	if (in) {
> -		input.count = 3;
> -
> -		params[2].type = get_param_acpi_type(wblock);
> -		params[2].buffer.length = in->length;
> -		params[2].buffer.pointer = in->pointer;
> -	}
> +	params[2].type = get_param_acpi_type(wblock);
> +	params[2].buffer.length = in->length;
> +	params[2].buffer.pointer = in->pointer;
>
>  	get_acpi_method_name(wblock, 'M', method);
>
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


