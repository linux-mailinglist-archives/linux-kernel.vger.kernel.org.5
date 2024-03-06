Return-Path: <linux-kernel+bounces-93735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714818733EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D18D28E7F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668995FBBF;
	Wed,  6 Mar 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fd3Y3to5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14795F861;
	Wed,  6 Mar 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720378; cv=none; b=ajk9kCrVxeG0Pl3DCOEa2z/62jeiOTPHCa3rCiIzrjH5wS9a/EuWzxPcXOtnDEeRsKdlRek9xCeN2N6HePH+ztjhNPGODRdiF8sspVDtuNhAHaLdljIi7ZM9/Nz1VtqpyRVCOBklQ4xBtagtncwoQu6QZRYUVR/uc/FaH4jRiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720378; c=relaxed/simple;
	bh=iJyCSdmI3E/9sHsRKQ+LNQH2aEW+pw+M2g+wGJ3g80k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WDjked7B+s+MQYyc/HgkbEOqPl9mWUe5YHBuMeTlKSDiZJGLeIEYrhJHjYRdmNXS/O5mcdOQINOKZLyB280HcMv4Kf6eqQeWa/sra5Iq7apjeEYGVMIu8uj/2XLR81qS+3JaBbnVY9nN2BvEZ0hU1vL/NoKwPhxxmSrLnZougTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fd3Y3to5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709720377; x=1741256377;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iJyCSdmI3E/9sHsRKQ+LNQH2aEW+pw+M2g+wGJ3g80k=;
  b=fd3Y3to5Hr2lfywO5vbUV2314jvjlaWpCEHe8e4Z6rIQuIJW3rplhWCk
   t2mnbUq6u8dCP8/sjnJVLp/yvSM1zCu6YJnfjTpAZjzbGVwY9EG/rFwHR
   aq8oPiRJd76hsIq5uM4hxfTFVEio+I7STFb/ypbIlujKZz1HyYI7mGShD
   vGr95MggJ684+bSwn8jNB0MG0PbVpx3cslwQh7WN0AC0iNYYYf1NgBTsc
   +UlPh11LfpddWMwAKjKflBK85cF8jT+mbcDEYVaS5OfipwcOiLpnw3jqG
   Em9RTBBlBs0sz2mGFYN6GP62gsTzk1KB+b/a9kKksRKPUCsHFTw/yiENa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14974856"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14974856"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:19:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14368247"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:19:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 12:19:30 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: wmi: Support reading/writing 16 bit
 EC values
In-Reply-To: <20240304221732.39272-1-W_Armin@gmx.de>
Message-ID: <ffb87c8f-3d6d-c96c-71e9-2abccfe68405@linux.intel.com>
References: <20240304221732.39272-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Mar 2024, Armin Wolf wrote:

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
>  drivers/platform/x86/wmi.c | 44 +++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1920e115da89..900e0e52a5fa 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1153,6 +1153,32 @@ static int parse_wdg(struct device *wmi_bus_dev, struct platform_device *pdev)
>  	return 0;
>  }
> 
> +static int ec_read_multiple(u8 address, u8 *buffer, size_t bytes)
> +{
> +	int i, ret;
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
> +	int i, ret;
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
> @@ -1162,27 +1188,25 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / 8;

I'm a quite hesitant about this. IMO, it should do DIV_ROUND_UP(bits, 
BITS_PER_BYTE) or return AE_BAD_PARAMETER when bits is not divisable by 8. 
And if you choose the round up approach, I'm not sure what the write 
should do with the excess bits.

In any case, 8 -> BITS_PER_BYTE.

> +	int ret;
> 
> -	if ((address > 0xFF) || !value)
> +	if (address > 0xFF || !value)

This should takes bytes into account to not overflow the u8 address?

-- 
 i.


