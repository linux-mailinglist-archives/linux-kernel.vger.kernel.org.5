Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089C07F201E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjKTWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjKTWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:19:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE391
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc2575dfc7so34247355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700518776; x=1701123576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU36NcT9RPyJC6TQdfEVGdreh7ck6Zb0oyJfbLqLJ4s=;
        b=BHBZSCe9TsuJXRnWjynxNsorVEt2YpNDI5jBGvOdc0lS2BVO9kGRDmab+buvBF1XDF
         tu7hhr7ZR57P73qhf0EssUW7071iC1TrGWXMxb+lHzpNMTmhWE+USEYdog1DDnmPwp4Q
         0vIg0Yx3r5cEKb5thX8sJKUejl3RdXbrFh3xyIeSHaCbSIsJUpsmIVmkVzoqERBCFbI1
         dMuzWfVSVANEeHQJT/1YFOUWgXz08OkQuHh4w0MqSasRlrR26BbTI7010TgZh5i0YnB8
         4HECP1qFKRiwv3VUpWERU4lX4yA1OgrQEvnawmrFjngupfDQAPLfkrRQV6hqQ89LY1ps
         Jkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700518776; x=1701123576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZU36NcT9RPyJC6TQdfEVGdreh7ck6Zb0oyJfbLqLJ4s=;
        b=oRbh/2nLsIn5vL9DcpTuDtfwbE53T25yoO4k5WXlbXDhAGPV3zsWJOf3JCF1LwtZ/j
         ZfknrOOgbn6E6kqscGIjQrO0nBVSLrDIPPfAz2Xs7ex1MZbAj6eZd7SDyr7QOIVfNKH+
         myYUjEZ9SuUJVAwOUIm9FVBe0xmw3VaUHdGuugvuqcKJiBaUcL9jPJgTl9hVEyx+THOr
         biBgcFX/wNzwtJ5N1H3HOd/7tBtrX8ASs6kMaKFWHr68EEDkT1fyJ0WhcFVaenHOBioc
         0uW2OoDJMfEbBMlu77C9NrxIKJstGdvP3wC27PwhvDha0Sis9E7k6H8RGSoGfNIkpuco
         Y3WA==
X-Gm-Message-State: AOJu0YzWNk03KCIBqzJQqTfFRJR8K82BDcVMyPFVjKXIlU0V6NKEfDJJ
        lzm/INv/xYYlt7z2H9FopeY=
X-Google-Smtp-Source: AGHT+IHMcbdksKd90KxZqrUcDtffyDsUiY3XBL82FnukX0GER7JnVDy/avqZExtispSySVyWf1HJxA==
X-Received: by 2002:a17:902:a985:b0:1cc:58f1:8646 with SMTP id bh5-20020a170902a98500b001cc58f18646mr7364589plb.50.1700518776489;
        Mon, 20 Nov 2023 14:19:36 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:75c6:4212:ae99:93b6])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001c9c47d6cb9sm3528246pld.99.2023.11.20.14.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:19:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 3/3] perf/x86: Add CAP_NO_INTERRUPT for uncore PMUs
Date:   Mon, 20 Nov 2023 14:19:32 -0800
Message-ID: <20231120221932.213710-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231120221932.213710-1-namhyung@kernel.org>
References: <20231120221932.213710-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't support sampling in uncore PMU events.  While it's
technically possible to generate interrupts, let's treat it as if it
has no interrupt in order to skip the freq adjust/unthrottling logic
in the timer handler which is only meaningful to sampling events.

Also remove the sampling event check because it'd be done in the general
code in the perf_event_open syscall.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/uncore.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 69043e02e8a7..f7e6228bd1b1 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -744,10 +744,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/* Sampling not supported yet */
-	if (hwc->sample_period)
-		return -EINVAL;
-
 	/*
 	 * Place all uncore events for a particular physical package
 	 * onto a single cpu
@@ -919,7 +915,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			.stop		= uncore_pmu_event_stop,
 			.read		= uncore_pmu_event_read,
 			.module		= THIS_MODULE,
-			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			/*
+			 * It doesn't allow sampling for uncore events, let's
+			 * treat the PMU has no interrupts to skip them in the
+			 * perf_adjust_freq_unthr_context().
+			 */
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 			.attr_update	= pmu->type->attr_update,
 		};
 	} else {
-- 
2.43.0.rc1.413.gea7ed67945-goog

