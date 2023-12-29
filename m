Return-Path: <linux-kernel+bounces-13274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2498202C4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA34B21FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC314AB8;
	Fri, 29 Dec 2023 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWWKooOG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035F14AA0;
	Fri, 29 Dec 2023 23:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB52C433C7;
	Fri, 29 Dec 2023 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703891449;
	bh=oQ0cC+ys/gAbywY/xLvEs4Ij2i9YNn4Y5Y6XD6BUnlQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CWWKooOGrSQvXImZJeYqdNpdE06TDVraQkQbZHyXr0I8hADv9liu3CJNiYyFyvgcW
	 EZqtj9iRO8PhlctrTvSDeGW9g+cagDwVThMxIZ80c+cBpwnpnPq/e53xOTT/xMH+r6
	 LcLizpr4jQyWLeqLBG7wqgZZeoB6SHBgTskeT5wXy/7pwPMiiS9F1a7n01JhHle4fR
	 0jWVmrdVCc6f5nscEUn7ZBUtRf7mULGVW7SIMCw5l2n+X2ekt3yRI9YSNeqBkAH7zu
	 BX87NZ0TgxkRDA9A619atyGBg3Y5wa0YRazx1NTXNHM85Ut1M9zsawhdLf+arvRUnp
	 MWxroPNwPRK7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30656CE095F; Fri, 29 Dec 2023 15:10:49 -0800 (PST)
Date: Fri, 29 Dec 2023 15:10:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v3] srcu: Improve comments about acceleration leak
Message-ID: <5d55ef20-4720-42aa-9f86-2f43444911fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <658c633a.050a0220.d8198.83e8@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658c633a.050a0220.d8198.83e8@mx.google.com>

On Wed, Dec 27, 2023 at 12:47:38PM -0500, Joel Fernandes (Google) wrote:
> The comments added in commit 1ef990c4b36b ("srcu: No need to
> advance/accelerate if no callback enqueued") are a bit confusing.
> The comments are describing a scenario for code that was moved and is
> no longer the way it was (snapshot after advancing). Improve the code
> comments to reflect this and also document why acceleration can never
> fail.
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you all!

							Thanx, Paul

> ---
> v1->v2: Fix typo in change log.
> v2->v3: Improvement to acceleration comment.
> 
>  kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0351a4e83529..051e149490d1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	if (rhp)
>  		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>  	/*
> -	 * The snapshot for acceleration must be taken _before_ the read of the
> -	 * current gp sequence used for advancing, otherwise advancing may fail
> -	 * and acceleration may then fail too.
> +	 * It's crucial to capture the snapshot 's' for acceleration before
> +	 * reading the current gp_seq that is used for advancing. This is
> +	 * essential because if the acceleration snapshot is taken after a
> +	 * failed advancement attempt, there's a risk that a grace period may
> +	 * conclude and a new one may start in the interim. If the snapshot is
> +	 * captured after this sequence of events, the acceleration snapshot 's'
> +	 * could be excessively advanced, leading to acceleration failure.
> +	 * In such a scenario, an 'acceleration leak' can occur, where new
> +	 * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
> +	 * Also note that encountering advancing failures is a normal
> +	 * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
>  	 *
> -	 * This could happen if:
> +	 * To see this, consider the following events which occur if
> +	 * rcu_seq_snap() were to be called after advance:
>  	 *
>  	 *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
>  	 *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
> @@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	if (rhp) {
>  		rcu_segcblist_advance(&sdp->srcu_cblist,
>  				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> +		/*
> +		 * Acceleration can never fail because the base current gp_seq
> +		 * used for acceleration is <= the value of gp_seq used for
> +		 * advancing. This means that RCU_NEXT_TAIL segment will
> +		 * always be able to be emptied by the acceleration into the
> +		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
> +		 */
>  		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
>  	}
>  	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

