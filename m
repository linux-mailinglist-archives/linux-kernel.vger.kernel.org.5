Return-Path: <linux-kernel+bounces-121352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF8688E69B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607F729E21C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF09157A68;
	Wed, 27 Mar 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eW1OVAqp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7D13A876;
	Wed, 27 Mar 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545162; cv=none; b=t7rlkWBfs/7HCZLYdIWbqq8h3NnyjsqMEnsmndOwyM8ttml4mVy16NN3+KJrPGubxfBVAsoCMLUL0x2mUfh2tR6/MaCOaaPyPG+V2KwIF0fWfKUFyfaK1rlP96cZJtMGvO5wluce2w90ft4ohl7G05rM+5WHYFYCb0mIvTKCxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545162; c=relaxed/simple;
	bh=IvPK6ON9KEhuTWpwCUnz/lO5Eb9diKRyDkkg+71RXhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNrcviIReubia/WnP6WNX8nFVX0FKSn2v3v4w3fmRpCiMzgMad3O8s8Qbpd8J0C42/8We58xNedUG8Yl/7UI+/VLhSz7sLO/NF9FVVPXbJpzaMm1e1cEbZGFwjrHNtMQi3uEtgJhkrHvMcAJp7ktAdds0Za9poP0I1dltYQfeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eW1OVAqp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711545162; x=1743081162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvPK6ON9KEhuTWpwCUnz/lO5Eb9diKRyDkkg+71RXhY=;
  b=eW1OVAqpj8VDc3JWyo9KMAkgkM5M8fuA/Iswt0tCyugz/Xxa1kLCiqPV
   kQVaOiOPiEmxnmevj+u814TxSR4uhwYpCt4sSxI0ts0FOX6iiK21ZVXRY
   iibw/R/ZtdNSyl9sOxmviRXitc2lFz1cwkD7tyK28ebw5j6b3WDdaQ39Q
   bsJuZjqkmmea8L+XA9/OWQtvepIzUB3l1lyL9HeyX+DfuF7PfXBRwCm49
   emo53gA0Fs2OjqkGEiYsWk31IQGqb9QosMP9BGu3/SsQIY6/YDwWnL/l5
   jXXqv1XmFTLOmam8UBmmsaRVhDGm2YYHMBxtcCO4c5T5pHZMD+QX1HpLb
   Q==;
X-CSE-ConnectionGUID: BHCDtHv/Sj2es2we1/f0nQ==
X-CSE-MsgGUID: txK54sFEQ7mk+wP5EMckgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6581471"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6581471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914912994"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="914912994"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:12:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpT4z-0000000GdkI-2zqD;
	Wed, 27 Mar 2024 15:12:33 +0200
Date: Wed, 27 Mar 2024 15:12:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <ZgQbQaNyIcuKnPqm@smile.fi.intel.com>
References: <87le6oy9vg.fsf@jogness.linutronix.de>
 <87plvy31hg.fsf@jogness.linutronix.de>
 <20240322062305.GB5132@atomide.com>
 <87r0fwt3z4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fwt3z4.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 10:38:15AM +0106, John Ogness wrote:
> On 2024-03-22, Tony Lindgren <tony@atomide.com> wrote:
> > * John Ogness <john.ogness@linutronix.de> [240313 09:50]:
> >> One nice thing that has risen from this is we are starting to see
> >> exactly what the console lock is needed for. At this point I would say
> >> its main function is synchronizing boot consoles with real
> >> drivers. Which means we will not be able to remove the console lock
> >> until we find a real solution to match boot consoles (which circumvent
> >> the Linux driver model) with the real drivers.
> >
> > Would it help if earlycon handles all the boot consoles?
> > Then just have the serial driver take over when it probes?
> 
> I think this would be very helpful. And it would also cleanup the boot
> arguments. For example, we would no longer need the
> architecture-specific arguments/options (such as "early_printk" and
> "keep"). These architecture-specific arguments can be really
> confusing.

You may not get rid of earlyprintk as it affects *very* early at boot,
earlycon is simply not and may not be available at these stages.

-- 
With Best Regards,
Andy Shevchenko



