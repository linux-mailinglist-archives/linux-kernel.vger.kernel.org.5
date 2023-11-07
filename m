Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BABA7E4194
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjKGOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:10:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539FC1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:09:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE13AC433C7;
        Tue,  7 Nov 2023 14:09:56 +0000 (UTC)
Date:   Tue, 7 Nov 2023 09:09:59 -0500
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
Message-ID: <20231107090959.1328bf62@gandalf.local.home>
In-Reply-To: <20231107084844.7a39ac3f@gandalf.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231106100549.33f6ce30d968906979ca3954@kernel.org>
        <20231106113710.3bf69211@gandalf.local.home>
        <20231107094258.d41a46c202197e92bc6d9656@kernel.org>
        <20231106220617.5eb73f2f@gandalf.local.home>
        <20231107144328.cc763a2a137391ceb105e9db@kernel.org>
        <20231107084844.7a39ac3f@gandalf.local.home>
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

On Tue, 7 Nov 2023 08:48:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 7 Nov 2023 14:43:28 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > 
> > > It's only needed if an architecture supports direct trampolines.    
> > 
> > I see, and x86_64 needs it.
> > OK, maybe better to keep it clear on x86-64 even on the
> > return handler.  
> 
> As it is arch specific, I'm not sure it matters for the return handler, as
> the return should never call a direct trampoline.

Just to clarify, the return trampoline should not bother touching that
register. The register was cleared in the fentry trampoline before calling
all the callbacks because the arch_ftrace_set_direct_caller() would set it.
Then on return of calling the function callbacks, it would test if
something set it or not.

If the return trampoline is not testing it after the return from the
callbacks, there's no reason to clear it. The fentry trampoline used it to
communicate to itself:

	orig_rax = 0;

	call ftrace_ops_list_func()

	/* Did something set orig_rax? */
	if (orig_rax != 0)
		return orig_rax;

It's not setting it to communicate with the callbacks. That is, the
callback does not expect it to be set.

-- Steve

