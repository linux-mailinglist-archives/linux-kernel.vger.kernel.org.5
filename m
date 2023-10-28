Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8DF7DAA21
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjJ1XOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJ1XNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1042EEB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso3316135ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534831; x=1699139631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq0QdLYJN1f+TxJhAAAn9k5Zt34COvQfV/ogec/O0wM=;
        b=RLNomWrxly9VYMzEM4GBRfylLuRbEIJ8Ho4PcimecPGIdPZhk86Nw+X/aCUAXOeq9W
         DmG2IogMsnFv1U+D9Qm+fst/JKxmGkmUPs4COe7N2JbLZK6lnNgCgNuvhYTTlus/tGsk
         nt7PnBVaiNLsi9VUmLsMtv+8gwoA++eQns8583KdyUjEEOMXrdvUb7vvpGlAqIR/Q13A
         l7wJHRqR/aFPXmmsL8hqZsfoWGoGYj0sdWYmVQRK4STzq1UH/pXetiUrgg77OF21+EHW
         guSp+TYYItzM0PJCMM9c+ZeLQgobX7NbVPpWVJy/4/zDIMGeqAw6JmCux59sDpHKDlSr
         uy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534831; x=1699139631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uq0QdLYJN1f+TxJhAAAn9k5Zt34COvQfV/ogec/O0wM=;
        b=iH9vkOO/ztzj8IwJYzzwL1R8KYql3EzG02rea8eRYgqmxWcl7HB5pO4IRbqFNPKtSN
         Iu2JmOKaloOhv2v8BIV0ZtoiBud248R8QZdp4fpdN99Vo+v7zCHyojHs2PPl7LkCFniP
         qV8fN9ihnHTmNMVIxgl8p8CQX40zMQ6qUwhwhVFzxapj56ojGvciY9bWBsGm+bBBwkpM
         zum/l6uYz1NUy03eys/qQSnFCjc2N98io1kewH9T1VSra0pjjVgyFAAxkFnJSI5VT7JW
         XkMGctRKrTcb9NNKYdrdWTRJiWFPNxjRp7M1d8Y/hYRmc/R+TX5kmtU3yYj/y8pRHNzD
         cBQQ==
X-Gm-Message-State: AOJu0YxcVt376+Kw25x2x5CzZzGGaNIHbQKxFppjh3JhzDd7TwGqQiin
        8cibMafuZPNs/alnsrctyRsKQypBaTt7uIOgB6w=
X-Google-Smtp-Source: AGHT+IGqJfNl+X6UXX6MsfY+UkH1b50Ad4rlkkQrptVRUTaYY/ZhDSmvjBpzXH88ANRSqVScovaqNA==
X-Received: by 2002:a17:902:6b8c:b0:1c9:bf14:4f94 with SMTP id p12-20020a1709026b8c00b001c9bf144f94mr6530418plk.44.1698534831309;
        Sat, 28 Oct 2023 16:13:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:50 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 07/11] riscv: mm: Introduce cntx2asid/cntx2version helper macros
Date:   Sat, 28 Oct 2023 16:12:05 -0700
Message-ID: <20231028231339.3116618-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028231339.3116618-1-samuel.holland@sifive.com>
References: <20231028231339.3116618-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the ASID allocator, the MM context ID contains two values:
the ASID in the lower bits, and the allocator version number in the
remaining bits. Use macros to make this separation more obvious.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h |  3 +++
 arch/riscv/mm/context.c      | 12 ++++++------
 arch/riscv/mm/tlbflush.c     |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 355504b37f8e..a550fbf770be 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,6 +26,9 @@ typedef struct {
 #endif
 } mm_context_t;
 
+#define cntx2asid(cntx)		((cntx) & asid_mask)
+#define cntx2version(cntx)	((cntx) & ~asid_mask)
+
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de6134..43d005f63253 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -81,7 +81,7 @@ static void __flush_context(void)
 		if (cntx == 0)
 			cntx = per_cpu(reserved_context, i);
 
-		__set_bit(cntx & asid_mask, context_asid_map);
+		__set_bit(cntx2asid(cntx), context_asid_map);
 		per_cpu(reserved_context, i) = cntx;
 	}
 
@@ -102,7 +102,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 	lockdep_assert_held(&context_lock);
 
 	if (cntx != 0) {
-		unsigned long newcntx = ver | (cntx & asid_mask);
+		unsigned long newcntx = ver | cntx2asid(cntx);
 
 		/*
 		 * If our current CONTEXT was active during a rollover, we
@@ -115,7 +115,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		 * We had a valid CONTEXT in a previous life, so try to
 		 * re-use it if possible.
 		 */
-		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+		if (!__test_and_set_bit(cntx2asid(cntx), context_asid_map))
 			return newcntx;
 	}
 
@@ -168,7 +168,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	 */
 	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
 	if (old_active_cntx &&
-	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
+	    (cntx2version(cntx) == atomic_long_read(&current_version)) &&
 	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
 					old_active_cntx, cntx))
 		goto switch_mm_fast;
@@ -177,7 +177,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 	/* Check that our ASID belongs to the current_version. */
 	cntx = atomic_long_read(&mm->context.id);
-	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
+	if (cntx2version(cntx) != atomic_long_read(&current_version)) {
 		cntx = __new_context(mm);
 		atomic_long_set(&mm->context.id, cntx);
 	}
@@ -191,7 +191,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 switch_mm_fast:
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
-		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  (cntx2asid(cntx) << SATP_ASID_SHIFT) |
 		  satp_mode);
 
 	if (need_flush_tlb)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 0feccb8932d2..1cfac683bda4 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -91,7 +91,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 
 		if (static_branch_unlikely(&use_asid_allocator))
-			asid = atomic_long_read(&mm->context.id) & asid_mask;
+			asid = cntx2asid(atomic_long_read(&mm->context.id));
 	} else {
 		cmask = cpu_online_mask;
 		broadcast = true;
@@ -123,7 +123,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 	unsigned long asid = FLUSH_TLB_NO_ASID;
 
 	if (mm && static_branch_unlikely(&use_asid_allocator))
-		asid = atomic_long_read(&mm->context.id) & asid_mask;
+		asid = cntx2asid(atomic_long_read(&mm->context.id));
 
 	local_flush_tlb_range_asid(start, size, stride, asid);
 }
-- 
2.42.0

