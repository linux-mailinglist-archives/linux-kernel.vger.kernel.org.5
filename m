Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFA7F3B00
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjKVBIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjKVBIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:22 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425D199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso3802649a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615298; x=1701220098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6X+mOMZoGJuf/KhFjronMx0sFEsDU8bO3mA0YdbfIg=;
        b=H3U84WlFWMabFJAnu3tQEA+F0LLai5ajuAUMjCUF0bKHxyPQRdJ+QKJPp5+1oqdG91
         +ZDHnKGt+FlNuhfmnVsYoTM7hLRUvq/FRGGeD8I3jgv2nYqdFw85QIaDik6dzXUqdITS
         2vekBoz6xau8XcW63DKWbPkuV4V+XjvxHlQq+ZxtaUK3Gz/C7xQh3MzJpnbI0n2WTaEX
         zPeSgjpKxj9RTmhpZ6wE6RrxCx8VMok8ar+TNuRxvyjBOcPXlsvzezEHqrkoQ7T/kbB/
         7xZZFV5YNqV5COo+t/rDGl6haTjm2P4erF30M+umkCusAHsbG+GZnwtDD6KfK/ek/V6+
         N54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615298; x=1701220098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6X+mOMZoGJuf/KhFjronMx0sFEsDU8bO3mA0YdbfIg=;
        b=V2gN6eTvUSpkg8SnnbljjHB7/hj2OEk4RR9clhKEn3IZR6FkkR+hygDyr3lobSKXGm
         N8N1OOfwEhF0emqstXdieDqk9fmkLhsfwMmb2M42+QTBbigGfPvlX+FW8QuwPteGq7Up
         0dLA9PAA2pMTQHEUaJDQSn6TPMwRcB5bGtthBJng9iGHSC/3dyHlThB/ZJgTRLJ2XC5y
         ChqTOOm4sAcL23iInxJImwUxKWR73TXVZ8sy3rOSTDb1MytEW4K7Zi6hf0UttL8Aq1Kz
         V6dSKEMukEgnCJ4E9pc0OsanlaSOgJkTjRCYOo9gMv+L9ehjlrN/qnd6V+91XwGCGMlj
         k9GA==
X-Gm-Message-State: AOJu0YxtsAtnCCmVbsLeuASPBj/GliWYk+Y0PhWmHrLPXYMaWlzi7/CM
        rxHKbnQQeW3DJKJfo5WEHthJSA==
X-Google-Smtp-Source: AGHT+IF0MPSUCqiTsnl1eQc+NOEkZdfylg4Cinzvui2qig7vBCcLaky4/GlXwa1fL7VF+JjfOGRcVA==
X-Received: by 2002:a05:6a20:431a:b0:18a:da5a:3825 with SMTP id h26-20020a056a20431a00b0018ada5a3825mr948843pzk.34.1700615298368;
        Tue, 21 Nov 2023 17:08:18 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:18 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 1/8] riscv: mm: Combine the SMP and UP TLB flush code
Date:   Tue, 21 Nov 2023 17:07:12 -0800
Message-ID: <20231122010815.3545294-2-samuel.holland@sifive.com>
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

In SMP configurations, all TLB flushing narrower than flush_tlb_all()
goes through __flush_tlb_range(). Do the same in UP configurations.

This allows UP configurations to take advantage of recent improvements
to the code in tlbflush.c, such as support for huge pages and flushing
multiple-page ranges.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

 arch/riscv/include/asm/tlbflush.h | 33 +++++++------------------------
 arch/riscv/mm/Makefile            |  5 +----
 arch/riscv/mm/tlbflush.c          | 13 ++++++++++++
 3 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 8f3418c5f172..317a1811aa51 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -27,13 +27,12 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
-#else /* CONFIG_MMU */
-#define local_flush_tlb_all()			do { } while (0)
-#define local_flush_tlb_page(addr)		do { } while (0)
-#endif /* CONFIG_MMU */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
+#ifdef CONFIG_SMP
 void flush_tlb_all(void);
+#else
+#define flush_tlb_all() local_flush_tlb_all()
+#endif
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 			unsigned long end, unsigned int page_size);
@@ -46,26 +45,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
-#else /* CONFIG_SMP && CONFIG_MMU */
-
-#define flush_tlb_all() local_flush_tlb_all()
-#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-/* Flush a range of kernel pages */
-static inline void flush_tlb_kernel_range(unsigned long start,
-	unsigned long end)
-{
-	local_flush_tlb_all();
-}
-
-#define flush_tlb_mm(mm) flush_tlb_all()
-#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
+#else /* CONFIG_MMU */
+#define local_flush_tlb_all()			do { } while (0)
+#endif /* CONFIG_MMU */
 
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 3a4dfc8babcf..96e65c571ce8 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,15 +13,12 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o tlbflush.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pgtable.o
 obj-y += pmem.o
 
-ifeq ($(CONFIG_MMU),y)
-obj-$(CONFIG_SMP) += tlbflush.o
-endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e6659d7368b3..22d7ed5abf8e 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -66,6 +66,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
+#ifdef CONFIG_SMP
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
@@ -138,6 +139,18 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 	if (mm)
 		put_cpu();
 }
+#else
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long size, unsigned long stride)
+{
+	unsigned long asid = FLUSH_TLB_NO_ASID;
+
+	if (mm && static_branch_unlikely(&use_asid_allocator))
+		asid = atomic_long_read(&mm->context.id) & asid_mask;
+
+	local_flush_tlb_range_asid(start, size, stride, asid);
+}
+#endif
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-- 
2.42.0

