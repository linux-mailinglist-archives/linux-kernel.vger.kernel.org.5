Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8C7E17E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjKEXdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEXdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:33:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378FBE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:33:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A28DC433C8;
        Sun,  5 Nov 2023 23:33:03 +0000 (UTC)
Date:   Sun, 5 Nov 2023 18:33:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
Message-ID: <20231105183301.38be5598@rorschach.local.home>
In-Reply-To: <20231105231734.GE3818@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 00:17:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Changelog nor code made it clear this was partial anything. So this is
> still the partial thing?
> 
> Can we then pretty clear clarify all that, and make it clear which regs
> are in there? Because when I do 'vim -t ftrace_regs' it just gets me a
> seemingly pointless wrapper struct, no elucidating comments nothingses.

I agree it should be better documented (like everything else). The
ftrace_regs must have all the registers needed to produce a function's
arguments. For x86_64, that would be:

  rdi, rsi, rdx, r8, r9, rsp

Basically anything that is needed to call mcount/fentry.

But yes, it's still partial registers but for archs that support
FTRACE_WITH_REGS, it can also hold all pt_regs which can be retrieved
by the arch_ftrace_get_regs(), which is why there's a pt_regs struct in
the x86 version. But that's not the case for arm64, as
arch_ftrace_get_regs() will always return NULL.

> 
> > You even Acked the patch:
> >
> > commit 02a474ca266a47ea8f4d5a11f4ffa120f83730ad
> > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Date:   Tue Oct 27 10:55:55 2020 -0400  
> 
> You expect me to remember things from 3 years ago?

Heh, of course not. I just thought it amusing that I created
ftrace_regs because of you and then 3 years later you ask to get rid of
it. But the real issue is that it's not documented clearly why it
exists, and that should be rectified.

Thanks,

-- Steve
