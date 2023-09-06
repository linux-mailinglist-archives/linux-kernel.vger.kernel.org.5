Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83D8796DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbjIFXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIFXoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:44:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA613132
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:44:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-592210fe8easo4551167b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694043868; x=1694648668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+URDfp1vmUnXA0TNecMPXbtTgLIonsOk2VAg6fREvI=;
        b=zHjXjO/UGZy3RRHHUmnI44bM1PZmZWHq+t3EuhOspUU+fB/jWSJMDCjcbkk2LopzQH
         yqDB9OB/Wy3FNbXskHmJn4/VIlHELLYrNGUExiFZOWXvkrGMxo7C0DJ7kRDAu1FSHrj0
         ySA6jhVy6TlhiQgdAV7UIKtCKLX+KvX0lQ+WnmMqU03lzLB/sPWrOR/qMYjjf7rHCR0k
         MvO4OwZQJ7zMmLulbV+due+R3ltlinEprot+uL3QZ+tnu7OaEM1VyVVbD3und91Al6jh
         mb9Mr3H+vlJA8mb4PnnhEEaBSKOQHqAOsdHdqvO1rNJ8HPUkfFdD5n4YiXZ7UpMJr1ec
         3w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043868; x=1694648668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+URDfp1vmUnXA0TNecMPXbtTgLIonsOk2VAg6fREvI=;
        b=ifCcusXQ9A78/tNBH5yQ1hGCk1BhLeFSQX8Tywge1DiY/lRzQQ4PTAkBkDX8an40Bu
         uPNgKHqVjYYZAbXnKLMoXmxlF1rKU30DCMYZpo8Kmvt563Y5ijab3bmMfoB6x5c0oGK2
         /jRxQDnOopjFySQyjSGH3TQK8v8v/3iAb2cDufA2fvdXhf0eztfOoonbQSemHsS1LpTO
         oNIEXFXJsVKJyM1x4E9kFACoaYNCGfDRoYyduPLyg2UVsyhK8a+bA1M1P6iwmtxyE1go
         YG7/cjJyJCSzwUJRrJs/hL8Tocms/6nSltP8fjl6OaH1yiiowPsqAhtmdTFONs0UVt2a
         h5NQ==
X-Gm-Message-State: AOJu0YxzADCtWv+gH45W7/3z0Sb3VvjP16XPH+WqeUaNbq817ufWnYo+
        2UyrXhpWIhy28MFdfGTJN1opU611eDmE
X-Google-Smtp-Source: AGHT+IFUsJFd+ZXwL0O9cqJfkHWMky3iGbPQNlocLh26uAaNrkFX/dpC4F4qxtqil6Na0N1gy2uRA4MdRv6i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e535:39a0:5730:b9dd])
 (user=irogers job=sendgmr) by 2002:a0d:ec4a:0:b0:595:cab:4bc5 with SMTP id
 r10-20020a0dec4a000000b005950cab4bc5mr431689ywn.4.1694043868077; Wed, 06 Sep
 2023 16:44:28 -0700 (PDT)
Date:   Wed,  6 Sep 2023 16:44:16 -0700
In-Reply-To: <20230906234416.3472339-1-irogers@google.com>
Message-Id: <20230906234416.3472339-2-irogers@google.com>
Mime-Version: 1.0
References: <20230906234416.3472339-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/2] perf list pfm: Retry supported test with exclude_kernel
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With paranoia set at 2 evsel__open will fail with EACCES for non-root
users. To avoid this stopping libpfm4 events from being printed, retry
with exclude_kernel enabled - copying the regular is_event_supported
test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 862e4a689868..5ccfe4b64cdf 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -145,7 +145,20 @@ static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpu
 
 	evsel->is_libpfm_event = true;
 
-	if (evsel__open(evsel, cpus, threads) < 0)
+	ret = evsel__open(evsel, cpus, threads);
+	if (ret == -EACCES) {
+		/*
+		 * This happens if the paranoid value
+		 * /proc/sys/kernel/perf_event_paranoid is set to 2
+		 * Re-run with exclude_kernel set; we don't do that
+		 * by default as some ARM machines do not support it.
+		 *
+		 */
+		evsel->core.attr.exclude_kernel = 1;
+		ret = evsel__open(evsel, cpus, threads);
+
+	}
+	if (ret < 0)
 		result = false;
 
 	evsel__close(evsel);
-- 
2.42.0.283.g2d96d420d3-goog

