Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7547579FC05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjINGcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbjINGb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:31:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE76BCF1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:31:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501bd7711e8so936695e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694673097; x=1695277897; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9y3W4w8Vrvb3itSQ1aZxY0flcAM2wszFYoNzBZyBoc=;
        b=HNlHriWIC+fTrXsbXmor1+yeLntBpO6AvNlKd1bszG63N1+7p2+d/ZFTXK01sBwADx
         G+R7ZNEEligoRZmEVYDzoriL6dWYFOXWcTdWDeZNXII8FUiSgUKLCPred62GIriQ+k6L
         0El1xHHKbT564UCp9+cCow5/fNOsL+TSfz37rng211mDLapV3gh0bF8lOqUJJ1e1f3tm
         mk9YUHVV7BR9TBnCY+kSs/BQSe+GsF9RPiZ909Iw4wk2hhM7neGjWjwxQQrAiOX/5SUC
         emJTi54pY3XqhqJ9EHpLgGUXg2ehfoOkDkoklGAgL2z7TNQgmyCpnt3/IpB+yKAYgwVh
         Os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673097; x=1695277897;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9y3W4w8Vrvb3itSQ1aZxY0flcAM2wszFYoNzBZyBoc=;
        b=USluBVJzSpY/1rUKpDX0e9yGp2EjjBrhWlz8PxazLxA2CAOtMvnLYF0UxthZy68lc4
         bpxOwzdFfhf9newQnjtgF1tOU2X8VQGe+4gzTH47sOPg3OhqI+GCvCdzvaLWhXoyzkNv
         S9FRnzgUQnnKdwukgvMeJxo/VqTyDRx5jo4lx89ppoy4wxF5NI4Hw6pojJXT4TH0mfUW
         c5sPh0IvwmZ4insT/LtkQj7v4oM9S8DkJPUcDMi+xKJoLZGp1jx4mRnN3hp3FgKJj0n8
         BIy7x9XaPMr8ZCvzVj1i6cnibJjqdi/qUqFfAQ2LXT11JUEbu59umGAKh91rj2WdMgLi
         2lew==
X-Gm-Message-State: AOJu0YxnQiWTyGxtm6lRi3+352YrzLAJaeXVxQ/ha0soGHBYlxcBawU5
        cnHVLIezMWIYC+Hj+fWc6G2H/EAxsYhvSH+DS1Y=
X-Google-Smtp-Source: AGHT+IEZbGELgFj+ivRiRQ+TIEYto5EpOmtl+6TCMIpbdj0vBdu2MWWww5vUgZ71rmW/zJdr3albrg==
X-Received: by 2002:a05:6512:2311:b0:500:7cab:efc3 with SMTP id o17-20020a056512231100b005007cabefc3mr4731734lfu.11.1694673096532;
        Wed, 13 Sep 2023 23:31:36 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512021a00b004ffad0ec2d5sm145003lfo.111.2023.09.13.23.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:31:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 08:31:35 +0200
Subject: [PATCH] ARC: mm: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-virt-to-phys-arc-v1-1-9dc0008dc0b0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMaoAmUC/x3MQQqAIBBA0avErBvQBMmuEi3SppxNxRhRiHdPW
 r7F/xkSCVOCockgdHPiY6/QbQMhzvtGyEs1dKozymmDN8uF14FnfBPOEtArb7UJtndeQc1OoZW
 ffzlOpXwV57JzYgAAAA==
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

In order to do this we move the virt_to_phys() and
below the definition of the __pa() and __va() macros so it
compiles. The macro version was also able to do recursive
symbol resolution.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/include/asm/page.h           | 21 ++++++++++++---------
 arch/arc/include/asm/pgtable-levels.h |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index 02b53ad811fb..def0dfb95b43 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -84,15 +84,6 @@ typedef struct {
 
 typedef struct page *pgtable_t;
 
-/*
- * Use virt_to_pfn with caution:
- * If used in pte or paddr related macros, it could cause truncation
- * in PAE40 builds
- * As a rule of thumb, only use it in helpers starting with virt_
- * You have been warned !
- */
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-
 /*
  * When HIGHMEM is enabled we have holes in the memory map so we need
  * pfn_valid() that takes into account the actual extents of the physical
@@ -122,6 +113,18 @@ extern int pfn_valid(unsigned long pfn);
 #define __pa(vaddr)  		((unsigned long)(vaddr))
 #define __va(paddr)  		((void *)((unsigned long)(paddr)))
 
+/*
+ * Use virt_to_pfn with caution:
+ * If used in pte or paddr related macros, it could cause truncation
+ * in PAE40 builds
+ * As a rule of thumb, only use it in helpers starting with virt_
+ * You have been warned !
+ */
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define virt_addr_valid(kaddr)  pfn_valid(virt_to_pfn(kaddr))
 
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index fc417c75c24d..86e148226463 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -159,7 +159,7 @@
 #define pmd_clear(xp)		do { pmd_val(*(xp)) = 0; } while (0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
 #define pmd_pfn(pmd)		((pmd_val(pmd) & PAGE_MASK) >> PAGE_SHIFT)
-#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
+#define pmd_page(pmd)		virt_to_page((void *)pmd_page_vaddr(pmd))
 #define set_pmd(pmdp, pmd)	(*(pmdp) = pmd)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page(pmd))
 

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230913-virt-to-phys-arc-b0b613c689b0

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

