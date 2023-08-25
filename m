Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA17787DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbjHYCkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbjHYCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062681BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5924b2aac52so6657797b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931232; x=1693536032;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0v6ZH91cRAWfBdufQXOgsVVfAmsDZGVPdtey97XoEE=;
        b=Btecnss5l4Wq7jLOEK/LGD64SV/s8pa43YQY1AffFs9TS+T6JdbuInYgZcTahf9+zo
         oxYgnfuFdzO79SpJh+LSgjXZtNjVxz7N8yTLT5TijYnZY8T8ORIAmgJVgCiNWlBj1oNX
         b2laVEfRwkZQlwtvYtoK+ybe1tT1I1cBfb8JYmc7zFfU+ENsOQLbBFdnvkWViObDswvk
         xz/BJiXEmam0+ZuFOS6uGYpoiqSmbk/ezm5pwW4aPP+dGLk421rA7WJvN0x9bqAkoSXq
         JLi5UMsQ1SjF1jmZ8OxHVl2pkGkYykxnp9R42abYgG5iFqDCQK/ZEXVpkfNIKaFLZtIw
         HOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931232; x=1693536032;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0v6ZH91cRAWfBdufQXOgsVVfAmsDZGVPdtey97XoEE=;
        b=X5U7xKXEXDfuabUZanifdALEd7R+DxDWAx+oQSsLltNgw+68w2zrSKgu8cKKsV9G6h
         EwDq2Ab6PbUXcniiE31VKAvuX53/dXBfRMjqVa7FxDGxxgVuurngjNgSdn5mcoIECFLq
         HA3XZdaJGK7QJYPbe8IXOH2DdPGWIYXF3vXsxCq+c2U78c4J49R9rrPKru9IzXGSaUi/
         KhueMsfyq5KQHpaDUGHaakAQicR3skBWkV5YHUl8XVhJBacaaiYdYwSXS+eQtnR9bxIX
         7+kIx+4pQahgsfQV0AzkhpcVFA6RPCEjzVVjXcpgpzFHBRBi9CDLE1raUJuZaqtH4kco
         cpIw==
X-Gm-Message-State: AOJu0Yz6TNdrEMsRLyajFwFoaMGwO2rSRZxlQabESCnLGoMrJe5P9/Wz
        +XkbIeWsCfUkYtuRFGU+FNGp9hPPTHXj
X-Google-Smtp-Source: AGHT+IHTePzpW1ONhHhLRkqg7uW8qhFGUhV+RL2W0FxSqbDMmfOWE3o3zh1BgpGWXmGcIcGYlGfHSapRZQiD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a25:3c87:0:b0:d78:215f:ba5f with SMTP id
 j129-20020a253c87000000b00d78215fba5fmr118274yba.9.1692931232240; Thu, 24 Aug
 2023 19:40:32 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:58 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-3-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 2/6] perf pmu: Remove logic for PMU name being NULL
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
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

The PMU name could be NULL in the case of the fake_pmu. Initialize the
name for the fake_pmu to "fake" so that all other logic can assume it
is initialized. Add a const to the type of name so that a literal can
be used to avoid additional initialization code. Propagate the cost
through related routines and remove now unnecessary "(char *)"
casts. Doing this located a bug in builtin-list for the pmu_glob that
was missing a strdup.

Signed-off-by: Ian Rogers <irogers@google.com>
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
index df817d1f9f3e..3bcc5c7035c2 100644
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
index 4120fafe0be4..78b986e5268d 100644
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
index a8a782bcb121..191b372f9a2d 100644
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
index 65d8cdff4d5f..f428cffb0378 100644
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
index 7fec2cca759f..e74d0223deb7 100644
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
index 3dc1ebee4d9f..94937378647a 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -522,7 +522,7 @@ static int test_core_pmu_event_aliases_cb(void *state, struct pmu_event_info *al
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
index 9eabf3ec56e9..a164164001fb 100644
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
index 13c71d28e0eb..9f35d86a3351 100644
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
index c07fe3a90722..39ffe8ceb380 100644
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
index 12372309d60e..b40ad6ea93fc 100644
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
index c71e135d7335..621bdd157a0f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -262,7 +262,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
-	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
+	evsel->pmu_name = pmu ? strdup(pmu->name) : NULL;
 
 	if (name)
 		evsel->name = strdup(name);
@@ -437,9 +437,6 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	if (parse_state->pmu_filter == NULL)
 		return false;
 
-	if (pmu->name == NULL)
-		return true;
-
 	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
 }
 
@@ -1292,7 +1289,7 @@ static bool config_term_percore(struct list_head *config_terms)
 }
 
 int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
+			 struct list_head *list, const char *name,
 			 struct list_head *head_config,
 			 bool auto_merge_stats, void *loc_)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c7f779420723..c4e8d8e94b28 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -176,7 +176,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				u64 addr, char *type, u64 len,
 				struct list_head *head_config);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
+			 struct list_head *list, const char *name,
 			 struct list_head *head_config,
 			bool auto_merge_stats, void *loc);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 00da1f8c0baf..3a9d4e2513b5 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -307,7 +307,7 @@ PE_NAME opt_pmu_config
 		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			char *name = pmu->name;
+			const char *name = pmu->name;
 
 			if (parse_events__filter_pmu(parse_state, pmu))
 				continue;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bb2ca29cd7bd..a96ccc5c3b51 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -29,7 +29,9 @@
 #include "fncache.h"
 #include "util/evsel_config.h"
 
-struct perf_pmu perf_pmu__fake;
+struct perf_pmu perf_pmu__fake = {
+	.name = "fake",
+};
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
@@ -967,13 +969,13 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
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
@@ -991,8 +993,8 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 {
 	struct perf_pmu *pmu;
 	__u32 type;
-	char *name = pmu_find_real_name(lookup_name);
-	char *alias_name;
+	const char *name = pmu_find_real_name(lookup_name);
+	const char *alias_name;
 
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
@@ -1974,7 +1976,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 		   name ?: "N/A", buf, config_name, config);
 }
 
-int perf_pmu__match(char *pattern, char *name, char *tok)
+int perf_pmu__match(const char *pattern, const char *name, const char *tok)
 {
 	if (!name)
 		return -1;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bae0de3ed7a5..e90169ab3dc2 100644
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
@@ -249,10 +249,10 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
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
2.42.0.rc2.253.gd59a3bf2b4-goog

