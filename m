Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEC7D5E18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344612AbjJXW0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjJXWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:25:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A419AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso5901684276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186314; x=1698791114; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5GSFwgTEaHeeY2eroEgFXWdX43cKEeIAHSJl2+ftFs=;
        b=0I8qcJyc3yn8lYPUk7aGbCk15kVD0PJnIqIpfMbU1cSVQQPlXP7U3OjyPmOQGxmjiX
         rjKs4Lo2BeOP+4NszZQAbgiABujNw5DuGX9G0+do0DukMj3YGTqsut8PsRGYFEBm2dhP
         sVzbPdXeDPLMHzkQ85eInORAXgCOG7Mux+CH/FD6ORP4rDjoCfKKFpr3KBcEvmZwI4Rx
         ZdQXu9y7Kt8PcmT54AEdsgCF1e/mISqGhqhrcmmRczT3x6QbW2XTiCsZM32b6pDATWW5
         yEQY+LCNr7MO1+g5peninPgAi4fX4ND8OybYi1Ovx3cMuc2MguABw99JhAfadDBAmhdx
         yHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186314; x=1698791114;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5GSFwgTEaHeeY2eroEgFXWdX43cKEeIAHSJl2+ftFs=;
        b=jqs0H2Qjhqi0UHLi4tnhrhs0IKMWT+enojoKaa8UkrMS4hhE2cp3frprKVRLaxRHNC
         GFC8v0g0+GVvigS5C+ClBON1RzxPS8Vo47rvscTCW3QoYFLglPfCDS+VnhQ5pF0o+yLl
         kkJVBh/2y6rWXmcGDDOIcUMGTLuRq50LIhp68ibXI2aV9N9UNuNPaxwsHImoasdOqzhh
         XFbnfTaqszTT9ieCIeH4kxUY/iPaVWGNX40BRoLjpSgEi/MeIISkoRH9DjfFRXiTVnG8
         7EYfN6UBJ5rErnFUD5Yf8cwQmEeT6HOI/b20sEJAj4U6FsuhXbw8xs8VQcAqheTuLEV6
         2bnA==
X-Gm-Message-State: AOJu0YwKA0DnUVxos+qQCR/ptCU+1pMBesVkcajzB9SpCrkLSHtQNMTV
        Iu4swQwQAZw9XOVSNi/d7oH2aSZnRM/w
X-Google-Smtp-Source: AGHT+IFIFIL85ohk9wFL0+k1YIHYu3DYGpabOsSP/C4iBxiw3i3/xw7t4g7qwMBIwQ0eBdmNv5wNqmbfOdVw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:544:b0:d13:856b:c10a with SMTP id
 z4-20020a056902054400b00d13856bc10amr287911ybs.3.1698186314186; Tue, 24 Oct
 2023 15:25:14 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:30 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-28-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 27/50] perf thread: Add missing RC_CHK_ACCESS
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

Comparing pointers without RC_CHK_ACCESS means the indirect object
will be compared rather than the underlying maps when REFCNT_CHECKING
is enabled. Fix by adding missing RC_CHK_ACCESS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index fe5e6991ae4b..eae3041408a7 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -385,7 +385,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread__pid(thread) == thread__pid(parent))
 		return thread__prepare_access(thread);
 
-	if (thread__maps(thread) == thread__maps(parent)) {
+	if (RC_CHK_ACCESS(thread__maps(thread)) == RC_CHK_ACCESS(thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread__pid(thread), thread__tid(thread),
 			 thread__pid(parent), thread__tid(parent));
-- 
2.42.0.758.gaed0368e0e-goog

