Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2254F81279F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjLNGEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjLNGEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:04:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A586F1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:03:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc6933a14so2262504276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702533787; x=1703138587; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4PUfny+V4K7JdYxjOjoh/zOyx459HJYl83NL6Gprj10=;
        b=rQl8xWOXnuGEraM6l/BLM+gFunjD2YrIIx+mVZn1Ma3nuV9hKYKJyCLEZlfOB9k6QA
         WXqcbSAZO+MlBdXlPCbF96fZg3hlFq3dT0v/DIaZGaO+17e5r65p8vEvGrjZfoQhks7V
         NFHN0GacXlbiOUpfvv2EdAyDN29o3KYSr0Kt9DP6UXGbw3GTJD0uFjQWfRbZ2BskpbIR
         u2qGlBLFtQO5wbsEGNCQjEt6IjFxCYfP/4i3e/hEDuFxe79SoRTOqqlpgNbEMmUTVgxz
         DnJ24Qf7BFoZTp3qn7tUUsLz/nlkYql9HOKZl0aD2N7HOLFTbgeQPMP4yCgI8Gt6FCQe
         twVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702533787; x=1703138587;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PUfny+V4K7JdYxjOjoh/zOyx459HJYl83NL6Gprj10=;
        b=KN7E+45zgZF073qhDUa/NPDvsLCH2w/QJgEmqNuOWwOzFFYQF9U2NLMguEYpp5Z52R
         +8LBUGQ3q31o2qctGV5gvSvHNxUEYyN5GmG3goGdXqTMk/7zKNLrv4cWjEyLHaaODpnU
         5FxLy3FkLHuvHALxqF/qWdkjGcB/hLjM725BUVVqkU8tubkngF932q3IAJ/XhFDMnYbn
         K3Fa70UfrKEbLuMAC8nE5WiFUGfdZOpFao+0Yq3UDHPFkDR50JlOABp0VcXsc16/OVrR
         wgFE45UCxusCmmywVFjMFfcBMOWBNPxSSI6/UL1rCz2cxbiWKkZtTGMj+ZUzB0JHeT7w
         sI+g==
X-Gm-Message-State: AOJu0Yx4DCH38PQgptTsAIwtcsdV4JyCc46//P0Oc3e1Cjk/0AoXWMdq
        uLPwwQ0i9INbEYSe8ReP2Ha0hL17DzBR
X-Google-Smtp-Source: AGHT+IFcS75cNx03y3Bc3EAju03RPpdE51givPJNziGrBBAtq6ZYga6BWWHY8ZXnGFc36WPB4Y7johreOuie
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:58bc:716b:84a8:e482])
 (user=irogers job=sendgmr) by 2002:a25:b292:0:b0:dbc:c697:63bd with SMTP id
 k18-20020a25b292000000b00dbcc69763bdmr42183ybj.0.1702533787423; Wed, 13 Dec
 2023 22:03:07 -0800 (PST)
Date:   Wed, 13 Dec 2023 22:02:56 -0800
Message-Id: <20231214060256.2094017-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1] perf stat: Combine the -A/--no-aggr and --no-merge options
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
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kaige Ye <ye@kaige.org>, James Clark <james.clark@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -A or --no-aggr option disables aggregation of core events:
```
$ perf stat -A -e cycles,data_total -a true

 Performance counter stats for 'system wide':

CPU0            1,287,665      cycles
CPU1            1,831,681      cycles
CPU2           27,345,998      cycles
CPU3            1,964,799      cycles
CPU4              236,174      cycles
CPU5            3,302,825      cycles
CPU6            9,201,446      cycles
CPU7            1,403,043      cycles
CPU0               110.90 MiB  data_total

       0.008961761 seconds time elapsed
```

The --no-merge option disables the aggregation of uncore events:
```
$ perf stat --no-merge -e cycles,data_total -a true

 Performance counter stats for 'system wide':

        38,482,778      cycles
             15.04 MiB  data_total [uncore_imc_free_running_1]
             15.00 MiB  data_total [uncore_imc_free_running_0]

       0.005915155 seconds time elapsed
```

Having two options confuses users who generally don't appreciate the
difference in PMUs. Keep all the options but make it so they all
disable aggregation both of core and uncore events:
```
$ perf stat -A -e cycles,data_total -a true

 Performance counter stats for 'system wide':

CPU0               85,878      cycles
CPU1               88,179      cycles
CPU2               60,872      cycles
CPU3            3,265,567      cycles
CPU4               82,357      cycles
CPU5               83,383      cycles
CPU6               84,156      cycles
CPU7              220,803      cycles
CPU0                 2.38 MiB  data_total [uncore_imc_free_running_0]
CPU0                 2.38 MiB  data_total [uncore_imc_free_running_1]

       0.001397205 seconds time elapsed
```

Update the relevant perf-stat man page information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-stat.txt | 52 ++++++++++++++------------
 tools/perf/builtin-stat.c              |  5 ++-
 tools/perf/util/stat-display.c         |  2 +-
 tools/perf/util/stat.c                 |  2 +-
 tools/perf/util/stat.h                 |  1 -
 5 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8f789fa1242e..5af2e432b54f 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -422,7 +422,34 @@ See perf list output for the possible metrics and metricgroups.
 
 -A::
 --no-aggr::
-Do not aggregate counts across all monitored CPUs.
+--no-merge::
+Do not aggregate/merge counts across monitored CPUs or PMUs.
+
+When multiple events are created from a single event specification,
+stat will, by default, aggregate the event counts and show the result
+in a single row. This option disables that behavior and shows the
+individual events and counts.
+
+Multiple events are created from a single event specification when:
+
+1. PID monitoring isn't requested and the system has more than one
+   CPU. For example, a system with 8 SMT threads will have one event
+   opened on each thread and aggregation is performed across them.
+
+2. Prefix or glob wildcard matching is used for the PMU name. For
+   example, multiple memory controller PMUs may exist typically with a
+   suffix of _0, _1, etc. By default the event counts will all be
+   combined if the PMU is specified without the suffix such as
+   uncore_imc rather than uncore_imc_0.
+
+3. Aliases, which are listed immediately after the Kernel PMU events
+   by perf list, are used.
+
+--hybrid-merge::
+Merge core event counts from all core PMUs. In hybrid or big.LITTLE
+systems by default each core PMU will report its count
+separately. This option forces core PMU counts to be combined to give
+a behavior closer to having a single CPU type in the system.
 
 --topdown::
 Print top-down metrics supported by the CPU. This allows to determine
@@ -475,29 +502,6 @@ highlight 'tma_frontend_bound'. This metric may be drilled into with
 
 Error out if the input is higher than the supported max level.
 
---no-merge::
-Do not merge results from same PMUs.
-
-When multiple events are created from a single event specification,
-stat will, by default, aggregate the event counts and show the result
-in a single row. This option disables that behavior and shows
-the individual events and counts.
-
-Multiple events are created from a single event specification when:
-1. Prefix or glob matching is used for the PMU name.
-2. Aliases, which are listed immediately after the Kernel PMU events
-   by perf list, are used.
-
---hybrid-merge::
-Merge the hybrid event counts from all PMUs.
-
-For hybrid events, by default, the stat aggregates and reports the event
-counts per PMU. But sometimes, it's also useful to aggregate event counts
-from all PMUs. This option enables that behavior and reports the counts
-without PMUs.
-
-For non-hybrid events, it should be no effect.
-
 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bda020c0b9d5..5fe9abc6a524 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1204,8 +1204,9 @@ static struct option stat_options[] = {
 	OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
 		    "list of cpus to monitor in system-wide"),
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
-		    "disable CPU count aggregation", AGGR_NONE),
-	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
+		    "disable aggregation across CPUs or PMUs", AGGR_NONE),
+	OPT_SET_UINT(0, "no-merge", &stat_config.aggr_mode,
+		    "disable aggregation the same as -A or -no-aggr", AGGR_NONE),
 	OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
 		    "Merge identical named hybrid events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index afe6db8e7bf4..8c61f8627ebc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -898,7 +898,7 @@ static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config
 
 static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
 {
-	if (config->no_merge || hybrid_uniquify(counter, config))
+	if (config->aggr_mode == AGGR_NONE || hybrid_uniquify(counter, config))
 		uniquify_event_name(counter);
 }
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 012c4946b9c4..b0bcf92f0f9c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -592,7 +592,7 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
 {
 	struct evsel *evsel;
 
-	if (config->no_merge)
+	if (config->aggr_mode == AGGR_NONE)
 		return;
 
 	evlist__for_each_entry(evlist, evsel)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 325d0fad1842..4357ba114822 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -76,7 +76,6 @@ struct perf_stat_config {
 	bool			 null_run;
 	bool			 ru_display;
 	bool			 big_num;
-	bool			 no_merge;
 	bool			 hybrid_merge;
 	bool			 walltime_run_table;
 	bool			 all_kernel;
-- 
2.43.0.472.g3155946c3a-goog

