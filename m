Return-Path: <linux-kernel+bounces-106321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16287EC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE3280F37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8152F90;
	Mon, 18 Mar 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cwrXHFsi"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54052F85
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776561; cv=none; b=cWwgfDlpCo40hGyQBtEneD61SF0mVnpma/KEDCyj/i5OuTHvOZLUe35/Gy9p7P24QhZ2LI5uRS3sGV2GmY0OmAyk5wNXTz6Gn6bDau/CVnTfb08MiCiw0kKLwIVSmt3c4RG6NZimG9Gt3vX6GgieGEB8ZZ4ay5HAfBQY+c3skTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776561; c=relaxed/simple;
	bh=fstJsI88rFXxdnO6uRjee1SkFXXRCenAkMwozqG3HWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHTVMbO6k7aHmbW3Jnrmg6NsiMLRACcuGUQPbSA0YOsMzqCTxN0rs8mIu7uCWrzmLFiwxeTAF3mmVwEVpd92xJWlqxO8fKOjHKnAbJBqUtc5tBANBk0WENJ0Rhs9TuvzPU1PNcZCkW+7tW783s2M5sk9zmwCiYmPnJgHdwhhdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cwrXHFsi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so44003311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710776556; x=1711381356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PTC94ZWbRaMxlVfwdin5J88yO9q91Lex65wqGvnlrg=;
        b=cwrXHFsi/yuwVhWRUSEJSMt13GNIXXMjrsryBRW0janO6RAl1fTJILYlBSOfuD4r6X
         BBomRnl6hNvwssdvlKOHTf0R7uNf+L1+e30kCFf3ztoDXzUCjDqsrbyXcgN69kBpT1vH
         9EMMxEitpAyBW16RNFv5IhyCkShsFku2g6UDDsEoSHk/Se/zKIer1ipY0Nk7auqhRYk6
         g6Yi1HmDjxMueJE/QsX9Go6No0lt02KgtZ7HPQeb+QLJDGtVwhTEhjFlwOscz7UyO8+l
         Tll7nNmQKHwT+9QQSAAXRAKH/jgSWqLz9ddxrGOkR2vNiztYDatvnNFODSvUm2Wx6eA1
         kddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776556; x=1711381356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PTC94ZWbRaMxlVfwdin5J88yO9q91Lex65wqGvnlrg=;
        b=dm3YximRUV/k4RyKMPABcVJJzrcUUJ0YRRiJb9r9xGnCk83LdnmUrB2Kx93Bv6FgfM
         oq2rSGItFEAOS14yPF525OTG/BExvd3CFnNYJHlmUJ6zcxlc9QpwO6iGQsLEDuXm45kM
         00NF84gquYmkLYFJOR4v4+2kfuRmakH8zeBaX4VMYOf+o2cHF6KIMGTBnXn2hNZi59zQ
         wHGpDytic60AMAhIXJpIvE7CJpKEGJWR5jaUxeNmB2A67nd8ayFqoE/CibIzgcCF8KO+
         FwbULtGKRIH41grMmAkeeMxDUC1RnIJsEUFajEY8KOaR4QNvMAcwkSy5JOFxDIK/J6bn
         APlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlTB0Hmq2OyrCmjJgWGt4qV/3FpNaFjj2tWi0BCPME1PDRIrzNC5+saKYKcOw6Tw1W60tchjkWiu+SB85wgNBxJiQ9pGnIzLhhZt8B
X-Gm-Message-State: AOJu0Yw5BvZY4mop4JZB9/fFfwYZtU+EXEHES/LZwS7y4NkHuuFsTkj7
	yABtwysaxiohhYTukd6IuNglrMLYfDsDhvu9WH2H8/R3mkOjFpAZ47UdZ5cyjI0=
X-Google-Smtp-Source: AGHT+IEsO7vhRxVm7Fc2hwqUeCgM1PR81mOQVEuvXfit0SV++Crjwy29mrjq3FKCuRT4gP9ISH6VZg==
X-Received: by 2002:a2e:9008:0:b0:2d4:5bc6:23a9 with SMTP id h8-20020a2e9008000000b002d45bc623a9mr7998112ljg.33.1710776552717;
        Mon, 18 Mar 2024 08:42:32 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id en10-20020a056402528a00b005693985c35dsm1368700edb.36.2024.03.18.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:42:32 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:42:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 08/26] printk: nbcon: Implement processing in
 port->lock wrapper
Message-ID: <Zfhg5mBd27HmRzQp@alley>
References: <Zdh4eEJJpasEWqa5@alley>
 <87le6oy9vg.fsf@jogness.linutronix.de>
 <ZfMIX8bsftsDNdlm@alley>
 <87sf0rbkp9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf0rbkp9.fsf@jogness.linutronix.de>

On Fri 2024-03-15 16:10:18, John Ogness wrote:
> On 2024-03-14, Petr Mladek <pmladek@suse.com> wrote:
> > Well, it brings another question. Does this allow to have
> > the following situation?
> >
> > CPU0				CPU1
> >
> >   some_function()
> >     uart_port_lock()
> >       // locked just with up->lock
> >       // doing something with the port
> >
> > 				register_console()
> > 				  // add struct console using the same
> > 				  // port as CPU0
> > 				  printk()
> > 				    console_try_lock()
> > 				    console_unlock()
> > 				      console_flush_all()
> > 					// acquire context for the newly
> > 					// registered nbcon
> > 					nbcon_context_try_acquire(ctxt)
> > 					  con->write()
> >
> > BANG: Both CPU0 and CPU1 are writing to the same port.
> >
> > Reason: CPU0 locked only via port->lock.
> > 	CPU1 locked only by acquiring nbcon context.
> 
> Great catch! Yes, this is possible. :-/
> 
> When the kthread series part is introduced, there will be additional
> callbacks that nbcon consoles must implement
> (driver_enter()/driver_exit()). These provide driver-level
> synchronization. In the case of serial uarts, the callbacks map to
> locking/unlocking the port lock.
> 
> If I were to introduce those callbacks in _this_ series, they can be
> used when adding a console to the list in register_console(). This
> changes your example to:
> 
> CPU0				CPU1
> 
>   some_function()
>     uart_port_lock()
>       // locked just with up->lock
>       // doing something with the port
> 
> 				register_console()
> 				  // add struct console using the same
> 				  // port as CPU0
> 				  newcon->driver_enter()
> 				    spin_lock(port_lock)
> 				    // spin on CPU0
>     uart_port_unlock()
> 				  // add new console to console list
> 				  newcon->driver_exit()
> 				    spin_unlock(port_lock)
> 				  ...
> 
> If any other CPUs come in and call uart_port_lock(), they will see the
> console as registered and will acquire the nbcon to avoid the BANG.

Looks good. See below.

> > Maybe, this is not possible because the console is registered when
> > the struct uart_port is being initialized and nobody could
> > use the same port in parallel, except for the early console.
> > Where the early console is serialized using the console_lock().
> 
> Yes, it is possible. Just check out:
> 
>     find /sys/ -name console -type f
> 
> If you echo 'Y' or 'N' into any of those files, you can dynamically
> register and unregister those consoles, respectively.
> 
> I just ran some tests to verify this and was even able to trigger a
> mainline bug because probe_baud() of the 8250 driver is not called under
> the port lock. This is essentially the same scenario you
> illustrated. But the 8250 probe_baud() issue is a driver bug and not
> related to this series.

Thanks a lot for checking it.

> Getting back to this series, my proposal would change register_console()
> like this:
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 68657d4d6649..25a0a81e8397 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3733,6 +3733,7 @@ void register_console(struct console *newcon)
>  	struct console *con;
>  	bool bootcon_registered = false;
>  	bool realcon_registered = false;
> +	unsigned long flags;
>  	int err;
>  
>  	console_list_lock();
> @@ -3831,6 +3832,19 @@ void register_console(struct console *newcon)
>  	if (newcon->flags & CON_BOOT)
>  		have_boot_console = true;
>  
> +	/*
> +	 * If another context is actively using the hardware of this new
> +	 * console, it will not be aware of the nbcon synchronization. This
> +	 * is a risk that two contexts could access the hardware
> +	 * simultaneously if this new console is used for atomic printing
> +	 * and the other context is still using the hardware.
> +	 * 
> +	 * Use the driver synchronization to ensure that the hardware is not
> +	 * in use while this new console transitions to being registered.
> +	 */
> +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> +		newcon->driver_enter(newcon, &flags);
> +
>  	/*
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
> @@ -3855,6 +3869,10 @@ void register_console(struct console *newcon)
>  	 * register_console() completes.
>  	 */
>  
> +	/* This new console is now registered. */
> +	if ((newcon->flags & CON_NBCON) && newcon->write_atomic)
> +		newcon->driver_exit(newcon, flags);
> +
>  	console_sysfs_notify();
>  
>  	/*
> 
> > One solution would be to add nbcon consoles into the console_list
> > under uart_port_lock().
> 
> This is what I have proposed and I think it is the most straight forward
> solution.
> 
> > Another solution would be to make sure that any code serialized
> > by uart_port_lock() will be already synchronized by nbcon context
> > while the nbcon is added into the console_list.
> 
> I do not think this would be acceptable. It would mean that non-console
> ports would need to lock the nbcon. Not only will that slow down the
> non-console ports, but it will also cause serious contention between the
> ports. (Remember, all the ports share the same struct console.)

I actually did not want to lock the nbcon for all ports. This is why
I proposed to do it in con->setup() where con->index is already set.
It might solve the problem without adding yet another callbacks.

That said, I like your solution with newcon->driver_enter()/exit()
callbacks. It seems to have an easier and more straightforward semantic.

Go for it, especially when you need these callbacks later in
the printk kthread.

Nit: I think about renaming the callbacks to"device_lock()
     and device_unlock().

     "(un)lock" probably better describes what the callbacks do.
     register_console() does not want to do any operations
     on the serial port. It just needs to serialize adding
     the console into the list.

     I suggest "device" because the callbacks will lock/unlock
     the tty_driver pointed by "con->device".

> 
> > Maybe, we could do this in con->setup() callback. Something like:
> 
> This proposal would work, but IMHO it adds too much complexity by
> requiring console drivers to implement the callbacks and do special
> things in those callbacks.

Fair enough.

Best Regards,
Petr

