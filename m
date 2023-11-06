Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E37E7E29EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKFQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:37:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772BD47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:37:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DFDC433C8;
        Mon,  6 Nov 2023 16:37:08 +0000 (UTC)
Date:   Mon, 6 Nov 2023 11:37:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231106113710.3bf69211@gandalf.local.home>
In-Reply-To: <20231106100549.33f6ce30d968906979ca3954@kernel.org>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231106100549.33f6ce30d968906979ca3954@kernel.org>
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

On Mon, 6 Nov 2023 10:05:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> So for x86-64,
> 
>  - rdi, rsi, rcx, rdx, r8, r9, and rsp
>  - rax and rdx
>  - rbp
> 
> (BTW, why orig_rax is cleared?)

You mean from ftrace_caller?

That's a "hack" to determine if we need to call the direct trampoline or
not. When you have both a direct trampoline and ftrace functions on the
same function, it will call ftrace_ops_list_func() to iterate all the
registered ftrace callbacks. The direct callback helper will set "orig_rax"
to let the return of the ftrace trampoline call the direct callback.

Remember if a direct callback is by itself, the fentry will call that
direct trampoline without going through the ftrace trampoline. This is used
to tell the ftrace trampoline that it's attached to a direct caller and
needs to call that and not return back to the function it is tracing.

See later down in that file we have:

	/*
	 * If ORIG_RAX is anything but zero, make this a call to that.
	 * See arch_ftrace_set_direct_caller().
	 */
	testq	%rax, %rax

-- Steve
