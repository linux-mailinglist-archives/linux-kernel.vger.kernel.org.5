Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E77BCDDE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjJHKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbjJHKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:49:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01BAC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:49:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c49f781855so2420846a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696762186; x=1697366986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c85eUG/PLq9rCFsCeX71oCXsLkAVXY0eAv8YSU0JAXU=;
        b=JLiXfvYzXrRkjWdy2KKgAIwOxqXCoSqFw/Rw+W8ujFyn57unpQuxwDclDAbIJ4x8nV
         gWeg6sQr7oE+fEa1WFPIdlaHZZovME2weOFoJ4bbeB87mTRuvaFrSMskOg+zpXILrkWE
         Euhggwx3yj/FC98qStE+xP+o0ICPItCn+iCORj8Rrfm3tRvrvc5y/8VtWlMHO0IWNxpf
         wnn4L7vv0Sj6abCf1Qsf/IegAdVrXqw5x4g8/uMI82TCol0cihsZi+fm9A7Xq8JaF+om
         lrwJaByXv/Gby8vPd++D1ruEMgyCe/DG0FUsHIqNGzk9QrPEnMn39xKwxt4cTTK0qAsd
         M3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696762186; x=1697366986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c85eUG/PLq9rCFsCeX71oCXsLkAVXY0eAv8YSU0JAXU=;
        b=dgaLMZr+GMSpa35ijIL0pdfWY2yLPkoFo3ooNIVsBTa4EhdHCQaiI3FGdUQeE9vxSA
         AwukDl8YFmTsOpJnoGgI981vMCvHKW7tuJHCs52BAP+K6RY6r7gmkSXN11Z8sA9jFDgM
         w6Ghl7vYhu75rVgDpc+gnfzAt7h8ErTCatwWaFh/b607TwnkHxSh/BV1ToIKlUAW2YEs
         ZyzrPGYOyHTVTB77gVJpwx38KTBYzPAfzFUmXpKjT3guK5/5nfWJUo2IG7rWzgDGdeCY
         xw2/ZKmBpEJUjHGZ7sSmzHdt1AAXUH+k/3Ebwli7WJ/k0yaVh1vRR+t7/CVyIViM/qn3
         oTpA==
X-Gm-Message-State: AOJu0YyG1/pRvC+UAyl5h7R1DHuG/JwKb+jDIl00v/CYIBF3o79CV6c8
        tOOMDuadi6vroa5J2eDsoaM=
X-Google-Smtp-Source: AGHT+IHVd5jBQ9WpOaV/jFPASDBM3v5OQWNToMhm5YONtcRz/QCme3u3oe2TEqh/4amnCbs8IM6JRg==
X-Received: by 2002:a05:6358:6f06:b0:13c:eea2:d021 with SMTP id r6-20020a0563586f0600b0013ceea2d021mr12274061rwn.9.1696762185748;
        Sun, 08 Oct 2023 03:49:45 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090acb0b00b002630c9d78aasm6311517pjt.5.2023.10.08.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:49:45 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     bsingharora@gmail.com, juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] delayacct: convert task->delays to a object
Date:   Sun,  8 Oct 2023 18:49:37 +0800
Message-Id: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1696761522.git.chunguang.xu@shopee.com>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <chunguang.xu@shopee.com>

Since in some scenarios we still want to get the task delayacct
through taskstats, so commit <0cd7c741f01de> introduces a sysctl to
enable it dynamically. However, since task->delays is allocated
during fork(), task->delays will not be reallocated when delayacct
is enabled later. This will make we cannot get the delayacct of old
tasks, but the new tasks cans. This can easily lead to confusion.
Therefore, try to workaround this issue by convert task->delays to
an object.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 include/linux/delayacct.h |  16 +-----
 include/linux/sched.h     |   3 +-
 kernel/delayacct.c        | 113 +++++++++++++++++++-------------------
 kernel/fork.c             |   7 +--
 4 files changed, 60 insertions(+), 79 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 660e534ce7c4..2f1dc6688a2f 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -65,7 +65,6 @@ struct task_delay_info {
 #ifdef CONFIG_TASK_DELAY_ACCT
 DECLARE_STATIC_KEY_FALSE(delayacct_key);
 extern int delayacct_on;	/* Delay accounting turned on/off */
-extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
 
 extern void __delayacct_tsk_init(struct task_struct *);
@@ -88,10 +87,7 @@ extern void __delayacct_irq(struct task_struct *task, u32 delta);
 
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
-	/* reinitialize in case parent's non-null pointer was dup'ed*/
-	tsk->delays = NULL;
-	if (delayacct_on)
-		__delayacct_tsk_init(tsk);
+	__delayacct_tsk_init(tsk);
 }
 
 static inline bool delayacct_enabled(void)
@@ -99,16 +95,6 @@ static inline bool delayacct_enabled(void)
 	return static_branch_unlikely(&delayacct_key);
 }
 
-/* Free tsk->delays. Called from bad fork and __put_task_struct
- * where there's no risk of tsk->delays being accessed elsewhere
- */
-static inline void delayacct_tsk_free(struct task_struct *tsk)
-{
-	if (delayacct_enabled())
-		kmem_cache_free(delayacct_cache, tsk->delays);
-	tsk->delays = NULL;
-}
-
 static inline void delayacct_blkio_start(void)
 {
 	if (delayacct_enabled())
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..5cc78184a31f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -37,6 +37,7 @@
 #include <linux/kcsan.h>
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
+#include <linux/delayacct.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1331,7 +1332,7 @@ struct task_struct {
 	struct page_frag		task_frag;
 
 #ifdef CONFIG_TASK_DELAY_ACCT
-	struct task_delay_info		*delays;
+	struct task_delay_info		delays;
 #endif
 
 #ifdef CONFIG_FAULT_INJECTION
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index ce10b7c1ee43..1a6b1d3e80af 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -16,7 +16,6 @@
 
 DEFINE_STATIC_KEY_FALSE(delayacct_key);
 int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
-struct kmem_cache *delayacct_cache;
 
 static void set_delayacct(bool enabled)
 {
@@ -38,7 +37,6 @@ __setup("delayacct", delayacct_setup_enable);
 
 void delayacct_init(void)
 {
-	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
 	delayacct_tsk_init(&init_task);
 	set_delayacct(delayacct_on);
 }
@@ -87,9 +85,8 @@ late_initcall(kernel_delayacct_sysctls_init);
 
 void __delayacct_tsk_init(struct task_struct *tsk)
 {
-	tsk->delays = kmem_cache_zalloc(delayacct_cache, GFP_KERNEL);
-	if (tsk->delays)
-		raw_spin_lock_init(&tsk->delays->lock);
+	memset(&tsk->delays, 0, sizeof(struct task_delay_info));
+	raw_spin_lock_init(&tsk->delays.lock);
 }
 
 /*
@@ -111,7 +108,7 @@ static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total, u32 *cou
 
 void __delayacct_blkio_start(void)
 {
-	current->delays->blkio_start = local_clock();
+	current->delays.blkio_start = local_clock();
 }
 
 /*
@@ -120,10 +117,10 @@ void __delayacct_blkio_start(void)
  */
 void __delayacct_blkio_end(struct task_struct *p)
 {
-	delayacct_end(&p->delays->lock,
-		      &p->delays->blkio_start,
-		      &p->delays->blkio_delay,
-		      &p->delays->blkio_count);
+	delayacct_end(&p->delays.lock,
+		      &p->delays.blkio_start,
+		      &p->delays.blkio_delay,
+		      &p->delays.blkio_count);
 }
 
 int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
@@ -166,29 +163,29 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
-	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	raw_spin_lock_irqsave(&tsk->delays.lock, flags);
+	tmp = d->blkio_delay_total + tsk->delays.blkio_delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
-	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	tmp = d->swapin_delay_total + tsk->delays.swapin_delay;
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
-	tmp = d->freepages_delay_total + tsk->delays->freepages_delay;
+	tmp = d->freepages_delay_total + tsk->delays.freepages_delay;
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
-	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
+	tmp = d->thrashing_delay_total + tsk->delays.thrashing_delay;
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
-	tmp = d->compact_delay_total + tsk->delays->compact_delay;
+	tmp = d->compact_delay_total + tsk->delays.compact_delay;
 	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
-	tmp = d->wpcopy_delay_total + tsk->delays->wpcopy_delay;
+	tmp = d->wpcopy_delay_total + tsk->delays.wpcopy_delay;
 	d->wpcopy_delay_total = (tmp < d->wpcopy_delay_total) ? 0 : tmp;
-	tmp = d->irq_delay_total + tsk->delays->irq_delay;
+	tmp = d->irq_delay_total + tsk->delays.irq_delay;
 	d->irq_delay_total = (tmp < d->irq_delay_total) ? 0 : tmp;
-	d->blkio_count += tsk->delays->blkio_count;
-	d->swapin_count += tsk->delays->swapin_count;
-	d->freepages_count += tsk->delays->freepages_count;
-	d->thrashing_count += tsk->delays->thrashing_count;
-	d->compact_count += tsk->delays->compact_count;
-	d->wpcopy_count += tsk->delays->wpcopy_count;
-	d->irq_count += tsk->delays->irq_count;
-	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	d->blkio_count += tsk->delays.blkio_count;
+	d->swapin_count += tsk->delays.swapin_count;
+	d->freepages_count += tsk->delays.freepages_count;
+	d->thrashing_count += tsk->delays.thrashing_count;
+	d->compact_count += tsk->delays.compact_count;
+	d->wpcopy_count += tsk->delays.wpcopy_count;
+	d->irq_count += tsk->delays.irq_count;
+	raw_spin_unlock_irqrestore(&tsk->delays.lock, flags);
 
 	return 0;
 }
@@ -198,23 +195,23 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	__u64 ret;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	ret = nsec_to_clock_t(tsk->delays->blkio_delay);
-	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays.lock, flags);
+	ret = nsec_to_clock_t(tsk->delays.blkio_delay);
+	raw_spin_unlock_irqrestore(&tsk->delays.lock, flags);
 	return ret;
 }
 
 void __delayacct_freepages_start(void)
 {
-	current->delays->freepages_start = local_clock();
+	current->delays.freepages_start = local_clock();
 }
 
 void __delayacct_freepages_end(void)
 {
-	delayacct_end(&current->delays->lock,
-		      &current->delays->freepages_start,
-		      &current->delays->freepages_delay,
-		      &current->delays->freepages_count);
+	delayacct_end(&current->delays.lock,
+		      &current->delays.freepages_start,
+		      &current->delays.freepages_delay,
+		      &current->delays.freepages_count);
 }
 
 void __delayacct_thrashing_start(bool *in_thrashing)
@@ -224,7 +221,7 @@ void __delayacct_thrashing_start(bool *in_thrashing)
 		return;
 
 	current->in_thrashing = 1;
-	current->delays->thrashing_start = local_clock();
+	current->delays.thrashing_start = local_clock();
 }
 
 void __delayacct_thrashing_end(bool *in_thrashing)
@@ -233,58 +230,58 @@ void __delayacct_thrashing_end(bool *in_thrashing)
 		return;
 
 	current->in_thrashing = 0;
-	delayacct_end(&current->delays->lock,
-		      &current->delays->thrashing_start,
-		      &current->delays->thrashing_delay,
-		      &current->delays->thrashing_count);
+	delayacct_end(&current->delays.lock,
+		      &current->delays.thrashing_start,
+		      &current->delays.thrashing_delay,
+		      &current->delays.thrashing_count);
 }
 
 void __delayacct_swapin_start(void)
 {
-	current->delays->swapin_start = local_clock();
+	current->delays.swapin_start = local_clock();
 }
 
 void __delayacct_swapin_end(void)
 {
-	delayacct_end(&current->delays->lock,
-		      &current->delays->swapin_start,
-		      &current->delays->swapin_delay,
-		      &current->delays->swapin_count);
+	delayacct_end(&current->delays.lock,
+		      &current->delays.swapin_start,
+		      &current->delays.swapin_delay,
+		      &current->delays.swapin_count);
 }
 
 void __delayacct_compact_start(void)
 {
-	current->delays->compact_start = local_clock();
+	current->delays.compact_start = local_clock();
 }
 
 void __delayacct_compact_end(void)
 {
-	delayacct_end(&current->delays->lock,
-		      &current->delays->compact_start,
-		      &current->delays->compact_delay,
-		      &current->delays->compact_count);
+	delayacct_end(&current->delays.lock,
+		      &current->delays.compact_start,
+		      &current->delays.compact_delay,
+		      &current->delays.compact_count);
 }
 
 void __delayacct_wpcopy_start(void)
 {
-	current->delays->wpcopy_start = local_clock();
+	current->delays.wpcopy_start = local_clock();
 }
 
 void __delayacct_wpcopy_end(void)
 {
-	delayacct_end(&current->delays->lock,
-		      &current->delays->wpcopy_start,
-		      &current->delays->wpcopy_delay,
-		      &current->delays->wpcopy_count);
+	delayacct_end(&current->delays.lock,
+		      &current->delays.wpcopy_start,
+		      &current->delays.wpcopy_delay,
+		      &current->delays.wpcopy_count);
 }
 
 void __delayacct_irq(struct task_struct *task, u32 delta)
 {
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&task->delays->lock, flags);
-	task->delays->irq_delay += delta;
-	task->delays->irq_count++;
-	raw_spin_unlock_irqrestore(&task->delays->lock, flags);
+	raw_spin_lock_irqsave(&task->delays.lock, flags);
+	task->delays.irq_delay += delta;
+	task->delays.irq_count++;
+	raw_spin_unlock_irqrestore(&task->delays.lock, flags);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..6f47989e3885 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -975,7 +975,6 @@ void __put_task_struct(struct task_struct *tsk)
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
 	exit_creds(tsk);
-	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
 	sched_core_free(tsk);
 	free_task(tsk);
@@ -2426,14 +2425,14 @@ __latent_entropy struct task_struct *copy_process(
 	cgroup_fork(p);
 	if (args->kthread) {
 		if (!set_kthread_struct(p))
-			goto bad_fork_cleanup_delayacct;
+			goto bad_fork_cleanup_count;
 	}
 #ifdef CONFIG_NUMA
 	p->mempolicy = mpol_dup(p->mempolicy);
 	if (IS_ERR(p->mempolicy)) {
 		retval = PTR_ERR(p->mempolicy);
 		p->mempolicy = NULL;
-		goto bad_fork_cleanup_delayacct;
+		goto bad_fork_cleanup_count;
 	}
 #endif
 #ifdef CONFIG_CPUSETS
@@ -2781,8 +2780,6 @@ __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_NUMA
 	mpol_put(p->mempolicy);
 #endif
-bad_fork_cleanup_delayacct:
-	delayacct_tsk_free(p);
 bad_fork_cleanup_count:
 	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	exit_creds(p);
-- 
2.25.1

