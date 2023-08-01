Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E276B882
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHAPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjHAPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED5F2107;
        Tue,  1 Aug 2023 08:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D27EF615DE;
        Tue,  1 Aug 2023 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E81C433C7;
        Tue,  1 Aug 2023 15:20:38 +0000 (UTC)
Date:   Tue, 1 Aug 2023 11:20:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801112036.0d4ee60d@gandalf.local.home>
In-Reply-To: <20230802000228.158f1bd605e497351611739e@kernel.org>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
        <20230802000228.158f1bd605e497351611739e@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Wed, 2 Aug 2023 00:02:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > If it diverges from that it's a big issue for bpf.
> > We'd have to remove all of fprobe usage.
> > I could be missing something, of course.  
> 
> Yes, so that's the discussion point. At first, I will disable fprobe on BPF
> if ftrace_regs is not compatible with pt_regs, but eventually it should be
> handled to support arm64. I believe BPF can do it since ftrace can do.

Note, for FYI let me give you a little history of where ftrace_regs came
from. When I realized that all function tracing had to save all the
registers that represent the arguments of a function as well as the stack
pointer, I wanted to change the non FTRACE_WITH_REGS to be able to have
access to those registers. This is where FTRACE_WITH_ARGS came from.

My first attempt was to pass a pt_regs that was partially filled, with only
the registers required for the arguments. But the x86 maintainers NACK'd
that. They refused to allow a partially filled pt_regs as that could cause
bugs in the future when a user may assume that the pt_regs is filled but is
not.

The solution was to come up with ftrace_regs, which just means it has all
the registers to extract the arguments of a function and nothing more. Most
implementations just have a partially filled pt_regs within it, but an API
needs to be used to get to the argument values.

When you say BPF uses pt_regs, is the pt_regs full or does it get passed a
partially filled structure?

For fast function entry, ftrace_regs is what should be used if the pt_regs
is not filled. As it is only for use for function entry. It supplies all
regs and stack pointer to get to all the arguments.

-- Steve
