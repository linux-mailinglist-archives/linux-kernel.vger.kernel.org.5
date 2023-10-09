Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C331C7BE9EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378329AbjJISlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378343AbjJISkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:40:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B311D73
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:40:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0dd156e5so81024937b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876806; x=1697481606; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=Zzs8LgYxJ9L34/UUsH7V6H7bLUTX23gvXUy7Mis7bsgEZ1NHQFm7Xqx5y1ColHjZmU
         C5XoV/I7JmmKjC8RHUgdjBJF4jz11xylRZuMCUxRrIjLk0aM9jQp0mu5lZuoxzGwfMUH
         CTkWcQDEyc4/7GTBB/xlNduPGC5VzbIfZKILSA1Co9c6Vlb2bczlCQ5sDNgX4Xrp6jed
         xssAASOpyGbH4IkmXmfMNO6xc7upBOnVq4T/GwgWkDa6Vs1G8eDLpdcFq2qkiB0D6ip+
         yKNhbpiGaK6J5rBJnhLOihTl/TUyZuzmHj5j1BbDJVf0pcQ5uszG9XaTkEmMqUDv/aZ8
         bJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876806; x=1697481606;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=lBhJekOucsMCM8FDPs8K0RJFbbYDdiNLiSO58UkB1F8hP8kAPHDW0ndZ0tA5tXsjS1
         M6OanwSV1zY1ln5s/EYWuNtkkz4BSeIfbKtwWrouJRO4+586fn1UJ6N85IyJxMrWGnNR
         xj7Wh+Xy39ZQ3NZBDERR+ZgT1O1ET26uYbqSB786dBZTHOfNj00S94oyixCxEVoFFRGf
         hqN594h6qef/rtwuLvQmwpR2cZhnlIsNJXanphAHqfKJH+52inb60kJb5/iIyuy+1e89
         wAV+1ZoMzjKGFdYZQiXdjTfdbjqyvkU4c7nrbN1KquzUajYWuQY/mU6ZQ864bSQ8TO4R
         ngFg==
X-Gm-Message-State: AOJu0YzLusUhFcn/Jeoyv/mjBilcFwzAelnwIPX9Ds/vRfOoIqjEQZ7q
        KsUqI4Uu/os+SNCDucWwhRh1bNg+7wUF
X-Google-Smtp-Source: AGHT+IFMZAJGeAEJwTa3L5Oxs6LsX8RfIY0fXdSBO9/RQSc7uGeMWt0HmEUSALq3ek1DTJsNNu1coZWFWJ50
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:4c4b:0:b0:5a7:b496:5983 with SMTP id
 z72-20020a814c4b000000b005a7b4965983mr17187ywa.9.1696876806075; Mon, 09 Oct
 2023 11:40:06 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:18 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-18-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 16/18] perf trace-event-info: Avoid passing NULL value to closedir
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
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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

If opendir failed then closedir was passed NULL which is
erroneous. Caught by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 319ccf09a435..c8755679281e 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -313,7 +313,8 @@ static int record_event_files(struct tracepoint_path *tps)
 	}
 	err = 0;
 out:
-	closedir(dir);
+	if (dir)
+		closedir(dir);
 	put_tracing_file(path);
 
 	return err;
-- 
2.42.0.609.gbb76f46606-goog

