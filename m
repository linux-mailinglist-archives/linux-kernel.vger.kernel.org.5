Return-Path: <linux-kernel+bounces-71308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854285A33A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF4F1C236D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90112E62A;
	Mon, 19 Feb 2024 12:30:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEB33C3C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345842; cv=none; b=hbQb8msliG8/JwI03JWGgh/3LYsbpmXStAgekqSos9AfgFrWf+ahpF2Mcxq0RNiTjhNxvrQQMx9CCpZFEOQs42CkUQnZD0a4upm+ZWJW5LCppI7WXL/PHiW4HLxlIlAX2StPsOivhADk+KurSnvOaszZ7nzah287LK/VdV8ziAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345842; c=relaxed/simple;
	bh=iX6uVvLS8WX5YCSNOooZxju9zMwTc8/l55VAGD+2Tqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqHTqW6myMrn/a1yAPcJ/U6JJZP8vj9eco/Gqx3d1QSTTA6Jhc8A4qx8zJmmRkpv9mK3eGllwdGKVkAgstIsvhKx3yt/04vQdUOe9qiNQ0Qtw8B1ntKUHF87V42arv/OsIO93nk//5+4JusSMg7T2bswCsIn8UVO/yZEzsx9CGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68376FEC;
	Mon, 19 Feb 2024 04:31:19 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844C83F73F;
	Mon, 19 Feb 2024 04:30:34 -0800 (PST)
Date: Mon, 19 Feb 2024 12:30:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
Message-ID: <ZdNJ5x1XmRZwa0Zp@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
 <87il2qmksh.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il2qmksh.fsf@oracle.com>

On Wed, Feb 14, 2024 at 08:08:30PM -0800, Ankur Arora wrote:
> 
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
> >> tif_need_resched() now takes a resched_t parameter to decide the
> >> immediacy of the need-resched.
> >
> > I see at the end of the series, most callers pass a constant:
> >
> > [mark@lakrids:~/src/linux]% git grep -w tif_need_resched
> > arch/s390/include/asm/preempt.h:        return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
> > arch/s390/include/asm/preempt.h:                        tif_need_resched(NR_now));
> > include/asm-generic/preempt.h:  return !--*preempt_count_ptr() && tif_need_resched(NR_now);
> > include/asm-generic/preempt.h:                  tif_need_resched(NR_now));
> > include/linux/preempt.h:        if (tif_need_resched(NR_now)) \
> > include/linux/sched.h:  return unlikely(tif_need_resched(NR_now));
> > include/linux/sched.h:          unlikely(tif_need_resched(NR_lazy));
> > include/linux/thread_info.h:static __always_inline bool tif_need_resched(resched_t rs)
> > include/linux/thread_info.h:     * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
> > kernel/entry/common.c:          if (tif_need_resched(NR_now))
> > kernel/sched/debug.c:   nr = tif_need_resched(NR_now) ? "need_resched" : "need_resched_lazy";
> > kernel/trace/trace.c:   if (tif_need_resched(NR_now))
> > kernel/trace/trace.c:   if (tif_need_resched(NR_lazy))
> >
> > I think it'd be clearer if we had tif_need_resched_now() and
> > tif_need_resched_lazy() wrappers rather than taking a parameter. I think that
> > if we did similar elsewhere (e.g. {set,test}_tsk_need_resched_{now,lazy}()),
> > it'd be a bit cleaner overall, since we can special-case the lazy behaviour
> > more easily/clearly.
> 
> So, we have three need-resched interfaces:
> 
> 1. need_resched(), need_resched_lazy()
>  These are used all over non-core (and idle) code, and I don't
>  see a case where the user would find it useful to dynamically
>  choose one or the other.
>  So, here two separate interfaces, need_resched()/need_resched_lazy()
>  make sense.
> 
> 2. tif_need_resched()
>  This is mostly used from preempt.h or scheduler adjacent code to drive
>  preemption and at least in current uses, the resched_t param is a
>  compile time constant.
> 
>  I think the scheduler might find it useful in some cases to parametrize
>  it (ex. maybe the scheduler knows how long which bit has been set for
>  over long and wants to pass that on to resched_latency_warn().)
> 
>  But that's a contrived example. I think this one would be fine
>  either way. Will try it out and see which (tif_need_resched(rs),
>  or tif_need_resched_now()/tif_need_resched_lazy()) seems cleaner.
> 
> 3. *_tsk_need_resched()
>  This is is used almost entirely from the scheduler and RCU.
> 
>  One place where I found the ability to parametrize quite useful
>  was __resched_curr(). So this I would like to keep.
> 
> All of that said, and I wonder if we need these new interfaces at all.
> Most of the code only uses the NR_now interface. Only the scheduler and
> the entry code need to distinguish between lazy and eager.
> (Plus, this way lazy and eager becomes an implementation detail which
> doesn't need to be known outside the scheduler. Which is also kind of
> the point of PREEMPT_AUTO.)
> 
> Say something like the patch below (and similar for tif_need_resched(),
> need_resched() etc.)
> 
> What do you think?
> 
> Ankur
> 
> ---------
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 58e6ea7572a0..b836b238b117 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1953,7 +1953,7 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>   * tif_resched(NR_now). Add a check in the helpers below to ensure
>   * we don't touch the tif_reshed(NR_now) bit unnecessarily.
>   */
> -static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
> +static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>  		set_tsk_thread_flag(tsk, tif_resched(rs));
> @@ -1964,6 +1964,11 @@ static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  		BUG();
>  }
> 
> +static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
> +{
> +	__set_tsk_need_resched(tsk, NR_now);
> +}

I assume for this (and test_tsk_need_resched() below), you mean to drop the
resched_t argument, i.e. this should be:

	static inline void set_tsk_need_resched(struct task_struct *tsk)
	{
		__set_tsk_need_resched(tsk, NR_now);
	}

Assuming so, this looks good to me!

Mark.

> +
>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  {
>  	clear_tsk_thread_flag(tsk, tif_resched(NR_now));
> @@ -1972,7 +1977,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  		clear_tsk_thread_flag(tsk, tif_resched(NR_lazy));
>  }
> 
> -static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
> +static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>  		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
> @@ -1980,6 +1985,11 @@ static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  		return false;
>  }
> 
> +static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
> +{
> +	return __test_tsk_need_resched(tsk, NR_now);
> +}
> +
>  /*
>   * cond_resched() and cond_resched_lock(): latency reduction via
>   * explicit rescheduling in places that are safe. The return

