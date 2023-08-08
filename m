Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145937742EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHHRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjHHRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677779EDB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:23:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so3345914a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511764; x=1692116564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLgiueEbzobtzFNNJX0j8sjbY7XP7Xp1Qtkd3nfwoTQ=;
        b=onsVEaUaP10UOYReNFOX0pIw9Z10L/wk/AgW570MTXMwplc4ITtz90qKdJgoxCbEXQ
         WuuHKEwQiMw+SbQX1oE79FH4WGb+7k+j11nYS0wny1XAMNNbH11KC453d23dBszkjq6y
         mNYWHlmUuGyb64iQvw9fj/djB9IBNGMb3TmIMKB6XcbnvJXmqiKMJt5Raxtgfp77dJIK
         rabwFX79CcdYCMu+mLgd24b0CzzedGa6mHuq8U0O8MDKKs3yllmyC2SRzb5czmJkAOMK
         jbIW633o2MV6J7AL+cb7x1ra8TVEtWB2pBRY5VgStLmg/lzq+pEQDPNhAo4Df30Aa7F+
         r80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511764; x=1692116564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLgiueEbzobtzFNNJX0j8sjbY7XP7Xp1Qtkd3nfwoTQ=;
        b=GrCk2qwdstZgk45bCKDqvupxKE8QMlfEeI5iTpTfL1TdNCoYtMjQcH6Y7w0ywbpznD
         J+tvJHY6h547S6Qtr+IB9qmvXbbIpbLjDftDLfqP+RpmWkiUHSUHHm0br/Gy1ido8ciW
         wKe/gRLJsGvsCuhYdzK6aSu6U0O6ycfVhWyWWA3cYlyOyYOc3xVNCZJRiOLD7Pon1Lsp
         +PsuM34bod/TwPTbr9bGeAuU28tOOWJr2ZSiwlwn1aDQ5i9+UP/UAvIwSg/8QeYYKy1X
         ufjWVLmAUVh+G9ClrzUpVBMfaTgojfYxW46x+FDXt/kf2JxcffJjL11pHFYKfXVcX1fq
         NoGw==
X-Gm-Message-State: AOJu0YzR1hy138hKMgcW5ILAs7plbY1dO7gSG8GFPnIM611A2e2C4iXA
        NT3eotXIZv9C+Hb3JTmY5EcV6W4/0YSm3vwYvnY=
X-Google-Smtp-Source: AGHT+IEWQUg1f+i6vP131s3YZltVSNob4tEp+mlNSTLfxjenmEfAb4fXWkyZNoHuGpYubcPeVCW7qw==
X-Received: by 2002:a05:6512:32d1:b0:4fe:c53:1824 with SMTP id f17-20020a05651232d100b004fe0c531824mr7666076lfg.40.1691484059954;
        Tue, 08 Aug 2023 01:40:59 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q15-20020ac2528f000000b004fbab80ecefsm1806634lfm.145.2023.08.08.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:40:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 10:40:58 +0200
Subject: [PATCH] microblaze: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJn/0WQC/x3MTQ5AMBBA4avIrE1SJYKriEXVlElQmYr4ibtrL
 L/Few8EEqYATfKA0MGB/RqRpQnYyawjIQ/RoJXOVaUqPFh23D1u0xVwYSu+n81NWBg3ON1bV5c
 WYr0JOT7/c9u97wf8si/5aQAAAA==
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Move the function down in the file so __pa() exists in our
scope, and it compiles. This in turn requires moving __pa()
as it depends on __virt_to_phys() that was below. (Lazy macro
evaluation conflicts with strict function ordering.)

Make a symmetric change to pfn_to_virt() so we have type
checking both ways.

Due to this the <asm/page.h> file being included into some
assembly files, some further inclusion guards are needed
to make sure assembly keeps compiling.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/microblaze/include/asm/page.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 337f23eabc71..86a4ce07c192 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -99,9 +99,6 @@ extern int page_is_ram(unsigned long pfn);
 # define phys_to_pfn(phys)	(PFN_DOWN(phys))
 # define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
 
-# define virt_to_pfn(vaddr)	(phys_to_pfn((__pa(vaddr))))
-# define pfn_to_virt(pfn)	__va(pfn_to_phys((pfn)))
-
 #  define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
 #  define page_to_virt(page)   __va(page_to_pfn(page) << PAGE_SHIFT)
 #  define page_to_phys(page)     (page_to_pfn(page) << PAGE_SHIFT)
@@ -109,11 +106,6 @@ extern int page_is_ram(unsigned long pfn);
 #  define ARCH_PFN_OFFSET	(memory_start >> PAGE_SHIFT)
 # endif /* __ASSEMBLY__ */
 
-#define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
-
-# define __pa(x)	__virt_to_phys((unsigned long)(x))
-# define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
-
 /* Convert between virtual and physical address for MMU. */
 /* Handle MicroBlaze processor with virtual memory. */
 #define __virt_to_phys(addr) \
@@ -125,6 +117,25 @@ extern int page_is_ram(unsigned long pfn);
 #define tovirt(rd, rs) \
 	addik rd, rs, (CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR)
 
+#ifndef __ASSEMBLY__
+
+# define __pa(x)	__virt_to_phys((unsigned long)(x))
+# define __va(x)	((void *)__phys_to_virt((unsigned long)(x)))
+
+static inline unsigned long virt_to_pfn(const void *vaddr)
+{
+	return phys_to_pfn(__pa(vaddr));
+}
+
+static inline const void *pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn_to_phys((pfn)));
+}
+
+#define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
+
+#endif /* __ASSEMBLY__ */
+
 #define TOPHYS(addr)  __virt_to_phys(addr)
 
 #endif /* __KERNEL__ */

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-microblaze-4afdf2bcf96c

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

