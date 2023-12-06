Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708C2806722
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377039AbjLFGHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376905AbjLFGGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:06:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090110C2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5be30d543c4so2863400a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842798; x=1702447598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fxgjHIY+i+wILRYpSYSEatYEwrJqDdx6PzPhkDcv2Y=;
        b=OkeXp78tTzQtRq/qF05WM5DAndaCDB8vhHKZDY0XNgg5ts5hL63JNgkkGzvDYoU598
         +3f3XDOyYR3xtGk2x8Uo9q8hEk0xSVZ2RCpPCylqNbpaWV8x0C/MKx2BNOhTx8Defkzu
         LBxuKcz2ucwJ8N39FMlxiLJCGjqx4V0EcqQ6VFLWFKJFodaUUU0ay9THUBRWyAtcXz3D
         /nWPrTWAxSQByn9g2DU/P7+3BATGMUXWDrnetwZcEVSIcnFH3B0EyBNJefdx4snPcBzo
         u2z3AOvWP5I9NzS1qDxExZIevQB2Td+6o8sYj0OGzaBpOgeCI4Zm8q+H1HFahj4TTHne
         0Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842798; x=1702447598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fxgjHIY+i+wILRYpSYSEatYEwrJqDdx6PzPhkDcv2Y=;
        b=En7l3HSrFkRSXDLsMlYchf1QITj6jWxkRYOpkhIInRaeviPBq398DggNEpMj2VdgEQ
         xnr286wBdm2hMlsUQxYYDG3cbk7zJtiDtjDzVjd/0NqqHjN3h5iwKp9CGk93r8q3dT2g
         l/GwqZ08Umpf+ovhqm7Lq7EKRsWGWoX9RspGzGqmE3p/hjGLNK59DcS30Efl+8L+pEwm
         18y3fY22HtdQJfahwDiQnI0e2yIodahGKOs4/Tx3ox/icYTeFGl49PDgtk1de/2s0du+
         wPMZDqdae/d65tKEBMDCeqGwFRageCLXB4Ip4TfY3FC8L/24CKRwfqDhwW3dqgR29pY4
         HU0A==
X-Gm-Message-State: AOJu0YxNgToX6Q+sgYi1AC8OpyF3ws5HNnDrnaEe8zN0UgydmcKXEA2g
        Cs63s/A+Lt2pPCmACxipjeWHoA==
X-Google-Smtp-Source: AGHT+IFaRusOCnlTqKyhQX2TmiINjReQS73wsX4XhW7l8zr6yWbnE5nsO3OQlJ5zjUwEdtZUgvxNGw==
X-Received: by 2002:a05:6a20:a426:b0:18f:97c:823e with SMTP id z38-20020a056a20a42600b0018f097c823emr186921pzk.72.1701842797795;
        Tue, 05 Dec 2023 22:06:37 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a08cd00b002868f5c2847sm2240355pjn.7.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:34 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.96)
        (envelope-from <dave@fromorbit.com>)
        id 1rAl3H-004VOm-3D;
        Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
        (envelope-from <dave@devoid.disaster.area>)
        id 1rAl3H-0000000BrVG-2K9L;
        Wed, 06 Dec 2023 17:06:31 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-cachefs@redhat.com,
        dhowells@redhat.com, gfs2@lists.linux.dev,
        dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] lib/dlock-list: Make sibling CPUs share the same linked list
Date:   Wed,  6 Dec 2023 17:05:33 +1100
Message-ID: <20231206060629.2827226-5-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

The dlock list needs one list for each of the CPUs available. However,
for sibling CPUs, they are sharing the L2 and probably L1 caches
too. As a result, there is not much to gain in term of avoiding
cacheline contention while increasing the cacheline footprint of the
L1/L2 caches as separate lists may need to be in the cache.

This patch makes all the sibling CPUs share the same list, thus
reducing the number of lists that need to be maintained in each
dlock list without having any noticeable impact on performance. It
also improves dlock list iteration performance as fewer lists need
to be iterated.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 lib/dlock-list.c | 74 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/lib/dlock-list.c b/lib/dlock-list.c
index f64ea4cc5e79..e2860944ec9f 100644
--- a/lib/dlock-list.c
+++ b/lib/dlock-list.c
@@ -25,31 +25,65 @@
  * The distributed and locked list is a distributed set of lists each of
  * which is protected by its own spinlock, but acts like a single
  * consolidated list to the callers. For scaling purpose, the number of
- * lists used is equal to the number of possible CPUs in the system to
- * minimize contention.
+ * lists used is equal to the number of possible cores in the system to
+ * minimize contention. All threads of the same CPU core will share the
+ * same list.
  *
- * However, it is possible that individual CPU numbers may be equal to
- * or greater than the number of possible CPUs when there are holes in
- * the CPU number list. As a result, we need to map the CPU number to a
- * list index.
+ * We need to map each CPU number to a list index.
  */
 static DEFINE_PER_CPU_READ_MOSTLY(int, cpu2idx);
+static int nr_dlock_lists __read_mostly;
 
 /*
- * Initialize cpu2idx mapping table
+ * Initialize cpu2idx mapping table & nr_dlock_lists.
  *
  * It is possible that a dlock-list can be allocated before the cpu2idx is
  * initialized. In this case, all the cpus are mapped to the first entry
  * before initialization.
  *
+ * All the sibling CPUs of a sibling group will map to the same dlock list so
+ * as to reduce the number of dlock lists to be maintained while minimizing
+ * cacheline contention.
+ *
+ * As the sibling masks are set up in the core initcall phase, this function
+ * has to be done in the postcore phase to get the right data.
  */
 static int __init cpu2idx_init(void)
 {
 	int idx, cpu;
+	struct cpumask *sibling_mask;
+	static struct cpumask mask __initdata;
 
+	cpumask_clear(&mask);
 	idx = 0;
-	for_each_possible_cpu(cpu)
-		per_cpu(cpu2idx, cpu) = idx++;
+	for_each_possible_cpu(cpu) {
+		int scpu;
+
+		if (cpumask_test_cpu(cpu, &mask))
+			continue;
+		per_cpu(cpu2idx, cpu) = idx;
+		cpumask_set_cpu(cpu, &mask);
+
+		sibling_mask = topology_sibling_cpumask(cpu);
+		if (sibling_mask) {
+			for_each_cpu(scpu, sibling_mask) {
+				per_cpu(cpu2idx, scpu) = idx;
+				cpumask_set_cpu(scpu, &mask);
+			}
+		}
+		idx++;
+	}
+
+	/*
+	 * nr_dlock_lists can only be set after cpu2idx is properly
+	 * initialized.
+	 */
+	smp_mb();
+	nr_dlock_lists = idx;
+	WARN_ON(nr_dlock_lists > nr_cpu_ids);
+
+	pr_info("dlock-list: %d head entries per dlock list.\n",
+		nr_dlock_lists);
 	return 0;
 }
 postcore_initcall(cpu2idx_init);
@@ -67,19 +101,23 @@ postcore_initcall(cpu2idx_init);
  *
  * Dynamically allocated locks need to have their own special lock class
  * to avoid lockdep warning.
+ *
+ * Since nr_dlock_lists will always be <= nr_cpu_ids, having more lists
+ * than necessary allocated is not a problem other than some wasted memory.
+ * The extra lists will not be ever used as all the cpu2idx entries will be
+ * 0 before initialization.
  */
 int __alloc_dlock_list_heads(struct dlock_list_heads *dlist,
 			     struct lock_class_key *key)
 {
-	int idx;
+	int idx, cnt = nr_dlock_lists ? nr_dlock_lists : nr_cpu_ids;
 
-	dlist->heads = kcalloc(nr_cpu_ids, sizeof(struct dlock_list_head),
-			       GFP_KERNEL);
+	dlist->heads = kcalloc(cnt, sizeof(struct dlock_list_head), GFP_KERNEL);
 
 	if (!dlist->heads)
 		return -ENOMEM;
 
-	for (idx = 0; idx < nr_cpu_ids; idx++) {
+	for (idx = 0; idx < cnt; idx++) {
 		struct dlock_list_head *head = &dlist->heads[idx];
 
 		INIT_LIST_HEAD(&head->list);
@@ -117,7 +155,10 @@ bool dlock_lists_empty(struct dlock_list_heads *dlist)
 {
 	int idx;
 
-	for (idx = 0; idx < nr_cpu_ids; idx++)
+	/* Shouldn't be called before nr_dlock_lists is initialized */
+	WARN_ON_ONCE(!nr_dlock_lists);
+
+	for (idx = 0; idx < nr_dlock_lists; idx++)
 		if (!list_empty(&dlist->heads[idx].list))
 			return false;
 	return true;
@@ -199,6 +240,9 @@ struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
 	struct dlock_list_node *next;
 	struct dlock_list_head *head;
 
+	/* Shouldn't be called before nr_dlock_lists is initialized */
+	WARN_ON_ONCE(!nr_dlock_lists);
+
 restart:
 	if (iter->entry) {
 		spin_unlock(&iter->entry->lock);
@@ -209,7 +253,7 @@ struct dlock_list_node *__dlock_list_next_list(struct dlock_list_iter *iter)
 	/*
 	 * Try next list
 	 */
-	if (++iter->index >= nr_cpu_ids)
+	if (++iter->index >= nr_dlock_lists)
 		return NULL;	/* All the entries iterated */
 
 	if (list_empty(&iter->head[iter->index].list))
-- 
2.42.0

