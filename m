Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050BC797DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjIGVFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIGVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:05:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8892
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:05:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8cbf0a0dso45251647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694120737; x=1694725537; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnyMsDgiX5vgIpgNk8THjYlZnq9260AQc9Onv7oS0O8=;
        b=XPD77feUZ4xInmA0jtgTl8BMRlL8A99/aZ42tYalUhBIMur5rr8oGdTfHFrrp+dCOx
         2p+CCrs0/k1eCnPvlH/FrRdi8ViYBG0BAQ7B4PpOsP6ebuuJODJ8EcoPvYLAdyxWPBrO
         pR0F9Jt7zdyTIyL1aabh27GaBamVo/ju+l5fUq/u/8Bm7ReqJopKHQPMHkU3nazyp9AC
         46FK2YCT24mZFaFluhb+acUhgL8OHl9ESGoFE6O3FTB8Cik/4aa13MdbKTDBFycuB/rR
         IZ4DpxpZKGhIl/H8ADA9rCmmuXfBkFvO6RLlJS4+9HSkwIrQc8w4h13CqxUm+MT2SsMg
         khVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120737; x=1694725537;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnyMsDgiX5vgIpgNk8THjYlZnq9260AQc9Onv7oS0O8=;
        b=uV/sjQyg5/vciG6+9FfFjb0MMqxSa73mIywerfYMj51eWiecUhclJZ5S2bvyJcW4gG
         UgQcAVrwWOu5dzZFpLn7MTTIsnCCb3M8PFlD0HteczySDX86a9f1ddpRG+HFFfX6uteq
         QGy2Ym1hCgjzttxDS8shqxbedXKere9CzmWfti06uhXY8za+HAiDV6dLuXScScRXnKmA
         xNIr8OUZh1UwVdAPrdRDhjq5kt4UrgSlhIu13u8/W/T2uBeQDa4u76lybnaR7+rVqsiL
         qKZRhF0INSVPMA3RM0yIFk1bVPx5XIdthPxqo02uZON8hqBelRoMHOyVkNgVexakRbFm
         vcxA==
X-Gm-Message-State: AOJu0Ywjm+St+QbXkh3rCCm7dib7AQFl12QBy7U+qMdCibG/iQFwyl1g
        8+ITJTBl1DYq07HXtaUqjgeSlx5X0Yt8
X-Google-Smtp-Source: AGHT+IGTPbYEN9QntgCC8Qk74o1xFC3ceEtnfcYbnQvG1l9e5gI3/scYqclOQxzhCRBR5VqtB1seyJB6RyI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e535:39a0:5730:b9dd])
 (user=irogers job=sendgmr) by 2002:a81:e244:0:b0:595:9e93:60c8 with SMTP id
 z4-20020a81e244000000b005959e9360c8mr108471ywl.1.1694120737296; Thu, 07 Sep
 2023 14:05:37 -0700 (PDT)
Date:   Thu,  7 Sep 2023 14:05:33 -0700
Message-Id: <20230907210533.3712979-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf parse-events: Avoid erange from hex numbers
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
        Rob Herring <robh@kernel.org>,
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

We specify that a "num_hex" comprises 1 or more digits, however, that
allows strtoull to fail with ERANGE. Limit the number of hex digits to
being between 1 and 16.

Before:
```
$ perf stat -e 'cpu/rE7574c47490475745/' true
perf: util/parse-events.c:215: fix_raw: Assertion `errno == 0' failed.
Aborted (core dumped)
```

After:
```
$ perf stat -e 'cpu/rE7574c47490475745/' true
event syntax error: 'cpu/rE7574c47490475745/'
                         \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu'

Initial error:
event syntax error: 'cpu/rE7574c47490475745/'
                         \___ unknown term 'rE7574c47490475745' for pmu 'cpu'

valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,percore,metric-id
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Issue found through fuzz testing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4ef4b6f171a0..f7df52b22c39 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -156,8 +156,8 @@ event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
 event		[^,{}/]+
 
 num_dec		[0-9]+
-num_hex		0x[a-fA-F0-9]+
-num_raw_hex	[a-fA-F0-9]+
+num_hex		0x[a-fA-F0-9]{1,16}
+num_raw_hex	[a-fA-F0-9]{1,16}
 name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
-- 
2.42.0.283.g2d96d420d3-goog

