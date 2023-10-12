Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD87C6575
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377585AbjJLGY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377515AbjJLGYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B740E0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c4e10594so10155497b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091854; x=1697696654; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeU4glzf7AMn8qq7ueoEKKj+mEB5KFmYHLHv3WfeocA=;
        b=Z1U58E5GbHMjbK2/Qvu2IUfacU3bHmWnp/dsMURmSj5lXZzDXJRBfgRJNJwFu6ZWNv
         ZWaf0aImIotiOsM2ZQM8NlxyHZKsjUQpTrDW5ZISggs4ur0oMZAGQwCjhx85jNkG/Us/
         gAPLvqsl2Db44SNrZwhbLqk2V3VS86xavDAB7+hTkeRFv/dLY1zqKPHn0UTAeH8IDIUH
         W3XUan4+Sb4LzaRnByD9tx000aOkrs4JZ0JHlei5KtBz2SZLB/elFKpAOGulIMv0hZnT
         5zKKTDft6mPn+7/1VpE5qwgYWjAoNkfCO8sCtHfLFkQWJE56T1T1D59ySmuyAH5vjOot
         t45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091854; x=1697696654;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeU4glzf7AMn8qq7ueoEKKj+mEB5KFmYHLHv3WfeocA=;
        b=i+w6aIq8Zw3GCk390Ajm43c2x3nvFnMshV1U+ztn7j3bvtE2KcC2YVPanx6pzeVZv5
         TO0LSwRjeBzVDk0HxqpQcujkcCMZGlsvFKAQhx+GI3IYRSKIpou/pkJgo04JH6y9ot7b
         dViKv9FrZf8l+I1oK4oKdGVNkQH3LraRUVhLuz/ozEY4ZnErn4iZ+Qo/PFRv8GZzcvVm
         P/9kk+w/yeeW9DQh/5e2V6hCzgdLFyLqmUPRvTNM9HuafYbksOl2NPa7bvtZB/SHElUl
         SqXABHZkMh+TjNS9O7eNveS7RPhuGjZRYcDYUjhW1WsZNHWXUO5Gf5CuEnXDyAaVmG2C
         5MnA==
X-Gm-Message-State: AOJu0YwSYwEu9x3rsAi1RZa/YRkfinMZsKxR7lnhYWn105T8okWERAC+
        siQcCWs1mTWXuc60ghs39Xecuvl1TUAz
X-Google-Smtp-Source: AGHT+IFbaF0JvsrJA8Pyi6Osn51e51XYhIhZKsVyPx7J9ZnrwG3gy+KXZ6E7OltXta56RlS+hciubo+AXwqC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:d510:0:b0:d89:4247:4191 with SMTP id
 r16-20020a25d510000000b00d8942474191mr430367ybe.3.1697091854712; Wed, 11 Oct
 2023 23:24:14 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:50 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-5-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 04/13] perf threads: Remove unused dead thread list
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
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 40826c45eb0b ("perf thread: Remove notion of dead threads")
removed dead threads but the list head wasn't removed. Remove it here.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 -
 tools/perf/util/machine.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e0e2c4a943e4..8e5085b77c7b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -67,7 +67,6 @@ static void machine__threads_init(struct machine *machine)
 		threads->entries = RB_ROOT_CACHED;
 		init_rwsem(&threads->lock);
 		threads->nr = 0;
-		INIT_LIST_HEAD(&threads->dead);
 		threads->last_match = NULL;
 	}
 }
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d034ecaf89c1..1279acda6a8a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -35,7 +35,6 @@ struct threads {
 	struct rb_root_cached  entries;
 	struct rw_semaphore    lock;
 	unsigned int	       nr;
-	struct list_head       dead;
 	struct thread	       *last_match;
 };
 
-- 
2.42.0.609.gbb76f46606-goog

