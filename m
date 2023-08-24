Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABF787B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbjHXW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbjHXW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:27:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353E1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbc0e0c6dso4891597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692916041; x=1693520841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yz2521idZC7Ay4NTiFNMcjkHoMtrhiUpIqFT4nzfTmE=;
        b=MTnsyQ9/Jse2ezqhFINqxxpg5HasXI35lYvN01ug0krp+X2r42cOgjd9Gw+FPdhSai
         /4E5yuHcfFabrdZ6wt9sUxMQbcGkfrSZIKjRFOMXjOPvaouEZ1dsTN+LfJVsSVO1bPcR
         MkGEKjEBSCVfZZWj/tU8zf78BED9gU9bPJdHlUeC7cWjfGSTOd/byJkCcW65Ac2LiUJl
         4OO0KCqaTIrkg+2SoqafKk+IhRkVWbC918bVHdmWN6TGw7etFNEWo0Qxr6yi9ACgNcDk
         USzSndu/8JlmT4CHjETEHyZTYbuBQ9nf69SitrRcn2Uw3NoQkIXKMW+J4bIaUi/GxlD2
         pt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916041; x=1693520841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz2521idZC7Ay4NTiFNMcjkHoMtrhiUpIqFT4nzfTmE=;
        b=MPJPAJ9sg7bUAyxtnKrtfzF7nDp8HnYRXb8N2+deh9XDHxQn65RW4G+61qHGy3P6T0
         dZLk5cLfqvG4G6a7YfRZaz4ByU9NdOBDpoJx7W7VH66zyHveMCF+/a88WwIFToMscOH3
         +QOmzqfUDkzRMzyGBoddFe8De8ckoMPWrLi5UQv18SzosC3w8vEUe4NBcCVKrsdgd741
         nlOrz5IvYqrPLGWSQifPJ7UI7qv9pj3FkzTn9Hc47wowVXx0YrtO3ZcQziMSipJ8lNas
         XGGC/jfW9kHTGAvFHLMRp98gDaV0ErAtHAIRPDtkGlibvV4AB0+WPn8896sN3iN76E5n
         JOEA==
X-Gm-Message-State: AOJu0YzWK+zGBbwPgX4FxxJdJX4vDcOsXqNAyPVzgWcpGJwMwnA1VF0Z
        LYs2+NXvGFZEKlMhsYCw0kqA/1qYQXd6
X-Google-Smtp-Source: AGHT+IFV2YTX24TKdDAUJ4fkcyCUvTxrmg1T3lOrvDgTQNZMIiZY7MeSOBobk1CP6++gdx2snH68EZ21YZQx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:af03:0:b0:583:9913:f293 with SMTP id
 n3-20020a81af03000000b005839913f293mr305363ywh.1.1692916041696; Thu, 24 Aug
 2023 15:27:21 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:27:15 -0700
In-Reply-To: <20230824222716.553982-1-irogers@google.com>
Message-Id: <20230824222716.553982-2-irogers@google.com>
Mime-Version: 1.0
References: <20230824222716.553982-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v4 1/2] perf pmus: Sort pmus by name then suffix
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
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort PMUs by name. If two PMUs have the same name but differ by
suffix, sort the suffixes numerically. For example, "breakpoint" comes
before "cpu", "uncore_imc_free_running_0" comes before
"uncore_imc_free_running_1". Suffixes need to be treated specially as
otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
etc. Only PMUs starting 'uncore_' are considered to have a potential
suffix.

Sorting of PMUs is done so that later patches can skip duplicate
uncore PMUs that differ only by there suffix.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 4dd5912617ff..b1f6a64693fe 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/list.h>
+#include <linux/list_sort.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
+#include <ctype.h>
 #include <dirent.h>
 #include <pthread.h>
 #include <string.h>
@@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
+static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
+{
+	int orig_len, len;
+
+	orig_len = len = strlen(str);
+
+	/* Non-uncore PMUs have their full length, for example, i915. */
+	if (strncmp(str, "uncore_", 7))
+		return len;
+
+	/*
+	 * Count trailing digits and '_', if '_{num}' suffix isn't present use
+	 * the full length.
+	 */
+	while (len > 0 && isdigit(str[len - 1]))
+		len--;
+
+	if (len > 0 && len != orig_len && str[len - 1] == '_') {
+		if (num)
+			*num = strtoul(&str[len], NULL, 10);
+		return len - 1;
+	}
+	return orig_len;
+}
+
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
@@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 }
 
+static int pmus_cmp(void *priv __maybe_unused,
+		    const struct list_head *lhs, const struct list_head *rhs)
+{
+	unsigned long lhs_num, rhs_num;
+	struct perf_pmu *lhs_pmu = container_of(lhs, struct perf_pmu, list);
+	struct perf_pmu *rhs_pmu = container_of(rhs, struct perf_pmu, list);
+	const char *lhs_pmu_name = lhs_pmu->name ?: "";
+	const char *rhs_pmu_name = rhs_pmu->name ?: "";
+	int lhs_pmu_name_len = pmu_name_len_no_suffix(lhs_pmu_name, &lhs_num);
+	int rhs_pmu_name_len = pmu_name_len_no_suffix(rhs_pmu_name, &rhs_num);
+	int ret = strncmp(lhs_pmu_name, rhs_pmu_name,
+			lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_name_len : rhs_pmu_name_len);
+
+	if (lhs_pmu_name_len != rhs_pmu_name_len || ret != 0 || lhs_pmu_name_len == 0)
+		return ret;
+
+	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
+}
+
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(bool core_only)
 {
@@ -156,6 +202,8 @@ static void pmu_read_sysfs(bool core_only)
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
 	}
+	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
 		if (!core_only)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

