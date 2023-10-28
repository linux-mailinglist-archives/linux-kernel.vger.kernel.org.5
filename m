Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98217DAA20
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ1XOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjJ1XN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EEED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4cbab83aaso2241624a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534832; x=1699139632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfPkHia9ku1mIe8MIuwK1ts/4i7vxeqzbyNHZF4YvJg=;
        b=iHcRbx+mh/is2zOiLO1C8565EhG3yX4UN8thHJRx9oleH6+7wXkj7cW0KEpxZregGH
         BJWAGCmSvyFf+2K/Q2VbBh8Gy3o6ln4PljiE+FPSM4p2mSDjc+iP1EvFd56h09x7KeHV
         MLcjs/pStT9tR6EJmp6mWJvFWx4e1qr5ji9/SilbgdvDHhvfgr9VczOjTgm5eCP4t72K
         oYzpZpS/IRCZyIVQvjvHcv35icPLcYm2V7EaztsrKz9S9afogzMO9tgVfLrNc4Ftjlmo
         IuhahHPfFAIytTAjOFx/uugbSsuP4fn68zFHM0PI2RXFBPdqpfW6PsTlsLxYq0oh0gWw
         wJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534832; x=1699139632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfPkHia9ku1mIe8MIuwK1ts/4i7vxeqzbyNHZF4YvJg=;
        b=e3zCOaSbtB9oQHhEi+pBGz5XQu/qtfKGVLrJYWN+geDetcrxKL9WNH+PEfxLWm8S8D
         92pPr0eY0z+DwbKazIMCz9Is5UoxRGKzd1Ti42kGgyBomnR41vASjXrquMZO1REszbn5
         sYYb5yqd4NjCwwcdYDC0dLfBMhqjEr66jHyuB7UWc3Qfs42nYPjov07RTli2rdmGIRV0
         2WuOILfVyD6jNyqGxmwT6G0sYNhkFgOg7T2ySB/QSnlI+OPlKn8nh8Jk/FfdOvgnZ2y/
         649COM+l/WVjkPsfEkt9Dl7AwAR0BK3w42ijSiSysEl9wGefa0iLGaI4SbHHz0yKXH68
         g82A==
X-Gm-Message-State: AOJu0YznLrojlpQb1sXr3WeuXi/3t3uYBdO1pP+1EDVcDovS0kso/kpx
        5Eufn1gTaDimjBgaU6ccNOLPDUpx4GZhrxsEtbc=
X-Google-Smtp-Source: AGHT+IERITWcnpZawWSuuFpc/cjj/Gs86LMrNqv2CdnNpOWafKnnt4wsBVVnxZL60abLMgaX5a0ZCA==
X-Received: by 2002:a05:6830:1e30:b0:6bd:c7c3:aac2 with SMTP id t16-20020a0568301e3000b006bdc7c3aac2mr6567117otr.18.1698534832734;
        Sat, 28 Oct 2023 16:13:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:52 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 08/11] riscv: mm: Use a fixed layout for the MM context ID
Date:   Sat, 28 Oct 2023 16:12:06 -0700
Message-ID: <20231028231339.3116618-9-samuel.holland@sifive.com>
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

Currently, the size of the ASID field in the MM context ID dynamically
depends on the number of hardware-supported ASID bits. This requires
reading a global variable to extract either field from the context ID.
Instead, allocate the maximum possible number of bits to the ASID field,
so the layout of the context ID is known at compile-time.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h      | 4 ++--
 arch/riscv/include/asm/tlbflush.h | 2 --
 arch/riscv/mm/context.c           | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index a550fbf770be..dc0273f7905f 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,8 +26,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
-#define cntx2asid(cntx)		((cntx) & asid_mask)
-#define cntx2version(cntx)	((cntx) & ~asid_mask)
+#define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
+#define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index e529a643be17..62d780037169 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -15,8 +15,6 @@
 #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
 
 #ifdef CONFIG_MMU
-extern unsigned long asid_mask;
-
 static inline void local_flush_tlb_all(void)
 {
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 43d005f63253..b5170ac1b742 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -22,7 +22,6 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
 static unsigned long asid_bits;
 static unsigned long num_asids;
-unsigned long asid_mask;
 
 static atomic_long_t current_version;
 
@@ -128,7 +127,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment current_version */
-	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
+	ver = atomic_long_add_return_relaxed(BIT(SATP_ASID_BITS), &current_version);
 
 	/* Flush everything  */
 	__flush_context();
@@ -247,7 +246,6 @@ static int __init asids_init(void)
 	/* Pre-compute ASID details */
 	if (asid_bits) {
 		num_asids = 1 << asid_bits;
-		asid_mask = num_asids - 1;
 	}
 
 	/*
@@ -255,7 +253,7 @@ static int __init asids_init(void)
 	 * at-least twice more than CPUs
 	 */
 	if (num_asids > (2 * num_possible_cpus())) {
-		atomic_long_set(&current_version, num_asids);
+		atomic_long_set(&current_version, BIT(SATP_ASID_BITS));
 
 		context_asid_map = bitmap_zalloc(num_asids, GFP_KERNEL);
 		if (!context_asid_map)
-- 
2.42.0

