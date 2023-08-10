Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00809777FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjHJSJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjHJSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:09:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EE10F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d62a7776f69so1194150276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691690989; x=1692295789;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nykc+Kyyh1+8m1DKPGBWNjKw48feUTxYe7ZnBfqGNo0=;
        b=SDdl8aJg4mXyp8R19oy/uvE3JdkPqurz8XeUyM6WDyjHBw3NfVAxYv6lFd1LfaGtrO
         M9EBkXlSebuLnFcNDVfcg3G7WRrkhahXNTQI/eb7099wZsSyEzIzlOg6Sc1hpQ3ZHCgJ
         4eAQA4V0hNa9z7OSwOs2BRoLVDaPYGhCt3yfRO7tsGskTplb6SV1BUusTNbKe4qRYXxK
         wvooAEy9gOX1gv9o7nL/dbH60nM0IEaNeEmfJdBd1kg48kkofExkoEfAgYOgLGFA1Rfg
         oC4He/il4f4WtFaLi5jHOUfQKFdna0FQ6FaAmJCV41z2csPeoil9k43q08v0nbvmqFi4
         6KKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690989; x=1692295789;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nykc+Kyyh1+8m1DKPGBWNjKw48feUTxYe7ZnBfqGNo0=;
        b=G+Y6aCiWK1mXhGeN7AGVMBYTa5MoxXDA3rseCML3sEFRezdJDKIMjuD6Qrc5JvNpoX
         eIfN4f2gCpjan0+9PpZdd6Z5E0aRpei4Hz1U0/yZx8YoYg5lNGmyl6OJPoNugpfks/tv
         8luK5DnoP2852NVhr7Le+anYud3YcKtcBbuz8U4zdPiE4oASvM5l/ydrNFAeuMA1Z6QK
         8ptOPDSA+Ct7uHPuFbwlvAyUEODGjVTqZGoR3ReT9XWFnVfQXBkac2yOazqAW6OSVC58
         bd7dmryQh8pUP1k4QQ8JadocnvPVrfAwI2v5sFlVjSTy3GuOucf89rudzXRMWfbLjY2v
         qljA==
X-Gm-Message-State: AOJu0YypRj1tuazA2qYTQBFYDKjBFIqyb1qgyaqy3rskfdhsdKM6sEUv
        SElBXm42zWbWgTYNrAkw31wMRYFx5OUN
X-Google-Smtp-Source: AGHT+IHsDqiFQ83RfjseHv4SyvYwvf32issTCGV6LfFt41q7SQay0B9zQzK2Hlga9OqAvGFDAuEXfmOdDuxL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:7404:0:b0:d04:d397:352d with SMTP id
 p4-20020a257404000000b00d04d397352dmr52070ybc.4.1691690988871; Thu, 10 Aug
 2023 11:09:48 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:09:44 -0700
Message-Id: <20230810180944.2794188-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1] perf script python: Fix python execution
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
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Fix missing symbol seen in:
```
 19: 'import perf' in python                                         :
--- start ---
test child forked, pid 2640936
python usage test: "echo "import sys ; sys.path.insert(0, 'python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: tools/perf/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: perf_pmus__supports_extended_type
test child finished with -1
---- end ----
'import perf' in python: FAILED!
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4eed8ec23994..c29f5f0bb552 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -113,6 +113,11 @@ bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
 	return false;
 }
 
+bool perf_pmus__supports_extended_type(void)
+{
+	return false;
+}
+
 /*
  * Add this one here not to drag util/metricgroup.c
  */
-- 
2.41.0.640.ga95def55d0-goog

