Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BA7C7546
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441975AbjJLR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJLR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:56:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2EDB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:56:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso1561917276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133412; x=1697738212; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5nkZcfdBOLCg2JD7+nD32uBrulHPlnA6DzJIE9BS0/8=;
        b=kV5zSE4zWfhTUdCs/rnOxGyYltVNqQ4OXdGQgI9+rmOA2W4gmpFEIeHkfUAOnLHrpl
         TcJ/TAbbmICHBVfMd/Bh9PyYh932Xw2Rqi3rdhzx2N12G0p/QR56fYvPE9IhZBtbRghP
         laHoEVNM3cI/Lze1x9IH0AMLtMB5O1z65wr9HWS22k65q1c7opjUJJSKlIK9hWrKbSsy
         QtbMPdSriu25p0LUh0VrwJSjb/R/g/lqENhdYNumFIGli7uMrBUSOhy9/FtXab4Pgxj1
         s4S3YJ1DL65F0/0Qbo4WmCOGDyBa9WlrmfKmjBYuzZsh+qMGy+qo1RFL9yp7G/K5jN/I
         m4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133412; x=1697738212;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nkZcfdBOLCg2JD7+nD32uBrulHPlnA6DzJIE9BS0/8=;
        b=CnCxI37jH6nir0uA513jIELzMmAqDYgDjU9DDMVxLyCQEYs2j6T3vD95lTq/+1AzEk
         2UecLlkf/4OMd/RqJA45xlnptl5gDXFfnH9O7mApUjkCsyrUlHIWtWJuJaU5fS2D08Nt
         mAJuQ+hVGCt0hoioKRxbo5Y40WvwDvDCGPbmtRxeolDUSmNlBUdjp9OeovbuY1FDkB+F
         rd5GYyLX9njKTbdagYZgMDpN1wgJTtei5ra1k68A3ErCN13xA33zmjwCAh15CJW9tHQ7
         UDyLe+U2OceXfBK+LT9gD6b8CSiSU5OBiqBc/6vJAVk0OEVqp7rcoug9q65J0ss9rkqV
         miTw==
X-Gm-Message-State: AOJu0Yx54gZrCr7uXFuPNHoJcmbD7zdEMIZvhR7pDghW8fnHwWzauSWZ
        dh/36qAvmvgOV++wPUzKML/NZZm8LCOW
X-Google-Smtp-Source: AGHT+IFgphkBNoBU2jpQ3RvZP3I7pTfsySTqC/W3j6gpxm3Z4BfagwfHVCD38rQVI4SUiYGelsSF+fL2bI/t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a25:aa48:0:b0:d9a:be7b:283c with SMTP id
 s66-20020a25aa48000000b00d9abe7b283cmr65087ybi.0.1697133411989; Thu, 12 Oct
 2023 10:56:51 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:39 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-2-irogers@google.com>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 1/7] perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
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

Assign default_config as part of the init. perf_pmu__get_default_config
was doing more than just getting the default config and so this is
intended to better align with the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c  |  8 +++-----
 tools/perf/arch/s390/util/pmu.c |  3 +--
 tools/perf/arch/x86/util/pmu.c  |  5 ++---
 tools/perf/util/pmu.c           | 13 ++++++-------
 tools/perf/util/pmu.h           |  2 +-
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index a9623b128ece..d55d2b15f2e6 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -14,22 +14,20 @@
 #include "../../../util/pmu.h"
 #include "../../../util/cs-etm.h"
 
-struct perf_event_attr
-*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		return cs_etm_get_default_config(pmu);
+		pmu->default_config = cs_etm_get_default_config(pmu);
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
-		return arm_spe_pmu_default_config(pmu);
+		pmu->default_config = arm_spe_pmu_default_config(pmu);
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
 #endif
 	}
 
 #endif
-	return NULL;
 }
diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
index 11f03f32e3fd..886c30e001fa 100644
--- a/tools/perf/arch/s390/util/pmu.c
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -13,11 +13,10 @@
 #define	S390_PMUPAI_EXT		"pai_ext"
 #define	S390_PMUCPUM_CF		"cpum_cf"
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu)
+void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
 	if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
 	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
 	    !strcmp(pmu->name, S390_PMUCPUM_CF))
 		pmu->selectable = true;
-	return NULL;
 }
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 8b53ca468a50..811e2377d2d5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -17,19 +17,18 @@
 #include "../../../util/pmus.h"
 #include "env.h"
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
-		return intel_pt_pmu_default_config(pmu);
+		pmu->default_config = intel_pt_pmu_default_config(pmu);
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
 		pmu->auxtrace = true;
 		pmu->selectable = true;
 	}
 #endif
-	return NULL;
 }
 
 int perf_pmus__num_mem_pmus(void)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6428e2648289..d075da0eecc0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -954,12 +954,6 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu)
 	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
 }
 
-struct perf_event_attr * __weak
-perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
-{
-	return NULL;
-}
-
 static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
 {
 	FILE *file = perf_pmu__open_file_at(pmu, dirfd, "alias");
@@ -991,6 +985,11 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 	return max_precise;
 }
 
+void __weak
+perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+{
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
@@ -1037,7 +1036,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
-	pmu->default_config = perf_pmu__get_default_config(pmu);
+	perf_pmu__arch_init(pmu);
 
 	return pmu;
 err:
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 85190d058852..588c64e38d6b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -233,7 +233,7 @@ bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
 
 int perf_pmu__test(void);
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
+void perf_pmu__arch_init(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
-- 
2.42.0.655.g421f12c284-goog

