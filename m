Return-Path: <linux-kernel+bounces-91186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12674870ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C8FB27B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242477994A;
	Mon,  4 Mar 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6xBGfIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917979957;
	Mon,  4 Mar 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581455; cv=none; b=CQYiWCaz6bPWIXBEZcOmR4GpQpGEJw5K9UD/RsZjSehR2leHGLPaoctu43MxO1DNOB/H4KNM8qkcOLqxSCtBOHsrm13vGBSj+bF+Plvr3Otk0+3IgpCPw8ASxHYn5CaMeslPboUZrlh2pTNqAe/Y4uISS4gDy4uzYl2tWrQs5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581455; c=relaxed/simple;
	bh=SwvPkDwF9T2IZMom4e0Hlei2LSGF3kUKwoNGm6XDOHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tugXSXDkMg3u0h/d/Asrb3Z7sJ3t7jGg5eZxQp7+A8wbVkgadVmrIKSxLMiwx8xFX5mGYcPTzgEyNKT8UCHOFN0Yn2NWUlRMdVjjUT+QNgRxF2+kDc6/779GobZPxr1tbsZy9aLQhnfh/fCaqUZ5MixLgrz4c52ZBbqTN2m8hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6xBGfIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4A5C433C7;
	Mon,  4 Mar 2024 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709581454;
	bh=SwvPkDwF9T2IZMom4e0Hlei2LSGF3kUKwoNGm6XDOHY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=V6xBGfIPyAELztemZyu79/9MtmOTnRnEsAbnC6RuQ0sP0R65uwCqtokyg2gkXVhqB
	 M5fHygQzsjleu89eQOnMy9RrI3Rb0p79KawHhiMc9aa2LYMQcNAqokHHpezRE+fT3I
	 NG+0uuMN9qwhunuFobscezY/9AAdSJpFxbNHpqDmRTso9WuA1DsrDqLwtF95iFesNe
	 1fVXo4+6/cH5LPH3EHyGeaLjMj0L+KaTHPo3t3BvZgaKRtmYrlN3LkXwDjnInXYsgH
	 /pvPvQ5a66SkzpMk6TyvR6u1eBNCRYSfnu8yNzkDTjh2YsbQVbmkoz3G8FStDR1SZv
	 kziWTDUxr1MQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A1EECE049E; Mon,  4 Mar 2024 11:44:14 -0800 (PST)
Date: Mon, 4 Mar 2024 11:44:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linke li <lilinke99@qq.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Message-ID: <a9ff4787-1b07-4d47-b2a0-5eb1336d3710@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
 <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
 <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>

On Mon, Mar 04, 2024 at 02:10:09PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/4/2024 12:14 PM, Paul E. McKenney wrote:
> > On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
> >>
> >>
> >> On 3/4/2024 5:54 AM, linke li wrote:
> >>> Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
> >>>
> >>>  {
> >>>  	int i;
> >>>
> >>> -	i = rp->rtort_pipe_count;
> >>> +	i = READ_ONCE(rp->rtort_pipe_count);
> >>>  	if (i > RCU_TORTURE_PIPE_LEN)
> >>>  		i = RCU_TORTURE_PIPE_LEN;
> >>>  	atomic_inc(&rcu_torture_wcount[i]);
> >>> -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> >>> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> >>> +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> >>>  		rp->rtort_mbtest = 0;
> >>>  		return true;
> >>>  	}
> >>>
> >>> But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
> >>> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
> >>> rcu_torture_writer() concurrently.
> >>>
> >>> Also, rp->rtort_pipe_count in the next line should be read using
> >>> READ_ONCE() because of data race.
> >>>
> >>> Signed-off-by: linke li <lilinke99@qq.com>
> >>> ---
> >>>  kernel/rcu/rcutorture.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >>> index 7567ca8e743c..00059ace4fd5 100644
> >>> --- a/kernel/rcu/rcutorture.c
> >>> +++ b/kernel/rcu/rcutorture.c
> >>> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
> >>>  	if (i > RCU_TORTURE_PIPE_LEN)
> >>>  		i = RCU_TORTURE_PIPE_LEN;
> >>>  	atomic_inc(&rcu_torture_wcount[i]);
> >>> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> >>> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> >>> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> >>> +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
> >>
> >> I want to say, I am not convinced with the patch because what's wrong with
> >> writing to an old index?
> >>
> >> You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
> >> early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
> >> the "incremented i" or "the increment from the latest value of pipe_count".
> >>
> >> Anyway, a slightly related/different question:
> >>
> >> Should that:
> >> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> >>
> >> Be:
> >> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
> >>
> >> ?
> > 
> > Thank you both!
> > 
> > At first glance, I would argue for something like this:
> > 
> > ------------------------------------------------------------------------
> > 
> > static bool
> > rcu_torture_pipe_update_one(struct rcu_torture *rp)
> > {
> > 	int i;
> > 	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
> > 
> > 	if (rtrcp) {
> > 		WRITE_ONCE(rp->rtort_chkp, NULL);
> > 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
> > 	}
> > 	i = READ_ONCE(rp->rtort_pipe_count) + 1;
> > 	if (i > RCU_TORTURE_PIPE_LEN)
> > 		i = RCU_TORTURE_PIPE_LEN;
> > 	atomic_inc(&rcu_torture_wcount[i]);
> > 	WRITE_ONCE(rp->rtort_pipe_count, i);
> > 	if (i >= RCU_TORTURE_PIPE_LEN) {
> > 		rp->rtort_mbtest = 0;
> > 		return true;
> > 	}
> > 	return false;
> > }
> > 
> > ------------------------------------------------------------------------
> > 
> > That is, move the increment to the read and replace the re-read with
> > the value "i" that was just written.
> 
> But that changes the original logic as well? It looks like with the above
> change, you're now writing to rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)
> + 1] instead of rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)].
> 
> I think that might break rcutorture, because there is an increment outside of
> the first 2 entries in rcu_torture_wcount but not sure (need to look more).

Good point on never incrementing the zeroth entry!  Clearly I should
have waited before replying.

How about the following?

------------------------------------------------------------------------

static bool
rcu_torture_pipe_update_one(struct rcu_torture *rp)
{
	int i;
	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);

	if (rtrcp) {
		WRITE_ONCE(rp->rtort_chkp, NULL);
		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
	}
	i = READ_ONCE(rp->rtort_pipe_count);
	if (i > RCU_TORTURE_PIPE_LEN)
		i = RCU_TORTURE_PIPE_LEN;
	atomic_inc(&rcu_torture_wcount[i]);
	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
		rp->rtort_mbtest = 0;
		return true;
	}
	return false;
}

------------------------------------------------------------------------

							Thanx, Paul

