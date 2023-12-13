Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289281159E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442093AbjLMPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442073AbjLMPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:04:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA433F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:08 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a22f59c6af8so127625966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702479847; x=1703084647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8FvBMSZ54x5+moiufktQOGQtRVM0b1bbyRye5DtqoI=;
        b=Ib/UlvKK6Cau0gG+R0rRYNdbJJW+k9A0Iq0B+AiYiaXHLxCo3QYBz+SHy0YmO3fBbI
         /hLz2s/sKqKE8BkvrKw/VxLGmF1VQVZZuShOSSwv9Livj3gBqLRDL/kEM0vLBJnXCHZd
         VbDqOOO2FInASowGYT+v3WDtHuM4BEHil8l2c2TaTuRc+2X5HuSc3WZ7PpIUlFvipqXY
         2mSMpwRjA5ocYcISc2JgtdI355Zlr0rJcvETEL+mAAu9NNnjdA01kRtEtyvpYAtLd1d3
         fmncNkMCp4SM2NyMFrPsuzV+shL8zvvUtVVeNNLwp22AycTraUYia1Z2JArigWc6VY+J
         7+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479847; x=1703084647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8FvBMSZ54x5+moiufktQOGQtRVM0b1bbyRye5DtqoI=;
        b=XH6WYO6ZHxH2BDaN+5CB1oUsZry+lE/JpiXqOJrt06sAaS55Oa3pj5NoSGUqy4qAtn
         0e3/+zDQMGutA2sfPPJvvaSApTBk/RdJvr9Cp4rMsnbaEsrrBNUTb8TB7lYHrrIrLWm4
         Z5FbhHWjaEtx5P9896PPXaEEJufy/4hLmTvOc+FAVf8sBL1A8mGCu5Qa89Jt14OLc5ch
         ZZePky8c9kC9DiVNh0oXFIfR4yTZuqiPDG3YooKoszU/re1WOg/8LV7CGQFJs/Zfbhbh
         y9HIOx8NLx0xbGhSuyi8Qpth6uDIv7x4se0Me2ko7n+2RvN3TmWzDNk7gHpKo3WxTH59
         Utyg==
X-Gm-Message-State: AOJu0YxfDMFpydOxBcHV8rCwhL60Ln9PDf1a2ndNQf3nUo6lvQ31LiaS
        977evr1+lSE6lJHCzNTf/WY=
X-Google-Smtp-Source: AGHT+IGK3pxqmERFMcq8dDTHv4KUlc8vKTSgFsfGllzuGdgrF46csMjYoKh8Z7fuAXQw6hv07E1y8w==
X-Received: by 2002:a17:907:2d88:b0:a1e:4794:e3b1 with SMTP id gt8-20020a1709072d8800b00a1e4794e3b1mr5107286ejc.148.1702479846901;
        Wed, 13 Dec 2023 07:04:06 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id hu18-20020a170907a09200b00a1e081369a9sm7849736ejc.23.2023.12.13.07.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:04:06 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradaed.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH RESEND -tip] x86/percpu: Use %RIP-relative address in untagged_addr()
Date:   Wed, 13 Dec 2023 16:03:15 +0100
Message-ID: <20231213150357.5942-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%RIP-relative addresses are nowadays correctly handled in alternative
instructions, so remove misleading comment and improve assembly to
use %RIP-relative address.

Also, explicitly using %gs: prefix will segfault for non-SMP builds.
Use macros from percpu.h which will DTRT with segment prefix register
as far as SMP/non-SMP builds are concerned.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/uaccess_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4469cc..01455c0b070c 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -11,6 +11,7 @@
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
+#include <asm/percpu.h>
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -18,14 +19,10 @@
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	/*
-	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
-	 * in alternative instructions. The relocation gets wrong when gets
-	 * copied to the target place.
-	 */
 	asm (ALTERNATIVE("",
-			 "and %%gs:tlbstate_untag_mask, %[addr]\n\t", X86_FEATURE_LAM)
-	     : [addr] "+r" (addr) : "m" (tlbstate_untag_mask));
+			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr)
+	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
 	return addr;
 }
-- 
2.42.0

