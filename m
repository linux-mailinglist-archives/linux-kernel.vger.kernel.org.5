Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159279B8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjIKWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243338AbjIKRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C3127
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-573f6f0fe9aso6289685a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451971; x=1695056771; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=YWCOnLA3d4/1GNUUBAPQ7IGBWC9j9mXhT7x0i2jwYLaTNsKaNXktq7Oo0GS4HN20XH
         D1x2yETJaiV4uDvGIoS6zXvlugijlRvIJMEKFnAIepyz6nUx7atxJAvwCSDeR4p3Z39S
         qan3tfA0QYt6XRy30ikBmsZB/MfvX23i26yLDzClGhRoX0rt0IlLIvV+23h5ssKYpBKd
         B84NpEqQnuqrdbVuNLHb3OIWny4mgBoXqMOjFxlTLcPLl4cUHSE3nNhNnD4zy9YAwE1C
         YgAMxrRyzLkrSrjOpIlSMo2bcifnDylyzpaGeVxDEi71j5LffHk6ae0AsuR3LnEoMoN8
         j6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451971; x=1695056771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=l4jj2dPJEcQS5UV2p3gCat2XfO4TDlsZm/9UOaphYbqKlMqpY2ai8Vhcsnt//T/R6I
         MtDG+dRAsZYrbspTB54lMEUNN+h4mnW0YGCCQMMDHRErcHB895w9U/bF3i02s5oAZjS3
         585gsjZ602ZvJjCtIDKuMVvxT7OMHBWDyxH+2HfUB6QclyXvKuB3TgPXLClMGDo+Q9ph
         qDcjP0eVo2XRPrVWHwcYfsnVOT+UrVz8BE/4sWepd16/lv0xspn0y/odOV9pnNE0tCdC
         WjhZwFUTn2zXe/3V7fJ+OmW6L1wVJBiGGlbvwOpOfUGgxGa6mlsOVrQkFbvbNSGuYXem
         30oQ==
X-Gm-Message-State: AOJu0Yzob5ychFl/0kN6mMfV99yHOYQ4q2IK9RHYAvFKKLRFuZPBfXMW
        qZGoHA2KFcfseGLIK/aNoiM4hx22wqi+
X-Google-Smtp-Source: AGHT+IGIhSAWZ1imjQEKI5kVl5ekILjaw0OmXTbC9BInGiGxTOTdQVla++ZMTYyGVj4IXpyev+Ua2Gvq2EsG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a65:6ab5:0:b0:573:f899:b6f with SMTP id
 x21-20020a656ab5000000b00573f8990b6fmr2287578pgu.10.1694451971254; Mon, 11
 Sep 2023 10:06:11 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:57 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-3-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/5] perf expr: Make YYDEBUG dependent on doing a debug build
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
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

YYDEBUG enables line numbers and other error helpers in the generated
expr-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6c93b358cc2d..e364790babb5 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,8 @@
 /* Simple expression parser */
 %{
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 #include <assert.h>
 #include <math.h>
 #include <stdlib.h>
-- 
2.42.0.283.g2d96d420d3-goog

