Return-Path: <linux-kernel+bounces-125291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1B892399
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28361C210B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B4383A5;
	Fri, 29 Mar 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="n303v0oN"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBCE4AEED
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738317; cv=none; b=Zv4E2xNy7R7uqDVb+Nq8szkpgiIYRulkbTQKRp3TeLarskDAaooJNcrk8sZiOrj7BcQe2AJJimaMSfYuzhZXZb8Fq51yr+pL2i+ikYQL5gwEkdtxLVKDbI+Bi3J60xiATgJmSpYB1P0x3+lYILLX0YT3+qpVkVA7NWwKmcdwROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738317; c=relaxed/simple;
	bh=KWwIotW1y1EPwjgR1d0C1AaUU+YymQBsrG5xC4C9Lxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/gat0p1TSdcXNT6cgaLAtQu+JFr8DxWV1a+qmvfYdlCKgU3XGGgK2HAlnAFOhG+BgYIC6CAcZMsS1peYZMYYUxzG/9evgDiGBLEeUTFrYZljWUVqny8mryuOmI7mCWvzh5PuGe6sTHKCprdPwTnjXDMTdpqSwlkMYrPYYNzx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=n303v0oN; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c38eced701so1332991b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711738313; x=1712343113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuM8ecOFJyJDtovRpu4FBUR1Iu1DTOXn5oqcF8xzseE=;
        b=n303v0oNs3k059VoNXimzdi58PWrl8cBTwg51Y9ZKDl+2MholVKpJt5LstOgGN7jx7
         lwRtiGFtBmX9KnkWgsPNo1jyk2DoA/6lpCdHNoqAd85PBOAQTt3u3p5WWrKm+pYRUAbb
         dFDd6RkNLqBABzQ/42jo9ZNMykHjZtGL2mudtKvYJvHMGlfeYVuFXrzViUjgVvm2FK9L
         JnT7W63p5JXMPU3KZ8QTfM0oMTw9GU/NugiAZl6m6rxgelHVHsuMLnG2aIAe5jzXfcaT
         S6qlr94GpW++mYy57uJrtIQxSY8Y4Zpe5ATXr5vecgGvv1oE/1S5qGiryMPKHIlKaeEe
         rdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738313; x=1712343113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuM8ecOFJyJDtovRpu4FBUR1Iu1DTOXn5oqcF8xzseE=;
        b=f34HxsWbZhv2ES/cXgdmlsepXLhATgia9hMMjr688YmOCu7r3J+N37OL7p/6RaWgW+
         +Rl21ELtOKe3CQtcZjnp/OTdtYVqb37SgGoYz1wfeu/ZUvb8A+L0enC2W/llniZ6U1zn
         TsJMmeSEhb78WpBHi0WxDRErV9HITevddA8SVNQqgZqaiMwSGqtiYDebkkmq8cXVEOD0
         wczZkweYWdZaMHzQEl7bNDa1BkKhA+4RIudJSnBb9iM4LHtg2xe23YH928JsCoijCiyx
         jr4M7vb8oo+2TBi4vQTW3Bt1HHYzzAi1NGWpHlJ6dDGmGfk9nvEvhIhg5EStk6HQPipQ
         D1xQ==
X-Gm-Message-State: AOJu0YzGcGg3a9QMWNzljI/EbB+7GsE6MVCW7n7SLYOhlFUcFW/3v3yd
	bcRGy4AiD3mXnERoMIn+5OlCT+UIxsJww4BgGvEGlSqj82+AngzbSM4qug/lvzc=
X-Google-Smtp-Source: AGHT+IFXddigHRumW63Y3jjiJPRozwcYTAhSquX8GQJmEd1lDmf8MJoUemBAVzmoY4+qHgZ2sLfDOQ==
X-Received: by 2002:a05:6808:238a:b0:3c3:e89a:94b7 with SMTP id bp10-20020a056808238a00b003c3e89a94b7mr3501594oib.22.1711738313089;
        Fri, 29 Mar 2024 11:51:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id hh1-20020a05622a618100b00430b0f40532sm1854785qtb.9.2024.03.29.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:51:52 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:51:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, kernel-dev@igalia.com
Subject: Re: [PATCH] sched/psi: Optimise psi_group_change a bit
Message-ID: <20240329185147.GA877460@cmpxchg.org>
References: <20240329160648.86999-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329160648.86999-1-tursulin@igalia.com>

On Fri, Mar 29, 2024 at 04:06:48PM +0000, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tursulin@ursulin.net>
> 
> The current code loops over the psi_states only to call a helper which
> then resolves back to the action needed for each state using a switch
> statement. That is effectively creating a double indirection of a kind
> which, given how all the states need to be explicitly listed and handled
> anyway, we can simply remove. Both the for loop and the switch statement
> that is.
> 
> The benefit is both in the code size and CPU time spent in this function.
> YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
> go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
> 0x2c1.
> 
> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-dev@igalia.com

This is great.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Ingo, would you mind please taking this through the scheduler tree? I
think Peter is still out.

Remaining quote below.

Thanks

> ---
>  kernel/sched/psi.c | 54 +++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..55720ecf420e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -218,28 +218,32 @@ void __init psi_init(void)
>  	group_init(&psi_system);
>  }
>  
> -static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
> +static u32 test_states(unsigned int *tasks, u32 state_mask)
>  {
> -	switch (state) {
> -	case PSI_IO_SOME:
> -		return unlikely(tasks[NR_IOWAIT]);
> -	case PSI_IO_FULL:
> -		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
> -	case PSI_MEM_SOME:
> -		return unlikely(tasks[NR_MEMSTALL]);
> -	case PSI_MEM_FULL:
> -		return unlikely(tasks[NR_MEMSTALL] &&
> -			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
> -	case PSI_CPU_SOME:
> -		return unlikely(tasks[NR_RUNNING] > oncpu);
> -	case PSI_CPU_FULL:
> -		return unlikely(tasks[NR_RUNNING] && !oncpu);
> -	case PSI_NONIDLE:
> -		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> -			tasks[NR_RUNNING];
> -	default:
> -		return false;
> +	const bool oncpu = state_mask & PSI_ONCPU;
> +
> +	if (tasks[NR_IOWAIT]) {
> +		state_mask |= BIT(PSI_IO_SOME);
> +		if (!tasks[NR_RUNNING])
> +			state_mask |= BIT(PSI_IO_FULL);
>  	}
> +
> +	if (tasks[NR_MEMSTALL]) {
> +		state_mask |= BIT(PSI_MEM_SOME);
> +		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
> +			state_mask |= BIT(PSI_MEM_FULL);
> +	}
> +
> +	if (tasks[NR_RUNNING] > oncpu)
> +		state_mask |= BIT(PSI_CPU_SOME);
> +
> +	if (tasks[NR_RUNNING] && !oncpu)
> +		state_mask |= BIT(PSI_CPU_FULL);
> +
> +	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
> +		state_mask |= BIT(PSI_NONIDLE);
> +
> +	return state_mask;
>  }
>  
>  static void get_recent_times(struct psi_group *group, int cpu,
> @@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  {
>  	struct psi_group_cpu *groupc;
>  	unsigned int t, m;
> -	enum psi_states s;
>  	u32 state_mask;
>  
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
> @@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		return;
>  	}
>  
> -	for (s = 0; s < NR_PSI_STATES; s++) {
> -		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
> -			state_mask |= (1 << s);
> -	}
> +	state_mask = test_states(groupc->tasks, state_mask);
>  
>  	/*
>  	 * Since we care about lost potential, a memstall is FULL
> @@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
>  	/*
>  	 * After we disable psi_group->enabled, we don't actually
>  	 * stop percpu tasks accounting in each psi_group_cpu,
> -	 * instead only stop test_state() loop, record_times()
> +	 * instead only stop test_states() loop, record_times()
>  	 * and averaging worker, see psi_group_change() for details.
>  	 *
>  	 * When disable cgroup PSI, this function has nothing to sync
> @@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
>  	 * would see !psi_group->enabled and only do task accounting.
>  	 *
>  	 * When re-enable cgroup PSI, this function use psi_group_change()
> -	 * to get correct state mask from test_state() loop on tasks[],
> +	 * to get correct state mask from test_states() loop on tasks[],
>  	 * and restart groupc->state_start from now, use .clear = .set = 0
>  	 * here since no task status really changed.
>  	 */
> -- 
> 2.44.0
> 

