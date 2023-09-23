Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112B7ABDE5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjIWFgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIWFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:35:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACEA19E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f4f2a9ef0so16370497b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447346; x=1696052146; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl2sn727KJMlO6SMtr3A6ZiYWuqB+jcCP05IXOF0Rso=;
        b=GKI5bBV5k41N7T/FQYnY25TahvoCxGzsXWLLCHfTta2GFLpJ3m4p1eE3Ab+tVWTMzF
         wgXl7ejPqCU0VyCj6s2Qbp5rOEhoQt8ABLbId2iQ2GFxJlmRTIKXcnIcvJGSWTzPLXfX
         fiirNkqYaP++i5y44pokYxBKNb3VgK7qKuW+C1o0oZeq9/v1+pBwfs46uuwAvHbHvrL4
         WjHppmzHzbBQ4GkB8rMzHO3kDoH10befQTAMV4daUUXSrtFvpvGAvOce+iPJvcqpQwOf
         FXik0EEi0zkuaAIMSMXpLtMB2v79BcdGCffEEcVvTQ4PQTHAKD4Lw9aoCs7YpNhiOn0I
         /a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447346; x=1696052146;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tl2sn727KJMlO6SMtr3A6ZiYWuqB+jcCP05IXOF0Rso=;
        b=hRi6pQgqYHuqweE8cgK96L7yN1QlMBFCoYX5WQrxhgppli0ujjBhU8QcnCjPCs7wBU
         VUyJGNAyuVjo7QvUGPZQB5xmmkY3+syM4O5/EAu1gVGmQXnRfisYiPQ6J/DjzoRNKjJz
         d7Ourz48lBZ0ip30gdTuCFx31q9AEQ1dgIVG9z3AeSCRag0ZFh8KYSeHbj7+/I5aQvHi
         DcgLE3oXMSWW1mtACvo19qszJFiz+jzQxGmTaNJBmuAI8pmqyb16cYEPQg8hcVPY5RaA
         HheGJw7+ftEuVqsoqzyg7a8hf06AM0qBiNHxp5ePtxHlNEL74KgRFbTnRU5CZDqQrBF1
         RmtA==
X-Gm-Message-State: AOJu0Yy7v17mGP5g4bJ6FC13nPVOW2Xgd5rEGZf+CAFpTu55eXEv8Ry2
        O8A70dtweUun4lkUKsWq8rjnNsk4VkBJ
X-Google-Smtp-Source: AGHT+IEpB4ceFB8hMqXpgUfgfqjdrpt7iWJfuJvUFtKD0Y9n2ndn3h9cRzzXJUloa5oQOGJF/fsXJ+a1H0ub
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a0d:ec52:0:b0:576:af04:3495 with SMTP id
 r18-20020a0dec52000000b00576af043495mr19364ywn.9.1695447345828; Fri, 22 Sep
 2023 22:35:45 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:01 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-5-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 04/18] perf hisi-ptt: Fix potential memory leak
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
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

Fix clang-tidy found potential memory leak and unread value:
```
tools/perf/util/hisi-ptt.c:108:3: warning: Value stored to 'data_offset' is never read [clang-analyzer-deadcode.DeadStores]
                data_offset = 0;
                ^             ~
tools/perf/util/hisi-ptt.c:108:3: note: Value stored to 'data_offset' is never read
                data_offset = 0;
                ^             ~
tools/perf/util/hisi-ptt.c:112:12: warning: Potential leak of memory pointed to by 'data' [clang-analyzer-unix.Malloc]
                        return -errno;
                                ^
/usr/include/errno.h:38:18: note: expanded from macro 'errno'
                 ^
tools/perf/util/hisi-ptt.c:100:15: note: Memory is allocated
        void *data = malloc(size);
                     ^~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:104:6: note: Assuming 'data' is non-null
        if (!data)
            ^~~~~
tools/perf/util/hisi-ptt.c:104:2: note: Taking false branch
        if (!data)
        ^
tools/perf/util/hisi-ptt.c:107:6: note: Assuming the condition is false
        if (perf_data__is_pipe(session->data)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:107:2: note: Taking false branch
        if (perf_data__is_pipe(session->data)) {
        ^
tools/perf/util/hisi-ptt.c:111:7: note: Assuming the condition is true
                if (data_offset == -1)
                    ^~~~~~~~~~~~~~~~~
tools/perf/util/hisi-ptt.c:111:3: note: Taking true branch
                if (data_offset == -1)
                ^
tools/perf/util/hisi-ptt.c:112:12: note: Potential leak of memory pointed to by 'data'
                        return -errno;
                                ^
/usr/include/errno.h:38:18: note: expanded from macro 'errno'
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hisi-ptt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 45b614bb73bf..ea297329c526 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -98,18 +98,18 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int size = event->auxtrace.size;
 	void *data = malloc(size);
-	off_t data_offset;
 	int err;
 
 	if (!data)
 		return -errno;
 
-	if (perf_data__is_pipe(session->data)) {
-		data_offset = 0;
-	} else {
-		data_offset = lseek(fd, 0, SEEK_CUR);
-		if (data_offset == -1)
+	if (!perf_data__is_pipe(session->data)) {
+		off_t data_offset = lseek(fd, 0, SEEK_CUR);
+
+		if (data_offset == -1) {
+			free(data);
 			return -errno;
+		}
 	}
 
 	err = readn(fd, data, size);
-- 
2.42.0.515.g380fc7ccd1-goog

