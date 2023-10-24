Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA057D5E04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbjJXWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJXWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5B10D1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cafa90160so5745255276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186255; x=1698791055; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NM9dcQFM3UJZ90iyVMmsCAaNS1wz3u9iN52BCuG9Qew=;
        b=meDc3XHpY9ExaB280nqOJ6K12OSUwce6tf+IECrl3phpC11mlm2lK0RtXg1hlcetqQ
         IARFzopmnj2l0M1LYYdylBWVYy8/qq2za77E8GuduEiFUQJyM9cjX9GO45Fiil3YMs6Y
         GY3R2xmNPk5JnsdAhz+XU2mGcSN++OBrYzAvjbRZU5i9w7OSu5mV/7UmwQRYvderROeH
         qFtLHtmi3fAE89TaP/eI9TrrMZosgnEr2XPChozMnTtw2Q2rXVkY0eIs5kE5k/VjROEs
         M4j+fFEFoz23hcJILF8zpJj/P9hNWAXbMOqtnsHCx7dDkufNWU8GmNTqVk1gMtn7S+Q1
         LfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186255; x=1698791055;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM9dcQFM3UJZ90iyVMmsCAaNS1wz3u9iN52BCuG9Qew=;
        b=nqnVu+0weadMj83l6jmG+VzU0F3NLIF+un41zNGbA4a78a/6pnh1c5DBA0D7lIJpnY
         fVJswvGlfXaQUPMwwmc8wvXC1ObSffGttzXXhRfoltekHb0k3HsXAEjbQjyS88T9+/Zr
         GcLNUVuvIb9MlSiT3oAsA+6sgBCyyoyWfZiubjmwA+E4PazPXYMhYm6S7SBf8Wel+PjG
         rZZWYhqxkGUIO0Q+m0JmoFR3DOCsRW4pApBUFHnJR8smhcVSf7a6+0gqjGvw9Egb2JMP
         QVu4oqRqT0uVHvEtnKoWDXejNdvUplPEQg/4NS9boJbKSs9CfFjlIvPoa+yLcdpbPh74
         A6YA==
X-Gm-Message-State: AOJu0Yw+m51ZQmHMjVI5+zkXw93cKuzH1j1ydOYjiQh7Kef27QpD5p/1
        DteBeSVoEfds8KM8iuYvfS5rewQZ9qtw
X-Google-Smtp-Source: AGHT+IF7nlRfsAq1YqcW3CsH70jSGEhchSRGYDNQ7SmWyO76Nk3DNu3kvo4mRn/43YxUo7ddKr0wFqtUs8/z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:d107:0:b0:d9a:50d2:a8ba with SMTP id
 i7-20020a25d107000000b00d9a50d2a8bamr250692ybg.2.1698186255187; Tue, 24 Oct
 2023 15:24:15 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:04 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-2-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 01/50] perf rwsem: Add debug mode that uses a mutex
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

Mutex error check will capture trying to take the lock recursively and
other problems that rwlock won't. At the expense of concurrency, adda
debug mode that uses a mutex in place of a rwsem.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/rwsem.c | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/rwsem.h | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/util/rwsem.c b/tools/perf/util/rwsem.c
index f3d29d8ddc99..5109167f27f7 100644
--- a/tools/perf/util/rwsem.c
+++ b/tools/perf/util/rwsem.c
@@ -2,32 +2,66 @@
 #include "util.h"
 #include "rwsem.h"
 
+#if RWS_ERRORCHECK
+#include "mutex.h"
+#endif
+
 int init_rwsem(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_init(&sem->mtx);
+	return 0;
+#else
 	return pthread_rwlock_init(&sem->lock, NULL);
+#endif
 }
 
 int exit_rwsem(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_destroy(&sem->mtx);
+	return 0;
+#else
 	return pthread_rwlock_destroy(&sem->lock);
+#endif
 }
 
 int down_read(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_lock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_rdlock(&sem->lock);
+#endif
 }
 
 int up_read(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_unlock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+#endif
 }
 
 int down_write(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_lock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_wrlock(&sem->lock);
+#endif
 }
 
 int up_write(struct rw_semaphore *sem)
 {
+#if RWS_ERRORCHECK
+	mutex_unlock(&sem->mtx);
+	return 0;
+#else
 	return perf_singlethreaded ? 0 : pthread_rwlock_unlock(&sem->lock);
+#endif
 }
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index 94565ad4d494..ef5cbc31d967 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -2,9 +2,20 @@
 #define _PERF_RWSEM_H
 
 #include <pthread.h>
+#include "mutex.h"
+
+/*
+ * Mutexes have additional error checking. Enable to use a mutex rather than a
+ * rwlock for debugging.
+ */
+#define RWS_ERRORCHECK 0
 
 struct rw_semaphore {
+#if RWS_ERRORCHECK
+	struct mutex mtx;
+#else
 	pthread_rwlock_t lock;
+#endif
 };
 
 int init_rwsem(struct rw_semaphore *sem);
-- 
2.42.0.758.gaed0368e0e-goog

