Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A887FCEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377071AbjK2GCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377003AbjK2GCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:34 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADE1BCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd6a86a898so78448357b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237754; x=1701842554; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgvVWlesLuugbgRkTEvAvehfG8qq5p36CQo20xvLh64=;
        b=plg/BvyHeIdYw5/sTw/8O42pXvNpBZZ4xtGoLVCUiJ8muIkzDqGuBwIo95BlhMoKFP
         o/i3w6YTXdOnDTxRV/0RqWsZm1doL2DbJnJXxvjhVN/rkqy9j/FB0qds3WgYZ0wiJc9+
         36Q3FUJIMVZZuyaEvBd9T7YM8nNaFu2wip6TbRFCM5lMKpmKvaXmqL3sC9eyM31/ZNXw
         +PcvoJJDV/r6HB4n4V+Ubndu0hujzHDUnucFIp5H5nrcPARH7K1Jtk0lj4a21xEvx1Ta
         RcaIkHQqNrN3/RXdXd9fGyBYU3vaYlv6IF7qSr455Iq6b52U/Kbdhr2FPs0Dn/BXru3E
         JrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237754; x=1701842554;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgvVWlesLuugbgRkTEvAvehfG8qq5p36CQo20xvLh64=;
        b=d3s9on4NjZ+coVOYnBOJHcaA7leHr5f13j6USKVzO/7LG1WbUAwXb8RuqApQ0HMXHc
         zfj50Bk2hsPRPj1LBliThBoQo00khLb5A5bECEj96AlpxCk27xxQDA4v1Uy2OFB0wEkN
         SsX/THuPXzy8DSJnk9sXymddjCNBbIxl+0LyYHozqA5VqBf12uRqzLAziWBXy1Kl0WM0
         W7oUmDF1S140Wb2XWTv/FjP/l2qvDa7B3gyMGWvVC6TuabreOPL1hAw7ES56t1oTFthH
         WlUk4aXZHWfyHyTiIObWgeT+R7gFdTyKb7GrvXOpYYy6oa7B5SObVe4Ew/8e6rmE3tNU
         JS7g==
X-Gm-Message-State: AOJu0Yyt/LtECP75XfojejoL20B/neFFxdhGofHHZVHKwcL+88zlpj2q
        /KUg4BJhlu+8fDGD6pw32TrHg0df89tx
X-Google-Smtp-Source: AGHT+IHNr4ejdtETuIXhfF0YTzQe2IWwh7lZHWr7MqF4UN0ZlhfgRrJfjgfRl1a5b9HrVLvNyeXWn4aGPi+3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e10:b0:5cc:20a1:90e4 with SMTP
 id et16-20020a05690c2e1000b005cc20a190e4mr530191ywb.6.1701237753930; Tue, 28
 Nov 2023 22:02:33 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:05 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-9-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 08/14] perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
 use
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

Switch perf_cpu_map__has_any_cpu_or_is_empty to
perf_cpu_map__is_any_cpu_or_is_empty as a CPU map may contain CPUs as
well as the dummy event and perf_cpu_map__is_any_cpu_or_is_empty is a
more correct alternative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-bts.c |  4 ++--
 tools/perf/arch/x86/util/intel-pt.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index af8ae4647585..34696f3d3d5d 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -143,7 +143,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
-	if (opts->full_auxtrace && !perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (opts->full_auxtrace && !perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
 		return -EINVAL;
 	}
@@ -224,7 +224,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d199619df3ab..6de7e2d21075 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -369,7 +369,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
+	per_cpu_mmaps = !perf_cpu_map__is_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
 
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
@@ -774,7 +774,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (have_timing_info && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !record_opts__no_switch_events(opts)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
@@ -832,7 +832,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
@@ -858,7 +858,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			tracking_evsel->immediate = true;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 			evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
 			evsel__set_sample_bit(tracking_evsel, CPU);
@@ -870,7 +870,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Warn the user when we do not have enough information to decode i.e.
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
-	if (!ptr->have_sched_switch && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (!ptr->have_sched_switch && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !target__none(&opts->target) &&
 	    !intel_pt_evsel->core.attr.exclude_user)
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
-- 
2.43.0.rc1.413.gea7ed67945-goog

