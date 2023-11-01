Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494BE7DE596
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbjKARqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbjKARqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A912E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:45:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2083DC433C8;
        Wed,  1 Nov 2023 17:45:58 +0000 (UTC)
Date:   Wed, 1 Nov 2023 13:45:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] ftrace_test_recursion_trylock behaviour
Message-ID: <20231101134556.5d4a46c3@gandalf.local.home>
In-Reply-To: <ZUKLnmYyHpthlMEE@krava>
References: <ZUKLnmYyHpthlMEE@krava>
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

On Wed, 1 Nov 2023 18:32:14 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> hi,
> I'm doing some testing on top of fprobes and noticed that the
> ftrace_test_recursion_trylock allows caller from the same context
> going through twice.
> 
> The change below adds extra fprobe on stack_trace_print, which is
> called within the sample_entry_handler and I can see it being executed
> with following trace output:
> 
>            <...>-457     [003] ...1.    32.352554: sample_entry_handler:
> Enter <kernel_clone+0x0/0x380> ip = 0xffffffff81177420 <...>-457
> [003] ...2.    32.352578: sample_entry_handler_extra: Enter
> <stack_trace_print+0x0/0x60> ip = 0xffffffff8127ae70
> 
> IOW nested ftrace_test_recursion_trylock call in the same context
> succeeded.
> 
> It seems the reason is the TRACE_CTX_TRANSITION bit logic.
> 
> Just making sure it's intentional.. we have kprobe_multi code on top of
> fprobe with another re-entry logic and that might behave differently based
> on ftrace_test_recursion_trylock logic.

Yes it's intentional, as it's a work around for an issue that may be
cleared up now with Peter Zijlstra's noinstr updates.

The use case for that TRACE_CTX_TRANSITION is when a function is traced
just after an interrupt was triggered but before the preempt count was
updated to let us know that we are in an interrupt context.

Daniel Bristot reported a regression after the trylock was first introduced
where the interrupt entry function was traced sometimes but not always.
That's because if the interrupt happened normally, it would be traced, but
if the interrupt happened when another event was being traced, the recursion
logic would see that the trace of the interrupt was happening in the same
context as the event it interrupted and drop the interrupt trace. But after
the preempt count was updated, the other functions in the interrupt would be
seen. This led to very confusing trace output.

The solution to that was this workaround hack, where the trace recursion
logic would allow a single recursion (the interrupt preempting another
trace before it set preempt count).

But with noinstr, there should be no more instances of this problem and we
can drop that extra bit. But the last I checked, there were a few places
that still could be traced without the preempt_count set. I'll have to
re-investigate.

-- Steve

