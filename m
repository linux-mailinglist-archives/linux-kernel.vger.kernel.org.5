Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573F37E7564
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjKJAAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKJAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:18 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053A44A4;
        Thu,  9 Nov 2023 16:00:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280260db156so1275325a91.2;
        Thu, 09 Nov 2023 16:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574415; x=1700179215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jxhCBHlodUJUyE+7ydD2OvPByRgSx7foQxdKlsARdZo=;
        b=Ff6LKpTis53IHHLt77YsYFkE5m9MKDbOhlvmRPyvxd6QotnSgPvrc3x/kSval37t72
         f4yOYeLeqHdWI74n3LbufBD1Vdw2AmvQy7WqtbHKkjLeDwNZlF5X6nMy7z2yYdG48CEj
         LNmp8UFflI+KHjKw7tTLCX/8DoTcT0KW2TvlW+wrjUjd8ffnaqBYm+x0mPh3Y+Tbtz69
         HA/xXc0/M7+grDVbM0wVgVCbFHrdB8vgyGMYYXN5QrVEzfeyxhPK5iniYHYo197ycmdt
         S97Ehl5HBytqr3pQypGzJE0GCTkudmdhICjnzbCUSnzxyTq37GwIH2k/E3lM4hh+SW9a
         zZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574415; x=1700179215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxhCBHlodUJUyE+7ydD2OvPByRgSx7foQxdKlsARdZo=;
        b=hbGcsIUfi14t+ff3pcSukgNDkJOKi0Wcrask4AhdWeZMqceNy/tHK0xQy5b25U4Q8/
         m97hCZnvn97drsp3xwu8FbtXv3npYneq3bSWOQ6bWdaQ0paE+ZihY825L/JtUjlrqLPL
         MoB7vwoOJqtpcOPU7e384zIw8T+DJ92b9FM4vK2exor4WqbFEwOGkXcL7QQbUDYMmcWU
         BauKJuDLMi7bQO+t8GJHAUMoxY2UDSdIJsgugfyyI6iBYh2DU1fJZDHcjtzzsvPgZaH1
         Hy5tjom2axnY+Rnd8OJYhLACOBhzubksnbkCQiTedvkpqnCejICHW34w6OXFH9E76Blb
         L4Ww==
X-Gm-Message-State: AOJu0YxJfTsEscu2fqcTLnN6j23yY0NtsIwc4fwKR2YTQzMXp6ZWHk7o
        MmXNNNwupBL4j4y9pBtxueDt7WWH3cw=
X-Google-Smtp-Source: AGHT+IGfEc2gjYk/llfpUrgZa07VwikCsqBbE+Zg27NdaY6QcZuymiHocfPWLO32z651+pF9HV6svg==
X-Received: by 2002:a17:90b:1d03:b0:280:4799:a841 with SMTP id on3-20020a17090b1d0300b002804799a841mr3394482pjb.38.1699574415186;
        Thu, 09 Nov 2023 16:00:15 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:14 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Wielaard <mark@klomp.org>,
        Jason Merrill <jason@redhat.com>
Subject: [RFC 00/52] perf tools: Introduce data type profiling (v2)
Date:   Thu,  9 Nov 2023 15:59:19 -0800
Message-ID: <20231110000012.3538610-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm happy to share my work on data type profiling.  This is to associate
PMU samples to data types they refer using DWARF debug information.  So
basically it depends on quality of PMU events and compiler for producing
DWARF info.  But it doesn't require any changes in the target program.

As it's an early stage, I've targeted the kernel on x86 to reduce the
amount of work but IIUC there's no fundamental blocker to apply it to
other architectures and applications.


* v2 changes
 - speed up analysis by not asking (unused) line number info to objdump
 - support annotate a specific data type only by passing a type name like
   `perf annotate --data-type=<TYPENAME>`  (PeterZ)
 - allow event group view to see multiple event results together like
   `perf annotate --data-type --group`  (PeterZ)
 - rename to `die_get_typename_from_type()`  (Masami)
 - add a feature check for HAVE_DWARF_CFI_SUPPORT  (Masami)
 - add Acked-by tags from Masami
 

* How to use it

To get precise memory access samples, users can use `perf mem record`
command to utilize those events supported by their architecture.  Intel
machines would work best as they have dedicated memory access events but
they would have a filter to ignore low latency loads like less than 30
cycles (use --ldlat option to change the default value).

    # To get memory access samples in kernel for 1 second (on Intel)
    $ sudo perf mem record -a -K --ldlat=4 -- sleep 1

    # Similar for the AMD (but it requires 6.3+ kernel for BPF filters)
    $ sudo perf mem record -a --filter 'mem_op == load || mem_op == store, ip > 0x8000000000000000' -- sleep 1

Note that it used 'sudo' command because it's collecting the event in
system wide mode.  Actually it would depend on the sysctl setting of
kernel.perf_event_paranoid.  AMD still needs root due to the BPF filter
though.

Actually users can use a different event as long as it gives precise
instruction addresses in samples.  But the perf mem record will pick
up the available events which will give more information like data
source or latency (for advanced usage).

After getting a profile data, you would run perf report or perf
annotate as usual to see the result.  Make sure that you have a kernel
debug package installed or vmlinux with DWARF info.

I've added new options and sort keys to enable the data type profiling.
Probably I need to add it to perf mem or perf c2c command for better
user experience.  I'm open to discussion how we can make it simpler and
intuitive for regular users.  But let's talk about the lower level
interface for now.

In perf report, it's just a matter of selecting new sort keys: 'type'
and 'typeoff'.  The 'type' shows name of the data type as a whole while
'typeoff' shows name of the field in the data type.  I found it useful
to use it with --hierarchy option to group relevant entries in the same
level.

Also, if you have both load and store events, pass --group option to
see the result together.  This would give 3 output columns with a dummy
event.  I think we should get rid of the dummy event after recording or
discard from the output at least.

    $ sudo perf report -s type,typeoff --hierarchy --group --stdio
    ...
    #
    # Samples: 10K of events 'cpu/mem-loads,ldlat=4/P, cpu/mem-stores/P, dummy:u'
    # Event count (approx.): 602758064
    #
    #                    Overhead  Data Type / Data Type Offset
    # ...........................  ............................
    #
        26.09%   3.28%   0.00%     long unsigned int
           26.09%   3.28%   0.00%     long unsigned int +0 (no field)
        18.48%   0.73%   0.00%     struct page
           10.83%   0.02%   0.00%     struct page +8 (lru.next)
            3.90%   0.28%   0.00%     struct page +0 (flags)
            3.45%   0.06%   0.00%     struct page +24 (mapping)
            0.25%   0.28%   0.00%     struct page +48 (_mapcount.counter)
            0.02%   0.06%   0.00%     struct page +32 (index)
            0.02%   0.00%   0.00%     struct page +52 (_refcount.counter)
            0.02%   0.01%   0.00%     struct page +56 (memcg_data)
            0.00%   0.01%   0.00%     struct page +16 (lru.prev)
        15.37%  17.54%   0.00%     (stack operation)
           15.37%  17.54%   0.00%     (stack operation) +0 (no field)
        11.71%  50.27%   0.00%     (unknown)
           11.71%  50.27%   0.00%     (unknown) +0 (no field)
    ...

The most frequently accessed type was long unsigned int and then the
struct page and you can see the second field (lru.next) at offset
8 was accessed mostly.

The (stack operation) and (unknown) have no type and field info.  FYI,
the stack operations are samples in PUSH, POP or RET instructions which
save or restore registers from/to the stack.  They are usually parts of
function prologue and epilogue and have no type info.

In perf annotate, new --data-type option was added to enable data
field level annotation.  Now it only shows number of samples for each
field but we can improve it.  The --data-type option optionally takes an
argument to specify the name of data type to display.  Otherwise, it'd
display all data types having samples.

    $ sudo perf annotate --data-type=page --group
    Annotate type: 'struct page' in [kernel.kallsyms] (480 samples):
     event[0] = cpu/mem-loads,ldlat=4/P
     event[1] = cpu/mem-stores/P
     event[2] = dummy:u
    ============================================================================
                              samples     offset       size  field
            447         33          0          0         64  struct page     {
            108          8          0          0          8      long unsigned int  flags;
            319         13          0          8         40      union       {
            319         13          0          8         40          struct          {
            236          2          0          8         16              union       {
            236          2          0          8         16                  struct list_head       lru {
            236          1          0          8          8                      struct list_head*  next;
              0          1          0         16          8                      struct list_head*  prev;
                                                                             };
            236          2          0          8         16                  struct          {
            236          1          0          8          8                      void*      __filler;
              0          1          0         16          4                      unsigned int       mlock_count;
                                                                             };
            236          2          0          8         16                  struct list_head       buddy_list {
            236          1          0          8          8                      struct list_head*  next;
              0          1          0         16          8                      struct list_head*  prev;
                                                                             };
            236          2          0          8         16                  struct list_head       pcp_list {
            236          1          0          8          8                      struct list_head*  next;
              0          1          0         16          8                      struct list_head*  prev;
                                                                             };
                                                                         };
             82          4          0         24          8              struct address_space*      mapping;
              1          7          0         32          8              union       {
              1          7          0         32          8                  long unsigned int      index;
              1          7          0         32          8                  long unsigned int      share;
                                                                         };
              0          0          0         40          8              long unsigned int  private;
                                                                     };
        ...

This shows each struct one by one and field-level access info in C-like
style.  The number of samples for the outer struct is a sum of number of
samples in every field in the struct.  In unions, each field is placed
in the same offset so they will have the same number of samples.

No TUI support yet.


* How it works

The basic idea is to use DWARF location expression in debug entries for
variables.  Say we got a sample in the instruction below:

    0x123456:  mov    0x18(%rdi), %rcx

Then we know the instruction at 0x123456 is accessing to a memory region
where %rdi register has a base address and offset 0x18 from the base.
DWARF would have a debug info entry for a function or a block which
covers that address.  For example, we might have something like this:

    <1><100>: Abbrev Number: 10 (DW_TAG_subroutine_type)
       <101>    DW_AT_name       : (indirect string, offset: 0x184e6): foo
       <105>    DW_AT_type       : <0x29ad7>
       <106>    DW_AT_low_pc     : 0x123400
       <10e>    DW_AT_high_pc    : 0x1234ff
    <2><116>: Abbrev Number: 8 (DW_TAG_formal_parameter)
       <117>    DW_AT_name       : (indirect string, offset: 0x18527): bar
       <11b>    DW_AT_type       : <0x29b3a>
       <11c>    DW_AT_location   : 1 byte block: 55    (DW_OP_reg2 (rdi))

So the function 'foo' covers the instruction from 0x123400 to 0x1234ff
and we know the sample instruction belongs to the function.  And it has
a parameter called 'bar' and it's located at the %rdi register.  Then we
know the instruction is using the variable bar and its type would be a
pointer (to a struct).  We can follow the type info of bar and verify
its access by checking the size of the (struct) type and offset in the
instruction (0x18).

Well.. this is a simple example that the 'bar' has a single location.
Other variables might be located in various places over time but it
should be covered by the location list of the debug entry.  Therefore,
as long as DWARF produces a correct location expression for a variable,
it should be able to find the variable using the location info.

Global variables and local variables are different as they can be
accessed directly without a pointer.  They are located in an absolute
address or relative position from the current stack frame.  So it needs
to handle such location expressions as well.

However, some memory accesses don't have a variable in some cases.  For
example, you have a pointer variable for a struct which contains another
pointers.  And then you can directly dereference it without using a
variable.  Consider the following source code.

    int foo(struct baz *bar) {
        ...
        if (bar->p->q == 0)
            return 1;
        ...
    }

This can generate instructions like below.

    ...
    0x123456:  mov    0x18(%rdi), %rcx
    0x12345a:  mov    0x10(%rcx), %rax     <=== sample
    0x12345e:  test   %rax, %rax
    0x123461:  je     <...>
    ...

And imagine we have a sample at 0x12345a.  Then it cannot find a
variable for %rcx since DWARF didn't generate one (it only knows about
'bar').  Without compiler support, all it can do is to track the code
execution in each instruction and propagate the type info in each
register and stack location by following the memory access.

Actually I found a discussion in the DWARF mailing list to support
"inverted location lists" and it seems a perfect fit for this project.
It'd be great if new DWARF would provide a way to lookup variable and
type info using a concrete location info (like a register number).

  https://lists.dwarfstd.org/pipermail/dwarf-discuss/2023-June/002278.html 


* Patch structure

The patch 1-5 are cleanups and a fix that can be applied separately.
The patch 6-25 are the main changes in perf report and perf annotate to
support simple cases with a pointer variable.  The patch 26-36 are to
improve it by handling global and local variables (without a pointer)
and some edge cases.  The patch 37-43 implemented instruction tracking
to infer data type when there's no variable for that.  The patch 47-51
handles kernel-specific per-cpu variables (only for current CPU).  The
patch 52 is to help debugging and is not intended for merge.


* Limitations and future work

As I said earlier, this work is in a very early shape and has many
limitations or rooms for improvement.  Basically it uses objdump tool to
extract location information from the sample instruction.  And the
parsing code and instruction tracking work on x86 only.

In the previous version, I mentioned a performance issue on objdump but
it turned out that it was because of bad usage.  I realized it passed
"-l" option to display line numbers along with the disassembly.  But it
doesn't use the line numbers for data type profiling.  So I just got rid
of it and it gives a huge speedup (285s -> 9.5s).

    $ time ./perf.v1 report -s type > output1
    real	4m45.248s
    user	4m0.714s
    sys		0m44.338s

    $ time ./perf.v2 report -s type > output2
    real	0m9.464s
    user	0m3.271s
    sys		0m6.254s

    $ md5sum output*
    1489f96658bfaee61812df9a42fa7812  output1
    1489f96658bfaee61812df9a42fa7812  output2

Interestingly, now GNU objdump outperforms llvm-objdump for some reason.
If you set the perf config annotate.objdump=llvm-objdump as I said in
the v1 cover letter, please remove it now. :)

Even with this change, still the most processing time was spent on the
objdump to get the disassembly.  It'd be nice if we can get the result
without using objdump at all.

Also I only tested it with C programs (mostly vmlinux) and I believe
there are many issues on handling C++ applications.  Probably other
languages (like Rust?) could be supported too.  But even for C programs,
it could improve things like better supporting union and array types and
dealing with type casts and so on.

I think compiler could generate more DWARF information to help this kind
of analysis.  Like I mentioned, it doesn't have a variable for
intermediate pointers when they are chained: a->b->c.  This chain could
be longer and hard to track the type from the previous variable.  If
compiler could generate (artificial) debug entries for the intermediate
pointers with a precise location expression and type info, it would be
really helpful.

And I plan to improve the analysis in perf tools with better integration
to the existing command like perf mem and/or perf c2c.  It'd be pretty
interesting to see per-struct or per-field access patterns both for load
and store event at the same time.  Also using data-source or snoop info
for each struct/field would give some insights on optimizing memory
usage or layout.

There are kernel specific issues too.  Some per-cpu variable accesses
created complex instruction patterns so it was hard to determine which
data/type it accessed.  For now, it just parsed simple patterns for
this-cpu access using %gs segment register.  Also it should handle
self-modifying codes like kprobe, ftrace, live patch and so on.  I guess
they would usually create an out-of-line copy of modified instructions
but needs more checking.  And I have no idea about the status of struct
layout randomization and the DWARF info of the resulting struct.  Maybe
there are more issues I'm not aware of, please let me know if you notice
something.


* Summary

Despite all the issues, I believe this would be a good addition to our
performance toolset.  It would help to observe memory overheads in a
different angle and to optimize the memory usage.  I'm really looking
forward to hearing any feedback.

The code is available at 'perf/data-profile-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Enjoy,
Namhyung


Cc: Ben Woodard <woodard@redhat.com> 
Cc: Joe Mario <jmario@redhat.com>
CC: Kees Cook <keescook@chromium.org>
Cc: David Blaikie <blaikie@google.com>
Cc: Xu Liu <xliuprof@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Mark Wielaard <mark@klomp.org>
Cc: Jason Merrill <jason@redhat.com>


Namhyung Kim (52):
  perf annotate: Pass "-l" option to objdump conditionally
  perf annotate: Move raw_comment and raw_func_start
  perf tools: Add util/debuginfo.[ch] files
  perf dwarf-aux: Fix die_get_typename() for void *
  perf dwarf-aux: Move #ifdef code to the header file
  perf dwarf-aux: Add die_get_scopes() helper
  perf dwarf-aux: Add die_find_variable_by_reg() helper
  perf build: Add feature check for dwarf_getcfi()
  perf probe: Convert to check dwarf_getcfi feature
  perf dwarf-aux: Factor out die_get_typename_from_type()
  perf dwarf-regs: Add get_dwarf_regnum()
  perf annotate-data: Add find_data_type()
  perf annotate-data: Add dso->data_types tree
  perf annotate: Factor out evsel__get_arch()
  perf annotate: Check if operand has multiple regs
  perf annotate: Add annotate_get_insn_location()
  perf annotate: Implement hist_entry__get_data_type()
  perf report: Add 'type' sort key
  perf report: Support data type profiling
  perf annotate-data: Add member field in the data type
  perf annotate-data: Update sample histogram for type
  perf report: Add 'typeoff' sort key
  perf report: Add 'symoff' sort key
  perf annotate: Add --data-type option
  perf annotate: Support event group display
  perf annotate: Add --type-stat option for debugging
  perf annotate: Add --insn-stat option for debugging
  perf annotate-data: Parse 'lock' prefix from llvm-objdump
  perf annotate-data: Handle macro fusion on x86
  perf annotate-data: Handle array style accesses
  perf annotate-data: Add stack operation pseudo type
  perf dwarf-aux: Add die_find_variable_by_addr()
  perf annotate-data: Handle PC-relative addressing
  perf annotate-data: Support global variables
  perf dwarf-aux: Add die_get_cfa()
  perf annotate-data: Support stack variables
  perf dwarf-aux: Check allowed DWARF Ops
  perf dwarf-aux: Add die_collect_vars()
  perf dwarf-aux: Handle type transfer for memory access
  perf annotate-data: Introduce struct data_loc_info
  perf map: Add map__objdump_2rip()
  perf annotate: Add annotate_get_basic_blocks()
  perf annotate-data: Maintain variable type info
  perf annotate-data: Add update_insn_state()
  perf annotate-data: Handle global variable access
  perf annotate-data: Handle call instructions
  perf annotate-data: Implement instruction tracking
  perf annotate: Parse x86 segment register location
  perf annotate-data: Handle this-cpu variables in kernel
  perf annotate-data: Track instructions with a this-cpu variable
  perf annotate-data: Add stack canary type
  perf annotate-data: Add debug message

 tools/build/Makefile.feature                  |    1 +
 tools/build/feature/Makefile                  |    4 +
 tools/build/feature/test-dwarf_getcfi.c       |    9 +
 tools/perf/Documentation/perf-annotate.txt    |   11 +
 tools/perf/Documentation/perf-report.txt      |    3 +
 tools/perf/Makefile.config                    |    5 +
 .../arch/loongarch/annotate/instructions.c    |    6 +-
 tools/perf/arch/x86/util/dwarf-regs.c         |   38 +
 tools/perf/builtin-annotate.c                 |  217 ++-
 tools/perf/builtin-report.c                   |   21 +-
 tools/perf/util/Build                         |    2 +
 tools/perf/util/annotate-data.c               | 1221 +++++++++++++++++
 tools/perf/util/annotate-data.h               |  222 +++
 tools/perf/util/annotate.c                    |  786 ++++++++++-
 tools/perf/util/annotate.h                    |  104 +-
 tools/perf/util/debuginfo.c                   |  205 +++
 tools/perf/util/debuginfo.h                   |   64 +
 tools/perf/util/dso.c                         |    4 +
 tools/perf/util/dso.h                         |    2 +
 tools/perf/util/dwarf-aux.c                   |  566 +++++++-
 tools/perf/util/dwarf-aux.h                   |   92 +-
 tools/perf/util/dwarf-regs.c                  |   34 +
 tools/perf/util/hist.h                        |    3 +
 tools/perf/util/include/dwarf-regs.h          |   19 +
 tools/perf/util/map.c                         |   20 +
 tools/perf/util/map.h                         |    3 +
 tools/perf/util/probe-finder.c                |  201 +--
 tools/perf/util/probe-finder.h                |   19 +-
 tools/perf/util/sort.c                        |  202 ++-
 tools/perf/util/sort.h                        |    7 +
 tools/perf/util/symbol_conf.h                 |    4 +-
 31 files changed, 3830 insertions(+), 265 deletions(-)
 create mode 100644 tools/build/feature/test-dwarf_getcfi.c
 create mode 100644 tools/perf/util/annotate-data.c
 create mode 100644 tools/perf/util/annotate-data.h
 create mode 100644 tools/perf/util/debuginfo.c
 create mode 100644 tools/perf/util/debuginfo.h


base-commit: 6512b6aa237db36d881a81cc312db39668e61853
-- 
2.42.0.869.gea05f2083d-goog

