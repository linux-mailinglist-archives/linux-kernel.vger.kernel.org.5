Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F57BAF36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJEXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJEXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1811F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so1378483276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547375; x=1697152175; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=TUOafyNyFpkw5HlqfYRfZ2KDifTOAdVmsiDbHfjG/tZN/K8MzsmB/ZyW5kBRpV2Vxy
         de74SPcO2Y7bY63zeRo9X8qRZb4HqiJdZ5erMNkRGnn2RLShlYln8bQWo9Tr1me2ePok
         FQI67umDKydZoQghwfHdaV8hDbSXJh9GRZgQ1CsKGmFkPlmL5MO7j/icse3vDywordTm
         8W/sjG/pfzMWKZR3cNINtiHol7zEsm3s0i4AxMwLJqVdmUaG8VVo0nQtuiSl5ljNeFF9
         URw4OS+6wvbgPA8PFEREKVzNQQeBUu89MH+A/ukCoDC3jrHzJDnR1x+stOZJBTl/VL/k
         YAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547375; x=1697152175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=stQCQlSWpjq+llZZzF6HDAmtRfWg7u2gbXLflJmbHiTZhpLMYcD229LJYLoHqqrwrq
         D334CTm8sFBYL8/NmgFQXpyQGBVKQrj9Bi7UuExZkkuafvfmhz25tvH/FBmXq1nAW4b5
         QikSImkeZWzaSgGdFVB3CdTualEN+fFAdETdeI6KYkuD7q5X0VqxyWve+Sm5guf/hMM/
         T3gPtrtJdVQIB9tfX9BswqFdMNZ0tZe6uwiTf9H75QnO0NRhub3uu42HqVnnFjEWajrK
         4tgMPARuf6n7T+Ecb6kLK3AiEGt+AgwP4VMeR33f8bJbW5PqWKk0TS4lJ42WtRe0GqQE
         5jMQ==
X-Gm-Message-State: AOJu0YytpsmsT0Y71buh5/vCX31QqRKlZ3LhJR5SuNftR6ExkCUN50uD
        EHYLITwRs9/lLFx/cKOp6DEMhiXCbmlj
X-Google-Smtp-Source: AGHT+IGhoEJjFH3ZasD0vN2aSL1BJQWA509hpCLmPH3Yh8OO4E14fhwoU9hhQx/jEj6F0UZsTT+z8Dsn07pZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:6a04:0:b0:d89:42d7:e72d with SMTP id
 f4-20020a256a04000000b00d8942d7e72dmr57696ybc.3.1696547375084; Thu, 05 Oct
 2023 16:09:35 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:49 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-17-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 16/18] perf trace-event-info: Avoid passing NULL value to closedir
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
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
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

