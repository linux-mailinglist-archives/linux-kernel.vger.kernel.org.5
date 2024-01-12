Return-Path: <linux-kernel+bounces-25094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1282C7E2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEB1F23B18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604A18E3A;
	Fri, 12 Jan 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njIy9xgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062C18E2C;
	Fri, 12 Jan 2024 23:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF69C433F1;
	Fri, 12 Jan 2024 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101617;
	bh=BVDuigBYTOkL1XAi3KeGeioizo6Ea+Fj47cSJCEZh/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njIy9xgkfwRBZ6Q+Ga0emA3HhdJKPpEFX6/XysqgdoxSNxKTnRs9h5//+TNuZYOa2
	 gJZp1lDAfRuhKvhNFXKIe6EAcff62F0eLMeLw4vftgJTd3M8Mugb/2u1wmaH8FYFt0
	 olA8fT7ZYG5v9PD3YaWHVIyo6ILHEhsEg7KFB8WPRS6nDCJnY0wd5Jkw7tUc5Y9I06
	 wcYUhzkFhNv2QUFOHFjVWhGh2Fi0Urqi57CBO/TmktnGgw2n7RMdSg/StJ5Hj74RsP
	 G730Kw/l2sf2PG1e7m1xYFyCEbyP6qmdK88X1RH6mrCbsKxSpZ3JF33lxJ4uPrn3Jc
	 wLbujrtPs3+5w==
Date: Sat, 13 Jan 2024 00:20:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 2/4] rcu: Add a trace event for
 synchronize_rcu_normal()
Message-ID: <ZaHJLmsoY8OTvQB9@localhost.localdomain>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104162510.72773-3-urezki@gmail.com>

Le Thu, Jan 04, 2024 at 05:25:08PM +0100, Uladzislau Rezki (Sony) a écrit :
> Add an rcu_sr_normal() trace event. It takes three arguments
> first one is the name of RCU flavour, second one is a user id
> which triggeres synchronize_rcu_normal() and last one is an
> event.
> 
> There are two traces in the synchronize_rcu_normal(). On entry,
> when a new request is registered and on exit point when request
> is completed.
> 
> Please note, CONFIG_RCU_TRACE=y is required to activate traces.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
>  kernel/rcu/tree.c          |  7 ++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 2ef9c719772a..31b3e0d3e65f 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -707,6 +707,33 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
>  		__entry->rcuname, __entry->p, __entry->nr_records)
>  );
>  
> +/*
> + * Tracepoint for a normal synchronize_rcu() states. The first argument
> + * is the RCU flavor, the second argument is a pointer to rcu_head the
> + * last one is an event.
> + */
> +TRACE_EVENT_RCU(rcu_sr_normal,

Can we call this "synchronize_rcu" instead? So people really know what it's
about.

Then should the need arise, we can still add "synchronize_rcu_expedited" trace
events later.

Thanks.

> +
> +	TP_PROTO(const char *rcuname, struct rcu_head *rhp, const char *srevent),
> +
> +	TP_ARGS(rcuname, rhp, srevent),
> +
> +	TP_STRUCT__entry(
> +		__field(const char *, rcuname)
> +		__field(void *, rhp)
> +		__field(const char *, srevent)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->rcuname = rcuname;
> +		__entry->rhp = rhp;
> +		__entry->srevent = srevent;
> +	),
> +
> +	TP_printk("%s rhp=0x%p event=%s",
> +		__entry->rcuname, __entry->rhp, __entry->srevent)
> +);
> +
>  /*
>   * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
>   * invoked.  The first argument is the name of the RCU flavor,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b756c40e4960..7d2ed89efcb3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3672,9 +3672,11 @@ static void synchronize_rcu_normal(void)
>  {
>  	struct rcu_synchronize rs;
>  
> +	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
> +
>  	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
>  		wait_rcu_gp(call_rcu_hurry);
> -		return;
> +		goto trace_complete_out;
>  	}
>  
>  	init_rcu_head_on_stack(&rs.head);
> @@ -3695,6 +3697,9 @@ static void synchronize_rcu_normal(void)
>  	/* Now we can wait. */
>  	wait_for_completion(&rs.completion);
>  	destroy_rcu_head_on_stack(&rs.head);
> +
> +trace_complete_out:
> +	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
>  }
>  
>  /**
> -- 
> 2.39.2
> 

