Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF980E180
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjLLC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjLLC16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:27:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A5E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:04 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so4444880276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348082; x=1702952882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hNYZVU7jLhcSO3fDn6RLV78h3tjyqIxI1rGMMvt+Xw=;
        b=ePKsM/tGAdK3gvUukaOmwZsSstedhRTMlsF/UrjOvRBtMV62WUNdKpo/FLEzaCa41q
         GAPc0A75QBrHCxae/KIms1ARldugkQtk/k/0BrqFDgZe3R9/oIiZlaWztZkDYm+tjVcm
         Rw1ixVTOspUWMFG2p5lMUNloVo56pYj4VuzXBKGUTTafxYXC9xb8y5b8Q15OA9xHmvf0
         fn9yjbuZzXegPepAUn8AVPsYqS4pglU6ot/eeC28azcNgpbPP58qDmR9O1UFbIxxuX7i
         D0+LGAamINdYzJxTMErjGsabAx/qVU0JpMWqBn9KulHEdjwfNGfHe34tqV6bvaeEcTIr
         q7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348082; x=1702952882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hNYZVU7jLhcSO3fDn6RLV78h3tjyqIxI1rGMMvt+Xw=;
        b=RRBIF3zmp8WO5xcRfGulu03H2zCjOQw6km40KMTpn5e+vsiFbNz7R/jN5lEg8E6Zac
         XPtpGJW2JZhckczvqeFGW24tBHFVutn+c5rBMZlf/DWIGV5m3BMMwXgYXijQXaMUwfDo
         8rz0C7y6ZycDdnCAGQlB0O68g3BI4GJaw+dKnWfBcq6VmIXSPE74yhpdegav2lfENlVI
         Na9n3ctKxPk2OgPTjE8ih9h9A96Vamyd+7FyHnvkU9Vq/5dVBWq4N5qdohxSIH2ad0Xc
         JmOlq/eN8v1esPEsEqHk3HpjciHyzmmPPJRCJymYnPY54Q3TnU141GQJum2KXXZYkT5o
         j43w==
X-Gm-Message-State: AOJu0YxJrOXr2U/jpKbarRNDO8ySbCdH7r2U7bfBD99euP9xMF4pTnKc
        u9Ex2ItyzuyXNxUR6yp00gwb+PPNaCyy5A==
X-Google-Smtp-Source: AGHT+IHpnmBIysjq8dCqG0Y1AQ3qKQF2uEeHPQ03tDKG/KcgdOCZgUorxUvjF04i/Yukj2uNh9iz2g==
X-Received: by 2002:a25:ef4b:0:b0:dbc:b118:588 with SMTP id w11-20020a25ef4b000000b00dbcb1180588mr980369ybm.11.1702348082171;
        Mon, 11 Dec 2023 18:28:02 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id h3-20020a259743000000b00db41482d349sm2868926ybo.57.2023.12.11.18.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:01 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 05/35] sched: add cpumask_find_and_set() and use it in __mm_cid_get()
Date:   Mon, 11 Dec 2023 18:27:19 -0800
Message-Id: <20231212022749.625238-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

__mm_cid_get() uses __mm_cid_try_get() helper to atomically acquire a
bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
easily extend it to cpumasks and use in the scheduler code.

cpumask_find_and_set() considers cid mask as a volatile region of memory,
as it actually is in this case. So, if it's changed while search is in
progress, KCSAN wouldn't fire warning on it.

CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 12 ++++++++++++
 kernel/sched/sched.h    | 14 +++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

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
index 2e5a95486a42..2ce9112de89b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3347,23 +3347,19 @@ static inline void mm_cid_put(struct mm_struct *mm)
 
 static inline int __mm_cid_try_get(struct mm_struct *mm)
 {
-	struct cpumask *cpumask;
-	int cid;
+	struct cpumask *cpumask = mm_cidmask(mm);
+	int cid = nr_cpu_ids;
 
-	cpumask = mm_cidmask(mm);
 	/*
 	 * Retry finding first zero bit if the mask is temporarily
 	 * filled. This only happens during concurrent remote-clear
 	 * which owns a cid without holding a rq lock.
 	 */
-	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
-			break;
+	while (cid >= nr_cpu_ids) {
+		cid = cpumask_find_and_set(cpumask);
 		cpu_relax();
 	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
-		return -1;
+
 	return cid;
 }
 
-- 
2.40.1

