Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BC7ECD07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjKOTd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjKOTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:33:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FC1B6;
        Wed, 15 Nov 2023 11:33:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9226C433C7;
        Wed, 15 Nov 2023 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076826;
        bh=C9d7m2stdHGAuOhCF7kDVySq8E4Kx449Rr4h5fAi4Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeSDY/DDUcgWFLOgfksulyUFBnN5f2Jm0ZjxIHc+ACf3RSr6kAWiRGMRJS5wRka5W
         ZTDxiHwLly+8BRa82k2QklzK2UgMyPTc4LtNUHZDfFRYKRIgNDpN+NZNvJW5/I+arx
         WZbKX3LiAZ13Km+3rtq+di3bHmflpahsnScEHM1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Ming Wang <wangming01@loongson.cn>,
        John Garry <john.g.garry@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 426/550] perf pmu: Remove logic for PMU name being NULL
Date:   Wed, 15 Nov 2023 14:16:50 -0500
Message-ID: <20231115191630.292521239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit c091ee90897aacf60aee510464cfc28b4041186f ]

The PMU name could be NULL in the case of the fake_pmu. Initialize the
name for the fake_pmu to "fake" so that all other logic can assume it
is initialized. Add a const to the type of name so that a literal can
be used to avoid additional initialization code. Propagate the cost
through related routines and remove now unnecessary "(char *)"
casts. Doing this located a bug in builtin-list for the pmu_glob that
was missing a strdup.

Signed-off-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20230825024002.801955-3-irogers@google.com
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: James Clark <james.clark@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Wei Li <liwei391@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Ming Wang <wangming01@loongson.cn>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 85f73c377b2a ("perf mem-events: Avoid uninitialized read")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/arm64/util/mem-events.c   |  2 +-
 tools/perf/arch/powerpc/util/mem-events.c |  6 +++---
 tools/perf/arch/x86/util/mem-events.c     |  8 ++++----
 tools/perf/arch/x86/util/pmu.c            | 10 +++++-----
 tools/perf/builtin-list.c                 |  2 +-
 tools/perf/tests/pmu-events.c             | 16 ++++++++--------
 tools/perf/util/env.c                     |  8 ++------
 tools/perf/util/header.c                  |  8 +-------
 tools/perf/util/mem-events.c              | 16 ++++++++--------
 tools/perf/util/mem-events.h              |  2 +-
 tools/perf/util/parse-events.c            |  7 ++-----
 tools/perf/util/parse-events.h            |  2 +-
 tools/perf/util/parse-events.y            |  2 +-
 tools/perf/util/pmu.c                     | 16 +++++++++-------
 tools/perf/util/pmu.h                     |  8 ++++----
 15 files changed, 51 insertions(+), 62 deletions(-)

diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
index df817d1f9f3eb..3bcc5c7035c21 100644
--- a/tools/perf/arch/arm64/util/mem-events.c
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -20,7 +20,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
 	return &perf_mem_events[i];
 }
 
-char *perf_mem_events__name(int i, char *pmu_name __maybe_unused)
+const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
index 4120fafe0be41..78b986e5268d9 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -3,10 +3,10 @@
 #include "mem-events.h"
 
 /* PowerPC does not support 'ldlat' parameter. */
-char *perf_mem_events__name(int i, char *pmu_name __maybe_unused)
+const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
 {
 	if (i == PERF_MEM_EVENTS__LOAD)
-		return (char *) "cpu/mem-loads/";
+		return "cpu/mem-loads/";
 
-	return (char *) "cpu/mem-stores/";
+	return "cpu/mem-stores/";
 }
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index a8a782bcb1213..191b372f9a2d3 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -52,7 +52,7 @@ bool is_mem_loads_aux_event(struct evsel *leader)
 	return leader->core.attr.config == MEM_LOADS_AUX;
 }
 
-char *perf_mem_events__name(int i, char *pmu_name)
+const char *perf_mem_events__name(int i, const char *pmu_name)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
@@ -65,7 +65,7 @@ char *perf_mem_events__name(int i, char *pmu_name)
 
 		if (!pmu_name) {
 			mem_loads_name__init = true;
-			pmu_name = (char *)"cpu";
+			pmu_name = "cpu";
 		}
 
 		if (perf_pmus__have_event(pmu_name, "mem-loads-aux")) {
@@ -82,12 +82,12 @@ char *perf_mem_events__name(int i, char *pmu_name)
 
 	if (i == PERF_MEM_EVENTS__STORE) {
 		if (!pmu_name)
-			pmu_name = (char *)"cpu";
+			pmu_name = "cpu";
 
 		scnprintf(mem_stores_name, sizeof(mem_stores_name),
 			  e->name, pmu_name);
 		return mem_stores_name;
 	}
 
-	return (char *)e->name;
+	return e->name;
 }
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 65d8cdff4d5f4..f428cffb03781 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -126,7 +126,7 @@ static int setup_pmu_alias_list(void)
 	return ret;
 }
 
-static char *__pmu_find_real_name(const char *name)
+static const char *__pmu_find_real_name(const char *name)
 {
 	struct pmu_alias *pmu_alias;
 
@@ -135,10 +135,10 @@ static char *__pmu_find_real_name(const char *name)
 			return pmu_alias->name;
 	}
 
-	return (char *)name;
+	return name;
 }
 
-char *pmu_find_real_name(const char *name)
+const char *pmu_find_real_name(const char *name)
 {
 	if (cached_list)
 		return __pmu_find_real_name(name);
@@ -149,7 +149,7 @@ char *pmu_find_real_name(const char *name)
 	return __pmu_find_real_name(name);
 }
 
-static char *__pmu_find_alias_name(const char *name)
+static const char *__pmu_find_alias_name(const char *name)
 {
 	struct pmu_alias *pmu_alias;
 
@@ -160,7 +160,7 @@ static char *__pmu_find_alias_name(const char *name)
 	return NULL;
 }
 
-char *pmu_find_alias_name(const char *name)
+const char *pmu_find_alias_name(const char *name)
 {
 	if (cached_list)
 		return __pmu_find_alias_name(name);
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 7fec2cca759f6..e74d0223deb7f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -502,7 +502,7 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			default_ps.pmu_glob = pmu->name;
+			default_ps.pmu_glob = strdup(pmu->name);
 		}
 	}
 	print_cb.print_start(ps);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 64383fc34ef1b..5c6f930db4387 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -508,7 +508,7 @@ static struct perf_pmu_alias *find_alias(const char *test_event, struct list_hea
 }
 
 /* Verify aliases are as expected */
-static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
+static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
 {
 	struct perf_pmu_test_event const **test_event_table;
 	struct perf_pmu *pmu;
@@ -635,7 +635,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 static struct perf_pmu_test_pmu test_pmus[] = {
 	{
 		.pmu = {
-			.name = (char *)"hisi_sccl1_ddrc2",
+			.name = "hisi_sccl1_ddrc2",
 			.is_uncore = 1,
 		},
 		.aliases = {
@@ -644,7 +644,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"uncore_cbox_0",
+			.name = "uncore_cbox_0",
 			.is_uncore = 1,
 		},
 		.aliases = {
@@ -655,7 +655,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"hisi_sccl3_l3c7",
+			.name = "hisi_sccl3_l3c7",
 			.is_uncore = 1,
 		},
 		.aliases = {
@@ -664,7 +664,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"uncore_imc_free_running_0",
+			.name = "uncore_imc_free_running_0",
 			.is_uncore = 1,
 		},
 		.aliases = {
@@ -673,7 +673,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"uncore_imc_0",
+			.name = "uncore_imc_0",
 			.is_uncore = 1,
 		},
 		.aliases = {
@@ -682,7 +682,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"uncore_sys_ddr_pmu0",
+			.name = "uncore_sys_ddr_pmu0",
 			.is_uncore = 1,
 			.id = (char *)"v8",
 		},
@@ -692,7 +692,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 	},
 	{
 		.pmu = {
-			.name = (char *)"uncore_sys_ccn_pmu4",
+			.name = "uncore_sys_ccn_pmu4",
 			.is_uncore = 1,
 			.id = (char *)"0x01",
 		},
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9eabf3ec56e97..a164164001fb5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -324,11 +324,9 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 	u32 pmu_num = 0;
 	struct strbuf sb;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name)
-			continue;
+	while ((pmu = perf_pmus__scan(pmu)))
 		pmu_num++;
-	}
+
 	if (!pmu_num) {
 		pr_debug("pmu mappings not available\n");
 		return -ENOENT;
@@ -339,8 +337,6 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 		return -ENOMEM;
 
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name)
-			continue;
 		if (strbuf_addf(&sb, "%u:%s", pmu->type, pmu->name) < 0)
 			goto error;
 		/* include a NULL character at the end */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7af85a479786b..083919e3b8d88 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -746,20 +746,14 @@ static int write_pmu_mappings(struct feat_fd *ff,
 	 * Do a first pass to count number of pmu to avoid lseek so this
 	 * works in pipe mode as well.
 	 */
-	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name)
-			continue;
+	while ((pmu = perf_pmus__scan(pmu)))
 		pmu_num++;
-	}
 
 	ret = do_write(ff, &pmu_num, sizeof(pmu_num));
 	if (ret < 0)
 		return ret;
 
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name)
-			continue;
-
 		ret = do_write(ff, &pmu->type, sizeof(pmu->type));
 		if (ret < 0)
 			return ret;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c07fe3a907220..39ffe8ceb3809 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -37,7 +37,7 @@ struct perf_mem_event * __weak perf_mem_events__ptr(int i)
 	return &perf_mem_events[i];
 }
 
-char * __weak perf_mem_events__name(int i, char *pmu_name  __maybe_unused)
+const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
 {
 	struct perf_mem_event *e = perf_mem_events__ptr(i);
 
@@ -53,7 +53,7 @@ char * __weak perf_mem_events__name(int i, char *pmu_name  __maybe_unused)
 		return mem_loads_name;
 	}
 
-	return (char *)e->name;
+	return e->name;
 }
 
 __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
@@ -186,7 +186,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
 	struct perf_pmu *pmu;
-	char *s;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -209,15 +208,16 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			}
 
 			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+				const char *s = perf_mem_events__name(j, pmu->name);
+
 				rec_argv[i++] = "-e";
-				s = perf_mem_events__name(j, pmu->name);
 				if (s) {
-					s = strdup(s);
-					if (!s)
+					char *copy = strdup(s);
+					if (!copy)
 						return -1;
 
-					rec_argv[i++] = s;
-					rec_tmp[k++] = s;
+					rec_argv[i++] = copy;
+					rec_tmp[k++] = copy;
 				}
 			}
 		}
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 12372309d60ed..b40ad6ea93fcd 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -38,7 +38,7 @@ extern unsigned int perf_mem_events__loads_ldlat;
 int perf_mem_events__parse(const char *str);
 int perf_mem_events__init(void);
 
-char *perf_mem_events__name(int i, char *pmu_name);
+const char *perf_mem_events__name(int i, const char *pmu_name);
 struct perf_mem_event *perf_mem_events__ptr(int i);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 979fc92c2f47d..596ba10129870 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -271,7 +271,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
+	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -446,9 +446,6 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	if (parse_state->pmu_filter == NULL)
 		return false;
 
-	if (pmu->name == NULL)
-		return true;
-
 	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
 }
 
@@ -1551,7 +1548,7 @@ static bool config_term_percore(struct list_head *config_terms)
 }
 
 int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
+			 struct list_head *list, const char *name,
 			 struct list_head *head_config,
 			 bool auto_merge_stats)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b0eb95f93e9c3..8e8682ca84654 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -190,7 +190,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				u64 addr, char *type, u64 len,
 				struct list_head *head_config);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
+			 struct list_head *list, const char *name,
 			 struct list_head *head_config,
 			 bool auto_merge_stats);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a049c577bae3d..59108f70d1e45 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -312,7 +312,7 @@ PE_NAME opt_pmu_config
 		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			char *name = pmu->name;
+			const char *name = pmu->name;
 
 			if (parse_events__filter_pmu(parse_state, pmu))
 				continue;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d5406effc1695..f20fcea215e4b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,7 +29,9 @@
 #include "fncache.h"
 #include "util/evsel_config.h"
 
-struct perf_pmu perf_pmu__fake;
+struct perf_pmu perf_pmu__fake = {
+	.name = "fake",
+};
 
 /**
  * struct perf_pmu_format - Values from a format file read from
@@ -840,13 +842,13 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
-char * __weak
+const char * __weak
 pmu_find_real_name(const char *name)
 {
-	return (char *)name;
+	return name;
 }
 
-char * __weak
+const char * __weak
 pmu_find_alias_name(const char *name __maybe_unused)
 {
 	return NULL;
@@ -866,8 +868,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	LIST_HEAD(format);
 	LIST_HEAD(aliases);
 	__u32 type;
-	char *name = pmu_find_real_name(lookup_name);
-	char *alias_name;
+	const char *name = pmu_find_real_name(lookup_name);
+	const char *alias_name;
 
 	/*
 	 * The pmu data we store & need consists of the pmu
@@ -1710,7 +1712,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 		   name ?: "N/A", buf, config_name, config);
 }
 
-int perf_pmu__match(char *pattern, char *name, char *tok)
+int perf_pmu__match(const char *pattern, const char *name, const char *tok)
 {
 	if (!name)
 		return -1;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6b414cecbad22..461af638399c9 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -39,7 +39,7 @@ struct perf_pmu_caps {
  */
 struct perf_pmu {
 	/** @name: The name of the PMU such as "cpu". */
-	char *name;
+	const char *name;
 	/**
 	 * @alias_name: Optional alternate name for the PMU determined in
 	 * architecture specific code.
@@ -275,10 +275,10 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *config_name);
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
-int perf_pmu__match(char *pattern, char *name, char *tok);
+int perf_pmu__match(const char *pattern, const char *name, const char *tok);
 
-char *pmu_find_real_name(const char *name);
-char *pmu_find_alias_name(const char *name);
+const char *pmu_find_real_name(const char *name);
+const char *pmu_find_alias_name(const char *name);
 double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
-- 
2.42.0



