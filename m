Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A42B773E64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHHQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjHHQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297A1251D;
        Tue,  8 Aug 2023 08:51:02 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8MSe0CeLnSuXDYNXmQMGffVQ+qqWANcy97jyL1wqRA=;
        b=ZRTnQ2X/RZ70sXWwIrfUBcu8cWR3hvaqzrzYrHIoRrBbpdx3WfABs0BZG7eiq4I4dT+Ui6
        WJSDqY0fVR5WXXBtdAKmznTxX/wwCT4G3qXt9btoyZiAPdLfG00uDxnqYiUkQOqjzG9n0p
        sF7PVCDV9/WbO33LnSUgc9fW2QSDx4cB87vF80CRrC5ImyOlZCejWfPAW8SXd+kQntOtTq
        bUj3RoEBIFcg6cEPb/rEHAfD4fPnx0+YhIAYdAVE6k4SX0tqFECEDnxYbWP5wPWYeaMtJN
        3ZgyaOSffTVsyJPHv2IVpM03K5L7xLyGadRF6Nd7nmNsyu4V0PtT/v1dVGbbbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8MSe0CeLnSuXDYNXmQMGffVQ+qqWANcy97jyL1wqRA=;
        b=j2aHBmoGe5zObUg1ajj5udUKdf8gpjp6/755aVGDJJ+G31NJtq+86PyRcz5H4AjKcXhbTi
        lg1QM2wczZtv7CDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/decompressor: Factor out kernel decompression and
 relocation
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-21-ardb@kernel.org>
References: <20230807162720.545787-21-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148423908.27769.3075033623173952060.tip-bot2@tip-bot2>
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

Commit-ID:     83381519352d6b5b3e429bf72aaab907480cb6b6
Gitweb:        https://git.kernel.org/tip/83381519352d6b5b3e429bf72aaab907480cb6b6
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:17 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 20:59:13 +02:00

x86/decompressor: Factor out kernel decompression and relocation

Factor out the decompressor sequence that invokes the decompressor,
parses the ELF and applies the relocations so that it can be called
directly from the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-21-ardb@kernel.org
---
 arch/x86/boot/compressed/misc.c | 28 +++++++++++++++++++++++-----
 arch/x86/include/asm/boot.h     |  8 ++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 2d91d56..f711f2a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -330,11 +330,33 @@ static size_t parse_elf(void *output)
 	return ehdr.e_entry - LOAD_PHYSICAL_ADDR;
 }
 
+const unsigned long kernel_total_size = VO__end - VO__text;
+
 static u8 boot_heap[BOOT_HEAP_SIZE] __aligned(4);
 
 extern unsigned char input_data[];
 extern unsigned int input_len, output_len;
 
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x))
+{
+	unsigned long entry;
+
+	if (!free_mem_ptr) {
+		free_mem_ptr     = (unsigned long)boot_heap;
+		free_mem_end_ptr = (unsigned long)boot_heap + sizeof(boot_heap);
+	}
+
+	if (__decompress(input_data, input_len, NULL, NULL, outbuf, output_len,
+			 NULL, error) < 0)
+		return ULONG_MAX;
+
+	entry = parse_elf(outbuf);
+	handle_relocations(outbuf, output_len, virt_addr);
+
+	return entry;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -354,7 +376,6 @@ extern unsigned int input_len, output_len;
  */
 asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 {
-	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
 	memptr heap = (memptr)boot_heap;
 	unsigned long needed_size;
@@ -463,10 +484,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		accept_memory(__pa(output), __pa(output) + needed_size);
 	}
 
-	__decompress(input_data, input_len, NULL, NULL, output, output_len,
-			NULL, error);
-	entry_offset = parse_elf(output);
-	handle_relocations(output, output_len, virt_addr);
+	entry_offset = decompress_kernel(output, virt_addr, error);
 
 	debug_putstr("done.\nBooting the kernel (entry_offset: 0x");
 	debug_puthex(entry_offset);
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280..4ae1433 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -62,4 +62,12 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
+#ifndef __ASSEMBLY__
+extern unsigned int output_len;
+extern const unsigned long kernel_total_size;
+
+unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
+				void (*error)(char *x));
+#endif
+
 #endif /* _ASM_X86_BOOT_H */
