Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA477A0BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHLPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHLPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:13:03 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726651FED
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:12:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703a0453fso43434921fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691853176; x=1692457976;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ws6iiiqipdTFS/mQpEmQJn0yYytb6SIvgYMxTasFi7k=;
        b=yEzXdnmaawhbn7lg9CMqwiIrci5pKGz7/T+iFi32rSQLSWxL+OeUVLazjyKOPBALSc
         MZFE3bp1wY70/CsBefhyJxqN6UOXIX/9DkS6QYKhaOrbCxRno5Nicvx+C1z3Tb8KPG+b
         SqCy7oUYe//aHx+SFfeOG9pZ9nzG9n7aJQs34hTsnzEI5qT0od7Ht0Uz+sWrRfsNEvnH
         Y09Mr4erBVDtHcQZPmUpYIkBjDxyXMope6kYjBtkcr1qTPUkjSFWr2upINaN172dNON5
         wb2bHz8a2IlO05pMo7QFzyu3twqrkpZN0WlA833+5+LLHnGkqZTVnKYt7awow6PJG0T7
         7AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853176; x=1692457976;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws6iiiqipdTFS/mQpEmQJn0yYytb6SIvgYMxTasFi7k=;
        b=Mc5PKD0OLIabvv8dS2eo6s3NJc6EB4WvMnUvaijgDZZ5BAqymYuSf75L/96pq1QpqC
         KjzvHvQeV67b4zObktxdbOmr++dCCsKOHupH3QV4HIiZIFz0mCCh5QaVStzy21GqLrw0
         RSkwC6M+T4Sa3gZwyqDvviQl58UOLUgFS6ytb7zIdkmn/fzUZF2O7UFjPSasVpwd/Tcp
         dom7Y/g7bdoxEf/Z+HRVnqrZPmOD82RAAvkcTMbrtM5lbymE75tf6MVU88c3k9xwHkyL
         YjzpKr7DpF5f0cX5vncGTcI7mTzwxFhc2MxVr33dy4D2d8dFKxahdP31ni/ckT908wci
         4+cA==
X-Gm-Message-State: AOJu0YznoxqCoYY4xueQBeewdBaiBWMcdiBVpvisIEAxVlKLYBusAjJ4
        dCZ5gVCitL4WN4Tdpfk2Y+5ZbrKN1x+Fzuruiac=
X-Google-Smtp-Source: AGHT+IFYq+X3g/jM4r8YgME91e7lC8uS36s+T11mW56eJqosjwlflQR/AHnV+WWBJQ6rc+rfuGEoOA==
X-Received: by 2002:a2e:a0c7:0:b0:2b6:9bd3:840e with SMTP id f7-20020a2ea0c7000000b002b69bd3840emr4034308ljm.21.1691853175653;
        Sat, 12 Aug 2023 08:12:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e86cf000000b002b9b90474c7sm1396506ljj.129.2023.08.12.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Aug 2023 17:12:54 +0200
Subject: [PATCH v2] s390/mm: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230812-virt-to-phys-s390-v2-1-6c40f31fe36f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHWh12QC/22NywqDMBBFf0Vm3Sl51BC76n8UFzFGHShGJhIq4
 r83lS67PAfuuTukwBQS3KsdOGRKFOcC6lKBn9w8BqS+MCihtLCiwUy84hpxmbaESTcC1eB0r21
 nbV1D2S0cBnqfzWdbeKK0Rt7Oiyy/9leT8k8tS5TYGSNvynjX+P7xotlxvEYeoT2O4wNh4g99s
 wAAAA==
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

For symmetry do the same with pfn_to_virt() reflecting the
current layout in asm-generic/page.h.

Doing this reveals a number of offenders in the arch code and
the S390-specific drivers, so just bite the bullet and fix up
all of those as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Just drop the cast to (unsigned long) in drivers/s390/char/vmcp.c,
  we do not need to cast to (void *) from (char *), a pointer is
  a pointer.
- Link to v1: https://lore.kernel.org/r/20230811-virt-to-phys-s390-v1-1-b661426ca9cd@linaro.org
---
 arch/s390/include/asm/kfence.h |  2 +-
 arch/s390/include/asm/page.h   | 12 ++++++++++--
 arch/s390/mm/cmm.c             |  2 +-
 arch/s390/mm/vmem.c            |  2 +-
 drivers/s390/block/scm_blk.c   |  2 +-
 drivers/s390/char/vmcp.c       |  2 +-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
index d55ba878378b..e47fd8cbe701 100644
--- a/arch/s390/include/asm/kfence.h
+++ b/arch/s390/include/asm/kfence.h
@@ -35,7 +35,7 @@ static __always_inline void kfence_split_mapping(void)
 
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
-	__kernel_map_pages(virt_to_page(addr), 1, !protect);
+	__kernel_map_pages(virt_to_page((void *)addr), 1, !protect);
 	return true;
 }
 
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index a9c138fcd2ad..cfec0743314e 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -191,8 +191,16 @@ int arch_make_page_accessible(struct page *page);
 #define phys_to_page(phys)	pfn_to_page(phys_to_pfn(phys))
 #define page_to_phys(page)	pfn_to_phys(page_to_pfn(page))
 
-#define pfn_to_virt(pfn)	__va(pfn_to_phys(pfn))
-#define virt_to_pfn(kaddr)	(phys_to_pfn(__pa(kaddr)))
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn_to_phys(pfn));
+}
+
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return phys_to_pfn(__pa(kaddr));
+}
+
 #define pfn_to_kaddr(pfn)	pfn_to_virt(pfn)
 
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 5300c6867d5e..f47515313226 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -90,7 +90,7 @@ static long cmm_alloc_pages(long nr, long *counter,
 			} else
 				free_page((unsigned long) npa);
 		}
-		diag10_range(virt_to_pfn(addr), 1);
+		diag10_range(virt_to_pfn((void *)addr), 1);
 		pa->pages[pa->index++] = addr;
 		(*counter)++;
 		spin_unlock(&cmm_lock);
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b26649233d12..30cd6e1be10d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -36,7 +36,7 @@ static void vmem_free_pages(unsigned long addr, int order)
 {
 	/* We don't expect boot memory to be removed ever. */
 	if (!slab_is_available() ||
-	    WARN_ON_ONCE(PageReserved(virt_to_page(addr))))
+	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
 		return;
 	free_pages(addr, order);
 }
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 0c1df1d5f1ac..3a9cc8a4a230 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -134,7 +134,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
-			mempool_free(virt_to_page(aidaw), aidaw_pool);
+			mempool_free(virt_to_page((void *)aidaw), aidaw_pool);
 	}
 
 	spin_lock_irqsave(&list_lock, flags);
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 4cebfaaa22b4..eb0520a9d4af 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -89,7 +89,7 @@ static void vmcp_response_free(struct vmcp_session *session)
 	order = get_order(session->bufsize);
 	nr_pages = ALIGN(session->bufsize, PAGE_SIZE) >> PAGE_SHIFT;
 	if (session->cma_alloc) {
-		page = virt_to_page((unsigned long)session->response);
+		page = virt_to_page(session->response);
 		cma_release(vmcp_cma, page, nr_pages);
 		session->cma_alloc = 0;
 	} else {

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230809-virt-to-phys-s390-2fa3d38b8855

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

