Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE9789F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjH0Nh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjH0NhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:37:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACCBF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:37:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a3b66f350so2100354b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693143437; x=1693748237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oz+CZy9YZvIlZYBV1Djf2HNAYZ0qDenfedTgUYUSqU=;
        b=qKRwvWOY1eyvGUyQ4yR43oXGTcXp51nzbgsPPA3iMBiiNIbINN0whfRO1HWt1N+ST2
         CXUB/FYM1uzJMhtRx35JS2MMHN3LLHNzflosP9qzDPpyURf6SjS5cz94G/SCQL2C2JF5
         s5DteAYHqf+XtZuDKfn/Kunn0ZI4wCmhzyR3O1r6PQd/YBtFWq8a3XLTyJ2RkSjkxrtW
         Qh5Uhk9whr6E0cI0QJZL1QQ5/AvzjPuB8zV7a7Rv/mmqOO57A8RNpIjx6ZzEFYlq1+sF
         n3CrKAYNQ5gGQ1v3jIRqQmUhO2Ii4dmrRp6YwJgFwcVXvfQTgQA6f+8AgMRiVRWbbdwn
         /iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693143437; x=1693748237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oz+CZy9YZvIlZYBV1Djf2HNAYZ0qDenfedTgUYUSqU=;
        b=FpM0e9KOCNYXJoejWdqIk2th8GeKMb+Dq47HOybOsV7408ZPXWZkpd8MDRR46EGOkf
         pxVZKt+xh7TCHUHf60PXuoszBRH/bQoN9+7GV73TxPVm0Oa72bDJEb0EMEyuCxjjO9q9
         n9gjvMOh8lGir4WPXWirG1dApuWxGXG8RYNIsC6TYAJ0zxWHBnP0a0pQvOtTRyI5m1JW
         qnQGi8BC8jAjxEnVT8neJl6YFll1ONmqSl1j+FWQ1QbwO5pQntSV5jHFvNN5iUrq2Kkd
         VZKh6nryGXcoCbGMEThuF04g09w8GiFIts/Xupr4ONeJss5Icjea4Hx2oWQEal3tM9Bi
         r0MA==
X-Gm-Message-State: AOJu0YwiALSTMw8fJah8jfBcJdKLz5hxoLg3SqGMwIATZl/jy1mHw0gS
        CK/bQL7tELnsJg/sApVXe/oGIQ==
X-Google-Smtp-Source: AGHT+IFM1OLxJh7p3BbZWTvqmLncDv+R+8Ia/nGwyLEZihC31U0cm8ZufuP+x1zTdn2BYzeKF1n0OA==
X-Received: by 2002:a05:6a21:7985:b0:14c:ca56:69f7 with SMTP id bh5-20020a056a21798500b0014cca5669f7mr4796294pzc.28.1693143437236;
        Sun, 27 Aug 2023 06:37:17 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id e29-20020a63371d000000b00565eb4fa8d1sm5273627pga.16.2023.08.27.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:37:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf cs-etm: Respect timestamp option
Date:   Sun, 27 Aug 2023 21:35:57 +0800
Message-Id: <20230827133557.112494-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827133557.112494-1-leo.yan@linaro.org>
References: <20230827133557.112494-1-leo.yan@linaro.org>
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

When users pass the option '--timestamp' or '-T' in the record command,
all events will set the PERF_SAMPLE_TIME bit in the attribution.  In
this case, the AUX event will record the kernel timestamp, but it
doesn't mean Arm CoreSight enables timestamp packets in its hardware
tracing.

If the option '--timestamp' or '-T' is set, this patch always enables
Arm CoreSight timestamp, as a result, the bit 28 in event's config is to
be set.

Before:

  # perf record -e cs_etm// --per-thread --timestamp -- ls
  # perf script --header-only
  ...
  # event : name = cs_etm//, , id = { 69 }, type = 12, size = 136,
  config = 0, { sample_period, sample_freq } = 1,
  sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
  disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
  ...

After:

  # perf record -e cs_etm// --per-thread --timestamp -- ls
  # perf script --header-only
  ...
  # event : name = cs_etm//, , id = { 49 }, type = 12, size = 136,
  config = 0x10000000, { sample_period, sample_freq } = 1,
  sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
  disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
  ...

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index cf9ef9ba800b..58c506e9788d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -442,6 +442,15 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 					   "contextid", 1);
 	}
 
+	/*
+	 * When the option '--timestamp' or '-T' is enabled, the PERF_SAMPLE_TIME
+	 * bit is set for all events.  In this case, always enable Arm CoreSight
+	 * timestamp tracing.
+	 */
+	if (opts->sample_time_set)
+		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
+					   "timestamp", 1);
+
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
 	if (err)
-- 
2.34.1

