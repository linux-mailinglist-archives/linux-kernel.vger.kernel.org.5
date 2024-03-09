Return-Path: <linux-kernel+bounces-97961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3A877264
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272AE1F2153C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AB20B12;
	Sat,  9 Mar 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQSCTd+e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D215BE;
	Sat,  9 Mar 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710004053; cv=none; b=TZdeSTHm6ca0cuja0ZB48701gAomZlULeQwny2ZOVff94hzvUaPOzyFwLVEaCHx5pRuoIthn22SI63/AX5xCtgOk6FWZxHKm51SbMF1Cm+4nz3Yb7pxBor6AJu9C4cmzq68apvUQtwFBnw3q9ZsVQ4NpotlEN+Vl45keVQYtKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710004053; c=relaxed/simple;
	bh=3E7oqw6/EdZcH3vXneiO51C/GvwyGjp97u7WZeIrrgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGtSwcco9AMsA/yDEP7DgfcvZenZ9jCf0UqSTASz99C3tGRN8TQLPgI/wVjuiT5dQZTsnXdxAZJ4I9C2TVM745X3Gb/PrG9SbgiJsEnsczcw+SdMxjHyG/X/WF9z+cjqJ6pMSVoXr8Xa47l+y4NdChYHRy486odB3qZDtMyAdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQSCTd+e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710004052; x=1741540052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3E7oqw6/EdZcH3vXneiO51C/GvwyGjp97u7WZeIrrgU=;
  b=mQSCTd+ejzXcZ8DDIA8Sr//zJQPABU5hqOWqj4A+TpkqYAmOFAF80zbH
   bz2XXM/xDQrAs8MB245rBuwRPX3h8H0ZLom5PbAfC3QeqLMplDcXZWSUx
   3V1hIXXkdXhbMwBBCf78Tj3X+dOZOggr13wX99NRBFl6QibyUs/eHrPpL
   vsjNbpyUzWS8ehKAlJVBzXhC8L5TxQnusJr4wiZos06cyWCqQ7qK/tgkk
   zszomEUoSvkVZcuQtmA/f/jP5Et6bGkBGUP0+eg1C5zjW21ICeJwUgNT5
   7JyabnAbqmK+vqktBoy20xvFYgcVV+a04Du9vFfsWL2Mg7ZZqpfjEnozS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="8531413"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="8531413"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 09:07:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="15409298"
Received: from chengyin-mobl.amr.corp.intel.com (HELO [10.209.27.224]) ([10.209.27.224])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 09:07:30 -0800
Message-ID: <a6152da8-5f3a-458b-bc48-4bc654677ece@linux.intel.com>
Date: Sat, 9 Mar 2024 09:07:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240308210519.2986-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/8/24 1:05 PM, Armin Wolf wrote:
> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is prefectly legal
> according to the ACPI spec.
>
> Add support for reading/writing such values.
>
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
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
>  drivers/platform/x86/wmi.c | 49 ++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..d9bf6d452b3a 100644
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

Why not use ec_transaction?

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

Same as above.
> +
>  /*
>   * WMI can have EmbeddedControl access regions. In which case, we just want to
>   * hand these off to the EC driver.
> @@ -1162,27 +1190,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
> +
> +	if (!value)
> +		return AE_NULL_ENTRY;
>
> -	if ((address > 0xFF) || !value)
> +	if (!bytes || bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
>
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes - 1 > U8_MAX)
>  		return AE_BAD_PARAMETER;
>
> -	if (bits != 8)

Since you want to support only 16 bit reads/writes, can you check for >16

> +	if (function != ACPI_READ && function != ACPI_WRITE)
>  		return AE_BAD_PARAMETER;
>
>  	if (function == ACPI_READ) {
> -		result = ec_read(address, &temp);
> -		*value = temp;
> +		ret = ec_read_multiple(address, (u8 *)value, bytes);
>  	} else {
> -		temp = 0xff & *value;
> -		result = ec_write(address, temp);
> +		ret = ec_write_multiple(address, (u8 *)value, bytes);
>  	}
>
> -	switch (result) {
> +	switch (ret) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
>  	case -ENODEV:
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


