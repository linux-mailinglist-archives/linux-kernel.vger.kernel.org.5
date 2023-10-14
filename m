Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410087C9350
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjJNHpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjJNHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:45:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2E3CA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed84c981so2311317b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269534; x=1697874334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96NwI+szUWVaDtq9XwWAR7aU5/19oJgtQRo7AsJZv38=;
        b=ZzRS508kUmxaJDRrD/5gZIOzVl1Lcl+4eIkhYEqeQJUCTxSMimNhKfiMf+aOEGOy/t
         NlnUJBcCQk+ePgoVqQz++/soPpPdGuVReHj2BbDJfAtGWVKlh2TDbzLYeN3eQtZ7xd/k
         apwLE6UxG6wYL3zZF4DmeQEpu3Ejru2XraknN0PeNu1NXQodg0fGuicl1TPfFxfJyXOZ
         VOxJ8VAnjFFUCYsd7UH1jJU0zuGCAnnSL9KpuDlH754MsIq+L2abjn4VVxaD59DrJEtY
         yYMrHtLzlR7qYKA2JCJxIeFgWmxFf2u0zNP8HB4Zp32up6A46kesV9Vw0kXONApDQ5wr
         Cg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269534; x=1697874334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96NwI+szUWVaDtq9XwWAR7aU5/19oJgtQRo7AsJZv38=;
        b=COxyDyLmoylz+aEEAQamNsZJdWFSLHHGvIX67ZjQKblvRspaVwVZM9kjCX+hQyuYcd
         xQ/63qcgJX8nKg/y2GhTVflDNl8AmfQG5mlwnfJKbk4xx291g+OYiMt3iwaqNQstfJKf
         r79lTi0X96yhMSb49TzpV3Eo7VYPoQDVW6E+ImiaIB58jy4t4CatO79su5JWnOmJwF78
         rEpqjamRyuPX9UKmckvg0RleNTjM2qS45Bl19zqSA4G7OoZG3HfUvoVTIeiCNVn52rPv
         Kavgs/TwH1ALmEPtiNTSFJLJyQxdNtVavW9ANGUQ/SvwuRfISuhitJ4iG60s8RKoVuty
         e/Ew==
X-Gm-Message-State: AOJu0Yz+c2l8d6zWl7glILnyy67u7D/M8ldZgOLo8itAX4o5I2C3Jl8X
        3sCTpE47Va+2uOR38ec93shfgw==
X-Google-Smtp-Source: AGHT+IFSuZzpRXBPpMB17Gk7j0z/3Vjzu2h3MJXxx77CEHZ/SOKVJBuTBUwkprQY5woSpJTwPmvLxQ==
X-Received: by 2002:a17:902:ca14:b0:1c9:ca02:6451 with SMTP id w20-20020a170902ca1400b001c9ca026451mr7855265pld.39.1697269533953;
        Sat, 14 Oct 2023 00:45:33 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm4965124pls.168.2023.10.14.00.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:45:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf cs-etm: Enable itrace option 'T'
Date:   Sat, 14 Oct 2023 15:45:13 +0800
Message-Id: <20231014074513.1668000-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014074513.1668000-1-leo.yan@linaro.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to Armv8.4, the feature FEAT_TRF is not supported by Arm CPUs.
Consequently, the sysfs node 'ts_source' will not be set as 1 by the
CoreSight ETM driver.  On the other hand, the perf tool relies on the
'ts_source' node to determine whether the kernel timestamp is traced.
Since the 'ts_source' is not set for Arm CPUs prior to Armv8.4,
platforms in this case cannot utilize the traced timestamp as the kernel
time.

This patch enables the 'T' itrace option, which forcibly utilizes the
traced timestamp as the kernel time.  If users are aware that their
working platform's Arm CoreSight shares the same counter with the kernel
time, they can specify 'T' option to decode the traced timestamp as the
kernel time.

An usage example is:

  # perf record -e cs_etm// -- test_program
  # perf script --itrace=i10ibT
  # perf report --itrace=i10ibT

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9729d006550d..4a37fdeb1795 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3322,12 +3322,27 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
 
-	/* Use virtual timestamps if all ETMs report ts_source = 1 */
-	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
+	if (etm->synth_opts.use_timestamp)
+		/*
+		 * Prior to Armv8.4, Arm CPUs don't support FEAT_TRF feature,
+		 * therefore the decoder cannot know if the timestamp trace is
+		 * same with the kernel time.
+		 *
+		 * If a user has knowledge for the working platform and can
+		 * specify itrace option 'T' to tell decoder to forcely use the
+		 * traced timestamp as the kernel time.
+		 */
+		etm->has_virtual_ts = true;
+	else
+		/* Use virtual timestamps if all ETMs report ts_source = 1 */
+		etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
 
 	if (!etm->has_virtual_ts)
 		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
-			    "The time field of the samples will not be set accurately.\n\n");
+			    "The time field of the samples will not be set accurately.\n"
+			    "For Arm CPUs prior to Armv8.4 or without support FEAT_TRF,\n"
+			    "you can specify the itrace option 'T' for timestamp decoding\n"
+			    "if the Coresight timestamp on the platform is same with the kernel time.\n\n");
 
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
-- 
2.34.1

