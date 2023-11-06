Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25937E25E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjKFNoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:44:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CFCDB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:44:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507cd62472dso5950702e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699278266; x=1699883066; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfut42GZ6PJsX7RslNyzOoo+yrwpRsBHvP3u/FnXLmg=;
        b=t3B7QSlmEjUv1A8FdwtPvgaD+7A6NsRDq/Z660xex7MQKIAlH5rLndQ1QV5vruG6Y0
         klKrwzuSzEKRUji7Dv7+8yddwCdwN5ScPSDUdPHeTEz8ADG0RWDe79jPEjmiyuYF2Ew4
         eZWjtS0MKBVBVwvI5yUhCsrHBhPkpoXS5rLKv6VW3tJLinfL1h2HERyUCapXkNQCaS5I
         sfFJLhPS83dJdYLFPYXj+Dm8ELXsctNIFeY4ECbuWE+8QH53h0SPATKTdm/VdHFwpK1Q
         cpTiZsmcigHoA4v7WZOnZS1HKG2fT11iYpI9G95WICOsUkT94/KZBBmArQJgN1p8mvsy
         ewOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278266; x=1699883066;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfut42GZ6PJsX7RslNyzOoo+yrwpRsBHvP3u/FnXLmg=;
        b=Z4sEiR/3dPQQ2eX3jiaBPx+xAbgMOAzOwcAXs87Vrnssnd2nfU9N2Y4dCdcXvNiPJ4
         xKNcSFpBm+Mtbx5bwXqI9Zzvb4EMdofrc57zzJAuaJUAeQidYU1Ddk1nTBRAlQrgw1IL
         NS6ce6IJLqeqbY9Xxt2oPcMFQsIkBgQ2nt9Re23rWbQAN4m03EVcbeWkJLgxKNcTzKAu
         E0ca3Ro1KlsiWwIKhfFWMILIYrdQtUb/RtgrDkbUmjYVEXMCKtUsQ9elgamryXpEei+Y
         zba7lGAwyq+7GBHbb7jJDK74IQ4TjXg/QESCPg067vdr0xWaF0ftusOlIIkIgp1m3g5f
         t0qw==
X-Gm-Message-State: AOJu0Yz2kPmiBSKi2GhVtPgP2ZQWteWepeP2FRTj6+RaoFTaRFMdLEBz
        SWcxxvlwR100ii+EvEEQ6qfqpg==
X-Google-Smtp-Source: AGHT+IH4bzAeeYdxryFqi17NUYVW5UsmYhLWSTUCigieIHr7c5swW3uUM3EOV8t/mdnyfou3jNyCSA==
X-Received: by 2002:a19:6505:0:b0:4fe:2815:8ba7 with SMTP id z5-20020a196505000000b004fe28158ba7mr3312316lfb.25.1699278266334;
        Mon, 06 Nov 2023 05:44:26 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004fe2de20d88sm1123959lfe.232.2023.11.06.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:44:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 06 Nov 2023 14:44:25 +0100
Subject: [PATCH] powerpc: Fix signature of pfn_to_kaddr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org>
X-B4-Tracking: v=1; b=H4sIALjtSGUC/x2MQQqAIBAAvxJ7bsG1UOor0SF0q72YaEgg/T3pO
 AwzFTIn4QxzVyFxkSxXaEB9B+7cwsEovjFopQciZbBIuvG+MO4Bd3kwRod+Is+jdUaRhVbGxE3
 912V93w8BGl8jZQAAAA==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a const in the returned value from pfn_to_kaddr()
but there are consumers that want to modify the result
and the generic function pfn_to_virt() in <asm-generic/page.h>
does allow this, so let's relax this requirement and do not
make the returned value const.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311061940.4pBrm44u-lkp@intel.com/
Fixes: 58b6fed89ab0 ("powerpc: Make virt_to_pfn() a static inline")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The remaining warnings from the test robot appear a bit bogus.
If someone knows what to do about them, please help. The warnings
often properly uncovers problems that have been around forever
due to these functions being disguised as macros.
---
 arch/powerpc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e5fcc79b5bfb..5243e48dc13a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -230,7 +230,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 	return __pa(kaddr) >> PAGE_SHIFT;
 }
 
-static inline const void *pfn_to_kaddr(unsigned long pfn)
+static inline void *pfn_to_kaddr(unsigned long pfn)
 {
 	return __va(pfn << PAGE_SHIFT);
 }

---
base-commit: d2f51b3516dade79269ff45eae2a7668ae711b25
change-id: 20231106-virt-to-pfn-fix-ppc-d91de47c6017

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

