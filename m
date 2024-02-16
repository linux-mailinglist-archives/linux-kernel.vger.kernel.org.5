Return-Path: <linux-kernel+bounces-69271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF2858677
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3401C20F89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCD9137C50;
	Fri, 16 Feb 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiS94GIc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4431369B4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113517; cv=none; b=uZTiOTww2m31I8dbffzw9/fGjgnUGWUh+cjaj9teqr/wBVXUld99nUuphGM3FI9LSJ3fXReS450e2t9pqKVKeGUNwx2b/+y9t8xvM2LLJMbFRUKUYFHEudsH3VUSCqrcElvKS5TegTxa0Oqc4yTOpcUmRBQw+I7NGN+Nwmjvq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113517; c=relaxed/simple;
	bh=Y6CA/0eXmsk2eZWqeDuAH9gz/qp6eh4914mbH0EVdkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=tLj79sQYUahKqPJeks6rGq5LaDUP2tyu3dmaW+yRMNSg4X9KLZsk8qe2wLcG/DZNrsDpUycWgg3oCE1CQZ7GfQoVrbj9nMXIzl50nojts/ZvMCrQdJkiSmLMpKfEk6yF293eMZmKBdx/hz7E2zSrvDpYPqhjEgUfvVFfE7hrEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiS94GIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708113512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q2M0pDMLhIbJFR8+0n3bXsPc6PTg3nS9JCcltQaK0U=;
	b=fiS94GIcWYV1ywc6Bp4LtgRPMlALvJC+xymLU5N1WhCw0elqmGhtuneCw/ikdoKVomjp3u
	/WYlsuJNX9MZpRzLV4zQKLS9CCR1TeNF+uEKbRiepN4iEu6tpfL8POMOInVS2Y7r7WoF5q
	akHUc0ZxeXfnJJ4zYfFIyDWIHM+Rb9I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-MD7GTr3dNzORwlWSEnethg-1; Fri, 16 Feb 2024 14:58:29 -0500
X-MC-Unique: MD7GTr3dNzORwlWSEnethg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c0383a9522so3398462b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113508; x=1708718308;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q2M0pDMLhIbJFR8+0n3bXsPc6PTg3nS9JCcltQaK0U=;
        b=Jz3urvtO99uElB9fQ2V0b40QA8jgJKPNMya//0lg4PvKMXcdxKFRh4LerwBD4e2wyO
         fBVVVJcYP5jppkqCrb0ILCVjR23LDh1MtBcKyAWz4SMCURpuPQCj4vpPVimp92nrYcKy
         gtRIy/y0230PHgzS1sjuJE6d92uFrC6qCVUBYveWYuQ724/X0B8LBt08hq8QxeVIbqNJ
         vsJpU7t/EfKI6yeeFl2+mntUZNwjav5J6Ky5q7L7MBBmgf5G8DkuPR/qrEsNrkDJN1u4
         DrRrz7rW4hGNW+dC/EMQOs+XhUbcj78/7oux9YrTPqMebczejd89amMiT+mH8RrM2/Aw
         Z3bw==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ3wwK3Q+3g1IBnUkkfDWPXZtsMagE0Yl7vs0gH4GtbsgO7gIvwDqrcdevxUqFwQyO1VoQJt9bKpEXcHjZx7nFH+RmG/A8vz294S0
X-Gm-Message-State: AOJu0YyEmRr6fhtNobIWQiCV+YGNI5UGtTi76icJujdZAa39tSMA0ot7
	uMS3HyFG1LZMXHYzzXCj9e8uEBhJ2yC8RjKLKlLp2Z8Gl9s3ZuJcBBphi2SXWlm6XEdqKKWZraA
	CrXNezKdtZ7fXoI2zfe7HtXN+uAutLztpFOgyELB3z4zTpR7WUOI1Fj9bT4COyg==
X-Received: by 2002:a05:6808:624d:b0:3c1:3489:f451 with SMTP id dt13-20020a056808624d00b003c13489f451mr5820934oib.54.1708113508492;
        Fri, 16 Feb 2024 11:58:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0gISsbHtKmdg+cmjm/kbPbQhCGSpGQpDeFj7BkHPIY4wbXdxIi1dqz2qkxCbH7bT8x9gavA==
X-Received: by 2002:a05:6808:624d:b0:3c1:3489:f451 with SMTP id dt13-20020a056808624d00b003c13489f451mr5820924oib.54.1708113508191;
        Fri, 16 Feb 2024 11:58:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id lq4-20020a0562145b8400b0068f1275b017sm232911qvb.24.2024.02.16.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:58:27 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/4] tty/serial8250: Make use of IRQ_HANDLED_MANY interface
Date: Fri, 16 Feb 2024 16:58:20 -0300
Message-ID: <Zc--XMryevBFYetZ@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <8c080e51-6ae5-0e8a-69f6-ca3666164248@linux.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-6-leobras@redhat.com> <8c080e51-6ae5-0e8a-69f6-ca3666164248@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 16, 2024 at 12:12:44PM +0200, Ilpo Järvinen wrote:
> On Fri, 16 Feb 2024, Leonardo Bras wrote:
> 
> > For every TX byte an IRQ is requested.
> > On threaded IRQs, the handler calls serial8250_tx_chars can send multiple
> > bytes, limited to it's queue size (tx_loadsz).
> 
> Perhaps I'm missing something here but I don't understand what this tries 
> to say.
> 
> - 8250 driver gets TX empty IRQ
> - We write x bytes to FIFO
> - UART blasts those bits to wire, eventually emptying FIFO
> - We get the next TX empty IRQ
> 
> What in this makes "for every TX byte an IRQ is requested" true? There's 
> one IRQ only for every x bytes TX'ed as far as I can tell!?!
> 

Context:
I created a C program for writting data to the serial by opening /dev/ttyS0 
and fprintf() strings of about 100bytes to it. This fprintf() runs alone in 
a for loop. This is compiled with GCC.

I noticed that it will create an IRQ for every char written to ttyS0.
Maybe I missed something, and this is not a rule, but that's what I 
perceived as an average.

My scenario:
- Linux compiled with force_irqthreads = true
- serial8250 used as a serial terminal (emulated by qemu)

For non-irqthreads it works just fine.

But in this (force_irqthreads = true) scenario the IRQ will get triggered a 
lot of times, and the threaded handler runs only sometimes, which makes it 
easy for the IRQs to be handled in batch, which is fine.

The issue: this causes irqs_unhandled to be incremented once every time 
note_interrupt() did not perceive a change in threads_handled. Since the 
threads_handled increments in batches, it means many of those IRQs will be 
considered "unhandled", leading to the serial8250 IRQ to be disabled.

I created a way (patches 2 & 3) to account for how many IRQ requests have 
actually been handled by a handler, if that handler can deal with them in 
batches. 

This patch is about me trying to make serial8250 report how many IRQs it 
handled, by using the (possibly incorrect) information that it will cause 
1 IRQ per tx-byte.

This 1 IRQ/tx-byte info was perceived by tracing the IRQ count and the 
number of bytes sent. It was also reinforced by serial8250_tx_chars() which 
seems to transmit 1 byte at a time, even though it repeats that up to FIFO 
size (up->tx_loadsz) in that function.

If that proves to be not correct, I will need to find a way of tracking 
the number of IRQs handled in that scenario, so the IRQ disabling thing can 
be avoided.

Does it make sense?

Thanks!
Leo

> -- 
>  i.
> 
> > When this happens, the handler return IRQ_HANDLED with reduces the
> > unhandled IRQ counter only by 1, even though many requests have been
> > handled at once.
> > 
> > This causes the unhandled IRQ counter to go up until it reaches the maximum
> > and causes the registered IRQ to be disabled, thus breaking the serial
> > console.
> > 
> > Make use of the newly introduced IRQ_HANDLED_MANY interface to return the
> > number of requests handled, so the unhandled IRQ counter can get decreased
> > accordingly.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  include/linux/serial_8250.h         |  2 +-
> >  drivers/tty/serial/8250/8250_core.c | 13 ++++++++-----
> >  drivers/tty/serial/8250/8250_port.c | 16 ++++++++++------
> >  3 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> > index ec46e3b49ee99..c9d4271b71d70 100644
> > --- a/include/linux/serial_8250.h
> > +++ b/include/linux/serial_8250.h
> > @@ -200,7 +200,7 @@ int fsl8250_handle_irq(struct uart_port *port);
> >  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> >  u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
> >  void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
> > -void serial8250_tx_chars(struct uart_8250_port *up);
> > +int serial8250_tx_chars(struct uart_8250_port *up);
> >  unsigned int serial8250_modem_status(struct uart_8250_port *up);
> >  void serial8250_init_port(struct uart_8250_port *up);
> >  void serial8250_set_defaults(struct uart_8250_port *up);
> > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > index ae637155fe7cd..2fab9102eec45 100644
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -110,7 +110,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  {
> >  	struct irq_info *i = dev_id;
> >  	struct list_head *l, *end = NULL;
> > -	int pass_counter = 0, handled = 0;
> > +	int pass_counter = 0, handled_total = 0;
> >  
> >  	pr_debug("%s(%d): start\n", __func__, irq);
> >  
> > @@ -120,15 +120,18 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  	do {
> >  		struct uart_8250_port *up;
> >  		struct uart_port *port;
> > +		int handled;
> >  
> >  		up = list_entry(l, struct uart_8250_port, list);
> >  		port = &up->port;
> >  
> > -		if (port->handle_irq(port)) {
> > -			handled = 1;
> > +		handled = port->handle_irq(port);
> > +		if (handled) {
> > +			handled_total += handled;
> >  			end = NULL;
> > -		} else if (end == NULL)
> > +		} else if (end == NULL) {
> >  			end = l;
> > +		}
> >  
> >  		l = l->next;
> >  
> > @@ -140,7 +143,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  
> >  	pr_debug("%s(%d): end\n", __func__, irq);
> >  
> > -	return IRQ_RETVAL(handled);
> > +	return IRQ_RETVAL_MANY(handled_total);
> >  }
> >  
> >  /*
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index f799c34f1603c..74d53507a73d4 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -1802,7 +1802,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_rx_chars);
> >  
> > -void serial8250_tx_chars(struct uart_8250_port *up)
> > +int serial8250_tx_chars(struct uart_8250_port *up)
> >  {
> >  	struct uart_port *port = &up->port;
> >  	struct circ_buf *xmit = &port->state->xmit;
> > @@ -1810,15 +1810,15 @@ void serial8250_tx_chars(struct uart_8250_port *up)
> >  
> >  	if (port->x_char) {
> >  		uart_xchar_out(port, UART_TX);
> > -		return;
> > +		return 0;
> >  	}
> >  	if (uart_tx_stopped(port)) {
> >  		serial8250_stop_tx(port);
> > -		return;
> > +		return 0;
> >  	}
> >  	if (uart_circ_empty(xmit)) {
> >  		__stop_tx(up);
> > -		return;
> > +		return 0;
> >  	}
> >  
> >  	count = up->tx_loadsz;
> > @@ -1858,6 +1858,9 @@ void serial8250_tx_chars(struct uart_8250_port *up)
> >  	 */
> >  	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
> >  		__stop_tx(up);
> > +
> > +	/* Return number of chars sent */
> > +	return up->tx_loadsz - count;
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_tx_chars);
> >  
> > @@ -1923,6 +1926,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> >  	bool skip_rx = false;
> >  	unsigned long flags;
> >  	u16 status;
> > +	int handled = 0;
> >  
> >  	if (iir & UART_IIR_NO_INT)
> >  		return 0;
> > @@ -1956,14 +1960,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
> >  	serial8250_modem_status(up);
> >  	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
> >  		if (!up->dma || up->dma->tx_err)
> > -			serial8250_tx_chars(up);
> > +			handled = serial8250_tx_chars(up);
> >  		else if (!up->dma->tx_running)
> >  			__stop_tx(up);
> >  	}
> >  
> >  	uart_unlock_and_check_sysrq_irqrestore(port, flags);
> >  
> > -	return 1;
> > +	return handled ? : 1;
> >  }
> >  EXPORT_SYMBOL_GPL(serial8250_handle_irq);
> >  
> > 
> 


