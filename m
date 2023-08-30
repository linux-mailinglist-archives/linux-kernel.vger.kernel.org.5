Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E3A78DFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbjH3TKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242170AbjH3HUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B881BE;
        Wed, 30 Aug 2023 00:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E940B60A20;
        Wed, 30 Aug 2023 07:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFD3C433C9;
        Wed, 30 Aug 2023 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693380043;
        bh=QQ0quCTLpUTsywVNQHdI0D3Qosir/o/XOI1N8Eq4ZxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/2MQvmFCsFlRDKWqD8Aprgs2DuOLsQgvv4AhaAGNtDvzD/+9TQ1WYHhRsuy2kMP1
         3RkwvpgKtUNE5Wlg65kgx2DiXWg7XE9avA4ZAqrSu8uEVnYlDOhSUpP+dl/GjOK5so
         m0ID85W7RN3W75zl6198lp9TJj8HAp0gwGtBh7XmZaK7Q5wjIWSYMWBzPihqGLUida
         pHeP3p8Q+Q824kvECId4pVMOOrKDL8uiaHto+5iNZ6ApYBdkrf2p8R3Dysgo8iB08z
         oGqRnolNsTRc4huwBU55FEiz/sNVcWhyOHn2fy0A2jXayxtR5zJD7sISUXnTavV544
         ttOxmud+b06aQ==
Date:   Wed, 30 Aug 2023 16:20:39 +0900
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230830162039.95c575460609cebdc34ab0c1@kernel.org>
In-Reply-To: <169280379741.282662.12221517584561036597.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
        <169280379741.282662.12221517584561036597.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 00:16:37 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +	/* See include/linux/ftrace.h, this returns &fregs->regs */
> +	return ftrace_partial_regs(fregs, NULL);
> +}
> +
> +#define perf_fprobe_return_regs(regs) do {} while (0)
> +
> +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
> +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stack */
> +#define PERF_FPROBE_REGS_MAX	4
> +
> +struct pt_regs_stack {
> +	struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> +	int idx;
> +};
> +
> +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> +	struct pt_regs *regs;
> +
> +	if (stack->idx < PERF_FPROBE_REGS_MAX) {
> +		regs = stack->regs[stack->idx++];
> +		return ftrace_partial_regs(fregs, regs);
> +	}
> +	return NULL;
> +}
> +
> +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs)
> +{
> +	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> +
> +	if (WARN_ON_ONCE(regs != stack->regs[stack->idx]))
> +		return;
> +
> +	--stack->idx;
> +}

Ah, I found that the perf_trace_buf_alloc() does the same thing. So

perf_trace_buf_alloc(size, &pt_regs, &rctx);

will give us the pt_regs at that point. Trace event does that so I think
it is OK to do that here.

Thank you,

> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
>  static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> -			    struct pt_regs *regs)
> +			    struct ftrace_regs *fregs)
>  {
>  	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
>  	struct fentry_trace_entry_head *entry;
>  	struct hlist_head *head;
>  	int size, __size, dsize;
> +	struct pt_regs *regs;
>  	int rctx;
>  
> +	regs = perf_fprobe_partial_regs(fregs);
> +	if (!regs)
> +		return -EINVAL;
> +
>  	head = this_cpu_ptr(call->perf_events);
>  	if (hlist_empty(head))
> -		return 0;
> +		goto out;
>  
> -	dsize = __get_data_size(&tf->tp, regs);
> +	dsize = __get_data_size(&tf->tp, fregs);
>  	__size = sizeof(*entry) + tf->tp.size + dsize;
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);

Here, we can borrow the pt_regs.

>  	if (!entry)
> -		return 0;
> +		goto out;
>  
>  	entry->ip = entry_ip;
>  	memset(&entry[1], 0, dsize);
> -	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> +	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
>  	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
>  			      head, NULL);
> +out:
> +	perf_fprobe_return_regs(regs);
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(fentry_perf_func);
>  
>  static void
>  fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> -		unsigned long ret_ip, struct pt_regs *regs)
> +		unsigned long ret_ip, struct ftrace_regs *fregs)
>  {
>  	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
>  	struct fexit_trace_entry_head *entry;
>  	struct hlist_head *head;
>  	int size, __size, dsize;
> +	struct pt_regs *regs;
>  	int rctx;
>  
> +	regs = perf_fprobe_partial_regs(fregs);
> +	if (!regs)
> +		return;
> +
>  	head = this_cpu_ptr(call->perf_events);
>  	if (hlist_empty(head))
> -		return;
> +		goto out;
>  
> -	dsize = __get_data_size(&tf->tp, regs);
> +	dsize = __get_data_size(&tf->tp, fregs);
>  	__size = sizeof(*entry) + tf->tp.size + dsize;
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);

Ditto.

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
