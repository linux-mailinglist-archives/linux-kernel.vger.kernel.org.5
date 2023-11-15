Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE37EC3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjKON2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjKON2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:28:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73608A6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so935295e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054898; x=1700659698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27kbaYc9o/j9wTLBAVP45tsETwTbQIy8zKNs3tAOssU=;
        b=aFf3AUw6HACU8INstTlF/4ZpPhEi2toseHhRelR0G9Kohvz1QugxFEBsainSppF+PS
         mhZjZSaHuPt4Y9HIHYbmU8vP42iu6FUPO4K4vXJphrAsSI4p5dQOc5XktMwum5ozpWHV
         4X5fAC5EGNQ2bbAUqhCAHA4ui9AB9pVXQcn3acig9ijKkSzGbnXqmqvP/r+xUsC9yN6U
         POUsAITTRqug1bdnvGtcf1WMz6pHpUCdu1Hzupzzxb/7NZvD2gAbnERgBa3UzwTZlzFJ
         JtWWDQgH2rNiC3cWkfvuYFym/fRJHLsoJXoDjoZAQv1y461T8Pr3zYCwmF/iRq0+pDF3
         ZpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054898; x=1700659698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27kbaYc9o/j9wTLBAVP45tsETwTbQIy8zKNs3tAOssU=;
        b=bczh5N/xPMyMElRKUywnPk+kAYe2HWiR0JUXYfc0iX/KfjU3TMwap0KTeFBjgxnIYf
         FtvQ6qQqZ7qb4Ya9VM3IhRAaRLuyxxcoLLHdgQ0ZHp/SqLVGwIFSlCc5I8TqLdmizqPG
         P44s9gClRRGdCeZ0oqG/Nz5AnnxObXIxWYaG9M2MMyhVfGUYGC/Kj2O6UpuzoTHSMI8n
         Vx5K9XE4KhBT7hB6C5RUXuvm7Zr1DIGxqvy5MhEQbMItTBa1t4hBNjHMQw/QgY7Ks4JF
         qWQQGwcjpIYygpGr4Pt4w9dp4mzvuF3S9DupfL9aRsjLLuacQe1Kx1EMAZ/20bCLE87H
         WPJw==
X-Gm-Message-State: AOJu0Yw8efhClU812aZwB7RkemG1bv/ok6ID5reouqY0/Y71JYbw2Y1P
        iMHyJw+wZ3/vv9mQpwfTw8LPkA==
X-Google-Smtp-Source: AGHT+IF1ifJjaPJepmn4jpc4ZHMqCS1sjn+6cBfSpPYvLaA1BjCWNuLVV5igC58y6bNOjVoqNakptg==
X-Received: by 2002:a05:6512:2248:b0:4fe:4896:b6ab with SMTP id i8-20020a056512224800b004fe4896b6abmr2401582lfu.15.1700054897725;
        Wed, 15 Nov 2023 05:28:17 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 14:28:15 +0100
Subject: [PATCH 2/2] Hexagon: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-virt-to-phy-arch-tree-v1-2-8b61296eae73@linaro.org>
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

For symmetry do the same with pfn_to_virt().

For compiletime resolution of __pa() we need PAGE_OFFSET which
was not available to __pa() and resolved by the preprocessor
wherever __pa() was used. Fix this by explicitly including
<asm/mem-layout.h> where required, following the pattern of the
architectures page.h file.

Acked-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
 

-- 
2.34.1

