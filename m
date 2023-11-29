Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01327FE339
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjK2WgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjK2WgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:36:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3219C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:36:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db49589f622so337199276.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701297370; x=1701902170; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXS7/e2VY4X2gQe3kEWDUpAXAmm4xsAO1n9z3bPt+MA=;
        b=j38Jd5HbasSPeHNKCfmy4mnlVxhAxOWxmBqpBdlqRWcQngjrlYGNIS8/H9NSFysi73
         6sc25+fADc0JDTW5gqYuGUF/3k8/OMNPxp0fvEvhjEGsX5Rkn/CGdQttKLVkKUHQRtfN
         3FQCi9bOGiGJMXfJdjp9pqIms/IITxcyIsJ09MXzuPl6yj4pLqrYj/qVEeOgN/KtkFnI
         siOL48+kIUPMMgFYIeXvkw74TqFi79oV7fav9Erm6Zy5betC9OEcjQ/g3+nzp7wgPP98
         8LVJx4397j7r1qtJeyPDM3J4pxiiaTn0QKdqgNOEE1Iw6eUQLaRz4bwGDtH099EuPxA9
         VJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297370; x=1701902170;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXS7/e2VY4X2gQe3kEWDUpAXAmm4xsAO1n9z3bPt+MA=;
        b=DTrK5JGUTJTZ9Ko1BrCsZsN34BnrRSD/1VdlTELu3AfRODgxtoTmnLWO2i7wruGubR
         dF5ULTLlgWcfHr8Xtajb60kxxIuqrm5qgZAMhth1vTkv/LaMgY/XBcCu9qruTcdsgIpT
         5KofVsoYv+cgH++UNoY1V+qjofDrDqdXvN6AVU8zoP/p94dqPYNxzyxV/3iAPmBvxGoU
         ifPzBGGzCsc8lE9MV/zWYQYcvJFhBDiNOZA0L+JDBxOAhOLbhOpccsGQr947tWcRDlGn
         E6r6u0RBv//MMQ2w75XBPojxpSjRmgvqPVMNWogxvyhcg1OcdCnPZZbPCmXooWjBjnD1
         0mvA==
X-Gm-Message-State: AOJu0Yy3mbPSk4dc8DTnqdU60s4sRnEjErXztWlmg8mo+iQYnL4wRLZi
        okw9JMXKgorVObx46kiq740X1+O6kvoj
X-Google-Smtp-Source: AGHT+IGyIcR99e16Ql+7yHk9cIo1V6bGooAvuqVpsvfGfU0chUWlBlm5DOUyxAipjVYAsyWt9PiLLaEIu6yW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:70ed:81b4:2b6c:fbc0])
 (user=irogers job=sendgmr) by 2002:a25:24d8:0:b0:db5:2a4:c55b with SMTP id
 k207-20020a2524d8000000b00db502a4c55bmr189209ybk.2.1701297369900; Wed, 29 Nov
 2023 14:36:09 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:35:40 -0800
Message-Id: <20231129223540.2247030-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1] perf stat: Fix help message for --metric-no-threshold option
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
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy-paste error led to help message for metric-no-threshold repeating
that of metric-no-merge.

Reported-by: Stephane Eranian <eranian@google.com>
Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a3af805a1d57..c77a3308d3fb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1255,7 +1255,7 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
-		       "don't try to share events between metrics in a group  "),
+		       "disable adding events for the metric threshold calculation"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-- 
2.43.0.rc1.413.gea7ed67945-goog

