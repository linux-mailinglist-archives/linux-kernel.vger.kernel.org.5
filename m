Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B14765BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjG0S6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjG0S6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:58:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1D198A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:58:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso13476795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690484283; x=1691089083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FofimiyN+7gyzGEdPyrBP2skR/4a1H3RZbKcHwnJwCU=;
        b=KnDd+Vx9BzShpCRzLQ631/OTf/QgBq8wCBP80Yw1l/syTWuVZd1mFQHnOFb5n/3cyE
         TukhFMSWwWymirfBGHC3p4wuay/d0DWPZyl+78CJlng2+dz494c+Eglij+K8qqKQf4hv
         4/E+Yc7aIpJ5620zW+lx0o7XJTJtyN+voY8PiGKvUEvR8YD0spKu/4+n762sANqG9nlA
         JGGxpE/z8ULSbOmkC4CA3cHyh0dj8cWRd0GL1Mq0lF97VyP+Af3o43rlpnU8SYmk3Yki
         Pg0JAmuERUhqze5Ri32pwH1Xujl7bJXT0s3JtHSJ6deEL2dq525vEra8wG4vcpq+deNd
         BTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484283; x=1691089083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FofimiyN+7gyzGEdPyrBP2skR/4a1H3RZbKcHwnJwCU=;
        b=LrrU2UNWnUesoxbXqh+qbvt2oFhN4gYsisZIE+Ay2VOit6K+L1Hy+E7m3PaozwwE47
         +NptupivYOVCyid4XeWNhcwrJcoKd+Km9cpAIzZOUezFNU2WSitStsnCq4Iw4NSxMOwf
         k5qAX8UoBowlNY2VODjv+QFw6NddVtOpXP64IgXh4YJzQkQLcomJlOI+0weccsfbG2Lg
         u1DRtzdKFPUFuGX0Wtb9qplr86nervkpDQRuj++P6YtKkn2r1TEqmC41g9mEABXkE41/
         cLTFiP8QlD32mot4sG2+5oALMPDWLIy+V2OgR/TQRGQMPyu7T/kDCqBbgxYQTtZQrnDl
         rITg==
X-Gm-Message-State: ABy/qLZgaRzpovsAw/n4vYz0Q2G77arHSz9M3pqdDJuvdc9vRRPQu3VY
        6G7NQxPLFtXYwA5pEY1jzBNTxQ==
X-Google-Smtp-Source: APBJJlE5yuP6dOyuWEfbshqESX2eaPb5FXyTM6wUkhll2KdkxuRc6Y2JvvBqcbIkk0EYV+e5ssUWbw==
X-Received: by 2002:a05:600c:3652:b0:3fa:934c:8350 with SMTP id y18-20020a05600c365200b003fa934c8350mr2269763wmq.27.1690484283337;
        Thu, 27 Jul 2023 11:58:03 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000050100b003141f96ed36sm2840938wrf.0.2023.07.27.11.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:58:03 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
Date:   Thu, 27 Jul 2023 20:55:51 +0200
Message-Id: <20230727185553.980262-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727185553.980262-1-alexghiti@rivosinc.com>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current form,
when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
whole tlb: so set a stride of the size of the hugetlb mapping in order to
only flush the hugetlb mapping.

Note that THPs are directly handled by flush_pmd_tlb_range().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index fa03289853d8..3e4acef1f6bc 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
+#include <linux/hugetlb.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -147,7 +148,14 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	unsigned long stride_shift;
+
+	stride_shift = is_vm_hugetlb_page(vma) ?
+				huge_page_shift(hstate_vma(vma)) :
+				PAGE_SHIFT;
+
+	__flush_tlb_range(vma->vm_mm,
+			  start, end - start, 1 << stride_shift);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-- 
2.39.2

