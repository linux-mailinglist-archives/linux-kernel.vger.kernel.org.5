Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916067FC59A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbjK1Ujp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Ujo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:39:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5F10F0;
        Tue, 28 Nov 2023 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701203990; x=1732739990;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zw/4FOCuSDF79qV8TNkmen9OZECct0nk83Hrv4vpeUs=;
  b=gAfCqzLbhri9uOwqAP2bDgXt1M/OAK9KvX8p4yuJ3cXQYsz8w4ga3Frq
   gKv+J28PejbqLO4svfwOhDg+wHb9E3Gniwmx+qCI7bOMHSvreabZNEeP2
   o9sK3UcuxDSlH2lpWBYb3zWsp2DjaqQPNs5a/5/2nk11NM57aqgxfCPu5
   /PCB0q8lsgfgsw2BXmh9y1AWbE75MVGVqriXBDL17oQJv3tTmpTrLc4ZY
   4Z79IzIlhZowJ3Eym53L8Rr7UhtOwp7eI+7Nca3zmLrSiGqaxjvKes44I
   m5Jo6q6xd5gr+41YVSbW0fxTjot825GjnZru6yXWqnyWn+lyAFfwArQPf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6227785"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6227785"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859563744"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859563744"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2023 12:39:49 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, irogers@google.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>, Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH] perf mem: Fix perf mem error on hybrid
Date:   Tue, 28 Nov 2023 12:39:40 -0800
Message-Id: <20231128203940.3964287-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The below error can be triggered on a hybrid machine.

 $ perf mem record -t load sleep 1
 event syntax error: 'breakpoint/mem-loads,ldlat=30/P'
                                \___ Bad event or PMU

 Unable to find PMU or event on a PMU of 'breakpoint'

In the perf_mem_events__record_args(), the current perf never checks the
availability of a mem event on a given PMU. All the PMUs will be added
to the perf mem event list. Perf errors out for the unsupported PMU.

Extend perf_mem_event__supported() and take a PMU into account. Check
the mem event for each PMU before adding it to the perf mem event list.

Optimize the perf_mem_events__init() a little bit. The function is to
check whether the mem events are supported in the system. It doesn't
need to scan all PMUs. Just return with the first supported PMU is good
enough.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Tested-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 954b235e12e5..3a2e3687878c 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
 	return -1;
 }
 
-static bool perf_mem_event__supported(const char *mnt, char *sysfs_name)
+static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
+				      struct perf_mem_event *e)
 {
+	char sysfs_name[100];
 	char path[PATH_MAX];
 	struct stat st;
 
+	scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
 	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
 	return !stat(path, &st);
 }
@@ -120,7 +123,6 @@ int perf_mem_events__init(void)
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
-		char sysfs_name[100];
 		struct perf_pmu *pmu = NULL;
 
 		/*
@@ -136,12 +138,12 @@ int perf_mem_events__init(void)
 		 * of core PMU.
 		 */
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-			scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
-			e->supported |= perf_mem_event__supported(mnt, sysfs_name);
+			e->supported |= perf_mem_event__supported(mnt, pmu, e);
+			if (e->supported) {
+				found = true;
+				break;
+			}
 		}
-
-		if (e->supported)
-			found = true;
 	}
 
 	return found ? 0 : -ENOENT;
@@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 						    int idx)
 {
 	const char *mnt = sysfs__mount();
-	char sysfs_name[100];
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
-		scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
-			  pmu->name);
-		if (!perf_mem_event__supported(mnt, sysfs_name)) {
+		if (!perf_mem_event__supported(mnt, pmu, e)) {
 			pr_err("failed: event '%s' not supported\n",
 			       perf_mem_events__name(idx, pmu->name));
 		}
@@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 				 char **rec_tmp, int *tmp_nr)
 {
+	const char *mnt = sysfs__mount();
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
 
@@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 				const char *s = perf_mem_events__name(j, pmu->name);
 
+				if (!perf_mem_event__supported(mnt, pmu, e))
+					continue;
+
 				rec_argv[i++] = "-e";
 				if (s) {
 					char *copy = strdup(s);
-- 
2.35.1

