Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16BA76C18F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjHBAlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBAlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF677E46;
        Tue,  1 Aug 2023 17:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C826177B;
        Wed,  2 Aug 2023 00:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08023C433C7;
        Wed,  2 Aug 2023 00:40:57 +0000 (UTC)
Date:   Tue, 1 Aug 2023 20:40:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Florent Revest <revest@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801204054.3884688e@rorschach.local.home>
In-Reply-To: <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
        <20230802000228.158f1bd605e497351611739e@kernel.org>
        <20230801112036.0d4ee60d@gandalf.local.home>
        <20230801113240.4e625020@gandalf.local.home>
        <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
        <20230801190920.7a1abfd5@gandalf.local.home>
        <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 09:21:46 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Then use kprobes. When I asked Masami what the difference between fprobes
> > and kprobes was, he told me that it would be that it would no longer rely
> > on the slower FTRACE_WITH_REGS. But currently, it still does.  
> 
> kprobes needs to keep using pt_regs because software-breakpoint exception
> handler gets that. And fprobe is used for bpf multi-kprobe interface,
> but I think it can be optional.
> 
> So until user-land tool supports the ftrace_regs, you can just disable
> using fprobes if CONFIG_DYNAMIC_FTRACE_WITH_REGS=n

I'm confused. I asked about the difference between kprobes on ftrace
and fprobes, and you said it was to get rid of the requirement of
FTRACE_WITH_REGS.

 https://lore.kernel.org/all/20230120205535.98998636329ca4d5f8325bc3@kernel.org/

> 
> Then you can safely use 
> 
> struct pt_regs *regs = ftrace_get_regs(fregs);
> 
> I think we can just replace the CONFIG_FPROBE ifdefs with
> CONFIG_DYNAMIC_FTRACE_WITH_REGS in kernel/trace/bpf_trace.c
> And that will be the first version of using ftrace_regs in fprobe.

But it is still slow. The FTRACE_WITH_REGS gives us the full pt_regs
and saves all registers including flags, which is a very slow operation
(and noticeable in profilers).

And this still doesn't work on arm64.

Maybe we can add a ftrace_partial_regs(fregs) that returns a
partially filled pt_regs, and the caller that uses this obviously knows
its partial (as it's in the name). But this doesn't quite help out arm64
because unlike x86, struct ftrace_regs does not contain an address
compatibility with pt_regs fields. It would need to do a copy.

 ftrace_partial_regs(fregs, &regs) ?

-- Steve
