Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16F774B7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjHHUsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjHHUsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:48:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C741239
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:40:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9a828c920so90575501fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512855; x=1692117655;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uTsNkzMlGNumI6E4N2sbj8WhFeiKobXXpi0Tum0hp4=;
        b=KB5LRjMqcPqagKTu+LyjFpj0i0umv/vJuab8H42NAsC6tfPj69xReExd40/CAbv2cb
         c3wK/97cCWrjbAFDoM83aY1GjyXZVh0uU9OT3qpPAebjFSjgV9/qLpMKVWx8PxvgQg43
         IPjmmHbr6Rjs7Rp1WMZRjOyn8rlaZHidj+T7SldMO2R82pAK2yADo/OIq1d55qLAmuyt
         bZiSEPf6VHoyypGkxubZ6/j/Cq48J+934FrWl9UJy1x+zquLguQhqhxTHecre2yLDUr2
         dsVRGuKbB/iwDBbRGi5tCeV8hhxPwRZvpQ4pT0FT0ceRl1HvnaP2/CcT8BDMvaP8AhTB
         nKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512855; x=1692117655;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uTsNkzMlGNumI6E4N2sbj8WhFeiKobXXpi0Tum0hp4=;
        b=L7pAJqCgV/UEh9EtMywWWZClwMIZJZyp/4FKEPhSBX2Nq4Wdgm/pP7HUReW+Oi6r8M
         YfBcludEXaChlizMPgGqR6HD9wslasrLi3xBnRQiRkpLCxxQkFFkvw0ti4uoYXIvciZC
         N1IO/DMPg11GK4RBz6imMiQ0+Qj2DBzfDn5TBkJZPpzn8lIL+F7poeW6QDGhKkYKspia
         wIYncjsc15T+Z2OUKO4mzdcF5HoPdxeVNn/1GXg1wKEklDd642oaLZ22d4s15dR4+pkT
         9MiF7XQEbWuphxTvmRjtZgxrJHkjPB4acIrWm93dCsTgbX/oZCoQoFiVcH4d4HCtX/np
         uXqw==
X-Gm-Message-State: AOJu0YwAjs4KslFZXJrXihUAM/FlPAQVX/Ugd/zQCFQ/tbKPYPQHTjkG
        hvWy4NSOJDQgx0UUFRpXtFW8dmC24mOCgR4b5pk=
X-Google-Smtp-Source: AGHT+IES5amA4SDlpCkbvTEDM6S0+rLZht3qutP1HCZ45dXQD1IYG/yvCBi5SrhtOxK+41I3d98chg==
X-Received: by 2002:a2e:805a:0:b0:2b9:ee3e:240b with SMTP id p26-20020a2e805a000000b002b9ee3e240bmr9312875ljg.41.1691487151244;
        Tue, 08 Aug 2023 02:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b22-20020a2e9896000000b002b9f0b25ff6sm2196530ljj.4.2023.08.08.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:32:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 11:32:30 +0200
Subject: [PATCH] openrisc: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-virt-to-phys-openrisc-v1-1-b2c16cf000a8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK0L0mQC/x3MMQqAMAxA0atIZgO1RSheRRykppqlLYmIIr27x
 fEN/7+gJEwKU/eC0MXKOTUMfQfhWNNOyFszWGOd8cbjxXLimbEcj2IulIQ1oI/RjME6t1KE1ha
 hyPf/nZdaPyHMl5RnAAAA
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
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

For symmetry, do the same with pfn_to_virt().

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/openrisc/include/asm/page.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 52b0d7e76446..bb044c4aa93b 100644
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
+	return __va(pfn) << PAGE_SHIFT;
+}
 
 #define virt_to_page(addr) \
 	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-virt-to-phys-openrisc-8ff05c233aef

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

