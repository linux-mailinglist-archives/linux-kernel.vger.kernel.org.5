Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DABD80FC11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377708AbjLMANX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLMANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1425683;
        Tue, 12 Dec 2023 16:13:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so4818424a91.3;
        Tue, 12 Dec 2023 16:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426406; x=1703031206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QXgL8D8PNXq5RFsROTbG7MkYROID9O42Iw8pCwO6r0E=;
        b=fSs0NFHnAzycPhakHxRyfpDZaTDMffIxGC7//L4qpyiK39gogaf4XGeJ3nwVlpnVMs
         lC3rZkbPcRUoSpPUrjFCGpTkc0uGkLkUkf3IfZWmQ/z8sbBvu0Gz8NaE72u08KBlVS8P
         zD1km3N2E9KdNyVCt2hFFOLHrXJQaEZIIvWBfhcge0GusnLPXjvCzpuetZeURuc6QUbC
         TgVNVChag9ZOYpld+MLg56V7mD9Xo5GDYPGrpyNl3R+mnneEI5/DhhAfKDie83z8PVe7
         vGIWyPaubiciAFHujNX57Iuls49Pjok4w6U+rejj2pqQ7qJkJzOtKDdTP/JPZcKMXDPn
         17hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426406; x=1703031206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXgL8D8PNXq5RFsROTbG7MkYROID9O42Iw8pCwO6r0E=;
        b=uMJ/E6WfYZsCLO+oKZCI8RVH2xpbTVyDqJNb6kcek1UnX/GG3wRwPiurPzMryIbRnQ
         TOIQ45+OJtHT2rCsTthMLxsYpOuaISrBY30AMYwG5zcWPu0ze+eXDwpRQp9kzS4A9I/J
         VEwrJwEIcie4cAdYG4FABTQNKNiG0iD4S0G9tCK+ItnbvZM+Tbu4GZP65Tl51lpicXdE
         +W30UqAG1lPMuVgEw4jl4tEPUJnjsI/aX/i0C5DIjLPEl7VIHRJ2syzEq2aHZI7TKtwL
         o0N7OGT+ACwiA1x1nEPUxfzhmcY6fXWaXLsgZTZX1ySZGyxPwX614LSo/zWviX6n4YVi
         h/EA==
X-Gm-Message-State: AOJu0Yy0CaNampSPaWeg7fwSlAIfxWqqmaXCQ0iSxfd1rRQP4IMNw6y9
        azqBItQB76FzDSnGI6AR9zk=
X-Google-Smtp-Source: AGHT+IHdWB/mdiE/h4Xhbkx5VFngY4VT/Zt6JxLC1bXqmY1XIkMfpHPaRQ/5ThLS4HVrJsBOYKjgAw==
X-Received: by 2002:a17:90a:6c47:b0:28a:d15b:56b9 with SMTP id x65-20020a17090a6c4700b0028ad15b56b9mr973270pjj.11.1702426406164;
        Tue, 12 Dec 2023 16:13:26 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:25 -0800 (PST)
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
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Wielaard <mark@klomp.org>,
        Jason Merrill <jason@redhat.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        William Huang <williamjhuang@google.com>
Subject: [PATCHSET 00/17] perf tools: Introduce data type profiling (v3)
Date:   Tue, 12 Dec 2023 16:13:06 -0800
Message-ID: <20231213001323.718046-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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


* v3 changes
 - split the basic part and the remaining parts for easier review.  And
   I'd like to focus on the basic part first as it's less controversial.
 - Protect from inappropriate access by checking init_annotation  (Arnaldo)
 - Show warnings when DWARF location support is not built  (Athira)
 - Some DWARF changes are merged in the perf-tools-next already
 
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
    $ sudo perf mem record -a -K --ldlat=1 -- sleep 1

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
to handle such location expressions as well.  Note that this part is not
included in the basic patchset but you can find it in the full series of
this work later.

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

This is the basic part of this work which only handles the pointer type
variables found in the DWARF debug info.  You can find the link to the
full version at the Summary section below.

The patch 1 and 2 are preparation for the next patches.  The patch 3-7
are the main logic to find a matching DWARF variable and its type using
given instruction and its location.  The patch 8 and 9 add 'type' sort
key to perf report.  The patch 10-14 are to support type annotation and
also import perf report with new sort keys.  The patch 15 enables event
group in perf annotate.  The patch 16 and 17 shows some stats for debug.


* Limitations and future work

As I said earlier, this work is in a very early shape and has many
limitations or rooms for improvement.  Basically it uses objdump tool to
extract location information from the sample instruction.  And the
parsing code and instruction tracking work on x86 only.

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

The code is available at 'perf/data-profile-basic-v3' branch in the tree
below.  The full version of the code is in 'perf/data-profile-v3' branch.

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
Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: William Huang <williamjhuang@google.com>


Namhyung Kim (17):
  perf dwarf-aux: Factor out die_get_typename_from_type()
  perf dwarf-regs: Add get_dwarf_regnum()
  perf annotate-data: Add find_data_type()
  perf annotate-data: Add dso->data_types tree
  perf annotate: Factor out evsel__get_arch()
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

 tools/perf/Documentation/perf-annotate.txt |  11 +
 tools/perf/Documentation/perf-report.txt   |   3 +
 tools/perf/arch/x86/util/dwarf-regs.c      |  38 ++
 tools/perf/builtin-annotate.c              | 249 ++++++++++++-
 tools/perf/builtin-report.c                |  15 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/annotate-data.c            | 404 +++++++++++++++++++++
 tools/perf/util/annotate-data.h            | 143 ++++++++
 tools/perf/util/annotate.c                 | 304 +++++++++++++++-
 tools/perf/util/annotate.h                 |  50 +++
 tools/perf/util/dso.c                      |   4 +
 tools/perf/util/dso.h                      |   2 +
 tools/perf/util/dwarf-aux.c                |  38 +-
 tools/perf/util/dwarf-aux.h                |   3 +
 tools/perf/util/dwarf-regs.c               |  34 ++
 tools/perf/util/hist.h                     |   3 +
 tools/perf/util/include/dwarf-regs.h       |  19 +
 tools/perf/util/sort.c                     | 202 ++++++++++-
 tools/perf/util/sort.h                     |   7 +
 tools/perf/util/symbol_conf.h              |   4 +-
 20 files changed, 1502 insertions(+), 32 deletions(-)
 create mode 100644 tools/perf/util/annotate-data.c
 create mode 100644 tools/perf/util/annotate-data.h


base-commit: 8596ba324356a7392a6639024de8c9ae7a9fce92
-- 
2.43.0.472.g3155946c3a-goog

