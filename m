Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59A7F201C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKTWTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKTWTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:19:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3511ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:35 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf6af8588fso4598305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700518775; x=1701123575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XOoFK7iiRtg8F9n1yVwN4BqrDcgETLBQgehwgQkqSk=;
        b=YktyFqrINYIrDa2sVdT9aw/3Nv6up+b0BlReQBNqLCzQaC2aB5bh4d4owSVBMc7bKu
         DhG9U0c3IkBP1fhHK6UMRZc/8uM1hr4i7fBe3rDJuHLmZi4c3DdWaP+ZkK/J8I6eOUTv
         dOj/6LINxR0oKsgggtdt6oGO9p2yPesBl3OkJlAI9inEdxAlkqd/+DXBhwfenZHYgEe8
         sKX5I9faUGnQJcictpeHNWc7CiWFqlYsfRgzmESHLj7lQ+94pSCXz8LQQu89NVqfot80
         qUSpvU4QxxGA9BCK/GNSuDaB1xBYNwEUAReZS7NaU5ljsAgQqoN33RrMe8NcJ3I3KrX8
         bV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700518775; x=1701123575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XOoFK7iiRtg8F9n1yVwN4BqrDcgETLBQgehwgQkqSk=;
        b=SuW/Yypu2azxNLcDX8BOgoPKeXVar/xkO2cC/KnXnVNaWBglvNYRcMgYq/N3EqZJRf
         2e1IALH7G3pXKRHg+9DW1+taE7D3pwdvnzsY0RWsGUMFUbl8KEKjKKKJzObN6nx6ZG7I
         9AcbhFF6nwME2OMTyVOB15CLik/b14Up3HNjlcDMVz80ji9aCaT5zWBT2H26Ratv9U3+
         oOZhm9sZVOWkEkYPNTk6dN6KxzwUTEj3Dt17VPtzzy7rdn+cRbC3oymd8W86LgYhilit
         DzvNIwf3n+q4dSykr9EsJ/uCTTuhtRuhWxvqyrKAVa6ee41I41/FPHRTR0++G8S21PHT
         JsuQ==
X-Gm-Message-State: AOJu0Yw9MnpuEvZ8QYbxqj3Vj+E9Ye8P06zP7F0WzKoLMzO9s3szisKo
        VPQlNHrSUOazvmQLSfl3CRI=
X-Google-Smtp-Source: AGHT+IFe8/tu8lmkUhi/3HijxlK6JcBhy81W2ka8TQGFI8ER6H2h5FUD3/MVnOwhRNRiUQBx3VkmYQ==
X-Received: by 2002:a17:902:7682:b0:1b8:954c:1f6 with SMTP id m2-20020a170902768200b001b8954c01f6mr10400426pll.36.1700518775351;
        Mon, 20 Nov 2023 14:19:35 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:75c6:4212:ae99:93b6])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001c9c47d6cb9sm3528246pld.99.2023.11.20.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:19:35 -0800 (PST)
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
Subject: [PATCH 2/3] perf/core: Reduce PMU access to adjust sample freq
Date:   Mon, 20 Nov 2023 14:19:31 -0800
Message-ID: <20231120221932.213710-2-namhyung@kernel.org>
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

For throttled events, it first starts the event and then stop
unnecessarily.  As it's already stopped, it can directly adjust
the frequency and then move on.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 53e2ad73102d..fd3449e4d081 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4119,10 +4119,15 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			event->pmu->start(event, 0);
-		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
+			if (!event->attr.freq || !event->attr.sample_freq) {
+				delta = 0;
+				goto next;
+			}
+
+			if (event->hw.state & PERF_HES_STOPPED)
+				goto adjust;
+		} else if (!event->attr.freq || !event->attr.sample_freq)
 			continue;
 
 		/*
@@ -4130,6 +4135,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+adjust:
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4144,6 +4150,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (delta > 0)
 			perf_adjust_period(event, period, delta, false);
 
+next:
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	}
 }
-- 
2.43.0.rc1.413.gea7ed67945-goog

