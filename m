Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F27BC410
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjJGCCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B87BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:02:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553ACC433C7;
        Sat,  7 Oct 2023 02:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696644156;
        bh=KJhkHr+1OstL4TFT6b1EKVh3HO0T8KZsNJCqwnc4PXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GFL3ZsfrpNbonuPKcABJXR7uNJrhrziTHCnFjCtOUZ8wLeBRkkA0EXometgklNRFr
         0MQNKoKWCLcBLosWenTrbjGpHLQ/n2ot5zWnjBbugtsZW4UhIoAa/jwe8dkHDHPNqI
         9Ymw2W1jrPosuS0uRkUUEtWMLa08edGRR9x6QUVmPuUgHYBYDPUywk0XyWTtKexY7L
         ZcHG9C57k+HMf+s77Sh2wiNsh72XQgT5TrEX3AM4q1UB8EGvjg8u06n+qNlf9YweMP
         uKbjvukFvIQOf3qS7aSydfztByrurnU1f/xgUQ1JPMqkCII15j6VW8uwbmI2EnM5HS
         gG3K0PtKYznNA==
Date:   Sat, 7 Oct 2023 11:02:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v9 3/5] kprobes: kretprobe scalability improvement with
 objpool
Message-Id: <20231007110229.70b21d0d7610bdf304b5e355@kernel.org>
In-Reply-To: <20230905015255.81545-4-wuqiang.matt@bytedance.com>
References: <20230905015255.81545-1-wuqiang.matt@bytedance.com>
        <20230905015255.81545-4-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Sep 2023 09:52:53 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> kretprobe is using freelist to manage return-instances, but freelist,
> as LIFO queue based on singly linked list, scales badly and reduces
> the overall throughput of kretprobed routines, especially for high
> contention scenarios.
> 
> Here's a typical throughput test of sys_prctl (counts in 10 seconds,
> measured with perf stat -a -I 10000 -e syscalls:sys_enter_prctl):
> 
> OS: Debian 10 X86_64, Linux 6.5rc7 with freelist
> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> 
>       1T       2T       4T       8T      16T      24T
> 24150045 29317964 15446741 12494489 18287272 18287272
>      32T      48T      64T      72T      96T     128T
> 16200682  1620068 11645677 11269858 10470118  9931051
> 
> This patch introduces objpool to kretprobe and rethook, with orginal
> freelist replaced and brings near-linear scalability to kretprobed
> routines. Tests of kretprobe throughput show the biggest ratio as
> 166.7x of the original freelist. Here's the comparison:
> 
>                   1T         2T         4T         8T        16T
> native:     41186213   82336866  164250978  328662645  658810299
> freelist:   24150045   29317964   15446741   12494489   18287272
> objpool:    24663700   49410571   98544977  197725940  396294399
>                  32T        48T        64T        96T       128T
> native:   1330338351 1969957941 2512291791 1514690434 2671040914
> freelist:   16200682   13737658   11645677   10470118    9931051
> objpool:    78673470 1177354156 1514690434 1604472348 1655086824
> 
> Tests on 96-core ARM64 system output similarly, but with the biggest
> ratio up to 454.8x:
> 
> OS: Debian 10 AARCH64, Linux 6.5rc7
> HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
> 
>                   1T         2T         4T         8T        16T
> native: .   30066096   13733813  126194076  257447289  505800181
> freelist:   16152090   11064397   11124068    7215768    5663013
> objpool:    13733813   27749031   56540679  112291770  223482778
>                  24T        32T        48T        64T        96T
> native:    763305277 1015925192 1521075123 2033009392 3021013752
> freelist:    5015810    4602893    3766792    3382478    2945292
> objpool:   334605663  448310646  675018951  903449904 1339693418
> 

This looks good to me (and I have tested with updated objpool)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Wuqiang, can you update the above number with the simplified
objpool? I got better number (always 80% of the native performance)
with 128 node/probe.
(*) https://lore.kernel.org/all/20231003003923.eabc33bb3f4ffb8eac71f2af@kernel.org/

Thank you,

> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> ---
>  include/linux/kprobes.h | 11 ++---
>  include/linux/rethook.h | 16 ++-----
>  kernel/kprobes.c        | 93 +++++++++++++++++------------------------
>  kernel/trace/fprobe.c   | 32 ++++++--------
>  kernel/trace/rethook.c  | 90 ++++++++++++++++++---------------------
>  5 files changed, 98 insertions(+), 144 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 85a64cb95d75..365eb092e9c4 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -26,8 +26,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
>  #include <linux/ftrace.h>
> -#include <linux/refcount.h>
> -#include <linux/freelist.h>
> +#include <linux/objpool.h>
>  #include <linux/rethook.h>
>  #include <asm/kprobes.h>
>  
> @@ -141,7 +140,7 @@ static inline bool kprobe_ftrace(struct kprobe *p)
>   */
>  struct kretprobe_holder {
>  	struct kretprobe	*rp;
> -	refcount_t		ref;
> +	struct objpool_head	pool;
>  };
>  
>  struct kretprobe {
> @@ -154,7 +153,6 @@ struct kretprobe {
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>  	struct rethook *rh;
>  #else
> -	struct freelist_head freelist;
>  	struct kretprobe_holder *rph;
>  #endif
>  };
> @@ -165,10 +163,7 @@ struct kretprobe_instance {
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>  	struct rethook_node node;
>  #else
> -	union {
> -		struct freelist_node freelist;
> -		struct rcu_head rcu;
> -	};
> +	struct rcu_head rcu;
>  	struct llist_node llist;
>  	struct kretprobe_holder *rph;
>  	kprobe_opcode_t *ret_addr;
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index 26b6f3c81a76..ce69b2b7bc35 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -6,11 +6,10 @@
>  #define _LINUX_RETHOOK_H
>  
>  #include <linux/compiler.h>
> -#include <linux/freelist.h>
> +#include <linux/objpool.h>
>  #include <linux/kallsyms.h>
>  #include <linux/llist.h>
>  #include <linux/rcupdate.h>
> -#include <linux/refcount.h>
>  
>  struct rethook_node;
>  
> @@ -30,14 +29,12 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
>  struct rethook {
>  	void			*data;
>  	rethook_handler_t	handler;
> -	struct freelist_head	pool;
> -	refcount_t		ref;
> +	struct objpool_head	pool;
>  	struct rcu_head		rcu;
>  };
>  
>  /**
>   * struct rethook_node - The rethook shadow-stack entry node.
> - * @freelist: The freelist, linked to struct rethook::pool.
>   * @rcu: The rcu_head for deferred freeing.
>   * @llist: The llist, linked to a struct task_struct::rethooks.
>   * @rethook: The pointer to the struct rethook.
> @@ -48,20 +45,16 @@ struct rethook {
>   * on each entry of the shadow stack.
>   */
>  struct rethook_node {
> -	union {
> -		struct freelist_node freelist;
> -		struct rcu_head      rcu;
> -	};
> +	struct rcu_head		rcu;
>  	struct llist_node	llist;
>  	struct rethook		*rethook;
>  	unsigned long		ret_addr;
>  	unsigned long		frame;
>  };
>  
> -struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
> +struct rethook *rethook_alloc(void *data, rethook_handler_t handler, int size, int num);
>  void rethook_stop(struct rethook *rh);
>  void rethook_free(struct rethook *rh);
> -void rethook_add_node(struct rethook *rh, struct rethook_node *node);
>  struct rethook_node *rethook_try_get(struct rethook *rh);
>  void rethook_recycle(struct rethook_node *node);
>  void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount);
> @@ -98,4 +91,3 @@ void rethook_flush_task(struct task_struct *tk);
>  #endif
>  
>  #endif
> -
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ca385b61d546..075a632e6c7c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1877,13 +1877,27 @@ static struct notifier_block kprobe_exceptions_nb = {
>  #ifdef CONFIG_KRETPROBES
>  
>  #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
> +
> +/* callbacks for objpool of kretprobe instances */
> +static int kretprobe_init_inst(void *nod, void *context)
> +{
> +	struct kretprobe_instance *ri = nod;
> +
> +	ri->rph = context;
> +	return 0;
> +}
> +static int kretprobe_fini_pool(struct objpool_head *head, void *context)
> +{
> +	kfree(context);
> +	return 0;
> +}
> +
>  static void free_rp_inst_rcu(struct rcu_head *head)
>  {
>  	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
> +	struct kretprobe_holder *rph = ri->rph;
>  
> -	if (refcount_dec_and_test(&ri->rph->ref))
> -		kfree(ri->rph);
> -	kfree(ri);
> +	objpool_drop(ri, &rph->pool);
>  }
>  NOKPROBE_SYMBOL(free_rp_inst_rcu);
>  
> @@ -1892,7 +1906,7 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
>  	struct kretprobe *rp = get_kretprobe(ri);
>  
>  	if (likely(rp))
> -		freelist_add(&ri->freelist, &rp->freelist);
> +		objpool_push(ri, &rp->rph->pool);
>  	else
>  		call_rcu(&ri->rcu, free_rp_inst_rcu);
>  }
> @@ -1929,23 +1943,12 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
>  
>  static inline void free_rp_inst(struct kretprobe *rp)
>  {
> -	struct kretprobe_instance *ri;
> -	struct freelist_node *node;
> -	int count = 0;
> -
> -	node = rp->freelist.head;
> -	while (node) {
> -		ri = container_of(node, struct kretprobe_instance, freelist);
> -		node = node->next;
> -
> -		kfree(ri);
> -		count++;
> -	}
> +	struct kretprobe_holder *rph = rp->rph;
>  
> -	if (refcount_sub_and_test(count, &rp->rph->ref)) {
> -		kfree(rp->rph);
> -		rp->rph = NULL;
> -	}
> +	if (!rph)
> +		return;
> +	rp->rph = NULL;
> +	objpool_fini(&rph->pool);
>  }
>  
>  /* This assumes the 'tsk' is the current task or the is not running. */
> @@ -2087,19 +2090,17 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
>  static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
> +	struct kretprobe_holder *rph = rp->rph;
>  	struct kretprobe_instance *ri;
> -	struct freelist_node *fn;
>  
> -	fn = freelist_try_get(&rp->freelist);
> -	if (!fn) {
> +	ri = objpool_pop(&rph->pool);
> +	if (!ri) {
>  		rp->nmissed++;
>  		return 0;
>  	}
>  
> -	ri = container_of(fn, struct kretprobe_instance, freelist);
> -
>  	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> -		freelist_add(&ri->freelist, &rp->freelist);
> +		objpool_push(ri, &rph->pool);
>  		return 0;
>  	}
>  
> @@ -2193,7 +2194,6 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
>  int register_kretprobe(struct kretprobe *rp)
>  {
>  	int ret;
> -	struct kretprobe_instance *inst;
>  	int i;
>  	void *addr;
>  
> @@ -2227,20 +2227,12 @@ int register_kretprobe(struct kretprobe *rp)
>  		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
>  
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
> -	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler);
> -	if (!rp->rh)
> -		return -ENOMEM;
> +	rp->rh = rethook_alloc((void *)rp, kretprobe_rethook_handler,
> +				sizeof(struct kretprobe_instance) +
> +				rp->data_size, rp->maxactive);
> +	if (IS_ERR(rp->rh))
> +		return PTR_ERR(rp->rh);
>  
> -	for (i = 0; i < rp->maxactive; i++) {
> -		inst = kzalloc(sizeof(struct kretprobe_instance) +
> -			       rp->data_size, GFP_KERNEL);
> -		if (inst == NULL) {
> -			rethook_free(rp->rh);
> -			rp->rh = NULL;
> -			return -ENOMEM;
> -		}
> -		rethook_add_node(rp->rh, &inst->node);
> -	}
>  	rp->nmissed = 0;
>  	/* Establish function entry probe point */
>  	ret = register_kprobe(&rp->kp);
> @@ -2249,25 +2241,18 @@ int register_kretprobe(struct kretprobe *rp)
>  		rp->rh = NULL;
>  	}
>  #else	/* !CONFIG_KRETPROBE_ON_RETHOOK */
> -	rp->freelist.head = NULL;
>  	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
>  	if (!rp->rph)
>  		return -ENOMEM;
>  
> -	rp->rph->rp = rp;
> -	for (i = 0; i < rp->maxactive; i++) {
> -		inst = kzalloc(sizeof(struct kretprobe_instance) +
> -			       rp->data_size, GFP_KERNEL);
> -		if (inst == NULL) {
> -			refcount_set(&rp->rph->ref, i);
> -			free_rp_inst(rp);
> -			return -ENOMEM;
> -		}
> -		inst->rph = rp->rph;
> -		freelist_add(&inst->freelist, &rp->freelist);
> +	if (objpool_init(&rp->rph->pool, rp->maxactive, rp->data_size +
> +			sizeof(struct kretprobe_instance), GFP_KERNEL,
> +			rp->rph, kretprobe_init_inst, kretprobe_fini_pool)) {
> +		kfree(rp->rph);
> +		rp->rph = NULL;
> +		return -ENOMEM;
>  	}
> -	refcount_set(&rp->rph->ref, i);
> -
> +	rp->rph->rp = rp;
>  	rp->nmissed = 0;
>  	/* Establish function entry probe point */
>  	ret = register_kprobe(&rp->kp);
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 3b21f4063258..f5bf98e6b2ac 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -187,9 +187,9 @@ static void fprobe_init(struct fprobe *fp)
>  
>  static int fprobe_init_rethook(struct fprobe *fp, int num)
>  {
> -	int i, size;
> +	int size;
>  
> -	if (num < 0)
> +	if (num <= 0)
>  		return -EINVAL;
>  
>  	if (!fp->exit_handler) {
> @@ -202,29 +202,21 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  		size = fp->nr_maxactive;
>  	else
>  		size = num * num_possible_cpus() * 2;
> -	if (size < 0)
> +	if (size <= 0)
>  		return -E2BIG;
>  
> -	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
> -	if (!fp->rethook)
> -		return -ENOMEM;
> -	for (i = 0; i < size; i++) {
> -		struct fprobe_rethook_node *node;
> -
> -		node = kzalloc(sizeof(*node) + fp->entry_data_size, GFP_KERNEL);
> -		if (!node) {
> -			rethook_free(fp->rethook);
> -			fp->rethook = NULL;
> -			return -ENOMEM;
> -		}
> -		rethook_add_node(fp->rethook, &node->node);
> -	}
> +	/* Initialize rethook */
> +	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
> +				sizeof(struct fprobe_rethook_node), size);
> +	if (IS_ERR(fp->rethook))
> +		return PTR_ERR(fp->rethook);
> +
>  	return 0;
>  }
>  
>  static void fprobe_fail_cleanup(struct fprobe *fp)
>  {
> -	if (fp->rethook) {
> +	if (!IS_ERR_OR_NULL(fp->rethook)) {
>  		/* Don't need to cleanup rethook->handler because this is not used. */
>  		rethook_free(fp->rethook);
>  		fp->rethook = NULL;
> @@ -379,14 +371,14 @@ int unregister_fprobe(struct fprobe *fp)
>  	if (!fprobe_is_registered(fp))
>  		return -EINVAL;
>  
> -	if (fp->rethook)
> +	if (!IS_ERR_OR_NULL(fp->rethook))
>  		rethook_stop(fp->rethook);
>  
>  	ret = unregister_ftrace_function(&fp->ops);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (fp->rethook)
> +	if (!IS_ERR_OR_NULL(fp->rethook))
>  		rethook_free(fp->rethook);
>  
>  	ftrace_free_filter(&fp->ops);
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 5eb9b598f4e9..13c8e6773892 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -9,6 +9,7 @@
>  #include <linux/rethook.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
> +#include <linux/smp.h>
>  
>  /* Return hook list (shadow stack by list) */
>  
> @@ -36,21 +37,7 @@ void rethook_flush_task(struct task_struct *tk)
>  static void rethook_free_rcu(struct rcu_head *head)
>  {
>  	struct rethook *rh = container_of(head, struct rethook, rcu);
> -	struct rethook_node *rhn;
> -	struct freelist_node *node;
> -	int count = 1;
> -
> -	node = rh->pool.head;
> -	while (node) {
> -		rhn = container_of(node, struct rethook_node, freelist);
> -		node = node->next;
> -		kfree(rhn);
> -		count++;
> -	}
> -
> -	/* The rh->ref is the number of pooled node + 1 */
> -	if (refcount_sub_and_test(count, &rh->ref))
> -		kfree(rh);
> +	objpool_fini(&rh->pool);
>  }
>  
>  /**
> @@ -83,54 +70,62 @@ void rethook_free(struct rethook *rh)
>  	call_rcu(&rh->rcu, rethook_free_rcu);
>  }
>  
> +static int rethook_init_node(void *nod, void *context)
> +{
> +	struct rethook_node *node = nod;
> +
> +	node->rethook = context;
> +	return 0;
> +}
> +
> +static int rethook_fini_pool(struct objpool_head *head, void *context)
> +{
> +	kfree(context);
> +	return 0;
> +}
> +
>  /**
>   * rethook_alloc() - Allocate struct rethook.
>   * @data: a data to pass the @handler when hooking the return.
> - * @handler: the return hook callback function.
> + * @handler: the return hook callback function, must NOT be NULL
> + * @size: node size: rethook node and additional data
> + * @num: number of rethook nodes to be preallocated
>   *
>   * Allocate and initialize a new rethook with @data and @handler.
> - * Return NULL if memory allocation fails or @handler is NULL.
> + * Return pointer of new rethook, or error codes for failures.
> + *
>   * Note that @handler == NULL means this rethook is going to be freed.
>   */
> -struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
> +struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
> +			      int size, int num)
>  {
> -	struct rethook *rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
> +	struct rethook *rh;
>  
> -	if (!rh || !handler) {
> -		kfree(rh);
> -		return NULL;
> -	}
> +	if (!handler || num <= 0 || size < sizeof(struct rethook_node))
> +		return ERR_PTR(-EINVAL);
> +
> +	rh = kzalloc(sizeof(struct rethook), GFP_KERNEL);
> +	if (!rh)
> +		return ERR_PTR(-ENOMEM);
>  
>  	rh->data = data;
>  	rh->handler = handler;
> -	rh->pool.head = NULL;
> -	refcount_set(&rh->ref, 1);
>  
> +	/* initialize the objpool for rethook nodes */
> +	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
> +			 rethook_init_node, rethook_fini_pool)) {
> +		kfree(rh);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  	return rh;
>  }
>  
> -/**
> - * rethook_add_node() - Add a new node to the rethook.
> - * @rh: the struct rethook.
> - * @node: the struct rethook_node to be added.
> - *
> - * Add @node to @rh. User must allocate @node (as a part of user's
> - * data structure.) The @node fields are initialized in this function.
> - */
> -void rethook_add_node(struct rethook *rh, struct rethook_node *node)
> -{
> -	node->rethook = rh;
> -	freelist_add(&node->freelist, &rh->pool);
> -	refcount_inc(&rh->ref);
> -}
> -
>  static void free_rethook_node_rcu(struct rcu_head *head)
>  {
>  	struct rethook_node *node = container_of(head, struct rethook_node, rcu);
> +	struct rethook *rh = node->rethook;
>  
> -	if (refcount_dec_and_test(&node->rethook->ref))
> -		kfree(node->rethook);
> -	kfree(node);
> +	objpool_drop(node, &rh->pool);
>  }
>  
>  /**
> @@ -145,7 +140,7 @@ void rethook_recycle(struct rethook_node *node)
>  	lockdep_assert_preemption_disabled();
>  
>  	if (likely(READ_ONCE(node->rethook->handler)))
> -		freelist_add(&node->freelist, &node->rethook->pool);
> +		objpool_push(node, &node->rethook->pool);
>  	else
>  		call_rcu(&node->rcu, free_rethook_node_rcu);
>  }
> @@ -161,7 +156,6 @@ NOKPROBE_SYMBOL(rethook_recycle);
>  struct rethook_node *rethook_try_get(struct rethook *rh)
>  {
>  	rethook_handler_t handler = READ_ONCE(rh->handler);
> -	struct freelist_node *fn;
>  
>  	lockdep_assert_preemption_disabled();
>  
> @@ -178,11 +172,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
>  	if (unlikely(!rcu_is_watching()))
>  		return NULL;
>  
> -	fn = freelist_try_get(&rh->pool);
> -	if (!fn)
> -		return NULL;
> -
> -	return container_of(fn, struct rethook_node, freelist);
> +	return (struct rethook_node *)objpool_pop(&rh->pool);
>  }
>  NOKPROBE_SYMBOL(rethook_try_get);
>  
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
