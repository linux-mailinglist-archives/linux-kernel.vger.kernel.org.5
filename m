Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88077C6581
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377831AbjJLGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377511AbjJLGYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C5121
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7dac80595so10309457b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091865; x=1697696665; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyUH9hPvlymkRvCiwSN/eO1tveUn9WvUsIn+qftqtUI=;
        b=Alk7tEDPHfTdgiMo+0PFgEDjLvWBrSK3IfWkl31fYSWOCG4akAVMrqufcIFG4/HVDN
         wgQmyElp5SPpQ6vjaT5WBoTe58dPdBPPeY7gJpyiiSYRXRJapxkf3PrL24MuP8zfL/nH
         SuRwrJmZuZzLNreab+8kXOhSLwRDdHW/z/wlRMJV+qNCMrLrf/OALRwOvtpXRSKbN2u/
         vxVwSWDeuP477+YQKoH87k/lZfRx9PhCV9ZW6+26k4WOQ50vG0pqVVZZtlCCDzIGhSHR
         5Evl2uuNii0wVWBlgieQ0sp7AZCF0/3PKDRdRDdCkKuPKU5o0nVtVDZfX1hghdzmz0XZ
         LiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091865; x=1697696665;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyUH9hPvlymkRvCiwSN/eO1tveUn9WvUsIn+qftqtUI=;
        b=f7VxbUmBcjhA8uS+JCHpFbC0slLjuBmloTd3Q+56/+i3TzSRQ2G/1phCa/tl1jcrqo
         IvpycnParuIObGcZ2HB70u5sdWcCh1EipLCZbVnreg9dsnc785kaTx820ax4uxNw4x3e
         OfBlZokjin1gM2i0ED/pbHfH4K20A02w32R2yEj6yLbe5DFXIF80/1V/SOpL1sd4Wg0/
         9XvB1wW89hnIe/jxrl+cXasUfVhtJneWTnUEKXxnap0MH3C1rvQTVsr1ygNuWTQhyhky
         rOpwI8lV/6KrCRHsT7Aop3iDR0Oq93YDUJjRZy8eUwQ6RdfF3XteE8uYW5zPKXMb85Oi
         FttQ==
X-Gm-Message-State: AOJu0Yz0RmcEomlU7FTBpaevk4GoFXoCQXgd/FivxEL4O69wnmJNxdkX
        RoxBwId5dJdBADIP4VkJtgMCudGVKT25
X-Google-Smtp-Source: AGHT+IEH07HDyKE3C92uXlhnmTt2oGTYwu5Ra01CUAR3cqmzqaFcrTMzzdIvO3clx52whdoAvv4Md0oSmVlO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:b3c5:0:b0:59b:db15:498c with SMTP id
 r188-20020a81b3c5000000b0059bdb15498cmr505881ywh.10.1697091864943; Wed, 11
 Oct 2023 23:24:24 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:54 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-9-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 08/13] perf callchain: Minor layout changes to callchain_list
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
2.42.0.609.gbb76f46606-goog

