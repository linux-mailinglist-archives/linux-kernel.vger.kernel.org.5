Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773FA801815
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjLAXui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLAXuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9310E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db548f8dae4so1467234276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474639; x=1702079439; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMWeTAylF3bUIvrApUeKD5Af/l0nzPxNAdOfQ8ZWtyk=;
        b=VPLK8ylzIs3LTjCvGHt2TOWKY6j5qZOCmv4K5x+D3BP3VeNe+ETocBZMJnW7kS1yll
         y+6h7yhVC1i4z8uHnSxkQNaSkXqru//4CzP2MMDfiP7wCnFg8otITcuVT+FsoH6jUj3d
         2gcrgTVmlUXzYHWf5KFMzj+DORb8qHSNcYBy6xcZdZp/7kfU21r4N1pq8+R/J6W652Hf
         zbo4AEPvP6rgUEZzykB2T/fbB9zIoKZOlLhboNw9n4Sha4rfs3pF0GOB96zqh3W4E4wH
         6RGZiXbOrUjKStkr4D/xw4udz48v5T2eyiN0+elVTmofHlCMLVP/Nz2LiLJy6lh32u4/
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474639; x=1702079439;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMWeTAylF3bUIvrApUeKD5Af/l0nzPxNAdOfQ8ZWtyk=;
        b=ofNVr5kglKDFkUVHbitCCqC8X/muTL/xEVlUwQefZEHlDDvlknq2Ro58mSaLvL23bd
         yD3VA/6gc9EgMjxJQHRPJBmay6vUXx7tjtpF9NrrUBrMqku+fRLA70eCePBxTb4zWOWl
         YKEnmU4n9QHpbjujO0CXGxGA8eDsvUmFzcuW2mBLyjKOUZZVSEhSND0g43UUG5A7zWX5
         /sAwzsqLrgaiLCAybqS5RvzRBzkVAI8/KRvv1bWZezRt4kvxagDB+Q3CjgI2oyKBX95v
         o/RBJfhj/O+Ye0Y9dj+HJrWBH5pmHoILXRNSwarsPkS47W08498gIXSTCjKOs3rQUn/Z
         SQ7Q==
X-Gm-Message-State: AOJu0YxFqsvKJsYgInnmY1cqxQ/dfsc9UtuwAD825XtB/AUHgsLMaUVR
        8X0bTU3QuesBL/LaLwhnY3twlavjLI+t
X-Google-Smtp-Source: AGHT+IFNARd7MyKjCR2gLvJy45/OB20UrZiZukoWo3tgtMA/0nbQdgyhR+LI1WVbM0lMkdiPHvakkjNz/pMc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a25:dad3:0:b0:db5:3d61:8e63 with SMTP id
 n202-20020a25dad3000000b00db53d618e63mr241281ybf.13.1701474639430; Fri, 01
 Dec 2023 15:50:39 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:23 -0800
Message-Id: <20231201235031.475293-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 1/9] perf thread_map: Skip exited threads when scanning /proc
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index e848579e61a8..18fbc41d09f3 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

