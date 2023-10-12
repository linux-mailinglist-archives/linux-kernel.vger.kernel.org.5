Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26B7C7348
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbjJLQmQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjJLQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:42:15 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955FD3;
        Thu, 12 Oct 2023 09:42:09 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-27ce05a23e5so1863381a91.1;
        Thu, 12 Oct 2023 09:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128929; x=1697733729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT20buiWY9WxsNuSNjOiAMe5fIgWrJA1aPxG7BUKqaQ=;
        b=v22ha9oXZWsPdyhUPHfV+JjBvOgeP1C300IVx/GzKoAPP+D8jCVy0YMGDHKmMtwW+2
         O48pRY3x+oWc2xm+CRjI5fC/3FbaphsIJ4v2bINSELz1+8gZRbUrGHEGU60khXTd5PTB
         Ep6o+9wR8Sl11UEM9Zmgcu0QOmDMz4BC0T6FmEZD8Ei+Okzg0ahdWcu0o8qNoK/yPnVi
         ciL0GaR/8EpubSTm2Nnws6s1L9n1rSXjKSlBkInyyXPuGWBErotRndQ68jlmRWYnoHnP
         4PASNUk1vxxrbrtqXaMt1BppsDGD1m99MwnBj1X64V9Yk/1v73sHg++DUCevixsh1UVg
         VEuA==
X-Gm-Message-State: AOJu0YzDFRigYCu+GlmmtzhJLMHViJGwyjoFomrsfU7fv+hSXcVJoqeZ
        GqRQUXHc/sMWhYddaMiMYJkonhKVqb6L4ypRtOM=
X-Google-Smtp-Source: AGHT+IHXcDvRqS0YnK1j/2YEtrDoSKmAG+ReU7/IL3skg26ji8mHC/Wx4B30n1Kq0695qOUe5ub2v7j0k51HPiw0ozQ=
X-Received: by 2002:a17:90a:72ca:b0:27d:2ce9:d6d5 with SMTP id
 l10-20020a17090a72ca00b0027d2ce9d6d5mr960842pjk.12.1697128928859; Thu, 12 Oct
 2023 09:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012091128.GL6307@noisy.programming.kicks-ass.net>
In-Reply-To: <20231012091128.GL6307@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 09:41:57 -0700
Message-ID: <CAM9d7cgcFCidNamZm+O-89N-Jf4EYF263f1GbxYf0xEbkwwE6Q@mail.gmail.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Oct 12, 2023 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> W00t!! Finally! :-)

Yay!

>
> On Wed, Oct 11, 2023 at 08:50:23PM -0700, Namhyung Kim wrote:
>
> > * How to use it
> >
> > To get precise memory access samples, users can use `perf mem record`
> > command to utilize those events supported by their architecture.  Intel
> > machines would work best as they have dedicated memory access events but
> > they would have a filter to ignore low latency loads like less than 30
> > cycles (use --ldlat option to change the default value).
> >
> >     # To get memory access samples in kernel for 1 second (on Intel)
> >     $ sudo perf mem record -a -K --ldlat=4 -- sleep 1
>
> Fundamentally this should work with anything PEBS from MEM_ as
> well, no? No real reason to rely on perf mem for this.

Correct, experienced users can choose any supported event.
Right now it doesn't even use any MEM_ (data_src) fields but it
should be added later.  BTW I think it'd be better to have an option
to enable the data src sample collection without gathering data MMAPs.

>
> > In perf report, it's just a matter of selecting new sort keys: 'type'
> > and 'typeoff'.  The 'type' shows name of the data type as a whole while
> > 'typeoff' shows name of the field in the data type.  I found it useful
> > to use it with --hierarchy option to group relevant entries in the same
> > level.
> >
> >     $ sudo perf report -s type,typeoff --hierarchy --stdio
> >     ...
> >     #
> >     #    Overhead  Data Type / Data Type Offset
> >     # ...........  ............................
> >     #
> >         23.95%     (stack operation)
> >            23.95%     (stack operation) +0 (no field)
> >         23.43%     (unknown)
> >            23.43%     (unknown) +0 (no field)
> >         10.30%     struct pcpu_hot
> >             4.80%     struct pcpu_hot +0 (current_task)
> >             3.53%     struct pcpu_hot +8 (preempt_count)
> >             1.88%     struct pcpu_hot +12 (cpu_number)
> >             0.07%     struct pcpu_hot +24 (top_of_stack)
> >             0.01%     struct pcpu_hot +40 (softirq_pending)
> >          4.25%     struct task_struct
> >             1.48%     struct task_struct +2036 (rcu_read_lock_nesting)
> >             0.53%     struct task_struct +2040 (rcu_read_unlock_special.b.blocked)
> >             0.49%     struct task_struct +2936 (cred)
> >             0.35%     struct task_struct +3144 (audit_context)
> >             0.19%     struct task_struct +46 (flags)
> >             0.17%     struct task_struct +972 (policy)
> >             0.15%     struct task_struct +32 (stack)
> >             0.15%     struct task_struct +8 (thread_info.syscall_work)
> >             0.10%     struct task_struct +976 (nr_cpus_allowed)
> >             0.09%     struct task_struct +2272 (mm)
> >         ...
> >
> > The (stack operation) and (unknown) have no type and field info.  FYI,
> > the stack operations are samples in PUSH, POP or RET instructions which
> > save or restore registers from/to the stack.  They are usually parts of
> > function prologue and epilogue and have no type info.  The next is the
> > struct pcpu_hot and you can see the first field (current_task) at offset
> > 0 was accessed mostly.  It's listed in order of access frequency (not in
> > offset) as you can see it in the task_struct.
> >
> > In perf annotate, new --data-type option was added to enable data
> > field level annotation.  Now it only shows number of samples for each
> > field but we can improve it.
> >
> >     $ sudo perf annotate --data-type
> >     Annotate type: 'struct pcpu_hot' in [kernel.kallsyms] (223 samples):
> >     ============================================================================
> >         samples     offset       size  field
> >             223          0         64  struct pcpu_hot       {
> >             223          0         64      union     {
> >             223          0         48          struct        {
> >              78          0          8              struct task_struct*      current_task;
> >              98          8          4              int      preempt_count;
> >              45         12          4              int      cpu_number;
> >               0         16          8              u64      call_depth;
> >               1         24          8              long unsigned int        top_of_stack;
> >               0         32          8              void*    hardirq_stack_ptr;
> >               1         40          2              u16      softirq_pending;
> >               0         42          1              bool     hardirq_stack_inuse;
> >                                                };
> >             223          0         64          u8*  pad;
> >                                            };
> >                                        };
> >     ...
> >
> > This shows each struct one by one and field-level access info in C-like
> > style.  The number of samples for the outer struct is a sum of number of
> > samples in every field in the struct.  In unions, each field is placed
> > in the same offset so they will have the same number of samples.
>
> This is excellent -- and pretty much what I've been asking for forever.

Glad you like it.

>
> Would it be possible to have multiple sample columns, for eg.
> MEM_LOADS_UOPS_RETIRED.L1_HIT and MEM_LOADS_UOPS_RETIRED.L1_MISS
> or even more (adding LLC hit and miss as well etc.) ?

Yep, that should be supported.  Ideally it would display samples
(or overhead) for each event in an event group.  And you can
force individual events to a group at report/annotate time.
But it doesn't work well with this for now.  Will fix.

>
> (for bonus points: --data-type=typename, would be awesome)

Right, will do that in the next spin.

>
> Additionally, annotating the regular perf-annotate output with data-type
> information (where we have it) might also be very useful. That way, even
> when profiling with PEBS-cycles, an expensive memop immediately gives a
> clue as to what data-type to look at.
>
> > No TUI support yet.
>
> Yeah, nobody needs that anyway :-)

I need that ;-)

At least, interactive transition between perf report and
perf annotate is really useful for me.  You should try
that someday.

Note that perf report TUI works well with data types.

>
> > This can generate instructions like below.
> >
> >     ...
> >     0x123456:  mov    0x18(%rdi), %rcx
> >     0x12345a:  mov    0x10(%rcx), %rax     <=== sample
> >     0x12345e:  test   %rax, %rax
> >     0x123461:  je     <...>
> >     ...
> >
> > And imagine we have a sample at 0x12345a.  Then it cannot find a
> > variable for %rcx since DWARF didn't generate one (it only knows about
> > 'bar').  Without compiler support, all it can do is to track the code
> > execution in each instruction and propagate the type info in each
> > register and stack location by following the memory access.
>
> Right, this has more or less been the 'excuse' for why doing this has
> been 'difficult' for the past 10+ years :/

I'm sure I missed some cases, but I managed to make it work on
usual cases.  We can improve it by handling it more cases and
instructions but it'd be great if we have a better support from the
toolchains.

>
> > Actually I found a discussion in the DWARF mailing list to support
> > "inverted location lists" and it seems a perfect fit for this project.
> > It'd be great if new DWARF would provide a way to lookup variable and
> > type info using a concrete location info (like a register number).
> >
> >   https://lists.dwarfstd.org/pipermail/dwarf-discuss/2023-June/002278.html
>
> Stephane was going to talk to tools people about this over 10 years ago
> :-)

Hope that they would make some progress.

>
> Thanks for *finally* getting this started!!

Yep, let's make it better!

Thanks,
Namhyung
