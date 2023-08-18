Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E2780549
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357940AbjHRFDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357941AbjHRFDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2307358E;
        Thu, 17 Aug 2023 22:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87D1B63DCF;
        Fri, 18 Aug 2023 05:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D77C433C8;
        Fri, 18 Aug 2023 05:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692334994;
        bh=Xe7q7+0L2tJmvnBCko+VRWapSjMia7Dg+dMl4WlGIGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ab78qhF8TMKTq/pZHwO5YGKRkadHYy9wYWYyhGkQpyurND1EvKVrjfvK3UqZWnBPl
         SwuYLWt4OuOtqOZLVx+gw1ZzoxxiYwqJLrS3CFAKuLu9IQWUMa+lFvL86HRDV3f86q
         WIyS6ArNzJz6jcsuoAbfts14pVEd5RP37tVPzn54l9t/4OPA7WDtfTMNzLVsUal0ii
         FjZj6wzRFJE0CJehOmNF7lCfj6ULvitjY7wl7cchDWm3FhxujWiURsP9gGC15Mt/Cu
         7P+kJtV2D1sD9YPckfjmqmtz4+3sb5qZGgya/RHudq1H+Juuo2PZSXRPv/uWyf1BkK
         YI+xp06ic1xMg==
Date:   Fri, 18 Aug 2023 14:03:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>
Subject: Re: [PATCH v2] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-Id: <20230818140309.b0a720afa87b05a2b7b27315@kernel.org>
In-Reply-To: <20230818022645.1948314-1-zhengyejian1@huawei.com>
References: <20230817115057.1637676-1-zhengyejian1@huawei.com>
        <20230818022645.1948314-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 10:26:45 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> There is race issue when concurrently splice_read main trace_pipe and
> per_cpu trace_pipes which will result in data read out being different
> from what actually writen.
> 
> As suggested by Steven:
>   > I believe we should add a ref count to trace_pipe and the per_cpu
>   > trace_pipes, where if they are opened, nothing else can read it.
>   >
>   > Opening trace_pipe locks all per_cpu ref counts, if any of them are
>   > open, then the trace_pipe open will fail (and releases any ref counts
>   > it had taken).
>   >
>   > Opening a per_cpu trace_pipe will up the ref count for just that
>   > CPU buffer. This will allow multiple tasks to read different per_cpu
>   > trace_pipe files, but will prevent the main trace_pipe file from
>   > being opened.
> 
> But because we only need to know whether per_cpu trace_pipe is open or
> not, using a cpumask instead of using ref count may be easier.
> 
> After this patch, users will find that:
>  - Main trace_pipe can be opened by only one user, and if it is
>    opened, all per_cpu trace_pipes cannot be opened;
>  - Per_cpu trace_pipes can be opened by multiple users, but each per_cpu
>    trace_pipe can only be opened by one user. And if one of them is
>    opened, main trace_pipe cannot be opened.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Looks good to me. 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, this reminds me that splice read support had been introduced for
virtio-trace support. I've tested it with/without this patch, but I hit
a different issue, which seems like a virtio-serial issue (per-cpu buffers
on the guest are spliced correctly, but the data can not be read from host
side). Let me investigate it.

Thank you,

> ---
> 
> v2:
>   - In open_pipe_on_cpu(), clean format of if statements.
>   - In tracing_open_pipe(), call tracing_get_cpu() after
>     tracing_check_open_get_tr() and within trace_types_lock,
>     also keep "int ret;" as the last declaration.
>     Link: https://lore.kernel.org/all/20230817101331.21ab6b33@gandalf.local.home/
> 
> v1:
>   - Link: https://lore.kernel.org/all/20230817115057.1637676-1-zhengyejian1@huawei.com/
> 
>  kernel/trace/trace.c | 55 ++++++++++++++++++++++++++++++++++++++------
>  kernel/trace/trace.h |  2 ++
>  2 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b8870078ef58..c888a0a2c0e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6705,10 +6705,36 @@ tracing_max_lat_write(struct file *filp, const char __user *ubuf,
>  
>  #endif
>  
> +static int open_pipe_on_cpu(struct trace_array *tr, int cpu)
> +{
> +	if (cpu == RING_BUFFER_ALL_CPUS) {
> +		if (cpumask_empty(tr->pipe_cpumask)) {
> +			cpumask_setall(tr->pipe_cpumask);
> +			return 0;
> +		}
> +	} else if (!cpumask_test_cpu(cpu, tr->pipe_cpumask)) {
> +		cpumask_set_cpu(cpu, tr->pipe_cpumask);
> +		return 0;
> +	}
> +	return -EBUSY;
> +}
> +
> +static void close_pipe_on_cpu(struct trace_array *tr, int cpu)
> +{
> +	if (cpu == RING_BUFFER_ALL_CPUS) {
> +		WARN_ON(!cpumask_full(tr->pipe_cpumask));
> +		cpumask_clear(tr->pipe_cpumask);
> +	} else {
> +		WARN_ON(!cpumask_test_cpu(cpu, tr->pipe_cpumask));
> +		cpumask_clear_cpu(cpu, tr->pipe_cpumask);
> +	}
> +}
> +
>  static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  {
>  	struct trace_array *tr = inode->i_private;
>  	struct trace_iterator *iter;
> +	int cpu;
>  	int ret;
>  
>  	ret = tracing_check_open_get_tr(tr);
> @@ -6716,13 +6742,16 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  		return ret;
>  
>  	mutex_lock(&trace_types_lock);
> +	cpu = tracing_get_cpu(inode);
> +	ret = open_pipe_on_cpu(tr, cpu);
> +	if (ret)
> +		goto fail_pipe_on_cpu;
>  
>  	/* create a buffer to store the information to pass to userspace */
>  	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
>  	if (!iter) {
>  		ret = -ENOMEM;
> -		__trace_array_put(tr);
> -		goto out;
> +		goto fail_alloc_iter;
>  	}
>  
>  	trace_seq_init(&iter->seq);
> @@ -6745,7 +6774,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  
>  	iter->tr = tr;
>  	iter->array_buffer = &tr->array_buffer;
> -	iter->cpu_file = tracing_get_cpu(inode);
> +	iter->cpu_file = cpu;
>  	mutex_init(&iter->mutex);
>  	filp->private_data = iter;
>  
> @@ -6755,12 +6784,15 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  	nonseekable_open(inode, filp);
>  
>  	tr->trace_ref++;
> -out:
> +
>  	mutex_unlock(&trace_types_lock);
>  	return ret;
>  
>  fail:
>  	kfree(iter);
> +fail_alloc_iter:
> +	close_pipe_on_cpu(tr, cpu);
> +fail_pipe_on_cpu:
>  	__trace_array_put(tr);
>  	mutex_unlock(&trace_types_lock);
>  	return ret;
> @@ -6777,7 +6809,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	if (iter->trace->pipe_close)
>  		iter->trace->pipe_close(iter);
> -
> +	close_pipe_on_cpu(tr, iter->cpu_file);
>  	mutex_unlock(&trace_types_lock);
>  
>  	free_cpumask_var(iter->started);
> @@ -9441,6 +9473,9 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
>  		goto out_free_tr;
>  
> +	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> +		goto out_free_tr;
> +
>  	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
>  
>  	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
> @@ -9482,6 +9517,7 @@ static struct trace_array *trace_array_create(const char *name)
>   out_free_tr:
>  	ftrace_free_ftrace_ops(tr);
>  	free_trace_buffers(tr);
> +	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
>  	kfree(tr);
> @@ -9584,6 +9620,7 @@ static int __remove_instance(struct trace_array *tr)
>  	}
>  	kfree(tr->topts);
>  
> +	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
>  	kfree(tr);
> @@ -10381,12 +10418,14 @@ __init static int tracer_alloc_buffers(void)
>  	if (trace_create_savedcmd() < 0)
>  		goto out_free_temp_buffer;
>  
> +	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
> +		goto out_free_savedcmd;
> +
>  	/* TODO: make the number of buffers hot pluggable with CPUS */
>  	if (allocate_trace_buffers(&global_trace, ring_buf_size) < 0) {
>  		MEM_FAIL(1, "tracer: failed to allocate ring buffer!\n");
> -		goto out_free_savedcmd;
> +		goto out_free_pipe_cpumask;
>  	}
> -
>  	if (global_trace.buffer_disabled)
>  		tracing_off();
>  
> @@ -10439,6 +10478,8 @@ __init static int tracer_alloc_buffers(void)
>  
>  	return 0;
>  
> +out_free_pipe_cpumask:
> +	free_cpumask_var(global_trace.pipe_cpumask);
>  out_free_savedcmd:
>  	free_saved_cmdlines_buffer(savedcmd);
>  out_free_temp_buffer:
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index e1edc2197fc8..53ac0f7780c2 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -377,6 +377,8 @@ struct trace_array {
>  	struct list_head	events;
>  	struct trace_event_file *trace_marker_file;
>  	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
> +	/* one per_cpu trace_pipe can be opened by only one user */
> +	cpumask_var_t		pipe_cpumask;
>  	int			ref;
>  	int			trace_ref;
>  #ifdef CONFIG_FUNCTION_TRACER
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
