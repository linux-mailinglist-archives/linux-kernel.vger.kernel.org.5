Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7CE768361
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjG3Bn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG3Bn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206719A6;
        Sat, 29 Jul 2023 18:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E93A602F9;
        Sun, 30 Jul 2023 01:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D560C433C7;
        Sun, 30 Jul 2023 01:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690681405;
        bh=Ag230mRf2+HwCCUnZ4geqgBWQuE+1+mw9qgMRZoQDac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAmSjQQDgMFDY9cSqSiiuVKSMF2Slo7SyqhSqJSmq/OLEhqc6sQ16hUVlhO901w6Q
         VaVR2xMP4TD7Qm2keYjL+8+CajOyUNijqvuX5LDN9K6Pq4TGx1cwXEAgI65ucIoxt4
         FqfeAnypH3+YXoCzP/MsvKfuPTGMgPp53PafwOfkaSmo0TFyTje7g+lk/+F+QGQGjE
         aIK1P4SGxVw+VjQafykesIg5uZ8oKf5wSO3xhdlOw3YdsHWM7XuuBD3LtUwWbMyhc7
         /1LTrieBKHjmgJzL93BGhGktHtNdEqTW/azsrjh4gWGWv6wDzzdYzYlUl3alrYYqdm
         mqMeMGQAbZ2ZA==
Date:   Sun, 30 Jul 2023 10:43:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] tracing: Add a debug_trace_printk() function
Message-Id: <20230730104321.f30784d6397b65636ac5f2cd@kernel.org>
In-Reply-To: <20230613095537.0ecf2459@gandalf.local.home>
References: <20230613095537.0ecf2459@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 09:55:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> While doing some tracing and kernel debugging, I found that some of my
> trace_printk()s were being lost in the noise of the other code that was
> being traced. Having a way to write trace_printk() not in the top level
> trace buffer would have been useful.
> 
> There was also a time I needed to debug ftrace itself, where
> trace_printk() did not hit the paths that were being debugged. But because
> the trace that was being debugged, was going into the top level ring
> buffer, it was causing issues for seeing what is to be traced.
> 
> To solve both of the above, add a debug_trace_printk() that can be used
> just like trace_printk() except that it goes into a "debug" instance
> buffer instead. This can be used at boot up as well.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Sorry, I missed this patch.
As far as it depends CONFIG_FTRACE_DEBUG_PRINT, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, what about adding generic trace_loglvl_printk(loglvl, fmt, ...)?

This is a macro that will be expanded to 'trace_loglvl_<N>_printk(fmt, ...)'
where N is 0-9. Then we can filter the trace_loglvl_N_printk event to a
specific instance.

Thank you,

> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230612193337.0fb0d3ca@gandalf.local.home/
> 
>   - I had added a prompt to the kconfig but never committed it.
>     It's now part of the patch.
> 
>  include/linux/kernel.h | 14 ++++++++++++++
>  kernel/trace/Kconfig   | 20 ++++++++++++++++++++
>  kernel/trace/trace.c   | 29 +++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0d91e0af0125..594c9ba17fd4 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -432,6 +432,20 @@ __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
>  extern __printf(2, 0) int
>  __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
>  
> +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> +extern __printf(2,0) void do_debug_trace_printk(unsigned long ip, const char *fmt, ...);
> +#define debug_trace_printk(fmt, ...) \
> +do {							\
> +	do_debug_trace_printk(_THIS_IP_, fmt, ##__VA_ARGS__);	\
> +} while (0)
> +
> +extern void debug_tracing_stop(void);
> +#else
> +#define debug_trace_printk(fmt, ...) do { } while (0)
> +static inline void debug_tracing_stop(void) { }
> +#endif
> +
> +
>  extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
>  #else
>  static inline void tracing_start(void) { }
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index abe5c583bd59..e07bca39dec9 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -974,6 +974,26 @@ config GCOV_PROFILE_FTRACE
>  	  Note that on a kernel compiled with this config, ftrace will
>  	  run significantly slower.
>  
> +config FTRACE_DEBUG_PRINT
> +	bool "Enable debug_trace_printk()"
> +	depends on TRACING
> +	help
> +	  This option enables the use of debug_trace_printk() instead of
> +	  using trace_printk(). The difference between the two is that
> +	  debug_trace_printk() traces are visible in the "debug" instance
> +	  found in:
> +
> +	  /sys/kernel/tracing/instances/debug
> +
> +	  This is useful when the trace printks should not interfere with
> +	  the normal top level tracing. It is also useful if the top level
> +	  tracing is very noisy and critical trace printks are dropped.
> +	  By using debug_trace_printk() the traces goes into as separate
> +	  ring buffer that will not be overridden by other trace events.
> +
> +	  If unsure say N (In fact, only say Y if you are debugging a
> +	                   kernel and require this)
> +
>  config FTRACE_SELFTEST
>  	bool
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 64a4dde073ef..c21a93cf5fd8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -490,6 +490,10 @@ static struct trace_array global_trace = {
>  	.trace_flags = TRACE_DEFAULT_FLAGS,
>  };
>  
> +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> +static struct trace_array *debug_trace;
> +#endif
> +
>  LIST_HEAD(ftrace_trace_arrays);
>  
>  int trace_array_get(struct trace_array *this_tr)
> @@ -10455,8 +10459,33 @@ void __init early_trace_init(void)
>  	tracer_alloc_buffers();
>  
>  	init_events();
> +
> +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> +	debug_trace = trace_array_get_by_name("debug");
> +	if (WARN_ON(!debug_trace))
> +		return;
> +	trace_array_init_printk(debug_trace);
> +#endif
>  }
>  
> +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> +__printf(2, 0)
> +void do_debug_trace_printk(unsigned long ip, const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	trace_array_vprintk(debug_trace, ip, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void debug_tracing_stop(void)
> +{
> +	debug_trace_printk("Stopping debug tracing\n");
> +	tracing_stop_tr(debug_trace);
> +}
> +#endif
> +
>  void __init trace_init(void)
>  {
>  	trace_event_init();
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
