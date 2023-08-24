Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48878669F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbjHXEPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbjHXEOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7D173F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26f9107479bso3050629a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850471; x=1693455271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvLE3Spqr0cSOEv2xXiI7FCQdeqKmdObep26XyHFaEA=;
        b=0vO41xS+LjkPKHDjpVXscNfFqCSMB7ITBrNVNeAk4Paz3gQXB5fvmRpMFfRSHETaP2
         aWU5eGIqYfFxKw+xRhKJowSWPm4if1XXtvaK8jHr3Gl2D0gCNqpCyRlphUWMW4iADo1T
         u7xoBk9UE9lhEz+7eAVJA1J3k8gyH0RBLnGFbPdHrsWFlfdSW1atQLY2nUSwXYTL6FsI
         5cMZ65p7NE8Og8x8tBSXL5p8EoNthY/nwicaGIYjkFKWquqYC8FdAyc6wiGsTvUP8NDo
         99j0fBniQII3hw9CiE9JObznBCYs2OstumIbMBXTR7I+QJFLl6ixvJ76b6bYEs0R4Kk0
         XNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850471; x=1693455271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvLE3Spqr0cSOEv2xXiI7FCQdeqKmdObep26XyHFaEA=;
        b=ID42gAwngfGZMWDwXo5symXjD62rbZX0f9XDkKAjd+qtuwTtotCRVkb9OMcypln7+D
         gd97m61Xu5y4YlRCeT5XNdcFXCrUNkNuY2ReC1e0wkfVDPojlfnpDNdlDuc6C+RTCfxp
         2UhrETSCNIZjl2vzNe8fvpWOWVhyoTZQk1avp0kHsmWed2RuvTypNKIGmp3Sw2graxc7
         JFffZqtd0Eub4m7oXFphUtREVgD1UEx7Jy/V2pqtHhH+ulEk+nAfM2yaC8XJVl2/Vh2B
         b2pkfPItcuJFo0WCGftjv/BBt2khuau2DIC0dUU0iAyRf8VbRaFsrFHwGH9R1Fi67sKv
         locw==
X-Gm-Message-State: AOJu0YyhneRRy6hCiYqasKhxezUTcbEBOFes+QIB363xys/gytuk/7qs
        KlPeDgs6vM/L1cxywO/kh/+a8a3TcyC9
X-Google-Smtp-Source: AGHT+IGPxDqYXAjpEC8kRChbVf9bd4e24xHLGbDbs7LLn6nrJmUfFHbxUsGqfUXPUGgYxtzWEGqbel03lsJ6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a17:90a:d80c:b0:26c:fab1:9e23 with SMTP id
 a12-20020a17090ad80c00b0026cfab19e23mr3745874pjv.0.1692850471230; Wed, 23 Aug
 2023 21:14:31 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:30 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-19-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 18/18] perf jevents: Don't append Unit to desc
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

On x86 reduces the binary size by 409,600 bytes or about 4%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c        | 13 ++++++++++++-
 tools/perf/pmu-events/jevents.py |  7 -------
 2 files changed, 12 insertions(+), 8 deletions(-)

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
-- 
2.42.0.rc1.204.g551eb34607-goog

