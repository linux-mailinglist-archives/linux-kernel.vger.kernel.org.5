Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41E7F3559
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjKURzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKURzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:55:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D2F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:55:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A59C433C8;
        Tue, 21 Nov 2023 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700589336;
        bh=p3KIxbTSpWrGCrWYr2BiJw80ABhzP1OJMLWNszmwFF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPA/a1DdaVBiAqshwHOYmO8W08lTv7WjBqEZttRt24gHTPD8HuhVe1oldGawY4/zu
         Kp7yiCBz2a9JqAiozk8OMtVmRT9gMOcdRDgbaqDodC7sNIWn4sNPb7FAC21ZvMPttJ
         WDlZH/ymsXNJR7jvhyBknjFPg8lTR2doNuoU0wZ1FHcghmcf3VzeL62cBIxBhmvfxh
         B6LnncD8Ge8JRnQpYhj/n/bsI0tPHuPDBJe6kzo4WQhnMMhksWxDundmlLvPPm3YGn
         gNsrW1W6K281B1Efy1RSdpNa0Qn+aot/MoNQAGTpfCEIbl+jifr1Y29PcilYjuCJ/t
         O07Ky4Be3TY8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04BEB40094; Tue, 21 Nov 2023 14:55:33 -0300 (-03)
Date:   Tue, 21 Nov 2023 14:55:33 -0300
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 18/52] perf report: Add 'type' sort key
Message-ID: <ZVzvFen/214ylf32@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-19-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110000012.3538610-19-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 09, 2023 at 03:59:37PM -0800, Namhyung Kim escreveu:
> The 'type' sort key is to aggregate hist entries by data type they
> access.  Add mem_type field to hist_entry struct to save the type.
> If hist_entry__get_data_type() returns NULL, it'd use the
> 'unknown_type' instance.

I built up to here and then tried on a random perf.data file:

⬢[acme@toolbox perf-tools-next]$ perf evlist
cycles:Pu
⬢[acme@toolbox perf-tools-next]$ perf evlist -v
cycles:Pu: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0 (PERF_COUNT_HW_CPU_CYCLES), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID|LOST, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
⬢[acme@toolbox perf-tools-next]$

And got:

⬢[acme@toolbox perf-tools-next]$ perf report -s type
perf: Segmentation fault
-------- backtrace --------
perf[0x69f743]
/lib64/libc.so.6(+0x3dbb0)[0x7f89b4778bb0]
perf[0x505af6]
perf[0x512d47]
perf[0x512f82]
perf[0x5b3461]
perf[0x5b3516]
perf[0x5b3a3e]
perf[0x5bbb05]
perf[0x5bc68f]
perf[0x5bca7c]
perf[0x42ead1]
perf[0x42fa08]
perf[0x43200d]
perf[0x504856]
perf[0x504ac5]
perf[0x504c14]
perf[0x504f01]
/lib64/libc.so.6(+0x27b8a)[0x7f89b4762b8a]
/lib64/libc.so.6(__libc_start_main+0x8b)[0x7f89b4762c4b]
perf[0x40ed65]
⬢[acme@toolbox perf-tools-next]$

Using gdb:

(gdb) run report --stdio -s type
Starting program: /home/acme/bin/perf report --stdio -s type

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 811109]

Program received signal SIGSEGV, Segmentation fault.
0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
189		return head->next == head;
(gdb) bt
#0  0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
#1  0x0000000000512d47 in symbol__ensure_annotate (ms=0xe6f258, evsel=0xe276f0) at util/annotate.c:3640
#2  0x0000000000512f82 in hist_entry__get_data_type (he=0xe6f1e0) at util/annotate.c:3696
#3  0x00000000005b3461 in sort__type_init (he=0xe6f1e0) at util/sort.c:2152
#4  0x00000000005b3516 in sort__type_collapse (left=0xe6ed80, right=0xe6f1e0) at util/sort.c:2169
#5  0x00000000005b3a3e in __sort__hpp_collapse (fmt=0xe448f0, a=0xe6ed80, b=0xe6f1e0) at util/sort.c:2394
#6  0x00000000005bbb05 in hist_entry__collapse (left=0xe6ed80, right=0xe6f1e0) at util/hist.c:1306
#7  0x00000000005bc68f in hists__collapse_insert_entry (hists=0xe27960, root=0xe27998, he=0xe6f1e0) at util/hist.c:1613
#8  0x00000000005bca7c in hists__collapse_resort (hists=0xe27960, prog=0x7fffffffb820) at util/hist.c:1697
#9  0x000000000042ead1 in report__collapse_hists (rep=0x7fffffffbac0) at builtin-report.c:723
#10 0x000000000042fa08 in __cmd_report (rep=0x7fffffffbac0) at builtin-report.c:1042
#11 0x000000000043200d in cmd_report (argc=0, argv=0x7fffffffe1b0) at builtin-report.c:1733
#12 0x0000000000504856 in run_builtin (p=0xdf7da0 <commands+288>, argc=4, argv=0x7fffffffe1b0) at perf.c:322
#13 0x0000000000504ac5 in handle_internal_command (argc=4, argv=0x7fffffffe1b0) at perf.c:375
#14 0x0000000000504c14 in run_argv (argcp=0x7fffffffdfcc, argv=0x7fffffffdfc0) at perf.c:419
#15 0x0000000000504f01 in main (argc=4, argv=0x7fffffffe1b0) at perf.c:535
(gdb)


static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
+{
+       struct disasm_line *dl, *tmp_dl;
+       struct annotation *notes;
+
+       notes = symbol__annotation(ms->sym);
+       if (!list_empty(&notes->src->source))
+               return;
+
+       if (symbol__annotate(ms, evsel, notes->options, NULL) < 0)
+               return;
+
+       /* remove non-insn disasm lines for simplicity */
+       list_for_each_entry_safe(dl, tmp_dl, &notes->src->source, al.node) {
+               if (dl->al.offset == -1) {
+                       list_del(&dl->al.node);
+                       free(dl);
+               }
+       }
+}

Probably annotated_source__new() wasn't called? Yeah, seems so:

(gdb) b annotated_source__new
Breakpoint 1 at 0x50a894: file util/annotate.c, line 851.
(gdb) run report --stdio -s type
Starting program: /home/acme/bin/perf report --stdio -s type

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.fedoraproject.org/>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 818292]

Program received signal SIGSEGV, Segmentation fault.
0x0000000000505af6 in list_empty (head=0x14c20) at /home/acme/git/perf-tools-next/tools/include/linux/list.h:189
189		return head->next == head;
(gdb)



 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/annotate-data.h          |  2 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 69 +++++++++++++++++++++++-
>  tools/perf/util/sort.h                   |  4 ++
>  5 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index af068b4f1e5a..aec34417090b 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -118,6 +118,7 @@ OPTIONS
>  	- retire_lat: On X86, this reports pipeline stall of this instruction compared
>  	  to the previous instruction in cycles. And currently supported only on X86
>  	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
> +	- type: Data type of sample memory access.
>  
>  	By default, comm, dso and symbol keys are used.
>  	(i.e. --sort comm,dso,symbol)
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index ab9f187bd7f1..6efdd7e21b28 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -22,6 +22,8 @@ struct annotated_data_type {
>  	int type_size;
>  };
>  
> +extern struct annotated_data_type unknown_type;
> +
>  #ifdef HAVE_DWARF_SUPPORT
>  
>  /* Returns data type at the location (ip, reg, offset) */
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index afc9f1c7f4dc..9bfed867f288 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -82,6 +82,7 @@ enum hist_column {
>  	HISTC_ADDR_TO,
>  	HISTC_ADDR,
>  	HISTC_SIMD,
> +	HISTC_TYPE,
>  	HISTC_NR_COLS, /* Last entry */
>  };
>  
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 27b123ccd2d1..e647f0117bb5 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -24,6 +24,7 @@
>  #include "strbuf.h"
>  #include "mem-events.h"
>  #include "annotate.h"
> +#include "annotate-data.h"
>  #include "event.h"
>  #include "time-utils.h"
>  #include "cgroup.h"
> @@ -2094,7 +2095,7 @@ struct sort_entry sort_dso_size = {
>  	.se_width_idx	= HISTC_DSO_SIZE,
>  };
>  
> -/* --sort dso_size */
> +/* --sort addr */
>  
>  static int64_t
>  sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
> @@ -2131,6 +2132,69 @@ struct sort_entry sort_addr = {
>  	.se_width_idx	= HISTC_ADDR,
>  };
>  
> +/* --sort type */
> +
> +struct annotated_data_type unknown_type = {
> +	.type_name = (char *)"(unknown)",
> +};
> +
> +static int64_t
> +sort__type_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return sort__addr_cmp(left, right);
> +}
> +
> +static void sort__type_init(struct hist_entry *he)
> +{
> +	if (he->mem_type)
> +		return;
> +
> +	he->mem_type = hist_entry__get_data_type(he);
> +	if (he->mem_type == NULL)
> +		he->mem_type = &unknown_type;
> +}
> +
> +static int64_t
> +sort__type_collapse(struct hist_entry *left, struct hist_entry *right)
> +{
> +	struct annotated_data_type *left_type = left->mem_type;
> +	struct annotated_data_type *right_type = right->mem_type;
> +
> +	if (!left_type) {
> +		sort__type_init(left);
> +		left_type = left->mem_type;
> +	}
> +
> +	if (!right_type) {
> +		sort__type_init(right);
> +		right_type = right->mem_type;
> +	}
> +
> +	return strcmp(left_type->type_name, right_type->type_name);
> +}
> +
> +static int64_t
> +sort__type_sort(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return sort__type_collapse(left, right);
> +}
> +
> +static int hist_entry__type_snprintf(struct hist_entry *he, char *bf,
> +				     size_t size, unsigned int width)
> +{
> +	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->type_name);
> +}
> +
> +struct sort_entry sort_type = {
> +	.se_header	= "Data Type",
> +	.se_cmp		= sort__type_cmp,
> +	.se_collapse	= sort__type_collapse,
> +	.se_sort	= sort__type_sort,
> +	.se_init	= sort__type_init,
> +	.se_snprintf	= hist_entry__type_snprintf,
> +	.se_width_idx	= HISTC_TYPE,
> +};
> +
>  
>  struct sort_dimension {
>  	const char		*name;
> @@ -2185,7 +2249,8 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_ADDR, "addr", sort_addr),
>  	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
>  	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
> -	DIM(SORT_SIMD, "simd", sort_simd)
> +	DIM(SORT_SIMD, "simd", sort_simd),
> +	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index ecfb7f1359d5..aabf0b8331a3 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -15,6 +15,7 @@
>  
>  struct option;
>  struct thread;
> +struct annotated_data_type;
>  
>  extern regex_t parent_regex;
>  extern const char *sort_order;
> @@ -34,6 +35,7 @@ extern struct sort_entry sort_dso_to;
>  extern struct sort_entry sort_sym_from;
>  extern struct sort_entry sort_sym_to;
>  extern struct sort_entry sort_srcline;
> +extern struct sort_entry sort_type;
>  extern const char default_mem_sort_order[];
>  extern bool chk_double_cl;
>  
> @@ -154,6 +156,7 @@ struct hist_entry {
>  	struct perf_hpp_list	*hpp_list;
>  	struct hist_entry	*parent_he;
>  	struct hist_entry_ops	*ops;
> +	struct annotated_data_type *mem_type;
>  	union {
>  		/* this is for hierarchical entry structure */
>  		struct {
> @@ -243,6 +246,7 @@ enum sort_type {
>  	SORT_LOCAL_RETIRE_LAT,
>  	SORT_GLOBAL_RETIRE_LAT,
>  	SORT_SIMD,
> +	SORT_ANNOTATE_DATA_TYPE,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo
