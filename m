Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD67B3FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjI3JOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjI3JOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE33BF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:14:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3BDC433C7;
        Sat, 30 Sep 2023 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696065282;
        bh=IDH9i4ossG8fiz9uTqL/nI6nmle6vBA4f7lhXd87Uxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rm9SNykJQwdTVW6S+Rf801ssab1h5iVg8gzKgmoRtFEW4Gs155ybnm+rBuwmhe/wo
         ItrleESvVOeL0vTQJuHBxCkj8xmEBUEOEZ0vkQ2MOmwnNrOpXHIXAni0aewiGrx6OZ
         xqz/ajf48Q8tqaV6nFOwuUovw9OxlzKfu3rhwjT0vI1sR3aUmvKBmC3Fa233NAFHi5
         p0epjZiJZ+tvH+uo3MTRZVjE9gbw5Rn+Cmu8I94npTDDhnx+OV8yiZg90Nt2a/iDHc
         5JgNvnNXsyV9LE1MDj3pA/VQcAbLuJhxdr047t8cmFyKwNaQ/IYSKQ0kH7ecurl1lW
         Io1hmHa9fALOg==
Date:   Sat, 30 Sep 2023 18:14:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20230930181435.6663ef5a6ad718548a1e414a@kernel.org>
In-Reply-To: <CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
        <20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
        <CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 17:12:07 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Sep 28, 2023 at 6:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >
> > Thus, what I need is to make fprobe to use function-graph tracer's shadow
> > stack and trampoline instead of rethook. This may need to generalize its
> > interface so that we can share it between fprobe and function-graph tracer,
> > but we don't need to involve rethook and kretprobes anymore.
> 
> ...
> 
> > And need to add patches
> >
> >  - Introduce a generized function exit hook interface for ftrace.
> >  - Replace rethook in fprobe with the function exit hook interface.
> 
> you mean that rethook will be removed after that?

No, it is too late. rethook is deeply integrated with kretprobe.
So when we remove the kretprobe, rethook will be removed too.
(fprobe and kretprobe provides similar functionality, so we can
move to fprobe)

Even though, objpool(*) itself might be kept for some other use
cases. As far as I can see, ftrace_ret_stack can not provide a context
local storage between entry -> exit callbacks. (so this feature must
be dropped from fprobe)

(*) https://lore.kernel.org/all/20230905015255.81545-1-wuqiang.matt@bytedance.com/

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
