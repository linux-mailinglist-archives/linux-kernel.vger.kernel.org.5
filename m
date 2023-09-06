Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAE7932F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbjIFAjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIFAjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:39:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08585CDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:39:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-597f461adc5so30420207b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 17:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693960757; x=1694565557; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQpsPVl9V03/stk4WOQOI+yTdw+/ffr/bGZfachQVh8=;
        b=DP/ai4p8bnINW7t45vY4MrFhUeZ3Da8f+0JzBmJ5qgiVvMc5PAay+vM45hay5dKvp8
         EahJ0V4aLoMNXFr+Jn+5Y0cRHPY+HEW4anUUcou3rHwNRhJNz4+8iD++9+rCpEboaiX2
         9VzP6ysh45aOM120111fJ10cR8loFvnepr1trkhuK0EvN8PyJW2Jj5dnxbSYa0i96FqI
         BG6HgE30H5ZgYe5JnhTrI3FuZm5EeNXpkQn2IpVVdDgfpC3C4QEzq8ykVPZe+lEVVQk+
         H7qmmG8Sq8DdseeooEryS/K67stBMVv5nePUzq3y1EN5qLLnCWLTVv2c5zdLzsyWWR1v
         LvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693960757; x=1694565557;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQpsPVl9V03/stk4WOQOI+yTdw+/ffr/bGZfachQVh8=;
        b=Zdq/YRFrVUTIbVVWFrTygPEgQqraZfFyLLCtU/F0Hf2X3+CN2r8X+SaWkjA9SGecGE
         8gWvS3eNp4IzU7s3NfpwewRb6i7HgKhPZH/RVN4+fLRwPTK+p26sqwhr/MuxP7yXg9TZ
         VP0ORHKulGhCiNfeS6dxtOZIQcHJFOCMrTFVxkdRg6XEUXZ0PYab5aotMFtAMkcXYpeT
         YRYv5Zavmzj8GVowA7Sot73mBx8Uw3i/YDHiBudWIaiplaFyGGjSvex3knluBpi0jhAw
         eeiMpDYzNrtymjjjm2fPtQJUlxdThXBx7c5zyJPLbuq5PXtFL9V5vWhNSa2SG7DZxmY+
         a9Dw==
X-Gm-Message-State: AOJu0YxPom29b88VqwUSvdclLDCx0SwenV485ife9QmZGA0N+BfWHpNe
        rUuZPTFAsOlQgsxU8ONEm1YdItfx70Tq
X-Google-Smtp-Source: AGHT+IEFAcdV2jUPryUB9Rl9WeMgHN2ABx4oD/+j/XoMO4VT30b4f6jeJ8aX4gauBWtCD542jaAx1BTSsbjX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f4e3:815b:ce4e:64bd])
 (user=irogers job=sendgmr) by 2002:a81:ad09:0:b0:58c:74ec:339b with SMTP id
 l9-20020a81ad09000000b0058c74ec339bmr337849ywh.1.1693960756957; Tue, 05 Sep
 2023 17:39:16 -0700 (PDT)
Date:   Tue,  5 Sep 2023 17:39:12 -0700
Message-Id: <20230906003912.3317462-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf stat: Fix aggr mode initialization
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generating metrics llc_code_read_mpi_demand_plus_prefetch,
llc_data_read_mpi_demand_plus_prefetch,
llc_miss_local_memory_bandwidth_read,
llc_miss_local_memory_bandwidth_write,
nllc_miss_remote_memory_bandwidth_read, memory_bandwidth_read,
memory_bandwidth_write, uncore_frequency, upi_data_transmit_bw,
C2_Pkg_Residency, C3_Core_Residency, C3_Pkg_Residency,
C6_Core_Residency, C6_Pkg_Residency, C7_Core_Residency,
C7_Pkg_Residency, UNCORE_FREQ and tma_info_system_socket_clks would
trigger an address sanitizer heap-buffer-overflows on a SkylakeX.

```
==2567752==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x5020003ed098 at pc 0x5621a816654e bp 0x7fffb55d4da0 sp 0x7fffb55d4d98
READ of size 4 at 0x5020003eee78 thread T0
    #0 0x558265d6654d in aggr_cpu_id__is_empty tools/perf/util/cpumap.c:694:12
    #1 0x558265c914da in perf_stat__get_aggr tools/perf/builtin-stat.c:1490:6
    #2 0x558265c914da in perf_stat__get_global_cached tools/perf/builtin-stat.c:1530:9
    #3 0x558265e53290 in should_skip_zero_counter tools/perf/util/stat-display.c:947:31
    #4 0x558265e53290 in print_counter_aggrdata tools/perf/util/stat-display.c:985:18
    #5 0x558265e51931 in print_counter tools/perf/util/stat-display.c:1110:3
    #6 0x558265e51931 in evlist__print_counters tools/perf/util/stat-display.c:1571:5
    #7 0x558265c8ec87 in print_counters tools/perf/builtin-stat.c:981:2
    #8 0x558265c8cc71 in cmd_stat tools/perf/builtin-stat.c:2837:3
    #9 0x558265bb9bd4 in run_builtin tools/perf/perf.c:323:11
    #10 0x558265bb98eb in handle_internal_command tools/perf/perf.c:377:8
    #11 0x558265bb9389 in run_argv tools/perf/perf.c:421:2
    #12 0x558265bb9389 in main tools/perf/perf.c:537:3
```

The issue was the use of testing a cpumap with NULL rather than using
empty, as a map containing the dummy value isn't NULL and the -1
results in an empty aggr map being allocated which legitimately
overflows when any member is accessed.

Fixes: 8a96f454f566 ("perf stat: Avoid SEGV if core.cpus isn't set")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df48e..a3af805a1d57 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1622,7 +1622,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	if (evsel_list->core.user_requested_cpus)
+	if (!perf_cpu_map__empty(evsel_list->core.user_requested_cpus))
 		nr = perf_cpu_map__max(evsel_list->core.user_requested_cpus).cpu;
 	else
 		nr = 0;
-- 
2.42.0.283.g2d96d420d3-goog

