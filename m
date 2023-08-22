Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19943783C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHVI7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHVI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742DCE;
        Tue, 22 Aug 2023 01:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4202C65004;
        Tue, 22 Aug 2023 08:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE22C433C7;
        Tue, 22 Aug 2023 08:59:38 +0000 (UTC)
Date:   Tue, 22 Aug 2023 04:59:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix to avoid wakeup loop in splice read of
 per-cpu buffer
Message-ID: <20230822045937.3fc0da54@rorschach.local.home>
In-Reply-To: <169262755804.106231.8245792908363050528.stgit@devnote2>
References: <169262755804.106231.8245792908363050528.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 23:19:18 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

>  	if (!spd.nr_pages) {
>  		long wait_index;
> +		size_t nr_pages;
> +		size_t full;

size_t is usually considered "long" (machine word length).

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

No need for do_div() as full is not 64 bit on 32 bit machines.

That's why the kernel test robot is complaining.

-- Steve

> +		} else
> +			full = iter->tr->buffer_percent;
> +
> +		ret = wait_on_pipe(iter, full);
