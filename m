Return-Path: <linux-kernel+bounces-165348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B812A8B8B95
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB82284464
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342212FB07;
	Wed,  1 May 2024 13:59:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F412EBF4;
	Wed,  1 May 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571968; cv=none; b=bO03wvKQA1TqsaetxOi/SZEEoNKErDXkUcR3bQrimFDl3NOYLi7qUEO3k413H1t7QA8CZEOg9l5+11Oq1d7qEiq1rlxViY36x+080Zn4SwZkRZoNYL7mCLiPYlWIxR6sWttmPkbXzZ3L5buepg1c4FA/7A0+B6t+y0Vn6qH2LQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571968; c=relaxed/simple;
	bh=NMGvVwOXWaxbv/nmLwC9gZ4w+4dXSSoUpLzPolluBN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdxTMf1UpXOrY0MgYu1Y7y3lcmDU9mDUcQJBfgYo+ctYWD5INVqHfT8ucnShg250uleFMaUaZx1tEcp4a+YeRLlkHNktN5k1GasArFMYiwZ9LDV0KCxwGEpU4l0kUFkUJCEW25RNahZQIoDj3jds5d69OpBwPS4YCMV74HQrhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EB97DA7;
	Wed,  1 May 2024 06:59:52 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53E5A3F71E;
	Wed,  1 May 2024 06:59:23 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	coresight@lists.linaro.org,
	leo.yan@linux.dev,
	irogers@google.com
Cc: James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf cs-etm: Remove repeated fetches of the ETM PMU
Date: Wed,  1 May 2024 14:57:52 +0100
Message-Id: <20240501135753.508022-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501135753.508022-1-james.clark@arm.com>
References: <20240501135753.508022-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most functions already have cs_etm_pmu, so it's a bit neater to pass
it through rather than itr only to convert it again.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 60 ++++++++++++++-----------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index a1fa711dc41a..2fc4b41daea1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -66,17 +66,14 @@ static const char * const metadata_ete_ro[] = {
 	[CS_ETE_TS_SOURCE]		= "ts_source",
 };
 
-static bool cs_etm_is_etmv4(struct auxtrace_record *itr, struct perf_cpu cpu);
-static bool cs_etm_is_ete(struct auxtrace_record *itr, struct perf_cpu cpu);
+static bool cs_etm_is_etmv4(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
+static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
 
-static int cs_etm_validate_context_id(struct auxtrace_record *itr, struct evsel *evsel,
+static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel *evsel,
 				      struct perf_cpu cpu)
 {
-	struct cs_etm_recording *ptr =
-		container_of(itr, struct cs_etm_recording, itr);
-	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	int err;
 	__u64 val;
 	u64 contextid = evsel->core.attr.config &
@@ -88,7 +85,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr, struct evsel
 		return 0;
 
 	/* Not supported in etmv3 */
-	if (!cs_etm_is_etmv4(itr, cpu)) {
+	if (!cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
 		pr_err("%s: contextid not supported in ETMv3, disable with %s/contextid=0/\n",
 		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
@@ -134,12 +131,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr, struct evsel
 	return 0;
 }
 
-static int cs_etm_validate_timestamp(struct auxtrace_record *itr, struct evsel *evsel,
+static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *evsel,
 				     struct perf_cpu cpu)
 {
-	struct cs_etm_recording *ptr =
-		container_of(itr, struct cs_etm_recording, itr);
-	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	int err;
 	__u64 val;
 
@@ -147,7 +141,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr, struct evsel *
 	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
 		return 0;
 
-	if (!cs_etm_is_etmv4(itr, cpu)) {
+	if (!cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
 		pr_err("%s: timestamp not supported in ETMv3, disable with %s/timestamp=0/\n",
 		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
@@ -173,6 +167,13 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr, struct evsel *
 	return 0;
 }
 
+static struct perf_pmu *cs_etm_get_pmu(struct auxtrace_record *itr)
+{
+	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
+
+	return ptr->cs_etm_pmu;
+}
+
 /*
  * Check whether the requested timestamp and contextid options should be
  * available on all requested CPUs and if not, tell the user how to override.
@@ -180,7 +181,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_record *itr, struct evsel *
  * first is better. In theory the kernel could still disable the option for
  * some other reason so this is best effort only.
  */
-static int cs_etm_validate_config(struct auxtrace_record *itr,
+static int cs_etm_validate_config(struct perf_pmu *cs_etm_pmu,
 				  struct evsel *evsel)
 {
 	int idx, err = 0;
@@ -204,11 +205,11 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
 	}
 
 	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
-		err = cs_etm_validate_context_id(itr, evsel, cpu);
+		err = cs_etm_validate_context_id(cs_etm_pmu, evsel, cpu);
 		if (err)
 			break;
 
-		err = cs_etm_validate_timestamp(itr, evsel, cpu);
+		err = cs_etm_validate_timestamp(cs_etm_pmu, evsel, cpu);
 		if (err)
 			break;
 	}
@@ -449,7 +450,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 		evsel__set_sample_bit(evsel, TIME);
 
-	err = cs_etm_validate_config(itr, cs_etm_evsel);
+	err = cs_etm_validate_config(cs_etm_pmu, cs_etm_evsel);
 out:
 	return err;
 }
@@ -515,14 +516,15 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 }
 
 static size_t
-cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-		      struct evlist *evlist __maybe_unused)
+cs_etm_info_priv_size(struct auxtrace_record *itr,
+		      struct evlist *evlist)
 {
 	int idx;
 	int etmv3 = 0, etmv4 = 0, ete = 0;
 	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
 	struct perf_cpu_map *intersect_cpus;
 	struct perf_cpu cpu;
+	struct perf_pmu *cs_etm_pmu = cs_etm_get_pmu(itr);
 
 	if (!perf_cpu_map__has_any_cpu(event_cpus)) {
 		/* cpu map is not "any" CPU , we have specific CPUs to work with */
@@ -535,9 +537,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		intersect_cpus = perf_cpu_map__new_online_cpus();
 	}
 	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
-		if (cs_etm_is_ete(itr, cpu))
+		if (cs_etm_is_ete(cs_etm_pmu, cpu))
 			ete++;
-		else if (cs_etm_is_etmv4(itr, cpu))
+		else if (cs_etm_is_etmv4(cs_etm_pmu, cpu))
 			etmv4++;
 		else
 			etmv3++;
@@ -550,12 +552,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	       (etmv3 * CS_ETMV3_PRIV_SIZE));
 }
 
-static bool cs_etm_is_etmv4(struct auxtrace_record *itr, struct perf_cpu cpu)
+static bool cs_etm_is_etmv4(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
 {
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-
 	/* Take any of the RO files for ETMv4 and see if it present */
 	return cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
 }
@@ -615,10 +613,8 @@ static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, co
 #define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
 #define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
 
-static bool cs_etm_is_ete(struct auxtrace_record *itr, struct perf_cpu cpu)
+static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
 {
-	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
-	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	__u64 trcdevarch;
 
 	if (!cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TRCDEVARCH]))
@@ -707,19 +703,17 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 {
 	u32 increment, nr_trc_params;
 	u64 magic;
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+	struct perf_pmu *cs_etm_pmu = cs_etm_get_pmu(itr);
 
 	/* first see what kind of tracer this cpu is affined to */
-	if (cs_etm_is_ete(itr, cpu)) {
+	if (cs_etm_is_ete(cs_etm_pmu, cpu)) {
 		magic = __perf_cs_ete_magic;
 		cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
 
 		/* How much space was used */
 		increment = CS_ETE_PRIV_MAX;
 		nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
-	} else if (cs_etm_is_etmv4(itr, cpu)) {
+	} else if (cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
 		magic = __perf_cs_etmv4_magic;
 		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
 
-- 
2.34.1


