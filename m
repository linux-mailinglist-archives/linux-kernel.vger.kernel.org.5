Return-Path: <linux-kernel+bounces-27691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD482F42D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6A21C208D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2441CD39;
	Tue, 16 Jan 2024 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfPMf26m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C01CD2B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429465; cv=none; b=c2Om4HYIEqY1AK6io7f3SsNX75F5aI/kuVJ/N98xqhn9dBAp4moNvaWQTznaWHoxOdzMjfq2X21jr7Q4bQnpFRi0w8QjrHlt0Uu9h1xmpd40o85o1gnL9kO7rRqRjlL2VqVf4M6Sl2+GOxD122B0A///yS12YgXul9EJYRNlfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429465; c=relaxed/simple;
	bh=C4NW4/xdipV3PZIsEE1qEeN40hdxEeW+JyPTTrGqC7g=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=qdFaXdXQALXl/HqaY/cg3DXtMLn1xdm+yxTOLxeckmzQhv6thZ/J6hulqg282nFl+CSbyhafPqwAbGT3DKxNbB72qr6UULTjVlw5q7EtlaRZxyIWDy+y2hhtfTx5a8ueRtQDOWnIjdyzBGh03b85V+djpLQk/jqgSjPR1MvdYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfPMf26m; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705429462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZXROdG3HVxdOQP6p836Pie8H/kxnzXhwaCBYdybx0o=;
	b=FfPMf26m2ej0MSr2bOnsQ2mq39ahgjwQn9VKaVuJI2aFZUmAZgYeIgb3zmSn2kq3AalyO+
	Aw8NUhw4txf/diQPz5fUhrHOrtu+tmTL+8G5IOy7RanQid0KoKmRkmgcpzmXzzLEubVPVf
	CEXuLJbXTNu5r3PmZWzEB17lKXw1i08=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-GS3UT3J5NOiW3yszW68-TA-1; Tue, 16 Jan 2024 13:24:15 -0500
X-MC-Unique: GS3UT3J5NOiW3yszW68-TA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd6cde14easo1832715b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429454; x=1706034254;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZXROdG3HVxdOQP6p836Pie8H/kxnzXhwaCBYdybx0o=;
        b=O28VDxWxsxn4FHlZd3cRlH9bKLujUaAGb0RLpEr1yR1EPBTGZVpMKLRuD2hZ3cV01N
         x4CvatCaGV0TYYJmG7UPHQG9DDFE5IkSDs+FiBH9p2UuCq8grlYsLVU3JICECI67Z4J/
         92cDuvNfL1Hj3RLZmMbnC4uc2nFB84l0nFc+fJNCp26V7vh8knHqs2z7oOivoQRYbIPV
         Qf9iB1Og0jqBOGQVKbzKXOk7bsq2/998+spKqdsCjvYsCcl5+RhoeR7vc+Yr3Hsb+597
         0D3nmTQ6WP2AlCcqrnMkdTJCh6idxv+h6atYGpY1NCqL1JNe0yRwZ6pgYKpmSwpU2wG2
         yR2w==
X-Gm-Message-State: AOJu0Yx8oePNuJc1oxNe5fKWyG2ORqf3Mu0YxCCYMMQfD2KkMvKSmI5G
	Bqrq4sNBSQbAe0Iyf593RID9vnENzQRSGDp5Bmbn+LkemUP77aGvG9g1Yn5bPJnxe5kbcrBEk43
	5QGtLuJbEIupyMRH7tLpp4isjiPCQsntl
X-Received: by 2002:a05:6808:3991:b0:3bd:7224:cfac with SMTP id gq17-20020a056808399100b003bd7224cfacmr4190178oib.63.1705429454779;
        Tue, 16 Jan 2024 10:24:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcammen5njJpgCvLKraAue9v8Z+qwiJCQA1k3kV0EMgCf1JohJ2KGTo9HzNr5pLcHunHsLqQ==
X-Received: by 2002:a05:6808:3991:b0:3bd:7224:cfac with SMTP id gq17-20020a056808399100b003bd7224cfacmr4190162oib.63.1705429454497;
        Tue, 16 Jan 2024 10:24:14 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b00429ff82eb74sm1116364qtw.82.2024.01.16.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:24:14 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Tue, 16 Jan 2024 15:24:10 -0300
Message-ID: <ZabJyq_y28tN1kuT@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dd85dd1c-1352-4136-9a06-00066435a1ba@kernel.org>
References: <20240116073234.2355850-2-leobras@redhat.com> <20240116073234.2355850-4-leobras@redhat.com> <dd85dd1c-1352-4136-9a06-00066435a1ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 16, 2024 at 08:49:14AM +0100, Jiri Slaby wrote:
> On 16. 01. 24, 8:32, Leonardo Bras wrote:
> > With PREEMPT_RT enabled, a spin_lock_irqsave() becomes a possibly sleeping
> > spin_lock(), without preempt_disable() or irq_disable().
> > 
> > This allows a task T1 to get preempted or interrupted while holding the
> > port->lock. If the preempting task T2 need the lock, spin_lock() code
> > will schedule T1 back until it finishes using the lock, and then go back to
> > T2.
> > 
> > There is an issue if a T1 holding port->lock is interrupted by an
> > IRQ, and this IRQ handler needs to get port->lock for writting (printk):
> > spin_lock() code will try to reschedule the interrupt handler, which is in
> > atomic context, causing a BUG() for trying to reschedule/sleep in atomic
> > context.
> > 
> > So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
> > fails proceed anyway, just like it's done in oops_in_progress case.
> 
> Hmm, that appears incorrect to me.
> 
> Perhaps we need a raw spin lock? Or maybe I am totally off, as my RT
> knowledge is close to zero.

If we have a raw_spin_lock_irqsave() here, it would hurt RT by a lot since 
disabling interrupts is usually bad at the RT kernel, and serial console 
can be used a lot.

> 
> This needs advices from RT folks...

Agree. All help is welcome in this case!

Thanks!
Leo

> 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >   drivers/tty/serial/8250/8250_port.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 8ca061d3bbb92..8480832846319 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3397,7 +3397,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >   	touch_nmi_watchdog();
> > -	if (oops_in_progress)
> > +	if (oops_in_progress || (IS_ENABLED(CONFIG_PREEMPT_RT) && in_atomic())
> >   		locked = uart_port_trylock_irqsave(port, &flags);
> >   	else
> >   		uart_port_lock_irqsave(port, &flags);
> 
> -- 
> js
> suse labs
> 


