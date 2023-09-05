Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD73792C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354012AbjIERG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356595AbjIEQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5E1FED;
        Tue,  5 Sep 2023 09:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C88560B95;
        Tue,  5 Sep 2023 16:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A140C433C8;
        Tue,  5 Sep 2023 16:30:40 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:30:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-ID: <20230905123058.706b12de@gandalf.local.home>
In-Reply-To: <20230905223633.23cd4e6e8407c45b934be477@kernel.org>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
        <169280377434.282662.7610009313268953247.stgit@devnote2>
        <20230904224038.4420a76ea15931aa40179697@kernel.org>
        <yt9d5y4pozrl.fsf@linux.ibm.com>
        <20230905223633.23cd4e6e8407c45b934be477@kernel.org>
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

On Tue, 5 Sep 2023 22:36:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yes, arch_rethook_trampoline() is good. It needs to save all registers.
> 
> In this series, I'm trying to change the pt_regs with ftrace_regs which will
> reduce trampoline overhead if DYNAMIC_FTRACE_WITH_ARGS=y.
> 
> kprobe -> (pt_regs) -> rethook_try_hook()
> fprobe -> (ftrace_regs) -> rethook_try_hook_ftrace() # new function
> 
> Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
> *without* FTRACE_WITH_REGS flags, can be used for hooking the function
> return. I saw;
> 
> void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
> {
>         rh->ret_addr = regs->gprs[14];
>         rh->frame = regs->gprs[15];
> 
>         /* Replace the return addr with trampoline addr */
>         regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
> }
> 
> gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
> gprs[14]? (I guess it is a link register)
> We need to read the gprs[14] and ensure that is restored to gpr14 when the
> ftrace is exit even without FTRACE_WITH_REGS flag.
> 
> IOW, it is ftrace save regs/restore regs code issue. I need to check how the
> function_graph implements it.

I would argue that the link register should also be saved in ftrace_regs.

The thing that ftrace_regs is not suppose to save is the general purpose
registers.

-- Steve
