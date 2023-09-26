Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1487AF680
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjIZXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjIZW7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:59:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B121BD7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:59:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d868842eda1so10617907276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761999; x=1696366799; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=w2Ft1LXAEmSLtC9q/HcLLlEk76TP801HJSIg3VEL3ncr98RNDUSNqCAXcOBcO6X4tI
         npSopTtiUAjNoIpCqSJySjDJgTjSXiAed4tM/2fxZClUbaRtzU+jj83GtGMxfi5NQD/B
         nMfjX2KjTH/FqCfssGStKhx2ON1a8h/DhSJJL4Pfel4W4QdY9DZE1KPYkaVxLZxv3Img
         Dpoyk2d38CYWak/iWz5zn4I+OPhdCxBIC69uUckjeof3dZvZTMRmEIA87MoySlRx+HMF
         5xHfGA22vpLsSbrWF6hxX6+73ONZGYgqaAvwuCbgNwE3dhrDCzo6hmbZAUJny3IdY6tu
         6tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761999; x=1696366799;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=Wj7TMuyfmgZyzJ7c2rMxo2Dn96PmWhnd3Js73X2b/QSd6NpGF+Pe9BVaduBnVF0zm7
         zcucaH8X1SdZqJL2/TR0GBUaHVfNLGHaxT4NM77TRJUvB9VS6sPlNEN8HzI+ZqZdVhhq
         6A7eoNKsOPEateLZDiqUvQDOotAUjjkylakR01f9wxjea4RlnGcu7e30E8x9KQffxL0Y
         Pl1Yz7JoIMQ7twjtr923L2LGq/Z56O715ireeeBsuvz90gZlhoOcfg66PgjReYdl3Gfb
         sVyCXH24+Evct9WMSlPOrmafol2iWT6qpAXG8jYxpwO4+RwpfYA3Ng1VWGgjUskDkFKq
         RRcQ==
X-Gm-Message-State: AOJu0YzRFtdRQ4wVen2hMS5dB7cjxJoi7Y5vJF+PnkdqkuJMxRLI2Vdi
        J3ZIa+ODX/hWBYyzyqQxJScEYjkUP4+9
X-Google-Smtp-Source: AGHT+IFZch+e7xyynHkKeoQ60ImjQAp+3ISkdHv20tIxWwLK1OAFPY5v8V2D4S6j74yS0I3sfetA/k16SO/x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8ff0:2e1:80b2:e4a])
 (user=irogers job=sendgmr) by 2002:a25:b0c:0:b0:d89:4382:6d14 with SMTP id
 12-20020a250b0c000000b00d8943826d14mr413ybl.6.1695761999020; Tue, 26 Sep 2023
 13:59:59 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:59:46 -0700
Message-Id: <20230926205948.1399594-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v2 1/3] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
isn't present and the broadwellx style cbox PMU should be used
instead. Fix the tma_info_system_dram_bw_use metric to use the server
metric rather than client.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/111

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 8fc62b8f667d..d0ef46c9bb61 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -652,7 +652,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@) / 1e6 / duration_time / 1e3",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e9 / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth, tma_sq_full"
-- 
2.42.0.515.g380fc7ccd1-goog

