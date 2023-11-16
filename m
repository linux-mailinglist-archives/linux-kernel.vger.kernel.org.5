Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB37EE730
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKPTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKPTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:11:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02CD4E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:11:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d216597f64so165351666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700161898; x=1700766698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwQUpHrldieb9q/f898qx9fwKE9eO/IChKWvTMHwjHs=;
        b=NA5xmWzMRF1SZmLb55xWj52IAqnlpEQ6IfUPLi5kP3PmUG6gI+dHhk8sLXbpkd/Sdb
         PHDrOBGbnSQfMQ+cJCdVZJ2SZZE9P9utsiviAP0J9gwv1J11BDCHoVHnOKacVK72ajDN
         RDMAnu58mCZwv++hegCuP+Uhlkv3vXfBznx0b31KnXsk++Npt4mloxDS9/P4/PUtyGnI
         7Mynwee8CxJV3zt7anCV/OhunnDGlwL4nLk5BtvyxbC658tkwoDMQJvY9Ts9wvJQ3Wow
         lDfENoVPWfIMMjWTaejHxrCSmWqBsjwy+bQ3mzU3fdfqjoxVoMwXX+ZdrWZ6RdKPYUK6
         19fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161898; x=1700766698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwQUpHrldieb9q/f898qx9fwKE9eO/IChKWvTMHwjHs=;
        b=o7Y5qUXITdgK1uHXaaiOKtTiQjFj3SimevrLaIgv1cGVRz7MT3fdGPRuxbMUMuJlGS
         1mVejuWaCTnUs3J/tKCj9szQYWIsqR48zISpWFA+C2KdZ/xQNb4gguR7H9mjGszsWcWM
         UQLoP25W7I1VOOGM5Ee37tBe8/PGAgIMKKjDXkNYqC+sn6GQge5xmECvTSaobTX1fnr+
         qBZEaDsBgGFdhV6ZAVVex8CjLyq9qmDK8nOoDKCXJhv5rSXrPgKn8NaYBuqzkxE9LqdU
         RDF+KwoKjuNbowrORTxARUoRxMsDuahoWsv7lkh9N7+ht4rw3WYoUJhF2yjitHBcqZgP
         jX8A==
X-Gm-Message-State: AOJu0YxvMwZEFaS3mZ0me+6iEisp+122J485A5K9s6idARToUIm0CTsx
        eKKF0z5fhAtmU1uARhxWnMI=
X-Google-Smtp-Source: AGHT+IEvK7D0Kw4B1/sOPq2I/pM/8z3XTEzAcvEYQuswDZlGPwgr+FgEPzQsvOAHISVcpmcSSrz7Lg==
X-Received: by 2002:a17:906:234d:b0:9d3:f436:6809 with SMTP id m13-20020a170906234d00b009d3f4366809mr12531752eja.39.1700161897905;
        Thu, 16 Nov 2023 11:11:37 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id mb24-20020a170906eb1800b00992e14af9c3sm8899951ejb.143.2023.11.16.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:11:37 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
Date:   Thu, 16 Nov 2023 20:10:59 +0100
Message-ID: <20231116191127.3446476-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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
Cc: Peter Zijlstra <peterz@infradead.org>
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
2.41.0

