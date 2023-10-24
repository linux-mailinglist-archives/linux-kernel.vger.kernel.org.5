Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED07D5E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjJXWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjJXWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:32:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A82106
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:32:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da05c625cb9so771924276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186728; x=1698791528; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5sjI1f5vh005/1ecdkhswjpcyMDjRf+co04ydutakFc=;
        b=T8zHFj/OHVjxmE05D5BJ81aNeynwMc6CaVRPxPYfjq3TZLWjCO/t2e4VRGeiijxxHr
         Fl6dmf5od/bGTyYZoI2YpgJCdESo007yg573epmyX48R2DVZSjLA+zv/YkzQDLTaS7fg
         L7UKpvvzBsZ/4IpS1hTf9wno/5EzN7N0jvmsg3YAyT2NGaAwKwdbZVRza4jSz/nBjlYe
         KS6X98rkNrMJNGhmjI6lZs8t4r1B21miEBxXTrhIEqURKzPkDKmFhpgsIeGNZKis1U09
         zUnqnAVTSmP3F1P3IXHpn0sLXJA8LDcEdrSBWDlK0dwEUg80g/Y7xKEwXbpZEmTTkpbz
         tx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186728; x=1698791528;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5sjI1f5vh005/1ecdkhswjpcyMDjRf+co04ydutakFc=;
        b=P3RvO6LWsY7iMEmkRsKpMFt2YxElEGaisvDm7sP7vXr+BqZVxmqd2s4ET61NPNDT8q
         Q2ZPI5qKTFc2cEJgNvC6DMuNwUKyaCQYMyWL55hk9y8O0ZfI8WEfocysd3BjQo9AJt11
         DcyQPXzcgBZf2yrF6MiBhLe8GBijP47aDwbYsVDnyKiPvpWeMXW50EQ7JzB0KyIgdpNv
         ciXUO2xbGf97a6ZcIoL3pERHptzcH4Q08OjIyM9xAcbiF7xCHd1Iqnp4CTT+RLbwJx2q
         bCyOpCfJxofchnc6G+jDc+QuCZ+XOSNVBQGFYrbtEd2U2AuAJyou+jMdgpHH28+z21Rp
         xcOA==
X-Gm-Message-State: AOJu0Yy0OzGu0hMGlJu2GQ5u1az7vtTTQqv4KZYLS+UyoqnRt2m53pXy
        qKsVOZKl1s0FMgB0P0Kzh97EmCQVqu6X
X-Google-Smtp-Source: AGHT+IGyVGLRMSCRZiZ7/84qie+da+k0hc1yspyUwRnl9NUhjP0cDot58jEhGfqQ0aDKIoxV/jlx5re8T6mL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:181e:b0:da0:622b:553b with SMTP
 id cf30-20020a056902181e00b00da0622b553bmr29800ybb.12.1698186365779; Tue, 24
 Oct 2023 15:26:05 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:53 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-51-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 50/50] perf threads: Reduce table size from 256 to 8
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
2.42.0.758.gaed0368e0e-goog

