Return-Path: <linux-kernel+bounces-74091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826F85CFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BB1C20BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8639AFE;
	Wed, 21 Feb 2024 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPy/t3bg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFD3A1B1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493986; cv=none; b=hkxDhyvgp5gSUOL4sUqPFPkHani2eTKhudd2x/azGoTfgUTkbl2msP+Ry48UpEPl8kUHxJz187A83ZysyEmMaNz6kPflsRvCAvy+duLVOABUqpPx4O0Ckf093s7EU1wnKrSZGzDQU3qCfFIKD/5nmTjyZWc+aybVOFnIEHisrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493986; c=relaxed/simple;
	bh=+TbXERsFDqvDHIsuaYvrIBRok6TpjQ5bwI6401S0zcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=d3tz3+oxMbnYNSpzMzo10qUbrLRNevKCyXN7Zkdyr5zme+2chUj93HFAnsiqMzW3YbC1bgrqUkX9OZUwtiDEoFlNuElN2g8nvDtSkmVY6BdHLyTwYEmaYvukXAZrD6EeiIXAz9ccd1ZQbiRiPbxM4VI45Y/Zg5Om1BNM7tsOVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPy/t3bg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708493978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7eEgHWxIovYcamm60n9/RVTiHoef/c1v6/MT8PkoZc=;
	b=NPy/t3bgBYarFzhcnmH4eP0GexS8KI3AQSJQZd2frl99Zny07Z7bNlp+7dvLw3Bjv7mb7k
	rb8afBlipLILlMtiHkvU+iaMFTDiZZTvThJBJb3X3SRVtpW5tKEFWUoUqOPiifaLA4Kd51
	4CVhCXqJ9ZpWJ9kwGrlOnI1XVmXBXD0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-zpFMs-JgNH-FpV38Sfm_hA-1; Wed, 21 Feb 2024 00:39:36 -0500
X-MC-Unique: zpFMs-JgNH-FpV38Sfm_hA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78776154916so292225085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708493976; x=1709098776;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7eEgHWxIovYcamm60n9/RVTiHoef/c1v6/MT8PkoZc=;
        b=O+91r8/Y5ylsreNTdc4DFmcG6WT5nFvN626yc+tSmDy+os3DSUNZELxu4IMQOizomg
         yLNR6JkIiWzqEtq3ZN5YCftZvy0o/4Vhwojhhu0xvGZ8TIXwIJGHmyLAJ7mIpjHXgAGf
         fK5OF0Js3njZS/cd0FczGXNAGPE0Jam3GlGOpx/pDrkIDeRVvSnkM8GeZcpjMX043+mZ
         nLz2uAquU6D8ftZauiSP//UUAj12rz8P4qX79H9xpYDNwUSO7fXXwtYCGXU1giAk2J1b
         lIH2gDPYugNf0mB3e8O31NXuYH54I1uwkq+zbth4+/vakirfPChh5rFhj9kz6g7befQz
         30tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXstkrXoYUBXOHB2RlRs2EZ24uuw9NT4RRgkdTMf7UYfZAFVUrEJDBH/In1wVL7MEwHr0FWxoYew02cJukzsRXo7QUdus6FkkO8Aa33
X-Gm-Message-State: AOJu0Yx2a2Htkp6xTqxgy/wOEl1g6+in7JB3ZIog292mP0aG9a8CBtlw
	IndZFbgUuwMZh3miKxGnkOWbDdU1UkEyZXQpLF8ymXfgC13IbKFNbwsV3NQ4eb85uVkIG+8f2xm
	Q4PdE2+JWlVlf/7+RefX9SKuP5edtTWiTabIAbru1BL3ufxjCLob/1dxafgT3gg==
X-Received: by 2002:a05:620a:2496:b0:787:6fa6:7c9d with SMTP id i22-20020a05620a249600b007876fa67c9dmr8882991qkn.29.1708493975781;
        Tue, 20 Feb 2024 21:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGogavJfEFgbd7NSRnzSxkCs77pNldCfbStHLnMwlTGdsEi2OSZgGGNU/73RTXrgtqPRZ/Qgw==
X-Received: by 2002:a05:620a:2496:b0:787:6fa6:7c9d with SMTP id i22-20020a05620a249600b007876fa67c9dmr8882983qkn.29.1708493975484;
        Tue, 20 Feb 2024 21:39:35 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:a28e:99bd:8c92:cf80:d1bd])
        by smtp.gmail.com with ESMTPSA id i11-20020ac871cb000000b0042dfb466c85sm3481262qtp.64.2024.02.20.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:39:34 -0800 (PST)
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
Date: Wed, 21 Feb 2024 02:39:25 -0300
Message-ID: <ZdWMja3BfCZsbF_q@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <87v86kaf84.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> On Mon, Feb 19 2024 at 10:59, Thomas Gleixner wrote:

Hi Thomas, thanks for reviewing!

> > On Fri, Feb 16 2024 at 04:59, Leonardo Bras wrote:
> >
> >> In threaded IRQs, some irq handlers are able to handle many requests at a
> >> single run, but this is only accounted as a single IRQ_HANDLED when
> >> increasing threads_handled.
> >>
> >> In order to fix this, introduce IRQ_HANDLED_MANY, so the returned value of
> >> those IRQ handlers are able to signal that many IRQs got handled at that
> >> run.
> >>
> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> >> it back to IRQ_HANDLED.
> >
> > That's not really workable as you'd have to update tons of drivers just
> > to deal with that corner case. That's error prone and just extra
> > complexity all over the place.

I agree, that's a downside of this implementation. 


> >
> > This really needs to be solved in the core code.
> 
> Something like the uncompiled below should do the trick.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -38,7 +38,8 @@ struct pt_regs;
>   * @affinity_notify:	context for notification of affinity changes
>   * @pending_mask:	pending rebalanced interrupts
>   * @threads_oneshot:	bitfield to handle shared oneshot threads
> - * @threads_active:	number of irqaction threads currently running
> + * @threads_active:	number of irqaction threads currently activated
> + * @threads_running:	number of irqaction threads currently running
>   * @wait_for_threads:	wait queue for sync_irq to wait for threaded handlers
>   * @nr_actions:		number of installed actions on this descriptor
>   * @no_suspend_depth:	number of irqactions on a irq descriptor with
> @@ -80,6 +81,7 @@ struct irq_desc {
>  #endif
>  	unsigned long		threads_oneshot;
>  	atomic_t		threads_active;
> +	atomic_t		threads_running;
>  	wait_queue_head_t       wait_for_threads;
>  #ifdef CONFIG_PM_SLEEP
>  	unsigned int		nr_actions;
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1194,9 +1194,11 @@ irq_forced_thread_fn(struct irq_desc *de
>  	local_bh_disable();
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>  		local_irq_disable();
> +	atomic_inc(&desc->threads_running);
>  	ret = action->thread_fn(action->irq, action->dev_id);
>  	if (ret == IRQ_HANDLED)
>  		atomic_inc(&desc->threads_handled);
> +	atomic_dec(&desc->threads_running);
>  
>  	irq_finalize_oneshot(desc, action);
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
> @@ -350,6 +350,12 @@ void note_interrupt(struct irq_desc *des
>  				desc->threads_handled_last = handled;
>  			} else {
>  				/*
> +				 * Avoid false positives when there is
> +				 * actually a thread running.
> +				 */
> +				if (atomic_read(&desc->threads_running))
> +					return;
> +				/*
>  				 * None of the threaded handlers felt
>  				 * responsible for the last interrupt
>  				 *
> 

I agree the above may be able to solve the issue, but it would make 2 extra 
atomic ops necessary in the thread handling the IRQ, as well as one extra 
atomic operation in note_interrupt(), which could increase latency on this 
IRQ deferring the handler to a thread.

I mean, yes, the cpu running note_interrupt() would probably already have 
exclusiveness for this cacheline, but it further increases cacheline 
bouncing and also adds the mem barriers that incur on atomic operations, 
even if we use an extra bit from threads_handled instead of allocate a new 
field for threads_running. 


On top of that, let's think on a scenario where the threaded handler will 
solve a lot of requests, but not necessarily spend a lot of time doing so.
This allows the thread to run for little time while solving a lot of 
requests.

In this scenario, note_interrupt() could return without incrementing 
irqs_unhandled for those IRQ that happen while the brief thread is running, 
but every other IRQ would cause note_interrupt() to increase 
irqs_unhandled, which would cause the bug to still reproduce.


I understand my suggested change increases irq_return complexity, but it
should not increase much of the overhead in both IRQ deferring and IRQ 
thread handling. Also, since it accounts for every IRQ actually handled, it 
does not matter how long the handler thread runs, it still avoids the bug.

As you previously noted, the main issue in my suggestion is about changing 
drivers' code. But while this change is optional, I wonder how many 
drivers handle IRQs that:
- use edge type interrupts, and
- can trigger really fast, many many times, and
- can run in force-thread mode, and
- have handlers that are able to deal with multiple IRQs per call.

If there aren't many that met this requirement, I could try to tackle them 
as they become a problem.


About solving it directly in generic code, I agree it would be the ideal 
scenario. That's why I suggested that in RFCv1: if the thread handles a 
single IRQ, we reset irqs_unhandled to zero. That's a good pointer on the 
thread being stuck, and TBH I don't think this is too far away from the 
current 100/100k if we consider some of those handlers can handle multiple 
IRQs at once.


What are your thoughts on that?

Thanks!
Leo


