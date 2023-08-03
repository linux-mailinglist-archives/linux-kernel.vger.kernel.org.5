Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1276E319
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjHCI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjHCI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758CA3AA6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C6D61CC3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95F4C433C8;
        Thu,  3 Aug 2023 08:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051187;
        bh=b22i5cpRysAWrYuPGapjjvgN3RpBjJ402hZ7Cjh+W4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Axcri0FcevtjIyWyFRy1a5qFFZrd6vzwOCz7Z/ps+RSYFEkk6uR+HwBgl3iUiEN8m
         kSDnYyucz2WNCaq5yd7QWY2BugIJ2A5r4gURnx7g2gITpghL/758+eLqNcYA5EppB2
         zGVOjJLJ+kbGE/l57DBHLxXIBkjzgyTMFTojw5OfPP9rVcO1ZvsTCsl7XlDH1qfe3E
         jnps5jXNojeeD71yRcULYbtdX4lqcvUDpPaWcM0dgRpUEtM7422mPg86xa45S+Hsl1
         CPNt/abaVBEE2yyD0/3j6HaLs4HSI7JWpRa6Vc0ORhT5OMW6gC/jYK4sWTPKMYphSR
         441cjFyFx48yg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/7] x86: Fix amd_check_microcode() declaration
Date:   Thu,  3 Aug 2023 10:26:13 +0200
Message-Id: <20230803082619.1369127-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803082619.1369127-1-arnd@kernel.org>
References: <20230803082619.1369127-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Move the declaration into a more appropriate header that is already included,
with the #ifdef check changed to match the definition's.

Fixes: 522b1d69219d8 ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/microcode_amd.h | 3 +--
 arch/x86/include/asm/processor.h     | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index a9b3f9635727e..81d3294b2b5e2 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -47,12 +47,11 @@ struct microcode_amd {
 extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
-extern void amd_check_microcode(void);
 #else
 static inline void load_ucode_amd_early(unsigned int cpuid_1_eax) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) {}
-static inline void amd_check_microcode(void) {}
 #endif
+
 #endif /* _ASM_X86_MICROCODE_AMD_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d46300e94f853..36d52075fdade 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -682,9 +682,11 @@ extern u16 get_llc_id(unsigned int cpu);
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
+extern void amd_check_microcode(void);
 #else
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
+static inline void amd_check_microcode(void)		{ }
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
-- 
2.39.2

