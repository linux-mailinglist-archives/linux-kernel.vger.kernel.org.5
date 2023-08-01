Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3276B8A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjHAPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjHAPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39512139;
        Tue,  1 Aug 2023 08:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D15C615E4;
        Tue,  1 Aug 2023 15:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F159BC433C7;
        Tue,  1 Aug 2023 15:32:41 +0000 (UTC)
Date:   Tue, 1 Aug 2023 11:32:40 -0400
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
Message-ID: <20230801113240.4e625020@gandalf.local.home>
In-Reply-To: <20230801112036.0d4ee60d@gandalf.local.home>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
        <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
        <20230802000228.158f1bd605e497351611739e@kernel.org>
        <20230801112036.0d4ee60d@gandalf.local.home>
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

On Tue, 1 Aug 2023 11:20:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The solution was to come up with ftrace_regs, which just means it has all
> the registers to extract the arguments of a function and nothing more. Most

This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. As
the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. They
will do:

	void callback(..., struct ftrace_regs *fregs) {
		struct pt_regs *regs = ftrace_get_regs(fregs);


Where ftrace_get_regs() will return the pt_regs only if it is fully filled.
If it is not, then it returns NULL. This was what the x86 maintainers
agreed with.

-- Steve


> implementations just have a partially filled pt_regs within it, but an API
> needs to be used to get to the argument values.

