Return-Path: <linux-kernel+bounces-47610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9E845038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324511F241D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017BA3F8C7;
	Thu,  1 Feb 2024 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziVY/e2+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA03CF6D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761378; cv=none; b=O/8BoMMg04g04+ooHWwIaqRcXk7BDAWPx+/MoxRhki6tXS2U70yKXrN4voCxM9nMfl8BFeQUjzB6BqgZnwPOS/MsriDS8Tdja3Cb0OMO5wVrq7w3nOTLMqVCi+NID0RmX8jbOompN8hKXFei/llcHWswncOAbNgTrNCPfodhZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761378; c=relaxed/simple;
	bh=kOaO6z2IMzg1r/MyGUpkXjIYsEpcI0zfWB2ic7bf2Xs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=b8aERM3QXGSjvKL484tQ+h38RoPThyZ6N1Wr0c8Cn4onpcbNIZMW8STWBqpkQy3duAayhmziSJerjY0x8dt2CudKOWZt1RGCg0dA9XHaq5F83dWT/wHp+kafVeIt95eehbqDo9oApvXgTZDm633lUdtZkkg2vyoMTnSqi8L3DSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziVY/e2+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c2643a07so901877276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761376; x=1707366176; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpPU/P9Rw6DdLv5FLhNPDNExyhurg221RAp9ZKk92ek=;
        b=ziVY/e2+cJiy9QxzXqS/oYiCR2TU3lt13bOhdazyiGC8Sj5NiU1FHpKgGbleB3KWP7
         rIAxlFv1GGlAOdImfqefbhLuX951KWFy0HN84o1A0rQUKcIwPyR5IWWu28tOH84cWXuP
         9Nh4qLBtzzksNd+i3rxKfdxVVJL6sRRXRGPBMTEy98MgJMP9twIJvlEGBxDIiX+Tcu/V
         jt1eG835NoyNIhMfb3u6Cj2eDEQECpag8W/dqEUu/6MW/Mxh59OyADnfDtbLKt3OibbE
         uUQeCkGsuyfflmkQhS5ci3vqjCdZqzP9kikn41+55Wrpp+aLTQ9qt0O0e7PCa0//nIHS
         ahiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761376; x=1707366176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpPU/P9Rw6DdLv5FLhNPDNExyhurg221RAp9ZKk92ek=;
        b=CQf0WuOIxUtQPN4MTDNBL9Kfmk508gvYtBQafgfuP82Y4c8T4TA0W3UVo8+o10fFR7
         tTqxl80I7s4AL3oHOO8HrMvyp6H/zgYOUxjLaZ+mkCG4ocKBz10FZnIMpg0yoWGqhkUP
         wqcYzJ6cNOJnanCvjxfgXKk0IVGDOKNkjyuEML0r9NaLGj0gWdbdneTCcFDr5ZolGl25
         IPbuKEIU1uyeoZFJA4oYawQj4rsBfoqOK/diGeiYerRJJUgFDUL+OLFPlIMuo1MhbXBJ
         jYsNhl+8UMkFdSjOl1w51r1kNVCKCN8r93zTzqOAapgtuGY3BiKh2gazbrCj5hVT2eO2
         5Cxw==
X-Gm-Message-State: AOJu0YxnvOKTqdkef6ngLfyuUCtJ2TfNPqMdtEbIJZ1itH4B/lR/9w6g
	myB7AN2fHUquAsD94vSD/qQSntSHTi5FKnjReQsUyWavOooVCIlpVcKp/IwHe4irrkRSCLYA1d+
	stDiuSw==
X-Google-Smtp-Source: AGHT+IE8wymZahqqeemlY1iaO6CqbNktaK+r6W2Pm1C/Yfoy9QDR7o8EnoDQ7a0APQKk/WVTZRZ/UDTr08z0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:6902:e0c:b0:dc2:1f3b:abdd with SMTP id
 df12-20020a0569020e0c00b00dc21f3babddmr954876ybb.5.1706761376013; Wed, 31 Jan
 2024 20:22:56 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:31 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 3/8] perf arm-spe/cs-etm: Directly iterate CPU maps
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
index 77e6663c1703..f4378ba0b8d6 100644
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
+		err = cs_etm_validate_timestamp(itr, evsel, cpu.cpu);
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
2.43.0.429.g432eaa2c6b-goog


