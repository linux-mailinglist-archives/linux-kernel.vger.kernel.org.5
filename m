Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA037DEC9C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjKBF4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 01:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjKBF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:56:00 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E5913D;
        Wed,  1 Nov 2023 22:55:57 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so410267a12.3;
        Wed, 01 Nov 2023 22:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698904556; x=1699509356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vVpAS4KEjXA0XAlwy4Gm/bodbnW8MsJmEcn/2Y1iWQ=;
        b=X0TDoYg/3JrTw8lfXZShQNR0zxESxzLVjQ1o/Ouf2CQvJRbjvbXT8I12h7ZaHVjvv+
         grhAa9noaE3CoCNQiEW8Kcu39xVTAB4q6r3iZSdXP+hgyxfvsa2ii+VoZVqyfp+u2ZK/
         2Vm6uvJLFVb3w/RCGYtCVKHKOMbh7kF1GVR80vU/BJc2gkQXHbHJt4oRd6na0RPvcWV/
         QQMJ24as+m3sCmq1abM2jKuQ3Q5HlWumbmtHUUkH+nP6BnuSr6pPvIuP88lmcidwbr4t
         O0BlI6YNb4D9uXqplNtF9x2AOfBwgg9FMF52RESxUVsMi2oEvHYuTMMoGDr34wahta9G
         37HA==
X-Gm-Message-State: AOJu0Ywczc0w6CabaMCmoO3zMPLP+TnW2Gz2mEdz6342lvunAeIf9t7y
        S0eAjJ9/WAjA+Ulj6XIX5gHETo0rqtTfIc9x660=
X-Google-Smtp-Source: AGHT+IFK6szul+rBI1mcUan2dKrg3R85vTVjd1HwAe6dw4pdzzu74uUQAeJGrzvacL/sMm/6U4Jg3iywvxbeLK0VZ/I=
X-Received: by 2002:a17:90b:fd4:b0:27d:6d9c:6964 with SMTP id
 gd20-20020a17090b0fd400b0027d6d9c6964mr16982311pjb.26.1698904556325; Wed, 01
 Nov 2023 22:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231031120526.11502-1-nick.forrington@arm.com> <20231031120526.11502-2-nick.forrington@arm.com>
In-Reply-To: <20231031120526.11502-2-nick.forrington@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Nov 2023 22:55:45 -0700
Message-ID: <CAM9d7cgzbjqU4U9tpAkhme-mZPV-LScJietre=3b01kykG_fcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf lock report: Restore aggregation by caller by default
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        stable@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
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

Hello,

On Tue, Oct 31, 2023 at 5:05 AM Nick Forrington <nick.forrington@arm.com> wrote:
>
> This change restores the previous default behaviour for "perf lock
> report", making the current aggregate-by-address behaviour available via
> the new "--lock-addr" command line parameter.
>
> This makes the behaviour consistent with "perf lock contention" (which
> also aggregates by caller by default, or by address when "--lock-addr"
> is specified).

I understand your concern but actually there's a difference.
"perf lock contention" is a new command which works with new
contention tracepoints whereas "perf lock report" works with old
lockdep/lockstat tracepoints which are not available in the default
configuration.

I made "perf lock contention" compatible to "perf lock report" so
it mimics the old tracepoints behavior as much as possible using
new tracepoints.  But the important difference is that new contention
tracepoints don't have lock names.  The old perf lock report showed
lock names by default but contention output had to use the caller
instead.

>
> Commit 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
> introduced aggregation modes for "perf lock contention" and (potentially
> inadvertently) changed the behaviour of "perf lock report" from
> aggregate-by-caller to aggregate-by-address (making the prior behaviour
> inaccessible).

So it doesn't change the behavior of perf lock report.
You're adding a new (default) feature for perf lock report
to sort the output by caller.  And please note that caller
info needs callstacks.  perf lock record adds it by default
when it finds there are only lock contention tracepoints.
But if it really has the old tracepoints, caller won't work
unless you enabled callstack collection manually (-g).

>
> Example aggregate-by-address output:
>
> $ perf lock report -F acquired

I guess you need -l option here.

>                 Name   acquired
>
>          event_mutex         34
>                              21
>                               1

This is because you used contention tracepoints
and they don't have lock names.

>
> Example aggregate-by-caller output:
>
> $ perf lock report -F acquired
>                 Name   acquired
>
>  perf_trace_init+...         34
>  lock_mm_and_find...         20
>  inherit_event.co...          1
>     do_madvise+0x1f8          1

Maybe it's ok to change the default behavior for contention
tracepoints.  But when lockdep tracepoints are available
it should use the existing addr (symbol) mode.

>
> Cc: stable@kernel.org
> Fixes: 688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")

So, I don't think this is a fix.

Thanks,
Namhyung


> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
> ---
>  tools/perf/Documentation/perf-lock.txt |  4 ++++
>  tools/perf/builtin-lock.c              | 24 +++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index 503abcba1438..349333acbbfc 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -80,6 +80,10 @@ REPORT OPTIONS
>  --combine-locks::
>         Merge lock instances in the same class (based on name).
>
> +-l::
> +--lock-addr::
> +       Show lock contention stat by address
> +
>  -t::
>  --threads::
>      The -t option is to show per-thread lock stat like below:
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index fa7419978353..3aa8ba5ad928 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -78,7 +78,7 @@ struct callstack_filter {
>
>  static struct lock_filter filters;
>
> -static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
> +static enum lock_aggr_mode aggr_mode = LOCK_AGGR_CALLER;
>
>  static bool needs_callstack(void)
>  {
> @@ -1983,8 +1983,8 @@ static int __cmd_report(bool display_info)
>         if (select_key(false))
>                 goto out_delete;
>
> -       if (show_thread_stats)
> -               aggr_mode = LOCK_AGGR_TASK;
> +       aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
> +               show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
>
>         err = perf_session__process_events(session);
>         if (err)
> @@ -2008,6 +2008,19 @@ static void sighandler(int sig __maybe_unused)
>  {
>  }
>
> +static int check_lock_report_options(const struct option *options,
> +                                    const char * const *usage)
> +{
> +       if (show_thread_stats && show_lock_addrs) {
> +               pr_err("Cannot use thread and addr mode together\n");
> +               parse_options_usage(usage, options, "threads", 0);
> +               parse_options_usage(NULL, options, "lock-addr", 0);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  static int check_lock_contention_options(const struct option *options,
>                                          const char * const *usage)
>
> @@ -2589,6 +2602,7 @@ int cmd_lock(int argc, const char **argv)
>         /* TODO: type */
>         OPT_BOOLEAN('c', "combine-locks", &combine_locks,
>                     "combine locks in the same class"),
> +       OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
>         OPT_BOOLEAN('t', "threads", &show_thread_stats,
>                     "show per-thread lock stats"),
>         OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
> @@ -2680,6 +2694,10 @@ int cmd_lock(int argc, const char **argv)
>                         if (argc)
>                                 usage_with_options(report_usage, report_options);
>                 }
> +
> +               if (check_lock_report_options(report_options, report_usage) < 0)
> +                       return -1;
> +
>                 rc = __cmd_report(false);
>         } else if (!strcmp(argv[0], "script")) {
>                 /* Aliased to 'perf script' */
> --
> 2.42.0
>
