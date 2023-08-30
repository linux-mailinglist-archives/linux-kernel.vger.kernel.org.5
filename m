Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2078D0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbjH3AF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjH3AFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:05:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13E41BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:05:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59504967e00so43921447b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693353949; x=1693958749; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UDc2NK3XlTUwXsReE+naes966j+l1MiNSkWpg4Kd34=;
        b=VPmM2wXi7jGNvYmPpEraraopuW2tLna96+tYWV8JErzKHpSqmIVOtGSYyuPne80+q4
         EX6UWlSM57dELr77wx6PPHmgfQ73OL5tGJuYxXggqSh7URKzSKFk6mjqpt9bQSIKx+ec
         xkHo9zwCNjxMATnxpn6GnjLVsTAUbqSr8n3FVgMSv9R3QRyW7iryulLyzBKOwKzBqoic
         5lAh4ZtJj3i5IMFLbscMsVrtY86XfCNWXCo7+i1EqoSndnqUueNdrl+fJwGAzpMCz5Mn
         MtxA6zGKAUtYLRuJHcP4NGq3N18a0Am1S2fl9vASQfKz859+b7+d2ukmSEjmJf7ZMAwB
         K+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693353949; x=1693958749;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UDc2NK3XlTUwXsReE+naes966j+l1MiNSkWpg4Kd34=;
        b=fQshSHx/W7e9+Z4sZQexHqbex4sXcvbHgpJPQKKxCm2ow01yi1zniSMusJe2NvMhmD
         0+lZRfEOqre2xRuS4dpWP/8DwHzPsx39WapsWW+t5MMW6j/Y5LgPWyw/ASAo45cmXq/L
         QU8VkdjPlSEgSy1TRFY+QpRJwXzgfJPXN5UBIvATMBzEvyvQQSrxyTWGzrD/X7kW525f
         CCyq5omHTxUqFKcaVQiOD20g7cK62J01Y4Fxc6obp4xMV1rUyN2sDSs47uhzB8WK7MJQ
         5+o3NUsWXEthpif3RnXrAXY44c05EncSwrkIAKEwTrCdSM/mSZKQnC1Mmb5kj6tkB8UT
         2Nvg==
X-Gm-Message-State: AOJu0YxBXd7Th0S2+pZmrGPt1jSSYQLS9c378tJFtoBXXFbcq+sZ1nIi
        yb0RW6A3D/Rv6Q1pphth1CPNSxX6ZWnX
X-Google-Smtp-Source: AGHT+IEJh99y0GSLoGMM96YsdXu2S3vQccr3hi26MSzWpxQlhPxea8QqIJkEwtT6IcAiOEeezLyrQ5grsLd2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a81:bd41:0:b0:576:b244:5a4e with SMTP id
 n1-20020a81bd41000000b00576b2445a4emr16748ywk.10.1693353949201; Tue, 29 Aug
 2023 17:05:49 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:05:45 -0700
Message-Id: <20230830000545.1638964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf pmu: Avoid uninitialized use of alias->str
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
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

alias is allocated with malloc allowing uninitialized memory to be
accessed. The initialization of str was moved late after it could have
been updated by a JSON event, however, this create a potential for an
uninitialized use. Fix this by assigning str to NULL early. Testing on
ARM (Raspberry Pi) showed a memory leak in the same code so add a
zfree.

Fixes: f63a536f03a2 ("perf pmu: Merge JSON events with sysfs at load time")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cde33e01959a..b3f8f3f1e900 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -532,6 +532,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (!alias)
 		return -ENOMEM;
 
+	alias->str = NULL;
 	INIT_LIST_HEAD(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
@@ -593,6 +594,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 			ret += scnprintf(newval + ret, sizeof(newval) - ret,
 					 "%s=%s", term->config, term->val.str);
 	}
+	zfree(&alias->str);
 	alias->str = strdup(newval);
 	if (!pe)
 		pmu->sysfs_aliases++;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

