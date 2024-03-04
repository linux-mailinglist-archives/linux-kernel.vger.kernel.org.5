Return-Path: <linux-kernel+bounces-91324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109F870E8F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E212E1F21896
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934447A706;
	Mon,  4 Mar 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06TDOK99"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92511193
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588696; cv=none; b=c4gRz/KIE7ilRvg3NpUTHCf7p8VBPozJPoq17+uPax8K1AaOLj/7YB0A7c2hYTULT3PeqmT3tfAka17JF+lR5QgH9s0LAUYJM+KICeEva9hSGNlZN3CWOasMlfJtQ/KarGhrcrHziru6k9aFoyBM32/dGYigDViMgBqmqL7qHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588696; c=relaxed/simple;
	bh=vnQfVPDee5TR5DXFXuoCLyv9CL2z+tYkFjRkKfEijPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbTZuEFE+ipT3VZCvbxBAwKo6rdnqq100wi8R4Nbe1QIEWBCmP1ksgeVzVK91VXitscr6UQQvE9LrKi05XfqnpaY5uvWtN6DF4LWokvfKKeCRVfXJPuYN7yymNJtPkWo52NdmaIcf0eSafr888KXFBk/ttGXga+scW53KK45frE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06TDOK99; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc744f54d0so75165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709588693; x=1710193493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdHn4GZb8mS5r9CCbE9G4dliiSwjFnsZ8iNZM0tpqSw=;
        b=06TDOK990+J2RWFomRj/GQySLoXhpD7RTIt7xnrmTNK6J4uRhHKa8Cxdf4gz4Qtoyk
         jcJnblnSu3edy8+G15UWUwOl/Ssp5q+zvPGxtUHHL0/nRAi/hKhqRiDuyE5tG6f489/o
         b+UUaDA7yLlRt+tsP3pwNF5/ft0snAca1KXVHSE3NtDMK78agKdZTs2z95MrIx+Vs6Q9
         u9I8X+W+OrOQTNxelFMLtgH9fmXDN7DmgdGpdSt3MldwLYgCbuh0l9jOwG6w+wk9unri
         edqZNXCGrhIG1IFHtfAUg6qm1G2UetVnbF7yUYYABl/8Ix84iPH2rRJnh+5KSq04Hxnt
         YkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588693; x=1710193493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdHn4GZb8mS5r9CCbE9G4dliiSwjFnsZ8iNZM0tpqSw=;
        b=dz+AU0kuYRtfKCu5aEgT/P0K/gxncqmE5VvrRb711s658k2rxVxfXDV6ZAtuCIl6pJ
         hPSh0UFVl0hO1Vkr5SPcdHcUO3dQya46JbsQqr1v7po6ZzhQb9G9+le7XtulE4yNCtvY
         AmVjkUS5DaVcSN4NM9oVsQQcvQHHYcoa6yij6a1w53WNJBkzqb+KzkdL9e/4dbm+ZrHL
         Qh2lsK3tnbtEfQMAuVCRIlqIYOVqFmbdN9a7egpgKeF79d4C3WL+8GgbdC6lUI25kYNG
         qbXeIRPyQ0XIR1cpOrX0RjDV+Dgcgu+2JFeq43IEv8+8FvSHdKXN5Dq3GpmPG2t+/ThX
         6UWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2oAtIUmgF27j3zCECkSictGLfPWdmn7WYaOIYy/bX8RKr5elEZSjyuCVTCEGLmY2azscCrmhidcjjnWBulY6/j6y+DVrK3hUP+tFs
X-Gm-Message-State: AOJu0Yzs9RZY8ZUUAGX1wzZJ/Hhx35tPmAKKG6oSVLAyMnCsFhxq1jB1
	QD4Rd1aLQS7jDPyNQUZI2pTtzTrXllf4HSxcIP9vglDbOWhxh4zT60MUk/Fjxiwmz9RIdx+hSm6
	S8p1Yg6ic5nuwhrW+SroQIQeTWrfVxyizpeTC
X-Google-Smtp-Source: AGHT+IGlRiqVF/I1pYpE4NUWd1ZLLQYcAq+ButRY/vOupZ8HBlb/kszZVF6akgIHib/kDQTm8OC6kJzLCWjs2sgY+6s=
X-Received: by 2002:a17:903:1c2:b0:1db:7057:24df with SMTP id
 e2-20020a17090301c200b001db705724dfmr2059plh.14.1709588692886; Mon, 04 Mar
 2024 13:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226192329.3281301-1-pcc@google.com> <2024030214-buffing-obtuse-8dc8@gregkh>
In-Reply-To: <2024030214-buffing-obtuse-8dc8@gregkh>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 4 Mar 2024 13:44:39 -0800
Message-ID: <CAMn1gO4V2ehZ8JN_+vz1B8xrpTdvHAbQ_G4-y4yAAzST=PUnuw@mail.gmail.com>
Subject: Re: [PATCH v2] serial: Lock console when calling into driver before registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 12:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 26, 2024 at 11:23:26AM -0800, Peter Collingbourne wrote:
> > During the handoff from earlycon to the real console driver, we have
> > two separate drivers operating on the same device concurrently. In the
> > case of the 8250 driver these concurrent accesses cause problems due
> > to the driver's use of banked registers, controlled by LCR.DLAB. It is
> > possible for the setup(), config_port(), pm() and set_mctrl() callbacks
> > to set DLAB, which can cause the earlycon code that intends to access
> > TX to instead access DLL, leading to missed output and corruption on
> > the serial line due to unintended modifications to the baud rate.
> >
> > In particular, for setup() we have:
> >
> > univ8250_console_setup()
> > -> serial8250_console_setup()
> > -> uart_set_options()
> > -> serial8250_set_termios()
> > -> serial8250_do_set_termios()
> > -> serial8250_do_set_divisor()
> >
> > For config_port() we have:
> >
> > serial8250_config_port()
> > -> autoconfig()
> >
> > For pm() we have:
> >
> > serial8250_pm()
> > -> serial8250_do_pm()
> > -> serial8250_set_sleep()
> >
> > For set_mctrl() we have (for some devices):
> >
> > serial8250_set_mctrl()
> > -> omap8250_set_mctrl()
> > -> __omap8250_set_mctrl()
> >
> > To avoid such problems, let's make it so that the console is locked
> > during pre-registration calls to these callbacks, which will prevent
> > the earlycon driver from running concurrently.
> >
> > Remove the partial solution to this problem in the 8250 driver
> > that locked the console only during autoconfig_irq(), as this would
> > result in a deadlock with the new approach. The console continues
> > to be locked during autoconfig_irq() because it can only be called
> > through uart_configure_port().
> >
> > Although this patch introduces more locking than strictly necessary
> > (and in particular it also locks during the call to rs485_config()
> > which is not affected by this issue as far as I can tell), it follows
> > the principle that it is the responsibility of the generic console
> > code to manage the earlycon handoff by ensuring that earlycon and real
> > console driver code cannot run concurrently, and not the individual
> > drivers.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee5=
43fa5b25532de55d8
>
> Why is a link to a gerrit review with no context other than this same
> commit needed here?

I usually add that to my patches so that the progression of the patch
can be tracked. See:
https://lore.kernel.org/all/CAMn1gO53G6-sZE8RiLAD2uERbW1XtvyZbRonNGbHonzD05=
8yAA@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=3DwhFbgy4RXG11c_=3DS7O-248oWmwB_aZOcWzWMV=
h3w7=3DRCw@mail.gmail.com/

> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/tty/serial/8250/8250_port.c |  6 ------
> >  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
> >  kernel/printk/printk.c              | 21 ++++++++++++++++++---
> >  3 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 8ca061d3bbb9..1d65055dde27 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port =
*up)
> >               inb_p(ICP);
> >       }
> >
> > -     if (uart_console(port))
> > -             console_lock();
> > -
> >       /* forget possible initially masked and pending IRQ */
> >       probe_irq_off(probe_irq_on());
> >       save_mcr =3D serial8250_in_MCR(up);
> > @@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port =
*up)
> >       if (port->flags & UPF_FOURPORT)
> >               outb_p(save_ICP, ICP);
> >
> > -     if (uart_console(port))
> > -             console_unlock();
> > -
> >       port->irq =3D (irq > 0) ? irq : 0;
> >  }
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index d6a58a9e072a..ff85ebd3a007 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2608,7 +2608,12 @@ uart_configure_port(struct uart_driver *drv, str=
uct uart_state *state,
> >                       port->type =3D PORT_UNKNOWN;
> >                       flags |=3D UART_CONFIG_TYPE;
> >               }
> > +             /* Synchronize with possible boot console. */
> > +             if (uart_console(port))
> > +                     console_lock();
> >               port->ops->config_port(port, flags);
> > +             if (uart_console(port))
> > +                     console_unlock();
> >       }
> >
> >       if (port->type !=3D PORT_UNKNOWN) {
> > @@ -2616,6 +2621,10 @@ uart_configure_port(struct uart_driver *drv, str=
uct uart_state *state,
> >
> >               uart_report_port(drv, port);
> >
> > +             /* Synchronize with possible boot console. */
> > +             if (uart_console(port))
> > +                     console_lock();
> > +
> >               /* Power up port for set_mctrl() */
> >               uart_change_pm(state, UART_PM_STATE_ON);
> >
> > @@ -2632,6 +2641,9 @@ uart_configure_port(struct uart_driver *drv, stru=
ct uart_state *state,
> >
> >               uart_rs485_config(port);
> >
> > +             if (uart_console(port))
> > +                     console_unlock();
> > +
> >               /*
> >                * If this driver supports console, and it hasn't been
> >                * successfully registered yet, try to re-register it.
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f2444b581e16..f51e4e5a869d 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3263,6 +3263,21 @@ static int __init keep_bootcon_setup(char *str)
> >
> >  early_param("keep_bootcon", keep_bootcon_setup);
> >
> > +static int console_call_setup(struct console *newcon, char *options)
> > +{
> > +     int err;
> > +
> > +     if (!newcon->setup)
> > +             return 0;
> > +
> > +     /* Synchronize with possible boot console. */
> > +     console_lock();
> > +     err =3D newcon->setup(newcon, options);
> > +     console_unlock();
> > +
> > +     return err;
> > +}
> > +
> >  /*
> >   * This is called by register_console() to try to match
> >   * the newly registered console with any of the ones selected
> > @@ -3298,8 +3313,8 @@ static int try_enable_preferred_console(struct co=
nsole *newcon,
> >                       if (_braille_register_console(newcon, c))
> >                               return 0;
> >
> > -                     if (newcon->setup &&
> > -                         (err =3D newcon->setup(newcon, c->options)) !=
=3D 0)
> > +                     err =3D console_call_setup(newcon, c->options);
> > +                     if (err !=3D 0)
>
> Didn't checkpatch complain about this?  It should be:
>                         if (err)
> right?

No, it didn't complain. (It complained about the pre-existing
assignment within an if, which is why I moved it out, but not about
that.) Looks like if (err) is more popular, so I changed it in v3.

> >                               return err;
> >               }
> >               newcon->flags |=3D CON_ENABLED;
> > @@ -3325,7 +3340,7 @@ static void try_enable_default_console(struct con=
sole *newcon)
> >       if (newcon->index < 0)
> >               newcon->index =3D 0;
> >
> > -     if (newcon->setup && newcon->setup(newcon, NULL) !=3D 0)
> > +     if (console_call_setup(newcon, NULL) !=3D 0)
> >               return;
>
> No way to pass an error back here?

The only caller, register_console(), ignores errors from this
function. Arguably it shouldn't, but that's a pre-existing issue.

Peter

