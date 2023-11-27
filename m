Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF17FAD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjK0WKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjK0WKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:10:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3211FD5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d032ab478fso22182097b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122996; x=1701727796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzfDI2A+Dhir6Mech0OT0IIjPNEDsBuzrIL0dTnaONc=;
        b=WPCl6vSIkYCmhmu5akCPCP2wiA+siWnPsU1ovqYyvnlCilvAj/f6d/b7vgwr+E/diC
         Ba6bBizXb1y82anhXo8OS5HdKsXpKCjA72oMgZuGAhFyaGlM6TMycIJBW9NdDAqdzyO9
         te6IJFlwKLbAZxtZbDSSMlhAZfqszic+zOL7Ercp+Q3xfVjP1Mg/DeWRNDcNYsY8m4PE
         5agcqzjazPelhn8a3OdtyzNGmjQHFNE1NUbmPvqx0AVDmc5rnl07tzOO47U5JmptxV37
         HousULPdBYyjJfZUeAIy95e8Afl3enRxsd2XgUbJzEi8G5D9WLdQA+K+9FdqpMjMgOiB
         jL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122996; x=1701727796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzfDI2A+Dhir6Mech0OT0IIjPNEDsBuzrIL0dTnaONc=;
        b=IkPcVz+e3ihS2zH7oMNYhW8aoh7K1+wJzPCiUXPPAH5MqrjN2/cBApSDeeJCE/Tb1e
         jhdDMcIGgiUaAVAR55u9WSFj8ne+4K0aXBxuHc3of3tmi4yw2hO7nvtCBJaZ5D9rxwmw
         IwvCsECeAdlb5VBenc2zFzRiF2r2ZaP58voPVJYpYQIIV7/dG1mpMPtNqK4uQubDZmk2
         iPkJj+UyYSpm+ar2jesl5SUFR9GeBiKosxh5fpm18/fs59kchQFhvAYhqxbP2HNrBa88
         aAZSPSzCk7aTdfT0+M9CfkBQ9eAYlishvG1EAKY5cG15nBF9KfUd2Q2Bz1xC5VlbneAC
         Jz8Q==
X-Gm-Message-State: AOJu0YxDtO/xRWiZkCOuuKS3Px/oULPykLcqICKFLNPtMZpApkhg8Et7
        nJEJjH28RFgJtCPIIATuSomASvaWa2wM
X-Google-Smtp-Source: AGHT+IGaIKu2ArZXpqNdtgLevplTsAmQxqFNH6ymMaSKl7+FsV5pF6ixsfu9G03ipjuFp54UpIs7B5jz9E9Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e87:b0:5cc:3d0c:2b60 with SMTP
 id eu7-20020a05690c2e8700b005cc3d0c2b60mr369861ywb.4.1701122996145; Mon, 27
 Nov 2023 14:09:56 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:26 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-15-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 14/50] perf thread: Add missing RC_CHK_EQUAL
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
2.43.0.rc1.413.gea7ed67945-goog

