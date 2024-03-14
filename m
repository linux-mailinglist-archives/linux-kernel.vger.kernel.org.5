Return-Path: <linux-kernel+bounces-103394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A743287BED9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4528B4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB79F6FE1F;
	Thu, 14 Mar 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B5CMQvgR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398FD5D8F8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426368; cv=none; b=FlTpytejqb1kaOni6BREH6I5cJ/R6V/QaUFviR8M6GHy1nM7zCFxynfIg5OispBrhHzyPmkRsqWI4dPeqvD+Q1US1Q5Al63tkd6Rz6VpI3KnubKbPHfj//AEces5RgjaA1Y/eje+FHRn8CYMsW+YskC0pOhDQz32vCVzq7G9Hmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426368; c=relaxed/simple;
	bh=/DWu/vw3XtKjMaqmI1AYrcQKGhu0EepK0RVmPULeSrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmH9BNxakodBvGJC0OuyKi6LkbR6dS3mjBTtVfDMQldStGldj0Mpmb82bGYHtZHLMyG5eby/CVUzXV/jGBQg1d4zN0f8MPNu3i3fXb5a3XnKmSrd3nG3sjlEQ8mh1tA0kIc3vl+eHYqZfbI9vwn+Jhlprwj+Pe/ukmakYthPmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B5CMQvgR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512f3e75391so1021177e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710426364; x=1711031164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ4y3HUjMAZOubilbeuIl/T8NgTHZl62/3d+4kkzLcI=;
        b=B5CMQvgR3uJzrxvUg5BL1tfPqcUbWvi64I68cbLNChSWQWj4tFnePVOLWTysw/ZTUV
         M07f6thNT4UTSvcp3B1jFnEaivJEQO1xr+5F1pzAkkybZelj/9AbjXYpuj1MduDkQW/5
         pJ6d+HbO28xWe5kNaaHwnPhQ7bYYX9/5x3RoGdfhkyPdPRMgFPnCtZbAz+dbvMCPSE9r
         hMjocvVCssIXcM6p+P0946kE9reHp6FF0iJ8/UAj9P65JfF2NLe+EY9/8Ar2YyYpGvfw
         MO2VtggOrfcZgy7QF+daYNN+dzyj962BW8RLCQlJF70/N7r5ukpI/TQ+C25sGrskzjnh
         B3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426364; x=1711031164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ4y3HUjMAZOubilbeuIl/T8NgTHZl62/3d+4kkzLcI=;
        b=Jj2B68qj168qQw+rI0AAt9PUR5AgySsJRMxZ5M7qOMa1mKk/ugie+bYXcZKOgvlW//
         tcX8S1dX/1rGl5OeKIRRUL+otHp2K3/jVKlxNLNkhK8u1P7CO+HfF5WNFStS+eFy78yD
         kusU4PK1GXaT2XbyHWz3ET8w7XKzM7UdAFkAQ55PjPwh6JfNPqwlZbcKyYAC2iPwN42R
         X54pG3BX+fGwM0AWcaBvewnXkWexEzX3QL6EoHIajKQVJuKnADznUvFp3mjCpeYPLq9x
         z+kF5i+iNM5O/DVKocJnlm3gMLH2jnaCIkfMLvq2RJVmR/JtJ2D4aFE8JiLWkxAZyxCe
         zuCw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJafzbxvqx1Hwy4bhajBc7e2A13tK8nx2s75mM9hF/5Qccmb9dDR0PdeA4p5aE0Kysmvyy9ct1Q8VT403UgJl7e0FLwNyaOcqlrbN
X-Gm-Message-State: AOJu0YxEperkr8HU8PTPUYxK2Bxlam4MyPrrW1QnBBoFzPwD+3xTZc5x
	iy5zDG6vh2OUIYU2xJualOrY3mAPcnaZs9AYarbqwRkVCy1fpBMktur8uijaCFE=
X-Google-Smtp-Source: AGHT+IH1+iKaJpRe6Iw7ybPZEnv3XEkABouqP7r8eOW32Vh9obkdsNDj95YyagwQk67XkflglUJFIQ==
X-Received: by 2002:a05:6512:1ce:b0:513:7e82:8145 with SMTP id f14-20020a05651201ce00b005137e828145mr1299542lfp.28.1710426364311;
        Thu, 14 Mar 2024 07:26:04 -0700 (PDT)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709064a1700b00a462e5d8d4asm746416eju.114.2024.03.14.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:26:04 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:26:02 +0100
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
Message-ID: <ZfMIX8bsftsDNdlm@alley>
References: <Zdh4eEJJpasEWqa5@alley>
 <87le6oy9vg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le6oy9vg.fsf@jogness.linutronix.de>

On Mon 2024-03-11 18:14:19, John Ogness wrote:
> Hi Petr,
> 
> Thanks for the detailed feedback. Here is a lengthy response. I hope it
> clarifies the uart port and console fields. And I think you identified a
> bug relating to the setup() callback.
> 
> On 2024-02-23, Petr Mladek <pmladek@suse.com> wrote:
> > My main (only) concern was the synchronization of the various accessed
> > variables, especially, port->cons.
> 
> The only issue is if port->cons disappears between lock and unlock. I
> see there is code setting port->cons to NULL, although I do not know
> why. Once port->cons is set, there is never a reason to unset it.

I wonder if it might be needed for hotplugging of the device
or the driver. Well, I would expect that the structures won't exist
when the driver is not loaded and/or the device providing
the port does not exist.

But maybe, it is just a defensive programming style where unused
pointers are cleared.

> Regardless, I will add port->lock synchronization when modifying
> port->cons. There are only a few code sites and they are all during
> driver setup.
> 
> > Note: I am not completely sure how the early and valid console drivers
> >       share the same struct uart_port. So, maybe I miss some important
> >       guarantee.
> 
> The struct uart_port is _not_ shared between the early and normal
> consoles. However, the struct console is shared for normal consoles
> amoung various ports of a particular driver.

I see.

> > Anyway. synchronization of port->cons looks like a shade area.
> > IMHO, the existing code expects that it is used _only when the console
> > is registered_. But this patch wants to access it _even before
> > the console is registered_!
> 
> Indeed. It is not enough for uart_is_nbcon() to check if it is an
> NBCON. It must also check if it is registered, locklessly:
> 
>     hlist_unhashed_lockless(&con->node);
> 
> Most importantly to be sure that nbcon_init() has already been called.
> register_console() clears the nbcon state after cons->index has been
> set, but before the console has been added to the list.

Makes sense.

Well, it brings another question. Does this allow to have
the following situation?

CPU0				CPU1

  some_function()
    uart_port_lock()
      // locked just with up->lock
      // doing something with the port

				register_console()
				  // add struct console using the same
				  // port as CPU0
				  printk()
				    console_try_lock()
				    console_unlock()
				      console_flush_all()
					// acquire context for the newly
					// registered nbcon
					nbcon_context_try_acquire(ctxt)
					  con->write()

BANG: Both CPU0 and CPU1 are writing to the same port.

Reason: CPU0 locked only via port->lock.
	CPU1 locked only by acquiring nbcon context.

Maybe, this is not possible because the console is registered when
the struct uart_port is being initialized and nobody could
use the same port in parallel, except for the early console.
Where the early console is serialized using the console_lock().

Hmm, if the parallel use of struct port_lock is not possible
during register_console then we probably do not even need
to serialize setting and clearing of port->cons.

By other words, I wonder if printk() is the only nasty user of
the uart ports. By "nasty user" I mean:

  + Using the same port even without struct uart_port by
    early console.

  + Using the port via struct uart_port even before the device
    is completely initialized. I assume that register_console()
    is called from the driver init call.

For example, the device/port gets visible in sysfs. I wonder
if anyone could trigger an operation on the port which
it is being registered as a console.

Sigh, if we agree that the above race is possible then I can't think
of any elegant solution.

Well, it might be better to be on the safe side:

One solution would be to add nbcon consoles into the console_list
under uart_port_lock().

Another solution would be to make sure that any code serialized
by uart_port_lock() will be already synchronized by nbcon context
while the nbcon is added into the console_list. Maybe, we
could do this in con->setup() callback. Something like:

 * @need_nbcon_context: true when uart_port_lock() has to acquire
	nbcon context as well

struct uart_port {
	bool need_nbcon_context;

int uart_console_setup(struct console *con, char *options)
{
	struct uart_8250_port *up = &serial8250_ports[co->index];

	spin_lock_irq(&up->lock);
	up->need_nbcon_context=true;
	spin_unlock_irq(&up->lock);

	// do whatever the original uart_console_setup did
}

int uart_console_exit(struct console *con, char *options)
{
	struct uart_8250_port *up = &serial8250_ports[co->index];

	// do whatever the original uart_console_exit did

	spin_lock_irq(&up->lock);
	up->need_nbcon_context=false;
	spin_unlock_irq(&up->lock);
}

We might even use this variable in uart_nbcon_acquire() to
decide whether we need to acquire the context or not.


> > For example, it took me quite a lot of time to shake my head around:
> >
> > #define uart_console(port) \
> > 	((port)->cons && (port)->cons->index == (port)->line)
> >
> >   + port->cons and port->line are updated in the uart code.
> >     It seems that the update is not serialized by port->lock.
> >     Something might be done under port->mutex.
> >
> >   + cons->index is updated in register_console() under
> >     console_list_lock.
> >
> > Spoiler: I propose a solution which does not use uart_console().
> 
> This check is necessary because multiple ports of a driver will set and
> share the same port->cons value, even if they are not really the
> console. I looked into enforcing that port->cons is NULL if it is not a
> registered console, but this is tricky. port->cons is driver-internal
> and hidden from printk. The driver will set port->cons in case it
> becomes the console and printk will set cons->index once it has chosen
> which port will be the actual console. But there is no way to unset
> port->cons if a port was not chosen by printk.
> 
> The various fields have the following meaning (AFAICT):
> 
> port->line: An identifier to represent a particular port supported by a
> driver.
> 
> port->cons: The struct console to use if this port is chosen to be a
> console.
> 
> port->console: Boolean, true if this port was chosen to be a
> console. (Used only by the tty layer.)
> 
> cons->index: The port chosen by printk to be a console.
> 
> None of those fields specify if the port is currently registered as a
> console. For that you would need to check if port->cons->node is hashed
> and then verify that port->line matches port->cons->index. This is what
> uart_nbcon_acquire() needs to do (as well as check if it is an nbcon
> console).

This is a great description. It would be great to have it somewhere in
the sources. Maybe, above the locking/acquire functions.

> >> --- a/drivers/tty/serial/8250/8250_port.c
> >> +++ b/drivers/tty/serial/8250/8250_port.c
> >> @@ -3284,6 +3284,7 @@ void serial8250_init_port(struct uart_8250_port *up)
> >>  	struct uart_port *port = &up->port;
> >>  
> >>  	spin_lock_init(&port->lock);
> >> +	port->nbcon_locked_port = false;
> >
> > I am not sure if the variable really helps anything:
> >
> >    + nbcon_context release() must handle the case when it
> >      lost the ownership anyway.
> 
> uart_nbcon_release() must first check if the provided port is a
> registered nbcon console. A simple boolean check is certainly faster
> than the 4 checks mentioned above. After all, if it was never locked,
> there is no reason to unlock it.

Fair enough.

> > We just need to make sure that port->cons can be cleared only
> > under port->lock. But this would be required even with
> > port->nbcon_locked_port.
> 
> Agreed. I will add this.
> 
> >> --- a/kernel/printk/nbcon.c
> >> +++ b/kernel/printk/nbcon.c
> >> +void uart_nbcon_acquire(struct uart_port *up)
> >> +{
> >> +	struct console *con = up->cons;
> >> +	struct nbcon_context ctxt;
> >
> > I would add:
> >
> > 	lockdep_assert_held(&up->lock);
> 
> OK.
> 
> >> +
> >> +	if (!uart_is_nbcon(up))
> >> +		return;
> >> +
> >> +	WARN_ON_ONCE(up->nbcon_locked_port);
> >> +
> >> +	do {
> >> +		do {
> >> +			memset(&ctxt, 0, sizeof(ctxt));
> >> +			ctxt.console	= con;
> >> +			ctxt.prio	= NBCON_PRIO_NORMAL;
> >> +		} while (!nbcon_context_try_acquire(&ctxt));
> >> +
> >> +	} while (!nbcon_context_enter_unsafe(&ctxt));
> >> +
> >> +	up->nbcon_locked_port = true;
> >> +}
> >> +EXPORT_SYMBOL_GPL(uart_nbcon_acquire);
> >
> > I would prefer to split the uart and nbcon specific code, for example:
> 
> Can you explain why? This code will not be used anywhere else.

It would have helped me with the review. The function is short
but it touches internals from both uart_port and nbcon words:

  + Implements new variant of nbcon_ctxt_acquire() API (busy loop, no timeout)

  + Checks and modifies struct uart_port details which affect
    uart_port_lock() API.

IMHO, there is too much to think about in a single function ;-)


Best Regards,
Petr

