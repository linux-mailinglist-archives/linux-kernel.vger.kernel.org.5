Return-Path: <linux-kernel+bounces-90991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7076D87081F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B609282C78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53E60263;
	Mon,  4 Mar 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxvLOxm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA375F578;
	Mon,  4 Mar 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572499; cv=none; b=B5hbqIJulfpZwtHBhhClB+CuAVuNE6tDbFoKMGOy+Z3IZ9bJA33qLAcmcnsbRaanhySlPGZyzQlb1QT6H9fanVbDY54SvInDMpSfi4X6YhRrQk7ZdK50X+U9XLfWzhlmZwtWLqLQMtpkaiOWypJeIvjVRmsE23lfbAzYrD+Zpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572499; c=relaxed/simple;
	bh=qd1sOSLgOf8ddIitiyjFvw08DRRUrMXsMLTlEEydo9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSPZrLTaPcjCgg+qcesDfW7aIhSuZCTl9g5gTaptZaT4byw7f/Ac2hA3nSlsq/4Hc7wVN9hbi9xzDJcUsWoeQqRLVtfB+CKwhRiMyi6RnSQRyb8TSTtFYI6ycB/YkZWEtM7Zk1GfL8RTP8A042maGOBt/K/eY+pJkJBKejwwt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxvLOxm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EA9C433F1;
	Mon,  4 Mar 2024 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572499;
	bh=qd1sOSLgOf8ddIitiyjFvw08DRRUrMXsMLTlEEydo9I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WxvLOxm+bLVFox71x36H10zK/rEm95p+xeN5dbVqTJBx31m/Ad/Jtr4BKWCPwN+3p
	 Go0uv4X6zdfHo9aSWZmWQl1XOTSLBmY3DN/jA43+8QitxXg5UYPp13u/4RyR++IZMR
	 i4qnOXgH98AZthkjB7j27HFTz7PYLwazQ6eD/ym5p+nekkB3C6eHQmxc/uwCKDPGeU
	 qF6+PKy9sHMs17oaYHpdIV0yqBT4++fH2F4VCiyEdN4Ukf2/ULl+8nyI/MrkhTA8de
	 ATgGDaKw0+qV2K/RztMSqTlVRpFDdnDUWmY5DSH4QrWrqg0a693WOpL6duAhrNx1Ix
	 HRFQAZhLs6Xnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8AE62CE0468; Mon,  4 Mar 2024 09:14:58 -0800 (PST)
Date: Mon, 4 Mar 2024 09:14:58 -0800
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
Message-ID: <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
 <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>

On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
> 
> 
> On 3/4/2024 5:54 AM, linke li wrote:
> > Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
> > 
> >  {
> >  	int i;
> > 
> > -	i = rp->rtort_pipe_count;
> > +	i = READ_ONCE(rp->rtort_pipe_count);
> >  	if (i > RCU_TORTURE_PIPE_LEN)
> >  		i = RCU_TORTURE_PIPE_LEN;
> >  	atomic_inc(&rcu_torture_wcount[i]);
> > -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> > +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> > +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> >  		rp->rtort_mbtest = 0;
> >  		return true;
> >  	}
> > 
> > But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
> > rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
> > rcu_torture_writer() concurrently.
> > 
> > Also, rp->rtort_pipe_count in the next line should be read using
> > READ_ONCE() because of data race.
> > 
> > Signed-off-by: linke li <lilinke99@qq.com>
> > ---
> >  kernel/rcu/rcutorture.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 7567ca8e743c..00059ace4fd5 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
> >  	if (i > RCU_TORTURE_PIPE_LEN)
> >  		i = RCU_TORTURE_PIPE_LEN;
> >  	atomic_inc(&rcu_torture_wcount[i]);
> > -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> > -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> > +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> > +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
> 
> I want to say, I am not convinced with the patch because what's wrong with
> writing to an old index?
> 
> You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
> early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
> the "incremented i" or "the increment from the latest value of pipe_count".
> 
> Anyway, a slightly related/different question:
> 
> Should that:
> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> 
> Be:
> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
> 
> ?

Thank you both!

At first glance, I would argue for something like this:

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
	i = READ_ONCE(rp->rtort_pipe_count) + 1;
	if (i > RCU_TORTURE_PIPE_LEN)
		i = RCU_TORTURE_PIPE_LEN;
	atomic_inc(&rcu_torture_wcount[i]);
	WRITE_ONCE(rp->rtort_pipe_count, i);
	if (i >= RCU_TORTURE_PIPE_LEN) {
		rp->rtort_mbtest = 0;
		return true;
	}
	return false;
}

------------------------------------------------------------------------

That is, move the increment to the read and replace the re-read with
the value "i" that was just written.

Thoughts?

							Thanx, Paul

