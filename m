Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C0782D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjHUPQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHUPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:16:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B4EE;
        Mon, 21 Aug 2023 08:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7C87619A5;
        Mon, 21 Aug 2023 15:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3420CC433C7;
        Mon, 21 Aug 2023 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631003;
        bh=JKe9ztueuPiEiUDswLDf27Y+P0gk7mojOx2Je864hew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PIL+MW3ilXMy0PLP4sW2oUdQYwl9tKSR46weUmd+DaLgnaVy513PicA/5tN5MZckm
         TkczGLObUjIDLcWuuBKAIDfv7+zqnA0oiV/PgITDr75Fq7KfghYua2qv0o0lDbUJ9P
         6HRIo/RpyOURkiHxcJ8HvEsu6+BK25G/8ZEIOL81jFkQOKAb3mS5uXXkvdRep0NZ1c
         imEngEmCjWQBIBRE7tKhyoOuXxJoQMcFzIGaXWHyqh3PNHAJCUUSrweq/OCvF1EBhk
         vLWNmlyRs2+OiMlxKfCYGmXIM+oammUeOqp6ouzXAxHR2CMmeGHHkha8XWZ5MiT41P
         5/J6LeXCE/6qg==
Date:   Tue, 22 Aug 2023 00:16:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-Id: <20230822001639.7a3cbedc3ad6e3938ee76e16@kernel.org>
In-Reply-To: <169262755804.106231.8245792908363050528.stgit@devnote2>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 23:19:18 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> ftrace user can set 0 or small number to the 'buffer_percent' for quick
> response for the ring buffer. In that case wait_on_pipe() will return
> before filling a page of the ring buffer. That is too soon for splice()
> because ring_buffer_read_page() will fail again.
> This leads unnecessary loop in tracing_buffers_splice_read().
> 
> Set a minimum percentage of the buffer which is enough to fill a page to
> wait_on_pipe() to avoid this situation.
> 
> Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

So this is what I found when I played with virtio-trace.

I think now trace-cmd has richer feature, so it can be replaced with that,
maybe what we need is a selftest that ensures trace_pipe_raw supports
splice correctly.

BTW, even with this fix, blocking splice still causes a strange behavior.
If I set '400' to buffer_size_kb (so 100 pages) and '1' to buffer_percent,
splice always returns 8192 (2 pages) to read. But I expected that should
return 4096 (1 page). This means splice() waits longer than I thought.

I think the fullfilled percentage calculation will be a bit wrong.

Thank you,

> ---
>  kernel/trace/trace.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b8870078ef58..88448e8d8214 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8462,6 +8462,8 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  	/* did we read anything? */
>  	if (!spd.nr_pages) {
>  		long wait_index;
> +		size_t nr_pages;
> +		size_t full;
>  
>  		if (ret)
>  			goto out;
> @@ -8472,7 +8474,15 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  
>  		wait_index = READ_ONCE(iter->wait_index);
>  
> -		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
> +		/* For splice, we have to ensure at least 1 page is filled */
> +		nr_pages = ring_buffer_nr_pages(iter->array_buffer->buffer, iter->cpu_file);
> +		if (nr_pages * iter->tr->buffer_percent < 100) {
> +			full = nr_pages + 99;
> +			do_div(full, nr_pages);
> +		} else
> +			full = iter->tr->buffer_percent;
> +
> +		ret = wait_on_pipe(iter, full);
>  		if (ret)
>  			goto out;
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
