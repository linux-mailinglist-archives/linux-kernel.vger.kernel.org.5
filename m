Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB05787B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjHXW1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjHXW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:27:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EBA1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5925fb6087bso4701977b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916044; x=1693520844;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsGJ9pkJpx1hk+C6giH/EfxO6XgKszScHPOUBP87Wvw=;
        b=2ZZnG63SDAPkUMfvbHyzPCOEzE2PNnT1Tb2pBjBJRZwouEsM7YnQfdNhP5EEcsE5Nn
         A7DbUygbMxX2NvU+aq5t9QkfSXum2Yhap/nBm8Uw9NeeD6H1F3c/WIGxje26V7LbGDeK
         +o7w5OSYZJrVmDSljaPw86OQYaEtxQnXEQpxgtZ3u+0u4LZEp28QQeFn+0am8xMX3gxv
         +Bo0rzST/6HqC2my1gtpZ9yz5RrzsNx8VrHDtP3nNTX0sgjhvBNg8vM4duwmH7IyEYbp
         sWlFR66cJjaqNCz8d/vFszWm0s1MuZp058qzrk4EGrKpKlBGmv/IKLE6TpVnhbDqlM34
         r5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916044; x=1693520844;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsGJ9pkJpx1hk+C6giH/EfxO6XgKszScHPOUBP87Wvw=;
        b=TBkvyNX5nFV7Z7JCwW5nNwPvPsYndOOlY4Uh9grFVyqDc6Vqt4kIQAwxOFIIPpehDo
         +IGvIMUqwjc1lypPjRhVA/PqbI/J8urW7U0HT4T+7XpMwyiXM9enFMUAkend1bmM4KWJ
         O9S/BGiIvNTiQfL3Zqwz8zeao0+roBoMFo5TN7KfKf9UX4D3gkHjM1FXQi2/1a0FOFVX
         uz8Zg3NcsIY40itjbyx2FMQzxBuGvPNkRvaHlfr+sVH+R4Dv1GOMUX/++PsU3HlRJqzl
         iTQ4fwEQKPlk7tL+n7tB/hl+G5FiWnQfCy49Eom9GnsEchE1z+a4FqZhDw/0z4+wfDqw
         1DBQ==
X-Gm-Message-State: AOJu0Yz4EVzOld240Sya/bMHL7Hl51Qx87m3AT/dqz2iyWq2XfvjLxQm
        jcGvOf6H4P7G5ZlzXqhHCf385NZ6q7Xz
X-Google-Smtp-Source: AGHT+IFAgs7eB/hOEvRyPzuYs7Ga70ODy5BsvZT3Fqs1up7wbr4SIWVBJ1BYtG6ErbOwFCDqe5d27wIKHVVA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a25:ce14:0:b0:c15:cbd1:60da with SMTP id
 x20-20020a25ce14000000b00c15cbd160damr258473ybe.6.1692916043957; Thu, 24 Aug
 2023 15:27:23 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:27:16 -0700
In-Reply-To: <20230824222716.553982-1-irogers@google.com>
Message-Id: <20230824222716.553982-3-irogers@google.com>
Mime-Version: 1.0
References: <20230824222716.553982-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v4 2/2] perf pmus: Skip duplicate PMUs and don't print list
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a PMUs scan that ignores duplicates. When there are multiple PMUs
that differ only by suffix, by default just list the first one and
skip all others. As the PMUs are sorted, the scan routine checks that
the PMU names match and the numbers are consecutive. If "-v" is passed
to "perf list" then list all PMUs.

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
---
 tools/perf/builtin-list.c         |  8 +++++
 tools/perf/util/pmu.c             | 17 +++++++---
 tools/perf/util/pmu.h             |  3 +-
 tools/perf/util/pmus.c            | 56 ++++++++++++++++++++++++++++---
 tools/perf/util/pmus.h            |  2 ++
 tools/perf/util/print-events.h    |  1 +
 tools/perf/util/s390-sample-raw.c |  3 +-
 7 files changed, 79 insertions(+), 11 deletions(-)

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
index b1f6a64693fe..9a748599e4cf 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -35,7 +35,7 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
-static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+int pmu_name_len_no_suffix(const char *str, unsigned long *num)
 {
 	int orig_len, len;
 
@@ -275,6 +275,46 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+	int last_pmu_name_len = 0;
+	unsigned long last_pmu_num = 0;
+	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
+
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/false);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	} else
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
+
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+
+			if (last_pmu_name_len == pmu_name_len &&
+			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+				last_pmu_num++;
+				continue;
+			}
+			return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", /*num=*/NULL);
+
+		if (last_pmu_name_len == pmu_name_len &&
+		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+			last_pmu_num++;
+			continue;
+		}
+		return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -400,10 +440,17 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
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
@@ -417,8 +464,9 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
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

