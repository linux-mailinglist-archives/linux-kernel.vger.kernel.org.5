Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736BA7DF952
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377271AbjKBR7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377186AbjKBR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8BD43
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9b0850fdso17011137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947915; x=1699552715; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wyNJQL6CFNlRT5cB8RLt/NVGX6O9HhWy8v7f/NT0so=;
        b=J4/rq3GfGSJmb3gADePg0FlMl9oi2h0BAEhZI7ydS69Tt7/lUZYn1m6WER38PmoaIi
         SCgU5uW9O/w5dqnAJgTyTkUf8w7fpTk7hiri3Rsd/nNug21HcABFykBIkTU6mX7oX78j
         nde98Rt9QJmKiuEBOgDqSmvanWO3HMMUQ+Jc4EcPuNlAxqDZpzL1j4oYezLdfWpXNH2L
         ZPbV1+W7tc0y0jJlkUR2QVUMAXBMJqwzUIKOL74HEgWaakcqAn0i+XWV0aVvJT1Mobx7
         CTXCBkxy/o8M1zwEvdp9fQg9s8RMaKQU9kF5UNfqQyNAO8b1Xm5GnXXl7f5ENN/HCUIS
         HLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947915; x=1699552715;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wyNJQL6CFNlRT5cB8RLt/NVGX6O9HhWy8v7f/NT0so=;
        b=jFRALHqRP8Fen8ipTPRZW+HLmQO4BgG7CEypneztjHUr72unoF39FvukWDEeBJ/SU0
         W+Es+p3Tpu11AO94EFy9+I5C4rGgMPrhAhsvkJzWzLxBrF/ho8wQu/EWseWhaFfjacrw
         JXwl9k7IOgB3fIaRxWU6moEAnF0KJl06XYRdCZk8CqWRv59JltiDv9exyYGYhxNlxT2W
         oFOeIHFTcNJIMYOhK7PKS1DdD4S18SvWh80KYYfErU8cIzGNSo2FXlA7AajLZN3u1V7K
         etk26ViwisDrqwmkVujDzM9nTRtlqUXOy9OD0P9eJxWhoxSpVmn5IAZQGubmOx9izmJh
         m2bQ==
X-Gm-Message-State: AOJu0Yzomvq3n5hNIN9XmkkZlWvA+XbnxrB/tGKBG8FWvmWuQaoCs/Pa
        mS8vCk68p33t+sLvxJLA9ZdSJCV9nhsR
X-Google-Smtp-Source: AGHT+IG/B4amwFWUdCbQdFbH1v4t5k/iqzDovRf0676Vjzl7BmB8YUgC5+6UGPTVqUpovJAXhLHGou4rp87G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr460458ybu.7.1698947915222; Thu, 02
 Nov 2023 10:58:35 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:59 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-18-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 17/53] perf thread: Add missing RC_CHK_EQUAL
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

Comparing pointers without RC_CHK_ACCESS means the indirect object
will be compared rather than the underlying maps when REFCNT_CHECKING
is enabled. Fix by adding missing RC_CHK_EQUAL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index fe5e6991ae4b..b9c2039c4230 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -385,7 +385,7 @@ static int thread__clone_maps(struct thread *thread, struct thread *parent, bool
 	if (thread__pid(thread) == thread__pid(parent))
 		return thread__prepare_access(thread);
 
-	if (thread__maps(thread) == thread__maps(parent)) {
+	if (RC_CHK_EQUAL(thread__maps(thread), thread__maps(parent))) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread__pid(thread), thread__tid(thread),
 			 thread__pid(parent), thread__tid(parent));
-- 
2.42.0.869.gea05f2083d-goog

