Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3179E6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbjIML2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbjIML2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:28:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A41BC2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:28:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501eec0a373so10961242e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694604521; x=1695209321; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbyHNNsN+Rn8ywOWxCv7Wlqb7uh+vWNRuvfamsm2vmc=;
        b=somuFy2nBKLNXqD6nDqNDRMxknIZMZnCRmH97Z6Y+b94Vi3ZOS9VJJYc8sX0WUt7Fo
         P0fNdCCWH9SnZCosdaiIBGrtDzzWtJZ1cVqxVhS1TxjtX/+dvtjp/8fc9swnFFYgn+AM
         Ke2x8gTJyDuAQMWpgUR9Kcvx4qrkdIkOHw9ZhJZDt1ruZnH+CPl7ALwSYOwOqizKDX1U
         UDZC4zM6Zg8cD5Sg5/AvPT0JhGhrAEthHDEircOvGfarAR8njzhg1OqE11j2oJcJjQoz
         7lLxCEt6TpRbDwz53/yytdE7qDSWw7VW6AOdiQItce4o5hsc5zBJLIaXnTZxH30tRqMw
         wlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604521; x=1695209321;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbyHNNsN+Rn8ywOWxCv7Wlqb7uh+vWNRuvfamsm2vmc=;
        b=f3vyoQNvF2E9YBiL3L08OH7PWR0CKUca/5xPkfm286ITcoW2GG4rcut5sulJrTiIZM
         RM06VnVFi1MN/Ghgwaed63+D6jesY1WYcM1Im9KAcukY4H4aj3RSiEtKKOGIMkINFCsV
         7zPo9h2hapJNhW4RPdCSxkMCDgziX/nXW20oUf7TEeW+Zvu1ZZENE4R5mwSE9UXxO4Bg
         eCFbzf0U4cFdT/tmu4NEKZMOUOBeAAUfm9T7MuBiQvslxhvhCLh25amMBW7KR++xdlhT
         cz/FufIH6/nRSaN8FwEe4c41+BtaOnNTW7Rv8CexccFCkAllw4hJTzefpMKrTJqsVaYi
         RA+Q==
X-Gm-Message-State: AOJu0Yz2etsouz+z30fwBPr+mhvv8qYHlEtkHkxJ8IY/qRcmxS1D4+yR
        QfIVZuZT+E1G+mNYpCezj8dgfQ==
X-Google-Smtp-Source: AGHT+IEWzSbscHddEez7dfee8IC7DxsyXluEAi0zBYnoJvAzxGs+uOEgBAt0asfF+mPbJrJBTdqqOw==
X-Received: by 2002:ac2:510f:0:b0:500:c765:bbe with SMTP id q15-20020ac2510f000000b00500c7650bbemr1778015lfb.0.1694604520898;
        Wed, 13 Sep 2023 04:28:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25931000000b004ff8f448343sm2082639lfi.33.2023.09.13.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:28:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 13:28:35 +0200
Subject: [PATCH v3] Hexagon: Make pfn accessors statics inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-hexagon-virt-to-pfn-v3-1-8bed34005011@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOKcAWUC/33NTQrCMBCG4atI1o4kaWKiK+8hLvozaQckKUkJl
 dK7m3alIC7fD+aZhSWMhIldDwuLmClR8CWq44G1Q+17BOpKM8llxS23MOBc98FDpjjBFGB0HpQ
 2TadFrY1SrFyOER3Nu3p/lB4oTSG+9idZbOt/LwsQcLYdN62Uwglze5KvYziF2LMNzPIDEfw3I
 guCrW2U0NJdHH4h67q+AZrjTkn8AAAA
To:     Brian Cain <bcain@quicinc.com>
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
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

For symmetry do the same with pfn_to_virt().

For compiletime resolution of __pa() we need PAGE_OFFSET which
was not available to __pa() and resolved by the preprocessor
wherever __pa() was used. Fix this by explicitly including
<asm/mem-layout.h> where required, following the pattern of the
architectures page.h file.

Acked-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Rebase on kernel v6.6-rc1
- Link to v2: https://lore.kernel.org/r/20230810-hexagon-virt-to-pfn-v2-1-ec8b4152f9fe@linaro.org

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
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230808-hexagon-virt-to-pfn-457bd51a5744

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

