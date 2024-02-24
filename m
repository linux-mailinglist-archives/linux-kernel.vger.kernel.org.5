Return-Path: <linux-kernel+bounces-79336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8A8620F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260F0B24629
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980FEEC7;
	Sat, 24 Feb 2024 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmeF/pYS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD639B;
	Sat, 24 Feb 2024 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733168; cv=none; b=pZ1Eeayq81NumfN+/s2LFhX7DoqZY82TcJ1Q7hhN7yTWD6it9nqVbyMeb1OSr2oFJ8wYTHXY+UmcxU9rSGQd8EzL6vGB+FAWz83bchY5qEgpOGDc1vjIEWqAWF7+bTTOBJJ3Xk20F0Mlmg8ccwkS4fUmS6L6XE7aGlHAFk0Evro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733168; c=relaxed/simple;
	bh=mGMFhkEAVEATSeecAUb5ND2N8AhgPWE+Gj/9u1cOHVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVACRgAKJlu9rawCmCIySqRSfAzAuslGzWHOkV/4EPhwqEJoecjFy09VFiQXmzDotw8LVuCr8VdIIfw5xfC1FZ1x0D4UhJTwlKdfsoeSzezDcKY+PfKxD/sv1L3tq2intq+7PVwHLdP077fVHDOFkFEBcHfXA9eA8T7o92IxOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmeF/pYS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708733165; x=1740269165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mGMFhkEAVEATSeecAUb5ND2N8AhgPWE+Gj/9u1cOHVU=;
  b=RmeF/pYSOMAMvc2DYVoelEd/CdMtkDFLgU+GPf9+xtccCaUJkiT8jpEn
   YTwaoSBxLvv8AAcumiTk9qN1XQb7853n0tSldrYNDjomdfUhC1l/sm7PW
   z3QcrMqaGI5vZpRFXieOZm77pojCiTUpOdtmkHBdt/5y7OjRKilyPqXod
   HWYy30iPZrWB3Fz9iQwwmdMhult43FcZLi78OnucFQM6iUu1ij8QAoiSg
   cv3BpldnDHkcyZjm+O0cfcHCNoSZmPAYyh/jt6oDQ1fCztz7A8jxe3mzj
   I8x17tEG6GsLWihqN0O0aQrv4Sa3BIXmzGNCNBl6DWpOdVASPFiqQuovZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3590764"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3590764"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 16:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6066855"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.115.84]) ([10.246.115.84])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 16:06:02 -0800
Message-ID: <4cafe9e0-1a08-4574-aa0d-5070b67f8cf3@intel.com>
Date: Fri, 23 Feb 2024 17:06:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: constify the struct device_type usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240219-device_cleanup-dax-v1-1-6b319ee89dc2@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240219-device_cleanup-dax-v1-1-6b319ee89dc2@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 5:47 AM, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> dax_mapping_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..e265ba019785 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -763,7 +763,7 @@ static const struct attribute_group *dax_mapping_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static struct device_type dax_mapping_type = {
> +static const struct device_type dax_mapping_type = {
>  	.release = dax_mapping_release,
>  	.groups = dax_mapping_attribute_groups,
>  };
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240219-device_cleanup-dax-d82fd0c67ffd
> 
> Best regards,

