Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5817F3B01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbjKVBIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjKVBI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEC1A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:24 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35b07f701c4so7176355ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615304; x=1701220104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b39ZSDVnn3/TpDDYcLNRgBYhWVyekPNc8OuxKxdgheo=;
        b=jGFhxv+q81USzJS8Lm5q+YQPv1bGi5N1k4DKcQFe1lg7H+HKyRO3zQkQb/wmFGjTDl
         wJA69QBg9P3oCQNwL0amVuWmJOm+m241n9H/bJfX1jjDppKnOC3g2D4pvmQkocb4UzED
         36WIyys7pwiwgwn7mM3F0SCa7BGBs+/58jxJi/xJIA69OQXTuREk8dWz7KiVtXJtaqlF
         rYvBA7Zn5Y8I7ASNFFVrQwoaZUF2Cg4cAi+oQNtgCHYIDmOVpsasAvnXIsl/djFPtQOa
         QaIicCaDoCgNiLst0qMBn3/88hdVNJ19CygLRZhiYQdCDkdmrAYwyZYPdScUumoeDr6l
         xJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615304; x=1701220104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b39ZSDVnn3/TpDDYcLNRgBYhWVyekPNc8OuxKxdgheo=;
        b=fWWhyVan4DVFQ45e5IAYDvnppPvaZPCn3IlQ1w7NlCxlquyHzOI0u5/QQ/Po3PIN1a
         fWlRz/kXmC2w9MiFczQcMcbIdPNppRHNP91Dp7MimRgXCkhsCL40xZRFyywAOth/XV8K
         jB7pmsRgC3B6QxHhQP6uyF54rd5fnfWxQpERNyoQIi5t3najYCQ8LchmjRxplDxwG1El
         NcCgmXQAvkvcnt4X6WpYCYliQVDeh7ZCmEQQz/cs1FcWsfhkuBo+0zFHlgwfF0+H6tg1
         pddblWsyT9zB+nI7F+D8OeeWs7FHco4OL54x9jL8f+tLT8zDRMjBJ0vqO/ysaLaazVW1
         WbVw==
X-Gm-Message-State: AOJu0YzZ06kFEx7PiMsQFZnoZWlkaV++59MTo/OTJMIknHl7ug4YaFZO
        ltwTX9FSlPWgqyPePPt6tA3sdMX+jdMOiYmfnhY=
X-Google-Smtp-Source: AGHT+IGi2JpVuCgk8T+HgcOfCC/VHmmgf8iSnDwMNXS0Bc2add3cL906GsPfWT4iX9QyNn2xttBJig==
X-Received: by 2002:a05:6e02:b48:b0:35b:2b49:d816 with SMTP id f8-20020a056e020b4800b0035b2b49d816mr721861ilu.13.1700615303918;
        Tue, 21 Nov 2023 17:08:23 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:23 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 5/8] riscv: mm: Use a fixed layout for the MM context ID
Date:   Tue, 21 Nov 2023 17:07:16 -0800
Message-ID: <20231122010815.3545294-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122010815.3545294-1-samuel.holland@sifive.com>
References: <20231122010815.3545294-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 3b393f765805..4448d907f2c9 100644
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

