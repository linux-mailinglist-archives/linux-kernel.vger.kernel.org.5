Return-Path: <linux-kernel+bounces-2372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA82815BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79795284F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6F23528E;
	Sat, 16 Dec 2023 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR3kSWoS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578235280;
	Sat, 16 Dec 2023 21:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E0FC433C7;
	Sat, 16 Dec 2023 21:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702761444;
	bh=wbCb7V8TWLXWLW8MxcJ7qPWIEaOem3AcnmRfFX2rmA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BR3kSWoS8OnHrcL5hEm2lXZG3sB12hceeVyLBjari4NMpLXOYePN/QDTFWzI9195P
	 eqxj/EPR3V+O3Wvnx0u00KFm5QygsEJSga2X2/PMfPif1ZVt7+g0okfxCJEKPy2wg+
	 rMpSe8NLr4ikom0S4unHw7q/yJnmmkmyEGeYv1H5S9DPf2qgaEGO2rb4kFAyNh5F3V
	 WyJWM6uziWjiGrL+CzoerPZwOTATuByWWwo6mQApSDU8rdIKv1B4BU8i7YBH3g8inm
	 gRfxbry2VSOc8sRyXhUIkds17cPQeItegGe7BufMjSJ3uD7BJHAAdhozQcSsfozGza
	 Ngwifx+19eDDg==
Date: Sat, 16 Dec 2023 22:17:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Message-ID: <ZX4T4E02hbsgnGBY@localhost.localdomain>
References: <20231211015717.1067822-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211015717.1067822-1-joel@joelfernandes.org>

Le Mon, Dec 11, 2023 at 01:57:16AM +0000, Joel Fernandes (Google) a écrit :
> The comments added in commit 1ef990c4b36b ("srcu: No need to
> advance/accelerate if no callback enqueued") are a bit confusing to me.

I know some maintainers who may argue that in the changelog world, the first
person doesn't exist :-)

> The comments are describing a scenario for code that was moved and is
> no longer the way it was (snapshot after advancing). Improve the code
> comments to reflect this and also document by acceleration can never

s/by/why

> fail.
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Fix typo in change log.
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
> +		 * Acceleration can never fail because the state of gp_seq used
> +		 * for advancing is <= the state of gp_seq used for
> +		 * acceleration.

What do you mean by "state" here? If it's the gp_seq number, that doesn't look
right. The situation raising the initial bug also involved a gp_seq used for
advancing <= the gp_seq used for acceleration.

Thanks.

> +                This means that RCU_NEXT_TAIL segment will
> +		 * always be able to be emptied by the acceleration into the
> +		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
> +		 */
>  		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
>  	}
>  	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

