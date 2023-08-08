Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82BB773EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjHHQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHHQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60E9089;
        Tue,  8 Aug 2023 08:52:21 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UKoshY9dL4+4BhYKrhvJNIuP8h9w/AW++PipRWo5EY=;
        b=XzKst5C9MTT8YKvHvEXbL9vq4HYDQVjvYSZ19L38i3Q+wSMyUaAkXIeXGpMnTgz1cDODrA
        /DAil87m9M98LRKB5uteoRG9dBDDYtlBuOXCL38ttaQQBhhUZ7q4fi3PXYwbpy5Z347q5D
        k8hs7Zedmdeujy6ekbzttpxhCTHSHxpRUCKnGNLpLjOVshS9nGE4wTsy+0VX5pZhc0FVDH
        ObPthDx8VckRH9XGjeWRlmlxZIu7hrLVryAmJvMzAGAEek/RNr03soYx/6mf6vbtyIGlmj
        4ZcH5d4POh4QtqvDm3QKPt5BYHuTBjHUZJ1u2KzN1T86kc+f0VF4erlNe5r+EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UKoshY9dL4+4BhYKrhvJNIuP8h9w/AW++PipRWo5EY=;
        b=zzftaqtuuxaMBIHcGs+r4ugKP3dT5xabbSMARhitvkJeIj+acCSbpglFgygAYB/nSpKTrR
        RzxPPJZk+szhWXAw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efistub: Clear BSS in EFI handover protocol entrypoint
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-7-ardb@kernel.org>
References: <20230807162720.545787-7-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148424483.27769.12149416146478802186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d7156b986d4cc0657fa6dc05c9fcf51c3d55a0fe
Gitweb:        https://git.kernel.org/tip/d7156b986d4cc0657fa6dc05c9fcf51c3d55a0fe
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:03 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:40:36 +02:00

x86/efistub: Clear BSS in EFI handover protocol entrypoint

The so-called EFI handover protocol is value-add from the distros that
permits a loader to simply copy a PE kernel image into memory and call
an alternative entrypoint that is described by an embedded boot_params
structure.

Most implementations of this protocol do not bother to check the PE
header for minimum alignment, section placement, etc, and therefore also
don't clear the image's BSS, or even allocate enough memory for it.

Allocating more memory on the fly is rather difficult, but at least
clear the BSS region explicitly when entering in this manner, so that
the EFI stub code does not get confused by global variables that were
not zero-initialized correctly.

When booting in mixed mode, this BSS clearing must occur before any
global state is created, so clear it in the 32-bit asm entry point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-7-ardb@kernel.org
---
 arch/x86/boot/compressed/efi_mixed.S    | 14 +++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c | 13 +++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 9308b59..8a02a15 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -142,6 +142,18 @@ SYM_FUNC_END(__efi64_thunk)
 	.code32
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 SYM_FUNC_START(efi32_stub_entry)
+	call	1f
+1:	popl	%ecx
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	(_bss - 1b)(%ecx), %edi
+	leal	(_ebss - 1b)(%ecx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -334,7 +346,7 @@ SYM_FUNC_END(efi32_pe_entry)
 	.org	efi32_stub_entry + 0x200
 	.code64
 SYM_FUNC_START_NOALIGN(efi64_stub_entry)
-	jmp	efi_stub_entry
+	jmp	efi_handover_entry
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3f3b3ed..9247dbc 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -970,12 +970,21 @@ fail:
 }
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+			struct boot_params *boot_params)
+{
+	extern char _bss[], _ebss[];
+
+	memset(_bss, 0, _ebss - _bss);
+	efi_stub_entry(handle, sys_table_arg, boot_params);
+}
+
 #ifndef CONFIG_EFI_MIXED
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi64_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 #endif
