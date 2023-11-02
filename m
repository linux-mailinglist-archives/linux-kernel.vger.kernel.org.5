Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7557DF943
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjKBR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbjKBR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22453197
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:57:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so18040277b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947878; x=1699552678; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wm2Wlx9LDH2uZyz0Nou/I5Qg1x4UBSoUiB/FkPORelQ=;
        b=Pch6qaGemODBCqyrH5aOelNKvoPmI9l2vhAndRxNF9h1qkm4FhiwfpAYppJOSpALZt
         nqMPF4TT5FwMENns2m8sRAQh16j5Me8G3WsfdQedMLnwuSEXbMKs3nK0GmANkht0b7EQ
         s926VY26rXyGqY1CXjWTE/qxyxX67QRVAh8w6/sOuKUL8bo1e65FC4+Yl5bSA2/CVMux
         oA6j8Fnh3IGqAMXMxKW0xaaFJ28d1vMoXWUvQSo9/MlDiWmG6+K/zM2rwBChqd+a8opC
         IS4RiZgmGmVQqK2HNUYMfVq2s7sO2SjJ0rwSQBCmyN0u5BhRnHt6hzBhndBKYzNdTtqH
         ZaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947878; x=1699552678;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm2Wlx9LDH2uZyz0Nou/I5Qg1x4UBSoUiB/FkPORelQ=;
        b=mE8etABlWEqoTIuahMFQY1KOc3xTvSiqUWyG1/u8TeQjiD3tQXQS1HgQ/0ZUmeErOZ
         8vlrcSJAONV13U0HrwwbOO9uqCZPXkEJvuEDfhlu6TfIb14rOjT/BvaenPQibejhiqF9
         1Tf2Rs5FBRrKufZSPLIGIDTQbOA/Zx6iXDM7NS5xiiA1V3UanxodVvYs4HjuA4JclIpp
         b2E+y1Kih7bCQzT/A710wGxOy7HMkVvDjTt3hcywNqZKPQasn4DlxXcIQis/i4pqz5UC
         ji88AvSGXXdfizJ+Nae1sgfIZPu0IJdmlFd8bI3bBBz+MdBX14CMt02xeT+kgvHccIi6
         gabg==
X-Gm-Message-State: AOJu0YwOzDsqA2lS1ewKLLOZDnGzTQd3C4NbUfz++PQLxYLL5LWXrtwX
        MJcjfrJqJN6dEAdCvzgNE+xhPIwWnWZc
X-Google-Smtp-Source: AGHT+IGhImc8PbN/vWcavGImLPGZXQdTvZdXtvmCdIUpNxNwttCsJ6N6F0SIJP7ks90b81FODbM1hHEu9GRM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a0d:ea95:0:b0:5a7:b575:49c3 with SMTP id
 t143-20020a0dea95000000b005a7b57549c3mr8687ywe.4.1698947878251; Thu, 02 Nov
 2023 10:57:58 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:43 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-2-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 01/53] perf comm: Use regular mutex
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwsem is only after used for writing so switch to a mutex that has
better error checking.

Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index afb8d4fd2644..4ae7bc2aa9a6 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -17,7 +17,7 @@ struct comm_str {
 
 /* Should perhaps be moved to struct machine */
 static struct rb_root comm_str_root;
-static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
+static struct mutex comm_str_lock = {.lock = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP,};
 
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
@@ -30,9 +30,9 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 static void comm_str__put(struct comm_str *cs)
 {
 	if (cs && refcount_dec_and_test(&cs->refcnt)) {
-		down_write(&comm_str_lock);
+		mutex_lock(&comm_str_lock);
 		rb_erase(&cs->rb_node, &comm_str_root);
-		up_write(&comm_str_lock);
+		mutex_unlock(&comm_str_lock);
 		zfree(&cs->str);
 		free(cs);
 	}
@@ -98,9 +98,9 @@ static struct comm_str *comm_str__findnew(const char *str, struct rb_root *root)
 {
 	struct comm_str *cs;
 
-	down_write(&comm_str_lock);
+	mutex_lock(&comm_str_lock);
 	cs = __comm_str__findnew(str, root);
-	up_write(&comm_str_lock);
+	mutex_unlock(&comm_str_lock);
 
 	return cs;
 }
-- 
2.42.0.869.gea05f2083d-goog

