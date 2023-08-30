Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D3378DBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjH3Skh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjH3Rzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:55:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924D193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:55:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d78406dee59so6214055276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418152; x=1694022952; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nhUMR+Qhbp8y+nwD/HFpoTD9KE/+xTeRonW+Kynw6Ks=;
        b=fBo3tSleXwKoYKYS476vyY88xGz98rxpjgCzOOfW3o0GkW51U1RFsH5GqaF8XXKEjp
         awj2HNt2NSg9yH7S2a0CboFSlRHFjNyYeziSoHvIhJVoN0I6z4U+lX0IV3rXB76VEBfN
         Ur1WbtVM1vTIOK+6Q5iW1QmEidk1I6sQV3Hz//GPzHkxz4gUlIaU4OmisG8LhAe1PNwn
         I/r52Tmk4twPeLRXxNpMQbSqVXMfhisjGme7rhZ5fp/xH0b69XjEkrXUgr/H+CCQS8ho
         qjgZCYgzZvT9TiC7JUkUdKLNs7I4YQhuEk8xZMYUTxDYsHlH76Ki/GfptrDxHNmG362s
         4mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418152; x=1694022952;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nhUMR+Qhbp8y+nwD/HFpoTD9KE/+xTeRonW+Kynw6Ks=;
        b=lOacnNELgMuqo4flIH++PfVJA7Fi/5aPeJAW4c2JIQUKphmch3yq81eRCePoq/b/gH
         XTjG8e+ppya7eRx3Qu2h1Thd6bvdZYwX7qGAS28n/dDtcnfwbwph58/O1WHhMM7gE4xI
         GtdFqmYm52jYptRKL/w34tQzUHDlXmW0QL74x+gibmEHl08bvarphQlyyfac9IDvfrwp
         44aG7HZYSRMoGTWnjgXgDBTDCA0EzPLSL1Sfico/O+slnXJBu9KQMgVqnt246WGQECor
         K1QR+mwp+1UCbn37DX798/6jjsSJDtrD0ZzWUbDb9DZpgZ8Cznuc9oPAU1N2gDGDRf/d
         ZfyQ==
X-Gm-Message-State: AOJu0YxAUT1I4DTVNDANQHYFOHTPoiYMyRjP3fzJHORYEsXb118PW1qs
        LJj//P1r+A5D8LR6u0otfkHXyPJWCrXQ
X-Google-Smtp-Source: AGHT+IGvBdJLMVXF/uFJxe50w5YPhsBZUhYxeG4/YnRgUHTI68Z8YR6f02uPs81VuhpenU633yiHhlN4Ozep
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:bc87:0:b0:d73:bcb7:7282 with SMTP id
 e7-20020a25bc87000000b00d73bcb77282mr85409ybk.8.1693418152443; Wed, 30 Aug
 2023 10:55:52 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:55:43 -0700
Message-Id: <20230830175543.1911892-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf vendor events intel: Fix modifier in tma_info_system_mem_parallel_reads
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
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

The metric is using the wrong format encoding. This fix is in the
converter script PR: https://github.com/intel/perfmon/pull/101

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 94cb38540b5a..2795a404bb58 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -923,7 +923,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
-        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@thresh\\=1@",
+        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@cmask\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches"
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

