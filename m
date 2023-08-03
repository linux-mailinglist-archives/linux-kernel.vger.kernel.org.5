Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0676EEE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHCP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjHCP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAEF211B;
        Thu,  3 Aug 2023 08:59:18 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTChyiFhvIi4JIl1UodawWAFP422YBkqPUZjcTiWnRQ=;
        b=mEtG/rtDo/OBInzajt2mngeLe+8/pjFaAOxIo5Zp/N+jKIsm9ZauzMw5Sr0dt+K/m6FiiF
        z53O1KDp2+TttsDv5MjRnhb3vgUUBmuJh43vEjsOYHTThWOg0tdB1j6lvWwWz8PMDEdnwd
        e0EscLecnlEdK5Pdx3qCSAMCO5v7a7G8zyx9dZlPnld8zFat5GIsz9k/984v6L62lC0Wxc
        Gn009ZgiQZW409zGkIcZ3kA8nCNA4l3ea2M74mU/ICEzw0y0+xpalv+uIhp7AqTAWk/WMw
        mI7YaDWzb7HSqE3T9TcmuLhZSuiXVW9tynnRuyn8GYesVQjYnRAnhHf/U7KJpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTChyiFhvIi4JIl1UodawWAFP422YBkqPUZjcTiWnRQ=;
        b=ggXJJUhgVsZBl73vnO/8+g2PFQ/ftKnxSM6z44MyE+hu1Y7OrtEZwRobHYSj9k2prZ1eoZ
        kJ2wgTVpiujXujCw==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Fix amd_check_microcode() declaration
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230725121751.2007665-1-arnd@kernel.org>
References: <20230725121751.2007665-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835629.28540.8472266349964382413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     566ffa3ae9649f7aa1debcf559ee7e26ed4a110f
Gitweb:        https://git.kernel.org/tip/566ffa3ae9649f7aa1debcf559ee7e26ed4a110f
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 25 Jul 2023 14:17:39 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 31 Jul 2023 11:03:16 +02:00

x86/cpu: Fix amd_check_microcode() declaration

The newly added amd_check_microcode() function has two conflicting definitions
if CONFIG_CPU_SUP_AMD is enabled and CONFIG_MICROCODE_AMD is disabled. Since
the header with the stub definition is not included in cpu/amd.c, this only
causes a -Wmissing-prototype warning with W=1:

  arch/x86/kernel/cpu/amd.c:1289:6: error: no previous prototype for 'amd_check_microcode' [-Werror=missing-prototypes]

Adding the missing #include shows the other problem:

  arch/x86/kernel/cpu/amd.c:1290:6: error: redefinition of 'amd_check_microcode'
  arch/x86/include/asm/microcode_amd.h:58:20: note: previous definition of 'amd_check_microcode' with type 'void(void)'

Move the declaration into a more appropriate header that is already
included, with the #ifdef check changed to match the definition's.

Fixes: 522b1d69219d8 ("x86/cpu/amd: Add a Zenbleed fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230725121751.2007665-1-arnd@kernel.org
---
 arch/x86/include/asm/microcode_amd.h | 3 +--
 arch/x86/include/asm/processor.h     | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 9675c62..2ed09a1 100644
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
index d46300e..36d5207 100644
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
