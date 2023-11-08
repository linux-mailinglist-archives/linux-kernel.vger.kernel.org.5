Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E577E5C24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjKHRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898C2110
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699463568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhkzshFwT5ppbI+Y0n3/gecIab4dQxwm3Gk3eDKRJwY=;
        b=MXwkGUUqT9prWChyQWre198SPmBS8ouNTe6e6+o3fskYdzTWahxUrDsbW3L1PZ9YQQwq83
        ztnFRo3YDnA3IzEB2eC/YcuQYTROP8GijG6JTn+ylNuAYVQynSGAWXyLBlFUxWJV1wMqnp
        SGVtulFe0mgV0h6nSYBy9FNxP07YF9A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-niRDKMPGN_aDMLRoZz61Kg-1; Wed, 08 Nov 2023 12:12:46 -0500
X-MC-Unique: niRDKMPGN_aDMLRoZz61Kg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6707401e1aeso81536206d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463566; x=1700068366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhkzshFwT5ppbI+Y0n3/gecIab4dQxwm3Gk3eDKRJwY=;
        b=vplK1show+NqDTxjpBW9DrAvvw5llq17GtWNHmS9mY01yDwUx2pIqJfko610iX5Gca
         QYPXxKW6hPtl4lJ0ad7xG4Hec/p+2h1hl0434SrZLHdiP4SAiDUsp8I9PfLuy2AaT0In
         WV6gz6GrZwsOQRA5l64x9pviT/3/ff+VuKOWSknkV/VdoaufEGAQ97lX3Ki9cTCBV4NV
         wZGhhMnfhahmqj46wV5I8CrXEGskg1qTjmFO2+8y600E8XcDYSDIBl2z1AB9oKkqMhRu
         j6+d0YHzpbqlbDkh/ALelkR6NAgPqWb01XMs1A4gJM8ZjUDvAvxdxPN7zYPpupg3/mP8
         p+Gw==
X-Gm-Message-State: AOJu0YwjZHItfX9tKi9My4+cXKsbHkRlUsX3G3oOJ00MOVKd+7hBswuh
        B/2kNEc7ANpGmkS/Gyf0+jUp3QyH4shzaZIz1lpakqW4lN7Bq4okJ6jC/JfBxcn8UOJYCCBbNBY
        yFlJNf/3yof8+X6oX91OmhYB8
X-Received: by 2002:ad4:5ccc:0:b0:675:65d6:d0f3 with SMTP id iu12-20020ad45ccc000000b0067565d6d0f3mr2646695qvb.24.1699463566124;
        Wed, 08 Nov 2023 09:12:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGws7NS+6V389jHhKF7I3mOLTMP5N8x47QKpNQLInhi0yxVVDHf8tYss1U+a9vJ4RliNSb7TA==
X-Received: by 2002:ad4:5ccc:0:b0:675:65d6:d0f3 with SMTP id iu12-20020ad45ccc000000b0067565d6d0f3mr2646666qvb.24.1699463565693;
        Wed, 08 Nov 2023 09:12:45 -0800 (PST)
Received: from [192.168.0.189] (pool-173-76-165-118.bstnma.fios.verizon.net. [173.76.165.118])
        by smtp.gmail.com with ESMTPSA id p16-20020a05621415d000b00647386a3234sm1269477qvz.85.2023.11.08.09.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 09:12:45 -0800 (PST)
Message-ID: <82cd8b7e-bd46-49ed-9160-eabcfd4c3c20@redhat.com>
Date:   Wed, 8 Nov 2023 12:12:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
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
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231012035111.676789-1-namhyung@kernel.org>
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 11:50 PM, Namhyung Kim wrote:
> Hello,
> 
> I'm happy to share my work on data type profiling.  This is to associate
> PMU samples to data types they refer using DWARF debug information.  So
> basically it depends on quality of PMU events and compiler for producing
> DWARF info.  But it doesn't require any changes in the target program.
> 
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
> 
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

Hi Namhyung:

I've been playing with your datatype profile patch and it looks really promising.
I think it would be a big help if it could be integrated into perf c2c.  

Perf c2c gives a great insight into what's contributing to cpu cacheline contention, but it
can be difficult to understand the output.  Having visuals with your datatype profile output
would be a big help.

I have a simple test program with readers and writers tugging on the data below:

  uint64_t hotVar; 
  typedef struct __foo {
     uint64_t m1;
     uint64_t m2;
     uint64_t m3;
  } FOO;

The rest of this reply looks at both your datatype output and c2c to see where they 
might compliment each other.


When I run perf with your patches on a simple program to cause contention on the above data, I get the following:

# perf mem record --ldlat=1 --all-user --  ./tugtest -r3 -r5 -r7 -r9 -r11 -w10 -w12 -w14 -w16 -b5 -H2000000
# perf report -s type,typeoff --hierarchy --stdio 

   # Samples: 26K of event 'cpu/mem-loads,ldlat=1/P'
   # Event count (approx.): 2958226
   #
   #    Overhead  Data Type / Data Type Offset
   # ...........  ............................
   #
       54.50%     int      
          54.50%     int +0 (no field)
       23.21%     long int 
          23.21%     long int +0 (no field)
       18.30%     struct __foo
           9.57%     struct __foo +8 (m2)
           8.73%     struct __foo +0 (m1)
        3.86%     long unsigned int
           3.86%     long unsigned int +0 (no field)
       <snip>  
   
   # Samples: 30K of event 'cpu/mem-stores/P'
   # Event count (approx.): 33880197
   #
   #    Overhead  Data Type / Data Type Offset
   # ...........  ............................
   #
       99.85%     struct __foo
          70.48%     struct __foo +0 (m1)
          29.34%     struct __foo +16 (m3)
           0.03%     struct __foo +8 (m2)
        0.09%     long unsigned int
           0.09%     long unsigned int +0 (no field)
        0.06%     (unknown)
           0.06%     (unknown) +0 (no field)
       <snip>  
   
Then I run perf annotate with your patches, and I get the following:

  # perf annotate  --data-type 

   Annotate type: 'long int' in /home/joe/tugtest/tugtest (2901 samples):
   ============================================================================
       samples     offset       size  field
          2901          0          8  long int	;
   
   Annotate type: 'struct __foo' in /home/joe/tugtest/tugtest (5593 samples):
   ============================================================================
       samples     offset       size  field
          5593          0         24  struct __foo	 {
          2755          0          8      uint64_t	m1;
          2838          8          8      uint64_t	m2;
             0         16          8      uint64_t	m3;
                                      };

Now when I run that same simple test using perf c2c, and I focus on the cachline that the struct and hotVar reside in, I get:

# perf c2c record --all-user -- ./tugtest -r3 -r5 -r7 -r9 -r11 -w10 -w12 -w14 -w16 -b5 -H2000000
# perf c2c report -NNN --stdio 
# <snip>
#
#      ----- HITM -----  ------- Store Refs ------  ------ Data address ------                ---------- cycles ----------    Total    cpu               Shared                     
# Num  RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A        Offset  Node  PA cnt  Code address  rmt hitm  lcl hitm      load  records    cnt      Symbol   Object    Source:Line  Node{cpu list}
#....  .......  .......  .......  .......  .......  ............  ....  ......  ............  ........  ........  ........  .......  .....  ..........  .......  .............  ....
#
 ---------------------------------------------------------------
    0     1094     2008    17071    13762        0      0x406100
 ---------------------------------------------------------------
         0.00%    0.20%    0.00%    0.00%    0.00%           0x8     1       1      0x401355         0       978      1020     2962      4  [.] writer  tugtest  tugtest.c:129   0{10,12,14,16}
         0.00%    0.00%    0.12%    0.02%    0.00%           0x8     1       1      0x401360         0         0         0       23      4  [.] writer  tugtest  tugtest.c:129   0{10,12,14,16}
        68.10%   60.26%    0.00%    0.00%    0.00%          0x10     1       1      0x401505      2181      1541      1393     5813      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}
        31.63%   39.34%    0.00%    0.00%    0.00%          0x10     1       1      0x401331      1242      1095       936     3393      4  [.] writer  tugtest  tugtest.c:127   0{10,12,14,16}
         0.00%    0.00%   40.03%   40.25%    0.00%          0x10     1       1      0x40133c         0         0         0    12372      4  [.] writer  tugtest  tugtest.c:127   0{10,12,14,16}
         0.27%    0.15%    0.00%    0.00%    0.00%          0x18     1       1      0x401343       834      1136      1032     2930      4  [.] writer  tugtest  tugtest.c:128   0{10,12,14,16}
         0.00%    0.05%    0.00%    0.00%    0.00%          0x18     1       1      0x40150c         0       933      1567     5050      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}
         0.00%    0.00%    0.06%    0.00%    0.00%          0x18     1       1      0x40134e         0         0         0       10      4  [.] writer  tugtest  tugtest.c:128   0{10,12,14,16}
         0.00%    0.00%   59.80%   59.73%    0.00%          0x20     1       1      0x401516         0         0         0    18428      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}

With the above c2c output, we can see:
 - the hottest contended addresses, and the load latencies they caused.
 - the cacheline offset for the contended addresses.
 - the cpus and numa nodes where the accesses came from.
 - the cacheline alignment for the data of interest.
 - the number of cpus and threads concurrently accessing each address.
 - the breakdown of reads causing HITM (contention) and writes hitting or missing the cacheline.
 - the object name, source line and line number for where the accesses occured.
 - the numa node where the data is allocated.
 - the number of physical pages the virtual addresses were mapped to (e.g. numa_balancing).

What would really help the c2c output be more usable is if it had a better visual to it.
It's likely the current c2c output can be trimmed a bit.

Here's one idea that incorporates your datatype info, though I'm sure there are better ways, as this may get unwieldy.:
     
#      ----- HITM -----  ------- Store Refs ------  ------ Data address ------                ---------- cycles ----------    Total    cpu               Shared                     
# Num  RmtHitm  LclHitm   L1 Hit  L1 Miss      N/A        Offset  Node  PA cnt  Code address  rmt hitm  lcl hitm      load  records    cnt      Symbol   Object    Source:Line  Node{cpu list}
#....  .......  .......  .......  .......  .......  ............  ....  ......  ............  ........  ........  ........  .......  .....  ..........  .......  .............  ....
#
 ---------------------------------------------------------------
    0     1094     2008    17071    13762        0      0x406100
 ---------------------------------------------------------------
  uint64_t hotVar: tugtest.c:38
         0.00%    0.20%    0.00%    0.00%    0.00%           0x8     1       1      0x401355         0       978      1020     2962      4  [.] writer  tugtest  tugtest.c:129   0{10,12,14,16}
         0.00%    0.00%    0.12%    0.02%    0.00%           0x8     1       1      0x401360         0         0         0       23      4  [.] writer  tugtest  tugtest.c:129   0{10,12,14,16}
  struct __foo uint64_t m1: tugtest.c:39
        68.10%   60.26%    0.00%    0.00%    0.00%          0x10     1       1      0x401505      2181      1541      1393     5813      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}
        31.63%   39.34%    0.00%    0.00%    0.00%          0x10     1       1      0x401331      1242      1095       936     3393      4  [.] writer  tugtest  tugtest.c:127   0{10,12,14,16}
         0.00%    0.00%   40.03%   40.25%    0.00%          0x10     1       1      0x40133c         0         0         0    12372      4  [.] writer  tugtest  tugtest.c:127   0{10,12,14,16}
  struct __foo uint64_t m2: tugtest.c:40
         0.27%    0.15%    0.00%    0.00%    0.00%          0x18     1       1      0x401343       834      1136      1032     2930      4  [.] writer  tugtest  tugtest.c:128   0{10,12,14,16}
         0.00%    0.05%    0.00%    0.00%    0.00%          0x18     1       1      0x40150c         0       933      1567     5050      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}
         0.00%    0.00%    0.06%    0.00%    0.00%          0x18     1       1      0x40134e         0         0         0       10      4  [.] writer  tugtest  tugtest.c:128   0{10,12,14,16}
  struct __foo uint64_t m3: tugtest.c:41
         0.00%    0.00%   59.80%   59.73%    0.00%          0x20     1       1      0x401516         0         0         0    18428      5  [.] reader  tugtest  tugtest.c:163   1{3,5,7,9,11}

And then it would be good to find a clean way to incorporate your sample counts.

On a related note, is there a way the accesses could be broken down into read counts 
and write counts?   That, with the above source line info for all the accesses, 
helps to convey a picture of "the affinity of the accesses".  

For example, while it's normally good to separate read-mostly data from hot 
written data, if the reads and writes are done together in the same block of 
code by the same thread, then keeping the two data symbols in the same cacheline
could be a win.  I've seen this often. Your datatype info might be able to 
make these affinities more visible to the user.

Thanks for doing this. This is great.
Joe


