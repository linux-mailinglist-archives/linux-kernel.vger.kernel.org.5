Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD57F3AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjKVBI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKVBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:24 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B65199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:20 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b83d2981b5so205144b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615300; x=1701220100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E3lnavwhWkbsPt/8jollKuN1Wp7270MVQq6Nf32IZI=;
        b=De9XE7y20ckTyRWrQa0Hbzaoo+nq6WHS5nTYBCqRAFQ86M9Y+UUqDZrtGW6qbGvbam
         GQWyR45fGKunNpZlHr3OK5+tRLH2Sr7H8s2+WIT3q3iMucD9E6OqkLvNchgsIy8EzEpU
         ffS+dsPylvPmEkh0dL/gYjCpb24upaSF/yXYwp6u0AGj+YvWJUZOil2jaSrELWKk7bSy
         FDinXNnPm0RgrV2BjpZ79xUgYKv3AVqBipGKjxI4gVROvr0uZE+YdrqZTCwSoQhucuSr
         hjYLt/wsZxfDzl0yVo1/8FSPz6KqXmz6xp6fpxXlBt4XGveYUNIbAaajxXPaSJ5YwDAR
         I2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615300; x=1701220100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E3lnavwhWkbsPt/8jollKuN1Wp7270MVQq6Nf32IZI=;
        b=LdW4YfR4DuuUWXpLcgdY1QI2O7O+w4G5v2th7+9fwgu48iTWCtmeBTro2u1UIAzEY3
         odaWC7rNvH4nwlm71mY9bN25aU0zPeufmHW7RvCaxfa/TT3oZiUzg8+srLsxcJEarTW2
         opQosRjspPmKHITfKa7VQ+0elCrpgW/eIAmgDejb7iTIltC9+7uKSKIKfA1+LT50w+u7
         xc5z/H+nIdL/uR6C+G+vCzlAXF5HD6P+dSTH68pJfhM6DqwgKUf11nwFxmPtqtsg/mee
         +k6xI8YcBtSa5YSvTmISJK3kovQ45CT6mqRTTyan/yh3359Silw3w9Ku+D5cQToaUK4r
         /jeQ==
X-Gm-Message-State: AOJu0YzIQylPPv1fCN9gCuZdecdp5jZ1vH5H6o+C0UF2IoBIVnPtR2dO
        aGuxlVtNKxVOnzKK0f8DFzEiRA==
X-Google-Smtp-Source: AGHT+IFhS1aXruOMSeKbF/kr742mxFr/4ERJTn5q1RSxs6qFscJwCL7KnIKBT8DwBL+aJBuJSXtucQ==
X-Received: by 2002:a05:6871:e805:b0:1d6:8b7f:ce89 with SMTP id qd5-20020a056871e80500b001d68b7fce89mr1213468oac.51.1700615299719;
        Tue, 21 Nov 2023 17:08:19 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:19 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 2/8] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
Date:   Tue, 21 Nov 2023 17:07:13 -0800
Message-ID: <20231122010815.3545294-3-samuel.holland@sifive.com>
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

commit 3f1e782998cd ("riscv: add ASID-based tlbflushing methods") added
calls to the sfence.vma instruction with rs2 != x0. These single-ASID
instruction variants are also affected by SiFive errata CIP-1200.

Until now, the errata workaround was not needed for the single-ASID
sfence.vma variants, because they were only used when the ASID allocator
was enabled, and the affected SiFive platforms do not support multiple
ASIDs. However, we are going to start using those sfence.vma variants
regardless of ASID support, so now we need alternatives covering them.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/include/asm/errata_list.h | 12 +++++++++++-
 arch/riscv/include/asm/tlbflush.h    | 19 ++++++++++++++++++-
 arch/riscv/mm/tlbflush.c             | 23 -----------------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 83ed25e43553..6781460ae564 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -44,11 +44,21 @@ ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
 	    CONFIG_ERRATA_SIFIVE_CIP_453)
 #else /* !__ASSEMBLY__ */
 
-#define ALT_FLUSH_TLB_PAGE(x)						\
+#define ALT_SFENCE_VMA_ASID(asid)					\
+asm(ALTERNATIVE("sfence.vma x0, %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (asid) : "memory")
+
+#define ALT_SFENCE_VMA_ADDR(addr)					\
 asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ALT_SFENCE_VMA_ADDR_ASID(addr, asid)				\
+asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (addr), "r" (asid) : "memory")
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 317a1811aa51..e529a643be17 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,10 +22,27 @@ static inline void local_flush_tlb_all(void)
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
 }
 
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ASID(asid);
+	else
+		local_flush_tlb_all();
+}
+
 /* Flush one page from local TLB */
 static inline void local_flush_tlb_page(unsigned long addr)
 {
-	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
+	ALT_SFENCE_VMA_ADDR(addr);
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+					     unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
+	else
+		local_flush_tlb_page(addr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 22d7ed5abf8e..0feccb8932d2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -7,29 +7,6 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
-static inline void local_flush_tlb_all_asid(unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma x0, %0"
-				:
-				: "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_all();
-}
-
-static inline void local_flush_tlb_page_asid(unsigned long addr,
-		unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma %0, %1"
-				:
-				: "r" (addr), "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_page(addr);
-}
-
 /*
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
-- 
2.42.0

