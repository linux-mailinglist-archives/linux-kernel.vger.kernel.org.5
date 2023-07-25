Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7A761817
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjGYMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGYMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A79A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D44616B1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B415EC433C8;
        Tue, 25 Jul 2023 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690287477;
        bh=gGj+zZodhcrEkfzZJQhzs82i0JBSqzhqMChNJmcVRpI=;
        h=From:To:Cc:Subject:Date:From;
        b=UdsoyzUqtMd/JeI8MWIcIhaqGCGpVKMTBQF+IxJlfs5UhEGvWYHXUpi3Mrbeq5O8R
         dBJNxlUah03PdcObRyZkwAcVLgKNFsRTInOyCX4X8qch72ArPXi8MxBZ8nWyo0woeW
         tkU32fdAHHEeSGHXOMBWrkuqnsEmG+d5t9bfZ1OAG3mDZ95X8EiKI3sb+vtgwJVRgt
         foxh3Ym/Cl8QjS2NLg2iAFVEkXc/8ZBJqsZNwKH0v3ODkSlJCe6MFbESSk7MDwuvDw
         qR8deFcxaIhUtKDcs45DBpwYtTRMNH0yNgIJ4U2ZQDK7MCaLO9yS//T1DNeh5sNF1H
         owyb/s0+N1TRg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Brian Gerst <brgerst@gmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86: Fix amd_check_microcode() declaration
Date:   Tue, 25 Jul 2023 14:17:39 +0200
Message-Id: <20230725121751.2007665-1-arnd@kernel.org>
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

Move the declaration into a more appropriate header that is already included,
with the #ifdef check changed to match the definition's.

Fixes: 522b1d69219d8 ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/microcode_amd.h | 3 +--
 arch/x86/include/asm/processor.h     | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 9675c621c1ca4..2ed09a1da4a27 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -48,13 +48,12 @@ extern void __init load_ucode_amd_bsp(unsigned int family);
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

