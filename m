Return-Path: <linux-kernel+bounces-30350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB7F831D98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E61E1F2432C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8CA29422;
	Thu, 18 Jan 2024 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZdbS5iF"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522271E494
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595742; cv=none; b=MQce1fPGc67ndKcuyi0w6wPQWKZt+mspCQe2GQFqd2oEGY67t40yvg3ZFCYWTu8UEIFH+rz/N1QlvyveqKdN0BuSkx6PeRO/A14aYPMFZeCHsxI0EbbJHVnVmO/5Rb7r/ZeGlRprz8+Ke7q+c0FlerwjrOIUZo2loFCh++fP+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595742; c=relaxed/simple;
	bh=/hnomHPcAseqFq1cW/xqae/noviJpoFRItt6SlswuJo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=oCw9i5rnEa6IBI/HsC4n2AXeXnkxSbnD1QzVxqx+slTQ60R2TStD2Cm2VchmdyHItQAEDy1H4PvjlzNRYmDQ7We8j+62aSX+884xyJ6+UEGqD2EUhf5apIePCC07A5ENn8kDmHNZnYJ34F62PBEcwLX8YvWe9BRsENXAtTom+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZdbS5iF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso1211541b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705595740; x=1706200540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rJOwSGjfVJzLe9+26Zcy9FWlxg4pdaTzmmi/NM8WBMU=;
        b=YZdbS5iF0FjbPlKXVyQhrw03FVSqVHxIG5EhKVs6cGT0ZAan4l6Ut2QU/KFkBdp2nF
         DfPAalMEtsTigJtrcXpNwh0daxm16r9nHzCE0cfqTBMJTT/2iqSY5kI1Ub/Qi5ivo8Ki
         Y9ZCYAR482MbeNa1tw3fqWHuxu/Qugmcii+gxx7p6ulkBqcBAqNZNji1XbFkhX9vTrJ9
         UGBT8qvZ0ByApxxZO32EHnsIDsZZE3y3ZAu8nJqLFLNRK7CA42dnxBvVD6ryqzaztIf5
         R1vwp6H2oEcf/3LJYmg3ABKP5ECx/9EBSaOsan+WM5y6D4kMKEgLLkmhNgkUC361rsMY
         eVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705595740; x=1706200540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJOwSGjfVJzLe9+26Zcy9FWlxg4pdaTzmmi/NM8WBMU=;
        b=ggIojLgF5tpTrFr8Ed1k1DJwI0D1jf5oqHDbqGELV83m8mVyyxF6k0x6/p3gYvF+ev
         HnTMlPeir5cQxLJUC0Yq7m6ZOlOoHXXF0ppZzEGxyxlsc9pScxfhcpGGkF5TRr/Sx23L
         gz3eu8S372HMhNyEavamGKp44oeLKuVtV8HcWCh3JDVMJ28z34EqibDRNkxXO24Wx1BB
         +KER5suHX7J8hDSILgptkDKkRY20XpI7Tq12b0oxig7b36yVhdLXKr3q3uhrSua8iQi9
         czET8bTXzQi9VH/rOdlhEevQGTmBQozFPQfbhK3vMGwoPbzxZHGUgVBf3GeiTLcK+eBi
         0RTw==
X-Gm-Message-State: AOJu0Ywj+vKTg9mN9DrSDz90rtTLHie0hwWVe+BzivFwrK2+ddduewtv
	xtgNsliglGmPie1iVfuBqwjd0blY6qHPVsK4e3SMcWvVdJoGNynnyaMfwNykAotmZUNrSETPVva
	DBk4Y4UOAEaYEm3r96sRvSt0Rx5IaWaTB0W2uCw==
X-Google-Smtp-Source: AGHT+IHJYseWdj0dxXqz5ZcWtoLfi7Hs3lfmlJPir+Wki5j3QGlb+Sk3l5S3uwbDxlMrb6tmbVcHpmw3U7368TN0OlQ=
X-Received: by 2002:a05:6a00:3399:b0:6d9:acea:bdce with SMTP id
 cm25-20020a056a00339900b006d9aceabdcemr1073239pfb.24.1705595740630; Thu, 18
 Jan 2024 08:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com>
 <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr> <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com>
 <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com>
 <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr> <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com>
 <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr>
 <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
 <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr> <cecfd395-f067-99e1-bdd2-fec2ebc3db3@inria.fr>
 <CAKfTPtCAcHuzhcDvry6_nH2K29wc-LEo2yOi-J-mnZkwMvGDbw@mail.gmail.com>
 <cfae246d-9383-59d-ee5b-81ea3dd0a795@inria.fr> <CAKfTPtD0B29zadkeEOCWvry123zWVEEm41ouKj7noXwQdoh2+Q@mail.gmail.com>
 <7a845b43-bd8e-6c7d-6bca-2e6f174f671@inria.fr> <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr>
In-Reply-To: <36f2cc93-db10-5977-78ab-d9d07c3f445@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 18 Jan 2024 17:35:28 +0100
Message-ID: <CAKfTPtA31Z0N9hd4z_GPvoZwK=KTf4fPbx_jDbK653mdVDLEbw@mail.gmail.com>
Subject: Re: EEVDF and NUMA balancing
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Julia,

Sorry for the delay. I have been involved on other perf regression

On Fri, 5 Jan 2024 at 18:27, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Fri, 5 Jan 2024, Julia Lawall wrote:
>
> >
> >
> > On Fri, 5 Jan 2024, Vincent Guittot wrote:
> >
> > > On Fri, 5 Jan 2024 at 15:51, Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >
> > > > > Your system is calling the polling mode and not the default
> > > > > cpuidle_idle_call() ? This could explain why I don't see such problem
> > > > > on my system which doesn't have polling
> > > > >
> > > > > Are you forcing the use of polling mode ?
> > > > > If yes, could you check that this problem disappears without forcing
> > > > > polling mode ?
> > > >
> > > > I expanded the code in do_idle to:
> > > >
> > > >                 if (cpu_idle_force_poll) { c1++;
> > > >                         tick_nohz_idle_restart_tick();
> > > >                         cpu_idle_poll();
> > > >                 } else if (tick_check_broadcast_expired()) { c2++;
> > > >                         tick_nohz_idle_restart_tick();
> > > >                         cpu_idle_poll();
> > > >                 } else { c3++;
> > > >                         cpuidle_idle_call();
> > > >                 }
> > > >
> > > > Later, I have:
> > > >
> > > >         trace_printk("force poll: %d: c1: %d, c2: %d, c3: %d\n",cpu_idle_force_poll, c1, c2, c3);
> > > >         flush_smp_call_function_queue();
> > > >         schedule_idle();
> > > >
> > > > force poll, c1 and c2 are always 0, and c3 is always some non-zero value.
> > > > Sometimes small (often 1), and sometimes large (304 or 305).
> > > >
> > > > So I don't think it's calling cpu_idle_poll().
> > >
> > > I agree that something else
> > >
> > > >
> > > > x86 has TIF_POLLING_NRFLAG defined to be a non zero value, which I think
> > > > is sufficient to cause the issue.
> > >
> > > Could you trace trace_sched_wake_idle_without_ipi() ans csd traces as well ?
> > > I don't understand what set need_resched() in your case; having in
> > > mind that I don't see the problem on my Arm systems and IIRC Peter
> > > said that he didn't face the problem on his x86 system.
> >
> > TIF_POLLING_NRFLAG doesn't seem to be defined on Arm.
> >
> > Peter said that he didn't see the problem, but perhaps that was just
> > random.  It requires a NUMA move to occur.  I make 20 runs to be sure to
> > see the problem at least once.  But another machine might behave
> > differently.
> >
> > I believe the call chain is:
> >
> > scheduler_tick
> >   trigger_load_balance
> >     nohz_balancer_kick
> >       kick_ilb
> >         smp_call_function_single_async
> >           generic_exec_single
> >             __smp_call_single_queue
> >               send_call_function_single_ipi
> >                 call_function_single_prep_ipi
> >                   set_nr_if_polling <====== sets need_resched
> >
> > I'll make a trace to reverify that.
>
> This is what I see at a tick, which corresponds to the call chain shown
> above:
>
>           bt.B.x-4184  [046]   466.410605: bputs:                scheduler_tick: calling trigger_load_balance
>           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling nohz_balancer_kick
>           bt.B.x-4184  [046]   466.410605: bputs:                trigger_load_balance: calling kick_ilb
>           bt.B.x-4184  [046]   466.410607: bprint:               trigger_load_balance: calling smp_call_function_single_async 22
>           bt.B.x-4184  [046]   466.410607: bputs:                smp_call_function_single_async: calling generic_exec_single
>           bt.B.x-4184  [046]   466.410607: bputs:                generic_exec_single: calling __smp_call_single_queue
>           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling send_call_function_single_ipi
>           bt.B.x-4184  [046]   466.410608: bputs:                __smp_call_single_queue: calling call_function_single_prep_ipi
>           bt.B.x-4184  [046]   466.410608: bputs:                call_function_single_prep_ipi: calling set_nr_if_polling
>           bt.B.x-4184  [046]   466.410609: sched_wake_idle_without_ipi: cpu=22

I don't know if you have made progress on this in the meantime.

Regarding the trace above, do you know if anything happens on CPU22
just before the scheduler tried to kick the ILB on it ?

Have you found why TIF_POLLING_NRFLAG seems to be always set when the
kick_ilb happens ? It should be cleared once entering the idle state.

Could you check your cpuidle driver ?

Vincent

>
> julia

