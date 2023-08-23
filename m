Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52759785E10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjHWRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjHWRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:06:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C0E68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:06:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977e0fbd742so740397766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692810384; x=1693415184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8kJXJjKS7h/p3miaRvaSI19tMqauTHvoSS/iJ/+kvA=;
        b=ooiGKtMgetH+xepHc/qXTlGSmDpflYMO6h0Ql/Zn0vuW2YLq6hUmfElWbvbg7COdZY
         mn3qHiQ/8HSGAxmS8O0ShkeguiF+dcgp7WZ1fXPKCIbpTYduVFDqNAPpE0jRSP7xkqyJ
         7DfkufiPQ35eg6q3HHEIurnR3HnRyPhuUN0iSvEwxWJwaE2/ZhktIOdWh377WzTf2Jm8
         Y0nmgrFnQ//NDtJYe6J50qGF9dv7KhYfwXG+sJLzk8sQU0T6nUtCSUQrXXvbec3WlqFH
         CH3MuUpc6Wcfi/roboeHNtPC533QQ4Miu8N0UNjr8egIZMLIp/SWe5iqoG5VENYmb66L
         RG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692810384; x=1693415184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8kJXJjKS7h/p3miaRvaSI19tMqauTHvoSS/iJ/+kvA=;
        b=CcHIR7BAm1wwqAO3EhsZzjFwxkD4Aekx4aJ9jaVLrkElNBhd5OMzOTEUGh5NzZjaIK
         4V5TZ+yJWrR/Nnw78KhKRec/G2APv2uV3B2vm7rZh7o3/o/ZmfPOGNKln692qLycwMMu
         BYLHeNaCEnhnNYe1sU8/36uWwu7mk93c3MG2tBYiOeP9H+hPfmJhkPWCKw8kU7uH24cr
         pMU2DyCpb2JQocKwDQEcm65P+wSKcXr+2MxDX7ZQX4HjQIUycUWPG7YtAT4gzamZHSBe
         IxLjIhiVEH6JpsrUqPK1s6AsEL9LzrRKkxleoA9daA4CPdVMC78mi82eYhITnkzVARN7
         xxkg==
X-Gm-Message-State: AOJu0YzMpDJH7RtGz5rfxZcao9AohKXpxB+SmfDUS7g6LQ4mVwA4OtF/
        1dwF0DJa99rbqezcsV1nLFE=
X-Google-Smtp-Source: AGHT+IESP9RTMkkyzae8SZmQBGuyiRP8rEypwpL3VDKZieqMoqb4UKuzRUjh6CLDOsGpNi9KQtJltw==
X-Received: by 2002:a17:907:7898:b0:9a1:b407:54c7 with SMTP id ku24-20020a170907789800b009a1b40754c7mr5200322ejc.2.1692810384119;
        Wed, 23 Aug 2023 10:06:24 -0700 (PDT)
Received: from f.. (cst-prg-6-172.cust.vodafone.cz. [46.135.6.172])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709067d0700b0099ce188be7fsm10005222ejo.3.2023.08.23.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 10:06:23 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     akpm@linux-foundation.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: remove remnants of SPLIT_RSS_COUNTING
Date:   Wed, 23 Aug 2023 19:05:56 +0200
Message-Id: <20230823170556.2281747-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The feature got retired in f1a7941243c1 ("mm: convert mm's rss stats
into percpu_counter"), but the patch failed to fully clean it up.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/exec.c          | 2 --
 include/linux/mm.h | 8 --------
 kernel/exit.c      | 4 ----
 kernel/fork.c      | 4 ----
 kernel/kthread.c   | 1 -
 mm/madvise.c       | 5 +----
 mm/memory.c        | 2 --
 7 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1a827d55ba94..8d31d5fc658f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -985,8 +985,6 @@ static int exec_mmap(struct mm_struct *mm)
 	tsk = current;
 	old_mm = current->mm;
 	exec_mm_release(tsk, old_mm);
-	if (old_mm)
-		sync_mm_rss(old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
 	if (ret)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..08402054767a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2606,14 +2606,6 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
 		*maxrss = hiwater_rss;
 }
 
-#if defined(SPLIT_RSS_COUNTING)
-void sync_mm_rss(struct mm_struct *mm);
-#else
-static inline void sync_mm_rss(struct mm_struct *mm)
-{
-}
-#endif
-
 #ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
 static inline int pte_special(pte_t pte)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index edb50b4c9972..3cdbe797008f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -539,7 +539,6 @@ static void exit_mm(void)
 	exit_mm_release(current, mm);
 	if (!mm)
 		return;
-	sync_mm_rss(mm);
 	mmap_read_lock(mm);
 	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm != current->active_mm);
@@ -829,9 +828,6 @@ void __noreturn do_exit(long code)
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
 
-	/* sync mm's RSS info before statistics gathering */
-	if (tsk->mm)
-		sync_mm_rss(tsk->mm);
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..1ac1d850f7ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2409,10 +2409,6 @@ __latent_entropy struct task_struct *copy_process(
 	p->io_uring = NULL;
 #endif
 
-#if defined(SPLIT_RSS_COUNTING)
-	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
-#endif
-
 	p->default_timer_slack_ns = current->timer_slack_ns;
 
 #ifdef CONFIG_PSI
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4fff7df17a68..0cf5582122b3 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1470,7 +1470,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	 * clearing tsk->mm.
 	 */
 	smp_mb__after_spinlock();
-	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
 	membarrier_update_current_mm(NULL);
diff --git a/mm/madvise.c b/mm/madvise.c
index 886f06066622..39bed9e4b08b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -741,11 +741,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		folio_mark_lazyfree(folio);
 	}
 
-	if (nr_swap) {
-		if (current->mm == mm)
-			sync_mm_rss(mm);
+	if (nr_swap)
 		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
-	}
 	if (start_pte) {
 		arch_leave_lazy_mmu_mode();
 		pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/memory.c b/mm/memory.c
index cdc4d4c1c858..b72d90ece7fe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -474,8 +474,6 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 {
 	int i;
 
-	if (current->mm == mm)
-		sync_mm_rss(mm);
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
 			add_mm_counter(mm, i, rss[i]);
-- 
2.39.2

