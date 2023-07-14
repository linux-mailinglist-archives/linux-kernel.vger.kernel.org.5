Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AC753571
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjGNIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjGNIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1A26BC;
        Fri, 14 Jul 2023 01:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDE461CAF;
        Fri, 14 Jul 2023 08:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F883C433C7;
        Fri, 14 Jul 2023 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689324480;
        bh=SuXBSUhf6SaAYBNbJx5KDu5zbWTFCohaWvvlrJaNPNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPSnjUUMNemRkawp16dG6Pf6q16Xt7vtm+dJXRxbmdioSVsJbCJgEHdX/ywGRcqEC
         KTFbCy4Lz3P58KATKpsAcaGIXSOpgO9mhvwkSX1wjKoqVmRqtNkNWcTL1tD8DYuBrd
         PLfOOc9HeqoLwfnwfIuX0bV0oV9dmC6hgjfFzNdaep2eMJAP1VYHGq7xJEjDHf3Sp0
         DuBEuDSD5k2NVqV6Ku1L1oTFxJvfLv9Zu3+4/0vU8BhLA9teqUwxJx8bnNkgitC1QW
         Tntjwfd/mXheb23yj/t8tpo/y0ApFKtejMQ+QXYRR/Sa8Jvqhf5P9H3L04IKUIGbr7
         wA5v+j/eJ1TBg==
Date:   Fri, 14 Jul 2023 17:47:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [PATCH 2/2] tracing: Add free_trace_iter_content() helper
 function
Message-Id: <20230714174757.4ab9157a2edb32d35224edfb@kernel.org>
In-Reply-To: <20230713114700.450e7a17@gandalf.local.home>
References: <20230713114510.04c452ca@gandalf.local.home>
        <20230713114700.450e7a17@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 11:47:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As the trace iterator is created and used by various interfaces, the clean
> up of it needs to be consistent. Create a free_trace_iter_content() helper
> function that frees the content of the iterator and use that to clean it
> up in all places that it is used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c370ffbe062..3f38250637e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4815,6 +4815,25 @@ static const struct seq_operations tracer_seq_ops = {
>  	.show		= s_show,
>  };
>  
> +/*
> + * Note, as iter itself can be allocated and freed in different
> + * ways, this function is only used to free its content, and not
> + * the iterator itself. The only requirement to all the allocations
> + * is that it must zero all fields (kzalloc), as freeing works with
> + * ethier allocated content or NULL.
> + */
> +static void free_trace_iter_content(struct trace_iterator *iter)
> +{
> +	/* The fmt is either NULL, allocated or points to static_fmt_buf */
> +	if (iter->fmt != static_fmt_buf)
> +		kfree(iter->fmt);
> +
> +	kfree(iter->temp);
> +	kfree(iter->buffer_iter);
> +	mutex_destroy(&iter->mutex);
> +	free_cpumask_var(iter->started);

This doesn't kfree(iter->trace) because iter->trace is just a reference
if I understand correctly.

> +}
> +
>  static struct trace_iterator *
>  __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  {
> @@ -4922,8 +4941,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  
>   fail:
>  	mutex_unlock(&trace_types_lock);
> -	kfree(iter->temp);
> -	kfree(iter->buffer_iter);
> +	free_trace_iter_content(iter);
>  release:
>  	seq_release_private(inode, file);
>  	return ERR_PTR(-ENOMEM);
> @@ -5002,11 +5020,7 @@ static int tracing_release(struct inode *inode, struct file *file)
>  
>  	mutex_unlock(&trace_types_lock);
>  
> -	mutex_destroy(&iter->mutex);
> -	free_cpumask_var(iter->started);
> -	kfree(iter->fmt);
> -	kfree(iter->temp);
> -	kfree(iter->buffer_iter);
> +	free_trace_iter_content(iter);
>  	seq_release_private(inode, file);
>  
>  	return 0;
> @@ -6709,7 +6723,12 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  	}
>  
>  	trace_seq_init(&iter->seq);
> -	iter->trace = tr->current_trace;
> +
> +	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
> +	if (!iter->trace)
> +		goto fail;
> +
> +	*iter->trace = *tr->current_trace;

Hmm, you allocate iter->trace here (again)

>  
>  	if (!alloc_cpumask_var(&iter->started, GFP_KERNEL)) {
>  		ret = -ENOMEM;
> @@ -6763,10 +6782,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	mutex_unlock(&trace_types_lock);
>  
> -	free_cpumask_var(iter->started);
> -	kfree(iter->fmt);
> -	kfree(iter->temp);
> -	mutex_destroy(&iter->mutex);

But there is no kfree(iter->trace).

Thank you,

> +	free_trace_iter_content(iter);
>  	kfree(iter);
>  
>  	trace_array_put(tr);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
