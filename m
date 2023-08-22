Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4986783700
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjHVAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHVAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A86F18E;
        Mon, 21 Aug 2023 17:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE4AA61A70;
        Tue, 22 Aug 2023 00:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1069BC433C8;
        Tue, 22 Aug 2023 00:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692663344;
        bh=n2Old7YYoUHJOORuHws8xgDm/6YhMrO0TuSlC5P3adw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pVXc7u2AyY0jrrtLJ+GvpxnTj67uMowoDpws6YlkMGiZV9+cXOHgcrfDb4HHavXhA
         VDmPE9SfjfT0x/w313l/q+4Mkvw9ROUpRyhyDeU87HB+m232bFP77OuYmrw2mSINHW
         ddTI3It4GoWi4iXldATHna8nh8+9FXse9bo396wINkBW6m6MnRcHJ4GNv/QVZ42AgG
         4kgHOctFLeOUu/F0FsL5m1pRkcsnRYsuznA0Grhyaz1Gndn3lANU7lJGOJytdX5XVg
         l6m/H6IvjGlBg1zgTyYYUInrz2CV3BAtTcntmM69+7oPYne6GPqrkxN74ZDzPYPgdf
         R31ypKVzyvLGw==
Date:   Tue, 22 Aug 2023 09:15:40 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-Id: <20230822091540.99e581b579aa790a90e335bc@kernel.org>
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

Ah I must have to take a sleep well. What I need is to ensure full >= 1.

static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int full)
{
...
        return (dirty * 100) > (full * nr_pages);
}

If dirty = 0, this always false.
But I think if full == 0, this should return true.

If dirty = 1,

- nr_pages < 100, this is always true and that is good.

- nr_pages > 100, even if full is 1 (smallest), it doesn't true. But that is OK
  because dirty page number will be increased later.

- nr_pages == 100 is the corner case. I think this should be

  return (dirty * 100) >= (full * nr_pages);

Let me update the patch.

Thank you,

> +
> +		ret = wait_on_pipe(iter, full);
>  		if (ret)
>  			goto out;
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
