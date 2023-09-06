Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2397933E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIFC6h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 22:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIFC6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:58:37 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FA1184;
        Tue,  5 Sep 2023 19:58:33 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7927611c54bso122465639f.2;
        Tue, 05 Sep 2023 19:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693969113; x=1694573913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHA/CZb972+rGa7PLzhmGS/p+N4WJm97/nO5EcN6Ds0=;
        b=NlN/oKT7bQy8nCJs/omupGkBXd+pqHs2IpN8/vTYY9TDF5XiHMlXR2Jks2yYd/14qa
         l7D+n7Ov5I+OG3oij4ZrQgbPnP/HfB1XAvrSuyt5eOiggsY7cS9P4sHXu993KD9DMWju
         Etj5naAeoEWdCsd+VQKWuldA5E+ZcpTU12pYS5Uu7pX+O1c8gcPwoEZ6B63dygmeDKLL
         UTIR4A1GljrLXQlHtdW5C6p5I8y7Rb7jtM3FpdKWS55z4FATqrUME8yIDOVTtpqzIAdf
         LpZ4mk9oqVosvEyK36odw1d6wGkmLe9fVCVOqNIl2nHd5RNR5FUhv3y0iEv9nDZSH0Zn
         678g==
X-Gm-Message-State: AOJu0Yw9iNxDQNLmGg1repnOjvskN33Qujj7gks/h5KNdIpPtcoz6emA
        mKm/T/NGugJGiSFVjMX4DhxTYms1abcY4oHIWIU=
X-Google-Smtp-Source: AGHT+IE1NKfVkyq0xjvB5OEQlRNdJKCYn+xWS/xXnPlmvVgeEIkorpw8TMN4A9uEblACZ55eTblk5/Ui7tsOHcdCiOs=
X-Received: by 2002:a5d:8449:0:b0:792:4cfc:178f with SMTP id
 w9-20020a5d8449000000b007924cfc178fmr15961626ior.16.1693969112902; Tue, 05
 Sep 2023 19:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230906003912.3317462-1-irogers@google.com>
In-Reply-To: <20230906003912.3317462-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Sep 2023 19:58:20 -0700
Message-ID: <CAM9d7cgBZufrSWQhSeipV35_y3Kb1EWSoqtXMvLBnCFaoS9Atg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix aggr mode initialization
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Ian,

On Tue, Sep 5, 2023 at 5:39 PM Ian Rogers <irogers@google.com> wrote:
>
> Generating metrics llc_code_read_mpi_demand_plus_prefetch,
> llc_data_read_mpi_demand_plus_prefetch,
> llc_miss_local_memory_bandwidth_read,
> llc_miss_local_memory_bandwidth_write,
> nllc_miss_remote_memory_bandwidth_read, memory_bandwidth_read,
> memory_bandwidth_write, uncore_frequency, upi_data_transmit_bw,
> C2_Pkg_Residency, C3_Core_Residency, C3_Pkg_Residency,
> C6_Core_Residency, C6_Pkg_Residency, C7_Core_Residency,
> C7_Pkg_Residency, UNCORE_FREQ and tma_info_system_socket_clks would
> trigger an address sanitizer heap-buffer-overflows on a SkylakeX.
>
> ```
> ==2567752==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x5020003ed098 at pc 0x5621a816654e bp 0x7fffb55d4da0 sp 0x7fffb55d4d98
> READ of size 4 at 0x5020003eee78 thread T0
>     #0 0x558265d6654d in aggr_cpu_id__is_empty tools/perf/util/cpumap.c:694:12
>     #1 0x558265c914da in perf_stat__get_aggr tools/perf/builtin-stat.c:1490:6
>     #2 0x558265c914da in perf_stat__get_global_cached tools/perf/builtin-stat.c:1530:9
>     #3 0x558265e53290 in should_skip_zero_counter tools/perf/util/stat-display.c:947:31
>     #4 0x558265e53290 in print_counter_aggrdata tools/perf/util/stat-display.c:985:18
>     #5 0x558265e51931 in print_counter tools/perf/util/stat-display.c:1110:3
>     #6 0x558265e51931 in evlist__print_counters tools/perf/util/stat-display.c:1571:5
>     #7 0x558265c8ec87 in print_counters tools/perf/builtin-stat.c:981:2
>     #8 0x558265c8cc71 in cmd_stat tools/perf/builtin-stat.c:2837:3
>     #9 0x558265bb9bd4 in run_builtin tools/perf/perf.c:323:11
>     #10 0x558265bb98eb in handle_internal_command tools/perf/perf.c:377:8
>     #11 0x558265bb9389 in run_argv tools/perf/perf.c:421:2
>     #12 0x558265bb9389 in main tools/perf/perf.c:537:3
> ```
>
> The issue was the use of testing a cpumap with NULL rather than using
> empty, as a map containing the dummy value isn't NULL and the -1
> results in an empty aggr map being allocated which legitimately
> overflows when any member is accessed.

Right, evlist__create_maps() set it to non-NULL.

>
> Fixes: 8a96f454f566 ("perf stat: Avoid SEGV if core.cpus isn't set")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 07b48f6df48e..a3af805a1d57 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1622,7 +1622,7 @@ static int perf_stat_init_aggr_mode(void)
>          * taking the highest cpu number to be the size of
>          * the aggregation translate cpumap.
>          */
> -       if (evsel_list->core.user_requested_cpus)
> +       if (!perf_cpu_map__empty(evsel_list->core.user_requested_cpus))
>                 nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
>         else
>                 nr = 0;
> --
> 2.42.0.283.g2d96d420d3-goog
>
