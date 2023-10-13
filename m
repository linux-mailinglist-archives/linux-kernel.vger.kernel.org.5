Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1213E7C87A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjJMOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJMOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:16:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F795;
        Fri, 13 Oct 2023 07:15:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A45C433C8;
        Fri, 13 Oct 2023 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206557;
        bh=vaBQANTmaEowKS5n5Xz4PYWxLnM7bQeyeVcAcBH8dVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7P5cz3QOEMz/PT3aPX7rzYzD6tfCe0VDZGQsgQqYJYYu0o8iTG0VRNoxdpM7WmBm
         ISfsVLjVvYJBnxDli/vsgekRaeHw8ryYlikdwF74jRDUsiB3hDK5o2yHeVkEjYuiUN
         BXjxH4Lx82//2pRe1xLaRadeq1RJVg4HXp0+y5SShPFcNPVyi1n080WsUBHtLurrqe
         tmRVcdFly3U7VRyyqNVgWq/FfxrtbmytWmz+J7w+tKL5sJKM0M4O8iv4MxgN1Sc38l
         FM1KYEp9t6r13sag1YbPOP0VIW06iEeRZFRIs9P9R7vM2utl9yTVhjp25Qf3mJVYBf
         n//t6/sgq6s9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45B7D40016; Fri, 13 Oct 2023 11:15:54 -0300 (-03)
Date:   Fri, 13 Oct 2023 11:15:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
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
Message-ID: <ZSlRGnFjEO9fuH3i@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 11, 2023 at 08:50:23PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> I'm happy to share my work on data type profiling.  This is to associate
> PMU samples to data types they refer using DWARF debug information.  So
> basically it depends on quality of PMU events and compiler for producing
> DWARF info.  But it doesn't require any changes in the target program.

Great news, finally work on this started :-)

And using what is already available, so that we get to see what are the
road blocks to cover more cases, great.

I'll test it all and report back,

Thanks for doing this work!

- Arnaldo
 
> As it's an early stage, I've targeted the kernel on x86 to reduce the
> amount of work but IIUC there's no fundamental blocker to apply it to
> other architectures and applications.
> 
> 
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
> 
>     # Similar for the AMD (but it requires 6.3+ kernel for BPF filters)
>     $ sudo perf mem record -a --filter 'mem_op == load, ip > 0x8000000000000000' -- sleep 1
> 
> Note that it used 'sudo' command because it's collecting the event in
> system wide mode.  Actually it would depend on the sysctl setting of
> kernel.perf_event_paranoid.  AMD still needs root due to the BPF filter
> though.
> 
> After getting a profile data, you would run perf report or perf
> annotate as usual to see the result.  Make sure that you have a kernel
> debug package installed or vmlinux with DWARF info.
 
> I've added new options and sort keys to enable the data type profiling.
> Probably I need to add it to perf mem or perf c2c command for better
> user experience.  I'm open to discussion how we can make it simpler and
> intuitive for regular users.  But let's talk about the lower level
> interface for now.
> 
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
> 
> No TUI support yet.
> 
> 
> * How it works
> 
> The basic idea is to use DWARF location expression in debug entries for
> variables.  Say we got a sample in the instruction below:
> 
>     0x123456:  mov    0x18(%rdi), %rcx
> 
> Then we know the instruction at 0x123456 is accessing to a memory region
> where %rdi register has a base address and offset 0x18 from the base.
> DWARF would have a debug info entry for a function or a block which
> covers that address.  For example, we might have something like this:
> 
>     <1><100>: Abbrev Number: 10 (DW_TAG_subroutine_type)
>        <101>    DW_AT_name       : (indirect string, offset: 0x184e6): foo
>        <105>    DW_AT_type       : <0x29ad7>
>        <106>    DW_AT_low_pc     : 0x123400
>        <10e>    DW_AT_high_pc    : 0x1234ff
>     <2><116>: Abbrev Number: 8 (DW_TAG_formal_parameter)
>        <117>    DW_AT_name       : (indirect string, offset: 0x18527): bar
>        <11b>    DW_AT_type       : <0x29b3a>
>        <11c>    DW_AT_location   : 1 byte block: 55    (DW_OP_reg2 (rdi))
> 
> So the function 'foo' covers the instruction from 0x123400 to 0x1234ff
> and we know the sample instruction belongs to the function.  And it has
> a parameter called 'bar' and it's located at the %rdi register.  Then we
> know the instruction is using the variable bar and its type would be a
> pointer (to a struct).  We can follow the type info of bar and verify
> its access by checking the size of the (struct) type and offset in the
> instruction (0x18).
> 
> Well.. this is a simple example that the 'bar' has a single location.
> Other variables might be located in various places over time but it
> should be covered by the location list of the debug entry.  Therefore,
> as long as DWARF produces a correct location expression for a variable,
> it should be able to find the variable using the location info.
> 
> Global variables and local variables are different as they can be
> accessed directly without a pointer.  They are located in an absolute
> address or relative position from the current stack frame.  So it needs
> to handle such location expressions as well.
> 
> However, some memory accesses don't have a variable in some cases.  For
> example, you have a pointer variable for a struct which contains another
> pointers.  And then you can directly dereference it without using a
> variable.  Consider the following source code.
> 
>     int foo(struct baz *bar) {
>         ...
>         if (bar->p->q == 0)
>             return 1;
>         ...
>     }
> 
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
> 
> Actually I found a discussion in the DWARF mailing list to support
> "inverted location lists" and it seems a perfect fit for this project.
> It'd be great if new DWARF would provide a way to lookup variable and
> type info using a concrete location info (like a register number).
> 
>   https://lists.dwarfstd.org/pipermail/dwarf-discuss/2023-June/002278.html 
> 
> 
> * Patch structure
> 
> The patch 1-5 are cleanups and a fix that can be applied separately.
> The patch 6-21 are the main changes in perf report and perf annotate to
> support simple cases with a pointer variable.  The patch 22-33 are to
> improve it by handling global and local variables (without a pointer)
> and some edge cases.  The patch 34-43 implemented instruction tracking
> to infer data type when there's no variable for that.  The patch 44-47
> handles kernel-specific per-cpu variables (only for current CPU).  The
> patch 48 is to help debugging and is not intended for merge.
> 
> 
> * Limitations and future work
> 
> As I said earlier, this work is in a very early shape and has many
> limitations or rooms for improvement.  Basically it uses objdump tool to
> extract location information from the sample instruction.  And the
> parsing code and instruction tracking work on x86 only.
> 
> Actually there's a performance issue about getting disassembly from the
> objdump for kernel.  On my system, GNU objdump was really slower than the
> one from LLVM for some reason so I had to pass the following option for
> each perf report and perf annotate.
> 
>     $ sudo perf report --objdump=llvm-objdump ...
> 
>     # To save it in the config file and drop the command line option
>     $ sudo perf config annotate.objdump=llvm-objdump
> 
> Even with this change, still the most processing time was spent on the
> objdump to get the disassembly.  It'd be nice if we can get the result
> without using objdump at all.
> 
> Also I only tested it with C programs (mostly vmlinux) and I believe
> there are many issues on handling C++ applications.  Probably other
> languages (like Rust?) could be supported too.  But even for C programs,
> it could improve things like better supporting union and array types and
> dealing with type casts and so on.
> 
> I think compiler could generate more DWARF information to help this kind
> of analysis.  Like I mentioned, it doesn't have a variable for
> intermediate pointers when they are chained: a->b->c.  This chain could
> be longer and hard to track the type from the previous variable.  If
> compiler could generate (artificial) debug entries for the intermediate
> pointers with a precise location expression and type info, it would be
> really helpful.
> 
> And I plan to improve the analysis in perf tools with better integration
> to the existing command like perf mem and/or perf c2c.  It'd be pretty
> interesting to see per-struct or per-field access patterns both for load
> and store event at the same time.  Also using data-source or snoop info
> for each struct/field would give some insights on optimizing memory
> usage or layout.
> 
> There are kernel specific issues too.  Some per-cpu variable accesses
> created complex instruction patterns so it was hard to determine which
> data/type it accessed.  For now, it just parsed simple patterns for
> this-cpu access using %gs segment register.  Also it should handle
> self-modifying codes like kprobe, ftrace, live patch and so on.  I guess
> they would usually create an out-of-line copy of modified instructions
> but needs more checking.  And I have no idea about the status of struct
> layout randomization and the DWARF info of the resulting struct.  Maybe
> there are more issues I'm not aware of, please let me know if you notice
> something.
> 
> 
> * Summary
> 
> Despite all the issues, I believe this would be a good addition to our
> performance toolset.  It would help to observe memory overheads in a
> different angle and to optimize the memory usage.  I'm really looking
> forward to hearing any feedback.
> 
> The code is available at 'perf/data-profile-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Enjoy,
> Namhyung
> 
> 
> Cc: Ben Woodard <woodard@redhat.com> 
> Cc: Joe Mario <jmario@redhat.com>
> CC: Kees Cook <keescook@chromium.org>
> Cc: David Blaikie <blaikie@google.com>
> Cc: Xu Liu <xliuprof@google.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> 
> Namhyung Kim (48):
>   perf annotate: Move raw_comment and raw_func_start
>   perf annotate: Check if operand has multiple regs
>   perf tools: Add util/debuginfo.[ch] files
>   perf dwarf-aux: Fix die_get_typename() for void *
>   perf dwarf-aux: Move #ifdef code to the header file
>   perf dwarf-aux: Add die_get_scopes() helper
>   perf dwarf-aux: Add die_find_variable_by_reg() helper
>   perf dwarf-aux: Factor out __die_get_typename()
>   perf dwarf-regs: Add get_dwarf_regnum()
>   perf annotate-data: Add find_data_type()
>   perf annotate-data: Add dso->data_types tree
>   perf annotate: Factor out evsel__get_arch()
>   perf annotate: Add annotate_get_insn_location()
>   perf annotate: Implement hist_entry__get_data_type()
>   perf report: Add 'type' sort key
>   perf report: Support data type profiling
>   perf annotate-data: Add member field in the data type
>   perf annotate-data: Update sample histogram for type
>   perf report: Add 'typeoff' sort key
>   perf report: Add 'symoff' sort key
>   perf annotate: Add --data-type option
>   perf annotate: Add --type-stat option for debugging
>   perf annotate: Add --insn-stat option for debugging
>   perf annotate-data: Parse 'lock' prefix from llvm-objdump
>   perf annotate-data: Handle macro fusion on x86
>   perf annotate-data: Handle array style accesses
>   perf annotate-data: Add stack operation pseudo type
>   perf dwarf-aux: Add die_find_variable_by_addr()
>   perf annotate-data: Handle PC-relative addressing
>   perf annotate-data: Support global variables
>   perf dwarf-aux: Add die_get_cfa()
>   perf annotate-data: Support stack variables
>   perf dwarf-aux: Check allowed DWARF Ops
>   perf dwarf-aux: Add die_collect_vars()
>   perf dwarf-aux: Handle type transfer for memory access
>   perf annotate-data: Introduce struct data_loc_info
>   perf map: Add map__objdump_2rip()
>   perf annotate: Add annotate_get_basic_blocks()
>   perf annotate-data: Maintain variable type info
>   perf annotate-data: Add update_insn_state()
>   perf annotate-data: Handle global variable access
>   perf annotate-data: Handle call instructions
>   perf annotate-data: Implement instruction tracking
>   perf annotate: Parse x86 segment register location
>   perf annotate-data: Handle this-cpu variables in kernel
>   perf annotate-data: Track instructions with a this-cpu variable
>   perf annotate-data: Add stack canary type
>   perf annotate-data: Add debug message
> 
>  tools/perf/Documentation/perf-report.txt      |    3 +
>  .../arch/loongarch/annotate/instructions.c    |    6 +-
>  tools/perf/arch/x86/util/dwarf-regs.c         |   38 +
>  tools/perf/builtin-annotate.c                 |  149 +-
>  tools/perf/builtin-report.c                   |   19 +-
>  tools/perf/util/Build                         |    2 +
>  tools/perf/util/annotate-data.c               | 1246 +++++++++++++++++
>  tools/perf/util/annotate-data.h               |  222 +++
>  tools/perf/util/annotate.c                    |  763 +++++++++-
>  tools/perf/util/annotate.h                    |  104 +-
>  tools/perf/util/debuginfo.c                   |  205 +++
>  tools/perf/util/debuginfo.h                   |   64 +
>  tools/perf/util/dso.c                         |    4 +
>  tools/perf/util/dso.h                         |    2 +
>  tools/perf/util/dwarf-aux.c                   |  561 +++++++-
>  tools/perf/util/dwarf-aux.h                   |   86 +-
>  tools/perf/util/dwarf-regs.c                  |   33 +
>  tools/perf/util/hist.h                        |    3 +
>  tools/perf/util/include/dwarf-regs.h          |   11 +
>  tools/perf/util/map.c                         |   20 +
>  tools/perf/util/map.h                         |    3 +
>  tools/perf/util/probe-finder.c                |  193 +--
>  tools/perf/util/probe-finder.h                |   19 +-
>  tools/perf/util/sort.c                        |  195 ++-
>  tools/perf/util/sort.h                        |    7 +
>  tools/perf/util/symbol_conf.h                 |    4 +-
>  26 files changed, 3703 insertions(+), 259 deletions(-)
>  create mode 100644 tools/perf/util/annotate-data.c
>  create mode 100644 tools/perf/util/annotate-data.h
>  create mode 100644 tools/perf/util/debuginfo.c
>  create mode 100644 tools/perf/util/debuginfo.h
> 
> 
> base-commit: 87cd3d48191e533cd9c224f2da1d78b3513daf47
> -- 
> 2.42.0.655.g421f12c284-goog
> 

-- 

- Arnaldo
