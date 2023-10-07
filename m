Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B17BC41F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjJGCOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjJGCN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:13:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE2DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:13:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so3545416276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644833; x=1697249633; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pvm9pouxrmYpafgNbDUzq8jjG9nkQlQXFZB/wFYV4ZY=;
        b=gIt3Ep8wQrLm5/xI11pGeuKoRgXc+4+1ky3tENwptnfMrV8Dnhm3eUn1Neff+jr1ht
         nBrZOdSRuch7YtiJZveOIztjN0qXG2QNjG4D/2Tfg4Sd0asjIbseR0Oah4fLyeMSY48S
         YjBwRKLA297NCyCDHgpE6s8X7N/0ObtaPH37elx4oPFSpgPEUoHJXBX4LZnKt4wsx4On
         27bm+ZfEJoxBXe3SB7+49GKV8Zq+8mclPXthEw9fZa46wA3Vdu138lDMb8C0fs4OkOnj
         iXfNjPP8zqpIpu0nSJWP72ij6NxLspjEyzc5fxRiG2DySZRC5e09/vnediUEpzY2KV8B
         Ui+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644833; x=1697249633;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvm9pouxrmYpafgNbDUzq8jjG9nkQlQXFZB/wFYV4ZY=;
        b=vTPqKV2lG67NxYkHtJSxUDNXD10V6CI/giRbg5gH3s+BAFVwUZx0Z7AYb0u5zlAbl6
         Kb2qU6ex8Rym1Sv5xU7FzYOzXNZm9gdcJpXosheYrJXCNCYTJdRIJUetw/IuW4zT1V8y
         9z1WyS0WfVEInoKgniDlV8ltRDMk7AGpMdBKc8uUHJ8NHU3BYBZHm7rC5qnIMQYOYBhc
         jgiyg2eJTRNerpK8xvqg9IvQlrmRjMS4LkCtQJS/Jv0IV5Q/Pxc/AMKYjX7mbbDkndeV
         ghWpa7/4d+4JZhIxGlb1ke06D1OuwOzSlJk16Z6dnGQ0E71qcb+OzOuAMBd8HPKfUJ06
         +ZZQ==
X-Gm-Message-State: AOJu0YzQ7bqD/KOkvTmYYzWB+O4oZDAA8BpwT/pjUign6LFDFmndTrJC
        KWTR73B0BlPfxwRCHGPi3JlSXK1FxE3n
X-Google-Smtp-Source: AGHT+IG/FCsfFR7DMO8ROGGKaKObepHsSbay/fgC+twT50YsCh2lPxyqOr65LGKvE49Mf12qsmL2OTWovX1b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:d313:0:b0:d7b:92d7:5629 with SMTP id
 e19-20020a25d313000000b00d7b92d75629mr166217ybf.8.1696644833466; Fri, 06 Oct
 2023 19:13:53 -0700 (PDT)
Date:   Fri,  6 Oct 2023 19:13:22 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-4-irogers@google.com>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 3/7] perf arm-spe: Move PMU initialization from default
 config code
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

Avoid setting PMU values in arm_spe_pmu_default_config, move to
perf_pmu__arch_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c       | 2 ++
 tools/perf/arch/arm64/util/arm-spe.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index d55d2b15f2e6..f25f68f84a94 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -23,6 +23,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->default_config = cs_etm_get_default_config(pmu);
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
+		pmu->selectable = true;
+		pmu->is_uncore = false;
 		pmu->default_config = arm_spe_pmu_default_config(pmu);
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 9cc3d6dcb849..08a76734ccd2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -516,8 +516,5 @@ struct perf_event_attr
 		attr->sample_period = 4096;
 	}
 
-	arm_spe_pmu->selectable = true;
-	arm_spe_pmu->is_uncore = false;
-
 	return attr;
 }
-- 
2.42.0.609.gbb76f46606-goog

