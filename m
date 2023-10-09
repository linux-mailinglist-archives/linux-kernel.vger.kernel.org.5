Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC57BE9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378307AbjJISkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378250AbjJISjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00708FF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21c283542so84080847b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876787; x=1697481587; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=HPZgNN8loVefaOMfnRHnLVQVv2af1+7RIMbdemt0ihqTnrd+eC09lwm75mFfpYfoK8
         VuM7z5hvPEqcV4xKoabEexIrQXkuMOBoXOzdovVPUOYM7Co1+/FnIRdDj13p3os/Rw7s
         NI8p7mPr7mM5ZF4uZ1mpG8YUhvyXuFinhqEKXJ+MQu3lrzW6kz4bJP3lMkttN6Hqxorz
         mHe7KnritTalDR6fFTBGMfrTMXulwEzrUJ6mji+Y2of/4EV33s2AeShAbwxSMRJ+d02t
         dZitQgZz34BI/Fy+TBjVTcAzYr64CsOm6jp1TlVN3L0JNxAf97JGub/g2KK4QBxJEYCZ
         lAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876787; x=1697481587;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGGlE54ge9XxgsvPeqIZ7isbDlHsMUv/MJYLVA09opo=;
        b=c7LHh6c68UBcV7NEAQ6dnSg0xlbdU2sE56rJHH+sODekPGfjEUnm6sONX5YtI9flgl
         kP8SzQVAN4zk7HTYSuUukOE14Gyk33gQ2wReAODCPwDymV9H1G5/MZdKfOBt+a/JDDTV
         S3KzUfCT14Y5UXRs0lBzDqc5mdm08M15MW5MmCk8ouuz6ESu7cHS057ZUbNCJJA8r0O+
         F1/upvSHAcCVz/WjiVrSQSqQ8uNqlZp5Djj9gpE7gjS6XNhW1bu93AT1grxRHi9nG9R+
         m3LR8gNlmyOEA3+60Q/0oFqR7w9Rfvq2D4taK4XQSXHxiu8gwLcdravgAX+KEU3fJPLG
         ZzwQ==
X-Gm-Message-State: AOJu0YwvTnfpYyENraTCuZoGUxCLZByTF/NVWcWBdI8C429371HLI+7q
        5mTDylk7edg7uOeElFiYG2YF0h28nazi
X-Google-Smtp-Source: AGHT+IGpysIorYdi8kbri+eoNngVpsBmCut1uHA899pI7BzlPq5MUUHT7YyMhz0NTaD8xsX1mPms8KyxGvsu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:c243:0:b0:d89:4d2c:d846 with SMTP id
 s64-20020a25c243000000b00d894d2cd846mr246744ybf.12.1696876787012; Mon, 09 Oct
 2023 11:39:47 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:10 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-10-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 08/18] perf mem-events: Avoid uninitialized read
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmu should be initialized to NULL before perf_pmus__scan loop. Fix and
shrink the scope of pmu at the same time. Issue detected by clang-tidy.

Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 39ffe8ceb380..954b235e12e5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -185,7 +185,6 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 {
 	int i = *argv_nr, k = 0;
 	struct perf_mem_event *e;
-	struct perf_pmu *pmu;
 
 	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
@@ -202,6 +201,8 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = perf_mem_events__name(j, NULL);
 		} else {
+			struct perf_pmu *pmu = NULL;
+
 			if (!e->supported) {
 				perf_mem_events__print_unsupport_hybrid(e, j);
 				return -1;
-- 
2.42.0.609.gbb76f46606-goog

