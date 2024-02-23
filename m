Return-Path: <linux-kernel+bounces-77763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF848609F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754AF1F22BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28B11199;
	Fri, 23 Feb 2024 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apl/hNve"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151611716
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663078; cv=none; b=CHkjvgD+NBxg4lGvusPdfs+SjkrhvtwmA/STpNSjricGO+GYywX74XM0REiF3f8duMoO1FS/ueTip7Cyd5wap9CtOaTm0Xjz7Oypfw4bEVq7TKMl/sA0JPffNOq7XlEBr/fT9uJl89FTgn66Vh8RPEDnBoO9wQbiYZeflNguGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663078; c=relaxed/simple;
	bh=ojlIzd5GXkuMpOKNCvz+H3NiQsBu9K8ombpH+AmFp/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VTnWR4w+vKGQpTl0iZ9aALbZwCPwVIgT+RZPryVHMm03ybDCQ4nLqjmxfjeolcmmVdfs0v9Ya0Nn/UvrHIDRF5fDF++CTlCayNwfeKlolz+uUDhPvtO9ydOh6HUbrpVpqhWf++A9shS+OsAzmKfyVoLbOmjk/3+t7RYMBVRdkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apl/hNve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708663074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APFoX/WgdLVMECB5h/Tnn4biiRg8V/MPw9fNtGeyrhY=;
	b=apl/hNveb3qTIhhM6HN414EKLxrq6u+dX/XLbAEtzZbUft4jwd5QSSSEBt0R03S/oyFdhx
	DHi7ynU1eNa11ui1fwCpNrjBPmDJQZqfDISrNgb5l7PdfrwKQypkZrVcOXS/LVtFTUg1oH
	ypvlzIxn3lRM+JLJlp/g6llSkuleRVc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-aPZ4pnZRPhCcjf235NW88g-1; Thu, 22 Feb 2024 23:37:52 -0500
X-MC-Unique: aPZ4pnZRPhCcjf235NW88g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d746417ea3so5566155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663072; x=1709267872;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APFoX/WgdLVMECB5h/Tnn4biiRg8V/MPw9fNtGeyrhY=;
        b=wcwm2Z+IGWL3jCnx4eUplL2mSjkTpB87Dy7KuXbMiURxgRObiuf4GSGxusw4yV8fz3
         OK3NJzXNGdUw2e9UwCF5tlgDZsk6cMdmN9JIvp0qOxvv/iIwoCISW61GpaJw+jY06EBt
         9SvcV1ZAK0VBEq4ToC/JA6WAuzmQ9Vpm2QkyCNj3cpa6aJFncLsA4m+jGIKe6XT16VjU
         fj6xlGt35L0B6daCB4r740Lpu6CzdYazrbMdGKyKbjKFFk0SNCwshhd3wBe5XfNX30rv
         CshBJlHwMd55JvWdQMX3pdvYQZ9VjnGpm4kx1+qoHlfHoYUcUjgwGSguiqiCMfnFDTt8
         pQyw==
X-Forwarded-Encrypted: i=1; AJvYcCVrnc7zjTcT62KYSIomlCQDdQKiIIYTscox8vjyo7l71W0J2ndgIccHZQLnZ+otgqjtX+rMabdVcIWaHWbwlmSDKeEznlfvssJIDgFy
X-Gm-Message-State: AOJu0YzQ2r9BSQMse1RQfz4YRCgScryi/58OKKzpHOH7NxTUNqzhz51J
	LY7uZag/ojFButLimRqO7z6zjuLfwCIOiIoVqsjycEvQr8ETUQgL4sAPbhBNbRbwDy11CaZwSE3
	i9Nq/b5HdGJQQFi8Xz5wuH3Uva9bfw1Nu/vCDEnjFva25kxqvioREdyi+qxoxOQ==
X-Received: by 2002:a17:902:cecb:b0:1db:51ee:8677 with SMTP id d11-20020a170902cecb00b001db51ee8677mr1052132plg.59.1708663071522;
        Thu, 22 Feb 2024 20:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSOd6TpdRX4104ZHecY7kiyFUjoc1+/+4lr8XvvgXzoUZMMkMF9ZLPO5FiFh6vd/fyxhaIwA==
X-Received: by 2002:a17:902:cecb:b0:1db:51ee:8677 with SMTP id d11-20020a170902cecb00b001db51ee8677mr1052110plg.59.1708663071083;
        Thu, 22 Feb 2024 20:37:51 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:a28e:99bd:8c92:cf80:d1bd])
        by smtp.gmail.com with ESMTPSA id ks16-20020a170903085000b001dbcb39dd7dsm10285564plb.125.2024.02.22.20.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:37:50 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Fri, 23 Feb 2024 01:37:39 -0300
Message-ID: <ZdghE6TNHgZ_bi19@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <87edd5hljz.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> >> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> >> >> it back to IRQ_HANDLED.
> >> >
> >> > That's not really workable as you'd have to update tons of drivers just
> >> > to deal with that corner case. That's error prone and just extra
> >> > complexity all over the place.
> >
> > I agree, that's a downside of this implementation. 
> 
> A serious one which is not really workable. See below.
> 
> > I agree the above may be able to solve the issue, but it would make 2 extra 
> > atomic ops necessary in the thread handling the IRQ, as well as one extra 
> > atomic operation in note_interrupt(), which could increase latency on this 
> > IRQ deferring the handler to a thread.
> >
> > I mean, yes, the cpu running note_interrupt() would probably already have 
> > exclusiveness for this cacheline, but it further increases cacheline 
> > bouncing and also adds the mem barriers that incur on atomic operations, 
> > even if we use an extra bit from threads_handled instead of allocate a new 
> > field for threads_running.
> 
> I think that's a strawman. Atomic operations can of course be more
> expensive than non-atomic ones, but they only start to make a difference
> when the cache line is contended. That's not the case here for the
> normal operations.
> 
> Interrupts and their threads are strictly targeted to a single CPU and
> the cache line is already hot and had to be made exclusive because of
> other write operations to it.
> 
> There is usually no concurrency at all, except for administrative
> operations like enable/disable or affinity changes. Those administrative
> operations are not high frequency and the resulting cache line bouncing
> is unavoidable even without that change. But does it matter in the
> larger picture? I don't think so.

That's a fair point, but there are some use cases that use CPU Isolation on 
top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
workload.

For those cases, IIRC the handler will run on a different (housekeeping) 
CPU when those IRQs originate on an Isolated CPU, meaning the above 
described cacheline bouncing is expected.


> 
> > On top of that, let's think on a scenario where the threaded handler will 
> > solve a lot of requests, but not necessarily spend a lot of time doing so.
> > This allows the thread to run for little time while solving a lot of 
> > requests.
> >
> > In this scenario, note_interrupt() could return without incrementing 
> > irqs_unhandled for those IRQ that happen while the brief thread is running, 
> > but every other IRQ would cause note_interrupt() to increase 
> > irqs_unhandled, which would cause the bug to still reproduce.
> 
> In theory yes. Does it happen in practice?
> 
> But that exposes a flaw in the actual detection code. The code is
> unconditionally accumulating if there is an unhandled interrupt within
> 100ms after the last unhandled one. IOW, if there is a periodic
> unhandled one every 50ms, the interrupt will be shut down after 100000 *
> 50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
> actually handled interrupts.
> 
> The spurious detector is really about runaway interrupts which hog a CPU
> completely, but the above is not what we want to protect against.

Now it makes a lot more sense to me.
Thanks!

> 
> > I understand my suggested change increases irq_return complexity, but it
> > should not increase much of the overhead in both IRQ deferring and IRQ 
> > thread handling. Also, since it accounts for every IRQ actually handled, it 
> > does not matter how long the handler thread runs, it still avoids the
> > bug.
> 
> I'm not worried about the extra complexity in note_interrupt(). That's
> fine and I don't have a strong opinion whether using your patch 2/4 or
> the simpler one I suggested.
> 
> > As you previously noted, the main issue in my suggestion is about changing 
> > drivers' code. But while this change is optional, I wonder how many 
> > drivers handle IRQs that:
> > - use edge type interrupts, and
> 
> It's not up to the driver to decide that. That's a platform property and
> the driver does not even know and they should not care because all what
> matters for the driver is that it gets the interrupts and does not lose
> anything.
> 
> > - can trigger really fast, many many times, and
> 
> That's a hardware or emulation property and I don't know how many
> devices would expose this behaviour.
> 
> > - can run in force-thread mode, and
> 
> Almost all drivers.
> 
> > - have handlers that are able to deal with multiple IRQs per call.
> 
> Pretty much every driver which has to deal with queues, FIFOs
> etc. That's a lot of them.
> 
> > About solving it directly in generic code, I agree it would be the ideal 
> > scenario. That's why I suggested that in RFCv1: if the thread handles a 
> > single IRQ, we reset irqs_unhandled to zero. That's a good pointer on the 
> > thread being stuck, and TBH I don't think this is too far away from the 
> > current 100/100k if we consider some of those handlers can handle multiple 
> > IRQs at once.
> 
> It has the downside that a scenario where there is a spurious interrupt
> flood with an occasional one inbetween which is handled by the thread
> will not be detected anymore. The accumulation and time period tracking
> are there for a reason.

Ok, fair point.
But if we disable it, we end up not having even those few successes.

But now that I understand the point is preventing the CPU from hogging, it 
makes sense: we prefer disabling the interrupt than compomising the system.
It also makes a warning that may help to track down the driver/device 
issue.

> 
> But as I pointed out above the detection logic is flawed due to the
> unconditional accumulation. Can you give the uncompiled below a test
> ride with your scenario?
> 
> Thanks,
> 
>         tglx
> ---
>  include/linux/irqdesc.h |    2 ++
>  kernel/irq/spurious.c   |   33 +++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -29,6 +29,7 @@ struct pt_regs;
>   * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
>   * @tot_count:		stats field for non-percpu irqs
>   * @irq_count:		stats field to detect stalled irqs
> + * @first_unhandled:	Timestamp of the first unhandled interrupt
>   * @last_unhandled:	aging timer for unhandled count
>   * @irqs_unhandled:	stats field for spurious unhandled interrupts
>   * @threads_handled:	stats field for deferred spurious detection of threaded handlers
> @@ -64,6 +65,7 @@ struct irq_desc {
>  	unsigned int		wake_depth;	/* nested wake enables */
>  	unsigned int		tot_count;
>  	unsigned int		irq_count;	/* For detecting broken IRQs */
> +	unsigned long		first_unhandled;
>  	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
>  	unsigned int		irqs_unhandled;
>  	atomic_t		threads_handled;
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -390,9 +390,14 @@ void note_interrupt(struct irq_desc *des
>  		 * working systems
>  		 */
>  		if (time_after(jiffies, desc->last_unhandled + HZ/10))
> -			desc->irqs_unhandled = 1;
> -		else
> -			desc->irqs_unhandled++;
> +			desc->irqs_unhandled = 0;
> +
> +		if (!desc->irqs_unhandled) {
> +			desc->irq_count = 0;
> +			desc->first_unhandled = jiffies;
> +		}
> +
> +		desc->irqs_unhandled++;
>  		desc->last_unhandled = jiffies;
>  	}
>  
> @@ -411,9 +416,27 @@ void note_interrupt(struct irq_desc *des
>  	if (likely(desc->irq_count < 100000))
>  		return;
>  
> -	desc->irq_count = 0;
>  	if (unlikely(desc->irqs_unhandled > 99900)) {
>  		/*
> +		 * Validate that this is actually an interrupt storm, which
> +		 * happens to:
> +		 *
> +		 *  - increment the unhandled count to ~100k within 10 seconds
> +		 *    which means there is an spurious interrupt every 50us
> +		 *  - have an unhandled to handled ratio > 2
> +		 *
> +		 * Otherwise reset the detector and start over. This also
> +		 * covers the case where a threaded handler consumes
> +		 * several hard interrupts in one go which would otherwise
> +		 * accumulate to 99900 over time and trigger a false positive.
> +		 */
> +		unsigned long td = desc->last_unhandled - desc->first_unhandled;
> +		unsigned int handled = desc->irq_count - desc->irqs_unhandled;
> +
> +		if (td > 5 * HZ || desc->irqs_unhandled / handled < 3)
> +			goto out;
> +
> +		/*
>  		 * The interrupt is stuck
>  		 */
>  		__report_bad_irq(desc, action_ret);
> @@ -428,7 +451,9 @@ void note_interrupt(struct irq_desc *des
>  		mod_timer(&poll_spurious_irq_timer,
>  			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
>  	}
> +out:
>  	desc->irqs_unhandled = 0;
> +	desc->irq_count = 0;
>  }
>  
>  bool noirqdebug __read_mostly;
> 

Sure, I will give it a try.

Now having a better understanding of what is expected here, I will also try 
to experiment a little here.

Thank you!
Leo


