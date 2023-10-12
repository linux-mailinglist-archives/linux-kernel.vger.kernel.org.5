Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248707C6937
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjJLJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjJLJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:14:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65B18F;
        Thu, 12 Oct 2023 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wp5Iab3YQO+kL2Pt3Wg09MfvraapsTSQohQxc/XyOAI=; b=eNWXa9sqk4ENg6S8BbBDcg1EY2
        ZW9K/9WSBmHYbd3xwxx6y5aULE2lPFtgrWR0psD8ShVyr94YICzSnABslC3mX2BSW3abqjKeeIzC3
        lMZ+HlgBgCoOg5KkHuvxMIce0vM+Q1Zi+m1dXYAABXJZAgSPHMJhPV9i7N/AlPuao1M3u8Utw+jt7
        P4QTObyKIjP4oXjm+isnYZvLn07TDuCe13TO+1KzOGglIPFHYi0E1/9lQzc5UBsQeB7jk4XPYpSKn
        WTd4TKfzAKfXC8rzxxmWILMQpgeD2Sgi/KdcZjuc8Mx6he6T+peLMyuJSnUhTyoO57XLPk6rWnAEJ
        wDbgaV9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqrj6-001hHm-02;
        Thu, 12 Oct 2023 09:13:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D60F30036C; Thu, 12 Oct 2023 11:11:29 +0200 (CEST)
Date:   Thu, 12 Oct 2023 11:11:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
Message-ID: <20231012091128.GL6307@noisy.programming.kicks-ass.net>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


W00t!! Finally! :-)

On Wed, Oct 11, 2023 at 08:50:23PM -0700, Namhyung Kim wrote:

> * How to use it
> 
> To get precise memory access samples, users can use `perf mem record`
> command to utilize those events supported by their architecture.  Intel
> machines would work best as they have dedicated memory access events but
> they would have a filter to ignore low latency loads like less than 30
> cycles (use --ldlat option to change the default value).
> 
>     # To get memory access samples in kernel for 1 second (on Intel)
>     $ sudo perf mem record -a -K --ldlat=4 -- sleep 1

Fundamentally this should work with anything PEBS from MEM_ as
well, no? No real reason to rely on perf mem for this.

> In perf report, it's just a matter of selecting new sort keys: 'type'
> and 'typeoff'.  The 'type' shows name of the data type as a whole while
> 'typeoff' shows name of the field in the data type.  I found it useful
> to use it with --hierarchy option to group relevant entries in the same
> level.
> 
>     $ sudo perf report -s type,typeoff --hierarchy --stdio
>     ...
>     #
>     #    Overhead  Data Type / Data Type Offset
>     # ...........  ............................
>     #
>         23.95%     (stack operation)
>            23.95%     (stack operation) +0 (no field)
>         23.43%     (unknown)
>            23.43%     (unknown) +0 (no field)
>         10.30%     struct pcpu_hot
>             4.80%     struct pcpu_hot +0 (current_task)
>             3.53%     struct pcpu_hot +8 (preempt_count)
>             1.88%     struct pcpu_hot +12 (cpu_number)
>             0.07%     struct pcpu_hot +24 (top_of_stack)
>             0.01%     struct pcpu_hot +40 (softirq_pending)
>          4.25%     struct task_struct
>             1.48%     struct task_struct +2036 (rcu_read_lock_nesting)
>             0.53%     struct task_struct +2040 (rcu_read_unlock_special.b.blocked)
>             0.49%     struct task_struct +2936 (cred)
>             0.35%     struct task_struct +3144 (audit_context)
>             0.19%     struct task_struct +46 (flags)
>             0.17%     struct task_struct +972 (policy)
>             0.15%     struct task_struct +32 (stack)
>             0.15%     struct task_struct +8 (thread_info.syscall_work)
>             0.10%     struct task_struct +976 (nr_cpus_allowed)
>             0.09%     struct task_struct +2272 (mm)
>         ...
> 
> The (stack operation) and (unknown) have no type and field info.  FYI,
> the stack operations are samples in PUSH, POP or RET instructions which
> save or restore registers from/to the stack.  They are usually parts of
> function prologue and epilogue and have no type info.  The next is the
> struct pcpu_hot and you can see the first field (current_task) at offset
> 0 was accessed mostly.  It's listed in order of access frequency (not in
> offset) as you can see it in the task_struct.
> 
> In perf annotate, new --data-type option was added to enable data
> field level annotation.  Now it only shows number of samples for each
> field but we can improve it.
> 
>     $ sudo perf annotate --data-type
>     Annotate type: 'struct pcpu_hot' in [kernel.kallsyms] (223 samples):
>     ============================================================================
>         samples     offset       size  field
>             223          0         64  struct pcpu_hot       {
>             223          0         64      union     {
>             223          0         48          struct        {
>              78          0          8              struct task_struct*      current_task;
>              98          8          4              int      preempt_count;
>              45         12          4              int      cpu_number;
>               0         16          8              u64      call_depth;
>               1         24          8              long unsigned int        top_of_stack;
>               0         32          8              void*    hardirq_stack_ptr;
>               1         40          2              u16      softirq_pending;
>               0         42          1              bool     hardirq_stack_inuse;
>                                                };
>             223          0         64          u8*  pad;
>                                            };
>                                        };
>     ...
> 
> This shows each struct one by one and field-level access info in C-like
> style.  The number of samples for the outer struct is a sum of number of
> samples in every field in the struct.  In unions, each field is placed
> in the same offset so they will have the same number of samples.

This is excellent -- and pretty much what I've been asking for forever.

Would it be possible to have multiple sample columns, for eg.
MEM_LOADS_UOPS_RETIRED.L1_HIT and MEM_LOADS_UOPS_RETIRED.L1_MISS
or even more (adding LLC hit and miss as well etc.) ?

(for bonus points: --data-type=typename, would be awesome)

Additionally, annotating the regular perf-annotate output with data-type
information (where we have it) might also be very useful. That way, even
when profiling with PEBS-cycles, an expensive memop immediately gives a
clue as to what data-type to look at.

> No TUI support yet.

Yeah, nobody needs that anyway :-)

> This can generate instructions like below.
> 
>     ...
>     0x123456:  mov    0x18(%rdi), %rcx
>     0x12345a:  mov    0x10(%rcx), %rax     <=== sample
>     0x12345e:  test   %rax, %rax
>     0x123461:  je     <...>
>     ...
> 
> And imagine we have a sample at 0x12345a.  Then it cannot find a
> variable for %rcx since DWARF didn't generate one (it only knows about
> 'bar').  Without compiler support, all it can do is to track the code
> execution in each instruction and propagate the type info in each
> register and stack location by following the memory access.

Right, this has more or less been the 'excuse' for why doing this has
been 'difficult' for the past 10+ years :/

> Actually I found a discussion in the DWARF mailing list to support
> "inverted location lists" and it seems a perfect fit for this project.
> It'd be great if new DWARF would provide a way to lookup variable and
> type info using a concrete location info (like a register number).
> 
>   https://lists.dwarfstd.org/pipermail/dwarf-discuss/2023-June/002278.html 

Stephane was going to talk to tools people about this over 10 years ago
:-)

Thanks for *finally* getting this started!!
