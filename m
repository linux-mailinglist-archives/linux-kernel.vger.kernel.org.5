Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830A79F7EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjINCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjINCYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:24:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC64198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:24:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so614419276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694658270; x=1695263070; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mr6eRGX/mot4ysHxW2nXh0B8TIVosY14z+Vg1QOhCRI=;
        b=jEYk0O0GqLNvr7w9JKUGQI+pV7PWXZkv7SPKQ6XmSFZM+C65Os5joK590+nvWe0Lwp
         +cPeGLyn5AHJprhBXPkRPGbGVfwYK3FbRyGZW/UQwoU9d7NuSGq9cKuoVKd03FTvwDkJ
         d2kbo6e2MC/mvUhloIR9kQsQaRE5DLZfHh1ySYE8YVGqEKwV9B00o9id9KPPXIEv8H+L
         imxqA6AX8lzhDhPa67jwHIQfpIZVp5oGXgyb8DRBj8Un0hwkKW9V14eGpm5NFLgQI025
         cvzaEahlleo4OBZIMIgU/z06YjqswoIp6toq+2RBh4yGoqYp74rWesSoe8p4A4rM3uPk
         QQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694658270; x=1695263070;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mr6eRGX/mot4ysHxW2nXh0B8TIVosY14z+Vg1QOhCRI=;
        b=jC1M67RlHWvNA/S/GxyXEws461853pPwSL/kEK2PkFjGCACpyB3uGXgXjb6alNdT2T
         Ow3n+Qhb71km4y3p15UljGE0iGA6bWl9TPZ0TfYtZ0nAXz98afg9gYoFW6+DPGIq1nk2
         KWAf04Sz7d7VeS5wA1sZ1bxSC4LnF4FL/1WGsnQNH4fdPDIOBUbYVWHNks/g9Z59s7RQ
         +nFDD31Yn+AmE35lkRQ7C83kVT5TBl+iBT6PztvTtt1YgP7AAzsLG5GU5XW6Gh4o5zaR
         JP/4QL10UxuDLQY0ExXmaPRNFvNng3L21osYBNWYpUibB2E8BORt7RmGW3amesxSQQEu
         zzUA==
X-Gm-Message-State: AOJu0YwdRLLZg/2mpfPUPmrJRWxGF0N1amkzaKt4rVKQPmhBA00kStCL
        vNT0y2wf4pe1jyT6WJCCeVfmTCCgsOBB
X-Google-Smtp-Source: AGHT+IG0qp2pzoQ+1PCyVwi/VCysIK1PqTEdrLS85yYQCAAqNmlaQqZSyKSExA9+ptRGctE4ca7HtSwxoZlJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a5b:8d:0:b0:d78:245a:aac4 with SMTP id
 b13-20020a5b008d000000b00d78245aaac4mr100091ybp.1.1694658270080; Wed, 13 Sep
 2023 19:24:30 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:24:25 -0700
Message-Id: <20230914022425.1489035-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf pmu: Ensure all alias variables are initialized
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an error detected by memory sanitizer:
```
==4033==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x55fb0fbedfc7 in read_alias_info tools/perf/util/pmu.c:457:6
    #1 0x55fb0fbea339 in check_info_data tools/perf/util/pmu.c:1434:2
    #2 0x55fb0fbea339 in perf_pmu__check_alias tools/perf/util/pmu.c:1504:9
    #3 0x55fb0fbdca85 in parse_events_add_pmu tools/perf/util/parse-events.c:1429:32
    #4 0x55fb0f965230 in parse_events_parse tools/perf/util/parse-events.y:299:6
    #5 0x55fb0fbdf6b2 in parse_events__scanner tools/perf/util/parse-events.c:1822:8
    #6 0x55fb0fbdf8c1 in __parse_events tools/perf/util/parse-events.c:2094:8
    #7 0x55fb0fa8ffa9 in parse_events tools/perf/util/parse-events.h:41:9
    #8 0x55fb0fa8ffa9 in test_event tools/perf/tests/parse-events.c:2393:8
    #9 0x55fb0fa8f458 in test__pmu_events tools/perf/tests/parse-events.c:2551:15
    #10 0x55fb0fa6d93f in run_test tools/perf/tests/builtin-test.c:242:9
    #11 0x55fb0fa6d93f in test_and_print tools/perf/tests/builtin-test.c:271:8
    #12 0x55fb0fa6d082 in __cmd_test tools/perf/tests/builtin-test.c:442:5
    #13 0x55fb0fa6d082 in cmd_test tools/perf/tests/builtin-test.c:564:9
    #14 0x55fb0f942720 in run_builtin tools/perf/perf.c:322:11
    #15 0x55fb0f942486 in handle_internal_command tools/perf/perf.c:375:8
    #16 0x55fb0f941dab in run_argv tools/perf/perf.c:419:2
    #17 0x55fb0f941dab in main tools/perf/perf.c:535:3
```

Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files
from sysfs")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d85602aa4b9f..8de6f39abd1b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -520,7 +520,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		pmu_name = pe->pmu;
 	}
 
-	alias = malloc(sizeof(*alias));
+	alias = zalloc(sizeof(*alias));
 	if (!alias)
 		return -ENOMEM;
 
-- 
2.42.0.459.ge4e396fd5e-goog

