Return-Path: <linux-kernel+bounces-27685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DE82F419
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B4128B26C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59391CD27;
	Tue, 16 Jan 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORSAlEKa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECC1CF81
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429282; cv=none; b=hXX47VjZnWCy/pOnzzyWPKM6jhZiZJASfEFTSopV1sLt1EqsUgYnmUkwnvrAu+PRetT8ktvNEq3go4sWhR7KvfMNJVm161S066e8+xLRWYq0Cg/QH+oN7/qPzG8UAhmivUyIU3cBM1XQN4+OnOc8mZzvMhbejw2tfacfUeTO7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429282; c=relaxed/simple;
	bh=ntvUfZcJ6fLFQU7RCJq28zrBOZDjmiFD00Rcqw9X3zc=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding; b=lVylCXj6pqK1/atQ4+ep3/sh1MBfR/0oN/KMYK7PDAtwTdIKRHrjQBTDohmern3UrrnNZmS39u2VOpUJCNGzJHPmpMV7jGc+K24pgw0fBUO+FYe5jYrLEGsJoz8evxu+KeSp0S26eRIfVFhCXHoRgfc9VWEv42cCbhNBkM3DJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORSAlEKa; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705429280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifZ91Hcy8IlnSUd8dHVnZjZ7aBykwrbLrRLSb8RkcSM=;
	b=ORSAlEKaYGEHDOGCcdJz3OvxClVCD2xLJa7R7+wiCiwxbvYbmV5ZoSbmeH4d3BFmuxbuDW
	IKe3mgDwmAyvLr3rs32RRHiS1h++TEgTHNgWZsjflO3M4Efn65vyCYKahhpSTqPh9e1/Vx
	OtIL1wxRPjYx3hqofn66lgNalRc2l/g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-MkundptRN--jMmmoZ3wUnA-1; Tue, 16 Jan 2024 13:21:19 -0500
X-MC-Unique: MkundptRN--jMmmoZ3wUnA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7831bc14ae3so1406985785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429277; x=1706034077;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifZ91Hcy8IlnSUd8dHVnZjZ7aBykwrbLrRLSb8RkcSM=;
        b=ZzokzykEr1Pr8TQNkAwqCif0JILYoOhXXw0jPjqR0VP0iokSbgNSBlWDyYyR939B3l
         EDGB1QYBvaDGe4xUWc0T2cTnjeEfH3Yc3rhjB9zkacDL/fxH9J5hUSe61TpaapExd6mc
         bFFbeJ7dbkEUlicM/YQHwFlGkt3nZ2mDe+XlHqw63qdu2bGQpE6Hr8i4InV0KMkwt3md
         XpRgxqwr2QnIjLmHNqTnTsKn1QAuPdCaccBtyiYgpbMYFVI6nbTMDimXaJWr78gbL72r
         9TtLT7AApypN1nWdX201Jkv0CbxaAsmKk5qddeacg4A1TFeJU6qBLaQ9fUXZAJIAqn32
         bxcQ==
X-Gm-Message-State: AOJu0YwpJtPoSbN2E5MJJ2RuUHLDPsPAcWcp1fVGu/6pF0m1ePWhqeae
	SbiSJ42ZnepqAIa2nbKnKw7GDiX/yi74DwObw0K8Wekgit+ZwbSwvYh2NzjzSyHKr3CRp2HICCH
	WmM+sSrIq6RsZvJ7rNZ5zj37UFtSPipg5
X-Received: by 2002:a05:620a:8110:b0:781:630e:6db0 with SMTP id os16-20020a05620a811000b00781630e6db0mr9177917qkn.113.1705429277646;
        Tue, 16 Jan 2024 10:21:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV1f1ojOSOiuzfaJrw+J3GKczhttmGoWGYH1H1A2lSz6rIHTA421p+Hq7NlDcQmh1Q/Cv0vQ==
X-Received: by 2002:a05:620a:8110:b0:781:630e:6db0 with SMTP id os16-20020a05620a811000b00781630e6db0mr9177892qkn.113.1705429277158;
        Tue, 16 Jan 2024 10:21:17 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:64aa:6db9:6544:60c:9e16])
        by smtp.gmail.com with ESMTPSA id g6-20020a05620a13c600b0078336444622sm3905036qkl.128.2024.01.16.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:21:16 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v1 2/2] serial/8250: Avoid getting lock in RT atomic context
Date: Tue, 16 Jan 2024 15:21:13 -0300
Message-ID: <ZabJGefGkrs0SNzW@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-3-leobras@redhat.com> <75a39f0a-8f79-eacf-4a35-5de512a3cbed@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 16, 2024 at 10:48:44AM +0200, Ilpo Järvinen wrote:
> On Tue, 16 Jan 2024, Leonardo Bras wrote:
> 
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

Hello Ilpo, thanks for replying!

> 
> I thought that the printk side was supposed to be become aware when it's 
> not safe to write to serial side so the printing can be deferred... Has 
> that plan changed?
> 
> -- 
>  i.

I was not aware of this plan.

Well, at least in an PREEMPT_RT=y kernel I have found this same bug 
reproducing several times, and through the debugging that I went through I 
saw no mechanism for preventing it.

This is one example of the bug:
While writing to serial with serial8250_tx_chars in a irq_thread handler
there is an interruption, and __report_bad_irq() tries to printk 
stuff to the console, and when printk goes down to 
serial8250_console_write() and tried to get the port->lock, which causes 
the "BUG: scheduling while atomic":

[   42.485878] irq 4: nobody cared (try booting with the "irqpoll" option)
[   42.485886] BUG: scheduling while atomic: irq/4-ttyS0/751/0x00010002
[   42.485890] Modules linked in:
[   42.485892] Preemption disabled at:
[   42.485893] [<ffffffff8118ac80>] irq_enter_rcu+0x10/0x80
[   42.485919] CPU: 0 PID: 751 Comm: irq/4-ttyS0 Not tainted 6.7.0-rc6+ #6
[   42.485927] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-1.el9 04/01/2014
[   42.485929] Call Trace:
[   42.485940]  <IRQ>
[   42.485944]  dump_stack_lvl+0x33/0x50
[   42.485976]  __schedule_bug+0x89/0xa0
[   42.485991]  schedule_debug.constprop.0+0xd1/0x120
[   42.485996]  __schedule+0x50/0x690
[   42.486026]  schedule_rtlock+0x1e/0x40
[   42.486029]  rtlock_slowlock_locked+0xe7/0x2b0
[   42.486047]  rt_spin_lock+0x41/0x60
[   42.486051]  serial8250_console_write+0x1be/0x460
[   42.486094]  console_flush_all+0x18d/0x3c0
[   42.486111]  console_unlock+0x6c/0xd0
[   42.486117]  vprintk_emit+0x1d6/0x290
[   42.486122]  _printk+0x58/0x80
[   42.486139]  __report_bad_irq+0x26/0xc0
[   42.486147]  note_interrupt+0x2a1/0x2f0
[   42.486155]  handle_irq_event+0x84/0x90
[   42.486161]  handle_edge_irq+0x9f/0x260
[   42.486168]  __common_interrupt+0x68/0x100
[   42.486178]  common_interrupt+0x9f/0xc0
[   42.486184]  </IRQ>


Thanks!
Leo

> 
> > So for the case (PREEMPT_RT && in_atomic()) try to get the lock, and if it
> > fails proceed anyway, just like it's done in oops_in_progress case.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 8ca061d3bbb92..8480832846319 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3397,7 +3397,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >  
> >  	touch_nmi_watchdog();
> >  
> > -	if (oops_in_progress)
> > +	if (oops_in_progress || (IS_ENABLED(CONFIG_PREEMPT_RT) && in_atomic())
> >  		locked = uart_port_trylock_irqsave(port, &flags);
> >  	else
> >  		uart_port_lock_irqsave(port, &flags);
> > 
> 


