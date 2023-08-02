Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D928F76D86C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHBUM1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHBUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:12:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916E6E75;
        Wed,  2 Aug 2023 13:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2DF61AB8;
        Wed,  2 Aug 2023 20:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB70C433C7;
        Wed,  2 Aug 2023 20:12:21 +0000 (UTC)
Date:   Wed, 2 Aug 2023 16:12:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20230802161220.579b2220@gandalf.local.home>
In-Reply-To: <CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
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
        <20230801204054.3884688e@rorschach.local.home>
        <20230802225634.f520080cd9de759d687a2b0a@kernel.org>
        <CAADnVQLqXjJvCcuQLVz8HxF050jDHaSa2D7cehoYtjXdp3wGLQ@mail.gmail.com>
        <20230802143845.3ce6ed61@gandalf.local.home>
        <CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 12:48:14 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Aug 2, 2023 at 11:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 2 Aug 2023 11:24:12 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >  
> > > This is a non starter.
> > > bpf progs expect arch dependent 'struct pt_regs *' and we cannot change that.  
> >
> > If the progs are compiled into native code, isn't there optimizations that
> > could be done? That is, if ftrace_regs is available, and the bpf program is
> > just using the subset of pt_regs, is it possible that it could be compiled
> > to use ftrace_regs?
> >
> > Forgive my ignorance on how BPF programs turn into executables when running
> > in the kernel.  
> 
> Right. It's possible for the verifier to do an offset rewrite,
> forbid certain access, always return 0 on load from certain offset,
> and so on.
> It's all non trivial amount of work.
> ftrace_partial_regs() from ftrace_regs into pt_regs is so much simpler.

Sure, and the copy could be the solution we have in the near future, but if
we could optimize it in the future, then perhaps it would be worth doing it.

Also, how are the bpf programs referencing the pt_regs? Could a ftrace_regs
API be added too? If the verifier sees that the program is using
ftrace_regs, it could then use the lighter weight fprobes for access,
otherwise it falls back to the kprobe version.

-- Steve
