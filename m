Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC87EC3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjKON2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343973AbjKON2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:28:22 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6819E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50970c2115eso9545473e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054897; x=1700659697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrVNEt2cc/SjP2EDNi8Ypx4BpRW+YQfrsXMUopTWpaU=;
        b=zprRwOvA48KLn950pgJrHqrGlQt3miOl3BufhUUpa3Iz/8XNOva97WZEFZoPaKAGyI
         aoYlFtcfm/rZDEg/rvpx6aCC5rxE2AyfeW2HnC2y/2wPkr5+VT1UN/wK3v/z4J+Sa1aX
         A4cwgmE3Jw/YtqHu5U/1e7rAVFggFyS19n9SAIDVBAfMctziWLh52DhvnRpCrIvufDKQ
         /UYV/xPt+JwoLfQe+0MzT3W03mBq8GsgDEwdWEHRY9BFwCD24ynJiz8HPfxVDan2iayC
         82w+W1GNye5SGAsp7HpOxVHR8H4XSd+btDDQqgDsPzB7Q49Wm4/qol9F8iAIz7qFQ+vl
         YjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054897; x=1700659697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrVNEt2cc/SjP2EDNi8Ypx4BpRW+YQfrsXMUopTWpaU=;
        b=uhikUuSslqOCQ1UQ6TAMHdNi9Q6iqPFL4yBEDJB+zK/+2l+3AWX7Z7ZfSzF9Ni9CJT
         Y1+pEQWW9U2dmCXfDbqPkbc2O0Ix2GyBU1DJ7C52LG75aasExg67FF/GL4N9gQRtqaXM
         JiChQwh3EcqhY3fKTlZgfaLZ1En640RlQgh77REnaKKTNZ/E2Q9qIaOqBUlVZCaMDHhK
         Eu/LXYJA6nkHZOre/1Hyh/5b3qumk2iiFntAflRbJxDojdeSbnkoOdjYdFgo8McHP1AP
         4yIaBd2HCdT/gUnZJbbEOp1YLygXQkV0gO1PDyAwrsgReEQifL3QoHlaMRhDkKXckuZi
         ffmQ==
X-Gm-Message-State: AOJu0YyXJFgXKeuwHw4bd7xaToAs9hdBp1kFFIwgNv83c/ynV9RATHCh
        iNbMzWpK7z/f5xQGA14aWLvaGQ==
X-Google-Smtp-Source: AGHT+IEZfdzsNM4pOVpdQmBfJck2ud0jjVkPzsGxSYAG5htEb3fgmCm3DK8SVrja4wL8Daoz/Qy5GA==
X-Received: by 2002:a05:6512:4846:b0:507:9702:8e09 with SMTP id ep6-20020a056512484600b0050797028e09mr8331107lfb.2.1700054896889;
        Wed, 15 Nov 2023 05:28:16 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:16 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 14:28:14 +0100
Subject: [PATCH 1/2] ARC: mm: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-virt-to-phy-arch-tree-v1-1-8b61296eae73@linaro.org>
References: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
In-Reply-To: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 

-- 
2.34.1

