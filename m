Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2344A796DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjIFXoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIFXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:44:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31694
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:44:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b957fd276so388399276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694043865; x=1694648665; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvNC5qCKH4m6gqyHIhkOUYbZhnc9A+awOBs+ZKq6knA=;
        b=xEQdg9m8FSrQYFdBXDYrBL2fxHf7nizA5BfMQz+8WNoGGOvT3jGgmMAB5TZjShkB3k
         CcMHLATTUTpPjTYgoWhxdqm3MqHYN7EMIV2EG4bbkImKBEwYm4I6NsFJMK+N8qJYphbi
         cJJSdNDehOZg2ON4CM7Wh8aMGndJCBH5ldoh6fqPW+A9TYoFY3T5XmKZWjXYM66xRs9b
         eWNb3sLYv0VsxyvoI7lS3FTQnWADRZHkvnyKrNszUngd/PXbuCITMoCX+/+Qw8QBFzkx
         dTESs2gCyULElmDVmsXmraeyWVZa+e5MVyr/0wugCmur2mNJNOMqkKgTl7xqnAbkviHF
         xd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043865; x=1694648665;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvNC5qCKH4m6gqyHIhkOUYbZhnc9A+awOBs+ZKq6knA=;
        b=Aeaua8jaVWhUovZjQJ1Az88HyMT8O7PWTjtYIyqFx6xz4/1A03V7m88ixdDwFNnEsc
         7H0oM9XJR0ejk6FfOlPLF3ibJLV2lQ7N6NdsJCxoArgtvuNgfY5++lBVami6atZJDIqR
         dtoSEiNu05zRN9moRHYsO+rA6agjfib8Qa4YpDGh6pZJOq6X1m9eXaV9uVHPFMSE7Tn9
         IOlpwwsN1bBQj6vFc4fHVTO1TNwCWrGexViEW/pr7LsvKyBNFBBeel0Ew+tRUD59H5TC
         IoMiwqIHB1r5oYjBc5P6/Kh71oiPGFt9N0uPn+mtnm/9BkIMD6iKdaP0DEzA+XZFFcTI
         aIqw==
X-Gm-Message-State: AOJu0YwdjPpKA21J9ynClACdHS5FvCA1wIYrPwqhjXV1bpNZqVXJyKNd
        5+oajC7pV5kjw5+gIvyY56VaoQLvXTSH
X-Google-Smtp-Source: AGHT+IHUHdworPjnqKLX/zN8U+Kn319G32iz3nG03XGqYqMkh19G2QwF17/nFngRp9YCLe7KTjkedFGrJg2F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e535:39a0:5730:b9dd])
 (user=irogers job=sendgmr) by 2002:a25:8807:0:b0:d7b:9185:e23d with SMTP id
 c7-20020a258807000000b00d7b9185e23dmr434315ybl.6.1694043865680; Wed, 06 Sep
 2023 16:44:25 -0700 (PDT)
Date:   Wed,  6 Sep 2023 16:44:15 -0700
Message-Id: <20230906234416.3472339-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 1/2] perf list: Avoid a hardcoded cpu PMU name
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the first core PMU instead.

On a Raspberry Pi, before:
```
$ perf list
...
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
       [(see 'man perf-list' on how to encode it)]
...
```
After:
```

$ perf list
...
  armv8_cortex_a72/t1=v1[,t2=v2,t3 ...]/modifier     [Raw hardware event descriptor]
       [(see 'man perf-list' on how to encode it)]
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index a7566edc86a3..b0fc48be623f 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -395,6 +395,8 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
+	char *tmp;
+
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
 	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
@@ -418,17 +420,21 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	print_cb->print_event(print_state,
-			/*topic=*/NULL,
-			/*pmu_name=*/NULL,
-			"cpu/t1=v1[,t2=v2,t3 ...]/modifier",
-			/*event_alias=*/NULL,
-			/*scale_unit=*/NULL,
-			/*deprecated=*/false,
-			event_type_descriptors[PERF_TYPE_RAW],
-			"(see 'man perf-list' on how to encode it)",
-			/*long_desc=*/NULL,
-			/*encoding_desc=*/NULL);
+	if (asprintf(&tmp, "%s/t1=v1[,t2=v2,t3 ...]/modifier",
+		     perf_pmus__scan_core(/*pmu=*/NULL)->name) > 0) {
+		print_cb->print_event(print_state,
+				/*topic=*/NULL,
+				/*pmu_name=*/NULL,
+				tmp,
+				/*event_alias=*/NULL,
+				/*scale_unit=*/NULL,
+				/*deprecated=*/false,
+				event_type_descriptors[PERF_TYPE_RAW],
+				"(see 'man perf-list' on how to encode it)",
+				/*long_desc=*/NULL,
+				/*encoding_desc=*/NULL);
+		free(tmp);
+	}
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
-- 
2.42.0.283.g2d96d420d3-goog

