Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE36760CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjGYI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjGYI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D110F4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE6A614BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197F5C433C8;
        Tue, 25 Jul 2023 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690273604;
        bh=OGBpT5Jt+TmmkL82pizZ3aBV1IMH5vp0zj/wyWC2G3U=;
        h=From:To:Cc:Subject:Date:From;
        b=rQOJ8VWAnuPVoKpTs12J5i9WSPPfURp6VB/BAT8Z5Y04R6DDCQXM4KTVL2zuqZ2iv
         3hwMtLJpNHDxSZsgVBPLMFvucAziXEvfUsHyUFv76S/D6bSf20jCuf3efJEQ6Kj5xc
         E9cxNIn3W2nP+pCm93lWslxX1QQ01bMiA7CRpimPTQvnSQCsJAFszDHONjZPhol4CD
         1E8wLD3zcfy55HgOSg0CbjrW0p5Yhon8gs8AY/1FJSaiwhMfpmz148qwYTozzb6xRO
         jd2ttx5rGdHoiv9j6XRKGjafC8mT0Upwh336792vH8sDO4N+XL0z6OxAUFamSmME2f
         FRXYVQKrX8FXQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix amd_check_microcode() declaration
Date:   Tue, 25 Jul 2023 10:26:13 +0200
Message-Id: <20230725082638.956675-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added amd_check_microcode() function has two conflicting definitions
if CONFIG_CPU_SUP_AMD is enabled and CONFIG_MICROCODE_AMD is disabled. Since
the header with the stub definition is not included in cpu/amd.c, this only
causes a -Wmissing-prototype warning with W=1

arch/x86/kernel/cpu/amd.c:1289:6: error: no previous prototype for 'amd_check_microcode' [-Werror=missing-prototypes]

Adding the missing #include shows the other problem:

arch/x86/kernel/cpu/amd.c:1290:6: error: redefinition of 'amd_check_microcode'
arch/x86/include/asm/microcode_amd.h:58:20: note: previous definition of 'amd_check_microcode' with type 'void(void)'

Change the stub function to use the matching #ifdef check for the amd cpu
support instead of the microcode and include the header to avoid both and
make it behave consistently.

Fixes: 522b1d69219d8 ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/microcode_amd.h | 7 ++++++-
 arch/x86/kernel/cpu/amd.c            | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 9675c621c1ca4..6a860d40b0411 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -48,13 +48,18 @@ extern void __init load_ucode_amd_bsp(unsigned int family);
 extern void load_ucode_amd_ap(unsigned int family);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
-extern void amd_check_microcode(void);
 #else
 static inline void __init load_ucode_amd_bsp(unsigned int family) {}
 static inline void load_ucode_amd_ap(unsigned int family) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) {}
+#endif
+
+#ifdef CONFIG_CPU_SUP_AMD
+extern void amd_check_microcode(void);
+#else
 static inline void amd_check_microcode(void) {}
 #endif
+
 #endif /* _ASM_X86_MICROCODE_AMD_H */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 26ad7ca423e7c..24596e3c106b7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -15,6 +15,7 @@
 #include <asm/cpu.h>
 #include <asm/spec-ctrl.h>
 #include <asm/smp.h>
+#include <asm/microcode_amd.h>
 #include <asm/numa.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
-- 
2.39.2

