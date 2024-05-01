Return-Path: <linux-kernel+bounces-165349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74B8B8B96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411EE1C22612
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3212F373;
	Wed,  1 May 2024 13:59:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802B12FB28;
	Wed,  1 May 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571972; cv=none; b=ftVXtyuWzMrq8CqZDBdIO8FDBT/+QOslC6mCzUMdfPsZrK89owk27WnErQGfot8J2OCwE7OxzAfWtA3J1NXNrAJ/DzJoPmgwE2IOXbeJa3rElRqX6enyQhh2e5NZkQnnbR1XLfPTbRcDvo/KjajwHLYOrA6bvpn7K0SNZKXrlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571972; c=relaxed/simple;
	bh=MrpCWDSQ20D9MblFT3Nd0Ml40zCW3TmmxyMQ5O0ywDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLTmNLr83QOD3q0MFyNCHwkAO/NT654W7z6MlXqti+2q2PSvGb5VEjRiWp8ptK8cfYOXfmp0OJGhwBPKLqzObAQkBRqS4v46ODFI9QXIXOaHaUhq6aYT2NsPqp2RERy6JZP1L8B3OcoRA2JSD3f2h/EPX15r1n9h9ke/wQXOQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 796441042;
	Wed,  1 May 2024 06:59:55 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDDFD3F71E;
	Wed,  1 May 2024 06:59:26 -0700 (PDT)
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
Subject: [PATCH v2 3/3] perf cs-etm: Improve version detection and error reporting
Date: Wed,  1 May 2024 14:57:53 +0100
Message-Id: <20240501135753.508022-4-james.clark@arm.com>
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

When the config validation functions are warning about ETMv3, they do it
based on "not ETMv4". If the drivers aren't all loaded or the hardware
doesn't support Coresight it will appear as "not ETMv4" and then Perf
will print the error message "... not supported in ETMv3 ..." which is
wrong and confusing.

cs_etm_is_etmv4() is also misnamed because it also returns true for
ETE because ETE has a superset of the ETMv4 metadata files. Although
this was always done in the correct order so it wasn't a bug.

Improve all this by making a single get version function which also
handles not present as a separate case. Change the ETMv3 error message
to only print when ETMv3 is detected, and add a new error message for
the not present case.

Reviewed-by: Leo Yan <leo.yan@linux.dev>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 61 ++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2fc4b41daea1..da6231367993 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -66,11 +66,25 @@ static const char * const metadata_ete_ro[] = {
 	[CS_ETE_TS_SOURCE]		= "ts_source",
 };
 
-static bool cs_etm_is_etmv4(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
+enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
 
+static enum cs_etm_version cs_etm_get_version(struct perf_pmu *cs_etm_pmu,
+					      struct perf_cpu cpu)
+{
+	if (cs_etm_is_ete(cs_etm_pmu, cpu))
+		return CS_ETE;
+	else if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]))
+		return CS_ETMV4;
+	else if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv3_ro[CS_ETM_ETMCCER]))
+		return CS_ETMV3;
+
+	return CS_NOT_PRESENT;
+}
+
 static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel *evsel,
 				      struct perf_cpu cpu)
 {
@@ -85,7 +99,7 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
 		return 0;
 
 	/* Not supported in etmv3 */
-	if (!cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
+	if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_ETMV3) {
 		pr_err("%s: contextid not supported in ETMv3, disable with %s/contextid=0/\n",
 		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
@@ -141,7 +155,7 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
 		return 0;
 
-	if (!cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
+	if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_ETMV3) {
 		pr_err("%s: timestamp not supported in ETMv3, disable with %s/timestamp=0/\n",
 		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
@@ -205,6 +219,11 @@ static int cs_etm_validate_config(struct perf_pmu *cs_etm_pmu,
 	}
 
 	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
+		if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_NOT_PRESENT) {
+			pr_err("%s: Not found on CPU %d. Check hardware and firmware support and that all Coresight drivers are loaded\n",
+			       CORESIGHT_ETM_PMU_NAME, cpu.cpu);
+			return -EINVAL;
+		}
 		err = cs_etm_validate_context_id(cs_etm_pmu, evsel, cpu);
 		if (err)
 			break;
@@ -536,13 +555,13 @@ cs_etm_info_priv_size(struct auxtrace_record *itr,
 		/* Event can be "any" CPU so count all online CPUs. */
 		intersect_cpus = perf_cpu_map__new_online_cpus();
 	}
+	/* Count number of each type of ETM. Don't count if that CPU has CS_NOT_PRESENT. */
 	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, intersect_cpus) {
-		if (cs_etm_is_ete(cs_etm_pmu, cpu))
-			ete++;
-		else if (cs_etm_is_etmv4(cs_etm_pmu, cpu))
-			etmv4++;
-		else
-			etmv3++;
+		enum cs_etm_version v = cs_etm_get_version(cs_etm_pmu, cpu);
+
+		ete   += v == CS_ETE;
+		etmv4 += v == CS_ETMV4;
+		etmv3 += v == CS_ETMV3;
 	}
 	perf_cpu_map__put(intersect_cpus);
 
@@ -552,12 +571,6 @@ cs_etm_info_priv_size(struct auxtrace_record *itr,
 	       (etmv3 * CS_ETMV3_PRIV_SIZE));
 }
 
-static bool cs_etm_is_etmv4(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
-{
-	/* Take any of the RO files for ETMv4 and see if it present */
-	return cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
-}
-
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val)
 {
 	char pmu_path[PATH_MAX];
@@ -706,21 +719,26 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 	struct perf_pmu *cs_etm_pmu = cs_etm_get_pmu(itr);
 
 	/* first see what kind of tracer this cpu is affined to */
-	if (cs_etm_is_ete(cs_etm_pmu, cpu)) {
+	switch (cs_etm_get_version(cs_etm_pmu, cpu)) {
+	case CS_ETE:
 		magic = __perf_cs_ete_magic;
 		cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
 
 		/* How much space was used */
 		increment = CS_ETE_PRIV_MAX;
 		nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
-	} else if (cs_etm_is_etmv4(cs_etm_pmu, cpu)) {
+		break;
+
+	case CS_ETMV4:
 		magic = __perf_cs_etmv4_magic;
 		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
 
 		/* How much space was used */
 		increment = CS_ETMV4_PRIV_MAX;
 		nr_trc_params = CS_ETMV4_PRIV_MAX - CS_ETMV4_TRCCONFIGR;
-	} else {
+		break;
+
+	case CS_ETMV3:
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
@@ -736,6 +754,13 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 		/* How much space was used */
 		increment = CS_ETM_PRIV_MAX;
 		nr_trc_params = CS_ETM_PRIV_MAX - CS_ETM_ETMCR;
+		break;
+
+	default:
+	case CS_NOT_PRESENT:
+		/* Unreachable, CPUs already validated in cs_etm_validate_config() */
+		assert(true);
+		return;
 	}
 
 	/* Build generic header portion */
-- 
2.34.1


