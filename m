Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5727AE3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjIZDKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIZDKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:10:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD141A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:10:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bdb9fe821so147715227b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695697838; x=1696302638; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=YaRZ+521cZY+Hg12Te953aAn4ryWTswlg2S/qICNnNHLAY6SYlo/VmiLGdv8dt5xcS
         PNq5PSFl49UNUsFEUUtB8trZYZBNCyD9LtFuLD3SpaUpODyfpLnUs51rUy3BJYpNgt0I
         BXYry7TNZDsll8VeQlKrF3Ch/cjhPM4HgAKJf+Ez0f8nUKeOkpRSBAFaOPwUnUjGRFvP
         nNShgxa59uNFO2mLQCMM63TxWnIY3Aho5GEQcRvyzWAd4+ePAD1Tg9QLlPLH3IU/uZUP
         q/cywqhwRevUhaSMvVZOHI0OOQ1bv12HMbCN6KQxZDroBaLAUpht2sH8VziGiWz2PaHr
         sVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697838; x=1696302638;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgojMLtTPS7ALj3bYas//tFq8eo4J8/6f82zm1IrmKo=;
        b=LlvpsaBwknWfoLn8QCVlS/s5VdXChRDscV5fsq9GfMt/OFr4yV7JPuyPnyoKeRS053
         RDeaw+Fh0JuE8iyUs1mNLLeD1vfvbSSh6gxBgudKhf9yy+onGTSTUjluV4UoP2voxZUs
         hewjBAB0WWYYnWBcsEipKi+KAOoKoaBUjrZ8tU+fUecv//tMD5Ow5E7+0UfZ4FKDstej
         PDy8fZVSOjiMxiBLNHRX0MQkLWBbRHqirbFvnFGIBIMQd7CDFmGf9J8HDDTFP+8cSHCt
         v9yR1ZOtIP9XdaAtjLFk3jcEQRKLs3GUzRg7T/pXJGcp8L4treoK7GDz8UEydbMGYTzj
         w02g==
X-Gm-Message-State: AOJu0YwUGQ72QlMWlaI4AfGZMUwcTwGx/ebggC07zWEqE0OWHCfztQau
        mE5xjALH/v7K9D5k14f584NZw2zG3+nf
X-Google-Smtp-Source: AGHT+IHxZckfVhFdCEU9eZntTCWfkRDlN6iE5MYOyucP3Lj0GJr7OMGaCQ9kes65z2V5oznPcfvM37kKJJGG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:12aa:898c:dbdf:d8b6])
 (user=irogers job=sendgmr) by 2002:a81:b148:0:b0:59b:f3a2:cd79 with SMTP id
 p69-20020a81b148000000b0059bf3a2cd79mr110510ywh.8.1695697837883; Mon, 25 Sep
 2023 20:10:37 -0700 (PDT)
Date:   Mon, 25 Sep 2023 20:10:34 -0700
Message-Id: <20230926031034.1201145-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
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
        Caleb Biggers <caleb.biggers@intel.com>
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

Broadwell-de has a consumer core and server uncore. The uncore_arb PMU
isn't present and the broadwellx style cbox PMU should be used
instead. Fix the tma_info_system_dram_bw_use metric to use the server
metric rather than client.

The associated converter script fix is in:
https://github.com/intel/perfmon/pull/111

Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 8fc62b8f667d..d0ef46c9bb61 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -652,7 +652,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
-        "MetricExpr": "64 * (arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@) / 1e6 / duration_time / 1e3",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e9 / duration_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth, tma_sq_full"
-- 
2.42.0.515.g380fc7ccd1-goog

