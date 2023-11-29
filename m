Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A077FCEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377031AbjK2GCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjK2GCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:02:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AF1BC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so6649263276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701237747; x=1701842547; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u4ZVQm6BXfm09/tS57asaxt2XeV8jv3rjSJhFgaw+iA=;
        b=ybnh1lIHrqCD75MWPzDGjjlZEGSE6JvL1bGsP63SmVP5TDDczIG0mK42B2wyYyKJAe
         GhcmUFT2PqIqEqK3kr+XjXEhpcv+O8K28eAikeVJ73WIPedf8e0+uUveJ233kGX3JH8g
         dP85102lX13NMXZenBa2nDjZ6b4QhCi/Jlo9QPKv3Xf7cOeP/toykEweiA1zY1MPrtdq
         CW9hwAk4MaBwoYaLIDmsEUrNDky2rJvMNtFNjHNhtHFh5VoN4UrZwol6AgZ1sym/pjMK
         OVpuBRsaiz4pudo/ld/F+Tc2tvFl/TUNukOV7/y90p1vHrNs4VYAbgEPGFxNkX/7840g
         iZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701237747; x=1701842547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4ZVQm6BXfm09/tS57asaxt2XeV8jv3rjSJhFgaw+iA=;
        b=HhVCTldSxZyc1AFJ7unyYNDxvxQpu1bOO6T/NpaXcr0fqBbBIJSxejr5+GWwRw02p1
         BYc5ZSiKBvLKKp6a3tSIhK1p6QIM27DMA79oGci4lcSfEPjOb+UNdD60z8WLYxZDv+IO
         4lcdiLkuA65SSRf5DWyPA7m5YO7TMgvKS2selWsX4WB/SpGpq8GMRii6qn6nAqFRskoP
         z8cxxlhCDpaqBDLAJfrqcvOJ8viUt5vdXl7v/F8kEzkAWliF9xebK5YCLfkcUKF6S8kL
         KhKQdPmP+iEw3j2dUd+HGwFqJZQYCcjWVnKRCRBmqilPMAGeQUMuuDVHQndkfYOALGlU
         vgSA==
X-Gm-Message-State: AOJu0Yz8V0Z9jvHQFNfEcr32u0xEQs9RJkhOq37B4ckK/1Sigz6ukI6s
        HHNdVT1mB6NJTFJiqQ/lIpGCSp5ziWQF
X-Google-Smtp-Source: AGHT+IGrbmAcgGFKWGO4CN4DZuwGzNNirWTnRPFt7368NYxc+4IVjA+ETsxRxMz4iHCrslIZ6bnFdP+hkjGF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:7141:0:b0:da0:c9a5:b529 with SMTP id
 m62-20020a257141000000b00da0c9a5b529mr472146ybc.12.1701237746973; Tue, 28 Nov
 2023 22:02:26 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:02:02 -0800
In-Reply-To: <20231129060211.1890454-1-irogers@google.com>
Message-Id: <20231129060211.1890454-6-irogers@google.com>
Mime-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 05/14] libperf cpumap: Add for_each_cpu that skips the "any
 CPU" case
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

When iterating CPUs in a CPU map it is often desirable to skip the
"any CPU" (aka dummy) case. Add a helper for this and use in
builtin-record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/cpumap.h | 6 ++++++
 tools/perf/builtin-record.c          | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 9cf361fc5edc..dbe0a7352b64 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -64,6 +64,12 @@ LIBPERF_API bool perf_cpu_map__has_any_cpu(const struct perf_cpu_map *map);
 	     (idx) < perf_cpu_map__nr(cpus);			\
 	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
 
+#define perf_cpu_map__for_each_cpu_skip_any(_cpu, idx, cpus)	\
+	for ((idx) = 0, (_cpu) = perf_cpu_map__cpu(cpus, idx);	\
+	     (idx) < perf_cpu_map__nr(cpus);			\
+	     (idx)++, (_cpu) = perf_cpu_map__cpu(cpus, idx))	\
+		if ((_cpu).cpu != -1)
+
 #define perf_cpu_map__for_each_idx(idx, cpus)				\
 	for ((idx) = 0; (idx) < perf_cpu_map__nr(cpus); (idx)++)
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8ec818568662..066f9232e947 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3580,9 +3580,7 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cp
 	if (cpu_map__is_dummy(cpus))
 		return 0;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		if (cpu.cpu == -1)
-			continue;
+	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, cpus) {
 		/* Return ENODEV is input cpu is greater than max cpu */
 		if ((unsigned long)cpu.cpu > mask->nbits)
 			return -ENODEV;
-- 
2.43.0.rc1.413.gea7ed67945-goog

