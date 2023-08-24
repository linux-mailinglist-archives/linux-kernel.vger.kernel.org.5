Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB87877EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbjHXSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbjHXSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:32:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7E51BEF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:32:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583312344e7so2317597b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692901941; x=1693506741;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNeeSRjShfUBxK20UmYelF8xLtXN72q85W2K9O6AewU=;
        b=6eeGKylvsVaRxqcWbxgaNrUL6kMoeIfCaARcdvzuxV1Qk1Nn5wH02JO8+6/0T4pV1I
         WZmUizQ6I7z2UHZ1tEsl8/bmQ/3t26lY0YiMcdEUVv/YeXJ3T5rnY+ZSLgx30PsG0/o/
         7fH1Z85JmLBIX+EOYlLRcAzB2CkGJhzgMadtQVB/p5Mn2yZ3zVRST+Eq42Fbp8jRT2Zd
         XCGR9jx6OKM0EAIC0lPTeCjqT/M1FsSHOZaz/JFRbqlS3OkgzH4vWqw+QL1XXHBmKSkV
         uLv9sMAKA9GD09u63qp4hIjQOv4ZRu31x5nmzCaDkhRqYrJgE0USb0fFiXEWT0sj0nb6
         0vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901941; x=1693506741;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNeeSRjShfUBxK20UmYelF8xLtXN72q85W2K9O6AewU=;
        b=gt3gb8VITDgQLdxekYTQkwDGt3fwAUIKZFOYiPECUmuCFHIcYLfKPbeikNDKL0mjkb
         yw1qEd21izxp7xnN8NzMZJ4z+lOAtSM4CddyMoTAF8Jq1/lA/fDkgFDlXdaadYwEI7TR
         1LUl9krti91tPJ1vOXIRsmT3DeYCXQq7IyoHVSnK+bACa+RfyHP+p5AO1AkJ54qcHLOf
         srUE0cmOu9lfIQiOsEaI19eWLND5I3C40RrBE2J4rCMuV48/VSfH2EExXDO9lCRlBqNy
         hpJnP1pC+A+k7jETcQS7uSDYtg6wWVuOchN2FXb2M6xpZ6puir6DcpnOt3M7wSrUUt1U
         b94A==
X-Gm-Message-State: AOJu0YySfNiSOg4NdvjYBNlngXCCE8n5gtr45aX6cbZPZyO0jiXiRQJG
        TKUpq0HxS6bxtfVKQhU7weNnBju/i9qL
X-Google-Smtp-Source: AGHT+IEHDSXwTvSkKB3beLc6wwOSaR1G9iaM3BAUwl25BtxYOXui5MNMrOMvZkCSI2+nprUfgTJaaCdXNoGt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a25:bc8a:0:b0:d78:2f4c:7df with SMTP id
 e10-20020a25bc8a000000b00d782f4c07dfmr315ybk.12.1692901941141; Thu, 24 Aug
 2023 11:32:21 -0700 (PDT)
Date:   Thu, 24 Aug 2023 11:32:12 -0700
Message-Id: <20230824183212.374787-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v3] perf jevents: Don't append Unit to desc
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
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

Unit with the PMU name is appended to desc in jevents.py, but on
hybrid platforms it causes the desc to differ from the regular
non-hybrid system with a PMU of 'cpu'. Having differing descs means
the events don't deduplicate. To make the perf list output not differ,
append the Unit on again in the perf list printing code.

On x86 reduces the binary size by 409,600 bytes or about 4%. Update
pmu-events test expectations to match the differently generated
pmu-events.c code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c        | 13 ++++++++++++-
 tools/perf/pmu-events/jevents.py |  7 -------
 tools/perf/tests/pmu-events.c    | 22 +++++++++++-----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 7fec2cca759f..d8b9f606e734 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -145,9 +145,20 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		putchar('\n');
 
 	if (desc && print_state->desc) {
+		char *desc_with_unit = NULL;
+		int desc_len = -1;
+
+		if (pmu_name && strcmp(pmu_name, "cpu")) {
+			desc_len = strlen(desc);
+			desc_len = asprintf(&desc_with_unit,
+					    desc[desc_len - 1] != '.'
+					      ? "%s. Unit: %s" : "%s Unit: %s",
+					    desc, pmu_name);
+		}
 		printf("%*s", 8, "[");
-		wordwrap(desc, 8, pager_get_columns(), 0);
+		wordwrap(desc_len > 0 ? desc_with_unit : desc, 8, pager_get_columns(), 0);
 		printf("]\n");
+		free(desc_with_unit);
 	}
 	long_desc = long_desc ?: desc;
 	if (long_desc && print_state->long_desc) {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e5bce57f5688..712f80d7d071 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -357,13 +357,6 @@ class JsonEvent:
       self.desc += extra_desc
     if self.long_desc and extra_desc:
       self.long_desc += extra_desc
-    if self.pmu and self.pmu != 'cpu':
-      if not self.desc:
-        self.desc = 'Unit: ' + self.pmu
-      else:
-        if not self.desc.endswith('. '):
-          self.desc += '. '
-      self.desc += 'Unit: ' + self.pmu
     if arch_std:
       if arch_std.lower() in _arch_std_events:
         event = _arch_std_events[arch_std.lower()].event
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 3dc1ebee4d9f..28c8789c4305 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -129,7 +129,7 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
 	.event = {
 		.name = "uncore_hisi_ddrc.flux_wcmd",
 		.event = "event=0x2",
-		.desc = "DDRC write commands. Unit: hisi_sccl,ddrc",
+		.desc = "DDRC write commands",
 		.topic = "uncore",
 		.long_desc = "DDRC write commands",
 		.pmu = "hisi_sccl,ddrc",
@@ -143,7 +143,7 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.event = {
 		.name = "unc_cbo_xsnp_response.miss_eviction",
 		.event = "event=0x22,umask=0x81",
-		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox",
+		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 		.topic = "uncore",
 		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 		.pmu = "uncore_cbox",
@@ -157,7 +157,7 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 	.event = {
 		.name = "event-hyphen",
 		.event = "event=0xe0,umask=0x00",
-		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox",
+		.desc = "UNC_CBO_HYPHEN",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_HYPHEN",
 		.pmu = "uncore_cbox",
@@ -171,7 +171,7 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 	.event = {
 		.name = "event-two-hyph",
 		.event = "event=0xc0,umask=0x00",
-		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox",
+		.desc = "UNC_CBO_TWO_HYPH",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_TWO_HYPH",
 		.pmu = "uncore_cbox",
@@ -185,7 +185,7 @@ static const struct perf_pmu_test_event uncore_hisi_l3c_rd_hit_cpipe = {
 	.event = {
 		.name = "uncore_hisi_l3c.rd_hit_cpipe",
 		.event = "event=0x7",
-		.desc = "Total read hits. Unit: hisi_sccl,l3c",
+		.desc = "Total read hits",
 		.topic = "uncore",
 		.long_desc = "Total read hits",
 		.pmu = "hisi_sccl,l3c",
@@ -199,7 +199,7 @@ static const struct perf_pmu_test_event uncore_imc_free_running_cache_miss = {
 	.event = {
 		.name = "uncore_imc_free_running.cache_miss",
 		.event = "event=0x12",
-		.desc = "Total cache misses. Unit: uncore_imc_free_running",
+		.desc = "Total cache misses",
 		.topic = "uncore",
 		.long_desc = "Total cache misses",
 		.pmu = "uncore_imc_free_running",
@@ -213,7 +213,7 @@ static const struct perf_pmu_test_event uncore_imc_cache_hits = {
 	.event = {
 		.name = "uncore_imc.cache_hits",
 		.event = "event=0x34",
-		.desc = "Total cache hits. Unit: uncore_imc",
+		.desc = "Total cache hits",
 		.topic = "uncore",
 		.long_desc = "Total cache hits",
 		.pmu = "uncore_imc",
@@ -238,13 +238,13 @@ static const struct perf_pmu_test_event sys_ddr_pmu_write_cycles = {
 	.event = {
 		.name = "sys_ddr_pmu.write_cycles",
 		.event = "event=0x2b",
-		.desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu",
+		.desc = "ddr write-cycles event",
 		.topic = "uncore",
 		.pmu = "uncore_sys_ddr_pmu",
 		.compat = "v8",
 	},
 	.alias_str = "event=0x2b",
-	.alias_long_desc = "ddr write-cycles event. Unit: uncore_sys_ddr_pmu",
+	.alias_long_desc = "ddr write-cycles event",
 	.matching_pmu = "uncore_sys_ddr_pmu",
 };
 
@@ -252,13 +252,13 @@ static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
 	.event = {
 		.name = "sys_ccn_pmu.read_cycles",
 		.event = "config=0x2c",
-		.desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu",
+		.desc = "ccn read-cycles event",
 		.topic = "uncore",
 		.pmu = "uncore_sys_ccn_pmu",
 		.compat = "0x01",
 	},
 	.alias_str = "config=0x2c",
-	.alias_long_desc = "ccn read-cycles event. Unit: uncore_sys_ccn_pmu",
+	.alias_long_desc = "ccn read-cycles event",
 	.matching_pmu = "uncore_sys_ccn_pmu",
 };
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

