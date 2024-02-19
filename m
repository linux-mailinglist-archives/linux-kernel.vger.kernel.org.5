Return-Path: <linux-kernel+bounces-71667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C5185A8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ADD2860D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1793CF77;
	Mon, 19 Feb 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+y64Myy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD04436D;
	Mon, 19 Feb 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359589; cv=none; b=kJZ1It/q/PlR7W5y5qR5su8b5pImKQRPZDK+bClJq7El8fiTX13bQLuntoqqTHnTJheu8cfnqWjyPwvIqpgbJfvu84+ySeNRUvI9DdZkPWxLvqeD5Kf6HKbI9tyhJcwpZYrhWfR1qZ9MtbP7jHN+5H6PeWJ1xxYblEFh4RBvHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359589; c=relaxed/simple;
	bh=RdNZuOtLOx4IGGS9wQnvPIdnfB7/swLpF9VOXubJEbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VukkZfcHNba1bnVL+xZ5mTzU2q9Psf3FDvGqespga4w+LnsdpCpDlquiy0FMHXhtB0COvfT6VL3vZ0lxo5jg3yRGIffdNmaG5ptnis0J0/3guHzXtuA2ZSe5+LN3q0F+ITtdmR/cwm1Pqudo1ZL44nGXGPqCh0bxErYMc/VLi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+y64Myy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708359588; x=1739895588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RdNZuOtLOx4IGGS9wQnvPIdnfB7/swLpF9VOXubJEbY=;
  b=j+y64MyylHLQhdgPVh9Ok9lGppgeAGMQtg1jES2Z8B8rpjR5ABnJIa8Q
   U29tDtqg5wJkrUfN9hfzb4hJeF6cwIlmabVwkhlyV7o5eO/4+RQ/HX64O
   ijVeY+bBFKPYyrwZii3+mFQ2Gacj/iYiotpEVi7UVHLsKD0m5miHL3ems
   Ldf6x5QK5baV1MiNrxPwoU1JJRN7dhvQcESXKfcHXrmA7d9gYKZnoltk4
   NERmi2r88J7GA3xXwgtdlGiqB+6SCsHy7WkElmM//6shbAKIfBIeGKbP+
   P32gutfb+HFJNS0LWXpfQTthGGGKkm5ku1UV6c2YGe7ifaPHUhB1LM0iM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2308988"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2308988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912900937"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912900937"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 08:19:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc6Mo-00000005rnm-2qGX;
	Mon, 19 Feb 2024 18:19:42 +0200
Date: Mon, 19 Feb 2024 18:19:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rengarajan.S@microchip.com
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, jirislaby@kernel.org,
	Kumaravel.Thiagarajan@microchip.com,
	Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Message-ID: <ZdN_npTcCfz0cI_g@smile.fi.intel.com>
References: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
 <063a1804732c619bc4a5c801c9881fedd92ad745.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <063a1804732c619bc4a5c801c9881fedd92ad745.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:26:21AM +0000, Rengarajan.S@microchip.com wrote:
> On Wed, 2024-02-14 at 15:50 +0200, Andy Shevchenko wrote:

..

> > +       /*
> > +        * 8250 core considers prescaller value to be always 16.
> > +        * The MCHP ports support downscaled mode and hence the
> > +        * functional UART clock can be lower, i.e. 62.5MHz, than
> > +        * software expects in order to support higher baud rates.
> > +        * Assign here 64MHz to support 4Mbps.
> > +        *
> > +        * The value itself is not really used anywhere except baud
> > +        * rate calculations, so we can mangle it as we wish.
> > +        */
> > +       port->port.uartclk = 64 * HZ_PER_MHZ;
> 
> As per internal MCHP DOS, PCI1XXXX driver uses a simple method of
> converting "legacy 16 bit baud rate generator" to a "32 bit fractional
> baud rate generator" which enables generation of an acceptable baud
> rate from any valuable frequency.
> 
> This is applicable only when the baud clock selected is 62.5 MHz, so
> when we configure the baud clock to 64 MHz(as above) will it be
> downscaled to 62.5 MHz, thus supporting the above feature? 

I specifically added the above comment. If you look closer, your driver does
not use this value at all, the 8250 port code uses it in several places:

- 8250_rsa case (not applicable to your driver)

- probe_baud() call (applicable iff the kernel command line misses the
  baudrate, but even without this patch it's broken for your driver)

- serial8250_update_uartclk() call (not applicable to your driver)

- serial8250_get_baud_rate() call (only to get max and min range;
  my change will have an effect on min (max is exactly what your
  quirk is doing right no), so 62500000/16/65535 ~= 59.6, while
  with my change 64000000/16/65535 ~= 61.0, but standard baudrate
  here is 50 and 75, the former isn't supported by the existing
  code either

- serial8250_do_get_divisor() call when magic_multiplier supplied
  (not applicable to your driver)

- autoconfig_16550a() call (not applicable to your driver)

Hope this clarifies the case.

Of course if you able to test, will be even better.
But wait for v2 where I update what Greg caught.

..

> Acked-by: Rengarajan S <rengarajan.s@microchip.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



