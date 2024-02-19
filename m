Return-Path: <linux-kernel+bounces-71292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3985A302
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688F81C2371F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA362D61B;
	Mon, 19 Feb 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdFYsMBf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F32D611;
	Mon, 19 Feb 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344993; cv=none; b=rSnKpFHoDCw/6KyKFrxjQ97owe5PTSGaRaRE3cpAAsvJiQM8GCouiHYts9/yMiw/iZlJFJR81LyjDN83L3ix0uPanu7Ir+BSzN3s+ef0NVykFLmnL32zmofcC2XsnbfB2dG5VIuMgSzyPCc15tDU9YlcnLGrmRAnkNZHQa5P0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344993; c=relaxed/simple;
	bh=9TrHAAuMkact29unPRZdiwWmhAkZN/UAM/ik02lnchs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPpB3Yx8hLQiEIt+T754hsl4ctuk093P+O89DgV9V6fNVSmAq2gaYuFRoikjOV9ScFza4LpbLKS+MgbeF9uvT/Vtmh7bkGj53NjfoId2BrqR1rZTyp+kyfAmtAuD0U5uihjC1eHGt40UTEDieER56/JhCZNR4fRk0FoOmkAtW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdFYsMBf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344991; x=1739880991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9TrHAAuMkact29unPRZdiwWmhAkZN/UAM/ik02lnchs=;
  b=kdFYsMBfsXOra86TJNgpoAczL3u74rzFkc6VbOlGrldnirmcwmqDLip/
   zDUUaVdRXpmv1XfjK1a3r/J/VLjY2JeD+yJTbI3+IUrf1yBu2Bxn5Jqnc
   9R12/KH97L6Uep+gBHnZCOsWt/+UB04za37WBcwF36PJg5Kk9h3RyecB5
   VGvrBsenXPMLeftXlb1K0avhsC99oK801b25bOeQNV8TVaBOsndrMOd1i
   7Pf0HNYSW3hZgHu8FjLdQmcujVahHYsAWV0BDoT3ekmzUnKe/QqWOgRae
   XNKX89YQ2xA9ggrQ3fGhuW6ueoGqY4oOmSjULm4rTbIs6+3wLT6W0PXBG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="5382521"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="5382521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912865972"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912865972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:16:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc2ZL-00000005ogX-3jLN;
	Mon, 19 Feb 2024 14:16:23 +0200
Date: Mon, 19 Feb 2024 14:16:23 +0200
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
Message-ID: <ZdNGlzwqwdsfwwab@smile.fi.intel.com>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-9-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 18, 2024 at 08:03:08PM +0106, John Ogness wrote:
> Currently the port->lock wrappers uart_port_lock(),
> uart_port_unlock() (and their variants) only lock/unlock
> the spin_lock.
> 
> If the port is an nbcon console, the wrappers must also
> acquire/release the console and mark the region as unsafe. This
> allows general port->lock synchronization to be synchronized
> with the nbcon console ownership.
> 
> Add a flag to struct uart_port to track nbcon console ownership.

..

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -6,6 +6,7 @@
>  #include <linux/console.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/serial_core.h>

The headers in this file is a mess. But here you can at least keep the piece
ordered, can you?

..

> +static inline bool uart_is_nbcon(struct uart_port *up)
> +{
> +	int cookie;
> +	bool ret;
> +
> +	if (!uart_console(up))
> +		return false;
> +
> +	cookie = console_srcu_read_lock();
> +	ret = (console_srcu_read_flags(up->cons) & CON_NBCON);

The outer parentheses are redundant.

> +	console_srcu_read_unlock(cookie);
> +	return ret;
> +}

..

> +void uart_nbcon_acquire(struct uart_port *up)
> +{
> +	struct console *con = up->cons;
> +	struct nbcon_context ctxt;
> +
> +	if (!uart_is_nbcon(up))
> +		return;

> +	WARN_ON_ONCE(up->nbcon_locked_port);

+ include linux/bug.h

> +	do {
> +		do {
> +			memset(&ctxt, 0, sizeof(ctxt));

+ include linux/string.h

> +			ctxt.console	= con;
> +			ctxt.prio	= NBCON_PRIO_NORMAL;
> +		} while (!nbcon_context_try_acquire(&ctxt));
> +
> +	} while (!nbcon_context_enter_unsafe(&ctxt));
> +
> +	up->nbcon_locked_port = true;
> +}
> +EXPORT_SYMBOL_GPL(uart_nbcon_acquire);

+ include linux/export.h

-- 
With Best Regards,
Andy Shevchenko



