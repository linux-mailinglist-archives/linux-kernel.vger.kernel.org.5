Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC2789799
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHZPAE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Aug 2023 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHZO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:59:59 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9A8198;
        Sat, 26 Aug 2023 07:59:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d746d030a86so1862162276.1;
        Sat, 26 Aug 2023 07:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693061995; x=1693666795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVfMpGHxQKV0VyiCtd44P44ckPvGutIu+QgOiHZ1TV4=;
        b=UybAzpcQPH0z9vuc5tcfmK0XB2cdG0cGoaKuXhakOLdiW7jv4s/f4MM7NzxipVUPoV
         lJatvoiqMi/tipSXfjVKYgDQYjC9VGlpmyd7lXclm+xVoaeVt8mdq7t/Y0HlXmPyhF2a
         d58JVqmUd2lkzJ30CFnQ9zqj3sdfumDzfTHczKfFElfOW/7Kpz4Ud50gChBs91v7kDY5
         9+WLPLBHwYUS5uPKomws1aZFJeduyGLjzB9iGMExf5qvtywjznzxmzsUD1Ao8rzPJ+JZ
         4u9ARv733RVPX7UONUEPCav963OpjnYPc2ghDE7PXATFJOK8bowg/EAG1DyScpbTzsa3
         dBLA==
X-Gm-Message-State: AOJu0YwhyXHufh5oTvbVjbwzBpHcIrnqf8yBHMOv+soRiaci/rJQrxFS
        2JuJwVyrvpBxu2GvWyBdUtQrqKotJaE4K/UUB6wCZUhY
X-Google-Smtp-Source: AGHT+IEO0SVohJ8JnKY3VLQa9EmNJQcZEIP+LVJoYu3LqLpRFNriGT2tLrO2MsJmOtSHZCZ70LzWpzyKQnlSBfT0M2A=
X-Received: by 2002:a25:add5:0:b0:d44:3ad2:42e5 with SMTP id
 d21-20020a25add5000000b00d443ad242e5mr21423335ybe.4.1693061995321; Sat, 26
 Aug 2023 07:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230826032608.107261-1-yangjihong1@huawei.com> <20230826032608.107261-5-yangjihong1@huawei.com>
In-Reply-To: <20230826032608.107261-5-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Aug 2023 07:59:42 -0700
Message-ID: <CAM9d7cibRU6ViyhxtEYG2UMSYUWbu__Oct-+J1PzvGwu_D=SPA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Aug 25, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> User space tasks can migrate between CPUs, we need to track side-band
> events for all CPUs.
>
> The specific scenarios are as follows:
>
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
>
>   perf record -C 0 stop
>
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.
>
> The solution is to record sideband events for all CPUs when tracing
> selected CPUs. Because this modifies the default behavior, add related
> comments to the perf record man page.
>
> The sys_perf_event_open invoked is as follows:
>
>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:u
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1 (PERF_TYPE_SOFTWARE)
>     size                             136
>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>     { sample_period, sample_freq }   1
>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>     read_format                      ID|LOST
>     inherit                          1
>     exclude_kernel                   1
>     exclude_hv                       1
>     mmap                             1
>     comm                             1
>     task                             1
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>   <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  3 ++
>  tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d5217be012d7..1889f66addf2 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -374,6 +374,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>  In per-thread mode with inheritance mode on (default), samples are captured only when
>  the thread executes on the designated CPUs. Default is to monitor all CPUs.
>
> +User space tasks can migrate between CPUs, so when tracing selected CPUs,
> +a dummy event is created to track sideband for all CPUs.
> +
>  -B::
>  --no-buildid::
>  Do not save the build ids of binaries in the perf.data files. This skips
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 83bd1f117191..21c571018148 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -906,10 +906,44 @@ static int record__config_off_cpu(struct record *rec)
>         return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>
> +static bool record__tracking_system_wide(struct record *rec)
> +{
> +       struct record_opts *opts = &rec->opts;
> +       struct evlist *evlist = rec->evlist;
> +       struct evsel *evsel;
> +
> +       /*
> +        * If all (non-dummy) evsel have exclude_user,
> +        * system_wide is not needed.

Maybe I missed some earlier discussion but why is it not
needed when exclude_user is set?  I think it still needs
FORK or COMM at least..

Thanks,
Namhyung


> +        *
> +        * all_kernel and all_user will overwrite exclude_kernel and
> +        * exclude_user of attr in evsel__config(), here need to check
> +        * all the three items.
> +        *
> +        * Sideband system wide if one of the following conditions is met:
> +        *
> +        *   - all_user is set, and there is a non-dummy event
> +        *   - all_user and all_kernel are not set, and there is
> +        *     a non-dummy event without exclude_user
> +        */
> +       if (opts->all_kernel)
> +               return false;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (!evsel__is_dummy_event(evsel)) {
> +                       if (opts->all_user || !evsel->core.attr.exclude_user)
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static int record__config_tracking_events(struct record *rec)
>  {
>         struct record_opts *opts = &rec->opts;
>         struct evlist *evlist = rec->evlist;
> +       bool system_wide = false;
>         struct evsel *evsel;
>
>         /*
> @@ -919,7 +953,15 @@ static int record__config_tracking_events(struct record *rec)
>          */
>         if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>             perf_pmus__num_core_pmus() > 1) {
> -               evsel = evlist__findnew_tracking_event(evlist, false);
> +
> +               /*
> +                * User space tasks can migrate between CPUs, so when tracing
> +                * selected CPUs, sideband for all CPUs is still needed.
> +                */
> +               if (!!opts->target.cpu_list && record__tracking_system_wide(rec))
> +                       system_wide = true;
> +
> +               evsel = evlist__findnew_tracking_event(evlist, system_wide);
>                 if (!evsel)
>                         return -ENOMEM;
>
> --
> 2.30.GIT
>
