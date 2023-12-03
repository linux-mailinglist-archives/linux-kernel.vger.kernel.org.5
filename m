Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F68026CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjLCTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjLCTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:11 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E3A2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:33:17 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d7692542beso9711157b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701631996; x=1702236796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hNYZVU7jLhcSO3fDn6RLV78h3tjyqIxI1rGMMvt+Xw=;
        b=R50KqwY5TO0LZ36Fq57lmyzgUOLMoDSX0jVucDwZtjXE2w5ZmaZM8Qm5iRzHQlGZAO
         POirBDqEiuv5VLDbr8aup4FTDi9g043S6Vff4em6IpeJR6/ahiiPc003CaUUw2z7GWeb
         acjUP1nl1WvMD13kZfhxBek74RkUsFt4Kcx97ERlieis6rWZkAi03hCS4+hIuaTplK7G
         RiCJfmSMchy430qOWTSJnBpvGE3TLLycE837H1uuzykLbSOxqsLaJyCQ2ueEhE9hTVw6
         VrRzlSJpiHcd5ktxlerX9jQyrDMc2LuamG91uuoMTN8BV+yb6gGEEO8iU4M4XQH8iHPp
         K+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701631996; x=1702236796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hNYZVU7jLhcSO3fDn6RLV78h3tjyqIxI1rGMMvt+Xw=;
        b=f3ycnLsSu396dsKhX+USvF3uWBzVxEhKyhjiXDq8PN4CNwgQnRfgc3iMCLxFylvec9
         H66TVt1OMv8Sgq8lA+anCO6O4+OewfpTxs/W+cD0xF5f3rSxztyU8KHRzvcEAPZjQRSr
         NycHCq+AdZ83SLwFGe38rHU7hiQSwcimVhY8Lvweld+qJ9Kgi3PV9V+aKad4bEbdI4Xm
         HryyRN3Q3Pkka0yfTFeEjxdgn7uh9gv6j60iK7BUV8PI65fmrth+ppKWWFEojh8t+8VX
         zCz0f+9kk40JMSSvi5kfPWQdnPj7vtZdt+qKxuf6JRNu45htuCuEIkiFTEV4TBR38zNt
         VgEg==
X-Gm-Message-State: AOJu0Yy8sZeaP3tDjfwIl4u8zpE2qacDGBE8qdPYJj5nggj9qKtc7xjo
        S6lXgV79blbEmL5R//+QU8KKY/LMLYxvPQ==
X-Google-Smtp-Source: AGHT+IFcTxgrIc2y2DpejCAFp4wRSfM5aHe2grEgeOILemylOrgZPzfSgXbvJPXoPFzVc+vzoRZfEw==
X-Received: by 2002:a81:d208:0:b0:5d7:1940:53e6 with SMTP id x8-20020a81d208000000b005d7194053e6mr1938192ywi.94.1701631996140;
        Sun, 03 Dec 2023 11:33:16 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id o188-20020a8173c5000000b005d647048e54sm1875513ywc.111.2023.12.03.11.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:15 -0800 (PST)
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
Subject: [PATCH v2 05/35] sched: add cpumask_find_and_set() and use it in __mm_cid_get()
Date:   Sun,  3 Dec 2023 11:32:37 -0800
Message-Id: <20231203193307.542794-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

