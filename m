Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E457787C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjHKHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:01:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E7726AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:01:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so2512248e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691737280; x=1692342080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fT3TYzmdwJ/MNgNgMofzXAXGmEmUnvc3SrKF/6LK3Sg=;
        b=KG09fJfDwl4FKObmon//fY9/heOSsiu21jbnUoYY6QFoUad0Bd1jUoaK4uNnaRP8Z4
         6shu8rwFbJ9vLkl/nZglQqfBhBwuGdXKgteClW5laXHzy1htRYPFDswDnSlu6ZnuE7wQ
         szegPHRyk0lnaEf2pe86kixPQBEPfFD7XFlL+AV9L+VeJDp9G2cTmEaqd6sdcZJYLMzE
         PrDAZcBQgPV/JtcNaG8u7OiMfzJlrVCD+eUe9I4UNlQdUqEAIeLXWZPlY3zZ/3MXNZE1
         vpz4TbU4D8rq9P3vyVNwVPtf3pvGDGgKv/hSqIITlL3oDWIl4h1vRInMDb54EhEqESxd
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691737280; x=1692342080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT3TYzmdwJ/MNgNgMofzXAXGmEmUnvc3SrKF/6LK3Sg=;
        b=N4hATYzOmDqvIrM7J7CZ1G+1ewRvwTyS2azBzZC6uk3UVoNa5bvwkTGccM5KweMewH
         7+a0af4yz6EvFX+hfE/KOOkm5LMXlksMn0ejRzxCQHXfyYMx+/8d68a+9AwR12Iykm5r
         7oewlPmX1cxHUFnQuUDJc7GiGGdYI1tzDfYKzwgZdvVDpYSw7W86zaF9euzSm9R62mHc
         pCBn0lR2pu9Q+UNy9rFRir9mpy72aNTbqCgqqZYV0Vsh92QoNFzP0tkxZWPrUHzJNMk/
         kaqIaMjgRwPdZ3oRVHZMNA/IDvKU02uy3wsbkKzHsxM26Oirj94NBpK4mLXGhUIvHinx
         UPCw==
X-Gm-Message-State: AOJu0YzDzK3xv8aCns6byYl+EkZAtDVdQ8otpKpuY7yA4sDeWOX+U3VJ
        Bn0CTeW3M6CPJbhf8kY7tq/jEQ92BM3oT3nSWqE=
X-Google-Smtp-Source: AGHT+IEUaN9Uoy0PII7ue903OgzzuYzeK84I+mmN6Le87uECEtsFQNd73YetAOwr9dRyXW8fA0jQ5g==
X-Received: by 2002:a05:6512:2011:b0:4fb:987b:ec3c with SMTP id a17-20020a056512201100b004fb987bec3cmr581223lfb.56.1691737280573;
        Fri, 11 Aug 2023 00:01:20 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004fbc82dd1a5sm610463lfn.13.2023.08.11.00.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:01:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 09:01:17 +0200
Subject: [PATCH v2] openrisc: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-virt-to-phys-openrisc-v2-1-3500d015bcc0@linaro.org>
X-B4-Tracking: v=1; b=H4sIALzc1WQC/4WNQQrCMBBFr1Jm7cgkRQmuvId0EeOkHZCkTEqwl
 N7d2Au4fA/++xsUVuECt24D5SpFcmpgTx2EyaeRUV6NwZLtyZHDKrrgknGe1oJ55qRSAroY6RJ
 s33uO0LazcpTP0X0MjScpS9b1uKnmZ/8Vq0GDTxvMNUQi8u7+luQ1n7OOMOz7/gX8L4gBuwAAA
 A==
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

For symmetry, do the same with pfn_to_virt().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Cast around a bit in the pfn_to_virt() function so we don't
  get pointer violation complaints.
- Link to v1: https://lore.kernel.org/r/20230808-virt-to-phys-openrisc-v1-1-b2c16cf000a8@linaro.org
---
 arch/openrisc/include/asm/page.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 52b0d7e76446..44fc1fd56717 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -72,8 +72,15 @@ typedef struct page *pgtable_t;
 #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
 #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
 
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-openrisc-8ff05c233aef

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

