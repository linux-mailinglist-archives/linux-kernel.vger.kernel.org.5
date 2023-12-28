Return-Path: <linux-kernel+bounces-12824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263081FA83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C01C222A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D589101C6;
	Thu, 28 Dec 2023 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="HjqmiiZT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E70F9D1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1/77b2Fo/WnASYiduBv30c2nietHwLk6cCOepVkjJSY=;
  b=HjqmiiZTv2q2YU85AyMEVB/SEo3SOIuQ7n3yCneGExTzhI4pMiHRQFm1
   p1gWsxNncjnSiLRJgGAFwU1SnlU4Y+vwViBp5buMR4iBd2ao1vh7a7e8W
   C+9fm/JXE+dB9Lf+VPmMwQS3wIhKsk9F5sw2o17cGM19JxNYJgAQvJDiu
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,312,1695679200"; 
   d="scan'208";a="75470371"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 19:34:48 +0100
Date: Thu, 28 Dec 2023 19:34:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
Message-ID: <edbd8ecd-148c-b366-fd46-3531dec39d49@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien> <20231009102949.GC14330@noisy.programming.kicks-ass.net> <b8ab29de-1775-46e-dd75-cdf98be8b0@inria.fr>
 <CAKfTPtBhWwk9sf9F1=KwubiAWFDC2A9ZT-SSJ+tgFxme1cFmYA@mail.gmail.com> <alpine.DEB.2.22.394.2312182302310.3361@hadrien> <CAKfTPtALEFtrapi3Kk97KLGQN4259eEQEwwftVUK4RG42Vgoyw@mail.gmail.com> <98b3df1-79b7-836f-e334-afbdd594b55@inria.fr>
 <CAKfTPtCRN_eWgVdK2-h6E_ifJKwwJEtMjeNjB=5DXZFWyBS+tQ@mail.gmail.com> <93112fbe-30be-eab8-427c-5d4670a0f94e@inria.fr> <CAKfTPtAeFvrZxApK3RruWwCjMxbQvOkU+_YgZSo4QPT_AD6FxA@mail.gmail.com> <9dc451b5-9dd8-89f2-1c9c-7c358faeaad@inria.fr>
 <CAKfTPtDCsLnDnVje9maP5s-L7TbtSu4CvF19xHOxbkvSNd7vZg@mail.gmail.com> <2359ab5-4556-1a73-9255-3fcf2fc57ec@inria.fr> <6618dcfa-a42f-567c-2a9d-a76786683b29@inria.fr> <CAKfTPtDrULyOB9+RhjoPfCpHKVhx5kRf6dq79DSE6jZgsEairw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

> > > > > > I'm surprised that you have mainly CPU_NEWLY_IDLE. Do you know the reason ?
> > > > >
> > > > > No.  They come from do_idle calling the scheduler.  I will look into why
> > > > > this happens so often.
> > > >
> > > > Hmm, the CPU was idle and received a need resched which triggered the
> > > > scheduler but there was nothing to schedule so it goes back to idle
> > > > after running a newly_idle _load_balance.
> > >
> > > I spent quite some time thinking the same until I saw the following code
> > > in do_idle:
> > >
> > > preempt_set_need_resched();
> > >
> > > So I have the impression that do_idle sets need resched itself.
> >
> > But of course that code is only executed if need_resched is true.  But I
>
> Yes, that is your root cause. something, most probably in interrupt
> context, wakes up your CPU and expect to wake up a thread
>
> > don't know who would be setting need resched on each clock tick.
>
> that can be a timer, interrupt, ipi, rcu ...
> a trace should give you some hints

I have the impression that it is the goal of calling nohz_csd_func on each
clock tick that causes the calls to need_resched.  If the idle process is
polling, call_function_single_prep_ipi just sets need_resched to get the
idle process to stop polling.  But there is no actual task that the idle
process should schedule.  The need_resched then prevents the idle process
from stealing, due to the CPU_NEWLY_IDLE flag, contradicting the whole
purpose of calling nohz_csd_func in the first place.

julia

