Return-Path: <linux-kernel+bounces-27143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317182EB25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E0C1C22DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1680125B4;
	Tue, 16 Jan 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHQrNaXK"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BB125A3;
	Tue, 16 Jan 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705394934; x=1736930934;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B6rzE15E+3r6Gl6rpOFZgLwTO62J00BCuGerH7lFMtQ=;
  b=CHQrNaXKvK33ncsD9gr14V1ruRe1pUat5akt1iLne48evhsBvx84RSMf
   6GRQTyNQTYY2XBauJEXdAK/ClKIhdaM8PmLA7FTwPFIC3KWlcMynIHVi8
   4W6kXdnv22GArdjAT/NBdbdQSt+7E1K/5povy9wlDKWdGTeDN5kg7MTFd
   Rsxb9Ky5DkOes7i94O/VBUbTm9zljpBUbj8Eg+6LYh4M1RQOVTMPeqdeH
   QRPC/WYClargpioRZ+nMP1GmF81ZRmBBCSBZUkCdO9Q23YGDhPRWXIoV7
   toJu6bduG4QMllquvbJsuIawWYFEF1VHhqrokcY8mNr/DeDsaCnwcebuv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="390246229"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="390246229"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854281511"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="854281511"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 00:48:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jan 2024 10:48:44 +0200 (EET)
To: Leonardo Bras <leobras@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Florian Fainelli <f.fainelli@gmail.com>, 
    John Ogness <john.ogness@linutronix.de>, Tony Lindgren <tony@atomide.com>, 
    Marcelo Tosatti <mtosatti@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT
 atomic context
In-Reply-To: <20240116073701.2356171-3-leobras@redhat.com>
Message-ID: <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jan 2024, Leonardo Bras wrote:

> With PREEMPT_RT enabled, a spin_lock_irqsave() becomes a possibly sleeping
> spin_lock(), without preempt_disable() or irq_disable().
> 
> This allows a task T1 to get preempted or interrupted while holding the
> port->lock. If the preempting task T2 need the lock, spin_lock() code
> will schedule T1 back until it finishes using the lock, and then go back to
> T2.
> 
> There is an issue if a T1 holding port->lock is interrupted by an
> IRQ, and this IRQ handler needs to get port->lock for writting (printk):
> spin_lock() code will try to reschedule the interrupt handler, which is in
> atomic context, causing a BUG() for trying to reschedule/sleep in atomic
> context.

I thought that the printk side was supposed to be become aware when it's 
not safe to write to serial side so the printing can be deferred... Has 
that plan changed?

-- 
 i.

> So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
> fails proceed anyway, just like it's done in oops_in_progress case.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8ca061d3bbb92..8480832846319 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3397,7 +3397,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  
>  	touch_nmi_watchdog();
>  
> -	if (oops_in_progress)
> +	if (oops_in_progress || (IS_ENABLED(CONFIG_PREEMPT_RT) && in_atomic())
>  		locked = uart_port_trylock_irqsave(port, &flags);
>  	else
>  		uart_port_lock_irqsave(port, &flags);
> 


