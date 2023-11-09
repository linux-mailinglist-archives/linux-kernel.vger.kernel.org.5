Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F127E751E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKIX2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbjKIX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:28:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F3449A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:28:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so2113446276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699572497; x=1700177297; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=va9PeSVkHZ3/T3gfCQBJuJqD+iAYQCCoTm/PqSXEj/U=;
        b=CptAGb2xtYIbOhsnfnTT99k6LHTV8rf402VjZrN4Uzgmc7LgWrA02oPpVsb6JJWaIP
         zAwxTTNbMHtkiIYx07gsLHjdH90iw2p5N2B8GvbuvXkp0EprJaLSuIWpnStUtXUr1VaZ
         P2yQhOTxfO/mUFzD2q2K08IzP3UJx+UBwNrACpx/XAsLvFb9JGebZOYibmHu+fbPn9uU
         BnoQHDzBsBYgHovllDsmkQZVTL9IZNV/qvcFgy5hpKtVYVzLAJoejESZarggcZ97vA6V
         fRBfAGRwscJuOw7b23A1EaeEXg9OvOTVxWkt+HP5yTu1X5qZQFb4w2I3lPyNJ8Wjcevs
         i/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572497; x=1700177297;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=va9PeSVkHZ3/T3gfCQBJuJqD+iAYQCCoTm/PqSXEj/U=;
        b=TIY5dnQKvTyTnHAoLsd1D64UelIlskalkpN6eSwNUyxu+TyHEmBVxHTZVJYOxXcvOm
         p39i8KcREDU64qhROlAMpr2rpfdd6JBSblQHMeQixwzsgFczBZ8gQ04cdTBc7ip0kHvw
         9mMuC1FZRFGVfVy4mXsKOF3Q5g24Gd3ERafjkpIrXeotaFpyHurbdt0t5Z36+AkGbivZ
         ww73LaV6i6iyOyHmvNe5ugelrJT8jq7990pEQJ6Nc84UCdU95l7Ad5ixaxL5cZsrJyxV
         p26z6dcCnRIBnw7WwWEq4/6Z2bm1xL3+fxDAkPWTSjiHHLlRpqfEDqt5Edw7QsYUcLR8
         U8MA==
X-Gm-Message-State: AOJu0YyEML4bEAKy5bB6QR8Yq+fPUKC9tdmAr0Bmdn3hhiq9DF7IMgY6
        o9XnDWDnBm4ar24Z7vD6dN/tWz72/Phd
X-Google-Smtp-Source: AGHT+IGORyolPaDLwqvSKUqqw4W+HuVgJGBZQPOahnyRc3XRyRcCC27fSMmjbKSo4VVs17rwX2+VObQP5F1J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5f4b:1253:36b6:f990])
 (user=irogers job=sendgmr) by 2002:a25:80d4:0:b0:daf:1554:b89a with SMTP id
 c20-20020a2580d4000000b00daf1554b89amr23353ybm.2.1699572497553; Thu, 09 Nov
 2023 15:28:17 -0800 (PST)
Date:   Thu,  9 Nov 2023 15:27:32 -0800
Message-Id: <20231109232732.2973015-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v1] perf vendor events: Add skx, clx, icx and spr upi
 bandwidth metric
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add upi_data_receive_bw metric for skylakex, cascadelakex, icelakex
and sapphirerapids. The metric was added to perfmon metrics in:
https://github.com/intel/perfmon/pull/119

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 6 ++++++
 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json    | 6 ++++++
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json     | 6 ++++++
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json    | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 84c132af3dfa..8bc6c0707856 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1862,6 +1862,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index e98602c66707..71d78a7841ea 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -1846,6 +1846,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 06c6d67cb76b..e31a4aac9f20 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1964,6 +1964,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 4a8f8eeb7525..ec3aa5ef00a3 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1806,6 +1806,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
-- 
2.43.0.rc0.421.g78406f8d94-goog

