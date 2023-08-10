Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A67782D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHJVuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHJVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:50:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F3273E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:50:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d5d5617ecc9so1343091276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704211; x=1692309011;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=5FZtuCkOD8r22iOeIWwQ4EsKC5V9oacrymly9BvtQDx+idhZLiswyd2Pn4fM+Y5yJU
         gihlEkfRYcZf+1od12kgpm54yVKgJK7Kp02Fg5aaLqMXX4HvsMKCvC9IlLrzauKF1goE
         emh076z/YKK/fJ62QXpR2rkG+QMHC/RaiZgTwNg4RY+ds/iLPnai5viHHZlucQ04R5L3
         Ca1j1b//D1R+DowDCdlvDl6kX5Q4A0mIGMow6CEzNRF9TexLxzUgBNhUR7xvyfdU6aTS
         rGbfEVmw188O8OYF7SOCwkgYPg6oVMYJtDt2P1rHtBnpwWPtJuCbvsdr5+w6ydavhOoU
         S2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704211; x=1692309011;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nscFVL3MFrP2MCfpvE3b34w9xAwW74LjxwP+hgfykt8=;
        b=VGxmw8oHBZ4J7WRYmFv2zlkjtc6+r84sJMEl6oakWRbAWfOSZTFruG1eq/kjROMHfW
         yqZk2jDsY0Bj7w0NPeg+cConCi2S8uCl3JL51plI3b1qFoKUxGVhy1OryvcX3TpTrJ51
         vulXHua2Whh666h5xRQfjwsWs+M0WyRu3VEolAqCWvXIsk2KeLYcfhWeRljF1NG4ahIR
         Z0Yq2ki0BArshYS60sqK2+DffHEtTwARFDStI5Jd+YswbtBnbB8ofkWjiM6l45ufdUSm
         y3GuIt/l+lcoSHrHhFeFBN+UfhW3PUG+C6RCk/ID4OjuK8YoWF1pv42eLHEDhW/Rj0AS
         rILw==
X-Gm-Message-State: AOJu0YwWqAhc9IXjFdtR1wNF6jhVmMfYVYxSIZLEDk1kyJXhYUUuCzli
        cV8xp0VOyO8LBkjq4hOAnZflzF0Rz7VG
X-Google-Smtp-Source: AGHT+IFhhIft5gWXsXGy4semc/T7A1pqRtRHdrjo123kU3YRYq8kKu0kmsMFOr7Pr8tU4963zgfNzCg55EHG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:60d6:0:b0:d12:d6e4:a08d with SMTP id
 u205-20020a2560d6000000b00d12d6e4a08dmr51937ybb.7.1691704211412; Thu, 10 Aug
 2023 14:50:11 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:49:52 -0700
In-Reply-To: <20230810214952.2934029-1-irogers@google.com>
Message-Id: <20230810214952.2934029-4-irogers@google.com>
Mime-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v2 3/3] perf pmus: Don't print duplicate PMU suffix in list by default
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

