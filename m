Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89427E32AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjKGBsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCE11F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 17:48:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42041C433C8;
        Tue,  7 Nov 2023 01:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699321681;
        bh=CKwjpTG7MJNielJIoM00sd6eXu7x3IOlS8MVxwqNats=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L7zjE0NZtBV4FbRXpTA7PX5NK1699ItkbVPWK1Db8EMXaVV5e4Pv2t6QetZOqNqzM
         WFOxVZ6MaND1ZMBTNKvSWtq0kVUsL7enH9vY7D926KZDVmviZXJMstE/lEFL711Feh
         7S/C16ULC9LGt0lbSYmWF2Or3rb+vI9Am8vUqO1RIKFRwz9FRct1itz40jRhLjvt2i
         2HNffJRb9ewxov/3kbv1HFUTjb81hhMMGrudtRqIbSX99iKEEUmlvvHkKlAflSrIhJ
         ZQEaj/E1eEjNB9yPFJg8v/hWmyZoXP7BPzFXmDV2VGKcSoJ68DS0QcfkzahQqEWoa1
         8fV3D+qYyO9Vg==
Date:   Tue, 7 Nov 2023 10:47:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 10/32] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20231107104755.19a72f896a016f5d4c165f31@kernel.org>
In-Reply-To: <169920051199.482486.17674190105884047734.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920051199.482486.17674190105884047734.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 01:08:32 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Allow for instances to have their own ftrace_ops part of the fgraph_ops that
> makes the funtion_graph tracer filter on the set_ftrace_filter file of the
> instance and not the top instance.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/ftrace.h               |    1 +
>  kernel/trace/fgraph.c                |   60 +++++++++++++++++++++-------------
>  kernel/trace/ftrace.c                |    6 ++-
>  kernel/trace/trace.h                 |   16 +++++----
>  kernel/trace/trace_functions.c       |    2 +
>  kernel/trace/trace_functions_graph.c |    8 +++--
>  6 files changed, 58 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7fd044ae3da5..9dab365c6023 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1044,6 +1044,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
>  struct fgraph_ops {
>  	trace_func_graph_ent_t		entryfunc;
>  	trace_func_graph_ret_t		retfunc;
> +	struct ftrace_ops		ops; /* for the hash lists */
>  	void				*private;
>  };
>  
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 1e8c17f70b84..0642f3281b64 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -17,14 +17,6 @@
>  #include "ftrace_internal.h"
>  #include "trace.h"
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -#define ASSIGN_OPS_HASH(opsname, val) \
> -	.func_hash		= val, \
> -	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
> -#else
> -#define ASSIGN_OPS_HASH(opsname, val)
> -#endif
> -
>  #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
>  #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
>  
> @@ -338,9 +330,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  		return -EBUSY;
>  #endif
>  
> -	if (!ftrace_ops_test(&global_ops, func, NULL))
> -		return -EBUSY;
> -
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
>  
> @@ -361,7 +350,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  			atomic_inc(&current->trace_overrun);
>  			break;
>  		}
> -		if (fgraph_array[i]->entryfunc(&trace, fgraph_array[i])) {
> +		if (ftrace_ops_test(&gops->ops, func, NULL) &&
> +		    gops->entryfunc(&trace, gops)) {
>  			offset = current->curr_ret_stack;
>  			/* Check the top level stored word */
>  			type = get_fgraph_type(current, offset - 1);
> @@ -656,17 +646,25 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  }
>  #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
>  
> -static struct ftrace_ops graph_ops = {
> -	.func			= ftrace_graph_func,
> -	.flags			= FTRACE_OPS_FL_INITIALIZED |
> -				   FTRACE_OPS_FL_PID |
> -				   FTRACE_OPS_GRAPH_STUB,
> +void fgraph_init_ops(struct ftrace_ops *dst_ops,
> +		     struct ftrace_ops *src_ops)
> +{
> +	dst_ops->func = ftrace_stub;
> +	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;

This needs to use FTRACE_OPS_GRAPH_STUB instead of FTRACE_OPS_FL_STUB, 
because commit 0c0593b45c9b ("x86/ftrace: Make function graph use ftrace
directly") introduced this flag to switch the mode. (fgraph on ftrace)

> +
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> -	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
> +	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
>  	/* trampoline_size is only needed for dynamically allocated tramps */
>  #endif
> -	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
> -};
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	if (src_ops) {
> +		dst_ops->func_hash = &src_ops->local_hash;
> +		mutex_init(&dst_ops->local_hash.regex_lock);
> +		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
> +	}
> +#endif
> +}
>  
>  void ftrace_graph_sleep_time_control(bool enable)
>  {
> @@ -871,11 +869,20 @@ static int start_graph_tracing(void)
>  
>  int register_ftrace_graph(struct fgraph_ops *gops)
>  {
> +	int command = 0;
>  	int ret = 0;
>  	int i;
>  
>  	mutex_lock(&ftrace_lock);
>  
> +	if (!gops->ops.func) {
> +		gops->ops.flags |= FTRACE_OPS_FL_STUB;

Ditto.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
