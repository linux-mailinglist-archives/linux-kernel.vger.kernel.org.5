Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA267B5752
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjJBPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjJBPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:39:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3CAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:39:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032E5C433C8;
        Mon,  2 Oct 2023 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261167;
        bh=lIapOgfdyVZYY4MQoc1rwfoDgxd/SzgEEbdHP2GxuT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mw2vG8+9aLErpB3lcMeUV0ZuVK8bCXnJPieMZLaXeYZt1ieRZmqPzuPRDjA2YiHhl
         WW6OPS/RkAm64WAYBD01xAWsAaBumM2s3ZzQXLz/wd46ysKYx6CYR6ZMKGJmYlnwu+
         LM0UIDJtUknjTu0B0aBGF61JNWp1OIHgxsgz8rxXskYILfr8INlRPeB7cuvpunmcUT
         ngzPCBGD5JW5AYq2lRiMGOB4OpJzYC2JLjcbmOiAbdsAObNmiHcI6raT+SEIT1XbFI
         DttuqXisWPFg1yPHYzj5a4Fxa0UC9jDsZM2Nsn52RD4D0jmVbjby6PIaRDwgPNvD8Y
         tcm7QK4Jaw7Zw==
Date:   Tue, 3 Oct 2023 00:39:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Guo Ren <guoren@kernel.org>,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20231003003923.eabc33bb3f4ffb8eac71f2af@kernel.org>
In-Reply-To: <20230930181435.6663ef5a6ad718548a1e414a@kernel.org>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
        <20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
        <CAADnVQ+HCLx+QUE88uVxeBNYFY4D=2-HADOU1C_czT1S1sRHgA@mail.gmail.com>
        <20230930181435.6663ef5a6ad718548a1e414a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2023 18:14:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 29 Sep 2023 17:12:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > On Thu, Sep 28, 2023 at 6:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > >
> > > Thus, what I need is to make fprobe to use function-graph tracer's shadow
> > > stack and trampoline instead of rethook. This may need to generalize its
> > > interface so that we can share it between fprobe and function-graph tracer,
> > > but we don't need to involve rethook and kretprobes anymore.
> > 
> > ...
> > 
> > > And need to add patches
> > >
> > >  - Introduce a generized function exit hook interface for ftrace.
> > >  - Replace rethook in fprobe with the function exit hook interface.
> > 
> > you mean that rethook will be removed after that?
> 
> No, it is too late. rethook is deeply integrated with kretprobe.
> So when we remove the kretprobe, rethook will be removed too.
> (fprobe and kretprobe provides similar functionality, so we can
> move to fprobe)
> 
> Even though, objpool(*) itself might be kept for some other use
> cases. As far as I can see, ftrace_ret_stack can not provide a context
> local storage between entry -> exit callbacks. (so this feature must
> be dropped from fprobe)
> 
> (*) https://lore.kernel.org/all/20230905015255.81545-1-wuqiang.matt@bytedance.com/

Oops, I rechecked the performance of objpool with prctl loop by
perf stat -a -I 10000 --interval-count 4 -e syscalls:sys_enter_prctl

And I found that with objpool, fprobe performance is the same
as function-graph!

	noprobe	kretprobe	fprobe	function-graph
T1	10706762	8506402	10475887	11249096
T2	28698960	20972543	22567923	22586848
T4	56634397	41500675	45042714	44932685
T8	114910972	85211522	91560078	90068034
T16	228519966	169212249	181582171	181181211
T32	448049923	330408645	361074536	356221873
T64	623779515	450932779	499909030	495516920

objpool consumes more memory than current freelist (because it is
just a list with counter) but that is limited. Usual use-case
(per-probe node size is 128, # of cpu: 8) one probe will allocate
22KB. (100 probes will need 2.2MB)
This is comparable to function graph ret-stack.

So now I'm reconsidering the strategy. I might better to keep
using rethook, but without ugly pt_regs casts. (e.g. use different
trampoline if rethook user requires ftrace_regs)

Sorry for confusing the direction.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
