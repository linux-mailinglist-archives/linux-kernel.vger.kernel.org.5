Return-Path: <linux-kernel+bounces-103705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68387C331
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14442885EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50BC762E5;
	Thu, 14 Mar 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co4/9v+M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513774E39;
	Thu, 14 Mar 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442614; cv=none; b=OAzDH2Y/FyWJlEqFHwAFQjE3N13yAaX6Rib/oIOOEekNioWvBTshXnehNCE7r/a8hAJ/alNumuvI89auMJodIX7iJ3VmyuERwPAJozD1zhYcF5tnlTxC3ickw/pfGX4931vl+RW6NWHh8wTnYBGEXSaz+kTzvd9JEMXaHbEpnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442614; c=relaxed/simple;
	bh=vbdumEA8i1vHquFSQh0G9ie0UpZsWtmjCxra+Osqsgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGnYUqrhXTLmCtsqfHpTA8yeOISkmPl037wRYzHJNShClLqipJBJvO1aFP8f+PSOB4vpS5zfRh1os/8WFR1Ite6w/MhyGGvta8yJ20fLciKNkli+BYw0ZD3zaelgJs1g1LbVwokQGL28AbQfzFiKFJSOZi/J2JEafRShIU2/VdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co4/9v+M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710442612; x=1741978612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vbdumEA8i1vHquFSQh0G9ie0UpZsWtmjCxra+Osqsgs=;
  b=Co4/9v+M8+QoRr8tyIcskty2er+P7qlYkzPVfmCadiVTDazk1wA60/LI
   5SPtOH4LQIMPxWcMwngJeB9SOj++m+xyUaIQwlexM8dejHAggM3U+F36q
   XPNDhIauo9wbSsPhbELZUxYRM5KIHydzZhwXlX4E9EX1J5/I7pLGEVIaJ
   CgsY4csaUXMtZnElHK+XmvNTpmJQyvXB43KKhpLSGyFs7m1Pk2e4dYXtE
   iyL8y7wsCy5QzWcGbCDXayF7/k0ROu3F4KLrO6N7Ai6jdU1tqzTR67xJd
   EqpbeN62QslkuzkvkQ7M/dYvNt08cazRcfqIlB1cQgHUtxAW1Aedu8/8c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="8224369"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="8224369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 11:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16865490"
Received: from jtang15-mobl.amr.corp.intel.com (HELO [10.212.137.58]) ([10.212.137.58])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 11:56:51 -0700
Message-ID: <887d0674-9531-417a-8eca-ecd86c528c29@linux.intel.com>
Date: Thu, 14 Mar 2024 11:56:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240314184538.2933-1-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240314184538.2933-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/14/24 11:45 AM, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is perfectly legal
> according to the ACPI spec.
>
> Add support for reading/writing such values.
>
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Chnages since v4:
> - spelling fix
> - fix checkpatch warning
>
> Changes since v3:
> - change type of variable i to size_t
>
> Changes since v2:
> - fix address overflow check
>
> Changes since v1:
> - use BITS_PER_BYTE
> - validate that number of bytes to read/write does not overflow the
>   address
> ---
>  drivers/platform/x86/wmi.c | 54 +++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..9602658711cf 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,34 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	return 0;
>  }
>
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_read(address + i, &buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ec_write_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	size_t i;
> +	int ret;
> +
> +	for (i = 0; i < bytes; i++) {
> +		ret = ec_write(address + i, buffer[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * WMI can have EmbeddedControl access regions. In which case, we just want to
>   * hand these off to the EC driver.
> @@ -1162,27 +1190,27 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
>
> -	if ((address > 0xFF) || !value)
> +	if (!value)
> +		return AE_NULL_ENTRY;
> +
> +	if (!bytes || bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
>
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>  		return AE_BAD_PARAMETER;
>
> -	if (bits != 8)
> +	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
>
> -	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> -	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> -	}
> +	if (function == ACPI_READ)
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
> +	else
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
>
> -	switch (result) {
> +	switch (ret) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
>  	case -ENODEV:
> --
> 2.39.2
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


