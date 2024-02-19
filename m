Return-Path: <linux-kernel+bounces-71739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D165685A9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3DE1C23287
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB3446BB;
	Mon, 19 Feb 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljeI0p++"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E799741C84;
	Mon, 19 Feb 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362875; cv=none; b=gSE1WXt8K+PsyJj1QTLO20Wll7bOgTSfrGByxtOPyY+nB/XgAz+xadTBtL0a2Og/fnOZnDXCbaYS3GVWYgM77NWGJNisBt7tRYPlxrur1li3ctnlif8IT8o1UWSDnNtps9PgHUpt2XOrodKIXLFFm6InmNF8x1j2vmFMYw2L52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362875; c=relaxed/simple;
	bh=hLOJYgGZFk4kaYTRs9LF+gbHOW73wW1rFlIOpDCiLB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB5Fgnyshu1mg0WTaWPGWG2eyhffMVyJacWkElLY5/RFCKWGowIjhIFFYoRL1Dvvrlkb9pvaAuswokZVsXKRdaRBVwwxRSEZgvsI2T40wdmMOKY6l+5zqEASErhSa9Q729RuCabFLw+VPYYHJ/aGzDwKE6qvjCHuA51mrvin960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljeI0p++; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362873; x=1739898873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hLOJYgGZFk4kaYTRs9LF+gbHOW73wW1rFlIOpDCiLB8=;
  b=ljeI0p++67bDtxB5Iq3XJqFDvU2zcuAETS9yquvg0JsQDWMU9lX613hO
   eH8KNb+pz3thlbhbS1Gx194TEnrWpsGRmkkGbzIyJI3M964/F3OcOsq2o
   xy8OlH8QZSLjiNytYQsvMzs5BIByuYzdNSNPhd2MxaY0cXdE9tStqE7U0
   UQJPNQkibFrz/kRX4Em/LpjX33GW9OfpjZRA3HyyU6iF6k1Nt5QQJyETJ
   d232TWrIW1ZkEiTt5Ha768G3AZqLX8x9IWB2HOQOgkThRyYHUmes7dfTK
   WRJ4uMvUpXYLk5gKOGMvk9nqIh5MXG316qx0PT2NGSF8945bCPNfvO/is
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13847310"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13847310"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912907995"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912907995"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:14:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc7Dl-00000005swa-0zK8;
	Mon, 19 Feb 2024 19:14:25 +0200
Date: Mon, 19 Feb 2024 19:14:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <ZdOMcCJ48N7UJT8J@smile.fi.intel.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
 <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
 <87jzn0bkqg.fsf@jogness.linutronix.de>
 <ZdNnKylfoj4Vt3Nu@smile.fi.intel.com>
 <87il2k2y7a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il2k2y7a.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 05:58:41PM +0106, John Ogness wrote:
> On 2024-02-19, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>> The headers in this file is a mess. But here you can at least keep the
> >>> piece ordered, can you?
> >> 
> >> Just to clarify, you would like to see this ordering and inclusion?
> >
> > Roughly, yes. Ideally it is quite likely that kernel.h is being used as
> > a 'proxy' header. Nowadays, it's rare the code needs kernel.h.
> 
> So I took the time to painfully discover every header that is required
> for nbcon.c without any proxy usage. It came down to this:
> 
> #include <linux/atomic.h>
> #include <linux/bug.h>

> #include <linux/compiler.h>

This is guaranteed to be included by types.h, can be dropped.

> #include <linux/console.h>
> #include <linux/delay.h>
> #include <linux/errno.h>
> #include <linux/export.h>
> #include <linux/init.h>
> #include <linux/irqflags.h>
> #include <linux/minmax.h>

> #include <linux/percpu-defs.h>

This...

> #include <linux/preempt.h>
> #include <linux/serial_core.h>
> #include <linux/slab.h>

> #include <linux/smp.h>

..and this I believe can be represented by percpu.h as most likely that is the
"main" library you are using.

> #include <linux/stddef.h>
> #include <linux/string.h>
> #include <linux/types.h>
> #include "internal.h"
> 
> For the next version of this series I will only add the includes you
> suggested, but will follow-up with a patch that fixes all proxy headers
> for nbcon.c. As a separate patch it will help with bisecting in case the
> ordering causes an explosion on some config/architecture.

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko



