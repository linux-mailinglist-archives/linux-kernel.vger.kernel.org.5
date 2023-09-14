Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB667A029F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjINL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjINL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305341A5;
        Thu, 14 Sep 2023 04:27:06 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+9lxCGIAXIBCuloyKhhileQmPydRd0vGCXF79l3kpc=;
        b=mg/48v65EyGLB5PQpDwmbJGvV4rhym5wswrU+tNtOxHYcn7tkh/+YQByBXlWc0BtzQ+eoK
        pF665Wge09i7s/wW3vsDh10kfkBJaUJ8HEFF0tgZJnfwxF7CgVyeZAtyPchZz8ktc5t8Xb
        i12ug582MyApSMnP4MxMXv5u8ghk3aTJpc1UlucXJSwVS1XgI2TiIquVAetiX1LqSS6OYL
        0muHLZPlW6iGUhSq+SWLGjSpQ5SDUyqcoJ/sFFo+lcqRQpmdh6avxoXgVQDqvJC9qos+r0
        eKeSrxR5Q76g1X8PAzEnfyLz+SXwgix3UDgh6de2asIn93G9NEtO2z4JkjwakQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+9lxCGIAXIBCuloyKhhileQmPydRd0vGCXF79l3kpc=;
        b=ITm/l6S5+pV3Os5lhA3rDVLwyLR1aZMnOK8BncwwxkjW+MnB7FQptYi4wILiXjwI4PBV0W
        5cyHvhVm4QRXESAg==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Rename ignore_sysret()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-3-nik.borisov@suse.com>
References: <20230623111409.3047467-3-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082431.27769.8435967971182289551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f71e1d2ff8e6a183bd4004bc97c453ba527b7dc6
Gitweb:        https://git.kernel.org/tip/f71e1d2ff8e6a183bd4004bc97c453ba527b7dc6
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:05 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86/entry: Rename ignore_sysret()

The SYSCALL instruction cannot really be disabled in compatibility mode.
The best that can be done is to configure the CSTAR msr to point to a
minimal handler. Currently this handler has a rather misleading name -
ignore_sysret() as it's not really doing anything with sysret.

Give it a more descriptive name.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-3-nik.borisov@suse.com

---
 arch/x86/entry/entry_64.S        | 4 ++--
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/common.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de..3be71ac 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1516,12 +1516,12 @@ SYM_CODE_END(asm_exc_nmi)
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
  */
-SYM_CODE_START(ignore_sysret)
+SYM_CODE_START(entry_SYSCALL32_ignore)
 	UNWIND_HINT_END_OF_STACK
 	ENDBR
 	mov	$-ENOSYS, %eax
 	sysretl
-SYM_CODE_END(ignore_sysret)
+SYM_CODE_END(entry_SYSCALL32_ignore)
 #endif
 
 .pushsection .text, "ax"
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920..93cd28d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -399,7 +399,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-extern asmlinkage void ignore_sysret(void);
+extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6..b3f8cba 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2087,7 +2087,7 @@ void syscall_init(void)
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
-	wrmsrl_cstar((unsigned long)ignore_sysret);
+	wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
