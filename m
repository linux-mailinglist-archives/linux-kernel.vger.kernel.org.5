Return-Path: <linux-kernel+bounces-77826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277C860AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666681F24165
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A23125D8;
	Fri, 23 Feb 2024 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDsMzDui"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF0125B0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669097; cv=none; b=K+NIhJrifQIKmpbuGMfX3Y27McYt0PAvMRuxq5sr5Bdeu55I132C5GxOLCPuV7gQCjowetbLNgbzaS+nwQdSUw7wC3rms7//nQKEkwy2pug1M8ixq0fR/TdN2Y07wJqt3xUYomzqacm3nhyLT1BRTeXXIkHsyxTODKmFOhkmZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669097; c=relaxed/simple;
	bh=rcRL6AOPBimFSOc2Z5A6BnhXyMYPvmWbtsmG0omtUnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz2XrFeKGK+kCLMYaW0GOmkZTf8KmIK0130lma3F/3V5lGu4+R8WM4FufZQKBifnDSfVdP3foS6qtP63H3f3qOUb/otL5FQo3W/tcRAQqSwH2HzyOkDiqpvSQl5GHsGHcHvWTnGXzcsZ/VWh+PBK58E3KuAjjGPfQJ7qeAsJ5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDsMzDui; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708669095; x=1740205095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rcRL6AOPBimFSOc2Z5A6BnhXyMYPvmWbtsmG0omtUnE=;
  b=UDsMzDuiIifmvcpYNTjzKUlSLeiOnEGxPYXY/ie9PM2lXI3riMPam3Jl
   FdUr1MYnbk5DgqiB7J0PgCe8BhTz8qONm6L7FRknyor70JFP1dAcwBi+u
   ECdWkloEywDl4ZAl2F9U07tgua6g4FHPYV9uXTqcqrYFrS71iHIxZhyw2
   KmJb5ORy6awGhnBaOLWirqihnjGBi5Nnu1fNqLaKwEAiR/RqXscV14QEs
   1QZvQS/G9LCBks91sJISdnW/l6djfEGOjFeDHfliLREObr5B1vVc29yWt
   tnK+ttXeRjNpMq/x7yI829VDI3pckyN9dzV1TnwSxZwAF8rWgKP19c5YZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2839995"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2839995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 22:18:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913729166"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913729166"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 22:18:13 -0800
Message-ID: <58da7bcd-ed88-42a4-be28-f3ae0723c5f7@linux.intel.com>
Date: Thu, 22 Feb 2024 22:18:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <65d831adaf58c_2509b2943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <65d831adaf58c_2509b2943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/22/24 9:48 PM, Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
>> During the TDX guest attestation process, TSM ConfigFS ABI is used by
>> the user attestation agent to get the signed VM measurement data (a.k.a
>> Quote), which can be used by a remote verifier to validate the
>> trustworthiness of the guest. When a user requests for the Quote data
>> via the ConfigFS ABI, the TDX Quote generation handler
>> (tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
>> and then shares the output with the user.
>>
>> Currently, when handling the Quote generation request, tdx_report_new()
>> handler only checks whether the VMM successfully processed the request
>> and if it is true it returns success and shares the output to the user
>> without actually validating the output data. Since the VMM can return
>> error even after processing the Quote request, always returning success
>> for the processed requests is incorrect and will create confusion to
>> the user. Although for the failed request, output buffer length will
>> be zero and can also be used by the user to identify the failure case,
>> it will be more clear to return error for all failed cases.
> This is a lot of text. More is not necessarily better.
>
> ---
> The tdx-guest driver marshals requests via hypercall to have a quoting
> enclave sign attestation evidence about the current state of the TD.
> There are 2 possible failures, a transport failure (failure to
> communicate with the quoting agent) and payload failure (a failed
> quote). The driver only checks the former, update it to consider the
> latter payload errors as well.
> ---

Looks better. I will use it in next version.

>
>
>> Validate the Quote data output status and return error code for all
>> failed cases.
>>
>> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
>> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>>  * Updated the commit log (Kirill)
>>
>>  drivers/virt/coco/tdx-guest/tdx-guest.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> index 1253bf76b570..61368318fa39 100644
>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> @@ -228,6 +228,12 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>>  		goto done;
>>  	}
>>  
>> +	if (quote_buf->status != GET_QUOTE_SUCCESS) {
>> +		pr_err("GetQuote request failed, ret %llx\n", quote_buf->status);
> Do you really want to spam the log on every error? I would expect
> pr_err() for events that are fatal to driver operation that might
> indicate conditions where maybe the TD should give up on the host.
>
> Yes, there are other pr_err() in this function and I am kicking myself
> for not scrutinizing those more closely. It is likely enough to
> distinguish transport errors vs payload / quote errors with ENXIO and
> EIO.
>
> Otherwise if there is an exceedingly good reason to keep this driver
> chirping into the kernel log then these likely also want to be
> rate-limited. If they are "just in case" debug messages, then move them
> to pr_debug().

Ok. Makes sense. I will convert it into a pr_debug.

I will submit a separate patch to fix other pr_err usage in this driver.
Expect Quote timeout, the rest of the failure does not affect the
usage of the driver.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


