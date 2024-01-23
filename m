Return-Path: <linux-kernel+bounces-34863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864BE838875
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6AB2824B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC45676A;
	Tue, 23 Jan 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCBemdx3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479A5675B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997186; cv=none; b=SgOhJNrDxZwVABSfOh96KeB5/VV8ErAiH+9E1kS4tdRLfy2ZPid/mbRmxnPjkuWC6NjtmAtxYWtoMHPbXlrEka9eDff7ytzTfcMyymlAhTpknPTzf6pvBBO2aoo2r9DyXGzERLKFIXupv2jy5P/Pc7lbAiX0sJMMXtqiohce+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997186; c=relaxed/simple;
	bh=uk5Hr+A2AJmp/0HJLDXxWYvQzaj3jCx5x06KUr3nG+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLlazZ3iCFajod8o+WJRgVLyeMmPxb8iST+yVJ4+NFWZKJOYtmxnZpXuCQ6tAB4+s16YrcHRf7bJfsgpnLaqtF8SoYRfHSINRwKtcEoKXdT8HJCvEs3ZMLN0ue5ggioZMGJ/TDVe7p9ZboP1MQHl4lew3+SqPjC7D15MlXSyY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCBemdx3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d73066880eso21043795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705997184; x=1706601984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Aqf+NiYa38wLQ+5wrQJ7Z0HKQo/aTX/7ZfOqaUfV7k=;
        b=zCBemdx39BSx3XJhybkbc4vpJf7RTP4S0mQMyOhC2pAwNISefrc8yXMPBJ5fs3376+
         DBcx+KEOPCLJLCJgWIEa3jM6iZ149/73X4IM45GeXSKVIH1mvS88LDo0yrCOsmjDwr3w
         gf1TvlwfwgoDTuw0tg7OSRaN0/pnixUjH9LnbQ4QfCivsn28jga6c1Usj1Wn7xJs4Jy7
         wsDp/lg6NZAIdAlm9BWAZn76vP2KsFumAZsvdxDSiMFUnTByB+YOwDE9WVihSoGRSab9
         821Fz86KPzgokdVjFmSeQYkodV8MJ/ElWi5kauxpvTv0FgsbCDFvJl3FpMr/MUvhOfO1
         gbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997184; x=1706601984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Aqf+NiYa38wLQ+5wrQJ7Z0HKQo/aTX/7ZfOqaUfV7k=;
        b=OUD+cSnfY7m650ng0WjLdnNrWysKwd+p6ZawyIAn/Gh8YCtqdzYHRsNQOrrGWVMG9Y
         BF8wsCZSu/LNtJV+7gFAhBI9kPQ9yFwg+9KVL4NvlDnDZVB1CIdyGMN5smY+0WlYmdcj
         voFSPDGOvPKMahbXjL2uToISDCz/EeRSW0Fyn4a2oe0Yzi6jdFX5r2YATSCK14S7lUnk
         3mwDEteRxXRIRppW/eWYnEq9FlXy/6YFzoYzegcdypD87+zzcYwYVO7WjixOUrz+Z5CR
         KRz53hS/Q3KfD9xPmdpZtmAUhcn/Tc4bSumddcD5DRl2Xx6CmpUUnyFtJ0MAB75WMljL
         ijMw==
X-Gm-Message-State: AOJu0Yz7b/9YihYhaWrCioKTRXKZbQVOhSZPWX170rvyQBKxAgQfpt5S
	8nGRYNU7ecuHPpd2rnLrtlvtISFaAxF0Y4MKBAFpk8GtSpwyBKGYWwT4THOj/zCmP8khp8ebp2k
	xi6WWgjkYNwqa9NxNqviyQRd9RkM5YTAHjUTB4w==
X-Google-Smtp-Source: AGHT+IHDSs+ITM+YJ096B4Dx/Et5VMHMiKsgXYecJAaT/c7TYykGaVFPMyvpE9CCmrq5mwEmRxG3b08lGha6XsytVJU=
X-Received: by 2002:a17:90b:4f8e:b0:290:b9f0:c755 with SMTP id
 qe14-20020a17090b4f8e00b00290b9f0c755mr1454607pjb.86.1705997184312; Tue, 23
 Jan 2024 00:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084548.2788-1-kprateek.nayak@amd.com> <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
 <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
In-Reply-To: <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Jan 2024 09:06:13 +0100
Message-ID: <CAKfTPtCFJ5TRdsHHiH_fz9R2TC3euz_Rp=LH+aQ9KeZx3uH+ZQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	gautham.shenoy@amd.com, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 05:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Tim,
>
> On 1/23/2024 3:29 AM, Tim Chen wrote:
> > On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b803030c3a03..1fedc7e29c98 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
> >>      if (!rf)
> >>              return NULL;
> >>
> >> +    /*
> >> +     * An idle CPU in TIF_POLLING mode might end up here after processing
> >> +     * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
> >> +     * sending an actual IPI. In such cases, where an idle CPU was woken
> >> +     * up only to process an interrupt, without necessarily queuing a task
> >> +     * on it, skip newidle_balance() to facilitate faster idle re-entry.
> >> +     */
> >> +    if (prev == rq->idle)
> >> +            return NULL;
> >> +
> >
> > Should we check the call function queue directly to detect that there is
> > an IPI waiting to be processed? something like
> >
> >       if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
> >               return NULL;
>
> That could be a valid check too. However, if an IPI is queued right
> after this check, the processing is still delayed since
> newidle_balance() only bails out for scenarios when a wakeup is trying
> to queue a new task on the CPU running the newidle_balance().
>
> >
> > Could there be cases where we want to do idle balance in this code path?
> > Say a cpu is idle and a scheduling tick came in, we may try
> > to look for something to run on the idle cpu.  Seems like after
> > your change above, that would be skipped.
>
> Wouldn't scheduler_tick() do load balancing when the time comes? In my
> testing, I did not see a case where the workloads I tested were
> sensitive to the aspect of newidle_balance() being invoked at scheduler
> tick. Have you come across a workload which might be sensitive to this
> aspect that I can quickly test and verify? Meanwhile, I'll run the
> workloads mentioned in the commit log on an Intel system to see if I
> can spot any sensitivity to this change.

Instead of trying to fix spurious need_resched in the scheduler,
can't we find a way to prevent it from happening ?

Because of TIF_NEED_RESCHED being set when TIF_POLLING is set, idle
load balances are already skipped for a less aggressive newly idle
load balanced:
https://lore.kernel.org/all/CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com/

The root of the problem is that we keep TIF_NEED_RESCHED set

>
> Adding David to the thread too since HHVM seems to be one of those
> workloads that is very sensitive to a successful newidle_balance().
>
> >
> > Tim
> >
> >
> >>      new_tasks = newidle_balance(rq, rf);
> >>
> >>      /*
> >
>
> --
> Thanks and Regards,
> Prateek

