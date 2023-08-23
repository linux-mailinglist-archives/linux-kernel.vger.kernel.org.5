Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E5785270
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjHWIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjHWIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B57E74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e4d2b7d16so71990177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778117; x=1693382917;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVPNIKRWrRX85pZfkeIbGqGN+aZoz9nclv8JB/Dx+DY=;
        b=2maq36UDs0VaiEhSZa+HOihekElrL31Y7dnJsQtE8bZUDmRBFN1lR+rsLege7SaQtM
         RC+t3k9R4dvAeanDR/0eqeLUy6eDraJwzyW3yUHNYpbCCTMH2eT9TDmEWUFZ84/MWwX1
         zxFZvceDTzy0qiEKhDlYcDOepm3nzaCNoJ0OuHLlUkGbMiywB8oGzvw/kpFoak+otjCB
         Bvep9JpQO5Fx9/PtTYdv/CM+sKZ9PFJD4CBCQFBuHIBxTkhj4kZP9ZX970g49ZXXX5x5
         rsI1VPoyeDPgF5Un3KGeDxnrvMZFa5KESm5+vHquELPRCYpdNy2zsdpTQcKGzLRX/7Ge
         6oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778117; x=1693382917;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVPNIKRWrRX85pZfkeIbGqGN+aZoz9nclv8JB/Dx+DY=;
        b=XiivqRshKb6rfK+4Wm6MXm/JRRhd+d25kohdI0o6Zy2mYMPJ1WWuR/gs2GehIGM1td
         cfxbVuRv6XkH+9wFDmous1sIgQAbH6Kx5q0VhXFiQThkAFM+AsGsnL/pSxsfve86orFO
         NaDE4wF73rmNjT729QtJirmIw6/PRBIHlrP9tLpZmRbDanH9qC1zvC4yWmtreR62nu//
         sWxuWU1dN7uJOu1h6RoNExnV+UQI8nPEfUdweZZMSY+iJovgb6oOhybRq2rdPDW7Q0oS
         S7L4kS2B1i33bSZlZXskxHqgrFwPA+lbs1hAFq1Gg/A7aqlJnzsyze7tIUuf+qDEy7pU
         h/cw==
X-Gm-Message-State: AOJu0YzuVEfaqO3yHQfryKYy7KmPMMVa2a9bdo5cB45C560rNklEYNGk
        6NdtB8SSuViPh944mjz72wExvVGSiywQ
X-Google-Smtp-Source: AGHT+IGNtc+vuUpoFkBQPAmSbNQ4ZcXCetCAAcNdD4zTkg2mp9pmA9kBpq8P8G/UaaTc8ofzxTgEMsGtFGHK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:691:b0:d4e:e2ae:e0c8 with SMTP id
 i17-20020a056902069100b00d4ee2aee0c8mr146979ybt.1.1692778116848; Wed, 23 Aug
 2023 01:08:36 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:05 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-3-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 02/25] perf pmu: Avoid a path name copy
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

Rather than read a base path and append into a 2nd path, read the base
path directly into output buffer and append to that.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a7f05e4dda97..7683c6749d66 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1756,17 +1756,19 @@ int perf_pmu__event_source_devices_fd(void)
  * then pathname will be filled with
  * "/sys/bus/event_source/devices/cs_etm/format"
  *
- * Return 0 if the sysfs mountpoint couldn't be found or if no
- * characters were written.
+ * Return 0 if the sysfs mountpoint couldn't be found, if no characters were
+ * written or if the buffer size is exceeded.
  */
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename)
 {
-	char base_path[PATH_MAX];
+	size_t len;
 
-	if (!perf_pmu__event_source_devices_scnprintf(base_path, sizeof(base_path)))
+	len = perf_pmu__event_source_devices_scnprintf(buf, size);
+	if (!len || (len + strlen(pmu_name) + strlen(filename) + 1)  >= size)
 		return 0;
-	return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filename);
+
+	return scnprintf(buf + len, size - len, "%s/%s", pmu_name, filename);
 }
 
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags)
-- 
2.42.0.rc1.204.g551eb34607-goog

