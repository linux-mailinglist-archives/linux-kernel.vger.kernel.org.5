Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DE7C754B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379623AbjJLR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379684AbjJLR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:57:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190A10C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bbe0a453so19335607b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133426; x=1697738226; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1x8BoWM8O8RCmIFn2DnLVwCXAu7C3bqwpGV//v0QwM=;
        b=lREfPG5kPxl/QmmS3DthGrLvgUjKAU4GS1B3qOFipVomvdsiXOhuNTQl1W1VJMrAX9
         62O/r8sOp7ZUfTCU33aH0COFnxJq9guXZjSCIR1y0RF9I3cZgez5iwqrM8N1ZEBTqLNi
         zpy5D5qmd9XmBzxU97+WSPXOpt8pIyhUC1OYOGyHBvXbAqTa8uRQCL6cwY/JpKfzA8JD
         0GCGWhu4YVtrZLOi7X41dRPOC72vWFNhMzUC/qK29ZAQ79BjDvVG9ND5BxGMhwlapq0j
         VGccbYx1xLjl7uYezM4Ipp+JP0Fber7c7StQT0VgR1RXEV5Muf/6I2Ns02gln63rSGNa
         2ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133426; x=1697738226;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1x8BoWM8O8RCmIFn2DnLVwCXAu7C3bqwpGV//v0QwM=;
        b=R2sAkvLIW49Hx5RrMR8Rd/bo4NsE0TYxNgQsQtJcmrTUWmCU6IXQrsHkg1bvHgmsxg
         9r17aPNw+1hNGOqbXRoilkcZTyUkISs0DGu2N3gim/bieGjVOAk9pJOCzwLGqJDqwCii
         E1147vVcVlZ1fmyeHsevwdnbddnYcoB5mmysznXATfYxx5kH0vF7CcWPnqKkH34JDW23
         fCBsuTewmc0eqzV3i1iX0I2nvcXq1ACXxcMKlyVsBX2kXJiHM4ch2jrpeLEyqxRHd6Pp
         2Rd8yxMLRhrLkzFWQgXPVmknUsARdTDQC6779/f/sUyUzU6Y5oPLP7xwfI0k7vZn1C9J
         Dz0g==
X-Gm-Message-State: AOJu0YwgcpwNx0PcYt5RG/RTv8P1cRnRo6JIS2AZm3gwiaQgaefmc0G3
        Ejzdj95TpfoVxlLjSecQE7EN8a8BSp4D
X-Google-Smtp-Source: AGHT+IEwTRbGSW1akUmOtQcpb4RZdxhs/m6hRtdXGRo0lvFCN0FEB1NatGHQAXPqEEbw1x6ExHj9KseGXdZU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a81:ce09:0:b0:59b:e684:3c7a with SMTP id
 t9-20020a81ce09000000b0059be6843c7amr436564ywi.4.1697133426007; Thu, 12 Oct
 2023 10:57:06 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:45 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-8-irogers@google.com>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 7/7] perf pmu: Lazily compute default config
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
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

The default config is computed during creation of the PMU and may do
things like scanning sysfs, when the PMU may just be used as part of
scanning. Change default_config to perf_event_attr_init_default, a
callback that is used when a default config needs initializing. This
avoids holding onto the memory for a perf_event_attr and copying.

On a tigerlake laptop running the pmu-scan benchmark:

Before:
Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 28.780 usec (+- 0.503 usec)
  Average PMU scanning took: 283.480 usec (+- 18.471 usec)
Number of openat syscalls: 30,227

After:
Running 'internals/pmu-scan' benchmark:
Computing performance of sysfs PMU event scan for 100 times
  Average core PMU scanning took: 27.880 usec (+- 0.169 usec)
  Average PMU scanning took: 245.260 usec (+- 15.758 usec)
Number of openat syscalls: 28,914

Over 3 runs it is a nearly 12% reduction in execution time and a 4.3%
of openat calls.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 13 ++------
 tools/perf/arch/arm/util/pmu.c       |  4 +--
 tools/perf/arch/arm64/util/arm-spe.c | 45 ++++++++++++++--------------
 tools/perf/arch/x86/util/intel-pt.c  | 25 ++++++++--------
 tools/perf/arch/x86/util/pmu.c       |  2 +-
 tools/perf/util/arm-spe.h            |  4 ++-
 tools/perf/util/cs-etm.h             |  2 +-
 tools/perf/util/intel-pt.h           |  3 +-
 tools/perf/util/parse-events.c       | 12 ++++----
 tools/perf/util/pmu.c                |  3 +-
 tools/perf/util/pmu.h                |  7 +++--
 11 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b8d6a953fd74..16bba74f048b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -917,16 +917,9 @@ struct auxtrace_record *cs_etm_record_init(int *err)
  * (CFG_CHG and evsel__set_config_if_unset()). If no default is set then user
  * changes aren't tracked.
  */
-struct perf_event_attr *
-cs_etm_get_default_config(struct perf_pmu *pmu __maybe_unused)
+void
+cs_etm_get_default_config(const struct perf_pmu *pmu __maybe_unused,
+			  struct perf_event_attr *attr)
 {
-	struct perf_event_attr *attr;
-
-	attr = zalloc(sizeof(struct perf_event_attr));
-	if (!attr)
-		return NULL;
-
 	attr->sample_period = 1;
-
-	return attr;
 }
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index f25f68f84a94..7f3af3b97f3b 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -20,12 +20,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		pmu->default_config = cs_etm_get_default_config(pmu);
+		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		pmu->selectable = true;
 		pmu->is_uncore = false;
-		pmu->default_config = arm_spe_pmu_default_config(pmu);
+		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
 #endif
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 08a76734ccd2..e3acc739bd00 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -113,6 +113,25 @@ arm_spe_snapshot_resolve_auxtrace_defaults(struct record_opts *opts,
 	}
 }
 
+static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
+{
+	static __u64 sample_period;
+
+	if (sample_period)
+		return sample_period;
+
+	/*
+	 * If kernel driver doesn't advertise a minimum,
+	 * use max allowable by PMSIDR_EL1.INTERVAL
+	 */
+	if (perf_pmu__scan_file(arm_spe_pmu, "caps/min_interval", "%llu",
+				&sample_period) != 1) {
+		pr_debug("arm_spe driver doesn't advertise a min. interval. Using 4096\n");
+		sample_period = 4096;
+	}
+	return sample_period;
+}
+
 static int arm_spe_recording_options(struct auxtrace_record *itr,
 				     struct evlist *evlist,
 				     struct record_opts *opts)
@@ -136,7 +155,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 				return -EINVAL;
 			}
 			evsel->core.attr.freq = 0;
-			evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
+			evsel->core.attr.sample_period = arm_spe_pmu__sample_period(arm_spe_pmu);
 			evsel->needs_auxtrace_mmap = true;
 			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
@@ -495,26 +514,8 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	return &sper->itr;
 }
 
-struct perf_event_attr
-*arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu)
+void
+arm_spe_pmu_default_config(const struct perf_pmu *arm_spe_pmu, struct perf_event_attr *attr)
 {
-	struct perf_event_attr *attr;
-
-	attr = zalloc(sizeof(struct perf_event_attr));
-	if (!attr) {
-		pr_err("arm_spe default config cannot allocate a perf_event_attr\n");
-		return NULL;
-	}
-
-	/*
-	 * If kernel driver doesn't advertise a minimum,
-	 * use max allowable by PMSIDR_EL1.INTERVAL
-	 */
-	if (perf_pmu__scan_file(arm_spe_pmu, "caps/min_interval", "%llu",
-				  &attr->sample_period) != 1) {
-		pr_debug("arm_spe driver doesn't advertise a min. interval. Using 4096\n");
-		attr->sample_period = 4096;
-	}
-
-	return attr;
+	attr->sample_period = arm_spe_pmu__sample_period(arm_spe_pmu);
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6d6cd8f9133c..fa0c718b9e72 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -60,7 +60,7 @@ struct intel_pt_recording {
 	size_t				priv_size;
 };
 
-static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
+static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
 					     const char *str,
 					     u64 *config)
 {
@@ -84,7 +84,7 @@ static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
 	return err;
 }
 
-static int intel_pt_parse_terms(struct perf_pmu *pmu, const char *str, u64 *config)
+static int intel_pt_parse_terms(const struct perf_pmu *pmu, const char *str, u64 *config)
 {
 	*config = 0;
 	return intel_pt_parse_terms_with_default(pmu, str, config);
@@ -177,7 +177,7 @@ static int intel_pt_pick_bit(int bits, int target)
 	return pick;
 }
 
-static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
+static u64 intel_pt_default_config(const struct perf_pmu *intel_pt_pmu)
 {
 	char buf[256];
 	int mtc, mtc_periods = 0, mtc_period;
@@ -256,18 +256,17 @@ static int intel_pt_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
-struct perf_event_attr *
-intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
+void intel_pt_pmu_default_config(const struct perf_pmu *intel_pt_pmu,
+				 struct perf_event_attr *attr)
 {
-	struct perf_event_attr *attr;
+	static u64 config;
+	static bool initialized;
 
-	attr = zalloc(sizeof(struct perf_event_attr));
-	if (!attr)
-		return NULL;
-
-	attr->config = intel_pt_default_config(intel_pt_pmu);
-
-	return attr;
+	if (!initialized) {
+		config = intel_pt_default_config(intel_pt_pmu);
+		initialized = true;
+	}
+	attr->config = config;
 }
 
 static const char *intel_pt_find_filter(struct evlist *evlist,
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 949b3e2c67bd..469555ae9b3c 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -23,7 +23,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
 		pmu->selectable = true;
-		pmu->default_config = intel_pt_pmu_default_config(pmu);
+		pmu->perf_event_attr_init_default = intel_pt_pmu_default_config;
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
 		pmu->auxtrace = true;
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..4f4900c18f3e 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -27,5 +27,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 
-struct perf_event_attr *arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu);
+void arm_spe_pmu_default_config(const struct perf_pmu *arm_spe_pmu,
+				struct perf_event_attr *attr);
+
 #endif
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 7cca37887917..4696267a32f0 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -242,7 +242,7 @@ struct cs_etm_packet_queue {
 
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
-struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
+void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);
 
 enum cs_etm_pid_fmt {
 	CS_ETM_PIDFMT_NONE,
diff --git a/tools/perf/util/intel-pt.h b/tools/perf/util/intel-pt.h
index c7d6068e3a6b..18fd0be52e6c 100644
--- a/tools/perf/util/intel-pt.h
+++ b/tools/perf/util/intel-pt.h
@@ -42,6 +42,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err);
 int intel_pt_process_auxtrace_info(union perf_event *event,
 				   struct perf_session *session);
 
-struct perf_event_attr *intel_pt_pmu_default_config(struct perf_pmu *pmu);
+void intel_pt_pmu_default_config(const struct perf_pmu *intel_pt_pmu,
+				 struct perf_event_attr *attr);
 
 #endif
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..ea5579510b97 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1418,11 +1418,10 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	}
 	fix_raw(&parsed_terms, pmu);
 
-	if (pmu->default_config) {
-		memcpy(&attr, pmu->default_config, sizeof(struct perf_event_attr));
-	} else {
-		memset(&attr, 0, sizeof(attr));
-	}
+	memset(&attr, 0, sizeof(attr));
+	if (pmu->perf_event_attr_init_default)
+		pmu->perf_event_attr_init_default(pmu, &attr);
+
 	attr.type = pmu->type;
 
 	if (list_empty(&parsed_terms.terms)) {
@@ -1466,7 +1465,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	 * When using default config, record which bits of attr->config were
 	 * changed by the user.
 	 */
-	if (pmu->default_config && get_config_chgs(pmu, &parsed_terms, &config_terms)) {
+	if (pmu->perf_event_attr_init_default &&
+	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -ENOMEM;
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8ef675ea7bdd..a967d25e899b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1402,7 +1402,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
 		     struct parse_events_error *err)
 {
-	bool zero = !!pmu->default_config;
+	bool zero = !!pmu->perf_event_attr_init_default;
 
 	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
 }
@@ -2064,7 +2064,6 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 
 	perf_cpu_map__put(pmu->cpus);
 
-	zfree(&pmu->default_config);
 	zfree(&pmu->name);
 	zfree(&pmu->alias_name);
 	zfree(&pmu->id);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 5a05131aa4ce..d2895d415f08 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -92,10 +92,11 @@ struct perf_pmu {
 	 */
 	int max_precise;
 	/**
-	 * @default_config: Optional default perf_event_attr determined in
-	 * architecture specific code.
+	 * @perf_event_attr_init_default: Optional function to default
+	 * initialize PMU specific parts of the perf_event_attr.
 	 */
-	struct perf_event_attr *default_config;
+	void (*perf_event_attr_init_default)(const struct perf_pmu *pmu,
+					     struct perf_event_attr *attr);
 	/**
 	 * @cpus: Empty or the contents of either of:
 	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
-- 
2.42.0.655.g421f12c284-goog

