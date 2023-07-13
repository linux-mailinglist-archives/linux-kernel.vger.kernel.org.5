Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF09752538
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGMOeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGMOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E02702;
        Thu, 13 Jul 2023 07:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84081612FB;
        Thu, 13 Jul 2023 14:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B13C433C7;
        Thu, 13 Jul 2023 14:33:55 +0000 (UTC)
Date:   Thu, 13 Jul 2023 10:33:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] traing: Fix memory leak of iter->temp when reading
 trace_pipe
Message-ID: <20230713103353.29cae218@gandalf.local.home>
In-Reply-To: <20230713141435.1133021-1-zhengyejian1@huawei.com>
References: <20230713141435.1133021-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 22:14:35 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> kmemleak reports:
>   unreferenced object 0xffff88814d14e200 (size 256):
>     comm "cat", pid 336, jiffies 4294871818 (age 779.490s)
>     hex dump (first 32 bytes):
>       04 00 01 03 00 00 00 00 08 00 00 00 00 00 00 00  ................
>       0c d8 c8 9b ff ff ff ff 04 5a ca 9b ff ff ff ff  .........Z......
>     backtrace:
>       [<ffffffff9bdff18f>] __kmalloc+0x4f/0x140
>       [<ffffffff9bc9238b>] trace_find_next_entry+0xbb/0x1d0
>       [<ffffffff9bc9caef>] trace_print_lat_context+0xaf/0x4e0
>       [<ffffffff9bc94490>] print_trace_line+0x3e0/0x950
>       [<ffffffff9bc95499>] tracing_read_pipe+0x2d9/0x5a0
>       [<ffffffff9bf03a43>] vfs_read+0x143/0x520
>       [<ffffffff9bf04c2d>] ksys_read+0xbd/0x160
>       [<ffffffff9d0f0edf>] do_syscall_64+0x3f/0x90
>       [<ffffffff9d2000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> when reading file 'trace_pipe', 'iter->temp' is allocated or relocated
> in trace_find_next_entry() but not freed before 'trace_pipe' is closed.
> 
> To fix it, free 'iter->temp' in tracing_release_pipe().
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Why is it that every time I send a pull request to Linus, I get another fix???

Anyway, Linus, hold off. I'll send a v3 with this included as well.

-- Steve

> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4529e264cb86..94cfaa884578 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6764,6 +6764,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	free_cpumask_var(iter->started);
>  	kfree(iter->fmt);
> +	kfree(iter->temp);
>  	mutex_destroy(&iter->mutex);
>  	kfree(iter);
>  

