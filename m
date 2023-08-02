Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1C76DADE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHBWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHBWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055710EA;
        Wed,  2 Aug 2023 15:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F2661B63;
        Wed,  2 Aug 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD2C433C8;
        Wed,  2 Aug 2023 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691016019;
        bh=ncYNi0R6QFmd8nuiw7FFifx0Ugbl+qglQ18OAjBA5dA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NPGlLLxzZwWKXqmElAKxQw35/kqjgAatcYpNKq6HB6T8H4xPvNBU5/5oAmaYPy260
         kN4SlQfnyawo9E3T+ESBWZ00+xgNIs5A0t9M+0qxzFiHGgbnrOi/w1QGCfRRbqJsuB
         oChkZWfdImFMHMa3wIGzRE7FNp6+eqDlGLiDVDrc44tyLVWdsEdbs8yV4G4K4XKYZX
         xzpX0F4DIlGw0pzrBS3FRFqNM7lZ+UaQenCYlSBk4HUq/jAMXeAEPAwSzFlRfYzpet
         NBe3sg6Z11GddjQzCbPPeIbkoc4H4xQX5eSD1D5TEtNrJLB8oIvXm4MgdnI9Jr8HN+
         xrffqXXo7k3QA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5002FCE1071; Wed,  2 Aug 2023 15:40:19 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:40:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v4 2/2] rcu: Dump memory object info if callback function
 is invalid
Message-ID: <06731ba9-0746-453e-bd1f-b857bd253543@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230802130918.1132-1-thunder.leizhen@huaweicloud.com>
 <20230802130918.1132-3-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802130918.1132-3-thunder.leizhen@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 09:09:18PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> When a structure containing an RCU callback rhp is (incorrectly) freed
> and reallocated after rhp is passed to call_rcu(), it is not unusual for
> rhp->func to be set to NULL. This defeats the debugging prints used by
> __call_rcu_common() in kernels built with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y,
> which expect to identify the offending code using the identity of this
> function.
> 
> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things
> are even worse, as can be seen from this splat:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0
> ... ...
> PC is at 0x0
> LR is at rcu_do_batch+0x1c0/0x3b8
> ... ...
>  (rcu_do_batch) from (rcu_core+0x1d4/0x284)
>  (rcu_core) from (__do_softirq+0x24c/0x344)
>  (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
>  (__irq_exit_rcu) from (irq_exit+0x8/0x10)
>  (irq_exit) from (__handle_domain_irq+0x74/0x9c)
>  (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
>  (gic_handle_irq) from (__irq_svc+0x5c/0x94)
>  (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
>  (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
>  (default_idle_call) from (do_idle+0xf8/0x150)
>  (do_idle) from (cpu_startup_entry+0x18/0x20)
>  (cpu_startup_entry) from (0xc01530)
> 
> This commit therefore adds calls to mem_dump_obj(rhp) to output some
> information, for example:
> 
>   slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
> 
> This provides the rough size of the memory block and the offset of the
> rcu_head structure, which as least provides at least a few clues to help
> locate the problem. If the problem is reproducible, additional slab
> debugging can be enabled, for example, CONFIG_DEBUG_SLAB=y, which can
> provide significantly more information.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Looks plausible, thank you!

What did you do to test this? 

One option is the object_debug module parameter to rcutorture, which is
described here: https://paulmck.livejournal.com/61432.html

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Not a big problem, but not a good habit to get into...  I add my own
Signed-off-by when I pull patches into my tree.  Or if you are thinking
in terms of sending this to mainline using some other path, when I am
good with it, I would give you a tag to use.

So were you looking for me to take these two patches?

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h      | 7 +++++++
>  kernel/rcu/srcutiny.c | 1 +
>  kernel/rcu/srcutree.c | 1 +
>  kernel/rcu/tasks.h    | 1 +
>  kernel/rcu/tiny.c     | 1 +
>  kernel/rcu/tree.c     | 1 +
>  6 files changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index d1dcb09750efbd6..bc81582238b9846 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_RCU_H
>  #define __LINUX_RCU_H
>  
> +#include <linux/slab.h>
>  #include <trace/events/rcu.h>
>  
>  /*
> @@ -248,6 +249,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>  }
>  #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
>  
> +static inline void debug_rcu_head_callback(struct rcu_head *rhp)
> +{
> +	if (unlikely(!rhp->func))
> +		kmem_dump_obj(rhp);
> +}
> +
>  extern int rcu_cpu_stall_suppress_at_boot;
>  
>  static inline bool rcu_stall_is_suppressed_at_boot(void)
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 336af24e0fe358a..c38e5933a5d6937 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
>  	while (lh) {
>  		rhp = lh;
>  		lh = lh->next;
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index f1a905200fc2f79..833a8f848a90ae6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1710,6 +1710,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>  	rhp = rcu_cblist_dequeue(&ready_cbs);
>  	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
>  		debug_rcu_head_unqueue(rhp);
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 7294be62727b12c..148ac6a464bfb12 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -538,6 +538,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  	len = rcl.len;
>  	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> +		debug_rcu_head_callback(rhp);
>  		local_bh_disable();
>  		rhp->func(rhp);
>  		local_bh_enable();
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index 42f7589e51e09e7..fec804b7908032d 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
>  
>  	trace_rcu_invoke_callback("", head);
>  	f = head->func;
> +	debug_rcu_head_callback(head);
>  	WRITE_ONCE(head->func, (rcu_callback_t)0L);
>  	f(head);
>  	rcu_lock_release(&rcu_callback_map);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7c79480bfaa04e4..927c5ba0ae42269 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2135,6 +2135,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  		trace_rcu_invoke_callback(rcu_state.name, rhp);
>  
>  		f = rhp->func;
> +		debug_rcu_head_callback(rhp);
>  		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
>  		f(rhp);
>  
> -- 
> 2.34.1
> 
