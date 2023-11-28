Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFE7FC1A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbjK1PRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346672AbjK1PRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:17:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7E10F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:17:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185B4C433C7;
        Tue, 28 Nov 2023 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701184663;
        bh=JxTiC2/pHqKRcO7pIH/J23k4YSH4V5N4dUr8JnjOdek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M5FhcpqWTArLBNAWue0LZ6I3Ts52em/nuo/3wG0GLaHf8xZ2KEfjV7c7ZfIy74ppW
         m953KJSddGJvt0ZlsTGap6wECyfV/9iVBpvCTPBc/mU1bfEW3NUeF7nulOWQuRh4OU
         rcCjL7CdiIBVhkoskNlk0dTDRjgcN4q+ksrxeBQdYEeucDjAZCAdh4eTw/ZWD3G7J4
         LJTINHDDVGkSD93qSAhd3n4ZzpCv1zPPenqhYvpLndnMdF9INQ0YzX2xm8oMWb6zPy
         Uu/9zjQmDhod+HdsEob0F4aF709hhod0VPgQD8euac3YvHLi2LQ3Ry0L6jIYtU0Jfg
         K8rQ2+YXXTLAQ==
Date:   Wed, 29 Nov 2023 00:17:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        dmaluka@google.com, Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC][PATCH] tracing: Allow creating instances with specified
 system events
Message-Id: <20231129001738.5041154000c4c1df58f6c7a1@kernel.org>
In-Reply-To: <20231127174108.3c331c9c@gandalf.local.home>
References: <20231127174108.3c331c9c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 27 Nov 2023 17:41:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A trace instance may only need to enable specific events. As the eventfs
> directory of an instance currently creates all events which adds overhead,
> allow internal instances to be created with just the events in systems
> that they care about. This currently only deals with systems and not
> individual events, but this should bring down the overhead of creating
> instances for specific use cases quite bit.

This sounds good, but can the eventfs reduce such overhead because
if the user doesn't touch the actual event, the event dentry will
be released soon?

> 
> The qla2xxx instance could just enable the systems it cares about, but that
> should be a separate patch.
> 
> Note that kprobes and synthetic events created after the creation of these
> instances, will be added to these instances, but those that are created
> before the creation of the instance will not be included.
> 
> Note, this may also be useful for creating instances in the eventfs, but
> I'm not sure how to do this there. I could add a deliminator:
> 
>   mkdir /sys/kernel/tracing/instances/foo::sched,timer

Can we limit this after making an instance? In that case, we can use
rmdir to remove unused "systems" directories. Or, maybe we can create
it afterwards with mkdir or use comand to a pseudo file.

echo sched:* timer:* > instances/foo/available_events

Thank you,

> 
> But if a tool already uses "::" as a deliminator, then this will break it.
> I could just have it work if all the events after the deliminator exist.
> 
>   Thoughts?
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c       |  2 +-
>  include/linux/trace.h               |  4 ++--
>  kernel/trace/trace.c                | 22 ++++++++++++--------
>  kernel/trace/trace.h                |  3 ++-
>  kernel/trace/trace_boot.c           |  2 +-
>  kernel/trace/trace_events.c         | 31 ++++++++++++++++++++++++++---
>  samples/ftrace/sample-trace-array.c |  2 +-
>  7 files changed, 49 insertions(+), 17 deletions(-)
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
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9aebf904ff97..3a5637ccabfd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9500,7 +9500,7 @@ struct trace_array *trace_array_find_get(const char *instance)
>  	return tr;
>  }
>  
> -static int trace_array_create_dir(struct trace_array *tr)
> +static int trace_array_create_dir(struct trace_array *tr, const char *systems)
>  {
>  	int ret;
>  
> @@ -9508,7 +9508,7 @@ static int trace_array_create_dir(struct trace_array *tr)
>  	if (!tr->dir)
>  		return -EINVAL;
>  
> -	ret = event_trace_add_tracer(tr->dir, tr);
> +	ret = event_trace_add_tracer(tr->dir, tr, systems);
>  	if (ret) {
>  		tracefs_remove(tr->dir);
>  		return ret;
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
> @@ -9569,7 +9570,7 @@ static struct trace_array *trace_array_create(const char *name)
>  	init_trace_flags_index(tr);
>  
>  	if (trace_instance_dir) {
> -		ret = trace_array_create_dir(tr);
> +		ret = trace_array_create_dir(tr, systems);
>  		if (ret)
>  			goto out_free_tr;
>  	} else
> @@ -9592,6 +9593,11 @@ static struct trace_array *trace_array_create(const char *name)
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
> @@ -9630,7 +9636,7 @@ static int instance_mkdir(const char *name)
>   * trace_array_put() is called, user space can not delete it.
>   *
>   */
> -struct trace_array *trace_array_get_by_name(const char *name)
> +struct trace_array *trace_array_get_by_name(const char *name, const char *systems)
>  {
>  	struct trace_array *tr;
>  
> @@ -9642,7 +9648,7 @@ struct trace_array *trace_array_get_by_name(const char *name)
>  			goto out_unlock;
>  	}
>  
> -	tr = trace_array_create(name);
> +	tr = trace_array_create_systems(name, systems);
>  
>  	if (IS_ERR(tr))
>  		tr = NULL;
> @@ -9758,7 +9764,7 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>  		if (!tr->name)
>  			continue;
> -		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
> +		if (MEM_FAIL(trace_array_create_dir(tr, NULL) < 0,
>  			     "Failed to create instance directory\n"))
>  			break;
>  	}
> @@ -10407,7 +10413,7 @@ __init static void enable_instances(void)
>  		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
>  			do_allocate_snapshot(tok);
>  
> -		tr = trace_array_get_by_name(tok);
> +		tr = trace_array_get_by_name(tok, NULL);
>  		if (!tr) {
>  			pr_warn("Failed to create instance buffer %s\n", curr_str);
>  			continue;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b7f4ea25a194..eb1bc1c572c3 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1540,7 +1540,8 @@ extern void trace_event_enable_tgid_record(bool enable);
>  
>  extern int event_trace_init(void);
>  extern int init_events(void);
> -extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
> +extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr,
> +				  const char *system);
>  extern int event_trace_del_tracer(struct trace_array *tr);
>  extern void __trace_early_add_events(struct trace_array *tr);
>  
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
> index f29e815ca5b2..9a1d91a7edf2 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3205,14 +3205,37 @@ static struct notifier_block trace_module_nb = {
>  };
>  #endif /* CONFIG_MODULES */
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
>  /* Create a new event directory structure for a trace directory. */
>  static void
> -__trace_add_event_dirs(struct trace_array *tr)
> +__trace_add_event_dirs(struct trace_array *tr, const char *systems)
>  {
>  	struct trace_event_call *call;
>  	int ret;
>  
>  	list_for_each_entry(call, &ftrace_events, list) {
> +		if (!event_in_systems(call, systems))
> +			continue;
>  		ret = __trace_add_new_event(call, tr);
>  		if (ret < 0)
>  			pr_warn("Could not create directory for event %s\n",
> @@ -3820,6 +3843,7 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>   * event_trace_add_tracer - add a instance of a trace_array to events
>   * @parent: The parent dentry to place the files/directories for events in
>   * @tr: The trace array associated with these events
> + * @systems: comma separated list of event systems to create (NULL for all)
>   *
>   * When a new instance is created, it needs to set up its events
>   * directory, as well as other files associated with events. It also
> @@ -3829,7 +3853,8 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>   *
>   * Must be called with event_mutex held.
>   */
> -int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
> +int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr,
> +			   const char *systems)
>  {
>  	int ret;
>  
> @@ -3844,7 +3869,7 @@ int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
>  	if (unlikely(!list_empty(&tr->events)))
>  		__trace_early_add_event_dirs(tr);
>  	else
> -		__trace_add_event_dirs(tr);
> +		__trace_add_event_dirs(tr, systems);
>  	up_write(&trace_event_sem);
>  
>   out:
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
