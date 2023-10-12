Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B27C7548
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441994AbjJLR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442007AbjJLR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:57:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B30D8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af53bde4so19851147b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133419; x=1697738219; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14FOksjqV545oUYd4P/1q30YKINPT/rJmn836J71agc=;
        b=VUS2eGTKBUNJ4Xuh3vfwN7wY38OLT7C9FgbHk/fSut55+H1dEGh64qPVffmGFEdGzS
         t0f1eg+8HVslY+34MjmrPYBAybiv+0SO8fKWPLs9NEJtfJtJrUVvGGsyik6YoEFNoM/J
         Oo8WudxEiM5WD0/h9rdk6w6/jHoja496xLVgaWJrz+QMRjwULwSMkxBP0e9T6sJanjbi
         WRv2baZRAuytvHX6JFPaNHTX/FFj/zZtr0vJKbRhYn8fhYapfxmOiFwL+u6wVeNxp6Xp
         8nCRs8QvPitERJqfeALfZN62hWngb0FttuhBR1x4UrNt30mUFVcvMTwQjrRa+L1YaGMj
         K9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133419; x=1697738219;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14FOksjqV545oUYd4P/1q30YKINPT/rJmn836J71agc=;
        b=XZqVmk+AXE5+HY3qLhJ6QLE7M+484dL89umjN2YS/XvJ8jw69efu3z5vrGzKpYBSkC
         FhS9Hjnia9fs5lOlucEYUfW9gNnNvw9JrPiMD43iEdqd3OPcGzDc0xXUhIyhD6oMpN1R
         2NdrRbPLKUgVZjV1FJ6frOg6Fa5BoBrLY3TWyGbLEgru/JdGD2TEX0ZQFbJxPnFFTMCL
         YHqz5UElz3TM7oygGxaQty7+Eys2pKso4DzgQ38ETXt+a/2aK7Qu3mcqrqrS8gJL02ry
         jLP1CaF2NBaMR28ZH5V4O/jWE7bRg+f6Y9TGEkyBRMGVM+/NCTbcPw2J36Rzgl+HXU27
         mtAQ==
X-Gm-Message-State: AOJu0YzZFyqxBGs4ixkPNlbiyLTkMPd4zO50eu6wJur2XXLo0gZd9Zk6
        A+ASWxQV/m58aqrvxLhuhpsC6CHKV6eP
X-Google-Smtp-Source: AGHT+IHgq6meuGbKkQDt+1J9vJsjMlp7VVyn5KqsFhf4Ln1NLHH1bTqBxU7SrG1olske0no0RoZ9hc2QZcjY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a0d:d70d:0:b0:59b:f493:813d with SMTP id
 z13-20020a0dd70d000000b0059bf493813dmr56973ywd.1.1697133419314; Thu, 12 Oct
 2023 10:56:59 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:56:42 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-5-irogers@google.com>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 4/7] perf pmu: Const-ify file APIs
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

File APIs don't alter the struct pmu so allow const ones to be passed.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/pmu.c    | 12 ++++++------
 tools/perf/util/pmu.h    | 11 ++++++-----
 tools/perf/util/python.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d075da0eecc0..861e485e0a70 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -575,7 +575,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	return 0;
 }
 
-static inline bool pmu_alias_info_file(char *name)
+static inline bool pmu_alias_info_file(const char *name)
 {
 	size_t len;
 
@@ -1770,7 +1770,7 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	return !strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe");
 }
 
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
+FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
@@ -1781,7 +1781,7 @@ FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 	return fopen(path, "r");
 }
 
-FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
+FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name)
 {
 	int fd;
 
@@ -1792,7 +1792,7 @@ FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name)
 	return fdopen(fd, "r");
 }
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt,
 			...)
 {
 	va_list args;
@@ -1809,7 +1809,7 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return ret;
 }
 
-int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
 			   const char *fmt, ...)
 {
 	va_list args;
@@ -1826,7 +1826,7 @@ int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
 	return ret;
 }
 
-bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
+bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name)
 {
 	char path[PATH_MAX];
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 588c64e38d6b..24af7297b522 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -222,14 +222,15 @@ bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
  */
 bool perf_pmu__is_software(const struct perf_pmu *pmu);
 
-FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
-FILE *perf_pmu__open_file_at(struct perf_pmu *pmu, int dirfd, const char *name);
+FILE *perf_pmu__open_file(const struct perf_pmu *pmu, const char *name);
+FILE *perf_pmu__open_file_at(const struct perf_pmu *pmu, int dirfd, const char *name);
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
-int perf_pmu__scan_file_at(struct perf_pmu *pmu, int dirfd, const char *name,
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
+	__scanf(3, 4);
+int perf_pmu__scan_file_at(const struct perf_pmu *pmu, int dirfd, const char *name,
 			   const char *fmt, ...) __scanf(4, 5);
 
-bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
+bool perf_pmu__file_exists(const struct perf_pmu *pmu, const char *name);
 
 int perf_pmu__test(void);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c29f5f0bb552..8761f51b5c7c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -98,7 +98,7 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
 	return NULL;
 }
 
-int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...)
+int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
 {
 	return EOF;
 }
-- 
2.42.0.655.g421f12c284-goog

