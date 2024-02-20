Return-Path: <linux-kernel+bounces-73172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01F85BEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A77D1C220B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A176BB2B;
	Tue, 20 Feb 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMSQxj8R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327467E6E;
	Tue, 20 Feb 2024 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438865; cv=none; b=u1TdqP8u9heL7lhcmhqzixSnEVHIxRkfNeeMm3PskROa7R4suS73TJNqasLuDo2ff6jKuySrfbwXTzARzn1tr/dH9hTeIC/uqyx1u7nMq4kMrXFBzvmN8xZ0IiJtV3xjywriojvOHX4juBNso8baXkQMi0a7gkMVlYazLFXJGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438865; c=relaxed/simple;
	bh=2/sNuZhDDW4BKax5wLDrsdyxDXb0JpkYm8vXKo6XHAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv3A9VUywDiC++R5oElzABKXjyPcXKx9FoeRlsqqa/sPS4NGw/DxViEu579P78qOnRlbzxHlCpBFvtt87aCDSxWXbYaaW0gYD/s7yaw5b6VPoffFz0S/Mj7clX0UKSYV+7aYz3IQ7kxwStfWarb1HWrr2rMLdulwJKTHEO6zoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMSQxj8R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438862; x=1739974862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2/sNuZhDDW4BKax5wLDrsdyxDXb0JpkYm8vXKo6XHAQ=;
  b=WMSQxj8RvHSy5mOiymDmSjbNxtzDMpmItitbAzeRfnJRVqEyY4XcJ9ea
   j3nKoRWGQ/2yqoKsDNEWXBq0M/fyjtzbo9Qx5xoys3O+5sPAjidHi71L7
   vYrapdwaOtMlkJH46pWBkUU9fSrADBNFD7PO0it26RBxVO3cjdaw2LDuz
   jt6A+A9JxkmjhC7p9x6AmJFbyaxcQiVip65/uCY1c75A/Ige8CjW3WmRO
   KNC1VHA5vR9to2mTHuJSc0tHhpgf3/vL8YP1lt2MLhpH/KsD48eCBg5g7
   shINsF8qQeFV05Gp11osaKAMYgIxUB3QJ/18iJ1b27GdAZ9ZD3NYYTFei
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5499039"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5499039"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913083829"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913083829"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:20:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcQzR-000000066Sa-1IE7;
	Tue, 20 Feb 2024 16:20:57 +0200
Date: Tue, 20 Feb 2024 16:20:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rengarajan.S@microchip.com
Cc: linux-serial@vger.kernel.org, jirislaby@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Kumaravel.Thiagarajan@microchip.com,
	Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Message-ID: <ZdS1Se4bVvuKDd6-@smile.fi.intel.com>
References: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
 <063a1804732c619bc4a5c801c9881fedd92ad745.camel@microchip.com>
 <ZdN_npTcCfz0cI_g@smile.fi.intel.com>
 <9ae91cfc2ca24d23c5f3bc16208e5d59eccba076.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ae91cfc2ca24d23c5f3bc16208e5d59eccba076.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 04:21:59AM +0000, Rengarajan.S@microchip.com wrote:
> On Mon, 2024-02-19 at 18:19 +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 09:26:21AM +0000,
> > Rengarajan.S@microchip.com wrote:
> > > On Wed, 2024-02-14 at 15:50 +0200, Andy Shevchenko wrote:

..

> > > > +       /*
> > > > +        * 8250 core considers prescaller value to be always 16.
> > > > +        * The MCHP ports support downscaled mode and hence the
> > > > +        * functional UART clock can be lower, i.e. 62.5MHz, than
> > > > +        * software expects in order to support higher baud
> > > > rates.
> > > > +        * Assign here 64MHz to support 4Mbps.
> > > > +        *
> > > > +        * The value itself is not really used anywhere except
> > > > baud
> > > > +        * rate calculations, so we can mangle it as we wish.
> > > > +        */
> > > > +       port->port.uartclk = 64 * HZ_PER_MHZ;
> > > 
> > > As per internal MCHP DOS, PCI1XXXX driver uses a simple method of
> > > converting "legacy 16 bit baud rate generator" to a "32 bit
> > > fractional
> > > baud rate generator" which enables generation of an acceptable baud
> > > rate from any valuable frequency.
> > > 
> > > This is applicable only when the baud clock selected is 62.5 MHz,
> > > so
> > > when we configure the baud clock to 64 MHz(as above) will it be
> > > downscaled to 62.5 MHz, thus supporting the above feature?
> > 
> > I specifically added the above comment. If you look closer, your
> > driver does
> > not use this value at all, the 8250 port code uses it in several
> > places:
> > 
> > - 8250_rsa case (not applicable to your driver)
> > 
> > - probe_baud() call (applicable iff the kernel command line misses
> > the
> >   baudrate, but even without this patch it's broken for your driver)
> > 
> > - serial8250_update_uartclk() call (not applicable to your driver)
> > 
> > - serial8250_get_baud_rate() call (only to get max and min range;
> >   my change will have an effect on min (max is exactly what your
> >   quirk is doing right no), so 62500000/16/65535 ~= 59.6, while
> >   with my change 64000000/16/65535 ~= 61.0, but standard baudrate
> >   here is 50 and 75, the former isn't supported by the existing
> >   code either
> > 
> > - serial8250_do_get_divisor() call when magic_multiplier supplied
> >   (not applicable to your driver)
> > 
> > - autoconfig_16550a() call (not applicable to your driver)
> > 
> > Hope this clarifies the case.
> > 
> > Of course if you able to test, will be even better.
> > But wait for v2 where I update what Greg caught.
> 
> Thanks for the clarification Andy. Will start with the testing after v2
> patch.

v2 is here:

https://lore.kernel.org/r/20240219162917.2159736-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



