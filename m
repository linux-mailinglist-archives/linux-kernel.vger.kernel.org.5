Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90602787DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242192AbjHYCkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbjHYCkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583D1AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc4291239so7438567b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931237; x=1693536037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHXteoJsO5CjisE3iWmyoU3o62DiyCouesqp1NV6ZaY=;
        b=aM1+/Q9/kqw9FPRt+ilUC2t7yHLdncPzCcyJOdfOPAzDkrfOyw4un0h7kWm/0Qss3d
         NZFW3A2SdinUDE2lpqWfXf87L12zQUGFk4HnP+F43itYhRV9t8p4sPKvIxpLO4O1e5ry
         xWTvly0fX09Jg95DitgN79YkII2+4qbIpeeQQLydHeV4IFgM1g6nevB8+LkEG1TR1gyo
         IgsiBX1y1/dn65Bvbkbn14tFgtJtGGxxK0KrXwN0HheDF/LrN7dc2LyhkLbEGu0uyqK1
         VEVzzuFW9e/yWmLZP3luTRDeMbdMaF1I55SoCgD1dSo+nZFJUAJiI13BEx3e16PI+zJV
         sRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931237; x=1693536037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXteoJsO5CjisE3iWmyoU3o62DiyCouesqp1NV6ZaY=;
        b=aI8F10oMLIpmleL0oYfcxTY3jL6orlC2XxoaVWZY/UPBpS8x4+iB/SO8aj20Sw1/Ox
         qIcBldOm+YUh36fRuKA1bbJeH1+DhFg9BEVO/lsPBk+rcHY1ClgTdx4Yh9Ngn6Haa9HY
         /Nc4to7jJB+dTTWjE1lQsho+6f5HlbLtUQ7DMw6yqxtkmvSyJLhp3syDqb4uFjQ78OmL
         pd3mfQRteNXfdWRSM3dO8PCcKXsyT1dIM83uBUyqehBzCYS4df8UQ0VWz1qeJdevYYwu
         aWYi8X1LwuOcrYKffzBs0q0zTxTsdFr0Bm/tIyEU0pC10idaEmhPiqPxDjyC7to3zHco
         ytiA==
X-Gm-Message-State: AOJu0Yx3n4+vrwA147yc07NCg37/0sDw78LcNhOP+4LIcjwtCg4y1Kjc
        0PXH/qfp8F+4xlUyoJB4HyjYWqBHHtQR
X-Google-Smtp-Source: AGHT+IGaNkQKvYICmjYwbFYZkcVjwo9/uyNhIHNgKwBwkDBYJTIRQcWeE5epFd3NZyNnRo3DSrMjLPSFkFEv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a81:b660:0:b0:573:5797:4b9e with SMTP id
 h32-20020a81b660000000b0057357974b9emr373461ywk.1.1692931237087; Thu, 24 Aug
 2023 19:40:37 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:40:00 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-5-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 4/6] perf pmu: Make id const and add missing free
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct pmu id is initialized from pmu_id that is read into
allocated memory from a file, as such it needs free-ing in
pmu__delete. Make the id value const so that we can remove casts in
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 4 ++--
 tools/perf/util/pmu.c         | 1 +
 tools/perf/util/pmu.h         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 94937378647a..eb243392c0f4 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -684,7 +684,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		.pmu = {
 			.name = "uncore_sys_ddr_pmu0",
 			.is_uncore = 1,
-			.id = (char *)"v8",
+			.id = "v8",
 		},
 		.aliases = {
 			&sys_ddr_pmu_write_cycles,
@@ -694,7 +694,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		.pmu = {
 			.name = "uncore_sys_ccn_pmu4",
 			.is_uncore = 1,
-			.id = (char *)"0x01",
+			.id = "0x01",
 		},
 		.aliases = {
 			&sys_ccn_pmu_read_cycles,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index eb42f9830be7..b92dc7237f3b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2056,6 +2056,7 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->default_config);
 	zfree(&pmu->name);
 	zfree(&pmu->alias_name);
+	zfree(&pmu->id);
 	free(pmu);
 }
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e90169ab3dc2..73965f208009 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -49,7 +49,7 @@ struct perf_pmu {
 	 * @id: Optional PMU identifier read from
 	 * <sysfs>/bus/event_source/devices/<name>/identifier.
 	 */
-	char *id;
+	const char *id;
 	/**
 	 * @type: Perf event attributed type value, read from
 	 * <sysfs>/bus/event_source/devices/<name>/type.
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

