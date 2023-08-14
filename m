Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489177BE33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjHNQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjHNQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76438BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:38:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c4d30c349so6110327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031089; x=1692635889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=U9uMvD45gGusaDttinkNdE3G1frqMqeAZgoBEl4kO4UpMSWz4uWQkmm43ItG1zVAvH
         fuLK6gjRAPwOQOV4fZgW/QRxRBwKlmOC5QrTISPScN/qBXuZRy6dNElCLDQUtWlKfThS
         PZylvUlNMqaxUD75Q2ifyLOkbO7VD7UdgS5ttzVfVu1FZEW0XHuPythKS8iw5BBzTJih
         rJvoYUF/cLxCyfnI+My/Gd+IGoVDih7slULOv4pud4S3f1Omp1bDGhiXSUn9wdzr62lO
         bCxa+t8ZVLf/TlGEn0RFe4eWcb5VK619rNI6hdDdov0SFBQ0T571QEwEQVLzdOYUdY3v
         lbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031089; x=1692635889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=lTBSIbwapO7fIbHRomUgHEkNBeMfaGO5juLw6OQee4VG8iJbcbAEFK2ZLB9w1+gsAW
         oOshmaUqqSDE7OrqLzoBoDgztQpoZVZ05o1ep+I8rlElsnc3LGevQplW+y4jD1d3UHif
         HfCAwi8VFyN3FUKWUr16rkwNj0lD1DaB4yUnx2WlbUkN5dvPueQEj/TYCH5aKw2PyurQ
         VnJ+jFQol4l6QE45RSThFKt9P2xnv3bm5yMqbNvwuk9CSv0jXD+RrseyTREoyscz9V6d
         VrlWKBEXAkqP7qnm2us2zEw8HhEKJPEThhCu24z2uT+mmMqft7lONgS3PSq+6rOfTC6+
         w/iA==
X-Gm-Message-State: AOJu0YzinJlarDbL03zurAJfa0RwDO3okQ2nQ0Y7yhRjZ0qMoVP/AjvD
        d89spDHeOWDflBiF9EgzvHA2Tene+DWc
X-Google-Smtp-Source: AGHT+IGILuj3oJi0XcEflNpwgbZiMygoIL9Z0oYEluFBltIoEdxznvbSgnXaL7yKzRFf5SLq8mw8deBFfqrB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a919:6125:510f:f0ef])
 (user=irogers job=sendgmr) by 2002:a81:441f:0:b0:589:a5c6:4a8e with SMTP id
 r31-20020a81441f000000b00589a5c64a8emr146149ywa.1.1692031089732; Mon, 14 Aug
 2023 09:38:09 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:57 -0700
In-Reply-To: <20230814163757.3077138-1-irogers@google.com>
Message-Id: <20230814163757.3077138-4-irogers@google.com>
Mime-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v3 3/3] perf pmus: Don't print duplicate PMU suffix in list by default
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicate PMUs are no longer printed by default but the suffix of the
first is printed. When duplicate PMUs are being skipped avoid printing
the suffix.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
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
 tools/perf/util/pmus.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5073843aca19..b0ecb2e5bdcc 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -440,10 +440,13 @@ static int sub_non_neg(int a, int b)
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
@@ -473,9 +476,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	int printed = 0;
 	int len, j;
 	struct sevent *aliases;
+	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
 	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
 
-	if (print_cb->skip_duplicate_pmus(print_state))
+	if (skip_duplicate_pmus)
 		scan_fn = perf_pmus__scan_skip_duplicates;
 	else
 		scan_fn = perf_pmus__scan;
@@ -518,6 +522,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			*desc = NULL, *long_desc = NULL,
 			*encoding_desc = NULL, *topic = NULL,
 			*pmu_name = NULL;
+		int pmu_name_len;
 		bool deprecated = false;
 		size_t buf_used;
 
@@ -528,7 +533,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		if (!aliases[j].event) {
 			/* A selectable event. */
 			pmu_name = aliases[j].pmu->name;
-			buf_used = snprintf(buf, sizeof(buf), "%s//", pmu_name) + 1;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
+			buf_used = snprintf(buf, sizeof(buf), "%.*s//", pmu_name_len, pmu_name) + 1;
 			name = buf;
 		} else {
 			if (aliases[j].event->desc) {
@@ -536,7 +542,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				buf_used = 0;
 			} else {
 				name = format_alias(buf, sizeof(buf), aliases[j].pmu,
-						    aliases[j].event);
+						    aliases[j].event, skip_duplicate_pmus);
 				if (aliases[j].is_cpu) {
 					alias = name;
 					name = aliases[j].event->name;
@@ -554,8 +560,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			long_desc = aliases[j].event->long_desc;
 			topic = aliases[j].event->topic;
 			encoding_desc = buf + buf_used;
+			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
 			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-					"%s/%s/", pmu_name, aliases[j].event->str) + 1;
+					"%.*s/%s/", pmu_name_len, pmu_name,
+					aliases[j].event->str) + 1;
 			deprecated = aliases[j].event->deprecated;
 		}
 		print_cb->print_event(print_state,
-- 
2.41.0.640.ga95def55d0-goog

