Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE57FCEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377052AbjK2GCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjK2GCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BBC1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cfd2325a06so51905597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237751; x=1701842551; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fls1hKYyOHnf3/bDsf3iPKJd0wwxSBN0A5pCMLik0gc=;
        b=3wDaubImVNAsdlj/q51pC/fauMjUFw9sRFujTynC/0lClwFFa7FPFXiBIiOR7bo0WY
         sm+0sHLTCRrT9lS/iejuJ/xVbu5p7iMsXcrTxX7vp4OfhbNP/UOJLRfaFvP6N6qgi7ax
         wWh2ERc+EDgS9gsmgtQYkuzRoDnKqdI+NPUM2dTQD3c8Oxb1JOy6g7ga3/6BWkWQieYJ
         eh7HHarWCXEgS6B4hlaBdCMPNF70x5m8t2IDEUB0mgn/VLMqspXQ2wTRiEeZqQE9dnOz
         Cxv6gxydrZR1Amo/xgnmaFSxPHoZUHKqZhIw3aUznfaRn+CAowGp3i4jGUIZtaIyPguv
         Vs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237751; x=1701842551;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fls1hKYyOHnf3/bDsf3iPKJd0wwxSBN0A5pCMLik0gc=;
        b=L3v6UhwrSuDuK+Q1yHu6cHs34LjEiNFKXwYQc2P3SlG5Nin+RjCSWGl+T/g+DjyDsN
         EDCUQ8N1YRdmiDKGdulKKo3Gbe5Xfq7wOENW24Z1J4Z4QG5n7ySQ06lRoBeY2pnaiBN6
         CjC0rL69Sna3tmgE3FFouzLbP/XVk3V7dhsEdzLSo5T5dvYFrBrDthucxWdiRDqss7iW
         sf7gIvz5PQmpZrhfYnYsWcwjuxv9aQoRG8cLDAevG5e3ef/eUC/CD9xMhsKPLyrmYSsX
         8//41c1fdUDBHl5XXpafQT1ITJJutgzmm2t8O+7Usm0o3qwDCjtCdRcNni5jtma3ZgyA
         dyOA==
X-Gm-Message-State: AOJu0YyMi2mcE/kJQF0pMQRYNipFCnLoYkzcBDP2rF/gZLog/fKe4VjX
        9gZuA0UdKOVGYll4geGjnU32Zi8d8rc3
X-Google-Smtp-Source: AGHT+IE+lyuX8dfYIgqcySLvvqClEvuXw1syxnF2VGdznLlQKEF0kdQlIAQFG3Eq5mP6kXDREMLbGDtcMcML
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:470e:b0:5cb:d80c:3d34 with SMTP
 id gz14-20020a05690c470e00b005cbd80c3d34mr370105ywb.8.1701237751669; Tue, 28
 Nov 2023 22:02:31 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:04 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-8-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 07/14] perf arm-spe/cs-etm: Directly iterate CPU maps
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than iterate all CPUs and see if they are in CPU maps, directly
iterate the CPU map. Similarly make use of the intersect
function. Switch perf_cpu_map__has_any_cpu_or_is_empty to more
appropriate alternatives.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 77 ++++++++++++----------------
 tools/perf/arch/arm64/util/arm-spe.c |  4 +-
 2 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 77e6663c1703..a68a72f2f668 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -197,38 +197,32 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
 static int cs_etm_validate_config(struct auxtrace_record *itr,
 				  struct evsel *evsel)
 {
-	int i, err = -EINVAL;
+	int idx, err = -EINVAL;
 	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
+	struct perf_cpu_map *intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
+	struct perf_cpu cpu;
 
-	/* Set option of each CPU we have */
-	for (i = 0; i < cpu__max_cpu().cpu; i++) {
-		struct perf_cpu cpu = { .cpu = i, };
-
-		/*
-		 * In per-cpu case, do the validation for CPUs to work with.
-		 * In per-thread case, the CPU map is empty.  Since the traced
-		 * program can run on any CPUs in this case, thus don't skip
-		 * validation.
-		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus) &&
-		    !perf_cpu_map__has(event_cpus, cpu))
-			continue;
-
-		if (!perf_cpu_map__has(online_cpus, cpu))
-			continue;
+	perf_cpu_map__put(online_cpus);
 
-		err = cs_etm_validate_context_id(itr, evsel, i);
+	/*
+	 * Set option of each CPU we have. In per-cpu case, do the validation
+	 * for CPUs to work with.  In per-thread case, the CPU map is empty.
+	 * Since the traced program can run on any CPUs in this case, thus don't
+	 * skip validation.
+	 */
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
+		err = cs_etm_validate_context_id(itr, evsel, cpu.cpu);
 		if (err)
 			goto out;
-		err = cs_etm_validate_timestamp(itr, evsel, i);
+		err = cs_etm_validate_timestamp(itr, evsel, idx);
 		if (err)
 			goto out;
 	}
 
 	err = 0;
 out:
-	perf_cpu_map__put(online_cpus);
+	perf_cpu_map__put(intersect_cpus);
 	return err;
 }
 
@@ -435,7 +429,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
 					   "timestamp", 1);
 		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
@@ -461,7 +455,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 		evsel__set_sample_bit(evsel, TIME);
 
 	err = cs_etm_validate_config(itr, cs_etm_evsel);
@@ -533,38 +527,32 @@ static size_t
 cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		      struct evlist *evlist __maybe_unused)
 {
-	int i;
+	int idx;
 	int etmv3 = 0, etmv4 = 0, ete = 0;
 	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
+	struct perf_cpu cpu;
 
 	/* cpu map is not empty, we have specific CPUs to work with */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
-		for (i = 0; i < cpu__max_cpu().cpu; i++) {
-			struct perf_cpu cpu = { .cpu = i, };
-
-			if (!perf_cpu_map__has(event_cpus, cpu) ||
-			    !perf_cpu_map__has(online_cpus, cpu))
-				continue;
+	if (!perf_cpu_map__is_empty(event_cpus)) {
+		struct perf_cpu_map *intersect_cpus =
+			perf_cpu_map__intersect(event_cpus, online_cpus);
 
-			if (cs_etm_is_ete(itr, i))
+		perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
+			if (cs_etm_is_ete(itr, cpu.cpu))
 				ete++;
-			else if (cs_etm_is_etmv4(itr, i))
+			else if (cs_etm_is_etmv4(itr, cpu.cpu))
 				etmv4++;
 			else
 				etmv3++;
 		}
+		perf_cpu_map__put(intersect_cpus);
 	} else {
 		/* get configuration for all CPUs in the system */
-		for (i = 0; i < cpu__max_cpu().cpu; i++) {
-			struct perf_cpu cpu = { .cpu = i, };
-
-			if (!perf_cpu_map__has(online_cpus, cpu))
-				continue;
-
-			if (cs_etm_is_ete(itr, i))
+		perf_cpu_map__for_each_cpu(cpu, idx, online_cpus) {
+			if (cs_etm_is_ete(itr, cpu.cpu))
 				ete++;
-			else if (cs_etm_is_etmv4(itr, i))
+			else if (cs_etm_is_etmv4(itr, cpu.cpu))
 				etmv4++;
 			else
 				etmv3++;
@@ -814,15 +802,14 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 		return -EINVAL;
 
 	/* If the cpu_map is empty all online CPUs are involved */
-	if (perf_cpu_map__has_any_cpu_or_is_empty(event_cpus)) {
+	if (perf_cpu_map__is_empty(event_cpus)) {
 		cpu_map = online_cpus;
 	} else {
 		/* Make sure all specified CPUs are online */
-		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
-			struct perf_cpu cpu = { .cpu = i, };
+		struct perf_cpu cpu;
 
-			if (perf_cpu_map__has(event_cpus, cpu) &&
-			    !perf_cpu_map__has(online_cpus, cpu))
+		perf_cpu_map__for_each_cpu(cpu, i, event_cpus) {
+			if (!perf_cpu_map__has(online_cpus, cpu))
 				return -EINVAL;
 		}
 
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 51ccbfd3d246..0b52e67edb3b 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -232,7 +232,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	 * In the case of per-cpu mmaps, sample CPU for AUX event;
 	 * also enable the timestamp tracing for samples correlation.
 	 */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_sample_bit(arm_spe_evsel, CPU);
 		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
 					   "ts_enable", 1);
@@ -265,7 +265,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	tracking_evsel->core.attr.sample_period = 1;
 
 	/* In per-cpu case, always need the time of mmap events etc */
-	if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		evsel__set_sample_bit(tracking_evsel, TIME);
 		evsel__set_sample_bit(tracking_evsel, CPU);
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

