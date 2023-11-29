Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAA7FCEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377044AbjK2GDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377032AbjK2GCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732419BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:49 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ccf44b0423so84980867b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237768; x=1701842568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdtDmuZlpO8R+sCZuGq6XIuCqB6n5MWFW+Mek7m4zb4=;
        b=gotxKEv80wkHKfwOnrYUFZ1P/QiffG8FS3MtPA9e9ms22h6ijUbW+/gk/3Zc3rYqX0
         eZz+enL5hNKX61jBBi0F1WtSYodUp0KpUX0MiQqCsSrT/qXGNmklX1bKK2dXW1i/3Guh
         MM7V904BCR9zGFc5AfXVYQ5S73yHjMZy5c+XG61hU70H/MmXc3WWwh8KYVR4SjJ0Syni
         Rn5Hs4cyevaUfF4b13San60VPFuoeKeaYqYnr/RLHSErNHnx9jmQPu6EDahzQGId4VAh
         azirywDrQQrMois+BFSzJlyIygMrwJDTghbRccfFE9s6SSQCoVEgWC2fXFTexinuJ6R2
         1OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237768; x=1701842568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdtDmuZlpO8R+sCZuGq6XIuCqB6n5MWFW+Mek7m4zb4=;
        b=BLwSjT4lGLlFyTMtkS27MltMa1Yzl3Kr3WCWXTGOYu2DHxxJkDdmw/weRm3tDmSLRk
         SiwPcUgyt0zdO493N+opi39iawr9ubXlDcCrXxirq/QIGvaX9oc0VPOjizJYrjFCu/qI
         SZrn639al8+q4aP/TLJ5GWvAtvHK3r0Wk1Vd0/26OuQCjKH1Ii33Q6z/NOjOmvbGssDc
         XbXixhf5qbHdxZibse0XB/ep09hzJlm1YvC2kVl4qspQj1yYXp2PjMNH7pNDsWNPxXKN
         iHdLvv25CNRjj1bFEMGxp67lp89tFQ62R/hMpv+hjo+1+zyhiY/QX5e/2WbTC7UEUZQV
         x5sQ==
X-Gm-Message-State: AOJu0Yyxmc/chmJppg0ictwX++nJfSV8Br4eUPWKhtgFf9CduJF0INqj
        ebctHFvYrne+yPy3FR4y5WGs0nlIlPmh
X-Google-Smtp-Source: AGHT+IFWysPah8NVdJGuOS/cub7nCqzkPRr9kIA04P1LJGn4EJzUePlje+77t8xYTmBpNHAmkcV+MNHmEHhD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a05:690c:fcd:b0:5ca:fef:82a4 with SMTP id
 dg13-20020a05690c0fcd00b005ca0fef82a4mr623872ywb.4.1701237768039; Tue, 28 Nov
 2023 22:02:48 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:11 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-15-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 14/14] libperf cpumap: Document perf_cpu_map__nr's behavior
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
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

perf_cpu_map__nr's behavior around an empty CPU map is strange as it
returns that there is 1 CPU. Changing code that may rely on this
behavior is hard, we can at least document the behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/cpumap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 523e4348fc96..90457d17fb2f 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -44,7 +44,18 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
 							 struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
+/**
+ * perf_cpu_map__cpu - get the CPU value at the given index. Returns -1 if index
+ *                     is invalid.
+ */
 LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+/**
+ * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu returns a
+ *                    cpu of -1 for an invalid index, this makes an empty map
+ *                    look like it contains the "any CPU"/dummy value. Otherwise
+ *                    the result is the number CPUs in the map plus one if the
+ *                    "any CPU"/dummy value is present.
+ */
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 /**
  * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
-- 
2.43.0.rc1.413.gea7ed67945-goog

