Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9D7BC41D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJGCN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjJGCNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:13:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB51CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:13:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86766bba9fso3842066276.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644831; x=1697249631; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fc7EI+IqMoK5GVnqlsLaiP62BnjpCmFT/Si/B7nJZs=;
        b=zJgDK0rZ1nQdVyYd+zr+B9/D9pYts8s5cn8NxT4eo6cErsMSnxIZSgwdaWfnfFDJF9
         qAajyn8qFg6g2Bbq5qRlhKoj0BIUQm1JqwNMeraEjjZW5ks0dYNyU2JJkv2LTyS2Y30Q
         Sq/LNG2/3+e7E8P6NqDp0zH7tEkoPOmTAFhvXj4GLz5YLWsyCsYG2S8CHmbOjtpz1Pyu
         Hn/vRMWAlfnFJK7tqgu02dDExQV0fWZ/Flv6lH+byB7BG8ADP+aVFgcfYyHwWAZ0PVqh
         PpFSTVE2CL3CB/tZSVNoTFZctRrDajpMUOSaGoO/5vszaIIpskzWjLXCDrFdR6uQdKrl
         F2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644831; x=1697249631;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fc7EI+IqMoK5GVnqlsLaiP62BnjpCmFT/Si/B7nJZs=;
        b=UOwGefIpNMFB7g1jZ5ZSNzWacbd233YTWr5LtmQGWQVJ29jaxGfF9QjfNfwtzwoLfV
         vDYIicVjYV1lKbaWTpMxp90TlGFcsrb0TMY8S6PGsTuWBGtu53sfXsSW7EC4Fp0iecPV
         yrjMF7f3FaTpWyIscpKUoHZXTbhOZetdz7PRgkldan8o1L/Ox9Hiout/YZd3CxUJXqcH
         jl6FtmaG6YBHWDz9WvtjopxgPYqdtGiCQqdjph2t2rnhWucKMBPBfxY5jJwFjA7GlTek
         UgYDrBAkTnO6NMTP3PuCwKhaOcs/nBADpUM5dPFsr7EgUrbrognASoHcAFlzb2/sjkDr
         b7nw==
X-Gm-Message-State: AOJu0YyNb2Z7RgoxC0h3wsGeb0jJjYn9ChKKJvWZQkzvibBXho7Ikz66
        Nk159ahvwOFkuUxZX8JCntI5mfT5HTi5
X-Google-Smtp-Source: AGHT+IHrCzJat+rz/BJ6g8m43IhpNWgcQXVdsawjas52P79D5OWVnwHwRJxeKmFFr5isb0ADzqHoPQ82uORz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:e20b:0:b0:d81:817c:582 with SMTP id
 h11-20020a25e20b000000b00d81817c0582mr155263ybe.7.1696644831137; Fri, 06 Oct
 2023 19:13:51 -0700 (PDT)
Date:   Fri,  6 Oct 2023 19:13:21 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-3-irogers@google.com>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 2/7] perf intel-pt: Move PMU initialization from default
 config code
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
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

Avoid setting PMU values in intel_pt_pmu_default_config, move to
perf_pmu__arch_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 --
 tools/perf/arch/x86/util/pmu.c      | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index b923bca939d9..6d6cd8f9133c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -267,8 +267,6 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 
 	attr->config = intel_pt_default_config(intel_pt_pmu);
 
-	intel_pt_pmu->selectable = true;
-
 	return attr;
 }
 
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 811e2377d2d5..949b3e2c67bd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,6 +22,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
+		pmu->selectable = true;
 		pmu->default_config = intel_pt_pmu_default_config(pmu);
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
-- 
2.42.0.609.gbb76f46606-goog

