Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C07E1E21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjKFKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:20:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833493;
        Mon,  6 Nov 2023 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TNwnTF7pJUM5wUYf1C8g4YjArZwLod3mYB+unv05Tsc=; b=NGn9slIRFegsAwH8UGyOzYUMiY
        aRIUJUcWoNKfCGvzH/Am3HdI6k+uS84T/KtTE/JPwEMhR/S2qkTK91Yr9S/4P/vmbrjLXDLek/oIj
        x4EOjbYEnv1qt/LKWfhSuIT80HrEc00l4QAiGb165xYYZ+bCWB1GPJj2BMocAjL/JTIE/E+/AwqbU
        X9wQI8qqKoGx+9qvfBPZXKhGZQybfVEZk4iH1ZppUjzoBXO8KntsQGTnZNj9funTF+G72/++SC7fj
        eD2S+Bl5hAJVA/VrNvCwxwjFVlKOrHSgGrFSt6imr0kvTcc+0jedyoAHpcY/ux49iZbxcXLZKjla8
        Z6TP1WDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzwhf-005LVK-Uv; Mon, 06 Nov 2023 10:19:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A31A30049D; Mon,  6 Nov 2023 11:19:32 +0100 (CET)
Date:   Mon, 6 Nov 2023 11:19:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
 <20231105172536.GA7124@noisy.programming.kicks-ass.net>
 <20231105141130.6ef7d8bd@rorschach.local.home>
 <20231105231734.GE3818@noisy.programming.kicks-ass.net>
 <20231105183301.38be5598@rorschach.local.home>
 <20231105183409.424bc368@rorschach.local.home>
 <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> On Sun, 5 Nov 2023 18:34:09 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun, 5 Nov 2023 18:33:01 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > For x86_64, that would be:
> > > 
> > >   rdi, rsi, rdx, r8, r9, rsp
> > 
> > I missed rcx.
> 
> I would like to add rax to the list so that it can handle the return value too. :)

So something like so?


diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..71bfe27594a5 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
+	/*
+	 * Partial, filled with:
+	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp
+	 */
 	struct pt_regs		regs;
 };
