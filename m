Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E007F3B08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKVBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjKVBId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:33 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1662199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:27 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b58d96a3bbso3637913b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615307; x=1701220107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj2ICW1Fptg7hPvDVbuVBoYZZibiQ7SyAcM7RK2jyBY=;
        b=eq1SR9abgzTitUEVa1WXCZZRtNJamTF6j/hVuHV/kxEuo/1w6ja5oRlG65TCxU//PU
         WVcCuHAHdjowyegBpF+RMRaM61V336FgQzWVo0zNkx/6aZZoWqpg8rXAoJCEl6YIZj+F
         UucYvk0idUl5uZtNlCUnwJnm1HCkWLWkEV9+0keo0nqVgO/Bt6o8Lc6uFxg/xr5A/khk
         kjF8EkV38tZrBl9d/cu5/e2/ZT4BCOcAAueoaxZS/L3JTeV1LLntPjn1stHlE2ARTPVq
         wKLUfoXYHYA1PKYkAIV7/CvDSczNWgI7JcUlK0FR7jelPOr5KfGWNwBJ3zz3IOV9z3tq
         PIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615307; x=1701220107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj2ICW1Fptg7hPvDVbuVBoYZZibiQ7SyAcM7RK2jyBY=;
        b=wUcK0WZDIyA9PTjTqWzDOdLoWOoJ/BtzscBbHW9b+CE2hIzHJV8LPbIfbdu+QPV5zA
         L/jLEPqlLgGSiNsxJFHSDgk6ggnJwU/sPOej6wxFmeP28kGkp5P+NsgTsfA89fVbE44a
         oDnaiKgvkL5J/tZlvhtIRk+5Jr5NxAW9hiJlk0KR3wc+al/ukiBSo7GAzc7uGw5zBAM6
         MpWb9xbIJGUOQBbve55HL5Bgb1DKqJroqBOz/wifIy05wyLCcN4OG1THZpWSZ4TnnIVm
         lrANTQTudZ8Sjo9qkWPHLa2SOmNRUfI8VbYDUfdpTyRY6lSvCt1PEUW6xXHMNBlNkOCU
         MOsA==
X-Gm-Message-State: AOJu0YxjM5NEqpBvYQMA0eG+ovOqygcIJDshArNgywP6PqT/FQ9uCauK
        7p6H0Q97Hmmpubo3qw0X+arjOw==
X-Google-Smtp-Source: AGHT+IE4b2JAkpIlmqFLR7/QsgdBYQzfOQCASKlXtamU7cDqbXpB+e41Rju/TG/nF3J4VXpKvwiJIw==
X-Received: by 2002:a05:6808:699:b0:3b7:673:8705 with SMTP id k25-20020a056808069900b003b706738705mr885196oig.18.1700615307054;
        Tue, 21 Nov 2023 17:08:27 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:26 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 8/8] riscv: mm: Always use ASID to flush MM contexts
Date:   Tue, 21 Nov 2023 17:07:19 -0800
Message-ID: <20231122010815.3545294-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122010815.3545294-1-samuel.holland@sifive.com>
References: <20231122010815.3545294-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if multiple ASIDs are not supported, using the single-ASID variant
of the sfence.vma instruction preserves TLB entries for global (kernel)
pages. So it is always more efficient to use the single-ASID code path.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Update both copies of __flush_tlb_range()

 arch/riscv/include/asm/mmu_context.h | 2 --
 arch/riscv/mm/context.c              | 3 +--
 arch/riscv/mm/tlbflush.c             | 5 ++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
-
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 3ca9b653df7d..20057085ab8a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -18,8 +18,7 @@
 
 #ifdef CONFIG_MMU
 
-DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
-
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 23409d70440f..d6619be10341 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -90,8 +90,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		/* check if the tlbflush needs to be sent to other CPUs */
 		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 
-		if (static_branch_unlikely(&use_asid_allocator))
-			asid = cntx2asid(atomic_long_read(&mm->context.id));
+		asid = cntx2asid(atomic_long_read(&mm->context.id));
 	} else {
 		cmask = cpu_online_mask;
 		broadcast = true;
@@ -122,7 +121,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long asid = FLUSH_TLB_NO_ASID;
 
-	if (mm && static_branch_unlikely(&use_asid_allocator))
+	if (mm)
 		asid = cntx2asid(atomic_long_read(&mm->context.id));
 
 	local_flush_tlb_range_asid(start, size, stride, asid);
-- 
2.42.0

