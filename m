Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04D7DAA1E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJ1XN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJ1XNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434BAD6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc20df5187so12487385ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534829; x=1699139629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iD5kVeuyzksz9qFDj4nk3gJEMMhm0SiL+jEgfo9gAo=;
        b=N0Riwa/miVN0GdyvyQAo5JXhlyamqaUNRyieLkclAEVbUF0t+IaKzLi0qcgVJbQAnI
         8UBcy7M/LFJa5UUH0V9KRqbpswk00GSmI+OgXiODEImnkc8R217odLBl9uM4/guxZfBZ
         V4e8rT1W5O9E9u7DCaGBloMBDH3Q6iTLAWaRmMAU3lfOUCsVlrQYWa5wLglvLmkFS4+C
         DyEvVh3xBxVwJXagt4WRfXdzOlCQ9wOJH6qgZ1gl2kSn0VY0NANWLkFbKVyX0BZeNkYj
         uKbKaqc0bzt4mRPf3HTVVGgWLNQuK/91q0e9VEZ/a8whg/xLO/ptCjMG2+9bfTdketH0
         ye3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534829; x=1699139629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iD5kVeuyzksz9qFDj4nk3gJEMMhm0SiL+jEgfo9gAo=;
        b=EkFsgmZjX/yeUahXR86RbbZa/Q80V7oTIzqbjg6aSKZ8IgLePmAXbNHGNC7LOVTzna
         dMUV7q6CCr548BsBCd95JK2t0m8rN5oQN7kszfRRT5ch1joUa5SchEXPYrom8lnMfKow
         ZBVy0Jgt3ld3Ll+31IZ9892oFXYelFj7zhpUaH6KmUmnGfmF4HHcSRnvGTqWHwU6wRnp
         vGVxSsYyLWYxfIKJUW6u2P/7vPlTkPhgR3cgLul4/5tM7EKG7Zzm4oQjWi9H3VA5c/eO
         fi66hrt2VbmwRmpuh2s6j7er2SoNn6dfSnUGjVQGwbMqlC+UKh6mP+3GAhVDo6Qhz7T1
         MvwA==
X-Gm-Message-State: AOJu0YzmOmDWxFixcNkmuOh2t25z6GszEj+f2VncdHVzIGC6kwFCU40B
        cvz0s+cMGmqcBQe+lfzV1azLhQ==
X-Google-Smtp-Source: AGHT+IGZfjM6oWIducpDDQ7hM02X3ekD2Mrbs3+cVpCJdtVQrXLcSNbo2i119+LD0HVTSm0uB+XkgQ==
X-Received: by 2002:a17:903:11d1:b0:1cc:f41:8f82 with SMTP id q17-20020a17090311d100b001cc0f418f82mr8777913plh.16.1698534828754;
        Sat, 28 Oct 2023 16:13:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:48 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 05/11] riscv: mm: Combine the SMP and UP TLB flush code
Date:   Sat, 28 Oct 2023 16:12:03 -0700
Message-ID: <20231028231339.3116618-6-samuel.holland@sifive.com>
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

In SMP configurations, all TLB flushing narrower than flush_tlb_all()
goes through __flush_tlb_range(). Do the same in UP configurations.

This allows UP configurations to take advantage of recent improvements
to the code in tlbflush.c, such as support for huge pages and flushing
multiple-page ranges.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

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
index 9c454f90fd3d..64f901674e35 100644
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

