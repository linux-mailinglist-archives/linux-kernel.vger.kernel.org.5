Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DEE7FA168
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjK0Nw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjK0Nwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545CF136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:53:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709CC433C8;
        Mon, 27 Nov 2023 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093180;
        bh=OVwwiJTTd2Vhegtvu9G08BBqbESo8kMbb5BInRIZLrU=;
        h=From:To:Cc:Subject:Date:From;
        b=IoMIIc363L97sThq31BHkdscisxQbYiN5XGi4PQS3uVNzebSC5UCaaSvU30x2pP8w
         9wNTG0C9vcYGu+VNL7zYVjKdGCRRFQLW+jCHkjFNqjXC4TRrhlG9EdpdGPfqQ1WmQR
         nkQNoM0z9yauRNMo+FgctvNsgHiVujGH1faCdaF20072cP7PVeytxmn/0X+3Zw5iVB
         o6zpHSmRIZItGLt/6yGfE5VX0vK/S3Ribv34Fgedy1tYRKglCZF43tPScvJ83aUUAZ
         qOTJxhPoPiPmOZL8V8oDSPNCIiYsi12JSgsyPQoTJhw/8M+sJ2OwdR9LOQLcaAq404
         Kdxpehpzx1jPQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
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
Subject: [PATCH v3 00/33] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date:   Mon, 27 Nov 2023 22:52:53 +0900
Message-Id: <170109317214.343914.4784420430328654397.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 3rd version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/169945345785.55307.5003201137843449313.stgit@devnote2/

In this version, I fixed the implementation issue in the multiple
function-graph tracer[12/33]. The previous version calls the handlers
of the function graph tracers multiple times if function tracer is
used for function entry callback. Instead, the function graph tracer
handler will be called once per each function-tracer callback. To
avoid "push" on the shadow ret-stack, the "push" operation checks
if the previous one can be reused and returns it.
Currently, x86-64 and arm64 support this new feature.
This also fixes reserve_data/retrieve_data functions[17/33] to allocate
data with correct size with corresponding index number. And fixes fprobe
patch to handle it correctly[28/33].

I added some arm64 supports[22/33][23/33], but this still seems to
cause some backtrace issue (maybe wrong fp saved?).

Overview
--------
This series does major 2 changes, enable multiple function-graphs on
the ftrace (e.g. allow function-graph on sub instances) and rewrite the
fprobe on this function-graph.

The former changes had been sent from Steven Rostedt 4 years ago (*),
which allows users to set different setting function-graph tracer (and
other tracers based on function-graph) in each trace-instances at the
same time.

(*) https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/

The purpose of latter change are;

 1) Remove dependency of the rethook from fprobe so that we can reduce
   the return hook code and shadow stack.

 2) Make 'ftrace_regs' the common trace interface for the function
   boundary.

1) Currently we have 2(or 3) different function return hook codes,
 the function-graph tracer and rethook (and legacy kretprobe).
 But since this  is redundant and needs double maintenance cost,
 I would like to unify those. From the user's viewpoint, function-
 graph tracer is very useful to grasp the execution path. For this
 purpose, it is hard to use the rethook in the function-graph
 tracer, but the opposite is possible. (Strictly speaking, kretprobe
 can not use it because it requires 'pt_regs' for historical reasons.)

2) Now the fprobe provides the 'pt_regs' for its handler, but that is
 wrong for the function entry and exit. Moreover, depending on the
 architecture, there is no way to accurately reproduce 'pt_regs'
 outside of interrupt or exception handlers. This means fprobe should
 not use 'pt_regs' because it does not use such exceptions.
 (Conversely, kprobe should use 'pt_regs' because it is an abstract
  interface of the software breakpoint exception.)

This series changes fprobe to use function-graph tracer for tracing
function entry and exit, instead of mixture of ftrace and rethook.
Unlike the rethook which is a per-task list of system-wide allocated
nodes, the function graph's ret_stack is a per-task shadow stack.
Thus it does not need to set 'nr_maxactive' (which is the number of
pre-allocated nodes).
Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
their register interface, this changes it to convert 'ftrace_regs' to
'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
so users must access only registers for function parameters or
return value. 

Design
------
Instead of using ftrace's function entry hook directly, the new fprobe
is built on top of the function-graph's entry and return callbacks
with 'ftrace_regs'.

Since the fprobe requires access to 'ftrace_regs', the architecture
must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, which enables to
call function-graph entry callback with 'ftrace_regs', and also
CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
return_to_handler.

All fprobes share a single function-graph ops (means shares a common
ftrace filter) similar to the kprobe-on-ftrace. This needs another
layer to find corresponding fprobe in the common function-graph
callbacks, but has much better scalability, since the number of
registered function-graph ops is limited.

In the entry callback, the fprobe runs its entry_handler and saves the
address of 'fprobe' on the function-graph's shadow stack as data. The
return callback decodes the data to get the 'fprobe' address, and runs
the exit_handler.

The fprobe introduces two hash-tables, one is for entry callback which
searches fprobes related to the given function address passed by entry
callback. The other is for a return callback which checks if the given
'fprobe' data structure pointer is still valid. Note that it is
possible to unregister fprobe before the return callback runs. Thus
the address validation must be done before using it in the return
callback.

Series
------
- Patch [1/33] and [2/33] are adding a comment for ftrace_regs.
- Patch [3/33] to [18/33] are the multiple function-graph support.
- Patch [19/33] and [20/33] adds new function-graph callbacks with
  ftrace_regs and x86-64 implementation.
- Patch [21/33] to [27/33] are preparation (adding util functions) of
  the new fprobe and its user.
- Patch [28/33] to [32/33] rewrites fprobes and updates its users.
- Patch [33/33] is a documentation update.

This series can be applied against the probes-fixes-v6.6-rc7 on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Christophe JAILLET (1):
      seq_buf: Export seq_buf_puts()

Masami Hiramatsu (Google) (17):
      tracing: Add a comment about ftrace_regs definition
      x86: tracing: Add ftrace_regs definition in the header
      function_graph: Add a new entry handler with parent_ip and ftrace_regs
      function_graph: Add a new exit handler with parent_ip and ftrace_regs
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
      arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      fprobe: Rewrite fprobe on function-graph tracer
      tracing/fprobe: Remove nr_maxactive from fprobe
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      selftests: ftrace: Remove obsolate maxactive syntax check
      Documentation: probes: Update fprobe on function-graph tracer

Steven Rostedt (VMware) (15):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables


 Documentation/trace/fprobe.rst                     |   42 +
 arch/arm64/Kconfig                                 |    2 
 arch/arm64/include/asm/ftrace.h                    |   24 
 arch/arm64/kernel/entry-ftrace.S                   |   28 +
 arch/arm64/kernel/ftrace.c                         |   19 
 arch/loongarch/Kconfig                             |    1 
 arch/loongarch/include/asm/ftrace.h                |    2 
 arch/loongarch/kernel/ftrace_dyn.c                 |    6 
 arch/powerpc/include/asm/ftrace.h                  |    9 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/s390/Kconfig                                  |    1 
 arch/s390/include/asm/ftrace.h                     |    7 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   17 
 arch/x86/kernel/ftrace.c                           |   51 +
 arch/x86/kernel/ftrace_64.S                        |   37 +
 include/linux/fprobe.h                             |   58 +
 include/linux/ftrace.h                             |  167 +++
 include/linux/sched.h                              |    2 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   19 
 kernel/trace/bpf_trace.c                           |   14 
 kernel/trace/fgraph.c                              |  981 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  637 +++++++++----
 kernel/trace/ftrace.c                              |   13 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   94 ++
 kernel/trace/trace_fprobe.c                        |  114 +-
 kernel/trace/trace_functions.c                     |    8 
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |   10 
 kernel/trace/trace_selftest.c                      |  178 ++++
 lib/seq_buf.c                                      |    1 
 lib/test_fprobe.c                                  |   51 -
 samples/fprobe/fprobe_example.c                    |    4 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 39 files changed, 2060 insertions(+), 706 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
