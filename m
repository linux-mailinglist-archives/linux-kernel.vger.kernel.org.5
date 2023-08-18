Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B18780AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359645AbjHRLCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376534AbjHRLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E905230C5;
        Fri, 18 Aug 2023 04:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85DB864A3B;
        Fri, 18 Aug 2023 11:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B846C433C8;
        Fri, 18 Aug 2023 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356514;
        bh=7hSNv8eDnTjtYePwvMwfe0ilLiKcuhYv/oX8ohwRoT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V0/1fHV+ivD5ad5/S+EYa0zA4ukXawKVPlfQJVOK7i8X2MDyjC4Hm/FTqoFo5S5G0
         xIjHJcxyqHfD5Lj27zk7OOAiRdRFRfV94Qr5OX/r0fgUzBk3NtS9DBiQuIMMG7rIEs
         oEfQk5s+ejjlTb/Q8sWF1Q1ZKFvqGzqczi+sNecyxUlD+y5hgV0PNCRvi4POgqSAGG
         vOKUqATOchaBb/apLmQHmoSw0hDqG40qCPgWfC6SGOU7Au/hZpJyb9KGR6aLpL0Vue
         1vm/rCyhFdbsK6fRCFBdttFUn2QggLpa3chgtMKdgdFXekXbXU2KAXDoVwI86TIcWU
         Pn+JszsTy7R/Q==
Date:   Fri, 18 Aug 2023 20:01:48 +0900
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
Subject: Re: [PATCH v3 4/8] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230818200148.66fd9878ddd32f810c6ae860@kernel.org>
In-Reply-To: <CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
        <169181864347.505132.7098838654251139622.stgit@devnote2>
        <CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 10:57:40 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 976fd594b446..d56304276318 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >          This allows for use of ftrace_regs_get_argument() and
> >          ftrace_regs_get_stack_pointer().
> >
> > +config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> > +       bool
> > +       help
> > +        If this is set, the memory layout of the ftrace_regs data structure
> > +        is the same as the pt_regs. So the pt_regs is possible to be casted
> > +        to ftrace_regs.
> 
> What would you think of introducing a:
> 
> #ifdef HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs);
> #endif // HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> 
> somewhere in ftrace.h just as a small extra safety net ? It doesn't
> exactly guarantee all we want but it should give an early warning of
> mistakes.

That's a good idea :)
OK, I'll add it in the next version.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
