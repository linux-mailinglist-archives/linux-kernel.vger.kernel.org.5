Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B17AF645
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjIZWYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIZWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:21:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F21BE1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:00:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d848694462aso14758418276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695762001; x=1696366801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPlBM3jJXh8NVH88UtLu8oL9H+fkXnh1TC9GtfvoblQ=;
        b=nynMp7SpE4Au+fyExLOHHa/JYZEAC05WnhxGmqJJeHneSzfPWc0y/7SByp6WjwzoPx
         Cwl1Hh4nif42xIOBFmCqdYw0XnccaBt9NY4EiJMogaslPfDGeXG9C8jL8l6HMc+ogeF7
         f+KXGdNU5PDqGPcIsjBn3V2SfFoYHGIctsVpJj+u3dgTWtL1pqEd5UTDCu0vod6l5Mnh
         1egs6LrWCYQvAualQI3Q8WN4OX7xTTsIdFuLO9MUoxsBEmtJfxih4LuCpZC98+ym/Fqh
         Sz2r4+hyhPVjglUqbSbVNhwW8wBj00la4tSfYGMCBISurxAW+qdggSYoAkSLsZuGFV5P
         gRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695762001; x=1696366801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPlBM3jJXh8NVH88UtLu8oL9H+fkXnh1TC9GtfvoblQ=;
        b=Sh0IIwLXWFXdGWNRBqMXx6lgzOHCn2R9rlofjKpQp4d7x38Lu1INZrIARcfVVcGGRU
         1r+8seRnbKBW8Hz4LCdxCfO4OKPlKON5eeEOUIviuyzsb4AiJ0NhIpl85h0Jps47X54U
         90Nvc/7FSuy6Tw2iafMNZrqIfhr/RKcqasTpF65BtoLj+CwD13g4xf8Qbwf/o1qxrI+R
         2wpQHp4BCKVGa0wzqa/9WA3Wg+Qv5IWvkiJ0slPmirzJNYfAUBHG7uVPhaOrSXilJ0LM
         g2C2097FTVjg+p/lK1Tw7wtsfJQ6aZkWSDMyAj0gszwgrHtAGqDIvKK0K7kM4dmabgSK
         bxwQ==
X-Gm-Message-State: AOJu0Ywx3LTGiTFt8Zqr2JAxQ7c09cIW3GvX0fxwwTg5vH/wIntiuvQU
        t6Bn05i4RsAzjBQnysmaV3VkEFxHXRZp
X-Google-Smtp-Source: AGHT+IG8cssxOjcO1yNg2FBC2jY+PbBtJIgqxfwRdWukqiHfGERqjP45UFvTZ+Cu2kHnzNJWqgAtGkFv25LR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ff0:2e1:80b2:e4a])
 (user=irogers job=sendgmr) by 2002:a25:ce4c:0:b0:d07:e80c:412e with SMTP id
 x73-20020a25ce4c000000b00d07e80c412emr234ybe.12.1695762001426; Tue, 26 Sep
 2023 14:00:01 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:59:47 -0700
In-Reply-To: <20230926205948.1399594-1-irogers@google.com>
Message-Id: <20230926205948.1399594-2-irogers@google.com>
Mime-Version: 1.0
References: <20230926205948.1399594-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v2 2/3] perf vendor events intel: Add broadwellde two metrics
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tma_info_system_socket_clks and uncore_freq metrics that require a
broadwellx style uncore event for UNC_CLOCK.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/112

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/bdwde-metrics.json          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index d0ef46c9bb61..e1f55fcfa0d0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -48,6 +48,12 @@
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
@@ -690,6 +696,12 @@
         "MetricGroup": "SMT",
         "MetricName": "tma_info_system_smt_2t_utilization"
     },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "MetricGroup": "SoC",
+        "MetricName": "tma_info_system_socket_clks"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
-- 
2.42.0.515.g380fc7ccd1-goog

