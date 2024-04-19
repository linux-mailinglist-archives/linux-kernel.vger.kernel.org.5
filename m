Return-Path: <linux-kernel+bounces-151275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D528AAC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE23B2825C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFB7D07F;
	Fri, 19 Apr 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fT6bUxzf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093C7C092
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520512; cv=none; b=HQGjiXIa7T9BVGs4odK7d707BD4OBf6OcClEsTj4A48fhcnrUJtFPhkq/oDEY5dtELumVJPGjeHEIYCfWGr2wp23ndv67x6Y/aV0hmxYqVMdAo81u4/19/Ewb8/DMzGXnfVsFaAzOnhet5ncAw76T2Ij6lr9b5H3UjYY1rXCJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520512; c=relaxed/simple;
	bh=3UhPQRD3s9bgq2iMH/mm4YlO9T24HAlbzn87JHbDjCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA7ghyOFuiVhEDUxn+UICTiOdIiyxcvR0vxBcFT1aYg+J0mTbrqYHyZ3/5XWcHEvXqAiNqdu9ihZkF6D06nH95YHHWH67qHtQe8NDa9VAfZ+IAebCMyiHIGOatnyysQw8WKEc89Xh8fjbISD3A0FLPoDdmPDhbTAGM8Qp/mOPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fT6bUxzf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso24069471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713520508; x=1714125308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMHwXYas0eCpDUsRNWt1WNdeBhxPT4OpnT4KCdcv++Q=;
        b=fT6bUxzf+9tcsvdmyCjOYfFuXfRL1dovFs7QlB7fLZh+jBlC8JT4CYwFrLJXDPEF0G
         58vYHzzhhZdzA0cSkTBQdbQ9E3IY9mWQ15xTZ/VIJbk1nlJseKGouI/IKwjqfhJD4lWT
         bYb/9ttn9i2ybzW+ekoBzLu1qxAUHyA3Uj+760/cAHgbpIwYURLM6LFvijgIHwIwC6o+
         of6SAhgUYYr4pIbOumfuR4qLNbSxZ3z5UpiWvwKdEEYO5qP35dZJ0DHAb8M7YeAOQkQv
         ghkGltIL/I3kC0VaXVc6hI4ivvjF48ffrvK0DJKPEj+F8pKspWhacRo4Or3jkVPzsvUy
         LBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520508; x=1714125308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMHwXYas0eCpDUsRNWt1WNdeBhxPT4OpnT4KCdcv++Q=;
        b=TpE+OH5v5AM60VM7ZzU1z4H04+6X7kvtswLvyiMXHb7KPGnIuh5wId6moc0lq/IGDb
         QpzPhWA5GT46H3jCchAc5GfCIqI0bzIEwKUM0UDdA2uSIl8MSDCrIF+uy2GoiKBtgRCC
         tG9sMgn3ONl7W+bEuJ5zYnZTCCZpl0kY71X8/P/maLqtO3GwtrDXVdkpgI9l8fPQFzDR
         FWt8jV6audn446suX8fk75S2KbzHJlC5lpU7m2OXCyR2S2iQ5pA5A/GCLcOIcPiPf9J6
         5m+Tk2Y4+HcYiXVomYdOgZVWvsGNole8kevdnJqwEChjNxtW/rQOGlgA5/f4m6ChqUQY
         Zo5w==
X-Forwarded-Encrypted: i=1; AJvYcCXzbzu39WOqFlAVOFCd9nmb80wSQZpdjsseyvTDA6J6m4rPfKg0udiAHb7wrAbWw58sM/9jqk66FjqzGktwcuiWV7om6KOqa2sERPwA
X-Gm-Message-State: AOJu0YxnVmj3xzmTeSKyNn2uAqzK8SDSeBzGGKGUFgieJ7M5mXUa3Llx
	AC3XHUFLCsFpi/r7YWEAbZALXa9+JkkBehAbclmUjldGfybZcjNWEhG84+yNaRQ=
X-Google-Smtp-Source: AGHT+IHfh5hUD5i8FisgqrHail7sCQS8CmB2aWzJbcdFn3tHCeckZM8RM9yqic3f4PKGiLa2E4kdZA==
X-Received: by 2002:a2e:8691:0:b0:2d8:5ca3:c360 with SMTP id l17-20020a2e8691000000b002d85ca3c360mr1190567lji.33.1713520508222;
        Fri, 19 Apr 2024 02:55:08 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm5886912wmo.22.2024.04.19.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:55:07 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:55:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 17/27] printk: nbcon: Use nbcon consoles in
 console_flush_all()
Message-ID: <ZiI_apItTZJQjuT_@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-18-john.ogness@linutronix.de>
 <ZhfwXsEE2Y8IPPxX@localhost.localdomain>
 <ZhgCgBK7JdRruvkj@localhost.localdomain>
 <87plunoai0.fsf@jogness.linutronix.de>
 <ZiEWaA3CeQsccEdj@pathway.suse.cz>
 <87v84e4a76.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v84e4a76.fsf@jogness.linutronix.de>

On Thu 2024-04-18 23:51:01, John Ogness wrote:
> On 2024-04-18, Petr Mladek <pmladek@suse.com> wrote:
> >> > 	   Solve this problem by introducing[*] nbcon_atomic_flush_all()
> >> > 	   which would flush even newly added messages and
> >> > 	   call this in nbcon_cpu_emergency_exit() when the printk
> >> > 	   kthread does not work. It should bail out when there
> >> > 	   is a panic in progress.
> >> >
> >> > 	   Motivation: It does not matter which "atomic" context
> >> > 		flushes NORMAL/EMERGENCY messages when
> >> > 		the printk kthread is not available.
> >> 
> >> I do not think that solves the problem. If the console is in an unsafe
> >> section, nothing can be printed.
> >
> > IMHO, it solves the problem.
> >
> > The idea is simple:
> >
> >   "The current nbcon console owner will be responsible for flushing
> >    all messages when the printk kthread does not exist."
> 
> Currently this is not valid. It assumes owners are printers. That is not
> always true. The owner might be some task modifying the baud rate and
> has nothing to do with printing.

Ah, I have missed this scenario.

> So what I am proposing is that we add two new normal-flushing sites that
> are only used when the kthread is not available:
> 
> 1. after exiting emergency mode: in nbcon_cpu_emergency_exit()
> 
> 2. after releasing ownership for non-printing: in nbcon_driver_release()
> 
> I think this will close the gap and it does not require irq_work.
> 
> > Sigh, all this is so complicated. I wonder how to document
> > this so that other people do not have to discover these
> > dependencies again and again. Is it even possible?
> 
> In the end we will have the following 5 scenarios (assuming my
> proposal):
> 
> 1. PRIO_NORMAL non-printing activity, always under con->device() lock,
>    upon release flushes[*] full backlog
> 
> 2. PRIO_NORMAL printing using write_thread(), always called from task
>    context and under con->device() lock, always flushes full backlog
> 
> 3. PRIO_NORMAL printing using write_atomic(), called with hardware
>    interrupts disabled, always flushes full backlog, (only used when the
>    kthread is not available)
> 
> 4. PRIO_EMERGENCY printing using write_atomic(), called with hardware
>    interrupts disabled, flushes through emergency, upon exit flushes[*]
>    full backlog
>
> 5. PRIO_PANIC printing using write_atomic(), called with hardware
>    interrupts disabled, flushes full backlog
> 
> [*] Only when the kthread is not available. And in that case #3 is the
>     scenario used for the trailing full flushing by #1 and #4.
> 
> 
> Full flushing is attempted in all 5 scenarios. A failed attempt means
> there is a new owner, but that owner is also one of the 5 scenarios.
> 
> Am I missing something?
> 
> IMHO #3 is the only bizarre scenario. It exists only to cover when the
> kthread is not available.

Great summary! I like it.

Let me try another summary:

We basically repeat the same trick as was used in the legacy
console_unlock(). When the kthread is not avaialale then
the current owner is responsible for flushing everything.

The game changer is the kthread. When it is available then
it takes care of "everything" as long as the system is
working normaly.

The system is working normally until suspend, shutdown, or panic().
It might also be sick. In which case, we try to flush the doctor
report immediately (emergency when safe). But we wait for
the entire doctor report before flushing (publishing).


Or another look. We have the following rules:

1. kthread is not avaialbe => owner flushes everything

2. kthread is available:

    a) Normal messages are off loaded to kthread (store + kick)

    b) Emergency messages (doctor examination) are first stored and then
       tried to be flushed immediately (when possible/safe), including
       all previous messages (other up-to-date notes).

       The emergency messages might also be split in more
       parts when the report is too long, for example,
       backtraces or lock depedencies of all tasks.
       (Reports from more doctor specialists). In this case,
       each part (report) is flushed immediately (when possible/safe),
       including all previous messages (other up-to-date notes).

       When the system tries to continue normaly (no dying)
       then any later messages (post doctor exam notes) are
       let the kthread (secretary) to flush them.

     c) Panic messages are flushed immediately (when possible/safe),
	including all previous messages (other up-to-date notes).

     d) The final flush in panic() will be done even when not safe
	(patient will try to read the diary even when feeling
	 dizzy and it might be a complete fiasco but it is
	 the very last chance).


In shorrt, go ahead with your proposal.

Best Regards,
Petr

