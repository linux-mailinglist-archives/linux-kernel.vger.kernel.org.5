Return-Path: <linux-kernel+bounces-56587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071B84CC17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94101F26747
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E07C099;
	Wed,  7 Feb 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFLxX2iN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F847A720;
	Wed,  7 Feb 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314097; cv=none; b=U52j58r950M4SSsBkDaYlxG2QlOf+eLCa+gq6vodpsmcQzS15Gs9GesOc0suWkrgvy92ifqqWqzn+aNqRrzwPge45LeHb8NCWk1Jb6Ku27mQP91kzZvY8nHoCylvLkol4oQmDWPpegeO8oXct1L1/vmUg8ng7QhaNSVgk4argEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314097; c=relaxed/simple;
	bh=ma6OUluhgadwtzGsBfD8CgNWmkQQVpB9KB1lAir5kFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fChRqnzg9mePHmqNwvIvuX1W/XwE07LFQ/GLNh99cfe+hbOc0ggKLeB8/BVNgbMgw97owPrvqiwZ68DRh8lKlZZ1CSYTmKstVBBesALqk3kRlG3QyLdchHYwPmqh4mgR1/b03aGAXKT9WVwymzwJZ/a8PVO4BOJTTefQad6KvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFLxX2iN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707314096; x=1738850096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ma6OUluhgadwtzGsBfD8CgNWmkQQVpB9KB1lAir5kFc=;
  b=aFLxX2iNPojpmZylOoaiou/UKn/vEXiPAe0ifZYyeVV3HUIBUSFNeCSY
   tfk9bZ2U1nswXwPDOEx90XHWJUAAyLtwaXo65wQUFUFhz7TWsh2HiVSJb
   A4+WIJdG4j6Zt0Q7wwiM/U2Ciyp3Pw797d1g73gcBdHYCpV7gWu32cbwS
   1+/FsFEzcGeOBRJlTHQaGVOcDRo8ZAN/vnE19KIGoFtvVoPP+novdqWN1
   EF2OenhDHIABaqtOJtHGElyK/CRexpesJZ20UfVB17MXuTM+ifGniSoHx
   OSDRGhnpkN6E4/yVKG1so4w+r1dRJ/VZIF1RcW8gOYmP/6mPLwf3VKPkG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12351389"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="12351389"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909998664"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="909998664"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:54:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXiO3-00000002ccd-0bPb;
	Wed, 07 Feb 2024 15:54:51 +0200
Date: Wed, 7 Feb 2024 15:54:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jesus Gonzalez <jesusmgh@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
References: <ZcIniuk0TMAIrHIB@smile.fi.intel.com>
 <20240206171132.35000-2-jesusmgh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206171132.35000-2-jesusmgh@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 06:11:33PM +0100, Jesus Gonzalez wrote:
> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
> probably others) in their ACPI table as the ID for the bmi160 IMU. This
> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
> to the user. Manufacturers have been approached on several occasions to
> try getting a BIOS with a fixed ID, mostly without actual positive
> results, and since affected devices are already a few years old, this is
> not expected to change. This patch enables using the bmi160_i2c driver for
> the bmi160 IMU on these devices.
> 
> Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
> model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
> with the argument of the device working with the Windows drivers.
> 
> 	Device (BMA2)
> 	{
> 	    Name (_ADR, Zero)  // _ADR: Address
> 	    Name (_HID, "10EC5280")  // _HID: Hardware ID
> 	    Name (_CID, "10EC5280")  // _CID: Compatible ID
> 	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> 	    Name (_UID, One)  // _UID: Unique ID
> 	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> 	    {
> 		Name (RBUF, ResourceTemplate ()
> 		{
> 		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
> 		        AddressingMode7Bit, "\\_SB.I2CC",
> 		        0x00, ResourceConsumer, , Exclusive,
> 		        )
> 		})
> 		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
> 	    }
> 	    
> 	    ...
> 	    
> 	}

..

> +/*
> + * FIRMWARE BUG WORKAROUND: ID "10EC5280"
> + * Some manufacturers like GPD, Lenovo or Aya used the incorrect
> + * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
> + * available as of Feb 2024 after trying to work with OEMs, and
> + * this is not expected to change anymore since at least some of
> + * the affected devices are from 2021/2022.
> + */

The location of the comment is wrong, it should be...

>  static const struct acpi_device_id bmi160_acpi_match[] = {

..here as you have had it previously. Just make sure it properly formed.

Maybe Jonathan can amend when applying, dunno.

> +	{"10EC5280", 0},
>  	{"BMI0160", 0},
>  	{ },

With the comment in the proper location,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



