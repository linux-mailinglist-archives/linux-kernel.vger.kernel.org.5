Return-Path: <linux-kernel+bounces-98333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5410F87788A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74828145A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACE3A29E;
	Sun, 10 Mar 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dd16Y25g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8651E502;
	Sun, 10 Mar 2024 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710104244; cv=none; b=DoIUiiraFnQjL+kieM5Uz9K6PAHWcF1fnWSsdVG+TgMeP9hV9YQ5OukUWoTg79ywkRuht+GnnzNZ8cF/n3VbywPc/NhBRWetDdqLsEMcPXJV5H+JhVQmOpLdtEHIVuNYqjlPNQ+AwRC5uWNGdkuXZoLPeRz6rkpg+XBLMORLl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710104244; c=relaxed/simple;
	bh=m/OvAdgkzvKcDTlmlp/NmzDaiiBJqqOm3dJ9tQ1F92k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv/8j6xHIQNOO5F4BzGKt0RyhA0BV2rsL858Yw8P6pBHEdQoVzLw+gTs87cptsmnLH4PiYRc8tpzU++1E6jgCUM8MO/+UnFjIbm3F1A+ejNrf5pQiBsRBRViyevEc+hR45s+ICzAQbf08UMI2H0iqC/ckM3pGt1Qe8W0xJK4PG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dd16Y25g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710104243; x=1741640243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/OvAdgkzvKcDTlmlp/NmzDaiiBJqqOm3dJ9tQ1F92k=;
  b=Dd16Y25gzOt5xbPoM3jkGpdIKU++FDpHgTclu3vmwmVVUMAON4a7KJrM
   /l8Z4Rjcxq9HLtYTaiAGTPI07FPoywV2E6LGsfYzzy3nKMKT5+oSC6LKQ
   KAqI6X0uX10D2uoHpSS1uH8Hnb2sOFn4n/QyuShkGYkb/azzM6hWbXwGJ
   XjRQI99/co91VXRGZE2rmCxSYQwAx2qKHXSOEqbpvcRTOGI9t+aNt0eit
   9t37XUJSH7qH+hnBv6ui9zHkZbmKTIGjzgRLtOp1GZ8k4/zs2ncMkEb5R
   QgzuxyWAQhiJDSL529TeQIjv4JpMSDBbR/q0rUEAUqy0tzmT2alT8dWzd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="16191457"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="16191457"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 13:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="15469051"
Received: from rniessen-mobl.amr.corp.intel.com (HELO [10.209.61.201]) ([10.209.61.201])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 13:57:21 -0700
Message-ID: <769f8b03-b9c4-4d41-b534-545cd080f47b@linux.intel.com>
Date: Sun, 10 Mar 2024 13:57:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] platform/x86: wmi: Avoid returning AE_OK upon
 unknown error
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240308210519.2986-1-W_Armin@gmx.de>
 <20240308210519.2986-2-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240308210519.2986-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/8/24 1:05 PM, Armin Wolf wrote:
> If an error code other than EINVAL, ENODEV or ETIME is returned
> by ec_read()/ec_write(), then AE_OK is wrongly returned.
>
> Fix this by only returning AE_OK if the return code is 0, and
> return AE_ERROR otherwise.
>
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/wmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index d9bf6d452b3a..84d1ccf6bc14 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1218,8 +1218,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  		return AE_NOT_FOUND;
>  	case -ETIME:
>  		return AE_TIME;
> -	default:
> +	case 0:
>  		return AE_OK;
> +	default:
> +		return AE_ERROR;
>  	}
>  }
>
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


