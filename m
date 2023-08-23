Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59D78528F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjHWISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjHWIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF881712
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cf42a3313so68004117b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778147; x=1693382947;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BhHz8yEC3pLTHC5QxPQtooiXn41z8hQeFyuHW+faxU=;
        b=HU8CMnAAS/RziILAg1+V2MuiV7wt756cyZBZvpvQQBvwc4jKJgrWKYRZHwYUZSMSAo
         NmxcfyQGcfrwMnDoxtigjRv7aJi2XO1CuPwiPoAuIG+fJbvYpKHxRGRjoViIi4S86uqN
         NrBpUPbak9vXU12UBuWxSRiLArx0Dr+yaZ4TXr8ovBXdGTkcYVk3Rq4ozIfLAmkjnyJ0
         R7RyTiXoci56hBq7QoUaHY6E3iVJwo8XVU8TxCN6zTurtsHZ03IuSaZpsZpXiC5fiO8g
         2x2dCBXG0IcrqxVC7m/ScNLEo7Ax2EajwvjNAtI2cDV3txn8b8Jhr9d2mDfXaNcbTw9N
         cJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778147; x=1693382947;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BhHz8yEC3pLTHC5QxPQtooiXn41z8hQeFyuHW+faxU=;
        b=DVYTcb+AlGYsbi4K6zVYDVxbvSpBJ/7AmbAJlul2M3n6ec5pCadyueecEQygcQnqtW
         lbX0Xum9UNPomuvMcHq4zeSkMWKq1IfEA9Bq0Z62bFM5yZyAndCbHDnpDOgCPemoP3n5
         7nYUXH3VZ/F+nLbMYWLyU2pfDLf8st2v4smrhJ7EGFZhyI71B6QupqYd8L0KQWPkHuH3
         ZnLZeBjDXixovoZvnK6jzPx4eRCD/26pWw5t5LejurSZsoh4C1ZgwL30uUi4ejykBUZN
         qnlW35GiuDhlZFqwI2UsBjnvnoDaL7+OpfqEqQQzRw1cBsKrU1z4Cj5B2IG6a1tNJ2tL
         wKBA==
X-Gm-Message-State: AOJu0Yxky7EuTCJblIVaDSzuPUkbLqe5wv6cgNqbXsjEQv3uw3FO9lsy
        vXyJ7MpCLJqBP+N9MDCSxdXHgMTNZikd
X-Google-Smtp-Source: AGHT+IHvEGLSuiJK2HNeck85ZiiHP2D3xStux0XexeC+vrw08E08DpocMMf1g+zZgw+G5QzS6QJtJ0hHQQFS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:af0e:0:b0:58c:6ddd:d27c with SMTP id
 n14-20020a81af0e000000b0058c6dddd27cmr154296ywh.6.1692778147209; Wed, 23 Aug
 2023 01:09:07 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:17 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-15-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 14/25] perf s390 s390_cpumcfdg_dump: Don't scan all PMUs
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Rather than scanning all PMUs for a counter name, scan the PMU
associated with the evsel of the sample. This is done to remove a
dependence on pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 50 ++++++++++++++++---------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 91330c874170..dc1ed3e95d4d 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -27,7 +27,7 @@
 #include "color.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
-#include "pmu-events/pmu-events.h"
+#include "util/pmu.h"
 #include "util/sample.h"
 
 static size_t ctrset_size(struct cf_ctrset_entry *set)
@@ -132,56 +132,57 @@ static int get_counterset_start(int setnr)
 
 struct get_counter_name_data {
 	int wanted;
-	const char *result;
+	char *result;
 };
 
-static int get_counter_name_callback(const struct pmu_event *evp,
-				     const struct pmu_events_table *table __maybe_unused,
-				     void *vdata)
+static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
 {
 	struct get_counter_name_data *data = vdata;
 	int rc, event_nr;
+	const char *event_str;
 
-	if (evp->name == NULL || evp->event == NULL)
+	if (info->str == NULL)
 		return 0;
-	rc = sscanf(evp->event, "event=%x", &event_nr);
+
+	event_str = strstr(info->str, "event=");
+	if (!event_str)
+		return 0;
+
+	rc = sscanf(event_str, "event=%x", &event_nr);
 	if (rc == 1 && event_nr == data->wanted) {
-		data->result = evp->name;
+		data->result = strdup(info->name);
 		return 1; /* Terminate the search. */
 	}
 	return 0;
 }
 
-/* Scan the PMU table and extract the logical name of a counter from the
- * PMU events table. Input is the counter set and counter number with in the
- * set. Construct the event number and use this as key. If they match return
- * the name of this counter.
+/* Scan the PMU and extract the logical name of a counter from the event. Input
+ * is the counter set and counter number with in the set. Construct the event
+ * number and use this as key. If they match return the name of this counter.
  * If no match is found a NULL pointer is returned.
  */
-static const char *get_counter_name(int set, int nr, const struct pmu_events_table *table)
+static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 {
 	struct get_counter_name_data data = {
 		.wanted = get_counterset_start(set) + nr,
 		.result = NULL,
 	};
 
-	if (!table)
+	if (!pmu)
 		return NULL;
 
-	pmu_events_table__for_each_event(table, get_counter_name_callback, &data);
+	perf_pmu__for_each_event(pmu, &data, get_counter_name_callback);
 	return data.result;
 }
 
-static void s390_cpumcfdg_dump(struct perf_sample *sample)
+static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 {
 	size_t i, len = sample->raw_size, offset = 0;
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
-	const struct pmu_events_table *table;
 	u64 *p;
 
-	table = pmu_events_table__find();
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 
@@ -199,11 +200,12 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
 			      " Counters:%d\n", offset, ce.set, ce.ctr);
 		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
-			const char *ev_name = get_counter_name(ce.set, i, table);
+			char *ev_name = get_counter_name(ce.set, i, pmu);
 
 			color_fprintf(stdout, color,
 				      "\tCounter:%03d %s Value:%#018lx\n", i,
 				      ev_name ?: "<unknown>", be64_to_cpu(*p));
+			free(ev_name);
 		}
 		offset += ctrset_size(&ce);
 	}
@@ -216,14 +218,14 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
  */
 void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
 {
-	struct evsel *ev_bc000;
+	struct evsel *evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
-	ev_bc000 = evlist__event2evsel(evlist, event);
-	if (ev_bc000 == NULL ||
-	    ev_bc000->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
+	evsel = evlist__event2evsel(evlist, event);
+	if (evsel == NULL ||
+	    evsel->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
 		return;
 
 	/* Display raw data on screen */
@@ -231,5 +233,5 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, str
 		pr_err("Invalid counter set data encountered\n");
 		return;
 	}
-	s390_cpumcfdg_dump(sample);
+	s390_cpumcfdg_dump(evsel->pmu, sample);
 }
-- 
2.42.0.rc1.204.g551eb34607-goog

