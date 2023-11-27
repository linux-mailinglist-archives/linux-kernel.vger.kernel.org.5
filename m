Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B07FAD26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjK0WOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjK0WNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:13:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0383252
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4038d7cfdso4283357276.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123049; x=1701727849; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HtKu9iAXaV88hgxFxNvjjL2GaCw51rWrgIl23jSopU=;
        b=kaZt8UKpJh8eSa03SjPg8YmVvsB61n0XkjbapUWvBpD5C5NehTXQUD2lfWbM1WfJQm
         3J6Enc9mEDc2dOod8XtnnHI6OzLp0CUCEUUVUDfpkNrS39IGn8xDnZGH145aC29ADKks
         AOErk65kPODlI8xsclcrUfwooRWcBgYRxSSgnAtYDlRihaoGSIszG8l1r8uM4fOiNtP9
         +VdjOuukGeEo6gYEwxTQOUnb/H3gsyKrVoT0Z6dzXJF1O//iFIhtm6KNptw+AlBI9eQB
         i14RYVMsTNMQ+r4P/xckphgA23UvVfV1iazJ38UrBEFVGCG1BYoQk0qvPLyl/Ey7LtWj
         h59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123049; x=1701727849;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HtKu9iAXaV88hgxFxNvjjL2GaCw51rWrgIl23jSopU=;
        b=ry3vh5Op6sDVSNyIOOI+Z/wFogLsTL0tm6Mr8HssoyyW0PMirmA0tCzs8rBNKIRBF1
         afUDEREIVgkm/N6H+PDjN1oQ1GXzUmMOT/ct8fE8bxNOcFPGB8trSaWDuU60rDQzo+o+
         ypgB5D+CthiQ26fC8W9Vl5hvKTE7z9///SnsC9UHZjiEpE3IU3Rgotgs9SVnHDUutDE2
         6frlzHdlYR7HYqzPOxuqHTDh3HgqnFPX2VtX2HCv5+06L+9FmHVXSs0gbMeBaReMkJ1N
         agpHbZP0J7B/k7BBCHcji1NMuzblsu2idNePZG0hd/PaVW7w386uK9LFCscvzUYogbVL
         xytw==
X-Gm-Message-State: AOJu0YyYwKHo5jwoyHBynO3hGWPfWxIpK5b1Z7Q4oy48ZOksXkpKrhAq
        czQFt/usTa1MuAdg6HW8IEiWSyXMHOxP
X-Google-Smtp-Source: AGHT+IHKwGIzqmD+4VwGagbyeQGdljxxm9mwjsTQKZC4lVrD2Dj8rBymf92im5fvsMjXaEfXJyCoq+wlFK29
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:24d8:0:b0:db5:2a4:c55b with SMTP id
 k207-20020a2524d8000000b00db502a4c55bmr719ybk.2.1701123048730; Mon, 27 Nov
 2023 14:10:48 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:49 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-38-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 37/50] perf threads: Reduce table size from 256 to 8
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.rc1.413.gea7ed67945-goog

