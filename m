Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A207E1DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjKFKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:04:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF45100
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:04:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CF4C433C7;
        Mon,  6 Nov 2023 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699265062;
        bh=N+J4uYmXVpTzfaXKjD6eS71G3lnyCcY7HtDKx1e+Uts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bov0Hu9H0C1RcT+NiXHNn+Pibn5nMp6Y45MKQJCmsmiNT0AlDwPjmasythPTi8B4p
         JKsmpx+T/Cnf3/7nhpaiGRiZh3cC6Wjrf7UEAJEwoz/aYcweViMP2ZXLc3JOBHaR+Z
         IUqacxRFDE4Mn2VB0DNucAnLf0wGpEmc5znw/gUCGwSXTYtE4Nq9OipLq2MRN/n9BD
         OoLoG4QEWt7A19uM6bmpDcbRQAp4KOS7x+7KQuxOtV1zbro++cjVaqyHOCqZ4K/AHN
         OUIDxeaxwf0T84aI2O36puv5Ko76ATVLCs9GyjydvIpTWY117PxdUSGDonRkZe48Kc
         4ZNZqDd4eihzQ==
Date:   Mon, 6 Nov 2023 19:04:16 +0900
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
Subject: Re: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops
 for fgraph with ftrace_graph_func
Message-Id: <20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
In-Reply-To: <169920060974.482486.15664806338999944098.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920060974.482486.15664806338999944098.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 01:10:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to initialize the ftrace_ops of fgraph_ops with ftrace_graph_func
> instead of ftrace_stub.

I've changed this, because fprobe entry handler is not called via
fgraph without this. But maybe I have to set correct gops->ops.func
after init?

Thank you,

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fgraph.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 597250bd30dc..858fb73440ec 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -872,7 +872,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  void fgraph_init_ops(struct ftrace_ops *dst_ops,
>  		     struct ftrace_ops *src_ops)
>  {
> -	dst_ops->func = ftrace_stub;
> +	dst_ops->func = ftrace_graph_func;
>  	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;
>  
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> @@ -1120,7 +1120,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  
>  	if (!gops->ops.func) {
>  		gops->ops.flags |= FTRACE_OPS_FL_STUB;
> -		gops->ops.func = ftrace_stub;
> +		gops->ops.func = ftrace_graph_func;
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
>  		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
>  #endif
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
