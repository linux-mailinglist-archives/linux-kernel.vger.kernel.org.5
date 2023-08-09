Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F28776215
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjHIOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHIOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF21FD7;
        Wed,  9 Aug 2023 07:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB58663226;
        Wed,  9 Aug 2023 14:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF941C433C8;
        Wed,  9 Aug 2023 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590217;
        bh=2eEmHOtaW98wEIaTzp1lW7UBm7j4xm9z1dP/0aIC++8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R9HffduBuPOErEDethBZPLCgOiIDoL5ALMjPA5YwJbsIEtlphtvcF5EQ1XxOQz+T5
         bge7lkcC+E9rS8ioMfGLf1kgPPAAF/qrhkbin4oikq+BCiwUYAUbdFBoijg20wyKBG
         EpaP3M9ZFVIjouUYix6gT0jQWzoMGJK/hY6vl4CE91QmIzkD9selukv1VTxuwaPUvD
         ObOWf5lLnlBwExfhxAicq1Ufi+pPDzA3eme/iNZobG+vZJmLKGnRBWttFWaaJOIZQc
         r4zW1yZnWwvEOSXW14L73xPPx+9Abe5gLLExjGgTryXBg1bsXCjCh3YmGUM0bt1JlS
         a5GhL+hIz1AsA==
Date:   Wed, 9 Aug 2023 23:10:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-Id: <20230809231011.b125bd68887a5659db59905e@kernel.org>
In-Reply-To: <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139091575.324433.13168120610633669432.stgit@devnote2>
        <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florent,

On Wed, 9 Aug 2023 12:28:38 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > on arm64.
> 
> This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> but fprobe wouldn't run on these builds because fprobe still registers
> to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> whether they want REGS or not ?

Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
on it. But fprobe itself can work because fprobe just pass the ftrace_regs
to the handlers. (Note that exit callback may not work until next patch)

> 
> >  static int
> >  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> > -                         unsigned long ret_ip, struct pt_regs *regs,
> > +                         unsigned long ret_ip, struct ftrace_regs *fregs,
> >                           void *data)
> >  {
> >         struct bpf_kprobe_multi_link *link;
> > +       struct pt_regs *regs = ftrace_get_regs(fregs);
> > +
> > +       if (!regs)
> > +               return 0;
> 
> (with the above comment addressed) this means that BPF multi_kprobe
> would successfully attach on builds WITH_ARGS but the programs would
> never actually run because here regs would be 0. This is a confusing
> failure mode for the user. I think that if multi_kprobe won't work
> (because we don't have a pt_regs conversion path yet), the user should
> be notified at attachment time that they won't be getting any events.

Yes, so I changed it will not be compiled in that case.

@@ -2460,7 +2460,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#ifdef CONFIG_FPROBE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;

> That's why I think kprobe_multi should inform fprobe_init that it
> wants FTRACE_OPS_FL_SAVE_REGS and fail if that's not possible (no
> trampoline for it for example)

Yeah, that's another possibility, but in the previous thread we
discussed and agreed to introduce the ftrace_partial_regs() which
will copy the partial registers from ftrace_regs to pt_regs.


Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
