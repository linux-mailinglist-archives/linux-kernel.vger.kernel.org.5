Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31078497C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHVSmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjHVSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:42:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60076CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:42:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5008d16cc36so1708128e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692729720; x=1693334520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEOToIeoViTRF8c8rAS7lPuWoT5IGl18T901p8s8lTc=;
        b=QfVGsVPwABxhEcYrvXbcmGiUuRvcJXymMpVHwTotunc6jGK3pxIitnK0pOSZRFmEuL
         oXQs8Q+9oKQP1g8HsM+D9ok35AXs4Q8BZUmGNdnBekmT+68LHd+hhZPCs9wHNZ3jhRgI
         Vt3/bJlJuCKxjpWBm1O+QxCqEFTn1KPle9ZPbnJa0Z+fOom8Xqlq3gvp71cs9gA3QHHB
         ginjoZv3MmDg3zGF/e+ejtBgdIEqcgUcmM2ZFdFCZ3XMR7dmlwZ6qhx7HaIW6rc0zrX9
         CjO/UNJsvzEP05/0XLKfCrEX730ap91i8SeofwitpKE0UWFbkwYzwE72YWNVtvqJbPPB
         CkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729720; x=1693334520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEOToIeoViTRF8c8rAS7lPuWoT5IGl18T901p8s8lTc=;
        b=MCL6XJkCfqErqMiu7rSfMIqwimyPnlCcBzzWhTmjTWlRnbj2O/9M9xcLeUhcLspIaw
         uS7DfGpyVWyvaOs4l/lOw5D6QOK2Ky6uDBqSNe1VjiU+6fm/buMuyDURkImK6PUVDwib
         m4DgqYrO/yXun2k9FM64RFfofZSKzwjo7gU+1XxG44Z2ClM2yjK6sPmbEpG4r5xHIta/
         CgHHPC4QJT/K2Woh4e/z4Y9/DstrGsFOwiVHUI5Q7UwS2kYzhTAwIAYeVB1hOsoeFn6S
         igUSeeAWr0o+Oz1i1WdevEUKBnGbnLI2pJ8ggsNcOOltGWSVttAgPI1kOMHWZm6EdeOe
         Vg3A==
X-Gm-Message-State: AOJu0Yx7gOCgEODgrlLhygfIXT0djddXD09zt1dauhqNpGBGXaQ0CSo+
        +nW/e97tDi+Yey3GIwyiF5QTQl9ChlNG9Q==
X-Google-Smtp-Source: AGHT+IEL+C5O6TMeHs29lajaMbWo+0Cbc3ZEq9kla6k40ShytD8+zBpbctMDQ6f76ngrJSIhW5Btog==
X-Received: by 2002:a05:6512:39ca:b0:4fe:82a7:814d with SMTP id k10-20020a05651239ca00b004fe82a7814dmr8200504lfu.48.1692729720458;
        Tue, 22 Aug 2023 11:42:00 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm7945317edx.5.2023.08.22.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:42:00 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/2] fork: group allocation of per-cpu counters for mm struct
Date:   Tue, 22 Aug 2023 20:41:52 +0200
Message-Id: <20230822184152.2194558-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822184152.2194558-1-mjguzik@gmail.com>
References: <20230822184152.2194558-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial execve scalability test which tries to be very friendly
(statically linked binaries, all separate) is predominantly bottlenecked
by back-to-back per-cpu counter allocations which serialize on global
locks.

Ease the pain by allocating and freeing them in one go.

Bench can be found here:
http://apollo.backplane.com/DFlyMisc/doexec.c

$ cc -static -O2 -o static-doexec doexec.c
$ ./static-doexec $(nproc)

Even at a very modest scale of 26 cores (ops/s):
before:	133543.63
after:	186061.81 (+39%)

While with the patch these allocations remain a significant problem,
the primary bottleneck shifts to:

    __pv_queued_spin_lock_slowpath+1
    _raw_spin_lock_irqsave+57
    folio_lruvec_lock_irqsave+91
    release_pages+590
    tlb_batch_pages_flush+61
    tlb_finish_mmu+101
    exit_mmap+327
    __mmput+61
    begin_new_exec+1245
    load_elf_binary+712
    bprm_execve+644
    do_execveat_common.isra.0+429
    __x64_sys_execve+50
    do_syscall_64+46
    entry_SYSCALL_64_after_hwframe+110

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 kernel/fork.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..4f0ada33457e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -909,8 +909,6 @@ static void cleanup_lazy_tlbs(struct mm_struct *mm)
  */
 void __mmdrop(struct mm_struct *mm)
 {
-	int i;
-
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 
@@ -925,9 +923,8 @@ void __mmdrop(struct mm_struct *mm)
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
+	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
 
-	for (i = 0; i < NR_MM_COUNTERS; i++)
-		percpu_counter_destroy(&mm->rss_stat[i]);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1252,8 +1249,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
-	int i;
-
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
@@ -1301,17 +1296,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_cid(mm))
 		goto fail_cid;
 
-	for (i = 0; i < NR_MM_COUNTERS; i++)
-		if (percpu_counter_init(&mm->rss_stat[i], 0, GFP_KERNEL_ACCOUNT))
-			goto fail_pcpu;
+	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT, NR_MM_COUNTERS))
+		goto fail_pcpu;
 
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
 fail_pcpu:
-	while (i > 0)
-		percpu_counter_destroy(&mm->rss_stat[--i]);
 	mm_destroy_cid(mm);
 fail_cid:
 	destroy_context(mm);
-- 
2.39.2

