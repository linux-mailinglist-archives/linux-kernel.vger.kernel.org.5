Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B459B78890C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbjHYNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbjHYNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:52:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E3D1BDB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:52:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so1128542276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692971571; x=1693576371;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dYhn8H+dXW3Ipl8n1VYVJEnCo8cNL6TIPVh5uinwXQ=;
        b=EHumlaJVyKkVBa9c0e20P0BWdp+1ernT6xK43PeNkHRWU8lqIeuZuQTQyVHAZyFyVq
         Pb0jP3mccWS/k9mvxMJO1jxjBVr+FZcbGVSFk0Hoccdp2tnzAxSzMYDbHRcoAud7TKDZ
         9zh/Dp6LrXj7vSSxEQOxMPqrF1bLvSn2wrV8qq+DxgXsiAtyKKJRuFkUpAz6w2IJdq6y
         afeA3h1TpfcfWPTlqY+k6AeKyUQ+l4bcr1k34PtsSwPi9L0n12xyn5yV9KFFilA6gaYT
         7wrZeH1jDEaripq6+87IKYI3N1AguLrCsgz+XW8Bj7laOPU3hTRxuOr4jX6capsWe5Y9
         UsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971571; x=1693576371;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dYhn8H+dXW3Ipl8n1VYVJEnCo8cNL6TIPVh5uinwXQ=;
        b=hbivUNLZrAG6rGy3nDYQSIwjCZGCyzXMnYz2Qr8eiCgQtJx4dzSzSu72zbEFB+/8A2
         IOZIJGapBnmDx9D6mqJ1PmUvcbKluTUoVvF/s1Yc5cqaVPt8yLgwKq8KYB1wbymi4BhS
         BjxGeLGj3N+j3Ps/bpBWuFRtVMEqLQwORkV8CLigXf3nqEEiQ+TBNVau7jyYp57I89uM
         MbcJ/jDD6W+xvUmx3ovBW8fxquB0y9WsNReeZjLD2AM/Q5ErxIn7SIUDp8BHFDlm/1A+
         s3a/+iOvrIJivjveYnxxCXoINKs2cXwJZ1/arbK8z8qmxQDvDpUaeNdc4wmLkYMgFIAx
         4uJg==
X-Gm-Message-State: AOJu0Yy9RFWhbugnDrxNZC//sVKTLZj96U/p1Htvmkei9vWXVqlNljzT
        +ZRfQ0ZC3dsp9Z2j/NoT5AY6kYvWll5N
X-Google-Smtp-Source: AGHT+IHvRqYILRSBMnoXywPyiF5I4pjA+sdKB05A8++FGoHLyxHqhOehETymctDBt2AGX3kLHoYuet9UDQ7E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a25:74c6:0:b0:d0c:c83b:94ed with SMTP id
 p189-20020a2574c6000000b00d0cc83b94edmr421918ybc.10.1692971570893; Fri, 25
 Aug 2023 06:52:50 -0700 (PDT)
Date:   Fri, 25 Aug 2023 06:52:37 -0700
In-Reply-To: <20230825135237.921058-1-irogers@google.com>
Message-Id: <20230825135237.921058-3-irogers@google.com>
Mime-Version: 1.0
References: <20230825135237.921058-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v5 2/2] perf pmus: Skip duplicate PMUs and don't print list
 suffix by default
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Add a PMUs scan that ignores duplicates. When there are multiple PMUs
that differ only by suffix, by default just list the first one and
skip all others. The scan routine checks that the PMU names match but
doesn't enforce that the numbers are consecutive as for some PMUs
there are gaps. If "-v" is passed to "perf list" then list all PMUs.

With the previous change duplicate PMUs are no longer printed but the
suffix of the first is printed. When duplicate PMUs are being skipped
avoid printing the suffix.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
...
$ perf list -v
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
...
```
Signed-off-by: Ian Rogers <irogers@google.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c         |  8 +++++
 tools/perf/util/pmu.c             | 17 +++++++---
 tools/perf/util/pmu.h             |  3 +-
 tools/perf/util/pmus.c            | 53 ++++++++++++++++++++++++++++---
 tools/perf/util/pmus.h            |  2 ++
 tools/perf/util/print-events.h    |  1 +
 tools/perf/util/s390-sample-raw.c |  3 +-
 7 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 7fec2cca759f..8fe4ddf02c14 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool default_skip_duplicate_pmus(void *ps)
+{
+	struct print_state *print_state = ps;
+
+	return !print_state->long_desc;
+}
+
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
@@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
 		.print_end = default_print_end,
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
+		.skip_duplicate_pmus = default_skip_duplicate_pmus,
 	};
 	const char *cputype = NULL;
 	const char *unit_name = NULL;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb2ca29cd7bd..b9ed829318c3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1576,7 +1576,9 @@ int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, p
 		.cb = cb,
 	};
 
-	return perf_pmu__for_each_event(pmu, &args, find_event_callback);
+	/* Sub-optimal, but function is only used by tests. */
+	return perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ false,
+					&args, find_event_callback);
 }
 
 static void perf_pmu__del_formats(struct list_head *formats)
@@ -1650,10 +1652,13 @@ static int sub_non_neg(int a, int b)
 }
 
 static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
-			  const struct perf_pmu_alias *alias)
+			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
 {
 	struct parse_events_term *term;
-	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
+	int pmu_name_len = skip_duplicate_pmus
+		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
+		: (int)strlen(pmu->name);
+	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &alias->terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
@@ -1675,7 +1680,8 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
-int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
+			     void *state, pmu_event_callback cb)
 {
 	char buf[1024];
 	struct perf_pmu_alias *event;
@@ -1694,7 +1700,8 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callba
 			info.name = event->name;
 			buf_used = 0;
 		} else {
-			info.name = format_alias(buf, sizeof(buf), pmu, event);
+			info.name = format_alias(buf, sizeof(buf), pmu, event,
+						 skip_duplicate_pmus);
 			if (pmu->is_core) {
 				info.alias = info.name;
 				info.name = event->name;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bae0de3ed7a5..b5c506f35b42 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -212,7 +212,8 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name);
 size_t perf_pmu__num_events(struct perf_pmu *pmu);
-int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
+			     void *state, pmu_event_callback cb);
 bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
 
 /**
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b1f6a64693fe..28909c9a32a1 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -35,7 +35,7 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
-static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+int pmu_name_len_no_suffix(const char *str, unsigned long *num)
 {
 	int orig_len, len;
 
@@ -275,6 +275,43 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+	int last_pmu_name_len = 0;
+	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
+
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/false);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	} else
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", NULL);
+
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+
+			if (last_pmu_name_len == pmu_name_len &&
+			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
+				continue;
+
+			return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+
+		if (last_pmu_name_len == pmu_name_len &&
+		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len))
+			continue;
+
+		return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -400,10 +437,17 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	int len;
 	struct sevent *aliases;
 	struct events_callback_state state;
+	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
+	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+
+	if (skip_duplicate_pmus)
+		scan_fn = perf_pmus__scan_skip_duplicates;
+	else
+		scan_fn = perf_pmus__scan;
 
 	pmu = NULL;
 	len = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL)
+	while ((pmu = scan_fn(pmu)) != NULL)
 		len += perf_pmu__num_events(pmu);
 
 	aliases = zalloc(sizeof(struct sevent) * len);
@@ -417,8 +461,9 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		.aliases_len = len,
 		.index = 0,
 	};
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		perf_pmu__for_each_event(pmu, &state, perf_pmus__print_pmu_events__callback);
+	while ((pmu = scan_fn(pmu)) != NULL) {
+		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
+					 perf_pmus__print_pmu_events__callback);
 	}
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (int j = 0; j < len; j++) {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index a21464432d0f..4c67153ac257 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,6 +5,8 @@
 struct perf_pmu;
 struct print_callbacks;
 
+int pmu_name_len_no_suffix(const char *str, unsigned long *num);
+
 void perf_pmus__destroy(void);
 
 struct perf_pmu *perf_pmus__find(const char *name);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d7fab411e75c..bf4290bef0cd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -26,6 +26,7 @@ struct print_callbacks {
 			const char *expr,
 			const char *threshold,
 			const char *unit);
+	bool (*skip_duplicate_pmus)(void *print_state);
 };
 
 /** Print all events, the default when no options are specified. */
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index dc1ed3e95d4d..115b16edb451 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -171,7 +171,8 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	if (!pmu)
 		return NULL;
 
-	perf_pmu__for_each_event(pmu, &data, get_counter_name_callback);
+	perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
+				 &data, get_counter_name_callback);
 	return data.result;
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

