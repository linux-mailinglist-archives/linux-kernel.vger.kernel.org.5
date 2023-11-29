Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C127FDA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjK2O6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjK2O6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:58:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166CC9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:58:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE2C433C7;
        Wed, 29 Nov 2023 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701269906;
        bh=KVV6v9vUJDXpJp3v+APRc/9eiAJF64T+HTlNQUfcykM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dOzDPIrfoOaR36h8NYlu1QIj1Oyif2F4gfwIqzmvhmoc2w6rLIyxDc/bn0JK1yA8/
         hkDD9HP4iuDtSzcNBn/Rm5/BpROJwMBJsi60epNMd60cvjzUxC36Ri8CfrwGbAQW9e
         FtT7JyZzdrMTKtKiU2AnrstR6/y2LfE7LjV3mGewPFQkwjyPydIWbRPydZmAZXDKwc
         jjGtLACm5RRa0Z7KYVBzw6X85IhjpKxtgiSr20odsp5YAJNa58L0PGV2XBTNM1vB5q
         gCnJp/NDAmq9tcs0OYu5v/aVGF7S3exrtrIcQpB1yfvYeHCni91/VWA4H+T1VPGrdJ
         hxjXTUZcaCb6Q==
Date:   Wed, 29 Nov 2023 23:58:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] tracing: Allow creating instances with specified system
 events
Message-Id: <20231129235821.d99da161644525a2fa988938@kernel.org>
In-Reply-To: <20231128122117.2276f4a7@gandalf.local.home>
References: <20231128122117.2276f4a7@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 12:21:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.
> 
> The trace_array_get_by_name() now has another parameter "systems". This
> parameter is a const string pointer of a comma/space separated list of
> event systems that should be created by the trace_array. (Note if the
> trace_array already exists, this parameter is ignored).
> 
> The list of systems is saved and if a module is loaded, its events will
> not be added unless the system for those events also match the systems
> string.
> 
> Note that all dynamic events are still added as they are created by the
> user.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since RFC: https://lore.kernel.org/all/20231127174108.3c331c9c@gandalf.local.home/
> 
> - Record "systems" in the trace_array so that only events with the system
>   name will be added. This includes modules that create events after the
>   trace_array is created.
> 
> - Dynamic events had to be specified directly to still allow them to be
>   created.

I have a question about this point. Does this mean the dynamic event files
will be created in the instance which limits the "system"?
For this point, I would like to allow limiting dynamic events on instance too.
If user needs to use specific one, e.g. synthetic, then it is possible to
add it to the filter.

Thank you,

> 
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 +--
>  include/linux/trace_events.h        |  4 +++
>  kernel/trace/trace.c                | 23 ++++++++++---
>  kernel/trace/trace.h                |  1 +
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 52 +++++++++++++++++++++++++++--
>  samples/ftrace/sample-trace-array.c |  2 +-
>  8 files changed, 78 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 03348f605c2e..dd674378f2f3 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -2889,7 +2889,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  static void
>  qla_trace_init(void)
>  {
> -	qla_trc_array = trace_array_get_by_name("qla2xxx");
> +	qla_trc_array = trace_array_get_by_name("qla2xxx", NULL);
>  	if (!qla_trc_array) {
>  		ql_log(ql_log_fatal, NULL, 0x0001,
>  		       "Unable to create qla2xxx trace instance, instance logging will be disabled.\n");
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 2a70a447184c..fdcd76b7be83 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -51,7 +51,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>  		       const char *fmt, ...);
>  int trace_array_init_printk(struct trace_array *tr);
>  void trace_array_put(struct trace_array *tr);
> -struct trace_array *trace_array_get_by_name(const char *name);
> +struct trace_array *trace_array_get_by_name(const char *name, const char *systems);
>  int trace_array_destroy(struct trace_array *tr);
>  
>  /* For osnoise tracer */
> @@ -84,7 +84,7 @@ static inline int trace_array_init_printk(struct trace_array *tr)
>  static inline void trace_array_put(struct trace_array *tr)
>  {
>  }
> -static inline struct trace_array *trace_array_get_by_name(const char *name)
> +static inline struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
>  {
>  	return NULL;
>  }
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d68ff9b1247f..ff818cab07b8 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -365,6 +365,10 @@ enum {
>  
>  #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
>  
> +#define TRACE_EVENT_FL_DYNAMIC_MASK					\
> +	(TRACE_EVENT_FL_DYNAMIC | TRACE_EVENT_FL_KPROBE |		\
> +	 TRACE_EVENT_FL_UPROBE | TRACE_EVENT_FL_EPROBE | TRACE_EVENT_FL_FPROBE)
> +
>  struct trace_event_call {
>  	struct list_head	list;
>  	struct trace_event_class *class;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9aebf904ff97..1c7129d07bfb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9520,7 +9520,8 @@ static int trace_array_create_dir(struct trace_array *tr)
>  	return ret;
>  }
>  
> -static struct trace_array *trace_array_create(const char *name)
> +static struct trace_array *
> +trace_array_create_systems(const char *name, const char *systems)
>  {
>  	struct trace_array *tr;
>  	int ret;
> @@ -9540,6 +9541,12 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
>  		goto out_free_tr;
>  
> +	if (systems) {
> +		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
> +		if (!tr->system_names)
> +			goto out_free_tr;
> +	}
> +
>  	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
>  
>  	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
> @@ -9586,12 +9593,18 @@ static struct trace_array *trace_array_create(const char *name)
>  	free_trace_buffers(tr);
>  	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
> +	kfree_const(tr->system_names);
>  	kfree(tr->name);
>  	kfree(tr);
>  
>  	return ERR_PTR(ret);
>  }
>  
> +static struct trace_array *trace_array_create(const char *name)
> +{
> +	return trace_array_create_systems(name, NULL);
> +}
> +
>  static int instance_mkdir(const char *name)
>  {
>  	struct trace_array *tr;
> @@ -9617,6 +9630,7 @@ static int instance_mkdir(const char *name)
>  /**
>   * trace_array_get_by_name - Create/Lookup a trace array, given its name.
>   * @name: The name of the trace array to be looked up/created.
> + * @system: A list of systems to create event directories for (NULL for all)
>   *
>   * Returns pointer to trace array with given name.
>   * NULL, if it cannot be created.
> @@ -9630,7 +9644,7 @@ static int instance_mkdir(const char *name)
>   * trace_array_put() is called, user space can not delete it.
>   *
>   */
> -struct trace_array *trace_array_get_by_name(const char *name)
> +struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
>  {
>  	struct trace_array *tr;
>  
> @@ -9642,7 +9656,7 @@ struct trace_array *trace_array_get_by_name(const char *name)
>  			goto out_unlock;
>  	}
>  
> -	tr = trace_array_create(name);
> +	tr = trace_array_create_systems(name, systems);
>  
>  	if (IS_ERR(tr))
>  		tr = NULL;
> @@ -9689,6 +9703,7 @@ static int __remove_instance(struct trace_array *tr)
>  
>  	free_cpumask_var(tr->pipe_cpumask);
>  	free_cpumask_var(tr->tracing_cpumask);
> +	kfree_const(tr->system_names);
>  	kfree(tr->name);
>  	kfree(tr);
>  
> @@ -10407,7 +10422,7 @@ __init static void enable_instances(void)
>  		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
>  			do_allocate_snapshot(tok);
>  
> -		tr = trace_array_get_by_name(tok);
> +		tr = trace_array_get_by_name(tok, NULL);
>  		if (!tr) {
>  			pr_warn("Failed to create instance buffer %s\n", curr_str);
>  			continue;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b7f4ea25a194..97b01dfd7070 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -377,6 +377,7 @@ struct trace_array {
>  	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
>  	unsigned int		flags;
>  	raw_spinlock_t		start_lock;
> +	const char		*system_names;
>  	struct list_head	err_log;
>  	struct dentry		*dir;
>  	struct dentry		*options;
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 7ccc7a8e155b..dbe29b4c6a7a 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -633,7 +633,7 @@ trace_boot_init_instances(struct xbc_node *node)
>  		if (!p || *p == '\0')
>  			continue;
>  
> -		tr = trace_array_get_by_name(p);
> +		tr = trace_array_get_by_name(p, NULL);
>  		if (!tr) {
>  			pr_err("Failed to get trace instance %s\n", p);
>  			continue;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index f29e815ca5b2..e8a56cf52cc1 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2896,6 +2896,31 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  	up_write(&trace_event_sem);
>  }
>  
> +static bool event_in_systems(struct trace_event_call *call,
> +			     const char *systems)
> +{
> +	const char *system;
> +	const char *p;
> +
> +	if (!systems)
> +		return true;
> +
> +	/* Dynamic events are always created */
> +	if (call->flags & TRACE_EVENT_FL_DYNAMIC_MASK)
> +		return true;
> +
> +	system = call->class->system;
> +	p = strstr(systems, system);
> +	if (!p)
> +		return false;
> +
> +	if (p != systems && !isspace(*(p - 1)) && *(p - 1) != ',')
> +		return false;
> +
> +	p += strlen(system);
> +	return !*p || isspace(*p) || *p == ',';
> +}
> +
>  static struct trace_event_file *
>  trace_create_new_event(struct trace_event_call *call,
>  		       struct trace_array *tr)
> @@ -2905,9 +2930,12 @@ trace_create_new_event(struct trace_event_call *call,
>  	struct trace_event_file *file;
>  	unsigned int first;
>  
> +	if (!event_in_systems(call, tr->system_names))
> +		return NULL;
> +
>  	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
>  	if (!file)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	pid_list = rcu_dereference_protected(tr->filtered_pids,
>  					     lockdep_is_held(&event_mutex));
> @@ -2972,8 +3000,17 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
>  	struct trace_event_file *file;
>  
>  	file = trace_create_new_event(call, tr);
> +	/*
> +	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
> +	 * allocation, or NULL if the event is not part of the tr->system_names.
> +	 * When the event is not part of the tr->system_names, return zero, not
> +	 * an error.
> +	 */
>  	if (!file)
> -		return -ENOMEM;
> +		return 0;
> +
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
>  
>  	if (eventdir_initialized)
>  		return event_create_dir(tr->event_dir, file);
> @@ -3012,8 +3049,17 @@ __trace_early_add_new_event(struct trace_event_call *call,
>  	int ret;
>  
>  	file = trace_create_new_event(call, tr);
> +	/*
> +	 * trace_create_new_event() returns ERR_PTR(-ENOMEM) if failed
> +	 * allocation, or NULL if the event is not part of the tr->system_names.
> +	 * When the event is not part of the tr->system_names, return zero, not
> +	 * an error.
> +	 */
>  	if (!file)
> -		return -ENOMEM;
> +		return 0;
> +
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
>  
>  	ret = event_define_fields(call);
>  	if (ret)
> diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
> index 6aba02a31c96..89b72957e687 100644
> --- a/samples/ftrace/sample-trace-array.c
> +++ b/samples/ftrace/sample-trace-array.c
> @@ -105,7 +105,7 @@ static int __init sample_trace_array_init(void)
>  	 * NOTE: This function increments the reference counter
>  	 * associated with the trace array - "tr".
>  	 */
> -	tr = trace_array_get_by_name("sample-instance");
> +	tr = trace_array_get_by_name("sample-instance", "sched,timer");
>  
>  	if (!tr)
>  		return -1;
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
