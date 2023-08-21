Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01522783468
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjHUU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHUU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:28:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F9123
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c353a395cso500449066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692649734; x=1693254534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg7FamlUBikKy1ZdTRl5d2sgxVAImmgfb9egeVVkijU=;
        b=GS9/2BnUwu1b5bIuLG08EYaNXH+HEHCTChQxHxg55sLB8NOoGwX+vmAnKuiPbbDf9b
         mZ7LpTBMnC3a1Nnzgv3bbrPFZ9IRYV8A3nWgKv9m3THXrC6NdegX590Uq5kun9tMH5S5
         5zlojrZmE82bf49ARL1iHeWmcDVQkaRvkbWrcnKAPyQYo3U4lCYpvLAjaa/YOB8Q01Zc
         u7K/ecFioIx+x8qXdfKm7gGhaPRhdHsGjU5rZaGLpBhTiv92bL2bScXiQDmWFMjvy85e
         Lh0w+bXwcDn6prStj+dkCeBnGR68a6gMpfE3b9sVu7ld7iurMfMYdHnlYp1I1OxpvK3l
         +Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649734; x=1693254534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg7FamlUBikKy1ZdTRl5d2sgxVAImmgfb9egeVVkijU=;
        b=GcQSoDyiVpkw22wPU0e1YRRqbQnsc3O3ngkE0Fy0I3Vm+zesp5U4+qBz2nT3y3d/yH
         dvje9z7q0TY4sX5/nOB7bhlg9cN5ufhEpPh6IawebfzEcNeSB3bSEmwDYrogIMe7fWqu
         dzxzuDAG5YTL8izM2xuacbsylmoy6WnUDxgs0Oj2lWDOwX9swg529rckaqppJl6G7YrB
         dzjIh4xuLXE0SJP3buWlXMg/GNevZhINjUFp3eUZNuVzUl6DtHtwJGBp7LkWm5I82qvA
         TsvZ5nPLoQdPZgS8obg/4p2G8bUb67K092NJsczx7pJMV/YSyGdhFa0ipvSHvrYBMkEa
         w4nA==
X-Gm-Message-State: AOJu0YyR531RkfXSczGznzWJ/g3waY8xaR1WHfJbz8uHoT3PR/prMjiQ
        EALaA9af9u6FRRldX5hE3OasetwwAwsFIw==
X-Google-Smtp-Source: AGHT+IGf2yh/BOotGTgsXmYaaGQBLu0XGFOT2TeDIDab903lxvXLvovWRyYYSDCXy47puh+eVEdJ8g==
X-Received: by 2002:a17:906:105d:b0:992:ab3a:f0d4 with SMTP id j29-20020a170906105d00b00992ab3af0d4mr5901843ejj.17.1692649734243;
        Mon, 21 Aug 2023 13:28:54 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b00997cce73cc7sm7084450eje.29.2023.08.21.13.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:28:53 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fork: group allocation of per-cpu counters for mm struct
Date:   Mon, 21 Aug 2023 22:28:29 +0200
Message-Id: <20230821202829.2163744-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821202829.2163744-1-mjguzik@gmail.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
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
 kernel/fork.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..86ff78e001c1 100644
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
@@ -1252,7 +1249,6 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
-	int i;
 
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
@@ -1301,17 +1297,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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

