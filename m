Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC57F4FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjKVStd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 13:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjKVStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:49:31 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A9199;
        Wed, 22 Nov 2023 10:49:26 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2854757f0f8so125347a91.1;
        Wed, 22 Nov 2023 10:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700678966; x=1701283766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7Iop8NjAv/V7uTTjT8YgCc8seaP7i+Z8kpzZdHXtjE=;
        b=aDDnQ2UbJI+J/sMDnThx3pWqpVeIAzK/72dAmSzOcNTDXXrDibCTFkhmSt2rK+idAX
         hJtqew9ghkD2bGiK4fvtwblCLVDuBzpI+fIHDfE04e+/xqtd9/EoDH5mUnSOjy1F49N0
         hOtbc4HFK/wc2VU/94Sk62BO3g/6E8HeWpkCezA7ZTCGCUiS3mQTxHGgAddIwQSZz5wL
         a29Ikd/nRyv1YJX581jR4wyhm6WsJYjszoq2YU3TmbgmE3o65aah/50rFD8UEAy5EV1P
         ctOmEHByImQMLYz8p5xESwg3pUtN+S7JGS7rsnuRY5i7OWg9gFD7R/sMpv7+z9fuKKMj
         kpSA==
X-Gm-Message-State: AOJu0Yz6J+vlXjq1hvmxFVUZ3xrZ8hd0ZT6BiqQEXxEADpndRsxdWm+r
        SJT4sjCpIszr6APXKI10KSU9p2vi7MjVYzkuTTI+63Db7M0=
X-Google-Smtp-Source: AGHT+IFWNWFEpGBHQ5w/vbcwy/t3WZMV319y8jsMD7cAf4LiuLVYYuzCiA/kwkmbqQGNj5DKcNqFSCSoWpg5y3vJwMg=
X-Received: by 2002:a17:90b:1e4d:b0:281:1404:c36f with SMTP id
 pi13-20020a17090b1e4d00b002811404c36fmr3475423pjb.16.1700678966001; Wed, 22
 Nov 2023 10:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20231110000012.3538610-1-namhyung@kernel.org> <20231110000012.3538610-19-namhyung@kernel.org>
 <ZVzvFen/214ylf32@kernel.org>
In-Reply-To: <ZVzvFen/214ylf32@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 10:49:13 -0800
Message-ID: <CAM9d7cijprv2fOM_jwYbrV0jbhno2ZQDCT3SExG=Ot=b2mANmw@mail.gmail.com>
Subject: Re: [PATCH 18/52] perf report: Add 'type' sort key
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 9:55 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 09, 2023 at 03:59:37PM -0800, Namhyung Kim escreveu:
> > The 'type' sort key is to aggregate hist entries by data type they
> > access.  Add mem_type field to hist_entry struct to save the type.
> > If hist_entry__get_data_type() returns NULL, it'd use the
> > 'unknown_type' instance.
>
> I built up to here and then tried on a random perf.data file:
>
> ⬢[acme@toolbox perf-tools-next]$ perf evlist
> cycles:Pu
> ⬢[acme@toolbox perf-tools-next]$ perf evlist -v
> cycles:Pu: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
> ⬢[acme@toolbox perf-tools-next]$
>
> And got:
>
> ⬢[acme@toolbox perf-tools-next]$ perf report -s type
> perf: Segmentation fault
> -------- backtrace --------
> perf[0x69f743]
> /lib64/libc.so.6(+0x3dbb0)[0x7f89b4778bb0]
> perf[0x505af6]
> perf[0x512d47]
> perf[0x512f82]
> perf[0x5b3461]
> perf[0x5b3516]
> perf[0x5b3a3e]
> perf[0x5bbb05]
> perf[0x5bc68f]
> perf[0x5bca7c]
> perf[0x42ead1]
> perf[0x42fa08]
> perf[0x43200d]
> perf[0x504856]
> perf[0x504ac5]
> perf[0x504c14]
> perf[0x504f01]
> /lib64/libc.so.6(+0x27b8a)[0x7f89b4762b8a]
> /lib64/libc.so.6(__libc_start_main+0x8b)[0x7f89b4762c4b]
> perf[0x40ed65]
> ⬢[acme@toolbox perf-tools-next]$

Right, the 'type' sort key was added here but unfortunately
it's not ready for prime time yet.  It also needs the next patch
19/52 ("perf report: Support data type profiling") to fully enable
the feature.  Do you think it's better to squash into here?

Thanks,
Namhyung

>
> Using gdb:
>
> (gdb) run report --stdio -s type
> Starting program: /home/acme/bin/perf report --stdio -s type
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 811109]
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
> 189             return head->next == head;
> (gdb) bt
> #0  0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
> #1  0x0000000000512d47 in symbol__ensure_annotate (ms=0xe6f258, evsel=0xe276f0) at util/annotate.c:3640
> #2  0x0000000000512f82 in hist_entry__get_data_type (he=0xe6f1e0) at util/annotate.c:3696
> #3  0x00000000005b3461 in sort__type_init (he=0xe6f1e0) at util/sort.c:2152
> #4  0x00000000005b3516 in sort__type_collapse (left=0xe6ed80, right=0xe6f1e0) at util/sort.c:2169
> #5  0x00000000005b3a3e in __sort__hpp_collapse (fmt=0xe448f0, a=0xe6ed80, b=0xe6f1e0) at util/sort.c:2394
> #6  0x00000000005bbb05 in hist_entry__collapse (left=0xe6ed80, right=0xe6f1e0) at util/hist.c:1306
> #7  0x00000000005bc68f in hists__collapse_insert_entry (hists=0xe27960, root=0xe27998, he=0xe6f1e0) at util/hist.c:1613
> #8  0x00000000005bca7c in hists__collapse_resort (hists=0xe27960, prog=0x7fffffffb820) at util/hist.c:1697
> #9  0x000000000042ead1 in report__collapse_hists (rep=0x7fffffffbac0) at builtin-report.c:723
> #10 0x000000000042fa08 in __cmd_report (rep=0x7fffffffbac0) at builtin-report.c:1042
> #11 0x000000000043200d in cmd_report (argc=0, argv=0x7fffffffe1b0) at builtin-report.c:1733
> #12 0x0000000000504856 in run_builtin (p=0xdf7da0 <commands+288>, argc=4, argv=0x7fffffffe1b0) at perf.c:322
> #13 0x0000000000504ac5 in handle_internal_command (argc=4, argv=0x7fffffffe1b0) at perf.c:375
> #14 0x0000000000504c14 in run_argv (argcp=0x7fffffffdfcc, argv=0x7fffffffdfc0) at perf.c:419
> #15 0x0000000000504f01 in main (argc=4, argv=0x7fffffffe1b0) at perf.c:535
> (gdb)
>
>
> static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
> +{
> +       struct disasm_line *dl, *tmp_dl;
> +       struct annotation *notes;
> +
> +       notes = symbol__annotation(ms->sym);
> +       if (!list_empty(&notes->src->source))
> +               return;
> +
> +       if (symbol__annotate(ms, evsel, notes->options, NULL) < 0)
> +               return;
> +
> +       /* remove non-insn disasm lines for simplicity */
> +       list_for_each_entry_safe(dl, tmp_dl, &notes->src->source, al.node) {
> +               if (dl->al.offset == -1) {
> +                       list_del(&dl->al.node);
> +                       free(dl);
> +               }
> +       }
> +}
>
> Probably annotated_source__new() wasn't called? Yeah, seems so:
>
> (gdb) b annotated_source__new
> Breakpoint 1 at 0x50a894: file util/annotate.c, line 851.
> (gdb) run report --stdio -s type
> Starting program: /home/acme/bin/perf report --stdio -s type
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 818292]
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
> 189             return head->next == head;
> (gdb)
