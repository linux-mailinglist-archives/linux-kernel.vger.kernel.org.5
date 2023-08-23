Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2F784FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjHWFG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjHWFGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:06:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CDE58
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so696526566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692767178; x=1693371978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKHCB44AckVFwTchMQuBCPQ5Mr4hBKNgvgKNhep04i4=;
        b=nbGMC/v69gsCL1IBVf+ztV6UvaaYtA28bsu2aG6AvtQMBJ+xqE93v5gEURtPqyh+JM
         a1MdLF+6B9gcA/ErtCCRYwr6N8uk4hiVZIa5fwbicH+qxlKLgPpX8V8Jr4t+5dhgPHjO
         HfNCETQIIeDAprwEzHDEabadn+frN0HXrfZcoQ5LUCeQlooltrZns12hOr5bS7GeJ6eT
         39KbYobKl8/hc9d0MxYsL0hN/2VjmNZuGYvtxgHwFpeJ7D1eRBtdGnd3KkB4NX4bywDL
         1NZuON4UUJvw4jjxWq5Jiix4+HFHnB7c8wvbpR9KwGf/vq93yXNr+VBD4t9ellxcZLQu
         Gn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692767178; x=1693371978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKHCB44AckVFwTchMQuBCPQ5Mr4hBKNgvgKNhep04i4=;
        b=QNdgyF44TC3UjnfKYCDcqAc0AduAjuqdJT7F5f6Zlm2Pj/tZ72mSumLLQtluRRtvwD
         27Eun+ubLIDZxzRq4gVmYmTz1PyatJrlhzZ4a7KNJ0/c5M/dNLaUcPmVMlgh0TrGubPK
         HtsUpHq1K0l5U8krosCvNRA8VEZ5cW+BtgG+YkdKIKi42Mwz3BL8cwXtHEJkOh9KsHf1
         s+rm9zOFfJyvKYCc+9lU4/c8vbJZDoGzasLbK5R17S4ObqwYVx9Erl3ZEBcvLSZFLlel
         hONeSdxJe01YfdW4o4t0+eZB1rJ/PxDU18cIvDqfkq0vAsyAf5gLH4JSO6S0re1vuKFT
         8b0w==
X-Gm-Message-State: AOJu0YzD+1aCCRgi4fseDRfb8Uqa6mVu60ZCTcZlHzld3sKaV5plreUh
        ETHIL/+h8SYbvNoSTtlFgAGrhCr+Kp/ULQ==
X-Google-Smtp-Source: AGHT+IE7nSULLshI01yEFzWITte3YVllrEGWbX3MHiHkvCwHHx0LceZup3+ufxgmQEyozhc7uPZ28Q==
X-Received: by 2002:a17:907:60c7:b0:991:bf04:2047 with SMTP id hv7-20020a17090760c700b00991bf042047mr8784854ejc.14.1692767177624;
        Tue, 22 Aug 2023 22:06:17 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b0099ddc81903asm9267401ejz.221.2023.08.22.22.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:06:17 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/2] kernel/fork: group allocation/free of per-cpu counters for mm struct
Date:   Wed, 23 Aug 2023 07:06:09 +0200
Message-Id: <20230823050609.2228718-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823050609.2228718-1-mjguzik@gmail.com>
References: <20230823050609.2228718-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
the primary bottleneck shifts to page release handling.

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
2.41.0

