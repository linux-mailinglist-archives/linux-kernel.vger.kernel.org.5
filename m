Return-Path: <linux-kernel+bounces-54958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DC84B562
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B71F22A40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95112F384;
	Tue,  6 Feb 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqPkU7hW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD412EBF0;
	Tue,  6 Feb 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222929; cv=none; b=nQoqiDGFblxh+aWuWeLE0Ye9JNrz6Fwco3kW66jh5gPbiGfCnBl09lrZtkanyClOs70Oj/Gh6JUZbo0mMmWv3A0fLJgtx1f7zpw7IvaXDRPkMVYrR/NMnYeMu+aKzmYTBw99pY4LiWZWAIWDBcL1CmuKNzT4R3shzP29Bobx9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222929; c=relaxed/simple;
	bh=PK5nDR0cVxyrHo/8P8GyyMrszWz1Rk8JjrC8mgYK/NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9IWl3oTkgNNOZGQCrcR85ZnEnzsQjNPC4ltiWt9P5NZMnIcuMHwUvf/O+qZG6dIsacBcfRMolNKcHqE5ltac81su8IERVonacsf0nZkWBONEgTxJoE0bALD8nzAdLuIe7SifGOa1szVuf4dPXAeV3r25yDnVGASFBhQjyjTnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqPkU7hW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707222928; x=1738758928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PK5nDR0cVxyrHo/8P8GyyMrszWz1Rk8JjrC8mgYK/NA=;
  b=DqPkU7hWYYoIYCY8u7iUPgCIiCdPNc1OLuT2PpVWBLZe6mLx8VuKg9yb
   QOxT6MxG6B2LVq601QaWUFNYCb+mOASDjXhf1I+1nEt+a6N2RhkegBsCy
   Z3mx9bLz/mgbmRqGuzeuw/JWakjoDA1nzYm4NLvA/1Y2msgkOv7nf+vR3
   rEq3ZQhraWUn2ckRHjqQmJQ9/uT0VyvhZi5kxQyIx3Ww5NrwKP9cHCgt1
   BnK1H0TPVrBeEtZ+qYCJvDia6EbxDmYA5L1dmxK+fXY0wCrawklZ7Pq2f
   nOukSuzb/JdbLLfd/AIcnVlOnA2Es6IzdaQvQ5wE7q6tv5/B4CllVg6eD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18254256"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18254256"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909627480"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909627480"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:35:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXKfb-00000002L3D-0pbE;
	Tue, 06 Feb 2024 14:35:23 +0200
Date: Tue, 6 Feb 2024 14:35:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jesus Gonzalez <jesusmgh@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <ZcIniuk0TMAIrHIB@smile.fi.intel.com>
References: <ZcDnikkiwSIDGzT0@smile.fi.intel.com>
 <20240205183618.7761-3-jesusmgh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205183618.7761-3-jesusmgh@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 07:36:20PM +0100, Jesus Gonzalez wrote:

Thank you for the update, my comments below.

First of all, it would be nice also to try to contact with Realtek and make
them aware again. Have anybody talked to them previously?

Also read this thread:
https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and 
> probably others) in their ACPI table as the ID for the bmi160 IMU. This 
> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable 
> to the user. Manufacturers have been approached on several occasions to 
> try getting a BIOS with a fixed ID, mostly without actual positive 
> results, and since affected devices are already a few years old, this is 
> not expected to change. This patch enables using the bmi160_i2c driver for 
> the bmi160 IMU on these devices.

You have trailing whitespaces in each of the line.

> Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
> model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
> with the argument of the device working with the Windows drivers.

>      Scope (_SB.I2CC)
>     {

Cut off these 2 lines.

>         Device (BMA2)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>             Name (_HID, "10EC5280")  // _HID: Hardware ID
>             Name (_CID, "10EC5280")  // _CID: Compatible ID
>             Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>             Name (_UID, One)  // _UID: Unique ID
>             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>             {
>                 Name (RBUF, ResourceTemplate ()
>                 {
>                     I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>                         AddressingMode7Bit, "\\_SB.I2CC",
>                         0x00, ResourceConsumer, , Exclusive,
>                         )
>                 })
>                 Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>             }

Please, cut the below...

> 
>             OperationRegion (CMS2, SystemIO, 0x72, 0x02)
>             Field (CMS2, ByteAcc, NoLock, Preserve)
>             {
>                 IND2,   8, 
>                 DAT2,   8
>             }
> 
>             IndexField (IND2, DAT2, ByteAcc, NoLock, Preserve)
>             {
>                 Offset (0x74), 
>                 BACS,   32
>             }
> 
>             Method (ROMS, 0, NotSerialized)
>             {
>                 Name (RBUF, Package (0x03)
>                 {
>                     "0 -1 0", 
>                     "-1 0 0", 
>                     "0 0 1"
>                 })
>                 Return (RBUF) /* \_SB_.I2CC.BMA2.ROMS.RBUF */
>             }
> 
>             Method (CALS, 1, NotSerialized)
>             {
>                 Local0 = Arg0
>                 If (((Local0 == Zero) || (Local0 == Ones)))
>                 {
>                     Return (Local0)
>                 }
>                 Else
>                 {
>                     BACS = Local0
>                 }
>             }
> 
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }

..till here. Replace it by ... on a single line.

>         }


>     }

As per above (this is part of Scope, so drop it as well).

..

> +	/* FIRMWARE BUG WORKAROUND
> +	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
> +	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
> +	 * available as of Feb 2024 after trying to work with OEMs, and
> +	 * this is not expected to change anymore since at least some of
> +	 * the affected devices are from 2021/2022.
> +	 */
> +	{"10EC5280", 0},

 /*
  * Please, use the correct style of
  * multi-line comments, like in this
  * example.
  */

-- 
With Best Regards,
Andy Shevchenko



