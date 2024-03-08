Return-Path: <linux-kernel+bounces-97281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5974876835
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC30B23515
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529F14F98;
	Fri,  8 Mar 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UggsHOnW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383917745;
	Fri,  8 Mar 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914533; cv=none; b=l/KTCCE10+v19ZPowxEP2W2s63L44Y36mVwaZk1OIMfQkKnu1fz3OoUwDKQX/52LicJdoaPtpaxwlOaF1WeWgV5n7XO3F+e9fTv6RarTNHJ+2KAzRdcBhyz76JuIjpKceJDwKhH8QI3pSK4MffwnaEjVhpEEqAe+CJPe/34Sq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914533; c=relaxed/simple;
	bh=KoN9H3CRkpnEci3xxesKljJ2R9dEAtl14sUiv45A7dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxhCXeSyiVJpJyeHJXWLUrJueRI3YbZvMrOR4OfhOCzl/oeAPo5A29Y+YNBpyZTmEu9pestxmjz3fY2t1qcS72BN1mKLU71jbZ/+hSWOb9H7InAp4fpdx8lFftS1blxhk+7lF20dFFIqO+cm5QyU8j3LEnzUwweZmVbe6sS2UKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UggsHOnW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709914533; x=1741450533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KoN9H3CRkpnEci3xxesKljJ2R9dEAtl14sUiv45A7dc=;
  b=UggsHOnWQ8ah4zZMoBbSL3lt4mdCqq40loaSl05lApYA+tq3Rut7Usgc
   hqqJoi4377BRJ8IbAuBur+64ttqk+rjHhB0iUZqAnuo8HkSGUB+CPRsmz
   RZTYm7lCfkGgYKDfFF9gMc2fyt0oUS2SV5xjj0ZDoJ3VOTCh5zPCwgAg2
   t4m1chzYjkUHQWUrRFYLiTGDUVRtUrRizpFGEm0Drd5KCifRypRXKrW4c
   7h8whYKrv/nMjEQZwgRFP8kNyX2JAYp1rNhsUTQXdlkykZpa3aROQW2G+
   X391VfQ/w/wvJ/xNCYtlLTNRBfXKpkACzA4HHXSoOvy6nCl5SOGdoOkmU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="16047241"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="16047241"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914250176"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="914250176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 08:15:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ricsX-0000000At8C-396L;
	Fri, 08 Mar 2024 18:15:25 +0200
Date: Fri, 8 Mar 2024 18:15:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v2] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <Zes5nX4YdxrsGRji@smile.fi.intel.com>
References: <2024030518-encrust-gutter-f507@gregkh>
 <PSAPR06MB4952ED7EAD4410B25258F42FC9212@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB4952ED7EAD4410B25258F42FC9212@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 07:42:27PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>

Thanks for your contribution!
My comments below.

..


First of all, always start a new email thread when sending a new version of the
patch (i.o.w. no In-Reply-to email header).

> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.
> 
> Signed-off-by: Guanbing Huang <albanhuang@tencent.com>


> Signed-off-by: Bing Fan <tombinfan@tencent.com>
> Signed-off-by: Linheng Du <dylanlhdu@tencent.com>

This chain, as described in Submitting Patches documentation [1], should go
accordingly.

..

> @@ -473,6 +473,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  		uart.port.flags |= UPF_SHARE_IRQ;
>  	uart.port.uartclk = 1843200;
>  	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
> +	device_property_read_u8(&dev->dev, "reg-shift", &uart.port.regshift);
>  	uart.port.dev = &dev->dev;

Instead, it may make sense to switch to use uart_read_port_properties() which
has been recently introduced and dozen of drivers converted.

Ex. e6a46d073e11 ("serial: 8250_dw: Switch to use uart_read_port_properties()")

Yes, it assumes that you always need to base your changes on the latest
available changes in the certain subsystem (here it is tty-next branch
in Greg's tty tree, see git.kernel.org for the details).

>  	line = serial8250_register_8250_port(&uart);

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
With Best Regards,
Andy Shevchenko



