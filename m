Return-Path: <linux-kernel+bounces-135621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAA89C8A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4FFB22C85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2081420B7;
	Mon,  8 Apr 2024 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEMyJOGk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5D1411EF;
	Mon,  8 Apr 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591113; cv=none; b=VnL0Sj50Ehgh+QqJaBvxsTYOiBo0vpOkcMy6M0cO7F34lfsBOyOsqnYLizGqpH2GELPtZcd8x3xLX9TfGGZSpcrmNZc/Clr+X1URH0Szu8kdtrdTmQaN9M0EaJd1T92mlR0hWjylz8/vLSuqpzopWPBsM00wtJQo8si2Sjyhxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591113; c=relaxed/simple;
	bh=T+hfrAsFNnklIEb0sRRQ8EMi792MajkNUSG/16PQJXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5k4fcabr3rhDQbqkCotMNQOHSXRN62S2wWTza9PkHn0vZMcDomPAw2gEIIEnZZXlT2L454wZ8Xo9r1F6foZik0UJF1DJGXjqYFAg2lfHAiz8EVJA9XrWGadwD8nu5dY6SyBkmQHVZti8N7jhG326SeUAKSmEDhPhmDhZ5YHUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEMyJOGk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712591112; x=1744127112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+hfrAsFNnklIEb0sRRQ8EMi792MajkNUSG/16PQJXE=;
  b=QEMyJOGkX6/hHHWD1cBeFJiCHWjgAalgCp8T3qzJ958dOSxcmcRyirvz
   Qr+QmLZNv3eMIU84RLL86NRepSahytose9EpjsJlwn8HLdgA+YCEtey97
   ddqMpEswgb5vn0EOWqyi5z2o6Lk5QslEr+es75Bmc3kPiccO9XVrsrsFI
   2zfZis6uY4Ou1ORAaVkue0BKlN3yMUVZTtwvkQ2nItZsbenfgzy2gtr3X
   QY20hAE6k45W1wnJHGJA+az1yR3Nb1eIPKJ6Hzjk2smPId19ilwA38JG9
   ZG5NSpWkBxDJFVmqVrH57LGAtAytgT6yUAbKVoy6SaiFBcPOtwOxTaNTK
   A==;
X-CSE-ConnectionGUID: 0jj0ANFKRDCscXaxj1VLjg==
X-CSE-MsgGUID: NcmG8EEbSrCpI21l0PdImA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8037174"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8037174"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915368991"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915368991"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:45:09 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtrBC-00000002ZCa-38P1;
	Mon, 08 Apr 2024 18:45:06 +0300
Date: Mon, 8 Apr 2024 18:45:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
Message-ID: <ZhQRAhsGfdikDGEG@smile.fi.intel.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
 <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f200b0-34dc-430b-b55e-b133faf4db44@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 07:25:03AM +0200, Jiri Slaby wrote:
> On 04. 04. 24, 16:59, Andy Shevchenko wrote:
> > The circular buffer is NULLified in uart_tty_port_shutdown()
> > under the spin lock. However, the PM or other timer based callbacks
> > may still trigger after this event without knowning that buffer pointer
> > is not valid. Since the serial code is a bit inconsistent in checking
> > the buffer state (some rely on the head-tail positions, some on the
> > buffer pointer), it's better to have both aligned, i.e. buffer pointer
> > to be NULL and head-tail possitions to be the same, meaning it's empty.
> > This will prevent asynchronous calls to dereference NULL pointer as
> > reported recently in 8250 case:
> > 
> >    BUG: kernel NULL pointer dereference, address: 00000cf5
> >    Workqueue: pm pm_runtime_work
> >    EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >    ...
> >    ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >    __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
> >    serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
> >    serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
> >    __rpm_callback (drivers/base/power/runtime.c:393)
> >    ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
> >    rpm_suspend (drivers/base/power/runtime.c:447)
> 
> Yeah, I noticed start_tx() is called repeatedly after shutdown() yesterday
> too. So thanks for looking into this.
> 
> And it's pretty weird. I think it's new with the runtime PM (sure, /me reads
> Fixes: now). I am not sure if it is documented, but most of the code in tty/
> assumes NO ordinary ->ops (like start_tx()) are called after shutdown().
> Actually, to me it occurs like serial8250_start_tx() should not be called in
> the first place. It makes no sense after all.

So, with PM autosuspend the [PM] callback can be called in to cases:
- port is open and busy, but PM is not informed (yet) of it
- port is closed while PM timer is still counting

The Fixes seems about the first case (so we need to call Tx there).
The second one probably can be fixed properly with PM barrier.

This fix is just against the oops AFAIU the bug report and my own case.

-- 
With Best Regards,
Andy Shevchenko



