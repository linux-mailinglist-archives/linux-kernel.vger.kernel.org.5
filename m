Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36437FACFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjK0WJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjK0WJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:09:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4803EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:23 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cdde93973aso57444107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122963; x=1701727763; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbPv4PyEdmBWH7WUrzt8/XaXbmHzexj4Rz5EFZB1OQM=;
        b=Km0rF0ZHW0TaTKx+npA8OJvPAtKyQKPO0A8M2mJ/DBBM41qhFvDyHLcEZxTP3w4vaS
         NwknOG+NnF1RF1aat0v7kfg2YfEpZn+q9ULMB4TONRjsECUCb8RdWk1SvrJjGGC2h3t7
         jNmmImB82KKjBgexV9sN64hmZU85VFmA8SO5GNZnXKxbfsPcmnLVdZb79Y4U7X07Cyii
         R7R8wv9Pw/BsiSbhDOc/CmjIe/9diA7ZDgl/UMgusk9oDsMg4f0bEDNDf0wbhQfVLMY0
         3uB5/YY3q1N5VdPdRG8gkqZV9iYZISz2aC1K7m9MJ0dNfvGx3N/4CqwWyc3ocgAzmdG/
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122963; x=1701727763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbPv4PyEdmBWH7WUrzt8/XaXbmHzexj4Rz5EFZB1OQM=;
        b=mKkISyRUplI6hENVjh9oDr3NTZkMhn6KSfQqUtu716Stu6qGcBDqTHptAQ+6LxYFyj
         MkIO0NPIYU7jTpEfsgwC1fOxZRSri2obp2i0ee8PkORKe2X866tsRTy7x5Op6TORZP1z
         mYTPwfE6E5rlzRzEvsV4KGyuHwxuEx/0KvDNSebyk3PLgxwWB7OUAW2xcUXef3R/yV7y
         YPsj7RrdT/ySlUzfpNvsgCP+hrXGS66qOOVhqghk1YpP/NyA8BPZpCkQmuIGhah6G/ua
         ug2UEhBl50Krh9ewTL33N2YIRuwCCDZR3GWxy0UYnnS3sUegCAnau2QAi0oBK19Oyai/
         Dvuw==
X-Gm-Message-State: AOJu0Ywn9kk4G8iqDGL4Kwz7QDQTlE1/QsrThJ/PYy7kYYW6fJCe2yUn
        BHwX8PFPot5kifgIBP2NzA00/XpbMXLG
X-Google-Smtp-Source: AGHT+IExUtMtiR+ptGG23+Vabnoaqo7AIZnyIS3yKYDbfx4Y1r3PAu2qXUtV6Z+us//6QncipclrfVxBHfi9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:d081:0:b0:d9a:c946:c18c with SMTP id
 h123-20020a25d081000000b00d9ac946c18cmr452645ybg.6.1701122962825; Mon, 27 Nov
 2023 14:09:22 -0800 (PST)
Date:   Mon, 27 Nov 2023 14:08:13 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-2-irogers@google.com>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 01/50] perf comm: Use regular mutex
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
2.43.0.rc1.413.gea7ed67945-goog

