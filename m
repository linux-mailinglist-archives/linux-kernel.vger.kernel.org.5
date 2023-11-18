Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B057F0088
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjKRPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKRPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:51:28 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E01BD5C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a87ac9d245so33492817b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322675; x=1700927475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WwK51pC/Flt9q/I+kAw/5yF9gjhLf/hhE3qbzZj538=;
        b=P5YBDmuk3cEzULVFK5ObOumk7DoixChS5whcVIIVaZsTZzQ3E4EkzC6aSus8c3n3iW
         u3M+lr1RiR8YxaIlhF+pdjp6kEjqzfwTLj7lCk1iCCJlZFUEOkls+01wzsGF53Ynr0Fr
         KfMkEbnUWLv+HKS8A/3+dMaWJNNONMb62c/wMq1l7aaQ9HeKc2Joc1pInvQfRwnY8g7M
         xAMfC8BO+2HLwNZe5OXx/RFn3S1qZp2VkmSAqSk/YZ/1kRn3nPplYsC1ppf4VS8Iji01
         L3rBCl5KCh3n9v9WW2uLvpFGjcW9Ymy13ES5tshCsb7jgoGUy3VDx+1tnq8vfnroFXWC
         ftHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322675; x=1700927475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WwK51pC/Flt9q/I+kAw/5yF9gjhLf/hhE3qbzZj538=;
        b=U3GynlV4UiSK6JIBHCnMwX4lbGgB7JuryjUSdbXykE+RjOH8QihYd2ONB2BMwSFC+K
         b2SZj/JDu4KF/xee/+BS/94h59k+pGuonI8/t9sQLxOIqy2Hje6WPuuTl0pOGMWxXE8c
         sIgEmYGPnTFkqA5tj36yB7ba3Sgh99gMMJ6iUsnpAfxkxaWnzqFPL59abjeYTxpwg9DT
         pV83uN+k9JrsnEG1t465O9XCVGyqMjhNmorhpP+pWgtsru0oSw+M5DnDUK+l1swdod49
         gOtg3DQjno1tPTD+uJDUAvDX3LZVsjNuLIfJnIYL09McXgIvRJtU6IWi7ZAc4Jkn3M4B
         SgpQ==
X-Gm-Message-State: AOJu0Yy+rd0/yCexXKsvAKMB1G3T+SGxcpnZB+F/diANtUfgk4ycXMci
        S3PEC9Perq/youdP6i8EnAO9kfiTkjWlhY+6
X-Google-Smtp-Source: AGHT+IHxSEbmknZ0a9HqoeCrPFoIoq/km5XQScyDT5hk8k8EGtLA6Ci9jOkyaNoThiclVwVEbJvlWw==
X-Received: by 2002:a0d:d556:0:b0:59b:c0a8:2882 with SMTP id x83-20020a0dd556000000b0059bc0a82882mr2805662ywd.46.1700322675422;
        Sat, 18 Nov 2023 07:51:15 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id w8-20020a816208000000b00597e912e67esm1183639ywb.131.2023.11.18.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:14 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in __mm_cid_get()
Date:   Sat, 18 Nov 2023 07:50:35 -0800
Message-Id: <20231118155105.25678-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__mm_cid_get() uses a __mm_cid_try_get() helper to atomically acquire a
bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
easily extend it to cpumasks and use in the scheduler code.

__mm_cid_try_get() has an infinite loop, which may delay forward
progress of __mm_cid_get() when the mask is dense. The
cpumask_find_and_set() doesn't poll the mask infinitely, and returns as
soon as nothing has found after the first iteration, allowing to acquire
the lock, and set use_cid_lock faster, if needed.

cpumask_find_and_set() considers cid mask as a volatile region of memory,
as it actually is in this case. So, if it's changed while search is in
progress, KCSAN wouldn't fire warning on it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 12 ++++++++++
 kernel/sched/sched.h    | 52 ++++++++++++-----------------------------
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..c2acced8be4e 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -271,6 +271,18 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 		small_cpumask_bits, n + 1);
 }
 
+/**
+ * cpumask_find_and_set - find the first unset cpu in a cpumask and
+ *			  set it atomically
+ * @srcp: the cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if nothing is found.
+ */
+static inline unsigned int cpumask_find_and_set(volatile struct cpumask *srcp)
+{
+	return find_and_set_bit(cpumask_bits(srcp), small_cpumask_bits);
+}
+
 /**
  * for_each_cpu - iterate over every cpu in a mask
  * @cpu: the (optionally unsigned) integer iterator
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..b2f095a9fc40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3345,28 +3345,6 @@ static inline void mm_cid_put(struct mm_struct *mm)
 	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 }
 
-static inline int __mm_cid_try_get(struct mm_struct *mm)
-{
-	struct cpumask *cpumask;
-	int cid;
-
-	cpumask = mm_cidmask(mm);
-	/*
-	 * Retry finding first zero bit if the mask is temporarily
-	 * filled. This only happens during concurrent remote-clear
-	 * which owns a cid without holding a rq lock.
-	 */
-	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
-			break;
-		cpu_relax();
-	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
-		return -1;
-	return cid;
-}
-
 /*
  * Save a snapshot of the current runqueue time of this cpu
  * with the per-cpu cid value, allowing to estimate how recently it was used.
@@ -3381,25 +3359,25 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
 
 static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 {
+	struct cpumask *cpumask = mm_cidmask(mm);
 	int cid;
 
-	/*
-	 * All allocations (even those using the cid_lock) are lock-free. If
-	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
-	 * guarantee forward progress.
-	 */
+	/* All allocations (even those using the cid_lock) are lock-free. */
 	if (!READ_ONCE(use_cid_lock)) {
-		cid = __mm_cid_try_get(mm);
-		if (cid >= 0)
+		cid = cpumask_find_and_set(cpumask);
+		if (cid < nr_cpu_ids)
 			goto end;
-		raw_spin_lock(&cid_lock);
-	} else {
-		raw_spin_lock(&cid_lock);
-		cid = __mm_cid_try_get(mm);
-		if (cid >= 0)
-			goto unlock;
 	}
 
+	/*
+	 * If use_cid_lock is set, hold the cid_lock to perform cid
+	 * allocation to guarantee forward progress.
+	 */
+	raw_spin_lock(&cid_lock);
+	cid = cpumask_find_and_set(cpumask);
+	if (cid < nr_cpu_ids)
+		goto unlock;
+
 	/*
 	 * cid concurrently allocated. Retry while forcing following
 	 * allocations to use the cid_lock to ensure forward progress.
@@ -3415,9 +3393,9 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * all newcoming allocations observe the use_cid_lock flag set.
 	 */
 	do {
-		cid = __mm_cid_try_get(mm);
+		cid = cpumask_find_and_set(cpumask);
 		cpu_relax();
-	} while (cid < 0);
+	} while (cid >= nr_cpu_ids);
 	/*
 	 * Allocate before clearing use_cid_lock. Only care about
 	 * program order because this is for forward progress.
-- 
2.39.2

