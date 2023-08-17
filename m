Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE177F872
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351747AbjHQONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351748AbjHQONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA610C8;
        Thu, 17 Aug 2023 07:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB79566298;
        Thu, 17 Aug 2023 14:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B91C433C9;
        Thu, 17 Aug 2023 14:13:26 +0000 (UTC)
Date:   Thu, 17 Aug 2023 10:13:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
Subject: Re: [RFC PATCH] tracing: Introduce pipe_cpumask to avoid race on
 trace_pipes
Message-ID: <20230817101331.21ab6b33@gandalf.local.home>
In-Reply-To: <20230817115057.1637676-1-zhengyejian1@huawei.com>
References: <20230816152308.5f887721@gandalf.local.home>
        <20230817115057.1637676-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 19:50:57 +0800
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
> ---
> 
> > Does that work for this?  
> 
> Hi, Steven, how about using a cpumask instead of ref count?
> This patch will also prevent main trace_pipe or anyone per_cpu trace_pipe
> from being opened by multiple people at the same time.

I'm fine with the CPU mask.

> 
>  kernel/trace/trace.c | 56 ++++++++++++++++++++++++++++++++++++++------
>  kernel/trace/trace.h |  2 ++
>  2 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b8870078ef58..73f6f4d10d43 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6705,24 +6705,54 @@ tracing_max_lat_write(struct file *filp, const char __user *ubuf,
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
> +	} else {
> +		if (!cpumask_test_cpu(cpu, tr->pipe_cpumask)) {
> +			cpumask_set_cpu(cpu, tr->pipe_cpumask);
> +			return 0;
> +		}
> +	}
> +	return -EBUSY;

The above would look nicer if you had that be } else if () {

	if (cpu == RING_BUFFER_ALL_CPUS) {
		if (cpumask_empty(tr->pipe_cpumask)) {
			cpumask_setall(tr->pipe_cpumask);
			return 0;
		}
	} else if (!cpumask_test_cpu(cpu, tr->pipe_cpumask)) {
		cpumask_set_cpu(cpu, tr->pipe_cpumask);
		return 0;
	}
	return -EBUSY;


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
>  	int ret;
> +	int cpu = tracing_get_cpu(inode);

tracing_get_cpu() must be called after tracing_check_open_get_tr(),
otherwise it may not be reliable.

Also, keep "int ret;" as the last declaration.

-- Steve

>  
>  	ret = tracing_check_open_get_tr(tr);
>  	if (ret)
>  		return ret;
>  
>  	mutex_lock(&trace_types_lock);
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
> @@ -6745,7 +6775,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  
>  	iter->tr = tr;
>  	iter->array_buffer = &tr->array_buffer;
> -	iter->cpu_file = tracing_get_cpu(inode);
> +	iter->cpu_file = cpu;
>  	mutex_init(&iter->mutex);
>  	filp->private_data = iter;
>  
> @@ -6755,12 +6785,15 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
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
> @@ -6777,7 +6810,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	if (iter->trace->pipe_close)
>  		iter->trace->pipe_close(iter);
> -
> +	close_pipe_on_cpu(tr, iter->cpu_file);
>  	mutex_unlock(&trace_types_lock);
>  
>  	free_cpumask_var(iter->started);
> @@ -9441,6 +9474,9 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
>  		goto out_free_tr;
>  
> +	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> +		goto out_free_tr;
> +
>  	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
>  
>  	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
> @@ -9482,6 +9518,7 @@ static struct trace_array *trace_array_create(const char *name)
>   out_free_tr:
>  	ftrace_free_ftrace_ops(tr);
>  	free_trace_buffers(tr);
> +	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
>  	kfree(tr);
> @@ -9584,6 +9621,7 @@ static int __remove_instance(struct trace_array *tr)
>  	}
>  	kfree(tr->topts);
>  
> +	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
>  	kfree(tr);
> @@ -10381,12 +10419,14 @@ __init static int tracer_alloc_buffers(void)
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
> @@ -10439,6 +10479,8 @@ __init static int tracer_alloc_buffers(void)
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

