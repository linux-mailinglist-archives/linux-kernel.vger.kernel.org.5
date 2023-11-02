Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815927DEBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbjKBEgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348480AbjKBEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:36:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF20E4;
        Wed,  1 Nov 2023 21:36:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2003FC433C8;
        Thu,  2 Nov 2023 04:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698899772;
        bh=5pZIeXNLC8dPpW/JdCImUZou9P6tPFfeOocsl5r3ygk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=US7AJ/y+OG3mXDYEOZLPv0hmttA9pfJAN8GlQ4YISNMak1mLGZHMck+XSv8LUkn/w
         H64WuYfW0HIhnKKdUiPjrYb4NXQJi8NZ1uHpfvdi9XcP1viLEeUy4CO0TemMlbohsp
         0aToS6Y5WPOFXIywy+z06LeTB5ljlm7BBBsZ1bAXhqa66l7B6bQU6rvM8MhQpbG22l
         ORk7q78gbjREvGQ//6VzT0odnmJaMISnthRmIlYWche6gbXFeFiKbjVT5oCNdR3lax
         fpsiP7YXudmF6l2mwUHZ+hW2V/1EW9AygFZYroMU6OaCTIYAJPNdbdeqEkD5NeZQNV
         KpS8iPgNT1svw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C88FDCE091E; Wed,  1 Nov 2023 21:36:11 -0700 (PDT)
Date:   Wed, 1 Nov 2023 21:36:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 2/3] rcu: Add a trace event for
 synchronize_rcu_normal()
Message-ID: <4364fee9-b760-42ed-b18f-434cb4937526@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030131254.488186-3-urezki@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 02:12:53PM +0100, Uladzislau Rezki (Sony) wrote:
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

This one looks good to me.

						Thanx, Paul

> ---
>  include/trace/events/rcu.h | 27 +++++++++++++++++++++++++++
>  kernel/rcu/tree.c          |  2 ++
>  2 files changed, 29 insertions(+)
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
> index f04846b543de..189975f57e78 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3630,6 +3630,7 @@ static void synchronize_rcu_normal(void)
>  {
>  	struct rcu_synchronize rs;
>  
> +	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
>  	if (READ_ONCE(rcu_normal_wake_from_gp)) {
>  		init_rcu_head_on_stack(&rs.head);
>  		init_completion(&rs.completion);
> @@ -3650,6 +3651,7 @@ static void synchronize_rcu_normal(void)
>  	} else {
>  		wait_rcu_gp(call_rcu_hurry);
>  	}
> +	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("complete"));
>  }
>  
>  /**
> -- 
> 2.30.2
> 
