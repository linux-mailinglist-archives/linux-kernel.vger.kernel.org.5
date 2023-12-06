Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0B8077A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378806AbjLFSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbjLFSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:35:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA703D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:35:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c5daf2baccso448577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701887737; x=1702492537; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B2/YElcFb78YmCVTTtjEUczkDmkglR+f6tXmRIs88Pc=;
        b=lpI5S7KZve6rDwSg9JJuwFXZi3JkCxVRCkaFNLUCQlGo9HFSQI1at6FI526w7WbY3R
         ntP5ih+FAqVRNL3o1ZV4A4EZuppjCU4bp1IlDErRnOAzhbMIGuoy0YXCOZdynmztQ1qa
         a6ieddnGtqPT1gMMhhXHYPjAClSqmu8JWSriqMFYv1eIg5IpJw20+JYVpT9X3EDymwOm
         DGHuk+767I4cQmjyMCYRvZiF/qavx5EDSL4PgxNuMsXXVbCQH01iyMY77N+GtbT/P3BW
         Wk+BHlZFv11jl9hVMkNRX3KdW6cY/xmHhZF0Iwmm/GmYEERduyErsKcEWb+XrQa653P2
         Yo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701887737; x=1702492537;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2/YElcFb78YmCVTTtjEUczkDmkglR+f6tXmRIs88Pc=;
        b=wFLUA532xOqUjk213a5xTtup5glUu42hzcrUpf92LX9jpMw16XVnZSwHbiA7Zcrgsx
         W1QUQuHU94CbTE36w4H61yfgcEVUl39e8hu7/QJyjyWTLNod8ou3gQ+NwU22T0SEHrE3
         EnFKGOi6FZ0ID37xGAbALs5jwkbN4ItHkidg1rjk2IGvz4InD+hgFpg5vv8xXXNxl4aN
         yJfcoMFF9wnlw9tAAgl8gpdz9a38uQXYqVZFf30YHvVwJjYWeFoAXchsPs6efHyiFuXR
         8H5vBnsVz/Wrwxvt7VPl3FtSaCLdJS+J2Fn8npD3CgAqxmMpldfgbx0ZCEj6qO/TTqf+
         t4OQ==
X-Gm-Message-State: AOJu0YxmESXLFMKgWBz+heJlPfJFXGH6Tec4PrJC1G4bp2nv1d4xn8vM
        DWyZFduhKQXAcBlBslyUUd3vMvAwxoG5
X-Google-Smtp-Source: AGHT+IFZUxuND2td+Pez2UzFtuP3tourqWfU0yR+9nJpAFBDlD4Cc/EBL7A37Z5pgGaT7kEPMo9vpuaFfND5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fe7d:8e90:65a9:5cbe])
 (user=irogers job=sendgmr) by 2002:a81:af04:0:b0:5d8:95b:af70 with SMTP id
 n4-20020a81af04000000b005d8095baf70mr21731ywh.4.1701887737162; Wed, 06 Dec
 2023 10:35:37 -0800 (PST)
Date:   Wed,  6 Dec 2023 10:35:33 -0800
Message-Id: <20231206183533.972028-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf stat: Exit perf stat if parse groups fails
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Metrics were added by a callback but commit a4b8cfcabb1d ("perf stat:
Delay metric parsing") postponed this to allow optimizations based on
the CPU configuration. In doing so it stopped errors in metric parsing
from causing perf stat termination. This change adds the termination
for bad metric names back in.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Closes: https://lore.kernel.org/lkml/ZXByT1K6enTh2EHT@kernel.org/
Fixes: a4b8cfcabb1d ("perf stat: Delay metric parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d8e5d6f7a87a..d22228eddccb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2695,15 +2695,19 @@ int cmd_stat(int argc, const char **argv)
 	 */
 	if (metrics) {
 		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+		int ret = metricgroup__parse_groups(evsel_list, pmu, metrics,
+						stat_config.metric_no_group,
+						stat_config.metric_no_merge,
+						stat_config.metric_no_threshold,
+						stat_config.user_requested_cpu_list,
+						stat_config.system_wide,
+						&stat_config.metric_events);
 
-		metricgroup__parse_groups(evsel_list, pmu, metrics,
-					stat_config.metric_no_group,
-					stat_config.metric_no_merge,
-					stat_config.metric_no_threshold,
-					stat_config.user_requested_cpu_list,
-					stat_config.system_wide,
-					&stat_config.metric_events);
 		zfree(&metrics);
+		if (ret) {
+			status = ret;
+			goto out;
+		}
 	}
 
 	if (add_default_attributes())
-- 
2.43.0.rc2.451.g8631bc7472-goog

