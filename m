Return-Path: <linux-kernel+bounces-155101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76D8AE549
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1C28337F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B313B5B1;
	Tue, 23 Apr 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aBsYfXKY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D813B5AC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872942; cv=none; b=VY986x3Q1+G2kyXpqNddYWskaGVwG9nigapG+3etsgpM43hb4/6hmCFJ8svzvL+p2YX8U7i/KUuYs8Z7Uj/D7E66u103dLy6MZnGjRMQOQ7uW9Wpm7c0SvdtRH+p3lYY6cUdZ/FxMsJ92ricWWdYF9OeGS2ObixYY3T4qzqkzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872942; c=relaxed/simple;
	bh=ZfuZnbxQcJiXsjKcyIyROVnZ6LTQ29+pjXlmqHq1MFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgQgdwvaMrkyRlHKDvEzYjJ1i3VUN8aX0w07u8bX3k9OioBDEB3cXAl0kc1BcRwoPSlmtGmjW8SZyxq9oqs+aclwLzV6NQNLEHzxytygt/nyiYAWYWnmqyKonDE1ogZRBVcVjt8pRVMtKXlYoZNXrGns+oeXOZ3qFbIvRAk52/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aBsYfXKY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VHYacKOAYAXq7qcz87ZpPvgNr8LptHfkppDy+s6k0rA=; b=aBsYfXKYCmtr2rA2INiUCkvFzo
	ycRy8s+dl5zZaUsn6fTVV6J/u4GpRBPCvbJ/df6M6G74A+YE89occI29mZWszcRF6dfP3kFC24xBU
	RffVsDvP8p/1/sKex1zGdhUCadc28EQics2ruxW5ghFlYwNvICan1BbRudQXk9Q7RpFZEG1pJYc4e
	DD3ZRaHB+LFCauuzidwsU+yxvA2lKpDRx9UENvxXRggInZ6PBZUqQLmycEMIRzfMQNxz2Vx+X+bpD
	b9mYMscBZhA2ce4of1V6C8jX8RUI63fEXasJr/YPge8eItr5K/crzUN7i2G7WPNN2JHqjiwcpYNZG
	3+tqkK/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzEdZ-0000000E14u-1Veg;
	Tue, 23 Apr 2024 11:48:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 05ABA30057A; Tue, 23 Apr 2024 13:48:37 +0200 (CEST)
Date: Tue, 23 Apr 2024 13:48:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
Message-ID: <20240423114836.GA24704@noisy.programming.kicks-ass.net>
References: <20240422082238.5784-1-xuewen.yan@unisoc.com>
 <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net>
 <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
 <20240422111744.GO30852@noisy.programming.kicks-ass.net>
 <CAB8ipk8ZBSnJfw9Ow9My-VXG1TU6DVY7mOL_i0Ejdd7GUZCLWA@mail.gmail.com>
 <20240422155937.GP30852@noisy.programming.kicks-ass.net>
 <CAB8ipk-WYVLsRi1_wnm2vF3M4RDnV1cSomb4MkJ83ef2GY0gzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-WYVLsRi1_wnm2vF3M4RDnV1cSomb4MkJ83ef2GY0gzg@mail.gmail.com>

On Tue, Apr 23, 2024 at 11:05:20AM +0800, Xuewen Yan wrote:
> On Mon, Apr 22, 2024 at 11:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 22, 2024 at 09:12:12PM +0800, Xuewen Yan wrote:
> >
> > > By adding a log to observe weight changes in reweight_entity, I found
> > > that calc_group_shares() often causes new_weight to become very small:
> >
> > Yes, cgroups do that. But over-all that should not matter no?
> >
> > Specifically, the whole re-weight thing turns into a series like:
> >
> >             w_0   w_1         w_n-1   w_0
> >         S = --- * --- * ... * ----- = ---
> >             w_1   w_2          w_n    w_n
> >
> > Where S is our ultimate scale factor.
> >
> > So even if w_m (0 < m < n) is 2, it completely disappears. But yes, it
> > will create a big term, which is why the initial vlag should be limited.
> 
> Okay, I understand what you mean. Even if the weight during dequeue is
> very small, the weight will be eliminated during enqueue.
> In this case, the necessity of the !on_rq case does not seem to be
> very important.
> 
> On the other hand, the following case:
> place_entity()
> {
> ...
>  5244                 load = cfs_rq->avg_load;
>  5245                 if (curr && curr->on_rq)
>  5246                         load += scale_load_down(curr->load.weight);
>  5247
>  5248                 lag *= load + scale_load_down(se->load.weight);
>  5249                 if (WARN_ON_ONCE(!load))
>  5250                         load = 1;
>  5251                 lag = div_s64(lag, load);<<<<
> ...
> }

So this plays games with scale_load_down() because this is W, the sum of
all w, which can indeed grow quite large and cause overflow.

> reweight_eevdf()
> {
> ...
>                  if (avruntime != se->vruntime) {
>  3770                 vlag = entity_lag(avruntime, se);
>  3771                 vlag = div_s64(vlag * old_weight, weight); <<<<
>  3772                 se->vruntime = avruntime - vlag;
>  3773         }
> .....
> }

While here we're talking about a single w, which is much more limited in
scope. And per the above, what we're trying to do is:

  vlag = lag/w
  lag/w * w/w' = lag/w'

That is, move vlag from one w to another.

> There is no need to clamp the above two positions because these two
> calculations will not theoretically cause s64 overflow?

Well, supposedly, if I didn't get it wrong etc.. (I do tend to get
things wrong from time to time :-).

I would think limited vlag would stay below 1 second or about 30 bits
this leaves another 30 bits for w which *should* be enough.

Anyway, if you're unsure, sprinkle some check_mul_overflow() and see if
you can tickle it.

