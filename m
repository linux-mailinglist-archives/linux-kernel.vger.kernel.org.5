Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869757A3712
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbjIQSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbjIQSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:13:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85233129;
        Sun, 17 Sep 2023 11:12:55 -0700 (PDT)
Date:   Sun, 17 Sep 2023 18:12:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDKxkhqIdeMe6T0j3y90XFzwL7zRPyAXKTJOyb7Djvo=;
        b=xelt92WdWS/kab2oqQA9iIwnMzwEP0ieS9R0SME5FTxVR32WqrOnlRhETSJ4Ck4SKMsLc4
        wq+WlQ3W5YPuFdEsHhSoeEGcoM+V1YxKA/x3htFXtdlXSPGhHovygvBN95NwKoYhXWvfc9
        oV6uSSnQHN0yFpbMYpTGp+blBf7hfXcBVpA/8t0EruwEPubRvFN0R24AM0eDgy3/O9qcoF
        ooUz5PDtiRCC8+CWiCFzx9QWlulMduU8qhjP7St6LpbFi4ZLeZhEnBgTh3b1x7rPbqASjP
        h8eyibK9YSl2ovxGwZiBpx5OWr8GNfL3L2EuY5nKoFd+Axtl/nc+8tFjaTIrxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDKxkhqIdeMe6T0j3y90XFzwL7zRPyAXKTJOyb7Djvo=;
        b=N1fISaY/MGNGtb8kyVxysVpdqaI/90mLH2wXkVnvM0i2MM03lzb7stlmJ6leFh2bNdAgrz
        djeajAuWCFAse2DA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Set EFI handover offset directly in header asm
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915171623.655440-12-ardb@google.com>
References: <20230915171623.655440-12-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169497437194.27769.17857741013219317202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     eac956345f99dda3d68f4ae6cf7b494105e54780
Gitweb:        https://git.kernel.org/tip/eac956345f99dda3d68f4ae6cf7b494105e54780
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 15 Sep 2023 17:16:26 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 19:48:42 +02:00

x86/boot: Set EFI handover offset directly in header asm

The offsets of the EFI handover entrypoints are available to the
assembler when constructing the header, so there is no need to set them
from the build tool afterwards.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-12-ardb@google.com
---
 arch/x86/boot/header.S      | 18 +++++++++++++++++-
 arch/x86/boot/tools/build.c | 24 ------------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 5575d0f..72744ba 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -524,8 +524,24 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # define INIT_SIZE VO_INIT_SIZE
 #endif
 
+	.macro		__handover_offset
+#ifndef CONFIG_EFI_HANDOVER_PROTOCOL
+	.long		0
+#elif !defined(CONFIG_X86_64)
+	.long		ZO_efi32_stub_entry
+#else
+	/* Yes, this is really how we defined it :( */
+	.long		ZO_efi64_stub_entry - 0x200
+#ifdef CONFIG_EFI_MIXED
+	.if		ZO_efi32_stub_entry != ZO_efi64_stub_entry - 0x200
+	.error		"32-bit and 64-bit EFI entry points do not match"
+	.endif
+#endif
+#endif
+	.endm
+
 init_size:		.long INIT_SIZE		# kernel initialization size
-handover_offset:	.long 0			# Filled in by build.c
+handover_offset:	__handover_offset
 kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 14ef13f..0694975 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -55,8 +55,6 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-static unsigned long efi32_stub_entry;
-static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _end;
@@ -265,31 +263,12 @@ static void efi_stub_defaults(void)
 #endif
 }
 
-static void efi_stub_entry_update(void)
-{
-	unsigned long addr = efi32_stub_entry;
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-#ifdef CONFIG_X86_64
-	/* Yes, this is really how we defined it :( */
-	addr = efi64_stub_entry - 0x200;
-#endif
-
-#ifdef CONFIG_EFI_MIXED
-	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
-#endif
-#endif
-	put_unaligned_le32(addr, &buf[0x264]);
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -332,8 +311,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_stub_entry);
-		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _end);
@@ -416,7 +393,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
-	efi_stub_entry_update();
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
