Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38567904A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 03:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbjIBB0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIBB0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 21:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BFA0;
        Fri,  1 Sep 2023 18:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32AF160C0D;
        Sat,  2 Sep 2023 01:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8572C433C8;
        Sat,  2 Sep 2023 01:25:56 +0000 (UTC)
Date:   Fri, 1 Sep 2023 21:26:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>, stable@vger.kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] tracing: Fix the unusable problem caused by non-empty
 pipe_cpumask
Message-ID: <20230901212607.1f8608de@gandalf.local.home>
In-Reply-To: <20230901230206.9bf0250291acd7bfbde46b53@kernel.org>
References: <20230901072626.278880-1-nashuiliang@gmail.com>
        <20230901230206.9bf0250291acd7bfbde46b53@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Fri, 1 Sep 2023 23:02:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri,  1 Sep 2023 15:26:26 +0800
> Chuang Wang <nashuiliang@gmail.com> wrote:
> 
> > There is a problem in the linux-6.5 when I execute the following
> > command:
> > 
> >  $ perf ftrace -t irqsoff
> >  failed to open trace_pipe
> > 
> > At the same time, when I open this file, the same error occurs.
> > 
> > Therefore, after carefully looking at the code, the open function of
> > 'trace_pipe' returns -EBUSY in open_pipe_on_cpu() because no clearing
> > operation was performed when 'trace_array->pipe_cpumask' was allocated.
> > 
> > With this patch, Use zalloc_cpumask_var() to ensure that
> > 'trace_array->pipe_cpumask' is reset to 0 when allocated.  


Brian Foster beat you to it.

  https://lore.kernel.org/linux-trace-kernel/20230831125500.986862-1-bfoster@redhat.com


> 
> Good catch. This looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Masami, I'll add your Reviewed-by to that commit.

Thanks!

-- Steve

> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
> > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > ---
> >  kernel/trace/trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index d8233d34b5a0..c0b8a72f3466 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -9461,7 +9461,7 @@ static struct trace_array *trace_array_create(const char *name)
> >  	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
> >  		goto out_free_tr;
> >  
> > -	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> > +	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> >  		goto out_free_tr;
> >  
> >  	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
> > @@ -10406,7 +10406,7 @@ __init static int tracer_alloc_buffers(void)
> >  	if (trace_create_savedcmd() < 0)
> >  		goto out_free_temp_buffer;
> >  
> > -	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
> > +	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
> >  		goto out_free_savedcmd;
> >  
> >  	/* TODO: make the number of buffers hot pluggable with CPUS */
> > -- 
> > 2.39.2
> >   
> 
> 

