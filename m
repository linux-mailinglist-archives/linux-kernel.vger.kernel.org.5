Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294E27D5E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbjJXWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344541AbjJXWYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016A51998
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81a80097fso65155077b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186275; x=1698791075; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fymRqgLhl5n1SIBrPc0QfOKYmvDTL24JHKj2ULWmDh8=;
        b=MB6fSisQ9Mzg+nwYpdT9l1RYvP7E37uzK/PFXvFTgNtN/Aem2ahuiBBObur4VXkFVo
         p9RcgL9HdBEekHsLtX/Yf2xzTLGU4StIUU5bA6UiUaSVq4z06w4TAYEKckw6gx03sW1N
         EQGwHUpZ32bLHGA1AxHd5PLMVS0yges3zPcF2Pl3yhdlKnbLUUE55ALZ6L6oMScLVG/z
         Y+MLkEs/Ydz7hqs+oHCYKfIkuM+6NoNAOdhu3XBtPNyseQZZFzFCNwrHZXxCsNqPdEiE
         0KdcYH/RQ5aum9KaqMn4egqsERjkcdTCmCdrqGHXFeLB29FgCwasQmxV+aiPfUFU4VRm
         wCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186275; x=1698791075;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fymRqgLhl5n1SIBrPc0QfOKYmvDTL24JHKj2ULWmDh8=;
        b=HTC0sUYgrOcwOlGHSeT5pgBfYPUpcxapbRXgk68DIi/cq5Lq3TMxXHierFbnmkCO/7
         ptCc3XYWEGEN0+vZL/nAL1DSQ22TrvK1Z3ILurqdfIU/ri/TzTyHPC8Kjug4HeNIbzBy
         ResmVpWhXbFe9DHxJW0p3V4ha5nO9or3o1JI8CDMUjUBoZqEWwZhmG8UoSPLl39rpQw+
         KgRr0WjsB4EPW+FRQhcPEPyF1ClhCsFyszPq4ce9XlA49PQSG/JKWkIwOZAMyp957RnE
         pglG2njn0T44LEzeMalau6ITsIa5OMU07DSjyAMIQBryvO6SWK+mPQ8Wens47sGfdS8X
         2flg==
X-Gm-Message-State: AOJu0YwIYfVyZFQRk6VXWIHlZQtF1P90Rt2tHpZL0GqYC6YKvB3j4mTW
        ljZG95tkiNoMMw3l6KtXWZuz1EBz+6VZ
X-Google-Smtp-Source: AGHT+IGhdi7O5ZhqnheMGqrQAIY05WVYo0pYxR8iw8GFpg46xp5pMtJOmYNKZ4MINF4sURPfdlTdvJxWf7b7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:76cc:0:b0:d9a:68de:16a1 with SMTP id
 r195-20020a2576cc000000b00d9a68de16a1mr273675ybc.0.1698186275302; Tue, 24 Oct
 2023 15:24:35 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:13 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-11-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 10/50] perf callchain: Minor layout changes to callchain_list
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

Avoid 6 byte hole for padding. Place more frequently used fields
first in an attempt to use just 1 cacheline in the common case.

Before:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        const char  *              srcline;              /*   104     8 */
        struct list_head           list;                 /*   112    16 */

        /* size: 128, cachelines: 2, members: 13 */
        /* sum members: 122, holes: 1, sum holes: 6 */
};
```

After:
```
struct callchain_list {
        struct list_head           list;                 /*     0    16 */
        u64                        ip;                   /*    16     8 */
        struct map_symbol          ms;                   /*    24    24 */
        const char  *              srcline;              /*    48     8 */
        u64                        branch_count;         /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        from_count;           /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        u64                        predicted_count;      /*   104     8 */
        u64                        abort_count;          /*   112     8 */
        struct {
                _Bool              unfolded;             /*   120     1 */
                _Bool              has_children;         /*   121     1 */
        };                                               /*   120     2 */

        /* size: 128, cachelines: 2, members: 13 */
        /* padding: 6 */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86e8a9e81456..d5c66345ae31 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -116,22 +116,22 @@ extern struct callchain_param callchain_param;
 extern struct callchain_param callchain_param_default;
 
 struct callchain_list {
+	struct list_head	list;
 	u64			ip;
 	struct map_symbol	ms;
-	struct /* for TUI */ {
-		bool		unfolded;
-		bool		has_children;
-	};
+	const char		*srcline;
 	u64			branch_count;
 	u64			from_count;
-	u64			predicted_count;
-	u64			abort_count;
 	u64			cycles_count;
 	u64			iter_count;
 	u64			iter_cycles;
 	struct branch_type_stat *brtype_stat;
-	const char		*srcline;
-	struct list_head	list;
+	u64			predicted_count;
+	u64			abort_count;
+	struct /* for TUI */ {
+		bool		unfolded;
+		bool		has_children;
+	};
 };
 
 /*
-- 
2.42.0.758.gaed0368e0e-goog

