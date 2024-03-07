Return-Path: <linux-kernel+bounces-94905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE64874687
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E154B20BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A06AD7;
	Thu,  7 Mar 2024 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnigMk2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DFD2EE;
	Thu,  7 Mar 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780773; cv=none; b=FHwwrWPVjqAdNa52oTmYLZPBYPS4TB2ztiE6AV7tq2passSeiRtghjZXnj/7pekM4ko5ZSjQa0AviXPH1mGdceVt3f6MIZ939ukbe3OYCE0gH3WcM5PA8olHcePkzQ4ABm6DucMczGWuS1WyneoKyL9wHwlM7OOJOR0H9GTNsb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780773; c=relaxed/simple;
	bh=N9kJflOItiiyiMD797U6SwChZThaqOtj9TUdElbAYuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/3zW0LPyzVo9AvbXSvSPpUvbllkeWxqHJUKhP/F1CFYCeAHHfy8BBpEMB3GTUTqQpxLZofKE6tc8nHh5pd9lU4XRX/ECBq7T8iVM7YEX43iwCV7zwH3BwnL66sypPC4vAjGkwXNZYhmtKVkIQOdiJSGBfZo5V+0TOHa37zzmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnigMk2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA36C433F1;
	Thu,  7 Mar 2024 03:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780773;
	bh=N9kJflOItiiyiMD797U6SwChZThaqOtj9TUdElbAYuc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GnigMk2Jn9iy0BovuDqjApleSGC1ZCSdHViWgM2kd1bVNezHuhFrTBiHLpJOTAenc
	 7O4oxrs/+aTTU48LOQ98btg0BK7Vm08Cz3nMUXQR/v58+BGy13RT90mYwXt6Z44YoD
	 HPWYR7N0P1Anvw3Qik24yzbiFpwKvZpUXepUSe4u59reienDnjW31xHLA+fGMquOfr
	 9bbOJF2zxg+S6WkJBzphCDOeVax8UmE1A+z7ods0bEfIehVGxmQW4pTXzMUwsz3zoP
	 NyN1Vhshwku7mhSBxRAQUkmTMDT82kIsfDGKRNm6tlbrsVNBEyr7ASCyony9q9+ALs
	 xh2B0sg/QVrAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92A05CE10B8; Wed,  6 Mar 2024 19:06:12 -0800 (PST)
Date: Wed, 6 Mar 2024 19:06:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
	joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
	frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <f81db151-b617-4c98-8135-e3c8818cba0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>

On Wed, Mar 06, 2024 at 06:43:42PM -0800, Linus Torvalds wrote:
> On Wed, 6 Mar 2024 at 18:29, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > TL;DR:  Those ->rtort_pipe_count increments cannot run concurrently
> > with each other or any other update of that field, so that update-side
> > READ_ONCE() call is unnecessary and the update-side plain C-language
> > read is OK.  The WRITE_ONCE() calls are there for the benefit of the
> > lockless read-side accesses to rtort_pipe_count.
> 
> Ahh. Ok. That makes a bit more sense.
> 
> So if that's the case, then the "updating side" should never use
> READ_ONCE, because there's nothing else to protect against.
> 
> Honestly, this all makes me think that we'd be *much* better off
> showing the real "handoff" with smp_store_release() and
> smp_load_acquire().
> 
> IOW, something like this (TOTALLY UNTESTED!) patch, perhaps?
> 
> And please note that this patch is not only untested, it really is a
> very handwavy patch.
> 
> I'm sending it as a patch just because it's a more precise way of
> saying "I think the writers and readers could use the store-release ->
> load-acquire not just to avoid any worries about accessing things
> once, but also as a way to show the directional 'flow' of the data".
> 
> I dunno.

Thank you for looking at this!

I will look carefully at this, but the reason I didn't do it this way
to begin with is that I did not want false negatives that let weak-memory
RCU bugs escape unnoticed due to that synchronization and its overhead.

Of course on x86, that synchronization is (nearly) free.

							Thanx, Paul

>            Linus

>  kernel/rcu/rcutorture.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7567ca8e743c..60b74df3eae2 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -461,12 +461,12 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
>  		WRITE_ONCE(rp->rtort_chkp, NULL);
>  		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
>  	}
> -	i = READ_ONCE(rp->rtort_pipe_count);
> +	i = rp->rtort_pipe_count;
>  	if (i > RCU_TORTURE_PIPE_LEN)
>  		i = RCU_TORTURE_PIPE_LEN;
>  	atomic_inc(&rcu_torture_wcount[i]);
> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> +	smp_store_release(&rp->rtort_pipe_count, ++i);
> +	if (i >= RCU_TORTURE_PIPE_LEN) {
>  		rp->rtort_mbtest = 0;
>  		return true;
>  	}
> @@ -1408,8 +1408,7 @@ rcu_torture_writer(void *arg)
>  			if (i > RCU_TORTURE_PIPE_LEN)
>  				i = RCU_TORTURE_PIPE_LEN;
>  			atomic_inc(&rcu_torture_wcount[i]);
> -			WRITE_ONCE(old_rp->rtort_pipe_count,
> -				   old_rp->rtort_pipe_count + 1);
> +			smp_store_release(&old_rp->rtort_pipe_count, ++i);
>  
>  			// Make sure readers block polled grace periods.
>  			if (cur_ops->get_gp_state && cur_ops->poll_gp_state) {
> @@ -1991,7 +1990,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
>  	rcu_torture_reader_do_mbchk(myid, p, trsp);
>  	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
>  	preempt_disable();
> -	pipe_count = READ_ONCE(p->rtort_pipe_count);
> +	pipe_count = smp_load_acquire(&p->rtort_pipe_count);
>  	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
>  		/* Should not happen, but... */
>  		pipe_count = RCU_TORTURE_PIPE_LEN;


