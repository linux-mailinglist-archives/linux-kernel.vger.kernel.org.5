Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90975CA79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGUOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGUOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD23588;
        Fri, 21 Jul 2023 07:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB81361BAF;
        Fri, 21 Jul 2023 14:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4D8C433C7;
        Fri, 21 Jul 2023 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689950765;
        bh=wh6KYtzokKI1f+cHkXEXNVb0673Gyg8MDVYmR2faJbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iizLVdNk4lIjiVLmrI2x8kWEyIIgNOUYOY9ZRzCSMKg1SC1Eu+EfLv5p9bG6HsEP/
         kcvfllwNw5RtSXFG6Bt+A7CVznk8Z4Rp8JxXtoVvNUVAK8Be86+MSrQxBq7cuhKcJz
         BJkHODcv3/DMA5l4ZX6EeaOmrMGxhXIN5P/Y+OOEWDym2P5Amm3XAeoXkeVRifuAn5
         ZChfDLzUMoCsYujaNDKPq0gVjzNdyEl5end721ZOF4A2M90sMsHveX3ZJmTTccEH6Q
         gvWRbWHsG2Y11tpy1yoqj+yn2F021mvtAH2S8fEG90hBXHoUoVLPOlcabKYNOn/MG2
         8XrAmdstbibRQ==
Date:   Fri, 21 Jul 2023 23:45:59 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andre Fredette <anfredet@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 1/5] perf bench uprobe: Add benchmark to test uprobe
 overhead
Message-Id: <20230721234559.cef77903e1cff359dbb06dfd@kernel.org>
In-Reply-To: <20230719204910.539044-2-acme@kernel.org>
References: <20230719204910.539044-1-acme@kernel.org>
        <20230719204910.539044-2-acme@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 17:49:06 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This just adds the initial "workload", a call to libc's usleep(1000us)
> function:
> 
>   $ perf stat --null perf bench uprobe all
>   # Running uprobe/baseline benchmark...
>   # Executed 1000 usleep(1000) calls
>        Total time: 1053533 usecs
> 
>    1053.533 usecs/op
> 
>    Performance counter stats for 'perf bench uprobe all':
> 
>          1.061042896 seconds time elapsed
> 
>          0.001079000 seconds user
>          0.006499000 seconds sys
> 
>   $
> 
> More entries will be added using a BPF skel to add various uprobes to
> the usleep() function.

Looks good to me. 

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andre Fredette <anfredet@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Dave Tucker <datucker@redhat.com>
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-bench.txt |  3 +
>  tools/perf/bench/Build                  |  1 +
>  tools/perf/bench/bench.h                |  1 +
>  tools/perf/bench/uprobe.c               | 80 +++++++++++++++++++++++++
>  tools/perf/builtin-bench.c              |  6 ++
>  5 files changed, 91 insertions(+)
>  create mode 100644 tools/perf/bench/uprobe.c
> 
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> index f04f0eaded985fc8..ca5789625cd2b8e5 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -67,6 +67,9 @@ SUBSYSTEM
>  'internals'::
>  	Benchmark internal perf functionality.
>  
> +'uprobe'::
> +	Benchmark overhead of uprobe + BPF.
> +
>  'all'::
>  	All benchmark subsystems.
>  
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index 0f158dc8139bbd0d..47412d47dccfeff2 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -16,6 +16,7 @@ perf-y += inject-buildid.o
>  perf-y += evlist-open-close.o
>  perf-y += breakpoint.o
>  perf-y += pmu-scan.o
> +perf-y += uprobe.o
>  
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
>  perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 0d2b65976212333a..201311f75c964df2 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -42,6 +42,7 @@ int bench_inject_build_id(int argc, const char **argv);
>  int bench_evlist_open_close(int argc, const char **argv);
>  int bench_breakpoint_thread(int argc, const char **argv);
>  int bench_breakpoint_enable(int argc, const char **argv);
> +int bench_uprobe_baseline(int argc, const char **argv);
>  int bench_pmu_scan(int argc, const char **argv);
>  
>  #define BENCH_FORMAT_DEFAULT_STR	"default"
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> new file mode 100644
> index 0000000000000000..707174220a76701f
> --- /dev/null
> +++ b/tools/perf/bench/uprobe.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * uprobe.c
> + *
> + * uprobe benchmarks
> + *
> + *  Copyright (C) 2023, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> + */
> +#include "../perf.h"
> +#include "../util/util.h"
> +#include <subcmd/parse-options.h>
> +#include "../builtin.h"
> +#include "bench.h"
> +#include <linux/time64.h>
> +
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +#define LOOPS_DEFAULT 1000
> +static int loops = LOOPS_DEFAULT;
> +
> +static const struct option options[] = {
> +	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
> +	OPT_END()
> +};
> +
> +static const char * const bench_uprobe_usage[] = {
> +	"perf bench uprobe <options>",
> +	NULL
> +};
> +
> +static int bench_uprobe(int argc, const char **argv)
> +{
> +	const char *name = "usleep(1000)", *unit = "usec";
> +	struct timespec start, end;
> +	u64 diff;
> +	int i;
> +
> +	argc = parse_options(argc, argv, options, bench_uprobe_usage, 0);
> +
> +	clock_gettime(CLOCK_REALTIME, &start);
> +
> +	for (i = 0; i < loops; i++) {
> +		usleep(USEC_PER_MSEC);
> +	}
> +
> +	clock_gettime(CLOCK_REALTIME, &end);
> +
> +	diff = end.tv_sec * NSEC_PER_SEC + end.tv_nsec - (start.tv_sec * NSEC_PER_SEC + start.tv_nsec);
> +	diff /= NSEC_PER_USEC;
> +
> +	switch (bench_format) {
> +	case BENCH_FORMAT_DEFAULT:
> +		printf("# Executed %'d %s calls\n", loops, name);
> +		printf(" %14s: %'" PRIu64 " %ss\n\n", "Total time", diff, unit);
> +		printf(" %'.3f %ss/op\n", (double)diff / (double)loops, unit);
> +		break;
> +
> +	case BENCH_FORMAT_SIMPLE:
> +		printf("%" PRIu64 "\n", diff);
> +		break;
> +
> +	default:
> +		/* reaching here is something of a disaster */
> +		fprintf(stderr, "Unknown format:%d\n", bench_format);
> +		exit(1);
> +	}
> +
> +	return 0;
> +}
> +
> +int bench_uprobe_baseline(int argc, const char **argv)
> +{
> +	return bench_uprobe(argc, argv);
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index db435b791a09b69b..09637aee83413e63 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -104,6 +104,11 @@ static struct bench breakpoint_benchmarks[] = {
>  	{ NULL,	NULL, NULL },
>  };
>  
> +static struct bench uprobe_benchmarks[] = {
> +	{ "baseline",	"Baseline libc usleep(1000) call",	bench_uprobe_baseline,	},
> +	{ NULL,	NULL, NULL },
> +};
> +
>  struct collection {
>  	const char	*name;
>  	const char	*summary;
> @@ -123,6 +128,7 @@ static struct collection collections[] = {
>  #endif
>  	{ "internals",	"Perf-internals benchmarks",			internals_benchmarks	},
>  	{ "breakpoint",	"Breakpoint benchmarks",			breakpoint_benchmarks	},
> +	{ "uprobe",	"uprobe benchmarks",				uprobe_benchmarks	},
>  	{ "all",	"All benchmarks",				NULL			},
>  	{ NULL,		NULL,						NULL			}
>  };
> -- 
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
