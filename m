Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603D7DAA1C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJ1XNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJ1XNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E0DD9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso3315715ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534823; x=1699139623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EsAJ3DvynnbB6jUfsinRvKaNQwCusxxXujfrC8RtXI=;
        b=Kz6ZFZekc1mo2dxoD2XHRtugETvR+zuoZtRIdZksTNRbflSk8B7ZN2wIgQZZGlwBbj
         xF8dG1IkQNxLs9sOOl1X1iXWslQ0Cy/MLeGmALbn2HMB9VqVAmwgVnZ7ryhetm1LnqDs
         3wjjYfw1kMPlVLl1f7SbHFnW0WOQZhPCIUOkuGjfCUM5udP/E5VJw0XVOTz/gYX2uUsF
         I4/eFWiVRH50KqxjRqNcgKC18uMidcJalcHGNJvcATE0SIfE8uxuZzUXsOp/Y3OWkyDn
         FEufHtOLRn80DOUDi57m+q4E+gs8HivYW6RmepUGHsQFvAhqU1+3Ujs1mgbyHtzmOfLW
         YXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534823; x=1699139623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EsAJ3DvynnbB6jUfsinRvKaNQwCusxxXujfrC8RtXI=;
        b=VRNIO5besVdn7IvAsZ/NsrI5TJSOS7hQ2FcMGY2C4v9dBrbRGMTMcRRw7YDMmk7AUS
         8S0zeTgZskERzg22EFso9kGlHlKhMP+ucTEFaeHI/xiomHOgZ4HHWrATkSBIKR6VCkKO
         ETk264D69oq82oimqQnCLCFGUAn8E8WZulxgXT8qoNhtneqSflFqsS0VdMjk0Vta6m6y
         20+1BFAMbCogkaioOyQefB8JGqRMg/c2NcZSGez1mxg0QJCoBVRJJ2xTekaJDx45Q7PA
         Stcq01JfY7WQ1sD02Kwk1CNOWFvjbceGSa4fqahqN9qTo0SpT8Sy18pBOmcqfA38v1N/
         IhZA==
X-Gm-Message-State: AOJu0YwPqX7Apedp2BFjxWA8ZPyB8b2GYt3YJhX1gtO1twCBTnGU24b2
        fzMSmMkXi5Buibj/FQsXjaqxOw==
X-Google-Smtp-Source: AGHT+IFw/0gO2jty39BfEl53e0TAm8jThBxaHB3Pi6HPPc0H5aL70GOaasoPy4Ex/mKBNftI1RCeRA==
X-Received: by 2002:a17:902:cf41:b0:1ca:8252:a91 with SMTP id e1-20020a170902cf4100b001ca82520a91mr7454451plg.41.1698534823149;
        Sat, 28 Oct 2023 16:13:43 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:42 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 01/11] riscv: Improve tlb_flush()
Date:   Sat, 28 Oct 2023 16:11:59 -0700
Message-ID: <20231028231339.3116618-2-samuel.holland@sifive.com>
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

From: Alexandre Ghiti <alexghiti@rivosinc.com>

For now, tlb_flush() simply calls flush_tlb_mm() which results in a
flush of the whole TLB. So let's use mmu_gather fields to provide a more
fine-grained flush of the TLB.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # On RZ/Five SMARC
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/include/asm/tlb.h      | 8 +++++++-
 arch/riscv/include/asm/tlbflush.h | 3 +++
 arch/riscv/mm/tlbflush.c          | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 120bcf2ed8a8..1eb5682b2af6 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -15,7 +15,13 @@ static void tlb_flush(struct mmu_gather *tlb);
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	flush_tlb_mm(tlb->mm);
+#ifdef CONFIG_MMU
+	if (tlb->fullmm || tlb->need_flush_all)
+		flush_tlb_mm(tlb->mm);
+	else
+		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
+				   tlb_get_unmap_size(tlb));
+#endif
 }
 
 #endif /* _ASM_RISCV_TLB_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index a09196f8de68..f5c4fb0ae642 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -32,6 +32,8 @@ static inline void local_flush_tlb_page(unsigned long addr)
 #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
 void flush_tlb_all(void);
 void flush_tlb_mm(struct mm_struct *mm);
+void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
+			unsigned long end, unsigned int page_size);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
@@ -52,6 +54,7 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 }
 
 #define flush_tlb_mm(mm) flush_tlb_all()
+#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
 #endif /* !CONFIG_SMP || !CONFIG_MMU */
 
 /* Flush a range of kernel pages */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 77be59aadc73..fa03289853d8 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -132,6 +132,13 @@ void flush_tlb_mm(struct mm_struct *mm)
 	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
 
+void flush_tlb_mm_range(struct mm_struct *mm,
+			unsigned long start, unsigned long end,
+			unsigned int page_size)
+{
+	__flush_tlb_range(mm, start, end - start, page_size);
+}
+
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
-- 
2.42.0

