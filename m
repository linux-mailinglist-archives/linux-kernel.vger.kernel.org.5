Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A1777156
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjHJH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:27:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629D1702
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:27:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so9725671fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691652426; x=1692257226;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yN9CEShf+RVQzOCyA7HLL5huGCM+loDBl/b3GyqW7cM=;
        b=hAI2zLDeYrFyA9B2O1/1J3hre6J5vK9lgwpDrJrzByfWFjSj3ECeAAiyPUFNQLE6lr
         OqEp6NrSVviNuEkXD49dy0AKhzGZxEM+9TXhkVqWLmv0Oce6NKTxQadC0D9Y6rGJUG4x
         Mnq3yHe8Sn7pGinLvaV8xRK+dgOCgpVuC3gkbDnV5nf9E1tjFh2OdhdHQDcXju1e6JYF
         +T0EgaHRZ4qbq2+0o7/3khE5izxby8zFQluqlvRjgj1Qeq/cZrB21i5+EFmXnVOxzEO5
         mMHoOYhB20nmxGXn1mnfsJvVIvTd6FbceVpHh4VzwANRpsdfTVFJPvF/DvoUmhk2FyND
         XFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691652426; x=1692257226;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN9CEShf+RVQzOCyA7HLL5huGCM+loDBl/b3GyqW7cM=;
        b=aLetMYrBhuRDeqtjdWfC/n2aR0QsR2XY43eX8qTFyKtUQ0XVE5xPfuMXYFG7DZHxYu
         mEAwWPhWzjpDcQc0ljiC9jbis8robTHeSXfq85YPC4z9g6qWJv0YKFDVSEOAN8TJOuHb
         ptNRT6xnGd9sDYxZBby7Y24TdPfeXIqX77LkFYKGC92oqq43dwzAwR/Z8ye04XdTb0ck
         SfzJWpdbHNRCA7q8jSkHZ38LdtOqV+SSCc7G8c208tuQc9RWP48vvuxUkS4hawUIqXPK
         9/CI6ovFU2Gz9i6Hla17aSspRQcK/5KRJdjF69AZlxQGid8U8tQhxCVab/dnT6byR3Rz
         l3mg==
X-Gm-Message-State: AOJu0YygU0p9ObjTjek39JeCJa2Vlnx2VBAPCvFdmTupl5oU56T0gMcA
        Kyj6K/SvUB9RkGG0nBtZVzKR8Q==
X-Google-Smtp-Source: AGHT+IHgd8Hjb+gMYaO0cS0m2RHlxFtCAELWefYhbMJLayBO9cdI/BMW7X3fnqTRhT0IxW6plo9f/A==
X-Received: by 2002:a2e:8559:0:b0:2b7:2db:8ea4 with SMTP id u25-20020a2e8559000000b002b702db8ea4mr1165263ljj.30.1691652425875;
        Thu, 10 Aug 2023 00:27:05 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm233152lji.123.2023.08.10.00.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:27:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:27:04 +0200
Subject: [PATCH] x86/xen: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-virt-to-phys-x86-xen-v1-1-9e966d333e7a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEiR1GQC/x3MQQqAIBBA0avErBswI9OuEi2sppyNhkYY0d2Tl
 m/x/wOJIlOCoXog0sWJgy9o6goWZ/1OyGsxSCFboYXGi+OJZ8DD3QmzVpjJYzP3VhnZdlYaKOk
 RaeP8b8fpfT+XKd7VZgAAAA==
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Also fix all offending call sites to pass a (void *) rather
than an unsigned long. Since virt_to_mfn() is wrapping
virt_to_pfn() this function has become polymorphic as well
so the usage need to be fixed up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/x86/include/asm/xen/page.h |  5 ++++-
 arch/x86/xen/enlighten_pv.c     |  2 +-
 arch/x86/xen/mmu_pv.c           | 12 ++++++------
 arch/x86/xen/setup.c            |  4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index fa9ec20783fa..85e63d58c074 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -295,7 +295,10 @@ static inline unsigned long bfn_to_local_pfn(unsigned long mfn)
 
 /* VIRT <-> MACHINE conversion */
 #define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
-#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
+static inline unsigned long virt_to_pfn(const void *v)
+{
+	return PFN_DOWN(__pa(v));
+}
 #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
 #define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b658248d01..7178976c5dcf 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -523,7 +523,7 @@ static void __init xen_load_gdt_boot(const struct desc_ptr *dtr)
 	BUG_ON(size > PAGE_SIZE);
 	BUG_ON(va & ~PAGE_MASK);
 
-	pfn = virt_to_pfn(va);
+	pfn = virt_to_pfn((void *)va);
 	mfn = pfn_to_mfn(pfn);
 
 	pte = pfn_pte(pfn, PAGE_KERNEL_RO);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index e0a975165de7..c4f20581f6e7 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2202,13 +2202,13 @@ static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
 		mcs = __xen_mc_entry(0);
 
 		if (in_frames)
-			in_frames[i] = virt_to_mfn(vaddr);
+			in_frames[i] = virt_to_mfn((void *)vaddr);
 
 		MULTI_update_va_mapping(mcs.mc, vaddr, VOID_PTE, 0);
-		__set_phys_to_machine(virt_to_pfn(vaddr), INVALID_P2M_ENTRY);
+		__set_phys_to_machine(virt_to_pfn((void *)vaddr), INVALID_P2M_ENTRY);
 
 		if (out_frames)
-			out_frames[i] = virt_to_pfn(vaddr);
+			out_frames[i] = virt_to_pfn((void *)vaddr);
 	}
 	xen_mc_issue(0);
 }
@@ -2250,7 +2250,7 @@ static void xen_remap_exchanged_ptes(unsigned long vaddr, int order,
 		MULTI_update_va_mapping(mcs.mc, vaddr,
 				mfn_pte(mfn, PAGE_KERNEL), flags);
 
-		set_phys_to_machine(virt_to_pfn(vaddr), mfn);
+		set_phys_to_machine(virt_to_pfn((void *)vaddr), mfn);
 	}
 
 	xen_mc_issue(0);
@@ -2327,7 +2327,7 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	xen_zap_pfn_range(vstart, order, in_frames, NULL);
 
 	/* 2. Get a new contiguous memory extent. */
-	out_frame = virt_to_pfn(vstart);
+	out_frame = virt_to_pfn((void *)vstart);
 	success = xen_exchange_memory(1UL << order, 0, in_frames,
 				      1, order, &out_frame,
 				      address_bits);
@@ -2360,7 +2360,7 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
 	/* 1. Find start MFN of contiguous extent. */
-	in_frame = virt_to_mfn(vstart);
+	in_frame = virt_to_mfn((void *)vstart);
 
 	/* 2. Zap current PTEs. */
 	xen_zap_pfn_range(vstart, order, NULL, out_frames);
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8b5cf7bb1f47..50c998b844fb 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -340,7 +340,7 @@ static void __init xen_do_set_identity_and_remap_chunk(
 
 	WARN_ON(size == 0);
 
-	mfn_save = virt_to_mfn(buf);
+	mfn_save = virt_to_mfn((void *)buf);
 
 	for (ident_pfn_iter = start_pfn, remap_pfn_iter = remap_pfn;
 	     ident_pfn_iter < ident_end_pfn;
@@ -503,7 +503,7 @@ void __init xen_remap_memory(void)
 	unsigned long pfn_s = ~0UL;
 	unsigned long len = 0;
 
-	mfn_save = virt_to_mfn(buf);
+	mfn_save = virt_to_mfn((void *)buf);
 
 	while (xen_remap_mfn != INVALID_P2M_ENTRY) {
 		/* Map the remap information */

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-x86-xen-1b7a69235a29

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

