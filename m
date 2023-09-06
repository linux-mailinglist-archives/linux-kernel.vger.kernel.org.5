Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23A794584
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjIFV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbjIFV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:57:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66B19AD;
        Wed,  6 Sep 2023 14:57:20 -0700 (PDT)
Date:   Wed, 06 Sep 2023 21:57:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694037437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUjeZkDnUC3aX8jLsaRvyeViLKg3OUTcSt981IJnyq4=;
        b=GrP9vqMHp+RvOb9bbOAqVN9wPWJJsmxQlfszovpWAjCvL83E2M7XeWJJjzrbrqL1BR03aW
        FNd95JY6it5Ssb02m8NaFQ0/n6ltHMxYcP/EXCPmBs20gEey+OW9O8Dm2rfuXLHKqM1JCu
        0W+RIOU5Pn8BBAJzCX7qCeprh5VM7EkFA0TnN2Y8E+mbQoGTyppgUtNFSSuXTSwSyd5eNJ
        2zYiefIebIQ2HuhPXamfoyoCPr4BXv36P4FpI5amw4kiJX8UlpSX2b6oxMAYIMteRrSrn4
        a+AHqrVJgJpPOI9jUDGrOYD+KF4NroYcecUrId7yurIDH823hL25NgCH3DGvWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694037437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUjeZkDnUC3aX8jLsaRvyeViLKg3OUTcSt981IJnyq4=;
        b=v/FsiB9im0oe5cVy3UZ9u0YIbSyad02FgAKlcueKusKRxTJ7ZbsyalwHYxY2q8R+JulZvQ
        YJtnM3N91l0nBAAw==
From:   "tip-bot2 for Thomas Huth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Remove the arch_calc_vm_prot_bits() macro from
 the UAPI
Cc:     Thomas Huth <thuth@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230906162658.142511-1-thuth@redhat.com>
References: <20230906162658.142511-1-thuth@redhat.com>
MIME-Version: 1.0
Message-ID: <169403743706.27769.33130108048902877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     659df86a7b2fe98feb5f4ec880e694caaebd27ae
Gitweb:        https://git.kernel.org/tip/659df86a7b2fe98feb5f4ec880e694caaebd27ae
Author:        Thomas Huth <thuth@redhat.com>
AuthorDate:    Wed, 06 Sep 2023 18:26:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 06 Sep 2023 23:50:46 +02:00

x86: Remove the arch_calc_vm_prot_bits() macro from the UAPI

The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
not part of the UAPI, so the macro is completely useless for userspace.

It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
config switch which we shouldn't expose to userspace. Thus let's move
this macro into a new internal header instead.

Fixes: 8f62c883222c ("x86/mm/pkeys: Add arch-specific VMA protection bits")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/20230906162658.142511-1-thuth@redhat.com
---
 arch/x86/include/asm/mman.h      | 15 +++++++++++++++
 arch/x86/include/uapi/asm/mman.h |  8 --------
 scripts/headers_install.sh       |  1 -
 3 files changed, 15 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/include/asm/mman.h

diff --git a/arch/x86/include/asm/mman.h b/arch/x86/include/asm/mman.h
new file mode 100644
index 0000000..12b8202
--- /dev/null
+++ b/arch/x86/include/asm/mman.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+#define arch_calc_vm_prot_bits(prot, key) (		\
+		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
+		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
+		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
+		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
+#endif
+
+#include <uapi/asm/mman.h>
+
+#endif /* __ASM_MMAN_H__ */
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 8148bdd..46cdc94 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,14 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-#define arch_calc_vm_prot_bits(prot, key) (		\
-		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
-		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
-		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
-		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
-#endif
-
 /* Flags for map_shadow_stack(2) */
 #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
 
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index afdddc8..56d3c33 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -81,7 +81,6 @@ arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
 arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION
 arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
-arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 "
 
 for c in $configs
