Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC987637D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGZNmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGZNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55181738;
        Wed, 26 Jul 2023 06:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3438861A4F;
        Wed, 26 Jul 2023 13:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED80BC433C8;
        Wed, 26 Jul 2023 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690378937;
        bh=tYT9s1regzKdhNac5OTFo8gp2k+iHZup6mz8Z3GP1ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aGMnS/iL2wMeDD8OkWa0vaTAfGMD7uJCTeZanQ4THjrj7+4R+mU0LrJWx7UOrGdhb
         ltnD9SeKmN6ttEc5HEtj2DfZtNsjYe8f8/e9XetDTWYkAJaHZbhhbL6o9gwkgdGclX
         QOf0VkCHeVGBmOOoXx5eo4l0barrKzF8oilB6NvRhOS4RMOO8vpJ4Kq2utrv/1Sn5f
         HFxu/mYpRcuH5xafYuP+nB/ODn4GIJKiUfzOy01imc6Y2CAx+7egj2lycm1iT5y9ei
         dI1ZIAywcjbGPoHMm1u8brTnqsIyLLnQdfef5pXArQ+GyI9Xh585xZBeojFnR6gdun
         8brYPCSqIadPw==
Date:   Wed, 26 Jul 2023 22:42:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] tracing: Add free_trace_iter_content() helper
 function
Message-Id: <20230726224213.f5f3a23d207ffedeee291d22@kernel.org>
In-Reply-To: <20230715141348.341887497@goodmis.org>
References: <20230715141213.970003974@goodmis.org>
        <20230715141348.341887497@goodmis.org>
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

On Sat, 15 Jul 2023 10:12:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As the trace iterator is created and used by various interfaces, the clean
> up of it needs to be consistent. Create a free_trace_iter_content() helper
> function that frees the content of the iterator and use that to clean it
> up in all places that it is used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, this adds iter->fmt != static_fmt_buf check. Is it a kind of fix?

Thank you,

> ---
>  kernel/trace/trace.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c370ffbe062..8775930aa545 100644
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
> @@ -6763,10 +6777,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	mutex_unlock(&trace_types_lock);
>  
> -	free_cpumask_var(iter->started);
> -	kfree(iter->fmt);
> -	kfree(iter->temp);
> -	mutex_destroy(&iter->mutex);
> +	free_trace_iter_content(iter);
>  	kfree(iter);
>  
>  	trace_array_put(tr);
> -- 
> 2.40.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
