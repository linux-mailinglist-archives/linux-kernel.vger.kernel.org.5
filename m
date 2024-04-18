Return-Path: <linux-kernel+bounces-149890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD48A9771
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B699F1C212A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35E1586F5;
	Thu, 18 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WI0ylXHy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE39433C7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436442; cv=none; b=crirzmOgd0Xt4cgNMdJyzPX0wYSGn+MzX4/CXsj8EbshRESW0nSUs5URzy2yqOTLc2u9RcRHVh099BpvIaCCx9bTg1x9zYUqVSKj54mbESaz/PLDphIlj+077jjhOSDhDtbCD1Ul9+fVzYH451BCSJEeq6LkeTCuG7Ua6UXjPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436442; c=relaxed/simple;
	bh=SNcM7mu59GTQp31Vc554XWfB/6nwJpgSz7akQJF/QzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoIXA86P73F0L9rVELguK50wvvOY5lBBIy5CWVxJluyrcYsMlPXmsIo2VlCErg7x4arcU7RNdCFiDTZD0EMPytBZ36sZB4fl79W57v4fMvZwO0HGAMfTzNDRAkVUCBCz9x/mNlbAoaK6ctPUbsaQSiwhU+nRnKcQI0X78jbHhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WI0ylXHy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343b92e54f5so504233f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713436439; x=1714041239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TqG/vX3kAJfrqS7HQAa54Wgm8mEhmbiwEFcC9upq5k=;
        b=WI0ylXHyEURxWgBTavug8L3glbFz459uGVNM+IlK/rxtKl8HR2uztrpsp6uKM/qdy2
         sIBw7ISyuuskiFEPOKEzSJLaj37fYmCRt6lyqrFFYCINyh5gn7U42TpRbxSVVJYiVLlM
         Ds/fBSEpRF5Cg8Kq2RGq/kX8pipeQwSDl4zU6cgDWFDHz1gFABERcuwd3fsK7KOvvNV9
         H/kQQUhmwy0vJgsBLgQk+Bqt0XV7nhKUHPqgMEVqRAj9RESyeUCVBAo6X7CtJ/Hzw0/t
         f+nyZgf/AAyEe2PKlOxUjlvW5+W72ytXr2IafzNAyFF0gxhvso54CXjkfHweSjAjKfCi
         pyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713436439; x=1714041239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TqG/vX3kAJfrqS7HQAa54Wgm8mEhmbiwEFcC9upq5k=;
        b=hLqdbTkoU4MSBwrN1hZn0wehJGrNx7BynA5U/NOHib/1+5XUeUAK7FUOqnD2aQzNtB
         3vv1g9iNIfuOKKK6TPbOb68scD/J6MuVBa/+yP6k/gSTCxdIYhAltw1mShlgWRU4y01t
         cDpJg+k4kWOrpvxePKV9BaTbdC5QWrqeKxqzzihtPPQ6zOrbYbDhwMeD/MTcLV+kUcEl
         6nJQV7FeGvuAX8Fy82efLwR7OVxsuex9QsY3Au9iQUhn2W/IsuwOLcdlPYcDUP6/7dLE
         FEgLaMDpybEEZ/AaDEy+Z+0kNiG4yjrn2HBNZsaghu9P002PmoFsfCV7b1K7Eubqqeor
         GjrA==
X-Forwarded-Encrypted: i=1; AJvYcCU2foGet6HKlpE7qboVumX5sHhZuIH6mfLXbW0NOCORgTdI3NgG9xZ0F/Fx5bJ3wo5qFQRLHYR/qdWXF6QlWsMAVUFBPUF6OGB3xPkF
X-Gm-Message-State: AOJu0YwGaTWs2JD3Blhu2H7RvSCHVQpzu0IEIiDWoGabPGSZqkViSdnG
	TrLB+lt5KX4vodxiMlnj7AQPqHBvY9B10+5sYhol22TQxnmnE33oPZZBNLe389Y=
X-Google-Smtp-Source: AGHT+IHn0lfIQBhg0+Ainxzp9m4rh0VMSbwQpgI8vxIy2mZz2yTKXXr1YlFSWVrwoKju+BMYZpS/QA==
X-Received: by 2002:adf:f405:0:b0:34a:cc3:806 with SMTP id g5-20020adff405000000b0034a0cc30806mr1133042wro.51.1713436438705;
        Thu, 18 Apr 2024 03:33:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b0034a0d3c0715sm1329748wrs.50.2024.04.18.03.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:33:58 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:33:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <ZiD3FNBZh_iMOVWY@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
 <87y19djqr0.fsf@jogness.linutronix.de>
 <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
 <87bk68niod.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk68niod.fsf@jogness.linutronix.de>

On Wed 2024-04-17 17:00:42, John Ogness wrote:
> On 2024-04-17, Petr Mladek <pmladek@suse.com> wrote:
> >> We want to avoid using nbcon console ownership contention whenever
> >> possible. In fact, there should _never_ be nbcon console owership
> >> contention except for in emergency or panic situations.
> >>
> >> In the normal case, printk will use the driver-specific locking for
> >> synchronization. Previously this was achieved by implementing the
> >> lock/unlock within the write() callback. But with nbcon consoles that
> >> is not possible because the nbcon ownership must be taken outside of
> >> the write callback:
> >> 
> >> con->device_lock()
> >> nbcon_acquire()
> >> con->write_atomic() or con->write_thread()
> >> nbcon_release()
> >> con->device_unlock()
> >
> > This sounds like a strong requirement. So there should be a strong
> > reason
> 
> There is: PREEMPT_RT

This explains it!

I think that a lot of misunderstanding here is caused because
your brain is trained primary in "RT mode" ;-) While I am not
that familiar with the RT tricks and my brain is thinking
in classic preemption mode :-)

I am not sure how it is done in other parts of kernel code where
RT needed to introduce some tricks. But I think that we should
really start mentioning RT behavior in the commit messages and
and comments where the RT mode makes huge changes.


> > when nbcon_acquire() is safe enough in emergency context
> > then it should be safe enough in the normal context either.
> > Otherwise, we would have a problem.
> 
> Of course. That is not the issue.
> 
> > My understanding is that we want to take con->device_lock()
> > in the normal context from two reasons:
> >
> >   1. This is historical, king of speculation, and probably
> >      not the real reason.
> 
> Correct. Not a reason.
> 
> >   2. The con->device() defines the context in which nbcon_acquire()
> >      will be taken and con->write_atomic() called to make it
> >      safe against other operations with the device driver.
> >
> >      For example, con->device() from uart serial consoles would
> >      disable interrupts to prevent deadlocks with the serial
> >      port IRQ handlers.
> >
> >      Some other drivers might just need to disable preemption.
> >      And some (future) drivers might even allow to keep
> >      the preemption enabled.
> 
> (Side note: In PREEMPT_RT, all drivers keep preemption enabled.)

This explains everything. It is a huge game changer.

Sigh, I remember that you told me this on Plumbers. But my
non-RT-trained  brain forgot this "detail". Well, I hope that
I am not the only one and we should mention this in the comments.

> > I still have to shake my head around this. But I would first like
> > to know whether:
> >
> >    + You agree that nbcon_try_acquire() always have to be called with
> >      preemption disabled.
> 
> No, it must not. PREEMPT_RT requires preemption enabled. That has always
> been the core of this whole rework.

Got it! I have completely forgot that spin_lock() is a mutex in RT.

> >    + What do you think about explicitly disabling preemption
> >      in nbcon_try_acquire().
> 
> We cannot do it.
> 
> >    + If it is acceptable for the big picture. It should be fine for
> >      serial consoles. But I think that graphics consoles wanted to
> >      be preemptive when called in the printk kthread.
> 
> In PREEMPT_RT, all are preemptive.
> 
> > I am sure that it will be possible to make nbcon_try_acquire()
> > preemption-safe but it will need some more magic.
> 
> I am still investigating why you think it is not safe (as an inner lock
> for the normal case). Note that for emergency and panic situations,
> preemption _is_ disabled.

The race scenario has been mentioned in
https://lore.kernel.org/r/Zhj5uQ-JJnlIGUXK@localhost.localdomain

CPU0				CPU1

 [ task A ]

 nbcon_context_try_acquire()
   # success with NORMAL prio
   # .unsafe == false;  // safe for takeover

 [ schedule: task A -> B ]


				WARN_ON()
				  nbcon_atomic_flush_pending()
				    nbcon_context_try_acquire()
				      # success with EMERGENCY prio
				      # .unsafe == false;  // safe for takeover

				      # flushing
				      nbcon_context_release()

				      # HERE: con->nbcon_state is free
				      #       to take by anyone !!!


 nbcon_context_try_acquire()
   # success with NORMAL prio [ task B ]
   # .unsafe == false;  // safe for takeover

 [ schedule: task B -> A ]

 nbcon_enter_unsafe()
   nbcon_context_can_proceed()

BUG: nbcon_context_can_proceed() returns "true" because
     the console is owned by a context on CPU0 with
     NBCON_PRIO_NORMAL.

     But it should return "false". The console is owned
     by a context from task B and we do the check
     in a context from task A.


OK, let's look at it with the new RT perspective. Here, the
con->device_lock() plays important role.

The race could NOT happen in:

   + NBCON_PRIO_PANIC context because it does not schedule

   + NBCON_PRIO_EMERGENCY context because we explicitly disable preemption there

   + NBCON_NORMAL_PRIO context when we ALWAYS do nbcon_try_acquire() under
     con->device() lock. Here the con->device_lock() serializes
     nbcon_try_acquire() calls even between running tasks.


Everything makes sense now. And we are probable safe.

I have to double check that we really ALWAYS call nbcon_try_acquire()
under con->device() lock. And I have to think how to describe this
in the commit messages and comments.

Best Regards,
Petr

