Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80577E997
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345801AbjHPTXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjHPTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC51FCE;
        Wed, 16 Aug 2023 12:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57EBD61E0C;
        Wed, 16 Aug 2023 19:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3976BC433C8;
        Wed, 16 Aug 2023 19:23:05 +0000 (UTC)
Date:   Wed, 16 Aug 2023 15:23:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230816152308.5f887721@gandalf.local.home>
In-Reply-To: <0b83d0e5-5fe6-0cfb-4695-23c2cb86526d@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
        <20230811204257.99df8ba60d591f5bace38615@kernel.org>
        <f7af687f-2376-fede-fa22-f776811c48f1@huawei.com>
        <20230811152413.76d5b72e@gandalf.local.home>
        <0b83d0e5-5fe6-0cfb-4695-23c2cb86526d@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 10:22:43 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

>
> >>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> >>>> index b8870078ef58..f169d33b948f 100644
> >>>> --- a/kernel/trace/trace.c
> >>>> +++ b/kernel/trace/trace.c
> >>>> @@ -7054,14 +7054,16 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
> >>>>    	if (ret <= 0)
> >>>>    		goto out_err;
> >>>>    
> >>>> -	if (!iter->ent && !trace_find_next_entry_inc(iter)) {
> >>>> +	trace_event_read_lock();
> >>>> +	trace_access_lock(iter->cpu_file);
> >>>> +
> >>>> +	if (!trace_find_next_entry_inc(iter)) {  
> >>>
> >>> It seems you skips '!iter->ent' check. Is there any reason for this change?  
> >>
> >> IIUC, 'iter->ent' may be the entry that was found but not consumed
> >> in last call tracing_splice_read_pipe(), and in this call, 'iter->ent'
> >> may have being consumed, so we may should find a new 'iter->ent' before
> >> printing it in tracing_fill_pipe_page(), see following reduced codes:  
> > 
> > And if it wasn't consumed? We just lost it?  
> 
> If 'iter->ent' was not consumed, trace_find_next_entry_inc() will find
> it again, will it?
> 
> -- Zheng Yejian
> 
> >   
> >>
> >>     tracing_splice_read_pipe() {
> >>       if (!iter->ent && !trace_find_next_entry_inc(iter)) {  // 1. find
> >> entry here
> >>           ... ...
> >>       }
> >>       tracing_fill_pipe_page() {
> >>         for (;;) {
> >>           ... ...
> >>           ret = print_trace_line(iter);  // 2. print entry
> >>           ... ...  
> > 
> > You missed:
> > 
> >             count = trace_seq_used(&iter->seq) - save_len;
> >             if (rem < count) {
> >                  rem = 0;
> >                  iter->seq.seq.len = save_len;
> > 
> > Where the above just threw away what was printed in the above
> > "print_trace_line()", and it never went to console.
> > 
> >                  break;
> >             }
> >   
> 
> Thanks for pointing this out!

Just to get this moving again, I believe we should add a ref count to
trace_pipe and the per_cpu trace_pipes, where if they are opened, nothing else can read it.

Opening trace_pipe locks all per_cpu ref counts, if any of them are open,
then the trace_pipe open will fail (and releases any ref counts it had
taken).

Opening a per_cpu trace_pipe will up the ref count for just that CPU
buffer. This will allow multiple tasks to read different per_cpu trace_pipe
files, but will prevent the main trace_pipe file from being opened.

Does that work for this?

-- Steve
