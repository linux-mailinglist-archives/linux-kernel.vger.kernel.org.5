Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284CA7CA944
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjJPNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJPNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:21:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961179B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:21:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0D5C433C7;
        Mon, 16 Oct 2023 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697462469;
        bh=J6Q58EpXbHuZM0jjknhudgIUvxShktGnMt77eTwFHnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fnZ0TgyFLEL25HEy4S4eXdcMFClOmOQD5O5DIcrrSlcfU+RIPGNpGusczDH2LYzpY
         f4VV/K8eh+B0yk4VBwHIWEGNjkKCZaSrKtjGpTS3ZSwla4/aoQgnk4CjA6ugp5gBJs
         /xIVCh+KPR4UbbOnGMVSnB2ytZhrQilstzWp+KPZSb6x9LaaF2Lx9keUCUCX7DsojI
         VJ0rgIYoJ8zhlZ/yCZR4P2ziBHfWlcs32lY4QusXbEZI+yW36DpgUv9OOJ1hnYo8NG
         BaS9fhtR+j8Be6uOQqv6a6nx8HbNrkR4bdywnk/icvjNEKrRQISamFthqGEjigIqMu
         mEsKI6eRzujMw==
Date:   Mon, 16 Oct 2023 22:21:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v10 3/5] kprobes: kretprobe scalability improvement with
 objpool
Message-Id: <20231016222103.cb9f426edc60220eabd8aa6a@kernel.org>
In-Reply-To: <20231015053251.707442-4-wuqiang.matt@bytedance.com>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
        <20231015053251.707442-4-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2023 13:32:49 +0800
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
>          1T       2T       4T       8T      16T      24T
>    24150045 29317964 15446741 12494489 18287272 17708768
>         32T      48T      64T      72T      96T     128T
>    16200682 13737658 11645677 11269858 10470118  9931051
> 
> This patch introduces objpool to replace freelist. objpool is a
> high performance queue, which can bring near-linear scalability
> to kretprobed routines. Tests of kretprobe throughput show the
> biggest ratio as 159x of original freelist. Here's the result:
> 
>                   1T         2T         4T         8T        16T
> native:     41186213   82336866  164250978  328662645  658810299
> freelist:   24150045   29317964   15446741   12494489   18287272
> objpool:    23926730   48010314   96125218  191782984  385091769
>                  32T        48T        64T        96T       128T
> native:   1330338351 1969957941 2512291791 1514690434 2671040914
> freelist:   16200682   13737658   11645677   10470118    9931051
> objpool:   764481096 1147149781 1456220214 1502109662 1579015050
> 
> Testings on 96-core ARM64 output similarly, but with the biggest
> ratio up to 336x:
> 
> OS: Debian 10 AARCH64, Linux 6.5rc7
> HW: Kunpeng-920 96 cores/2 sockets/4 NUMA nodes, DDR4 2933 MT/s
> 
>                   1T         2T         4T         8T        16T
> native: .   30066096   63569843  126194076  257447289  505800181
> freelist:   16152090   11064397   11124068    7215768    5663013
> objpool:    13997541   28032100   55726624  110099926  221498787
>                  24T        32T        48T        64T        96T
> native:    763305277 1015925192 1521075123 2033009392 3021013752
> freelist:    5015810    4602893    3766792    3382478    2945292
> objpool:   328192025  439439564  668534502  887401381  990067903
> 
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
> @@ -2227,19 +2227,12 @@ int register_kretprobe(struct kretprobe *rp)
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
> -		inst = kzalloc(struct_size(inst, data, rp->data_size), GFP_KERNEL);
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
> @@ -2249,24 +2241,18 @@ int register_kretprobe(struct kretprobe *rp)
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
> -		inst = kzalloc(struct_size(inst, data, rp->data_size), GFP_KERNEL);
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

Oops, this must be a bugfix. Let me fix it.

>  
>  	if (!fp->exit_handler) {
> @@ -202,29 +202,21 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  		size = fp->nr_maxactive;
>  	else
>  		size = num * num_possible_cpus() * 2;
> -	if (size < 0)
> +	if (size <= 0)
>  		return -E2BIG;

Here too.

Except for this point, it looks good to me.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
