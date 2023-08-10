Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C47771B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjHJHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjHJHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:41:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF92133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:41:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so2049316e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653308; x=1692258108;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9JjIvfMur6gn/jWCq4DFu7qCLyJ7WcwWmX8GtDsRIk=;
        b=mVOiEl7ELLi0lMnbWmVoEtSc+/Nc8urH4vO/fjVk5P5kluFBUqfORnQ6tNomAN6xPf
         1uOeQ45UZoVz7xEMCnf6xpKxHW857zRgpAAGF8fUU4cegvRl02KAXC7fnYAxXs+8QKv7
         uekN53HY7boQLgm6PxHtYeOVgXnsuDCpaE7yw2cmwHXq1lRgvgLlcu/4rhURpkX98eZs
         GWll0RG+j3cs/BZ6B83RoT9nqZkFZwSQ/buuGPzqGWbxf9xhEzCPUlE9apu7ASYaOTuW
         9/8m+rf/5+AmQ3sS8JIwlJXTP4gGVFxnykGyLhkRswah9TVMywT4/DGigZI0scxdOOIv
         KXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653308; x=1692258108;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9JjIvfMur6gn/jWCq4DFu7qCLyJ7WcwWmX8GtDsRIk=;
        b=AJDNlRdIQEIExCW22JdWc+lLyJn9p8OhKW1RzchgUd8FpKKb9sfc4cEe2Uz62sM+Nw
         6A/wQkLT3oXeWXOzN+7bS5KgVpYZGkyRigl/suK8WnNm6mKtqdMSs5za3j518VN0fAF1
         H1g7p0ouze35cVU2Bxfxc8SGfkvDZ9CPjx7/sp+WF5YNjk531ODIvPYf5JflrxdvAuxs
         LJ8GrPbAWKYE+u9j+ssrNTyHRURP/m2UPLONNIj6W646B/mJSc3gCnb0WQTKl+I2kweT
         flinC9TrUY2P+F+RtB8riGm9c8dSmBB8X1uvOaGfT58I9f/9AoSvf7B6xf/yZPy3SoyK
         osNA==
X-Gm-Message-State: AOJu0Yy/yiVCftaBCcXBIanRo0Un6a1Y8AaCsTRR4dkNepsID6Wl1aPp
        540tfAuXGm8dulsLoOO9xdgzTA==
X-Google-Smtp-Source: AGHT+IEXFUzt8xv0bTXWTh/3cld7EI1U7jsx3PSiXA01MTQeoXmY3rzinuFPRtOg2o3qhcutqPQIvA==
X-Received: by 2002:a05:6512:a94:b0:4fe:d15:e1d2 with SMTP id m20-20020a0565120a9400b004fe0d15e1d2mr598521lfu.12.1691653308150;
        Thu, 10 Aug 2023 00:41:48 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id k22-20020ac24576000000b004fe8424c750sm182087lfm.47.2023.08.10.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:41:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:41:47 +0200
Subject: [PATCH v2] Hexagon: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-hexagon-virt-to-pfn-v2-1-ec8b4152f9fe@linaro.org>
X-B4-Tracking: v=1; b=H4sIALqU1GQC/32NQQqDMBBFryKz7pQkNY105T2Ki1QTHSiJTEKwi
 Hdv6gG6fA/++zskx+QSPJod2BVKFEMFdWlgXGyYHdJUGZRQN9GJDhe32TkGLMQZc8TVB2y1eU1
 aWm3aFupyZedpO6vPofJCKUf+nCdF/uz/XpEo8d5NwoxKSS9N/6ZgOV4jzzAcx/EFWDlYh7cAA
 AA=
To:     Brian Cain <bcain@quicinc.com>
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
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

For symmetry do the same with pfn_to_virt().

For compiletime resolution of __pa() we need PAGE_OFFSET which
was not available to __pa() and resolved by the preprocessor
wherever __pa() was used. Fix this by explicitly including
<asm/mem-layout.h> where required, following the pattern of the
architectures page.h file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Use more elaborate casting back to unsigned long before shifting
  in pfn_to_virt and back to void * after that.
- Link to v1: https://lore.kernel.org/r/20230808-hexagon-virt-to-pfn-v1-1-68d07c221f17@linaro.org
---
 arch/hexagon/include/asm/page.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 9c03b9965f07..10f1bc07423c 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -78,6 +78,9 @@ typedef struct page *pgtable_t;
 #define __pgd(x)       ((pgd_t) { (x) })
 #define __pgprot(x)    ((pgprot_t) { (x) })
 
+/* Needed for PAGE_OFFSET used in the macro right below */
+#include <asm/mem-layout.h>
+
 /*
  * We need a __pa and a __va routine for kernel space.
  * MIPS says they're only used during mem_init.
@@ -125,8 +128,16 @@ static inline void clear_page(void *page)
  */
 #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
+
 
 #define page_to_virt(page)	__va(page_to_phys(page))
 

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-hexagon-virt-to-pfn-457bd51a5744

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

