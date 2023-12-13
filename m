Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632280AAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjLHRcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574554AbjLHRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:25:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9241137;
        Fri,  8 Dec 2023 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702056350; x=1733592350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cAWcAFXcZ6Kpo1E866I0ZngNa4SgwSqIHT6h4WJDGxc=;
  b=UemSxrsyHWGwZU2jmX1hBUr/Js0GiOZccrxOw0Z6KFycTXs/ID8YWUxV
   Fxum47WiCExMgyLSP7DllvbFTilksaFUhZg9bfZqK5bv4oePt3Ey8+95V
   Fb+07qThkUQ07yZY4qkIMpA1I5CkV28+Fr7F8L1WIjCf7hrU+oU8CxNS1
   N0ntW2eqmNWMmI548CNaujfp3nwwsf+WCDLpEmSWiFbmIYs5QWZ36i8Ch
   OuSc9G9Y7f40E14aBBSNez2/cOf4jh8hCz1d1N6I2elhPffCg27r63ys+
   /bdN7j3fI62Lnx6H1cMVzG/gKCxqmCJlxDsOcRqFFjix/RosgC+zku0M0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="379432514"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="379432514"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772201691"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772201691"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:18 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH RFC V2 3/4] perf tools: Add support for AUX area pause / resume
Date:   Fri,  8 Dec 2023 19:24:48 +0200
Message-Id: <20231208172449.35444-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208172449.35444-1-adrian.hunter@intel.com>
References: <20231208172449.35444-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add config terms aux-pause, aux-resume and aux-start-paused.

Still to do: validation, fallbacks for perf_event_open, documentation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 11 +++++++-
 tools/perf/util/auxtrace.c                |  4 +++
 tools/perf/util/evsel.c                   |  9 +++++++
 tools/perf/util/evsel_config.h            |  6 +++++
 tools/perf/util/parse-events.c            | 33 +++++++++++++++++++++++
 tools/perf/util/parse-events.h            |  3 +++
 tools/perf/util/parse-events.l            |  3 +++
 tools/perf/util/perf_event_attr_fprintf.c |  3 +++
 8 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..9db32bc10d5b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_output_cfg;
+		struct {
+			__u64	aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				aux_start_paused :  1, /* start AUX area tracing paused */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a0368202a746..4a7ca8b0d100 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -814,6 +814,10 @@ void auxtrace_regroup_aux_output(struct evlist *evlist)
 		if (evsel__is_aux_event(evsel))
 			aux_evsel = evsel;
 		term = evsel__get_config_term(evsel, AUX_OUTPUT);
+		if (!term)
+			term = evsel__get_config_term(evsel, AUX_PAUSE);
+		if (!term)
+			term = evsel__get_config_term(evsel, AUX_RESUME);
 		/* If possible, group with the AUX event */
 		if (term && aux_evsel)
 			evlist__regroup(evlist, aux_evsel, evsel);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a5da74e3a517..03553c104954 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1001,6 +1001,15 @@ static void evsel__apply_config_terms(struct evsel *evsel,
 		case EVSEL__CONFIG_TERM_AUX_OUTPUT:
 			attr->aux_output = term->val.aux_output ? 1 : 0;
 			break;
+		case EVSEL__CONFIG_TERM_AUX_PAUSE:
+			attr->aux_pause = term->val.aux_pause ? 1 : 0;
+			break;
+		case EVSEL__CONFIG_TERM_AUX_RESUME:
+			attr->aux_resume = term->val.aux_resume ? 1 : 0;
+			break;
+		case EVSEL__CONFIG_TERM_AUX_START_PAUSED:
+			attr->aux_start_paused = term->val.aux_start_paused ? 1 : 0;
+			break;
 		case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
 			/* Already applied by auxtrace */
 			break;
diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_config.h
index aee6f808b512..85ad183b5637 100644
--- a/tools/perf/util/evsel_config.h
+++ b/tools/perf/util/evsel_config.h
@@ -25,6 +25,9 @@ enum evsel_term_type {
 	EVSEL__CONFIG_TERM_BRANCH,
 	EVSEL__CONFIG_TERM_PERCORE,
 	EVSEL__CONFIG_TERM_AUX_OUTPUT,
+	EVSEL__CONFIG_TERM_AUX_PAUSE,
+	EVSEL__CONFIG_TERM_AUX_RESUME,
+	EVSEL__CONFIG_TERM_AUX_START_PAUSED,
 	EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
 	EVSEL__CONFIG_TERM_CFG_CHG,
 };
@@ -44,6 +47,9 @@ struct evsel_config_term {
 		unsigned long max_events;
 		bool	      percore;
 		bool	      aux_output;
+		bool	      aux_pause;
+		bool	      aux_resume;
+		bool	      aux_start_paused;
 		u32	      aux_sample_size;
 		u64	      cfg_chg;
 		char	      *str;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index aa2f5c6fc7fc..615b04d5fb30 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -768,6 +768,9 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_DRV_CFG]		= "driver-config",
 		[PARSE_EVENTS__TERM_TYPE_PERCORE]		= "percore",
 		[PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT]		= "aux-output",
+		[PARSE_EVENTS__TERM_TYPE_AUX_PAUSE]		= "aux-pause",
+		[PARSE_EVENTS__TERM_TYPE_AUX_RESUME]		= "aux-resume",
+		[PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED]	= "aux-start-paused",
 		[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
 		[PARSE_EVENTS__TERM_TYPE_METRIC_ID]		= "metric-id",
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
@@ -817,6 +820,9 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_PAUSE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_RESUME:
+	case PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -936,6 +942,15 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
 		CHECK_TYPE_VAL(NUM);
 		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_PAUSE:
+		CHECK_TYPE_VAL(NUM);
+		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_RESUME:
+		CHECK_TYPE_VAL(NUM);
+		break;
+	case PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED:
+		CHECK_TYPE_VAL(NUM);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		CHECK_TYPE_VAL(NUM);
 		if (term->val.num > UINT_MAX) {
@@ -1036,6 +1051,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_OVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_NOOVERWRITE:
 	case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+	case PARSE_EVENTS__TERM_TYPE_AUX_PAUSE:
+	case PARSE_EVENTS__TERM_TYPE_AUX_RESUME:
+	case PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED:
 	case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		return config_term_common(attr, term, err);
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -1170,6 +1188,18 @@ do {								\
 			ADD_CONFIG_TERM_VAL(AUX_OUTPUT, aux_output,
 					    term->val.num ? 1 : 0, term->weak);
 			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_PAUSE:
+			ADD_CONFIG_TERM_VAL(AUX_PAUSE, aux_pause,
+					    term->val.num ? 1 : 0, term->weak);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_RESUME:
+			ADD_CONFIG_TERM_VAL(AUX_RESUME, aux_resume,
+					    term->val.num ? 1 : 0, term->weak);
+			break;
+		case PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED:
+			ADD_CONFIG_TERM_VAL(AUX_START_PAUSED, aux_start_paused,
+					    term->val.num ? 1 : 0, term->weak);
+			break;
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 			ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_size,
 					    term->val.num, term->weak);
@@ -1232,6 +1262,9 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 		case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		case PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT:
+		case PARSE_EVENTS__TERM_TYPE_AUX_PAUSE:
+		case PARSE_EVENTS__TERM_TYPE_AUX_RESUME:
+		case PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED:
 		case PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE:
 		case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 		case PARSE_EVENTS__TERM_TYPE_RAW:
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 63c0a36a4bf1..ff0871385b50 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -74,6 +74,9 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_DRV_CFG,
 	PARSE_EVENTS__TERM_TYPE_PERCORE,
 	PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT,
+	PARSE_EVENTS__TERM_TYPE_AUX_PAUSE,
+	PARSE_EVENTS__TERM_TYPE_AUX_RESUME,
+	PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED,
 	PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE,
 	PARSE_EVENTS__TERM_TYPE_METRIC_ID,
 	PARSE_EVENTS__TERM_TYPE_RAW,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index e86c45675e1d..56963013c3af 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -244,6 +244,9 @@ overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
 no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
 percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-pause		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_PAUSE); }
+aux-resume		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_RESUME); }
+aux-start-paused	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_START_PAUSED); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 8f04d3b7f3ec..e6ba0ac73182 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -309,6 +309,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(inherit_thread, p_unsigned);
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
+	PRINT_ATTRf(aux_start_paused, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -323,6 +324,8 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(aux_pause, p_unsigned);
+	PRINT_ATTRf(aux_resume, p_unsigned);
 
 	return ret;
 }
-- 
2.34.1

