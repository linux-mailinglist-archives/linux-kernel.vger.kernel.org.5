Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432B27B2A25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 03:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI2BV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 21:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2BVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 21:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1800194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 18:21:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715BEC433C8;
        Fri, 29 Sep 2023 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695950482;
        bh=+xluoaRtd881mhnbMqR45ST1+JNC6xy+NKQlkNY/GIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j5adAD5V99j47hEbe9AhUblLVyJoZeun+NI4uuPi90VOUy3emX2UdMsWbjd2bAdtP
         XSdsBAztHTov7eupg3dtF2BwhCLIPEOZDprzff4z2xjtmFmjOOQc+27TFdnvGJiJTu
         bbskvrqvb8I4EHBZcQ08OnhLFYnOKOTCVZ1bGyZ5tAMfrWj5QTHagCXFyjc1g1F9cd
         F/IfPN+qQBrYgK5AT9OHfew3W41MZgfy4ULWlxa/dpFD37E3pxMT15wK8HX0RAxcRg
         NTfamK6HgCAoyj85OCgBUT/oriPRcrw20JZmx4K+jMVLj2EIub3CUORm+1lneMCD5M
         xDmik0x6eXCNA==
Date:   Fri, 29 Sep 2023 10:21:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs
 instead of pt_regs
Message-Id: <20230929102115.09c015b9af03e188f1fbb25c@kernel.org>
In-Reply-To: <169556254640.146934.5654329452696494756.stgit@devnote2>
References: <169556254640.146934.5654329452696494756.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While revising the LPC slides, I realized that this series is actually
slightly going in the wrong direction.

My goal is to unify "the shadow stack and the trampoline" for function exit
tracing (function graph tracer and function return probe event), but not
only unifying the internal interface.

My original plan was to introduce an independent "interface" for the shadow
stack and trampoline, which can switch the backend implementation. This was
important because when I started that, there were kretprobe or function-
graph tracer which hook the function exit.

If kprobe depends on the function-graph tracer only for using the same shadow
stack, that makes kprobe usability down. So I introduced "rethook" for the
interface, which could be a wrapper interface of the shadow stacks and the
trampolines. 
One my misread was the "pt_regs" issue. So this series is for fixing it.

However, when I introduced "fprobe" for function entry and exit probe, this
assumption has changed. If we move from kprobe/kretprobe to fprobe for
function entry/exit probing (= function entry/exit probe event on ftrace),
we don't need to care about the dependency of kprobes, because if "fprobe"
already depends on function tracer. Maybe it can depends on function-graph
tracer too.

Thus, what I need is to make fprobe to use function-graph tracer's shadow
stack and trampoline instead of rethook. This may need to generalize its
interface so that we can share it between fprobe and function-graph tracer,
but we don't need to involve rethook and kretprobes anymore.

Note that this plan still requires changing the fprobe interface to
use ftrace_regs, because some architecture doesn't support pt_regs on
ftrace.

Thus, I will keep the following patches from this series.
(first 3 patches are fixes so to be sent independently)

>  - RISCV ftrace fix to save registers on struct ftrace_regs correctly.
>  - Document fix for the current fprobe callback prototype.
>  - Add a comment of requirement for the ftrace_regs.
>  - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
      (this needs to be fixed)

>  - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
>  - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
>    implementation)
>  - Introduce ftrace_fill_perf_regs() for perf pt_regs.

>  - Update fprobe-events to use ftrace_regs natively.
>  - Update bpf multi-kprobe handler use ftrace_partial_regs().

And need to add patches

 - Introduce a generized function exit hook interface for ftrace.
 - Replace rethook in fprobe with the function exit hook interface.


Thank you,

On Sun, 24 Sep 2023 22:35:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 5th version of the series to use ftrace_regs instead of pt_regs
> in fprobe.
> The previous version is here;
> 
> https://lore.kernel.org/all/169280372795.282662.9784422934484459769.stgit@devnote2/
> 
> In this version, I decided to use perf's own per-cpu pt_regs array to
> copy the required registers[8/12]. Thus this version adds a patch which
> adds a new ftrace_fill_perf_regs() API. So the ftrace_partial_regs() will
> be used for BPF and ftrace_fill_perf_regs() is used for perf events.
> 
> This also adds a fix for RISCV ftrace[1/12]. When kernel is built with
> disabling CONFIG_DYNAMIC_FTRACE_WITH_REGS on RISCV, it stores partial
> registers on the stack, but it doesn't make it fit to struct ftrace_regs.
> But since the 4th argument of ftrace_func_t is ftrace_regs *, it breaks
> the ABI. So fixing it to save registers on ftrace_regs (== pt_regs on RISCV).
> 
> Another new patch [3/12] is adding a comment about the requirements for
> the ftrace_regs.
> 
>  - RISCV ftrace fix to save registers on struct ftrace_regs correctly.
>  - Document fix for the current fprobe callback prototype.
>  - Add a comment of requirement for the ftrace_regs.
>  - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
>  - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
>  - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
>    implementation)
>  - Introduce ftrace_fill_perf_regs() for perf pt_regs.
>  - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
>    introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_regs is
>    just a wrapper of pt_regs (except for arm64, other architectures do this)
>  - Update fprobe-events to use ftrace_regs natively.
>  - Update bpf multi-kprobe handler use ftrace_partial_regs().
>  - Update document for new fprobe callbacks.
>  - Add notes for the $argN and $retval.
> 
> This series can be applied against the trace-v6.6-rc2 on linux-trace tree.
> 
> This series can also be found below branch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (12):
>       riscv: ftrace: Fix to pass correct ftrace_regs to ftrace_func_t functions
>       Documentation: probes: Add a new ret_ip callback parameter
>       tracing: Add a comment about the requirements of the ftrace_regs
>       fprobe: Use ftrace_regs in fprobe entry handler
>       tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
>       fprobe: rethook: Use ftrace_regs in fprobe exit handler and rethook
>       tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
>       tracing: Add ftrace_fill_perf_regs() for perf event
>       tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
>       bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
>       Documentation: probes: Update fprobe document to use ftrace_regs
>       Documentation: tracing: Add a note about argument and retval access
> 
> 
>  Documentation/trace/fprobe.rst      |   18 +++--
>  Documentation/trace/fprobetrace.rst |    8 ++
>  Documentation/trace/kprobetrace.rst |    8 ++
>  arch/Kconfig                        |    1 
>  arch/arm64/include/asm/ftrace.h     |   18 +++++
>  arch/loongarch/Kconfig              |    1 
>  arch/loongarch/kernel/rethook.c     |   10 +--
>  arch/loongarch/kernel/rethook.h     |    4 +
>  arch/powerpc/include/asm/ftrace.h   |    7 ++
>  arch/riscv/kernel/mcount-dyn.S      |   67 ++++++++----------
>  arch/riscv/kernel/probes/rethook.c  |   12 ++-
>  arch/riscv/kernel/probes/rethook.h  |    6 +-
>  arch/s390/Kconfig                   |    1 
>  arch/s390/include/asm/ftrace.h      |    9 ++
>  arch/s390/kernel/rethook.c          |   10 ++-
>  arch/s390/kernel/rethook.h          |    2 -
>  arch/x86/Kconfig                    |    1 
>  arch/x86/include/asm/ftrace.h       |    7 ++
>  arch/x86/kernel/rethook.c           |   13 ++--
>  include/linux/fprobe.h              |    4 +
>  include/linux/ftrace.h              |  128 +++++++++++++++++++++++++++++------
>  include/linux/rethook.h             |   11 ++-
>  kernel/kprobes.c                    |   10 ++-
>  kernel/trace/Kconfig                |    9 ++
>  kernel/trace/bpf_trace.c            |   14 ++--
>  kernel/trace/fprobe.c               |   10 +--
>  kernel/trace/rethook.c              |   16 ++--
>  kernel/trace/trace_fprobe.c         |   70 +++++++++++--------
>  kernel/trace/trace_probe_tmpl.h     |    2 -
>  lib/test_fprobe.c                   |   10 +--
>  samples/fprobe/fprobe_example.c     |    4 +
>  31 files changed, 327 insertions(+), 164 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
