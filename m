Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE07797AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjHKTYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjHKTYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449730DB;
        Fri, 11 Aug 2023 12:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6409F67937;
        Fri, 11 Aug 2023 19:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA76C433C7;
        Fri, 11 Aug 2023 19:24:15 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:24:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230811152413.76d5b72e@gandalf.local.home>
In-Reply-To: <f7af687f-2376-fede-fa22-f776811c48f1@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
        <20230811204257.99df8ba60d591f5bace38615@kernel.org>
        <f7af687f-2376-fede-fa22-f776811c48f1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 20:37:07 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> On 2023/8/11 19:42, Masami Hiramatsu (Google) wrote:
> > On Thu, 10 Aug 2023 20:39:05 +0800
> > Zheng Yejian <zhengyejian1@huawei.com> wrote:
> >   
> >> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
> >> there are more data being read out than expected.
> >>
> >> The root cause is that in tracing_splice_read_pipe(), an entry is found
> >> outside locks, it may be read by multiple readers or consumed by other
> >> reader as starting printing it.
> >>
> >> To fix it, change to find entry after holding locks.
> >>
> >> Fixes: 7e53bd42d14c ("tracing: Consolidate protection of reader access to the ring buffer")
> >> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> >> ---
> >>   kernel/trace/trace.c | 10 ++++++----
> >>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> >> index b8870078ef58..f169d33b948f 100644
> >> --- a/kernel/trace/trace.c
> >> +++ b/kernel/trace/trace.c
> >> @@ -7054,14 +7054,16 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
> >>   	if (ret <= 0)
> >>   		goto out_err;
> >>   
> >> -	if (!iter->ent && !trace_find_next_entry_inc(iter)) {
> >> +	trace_event_read_lock();
> >> +	trace_access_lock(iter->cpu_file);
> >> +
> >> +	if (!trace_find_next_entry_inc(iter)) {  
> > 
> > It seems you skips '!iter->ent' check. Is there any reason for this change?  
> 
> IIUC, 'iter->ent' may be the entry that was found but not consumed
> in last call tracing_splice_read_pipe(), and in this call, 'iter->ent'
> may have being consumed, so we may should find a new 'iter->ent' before
> printing it in tracing_fill_pipe_page(), see following reduced codes:

And if it wasn't consumed? We just lost it?

> 
>    tracing_splice_read_pipe() {
>      if (!iter->ent && !trace_find_next_entry_inc(iter)) {  // 1. find 
> entry here
>          ... ...
>      }
>      tracing_fill_pipe_page() {
>        for (;;) {
>          ... ...
>          ret = print_trace_line(iter);  // 2. print entry
>          ... ...

You missed:

           count = trace_seq_used(&iter->seq) - save_len;
           if (rem < count) {
                rem = 0;
                iter->seq.seq.len = save_len;

Where the above just threw away what was printed in the above
"print_trace_line()", and it never went to console.

                break;
           }

-- Steve


>          if (!trace_find_next_entry_inc()) {  // 3. find next entry
>            ... ...
>            break;
>          }
>        }
> 
> --
> 
> Thanks,
> Zheng Yejian
> 
> > 
> > Thank you,
> >   
> >> +		trace_access_unlock(iter->cpu_file);
> >> +		trace_event_read_unlock();
> >>   		ret = -EFAULT;
> >>   		goto out_err;
> >>   	}
> >>   
> >> -	trace_event_read_lock();
> >> -	trace_access_lock(iter->cpu_file);
> >> -
> >>   	/* Fill as many pages as possible. */
> >>   	for (i = 0, rem = len; i < spd.nr_pages_max && rem; i++) {
> >>   		spd.pages[i] = alloc_page(GFP_KERNEL);
> >> -- 
> >> 2.25.1
> >>  
> > 
> >   

