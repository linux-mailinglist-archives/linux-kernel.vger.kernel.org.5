Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A87ABDF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIWFgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjIWFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F71B0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59beb3a8291so52251057b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447357; x=1696052157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=VECHTX8kH/m85pfQg57m3iGB7ST5r0q4pSlbk/RBPLUEh9xIOTdPwJzZtNhxzcXt1D
         +ahbfZbBP3JAFkixzvlI0ewFZW4GlcunjGpWryCSEeMK2+qhtVkuiiVYR5COoTycUKpw
         0uujQVhzYlIEO85f8NNW+5z0i7m+KPQQO2KVZHc0qTvzqZaLz1P3XPcN86MnWnjwlwxU
         +P7VSh9ggnno7K+uzXPag31BZKf4vHqJ2OikvhkPXwD9Qj6YZGcjd5XDCIfErmi4roys
         wX5KxzNtqcQPPlM/nG01lfZVdySQTQhJzYVjmcMgA/bMViIA3iRa0TQB5mxXlQQYL27t
         n33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447357; x=1696052157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gGdTy/Hpx4ZQLMYPilsnkHUZ9OACUdEplw6hC2pVSI=;
        b=I/LZ5oHkhhzqMYXMefgDRUdWJOk22FHhr3yooqBE4jgtW4yajltUJ8tiXGId9daNvv
         CRIy6x0sSSSsZoP5sTLLXlPT2So+7/aiUzxD+sgGfbvbaHB2H7duQoVvV8lq1tR+aaZY
         YnuGdir3RQTvrQ0ZohEbgc/SMjBxSulBXeZR5klLcTmB3yypas1n7TwG1uJwBHMiGSeB
         kI0083TniKpUSWvxIAT4irJbauxXghBPSHpYKdgBv+y/3dQAaSrtd4y+yUK61+ptkbNo
         Sc+O4irvFoAu11146mS2cZcJ8KLIgjn1MEpdeL8OvbjvAkc9P+QRsGT5EqQubNkpm3xt
         /WMQ==
X-Gm-Message-State: AOJu0Yxtur1kxz+XIJuo7/P5UqPLwWJrTh67ws7GfQ2xh4uOHVkqL74M
        91rh/hfmdG7WsInP8HHgV/ieHSPULt6U
X-Google-Smtp-Source: AGHT+IHu3H0RgtYZ8l9qpPGoXpBjWqmDv48DSjpHsFtxnOifuDQfmXQ64ydXe7XcESUrtgiyDqPuQqKHNS6T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a0d:ec52:0:b0:58c:6ddd:d27c with SMTP id
 r18-20020a0dec52000000b0058c6dddd27cmr19945ywn.6.1695447356813; Fri, 22 Sep
 2023 22:35:56 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:06 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-10-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 09/18] perf mem-events: Avoid uninitialized read
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
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
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
2.42.0.515.g380fc7ccd1-goog

