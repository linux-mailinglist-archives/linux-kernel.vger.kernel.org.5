Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778B7DF988
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjKBSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjKBSDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:03:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61F1FDD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:59:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so17492367b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947968; x=1699552768; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWO5cb/JGhq0YhhkeavtzpdshUSY9BdgMbF9Q9qBiTA=;
        b=uRoCphS4a9ghls3sAYAX7ZAuJANZx9SSqLeMB9FiVNgB/fbH176oYzGdft8sdIpm8o
         wXq+z+WBKiXVhnxX3RPhsytFffanBsYX6Ta06ScOLtprRjYvR014DfYQo3eKyHs2xiU4
         Tua9WqMIa4eDW9qpEKNZkEqAblO6J1vRfbJJOpCibqvWYaXcymcYIx2+gEpdvVsa7RyE
         6mfd6QnBwXUhvFeKM0b08PfFraQOpGE5qnzGiFx4PJFQ+J6c/KXKhq5jT+YEfIZtYc2+
         sV8TXUwGJozE55n6/j/kGWW74EwZJVpFYpI5fEH+obnqbZfbM9eHWDKoWlxtWTDnIclu
         nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947968; x=1699552768;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWO5cb/JGhq0YhhkeavtzpdshUSY9BdgMbF9Q9qBiTA=;
        b=I6XLXIKy/8bAXuuoOdiL3JLq31AVbIqFTJy5rCutlv8g4t7M8MvDCV621flY8/Fza4
         Ai+uXU68sCuUUQGsEUwRPtYa8lseDwrNhQKSXqb5AimR/PaptlG7LLmgxshltXckLHhX
         inwc3TPZyW4PJ473Zvz0558I6Zxh/2ikSbfINtHPNGc9FozsG5CBwElYGWoEMoCgFH2k
         Y/L3KA3UwR1bhXatO+oHdqFGt5an0Z8U4fxxsLQQRKYfI9sS/Omq45kGvs5z+tICkZHH
         hHzM33I/KnY74bOc4cAOcQSqPfBmTeWais36Om2nEVcuCrkMQh0C6oGt3E+FxdoC4XqZ
         FSSQ==
X-Gm-Message-State: AOJu0Yyh39YpeaSeizVQbNahlZ17nYsRa3sqt4Kt9vCgQNve90WUFSiN
        qDDcGuBjytqsMrD4i89YWe6YLL2jlb6Q
X-Google-Smtp-Source: AGHT+IHiCSNiwtVO+sCrdD2Mg2fwEV+vcc69wWBZdswoUAczP+5MhgJ9MgBKBwzIu9ysa21AlSt8cBmLq49h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:168c:b0:da0:3e46:8ba5 with SMTP
 id bx12-20020a056902168c00b00da03e468ba5mr359961ybb.8.1698947967753; Thu, 02
 Nov 2023 10:59:27 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:57:22 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-41-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 40/53] perf threads: Reduce table size from 256 to 8
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
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0.869.gea05f2083d-goog

