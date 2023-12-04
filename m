Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58408803CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjLDSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjLDSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:23:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83816FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:23:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db548f8dae4so3114866276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701714217; x=1702319017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7oIwN0gwgnh0JH2uoSPjyFXY7LBES97cup/kWuAMDc=;
        b=q92XS/kE26MVTRpPzE2bIiAyjv9qbVKDQsWy1X7HPBmXk5UD1My1tKNPadBkxZX291
         j5CRjW4DGyTjtALsasg6vgp+lUaRbhiYArI4+d9G5zJcBCiz2RPfVsUSW7sjfxpNZQkc
         iYMBWAewjLxEVkZb8UmH6SWJE0KXOurqWE9oac+BB5KlwQcuLKIllzO+CByr7kWyh2j/
         ZZoWLB0wwnGOAmgGEhud/yW+H/QXNlm1TTXnUcpOZ4H9NUQhpeyFMcXrZdmym6Ck8XIm
         syVam1m3pwm9Wdxlqd2hKY/kfpNH2H7R4HIi2Ik7jjlPgrGzG24BXJfMIjWUpRgnpKWa
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714217; x=1702319017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7oIwN0gwgnh0JH2uoSPjyFXY7LBES97cup/kWuAMDc=;
        b=VuRi3YvUxacBK2fioTgsNMym/upgDfB8qDxGi/Hd2Z7o6J9ShGvruLKVWVVqqmrTFS
         1K5AG6iQiq0UBg6oRAq7h7i1cA+W+d0mX4zgqGDOvdcHnub8a9jOJb7/JPzkF+5OHheC
         nUV/oc2847WCwi0PJS1v4NRzHS84qOBws2aOUKqcKnQ03dDexDGMf4jJvzMCjGzvLKFD
         FPBg4V0KbsLxWFnowQtYvU9lK1QXL2lxB4hNx0IWCLO2zEgN0vUvVgNvBr9yZeboaqwv
         qPyDnNq43Gd9u5mu2WqZGDPZo4X3ZLSj8noD47VZvgFhW61ODBr1Y/xTrn0bpZFON6fj
         2sfQ==
X-Gm-Message-State: AOJu0YxbAwwDKssHTWxsZ0PD5oLaQId79We/QLNY0bl5GYebEEr2G0ss
        PJIXi5wLN8HXF9j/eDOjb7xowXWWzNMi
X-Google-Smtp-Source: AGHT+IHOBK+GAxccPQiMkDdDXauTrztmqup3Xwe1oIP3fGM+SQUEpNnshkLn78GxvBotlA0CjlE9r9x7oN0t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b241:d804:967e:c827])
 (user=irogers job=sendgmr) by 2002:a25:d4cc:0:b0:db9:772b:1020 with SMTP id
 m195-20020a25d4cc000000b00db9772b1020mr44975ybf.5.1701714217695; Mon, 04 Dec
 2023 10:23:37 -0800 (PST)
Date:   Mon,  4 Dec 2023 10:23:30 -0800
In-Reply-To: <20231204182330.654255-1-irogers@google.com>
Message-Id: <20231204182330.654255-2-irogers@google.com>
Mime-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 2/2] perf vendor events arm64: Fix default AmpereOne metrics
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add default metric group name for TopdownL1 metrics.

Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index e2848a9d4848..afcdad58ef89 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -231,6 +231,7 @@
         "MetricName": "slots_lost_misspeculation_fraction",
         "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
         "ScaleUnit": "1percent of slots"
     },
@@ -238,6 +239,7 @@
         "MetricName": "retired_fraction",
         "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots retiring, useful work",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
 	"ScaleUnit": "1percent of slots"
     },
-- 
2.43.0.rc2.451.g8631bc7472-goog

