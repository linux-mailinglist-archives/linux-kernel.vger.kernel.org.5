Return-Path: <linux-kernel+bounces-137671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B689E5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E49A28361B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E4112B14F;
	Tue,  9 Apr 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zwpwAJFc"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15453AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702332; cv=none; b=uPwkAs485fay2D7Y49UD+uDJ8MgOWRmSz4trpsZp8ie7xXJLnggXTrdd+Gy9DY6no1+OC2mZqIO/8PBTKCgjDK/Bu0qOUuckifctG2rfC/RTdjK/V6NqQVJ5m2Qw+pQ258SiLgflLxZt+6LUnu1/IEDMrcqQKyx4Tw82nwI4maA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702332; c=relaxed/simple;
	bh=1nTpHcFG7TaTN4UKuMWoGMUhSmjP455yY+NbNgC/vzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoSkUIwzaGb3ysdQxRTvfL9abWu86fcIFQvkvJuR6rX7zpnjKvXgtrY9AJrfJ/mZVjFAq3mhfRGEumNu2greiiXFC71VanEeBqYi12qBDWdpVHJjfq4qfcXoUBOh8X3oHyFu/niaJFz4HycYPkrScoQsS0Eb60hfnkIYdy/NMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zwpwAJFc; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4daa91c0344so2089339e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1712702329; x=1713307129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89EL/EjdotA4u7WdksJrZLtkwceVa9rml4RSMBb+ZaA=;
        b=zwpwAJFcMLCzSU/WM0JueVy6zmM1XhGflsb9SIenLtxujZg50UJZqTJWqmulmQkrRE
         /T2lqcSLDjtUhwyiuhmWo3IxZsD4TLNCUFCtfT15ZOs/dU1rSQls5bPzJvchclI0GIHG
         fsrCYiQxyQNMBL0zb1idu6F9AX8w57R6OmvafNmqSojHzBSRr+eXDAw1D0oyWOpSEpbH
         HbEoQZ+txZYwQaFkRuflIXWV67qnfmqJJOlzYQYmmNqPxnofKhM/J8G60WqPwTSTisxe
         Gz00gIdlWFGtg1RVugJ0H09Vp58+UaAc+IBM7/QPdxamJczEs8JvFuCM/J0EYh/UZ0zc
         UCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702329; x=1713307129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89EL/EjdotA4u7WdksJrZLtkwceVa9rml4RSMBb+ZaA=;
        b=QwZyJHAYoHwoelgMJg2sX0rgStpr/tyk0UZI4uZ4bkerJ8h+ra6ROKE2kGhiuUwyPZ
         9XOX11jG8fNQYSzdK0BelRdkDRE06Mi2YN/cSVG0hXFLXZSRCPE+4Vg2AJ0skF1Nyxy1
         rGwuWcfeghIN0wJXq4HE3HrPJpfSYhTl6ve0EwEQxD/Dn/STVe06Aacl5dHgy9aA20+D
         bqupkzgpd3N5S7baT3CVWDMm5wnSBZ3L2KRG7ytkZstVkAFx2hX7aFBYkPYykvLwDSvt
         JtHmCa8DkUPb04sq0gfwbz5ua7Qp42w4ExC9O16/HdlZL3qz4wHZMzrkaN6drHfD1WI7
         59DA==
X-Gm-Message-State: AOJu0Yxow87kp/rlzik0f03R78EW/CIrM/9tj1Ow4wlg1VaPvmIm3URb
	RRlhXl3G6vLZ9ScwKegA65Dnr7KvU2I9Wn1EmNOPs4GQXHwK3qHWBgWxN9j1yrQ=
X-Google-Smtp-Source: AGHT+IGiZK+tmHaywYrZ55RN5iwQnBxvHwVHGKo5oFf2/SFzKqBJnLN3XfIMJ9ECDpwW6+5kM+ErpQ==
X-Received: by 2002:a05:6122:2005:b0:4c8:e5a0:4222 with SMTP id l5-20020a056122200500b004c8e5a04222mr1351787vkd.12.1712702329298;
        Tue, 09 Apr 2024 15:38:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6db8])
        by smtp.gmail.com with ESMTPSA id s12-20020a0cdc0c000000b0069b10f48ecbsm2922036qvk.47.2024.04.09.15.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:38:48 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:38:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH] sched/psi: Optimise psi_group_change a bit
Message-ID: <20240409223847.GE1057805@cmpxchg.org>
References: <20240329160648.86999-1-tursulin@igalia.com>
 <20240329185147.GA877460@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329185147.GA877460@cmpxchg.org>

[ Oops, I still had an old mutt alias for Ingo's address. ]

Ingo, would you mind taking this through the scheduler tree?

On Fri, Mar 29, 2024 at 02:51:53PM -0400, Johannes Weiner wrote:
> On Fri, Mar 29, 2024 at 04:06:48PM +0000, Tvrtko Ursulin wrote:
> > From: Tvrtko Ursulin <tursulin@ursulin.net>
> > 
> > The current code loops over the psi_states only to call a helper which
> > then resolves back to the action needed for each state using a switch
> > statement. That is effectively creating a double indirection of a kind
> > which, given how all the states need to be explicitly listed and handled
> > anyway, we can simply remove. Both the for loop and the switch statement
> > that is.
> > 
> > The benefit is both in the code size and CPU time spent in this function.
> > YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
> > go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
> > 0x2c1.
> > 
> > Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Peter Ziljstra <peterz@infradead.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kernel-dev@igalia.com
> 
> This is great.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Ingo, would you mind please taking this through the scheduler tree? I
> think Peter is still out.
> 
> Remaining quote below.
> 
> Thanks
> 
> > ---
> >  kernel/sched/psi.c | 54 +++++++++++++++++++++++-----------------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> > 
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 7b4aa5809c0f..55720ecf420e 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -218,28 +218,32 @@ void __init psi_init(void)
> >  	group_init(&psi_system);
> >  }
> >  
> > -static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
> > +static u32 test_states(unsigned int *tasks, u32 state_mask)
> >  {
> > -	switch (state) {
> > -	case PSI_IO_SOME:
> > -		return unlikely(tasks[NR_IOWAIT]);
> > -	case PSI_IO_FULL:
> > -		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
> > -	case PSI_MEM_SOME:
> > -		return unlikely(tasks[NR_MEMSTALL]);
> > -	case PSI_MEM_FULL:
> > -		return unlikely(tasks[NR_MEMSTALL] &&
> > -			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
> > -	case PSI_CPU_SOME:
> > -		return unlikely(tasks[NR_RUNNING] > oncpu);
> > -	case PSI_CPU_FULL:
> > -		return unlikely(tasks[NR_RUNNING] && !oncpu);
> > -	case PSI_NONIDLE:
> > -		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> > -			tasks[NR_RUNNING];
> > -	default:
> > -		return false;
> > +	const bool oncpu = state_mask & PSI_ONCPU;
> > +
> > +	if (tasks[NR_IOWAIT]) {
> > +		state_mask |= BIT(PSI_IO_SOME);
> > +		if (!tasks[NR_RUNNING])
> > +			state_mask |= BIT(PSI_IO_FULL);
> >  	}
> > +
> > +	if (tasks[NR_MEMSTALL]) {
> > +		state_mask |= BIT(PSI_MEM_SOME);
> > +		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
> > +			state_mask |= BIT(PSI_MEM_FULL);
> > +	}
> > +
> > +	if (tasks[NR_RUNNING] > oncpu)
> > +		state_mask |= BIT(PSI_CPU_SOME);
> > +
> > +	if (tasks[NR_RUNNING] && !oncpu)
> > +		state_mask |= BIT(PSI_CPU_FULL);
> > +
> > +	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
> > +		state_mask |= BIT(PSI_NONIDLE);
> > +
> > +	return state_mask;
> >  }
> >  
> >  static void get_recent_times(struct psi_group *group, int cpu,
> > @@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >  {
> >  	struct psi_group_cpu *groupc;
> >  	unsigned int t, m;
> > -	enum psi_states s;
> >  	u32 state_mask;
> >  
> >  	groupc = per_cpu_ptr(group->pcpu, cpu);
> > @@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
> >  		return;
> >  	}
> >  
> > -	for (s = 0; s < NR_PSI_STATES; s++) {
> > -		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
> > -			state_mask |= (1 << s);
> > -	}
> > +	state_mask = test_states(groupc->tasks, state_mask);
> >  
> >  	/*
> >  	 * Since we care about lost potential, a memstall is FULL
> > @@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
> >  	/*
> >  	 * After we disable psi_group->enabled, we don't actually
> >  	 * stop percpu tasks accounting in each psi_group_cpu,
> > -	 * instead only stop test_state() loop, record_times()
> > +	 * instead only stop test_states() loop, record_times()
> >  	 * and averaging worker, see psi_group_change() for details.
> >  	 *
> >  	 * When disable cgroup PSI, this function has nothing to sync
> > @@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
> >  	 * would see !psi_group->enabled and only do task accounting.
> >  	 *
> >  	 * When re-enable cgroup PSI, this function use psi_group_change()
> > -	 * to get correct state mask from test_state() loop on tasks[],
> > +	 * to get correct state mask from test_states() loop on tasks[],
> >  	 * and restart groupc->state_start from now, use .clear = .set = 0
> >  	 * here since no task status really changed.
> >  	 */
> > -- 
> > 2.44.0
> > 

