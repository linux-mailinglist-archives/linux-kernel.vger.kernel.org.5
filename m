Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB07FCEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjK2GDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377035AbjK2GCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406E1BCC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so6649487276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237761; x=1701842561; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DVMbIRV+NQmnATStJOD8jb70rfi854C2wLg/boNolQ=;
        b=a4zY/nC+0QtkxYXQUOj8uwuD+fonU+1WoTol7K1a0yha0+XUCYnbvn4CPLXb5tK3aH
         vJt/cKfnVcxmP24DjxQnvxwPtO54xENEs+k/qZd9ROc2TF5IAIZsRGPE6rqvypeJEiG1
         /HC/F5uEqO9iUVYIaSciOoD6+UV7MLN+sOphw68wcXtTHGYqLcijMEeWKxuAvNeaXwGN
         QBiCewTJkOcL76fD7sQPmI4XVSgN/ON246iDDGrjvUROdQvoI9W7COlfzGYRnikJSRDU
         iriSFPigvOQ04ojlxspTj8iOOcmdZHREqd64sZtPw1D/xJXdMW8dhTEOr8jdHR2n5+Nl
         YqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237761; x=1701842561;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DVMbIRV+NQmnATStJOD8jb70rfi854C2wLg/boNolQ=;
        b=IzfmF9QyBZj03vqXwPfUDG1KtbVFqEHzYbS730USS1TCqmINx85h/lUsDNPZ4xrLon
         /zEpNsEI2zDcXfWQ2wPLueZUcXuhqfNFk77HLGI6RQ54RHQ6S5rZEQrEV1kEPmD08+R8
         np0hKzyUhOuKKSAzi0oC9ELPvSDC057vX74GEaQV0RrxeOYElvqlMBSQmkHVNxQOt4SH
         oohs5oKHJUki3NLu7fMMTumpRXashAYUgz+3kCGE6kSYE/6AFXpgUCVNDJQ4/YhN7qV9
         5IMeLcK/ULoN15bVmakzpTh79cLCp+NIvUHyTV0q4IKHIcMLkif50Y9QB/XIgtSaJO4p
         UMFA==
X-Gm-Message-State: AOJu0Yy+xC9xZvX621lRpHsq73s5JE14MUV3AREW1bedFYgk7yEaI/B0
        sifCRwxoIO30LcSjiCwgdrR6oaGy50qt
X-Google-Smtp-Source: AGHT+IHJMRqYtdqiq8wS3BvtGG3WjhuhilD2hoypqMhKE4FVBpXobXp8Db6UyUfeaAWJBMxnRYUQrmZznlQj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:e4c5:0:b0:d9c:801c:4230 with SMTP id
 b188-20020a25e4c5000000b00d9c801c4230mr494820ybh.5.1701237761085; Tue, 28 Nov
 2023 22:02:41 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:08 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-12-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 11/14] perf arm64 header: Remove unnecessary CPU map get
 and put
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

In both cases the CPU map is known owned by either the caller or a
PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 97037499152e..a9de0b5187dd 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -25,8 +25,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	cpus = perf_cpu_map__get(cpus);
-
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 		char path[PATH_MAX];
 		FILE *file;
@@ -51,7 +49,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		break;
 	}
 
-	perf_cpu_map__put(cpus);
 	return ret;
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

