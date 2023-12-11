Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8349D80C9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbjLKMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLKMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBF21A8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64061C433C7;
        Mon, 11 Dec 2023 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702297898;
        bh=2YrHH+HuC91ba8HcfvIfejtI7HytiTGHhIwK+ff//AE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BCtBzmDCymkLD2leoITdd8OLzwp7C+lqgyb+dP2XCyEF7n+M0IhYKTAIbTLYeSC1X
         4m6EW/Il7Pd0/N5kPwnP3vLAmueP90GzVxL1Y2QF+m/O7v2M2aRpVWWq5WD+wOENzb
         8nYHB2SyWaonh1wsCYeepu1ECCcP7nXzme8fLFPU84oeoQ4Tiwbl3hVjCCJ8jOUiVy
         dC1PqKNHVQclRJyaIputlbl+Ou2QRlhnrQOhidGVdaY/pHNAqE6Kz0h+zUmMi90Xr7
         sSiN73BRSvdBYw1PEdcxm0O9U3UbD7PY9aC9jEqISaAx8WljylQjCS13o7IywV36ac
         C+q8gOhuaLaEQ==
Date:   Mon, 11 Dec 2023 21:31:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Update snapshot buffer on resize if it is
 allocated
Message-Id: <20231211213134.bd21cf745b8c5a0892891946@kernel.org>
In-Reply-To: <20231210225447.48476a6a@rorschach.local.home>
References: <20231210225447.48476a6a@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 22:54:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The snapshot buffer is to mimic the main buffer so that when a snapshot is
> needed, the snapshot and main buffer are swapped. When the snapshot buffer
> is allocated, it is set to the minimal size that the ring buffer may be at
> and still functional. When it is allocated it becomes the same size as the
> main ring buffer, and when the main ring buffer changes in size, it should
> do.

nit: There seems two "when the snapshot buffer is allocated" case, maybe latter
"it" means main buffer?

> 
> Currently, the resize only updates the snapshot buffer if it's used by the
> current tracer (ie. the preemptirqsoff tracer). But it needs to be updated
> anytime it is allocated.
> 
> When changing the size of the main buffer, instead of looking to see if
> the current tracer is utilizing the snapshot buffer, just check if it is
> allocated to know if it should be updated or not.
> 
> Also fix typo in comment just above the code change.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, the historical naming leads this kind of issues.
Maybe we'd better to rename 'max_buffer' to 'snapshot_buffer'?

Thanks,


> Cc: stable@vger.kernel.org
> Fixes: ad909e21bbe69 ("tracing: Add internal tracing_snapshot() functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index aa8f99f3e5de..6c79548f9574 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6348,7 +6348,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
>  	if (!tr->array_buffer.buffer)
>  		return 0;
>  
> -	/* Do not allow tracing while resizng ring buffer */
> +	/* Do not allow tracing while resizing ring buffer */
>  	tracing_stop_tr(tr);
>  
>  	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
> @@ -6356,7 +6356,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
>  		goto out_start;
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -	if (!tr->current_trace->use_max_tr)
> +	if (!tr->allocated_snapshot)
>  		goto out;
>  
>  	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
