Return-Path: <linux-kernel+bounces-132091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D5898F84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B41F22D63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539D1350FA;
	Thu,  4 Apr 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq4t3J+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1084133413;
	Thu,  4 Apr 2024 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261955; cv=none; b=O2Z5Jze28+45JvPW83BLkr+39iD/qGStBb8oKFu/k49G1/zCuFOdL97YkBSqoyZUDFeqwMHSDFS6FI2wvSESlhmGL1RFcQ8mtff7Na9u7gV2Ua9Ya3kDxpvFrrVMD4d6VylofPmK2DOKx9xbZVxD4hi2PFWnHHtxGsFU67tXVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261955; c=relaxed/simple;
	bh=NS25OfLBD8D7Z7nX6XcFM2Jj4Yv1a95IhOl67KbfY8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slQyxlZacVSNLXRk3mbjbL2ENpJUaku7A0OHuG9etwJojSZaG9qjAogrRnbpEGUnIha7BfJiY9hH5G7hQY/vWJSgwvROHP8+sh0JRZ4XwcTNd//BbmJ9JRMvMORQEJbPObIYnyJOsGkRuP1zmYyJO6FuFeH1aFnT3wtzMkHPbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq4t3J+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A99C433C7;
	Thu,  4 Apr 2024 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712261954;
	bh=NS25OfLBD8D7Z7nX6XcFM2Jj4Yv1a95IhOl67KbfY8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oq4t3J+uL/lSQwkTjpPBKJRUTrpFUuVCx8gq+Qqj+12XoNRw1sZnJscdV2aX7rnO0
	 JQsx3KDDrp3U8SBI3hFYmHVvdEDydn4wRd5GavqwAATcJoks318K2sgQL5C+AtE/AA
	 sh1vfmAcdHXHFuw6g+3OYugBJ4gs9HdU7mBZgUEEg38HYezWNnJCO4oZJaJ0Lf/dvi
	 PEBMVwpVL+VcKxi3WAVA+bSvFe32yV5XRcHQRAaL8Q4SGPgKLcLXSUpd9HApV5s3nA
	 2sn651qA28MYbMqAgtFBgWDOUAqlZnwNyG6zwoCb/lXNLE+IkxgVJkv7i5q/Eq0sBm
	 jOCS5a0Wy2Hfg==
Date: Thu, 4 Apr 2024 22:19:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, urezki@gmail.com,
	neeraj.iitr10@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH v4] rcu/tree: Reduce wake up for synchronize_rcu() common
 case
Message-ID: <Zg8LP9fEHlDPeq5L@pavilion.home>
References: <20240319185458.3968308-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319185458.3968308-1-joel@joelfernandes.org>

Le Tue, Mar 19, 2024 at 02:54:57PM -0400, Joel Fernandes (Google) a écrit :
> In the synchronize_rcu() common case, we will have less than
> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> is pointless just to free the last injected wait head since at that point,
> all the users have already been awakened.
> 
> Introduce a new counter to track this and prevent the wakeup in the
> common case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Rebase on paul/dev
> v2->v3: Additional optimization for wait_tail->next == NULL case.
> v3->v4: Apply clean ups from Vlad. Tested rcutorture all scenarios.
> ---
>  kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
>  kernel/rcu/tree.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9fbb5ab57c84..f3193670fe42 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
>  	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>  		rcu_sr_normal_gp_cleanup_work),
> +	.srs_cleanups_pending = ATOMIC_INIT(0),
>  };
>  
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  	 * the done tail list manipulations are protected here.
>  	 */
>  	done = smp_load_acquire(&rcu_state.srs_done_tail);
> -	if (!done)
> +	if (!done) {

Can this really happen? And if not should we warn?

> +		/* See comments below. */
> +		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);

And if not should we really do that?

>  		return;
> +	}
>  
>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>  	head = done->next;
> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>  
>  		rcu_sr_put_wait_head(rcu);
>  	}
> +
> +	/* Order list manipulations with atomic access. */
> +	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);

Can we have a sanity check here ensuring this never goes negative?

Thanks.

