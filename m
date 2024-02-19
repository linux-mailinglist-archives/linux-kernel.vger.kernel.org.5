Return-Path: <linux-kernel+bounces-71486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9585A611
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966D31F26521
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB491EA80;
	Mon, 19 Feb 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDgxyvZN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC737155;
	Mon, 19 Feb 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353333; cv=none; b=ku2efWLu672s9k3z4rOPmTIheyLWz//vCmxUCBGv3whK2LEDJ8XoR+mBrZkUit4hw8TRQyX8ypp8UbtaDEyKgTljwAkMl/6/zLfCXR1KkOYz+EWifkf3078VWMFIYcLujednskfwu0dU3sO/3Th2XCgRcDCZhnMcxBGyvP75Dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353333; c=relaxed/simple;
	bh=k2Lph/7vsIC7otT5TKfaEZcrEWoZc028leDXer26Ytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoCHBhCXFU6jiyxB5ffX2ER8Uc6NDJWQ69VbvSKgBXh9jsWzWXr51NOixMhevKGrcOG8C+q0yzVKKeKid5BmIQnSkhbxQPV2riua34/hvhlWHaeOG86dUx9ePObU7nuMAGOXr05YOMmVuGGf2P3x0Dh+a5oqcdOdfErJCKOKzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDgxyvZN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708353332; x=1739889332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2Lph/7vsIC7otT5TKfaEZcrEWoZc028leDXer26Ytc=;
  b=FDgxyvZNbFo7oHyQ4Mso09FK2mwy7EmNzOHY88OdOnGUgHscgaCAo1ti
   wQWaaEh8S0J8+abfbUCiLNJqD4MB21Mq3pIdFeuVDLnL9moU2xmt0iyFA
   HPxajoOWh4yfeaHtnN4BJH/WQ3bl9O//LxTXLAftRsPxRLEJtkqv5SFMU
   lbLBys/K3LybtfD0YYHQ548JLwhQrd5JIQZKSqwJoq7U1oUgVz0iOwf81
   AX87VHgCqrlvs43mVa72UfWzw56QDYSVR+DTKRV8WsBFbAy3B0ankwL80
   HzCWNmNTGfx2xu6nMs1LY16HT/1u5HL/4KBfVqAdGQMQqrCAzuAYWsRK9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2580539"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2580539"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="827011627"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="827011627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:35:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc4jr-00000005qOC-2YNa;
	Mon, 19 Feb 2024 16:35:23 +0200
Date: Mon, 19 Feb 2024 16:35:23 +0200
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
Message-ID: <ZdNnKylfoj4Vt3Nu@smile.fi.intel.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
 <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
 <87jzn0bkqg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzn0bkqg.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 03:24:47PM +0106, John Ogness wrote:
> On 2024-02-19, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> >>  #include <linux/console.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/serial_core.h>
> >
> > The headers in this file is a mess. But here you can at least keep the
> > piece ordered, can you?
> 
> Just to clarify, you would like to see this ordering and inclusion?

Roughly, yes. Ideally it is quite likely that kernel.h is being used as
a 'proxy' header. Nowadays, it's rare the code needs kernel.h.

> #include <linux/bug.h>
> #include <linux/console.h>
> #include <linux/delay.h>
> #include <linux/export.h>
> #include <linux/kernel.h>
> #include <linux/serial_core.h>
> #include <linux/slab.h>
> #include <linux/string.h>

-- 
With Best Regards,
Andy Shevchenko



