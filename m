Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C578FEB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349857AbjIAOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:02:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8710EC;
        Fri,  1 Sep 2023 07:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F03C7CE2399;
        Fri,  1 Sep 2023 14:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D2C433C9;
        Fri,  1 Sep 2023 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693576931;
        bh=xzO5OH5Qe2Y2j815wjyuTSS67nTGI2J0u9LP7ckN3VI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D/6GSgOgfF6CcOKgPU5RN5AWuG8ROJ0vKyJHcU2JIM3qiL6CYSAFAiRRK3ym59i3C
         BXBN6JpNHZcbELGVnd4qXScx8fnfzWZEdfDrRhTdjm/sjJg9ThzbwUWPb1AvFwPpOL
         TlN3INvMHrZX/8CmEpIOeMqrx0+I4EKAYU7fhDyaGvIYDfxVTZYfgN1IterV450nOZ
         1zuHdwdVuPzaU3Fm4iBVU43fgt8J81o4d0BVbXEwVm7eU6autgjskuwZquJKu18m0U
         23Wg2EjyaTqIqKXZbHkJiPHKFuPcJehoKloiB4QTrO7U9swoxgCbobxIi11WLwPTAa
         HNEuBoGV8vT7A==
Date:   Fri, 1 Sep 2023 23:02:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix the unusable problem caused by non-empty
 pipe_cpumask
Message-Id: <20230901230206.9bf0250291acd7bfbde46b53@kernel.org>
In-Reply-To: <20230901072626.278880-1-nashuiliang@gmail.com>
References: <20230901072626.278880-1-nashuiliang@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Sep 2023 15:26:26 +0800
Chuang Wang <nashuiliang@gmail.com> wrote:

> There is a problem in the linux-6.5 when I execute the following
> command:
> 
>  $ perf ftrace -t irqsoff
>  failed to open trace_pipe
> 
> At the same time, when I open this file, the same error occurs.
> 
> Therefore, after carefully looking at the code, the open function of
> 'trace_pipe' returns -EBUSY in open_pipe_on_cpu() because no clearing
> operation was performed when 'trace_array->pipe_cpumask' was allocated.
> 
> With this patch, Use zalloc_cpumask_var() to ensure that
> 'trace_array->pipe_cpumask' is reset to 0 when allocated.

Good catch. This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Cc: stable@vger.kernel.org
> Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d8233d34b5a0..c0b8a72f3466 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9461,7 +9461,7 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
>  		goto out_free_tr;
>  
> -	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
>  		goto out_free_tr;
>  
>  	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
> @@ -10406,7 +10406,7 @@ __init static int tracer_alloc_buffers(void)
>  	if (trace_create_savedcmd() < 0)
>  		goto out_free_temp_buffer;
>  
> -	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
>  		goto out_free_savedcmd;
>  
>  	/* TODO: make the number of buffers hot pluggable with CPUS */
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
