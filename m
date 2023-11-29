Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007057FCEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377086AbjK2GC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376999AbjK2GCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363C19B0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d0c4ba7081so38045587b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237759; x=1701842559; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LT6pUkq6nOZyulqCEeWY4llreF+FWbGDdI1GlLo0K+Y=;
        b=3sI5pIGvs/fAI6Opb6EAFgnk3xrzuTRPcS9vxNKmuSZNIyPTDZC0jOo3c14GBriIXC
         Q2RnZlK7OaUe1ia7sa3p1SNKl3gSeuMuWPsaDE9xjqcGmD3OwrHAdkM+yhzhWNCMvmkR
         9gpQWR6Z+ESxHMpgRoxvi+XFHtqQsCZXpPKGdxoBbDMZGf6BBCaJHa5bL57ZVbO8tcY0
         D7OfQgQbecbOXAbOwEmskBN9GUiVn04u50jx44iSqT+yt8+p1/Uvqh+dlwlc20AgS3SE
         /Kr6+ObDr7si897Ss5wEV6AE1jvv6y7YPJLoUHq7vfkGvjB9nhRPcT2ljWrRsjl05tRN
         SjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237759; x=1701842559;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LT6pUkq6nOZyulqCEeWY4llreF+FWbGDdI1GlLo0K+Y=;
        b=Ac7lAWER3YLvdz0NJSVi9hpyiQpSmXOnKOsOMa1JHGbywRhq7f/zHTzsackp3zTFqk
         byj+44b49MsrKwQYBOEKA6V5uGmlIB2T9+Oytqg1G+9wMfoprucFMtdIEL8b5Z8+KtoA
         r863AeT/WoHyiIR+L2WTBUe/D8xaS7bmRWhHbWD1JNI7BUcVDcOTlTFSkK9oZI7LgTx+
         yVt56U7q+zAKxdnvCkcCVK7BqvztC9RSAL0E9BJzDnabS7wvsfWT/A9wITRzO+qD+fCg
         DuyR5qy6LGiiBfuhPtmEHhlENQHbDhaIYj0cCRjhMXTv6thNZyghGb2PPuuMVaPVo+s7
         CJ6Q==
X-Gm-Message-State: AOJu0YycuRKUpSlA1FyxSx9lANsMnA3iee/XLq1UIZkKshJ0lnpdhv1O
        dSsvsNxXNBfr+e072D1uRizb6MRzPXmm
X-Google-Smtp-Source: AGHT+IHcLhZcuRAnfvMJq6pSrYjIxfVYzDocHNgvrzM6qynXE4Nqh8rL8wha0ZAZQAWY4sv3ZhFZ2JZcU4oz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a81:9b10:0:b0:5ca:5fcd:7063 with SMTP id
 s16-20020a819b10000000b005ca5fcd7063mr598732ywg.3.1701237758929; Tue, 28 Nov
 2023 22:02:38 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:07 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-11-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 10/14] perf top: Avoid repeated function calls
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a local variable to avoid repeated calls to perf_cpu_map__nr.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/top.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index be7157de0451..4db3d1bd686c 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -28,6 +28,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	struct record_opts *opts = &top->record_opts;
 	struct target *target = &opts->target;
 	size_t ret = 0;
+	int nr_cpus;
 
 	if (top->samples) {
 		samples_per_sec = top->samples / top->delay_secs;
@@ -93,19 +94,17 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
+	nr_cpus = perf_cpu_map__nr(top->evlist->core.user_requested_cpus);
 	if (target->cpu_list)
 		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
-				perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
-				? "s" : "",
+				nr_cpus > 1 ? "s" : "",
 				target->cpu_list);
 	else {
 		if (target->tid)
 			ret += SNPRINTF(bf + ret, size - ret, ")");
 		else
 			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
-					perf_cpu_map__nr(top->evlist->core.user_requested_cpus),
-					perf_cpu_map__nr(top->evlist->core.user_requested_cpus) > 1
-					? "s" : "");
+					nr_cpus, nr_cpus > 1 ? "s" : "");
 	}
 
 	perf_top__reset_sample_counters(top);
-- 
2.43.0.rc1.413.gea7ed67945-goog

