Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB280E052
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbjLLAcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjLLAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:56 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6CB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:32:01 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b70139d54cso172239139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341121; x=1702945921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w/uO62RCM4lgIOFIJSX/lpUSqBhcJ+S2LdMTwfnN3k=;
        b=DqajHofp4GA+X471DNBObNwVjGRJSdWSJu0rm2VmQLmSV0KQCp0fkbCrVWL+9eM8vv
         QC545sHxEAc8ajvuLRa1UVI1V95WISF3QuHVN/k85fZRdURdNJSW5J+mnTn9DhewfyU7
         Xl0TEvGzob7L+Cz2jDvGiQQddHIXkDNsFvpfJsifPAE5GudcVyFsqjx/zqZKD6Uw11dQ
         C3nCltu2UcTOgK7quGZLpagUtoG0ZBd7Pyu+83HSCo9dvVJ1wqgHgFfB/rT3LdFUKYLW
         S0d48vG2nSrX+lFLvBJUFNpHicksUeuzYAefcVV3VJrg3OVC/6VO4I0aDa243N4//JDn
         7F7g==
X-Gm-Message-State: AOJu0YyPF4762vXXRlZobgzXHtwDcxdN+Ky5yy3FLYBC6kpbR7n4cqpc
        cRdtEJKwpOgUR3+bjujszjT8UWyeCKldn5oa
X-Google-Smtp-Source: AGHT+IExaJLrIz+75Eul+AyLSVFH0+Rrj4tbrsNJ8GP8Awbknnf2wojDgcPUgKk6tO2e0hAd709nMA==
X-Received: by 2002:a05:6e02:154b:b0:35d:6984:c3a with SMTP id j11-20020a056e02154b00b0035d69840c3amr4359210ilu.32.1702341120831;
        Mon, 11 Dec 2023 16:32:00 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id bq10-20020a056e02238a00b0035d4633cf5dsm2645674ilb.61.2023.12.11.16.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:32:00 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 8/8] sched: Add selftest for SHARED_RUNQ
Date:   Mon, 11 Dec 2023 18:31:41 -0600
Message-ID: <20231212003141.216236-9-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to ensure that SHARED_RUNQ works as expected. Let's add a
testcase to the sched/ subdirectory containing SHARED_RUNQ which enables
and disables it in a loop, while stressing the system with rcutorture.

Cc: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/sched/Makefile    |  5 ++++-
 tools/testing/selftests/sched/config      |  2 ++
 tools/testing/selftests/sched/test-swq.sh | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/sched/test-swq.sh

diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..22f4941ff76b 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -9,6 +9,9 @@ CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
 LDLIBS += -lpthread
 
 TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+TEST_PROGS := \
+	cs_prctl_test \
+	test-srq.sh
+
 
 include ../lib.mk
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
index e8b09aa7c0c4..6e1cbdb6eec3 100644
--- a/tools/testing/selftests/sched/config
+++ b/tools/testing/selftests/sched/config
@@ -1 +1,3 @@
 CONFIG_SCHED_DEBUG=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_RCU_TORTURE_TEST=m
diff --git a/tools/testing/selftests/sched/test-swq.sh b/tools/testing/selftests/sched/test-swq.sh
new file mode 100755
index 000000000000..547088840a6c
--- /dev/null
+++ b/tools/testing/selftests/sched/test-swq.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 Meta, Inc
+
+echo "TEST: SHARED_RUNQ stress test ..."
+
+modprobe rcutorture
+
+for i in {1..10}; do
+	echo "Beginning iteration $i"
+	echo "SHARED_RUNQ" > /sys/kernel/debug/sched/features
+	sleep 2.3
+	echo "NO_SHARED_RUNQ" > /sys/kernel/debug/sched/features
+	sleep .8
+	echo "Completed iteration $i"
+	echo ""
+done
+
+rmmod rcutorture
+
+echo "DONE: SHARED_RUNQ stress test completed"
+
+exit 0
-- 
2.42.1

