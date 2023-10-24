Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB67D5E09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbjJXWYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbjJXWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6231705
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so5993692276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186266; x=1698791066; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVGR9Xyq2raGKRiGJds6iUcO5Lwf67o/Z2QHhpJQbfc=;
        b=ydbfqHeKgSmvFccd0/lADv3jDFkKDDTtxmixOmTXahACyrE+ZbWlkxxgbjNr/CQEeM
         d+cfSwlTgZSyT6SM8NTk2sjvATpeYifQt66+2zi2i+FpB2gH0A5VVjJrkoAPKe4A8s0G
         09dIdKRnwy2R1ipHQJPVWTt8+jS7TRPuFFkH6t0heiUigPwY35F0Bvmsp55cYhUVKROf
         CiXKIeWui1hEXCBec5lnKU4Kqke7cIWHJg2bd4xtHQc5wmK4RZ9HBH7t7t/ZvTDu0PiF
         JWwc5+dfjSDD2voG0Agh4C4fQVN4AehnvGsbJnZYty009NEwb+6UYRvsZbdoGEQYGUbx
         ho5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186266; x=1698791066;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVGR9Xyq2raGKRiGJds6iUcO5Lwf67o/Z2QHhpJQbfc=;
        b=CI41txB337NQS2u/XufX66uC0q3q6OEmB2zHTod/bMLWQOw92RQa3dzVJOwDvSTssj
         HQ6rzRlp/crQUjAGuBz77xLzmQZN1iS+brgU8eccr1auSsZ/i53FJ98HwFNF3W+2rH1g
         7rfm0i16QaNmx9bDCHvzyrA4gljfVxezxEv4F/Gtc4K+rxyEwfzTz7DammUELxmlqa4F
         Z0pCVRlOX/yengzMMyhqBUX7TRSXhtWcx/rtB1qQIFoSGRJFrwIOEogk6IzQhSKnFNFh
         az1RQ3yFpYvu5Dh3pXw9oc6ika71UzLqEcarEm78LyV8so316ZaF5sFrVnLSvKrAdfmk
         vjYA==
X-Gm-Message-State: AOJu0YzXle8Kzwc2aZMeLGhle9j9A99IBTdJCVDQfXTOivyigd1+j2dT
        warLvKKyG1+y6+6Bj3mmc7hwJlQB1bVW
X-Google-Smtp-Source: AGHT+IE0LnLyRZWa3HLVttfv23W2KKPiQIO0rXTRdCKvqzFZLAQ2zpqNdQtleswviPvhJJuZK+5ZXsYOiV7e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:8541:0:b0:d89:b072:d06f with SMTP id
 f1-20020a258541000000b00d89b072d06fmr256399ybn.7.1698186266012; Tue, 24 Oct
 2023 15:24:26 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:09 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-7-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 06/50] perf threads: Remove unused dead thread list
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
index 098600d983c5..31fdbb0f27af 100644
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
2.42.0.758.gaed0368e0e-goog

