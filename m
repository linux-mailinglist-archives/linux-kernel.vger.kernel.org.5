Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC537FC467
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjK1TqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1TqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:46:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B819A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:46:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd573c2cccso1273187b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701200788; x=1701805588; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UTOP80w6oO59ioynFIZpUkq+H0Ur/HUQD/Hl4Lb3+fo=;
        b=DbhahV18jqpZxyjInbhmmGuKGlGjLA5z1U5MrdYNP8VtMYN8dF3Fv2hIgCpCXU79Dv
         Yz4lkea6zmOOhXH9CsZ/ZnyQl8SAdsolGqgZS59A1fU+GOwK7DLS1xg89uEr+pSGKYWE
         KEtKZcNa+2I2MRItgzgw8Ag3FiI1BcmkU4QcxMRbck/95iFQp2dDbPrdDe7rmWzdrWtm
         Lse+lo2Zx1nl7WAYGEJooVBKe/hJ1Wm0SOL7ncCyRZ1qIIgQT2zpTdMzLBesBtY4q5KK
         nrUBiYpDKX+Vlh1csvsOD7KjFMXK5qsEWBJDqMiHx2mhofu6UquByEkhE8TxNxfN8DzW
         YIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200788; x=1701805588;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTOP80w6oO59ioynFIZpUkq+H0Ur/HUQD/Hl4Lb3+fo=;
        b=IDJK6pLUPotSV9aFfKMhyILLquu2FcpeQuLwHv5vocOfAKJkPKywhHC7W0jrYuunQS
         vLzUawH/k4bU/R+W2Uyc2oa887a1EPd1Z3TMhOyOXE5pSngHu2J4HSLXRHXe09Ikkg6h
         vV8FiQZwJet8mFepu1Gg1fhaErmFN+4lJOsNdNJjgM2n+wp+tPP3rFwN9KoJlxS1k+X8
         Moj8tBbiyRXuP11zXyc3vFGrRrWd9VkIk7a2NI3vCwYKueyWW9deP9H89Q9gHzWXu+0y
         dwkDioIPr0Acc3KTkaSYCIJm1FGkc6q0rQWcP42bu40xyS0Y4CLIoQb2EP3IREWBIZDc
         ACPg==
X-Gm-Message-State: AOJu0Yw+BJf0PDwKeAFjDeTmL0aV4WMPjFDkPUcOltwQJ5wC2rHKD6ge
        WZzXEHs0PJB3VaGCcKMuDefjj/qb0KtR
X-Google-Smtp-Source: AGHT+IG3hnlUY9stfckcsSokuct8uB5ZoMSmtqqHO79OB5z62Y2t7aa6NOpQmwwM9Dw+gUzo2c4XxgLa4dpO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:254b:c025:1be9:f61e])
 (user=irogers job=sendgmr) by 2002:a05:690c:fd3:b0:5be:baac:54e4 with SMTP id
 dg19-20020a05690c0fd300b005bebaac54e4mr699860ywb.5.1701200788269; Tue, 28 Nov
 2023 11:46:28 -0800 (PST)
Date:   Tue, 28 Nov 2023 11:46:24 -0800
Message-Id: <20231128194624.1419260-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf tests: Make DSO tests a suite rather than individual
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
        Yang Jihong <yangjihong1@huawei.com>,
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

Make the DSO data tests a suite rather than individual so their output
is grouped.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  2 --
 tools/perf/tests/dso-data.c     | 15 ++++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 113e92119e1d..9c09e4681c3a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -62,8 +62,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__dso_data,
-	&suite__dso_data_cache,
-	&suite__dso_data_reopen,
 	&suite__perf_evsel__roundtrip_name_test,
 #ifdef HAVE_LIBTRACEEVENT
 	&suite__perf_evsel__tp_sched_test,
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index deaefcdd8f09..5286ae8bd2d7 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -393,6 +393,15 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
 	return 0;
 }
 
-DEFINE_SUITE("DSO data read", dso_data);
-DEFINE_SUITE("DSO data cache", dso_data_cache);
-DEFINE_SUITE("DSO data reopen", dso_data_reopen);
+
+static struct test_case tests__dso_data[] = {
+	TEST_CASE("read", dso_data),
+	TEST_CASE("cache", dso_data_cache),
+	TEST_CASE("reopen", dso_data_reopen),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__dso_data = {
+	.desc = "DSO data tests",
+	.test_cases = tests__dso_data,
+};
-- 
2.43.0.rc1.413.gea7ed67945-goog

