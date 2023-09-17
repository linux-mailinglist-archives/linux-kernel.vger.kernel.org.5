Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F67A3711
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjIQSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjIQSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:13:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3B135;
        Sun, 17 Sep 2023 11:12:55 -0700 (PDT)
Date:   Sun, 17 Sep 2023 18:12:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmbTHz0oxyRq0ilV2+qpm/m2KASgVKj0aN/6CNBu2n0=;
        b=EGp9U5jKCdAnqeqoXL9HlPux59j3cMJpx4by/43tl/Jwa2jMUGzGB3SGFT3ZHhx6JU2MPl
        8fqNtyWTvDp6UQK8ksaQKH1jyafi+HqmSKn9fC2icIJ0om341TJRUCVx9zMrM3eUqKS3g4
        rwZ0WgoLHmRyUkWQU4Ycw6b0GcPrq3Y5wa7hFFPd9ocHX5UGnx8iTrab2dIGoKljd3UKfG
        b0zinTB4RV9eE0GjOKo/FbFweAjObjQbuP+bS1K2LadLzPIVBUo8Y6mIf2fOb6uVH8VOSp
        gaAT0ft0/pzC5X1QCfPQ2H1SmeBLBPCwjFgILLfjeU4iETKPOsGllbC54F2mMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmbTHz0oxyRq0ilV2+qpm/m2KASgVKj0aN/6CNBu2n0=;
        b=Wy/mhCPoblq8Xhev5zkKx3LCwm5bfQ2slL5LHd//eG655iov3qoXRcclv80MbyEg3BJZtM
        SPvVF3qdXV40PqDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Define setup size in linker script
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915171623.655440-13-ardb@google.com>
References: <20230915171623.655440-13-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169497437144.27769.10481980684639575351.tip-bot2@tip-bot2>
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

Commit-ID:     093ab258e3fb1d1d3afdfd4a69403d44ce90e360
Gitweb:        https://git.kernel.org/tip/093ab258e3fb1d1d3afdfd4a69403d44ce90e360
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 15 Sep 2023 17:16:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 19:48:42 +02:00

x86/boot: Define setup size in linker script

The setup block contains the real mode startup code that is used when
booting from a legacy BIOS, along with the boot_params/setup_data that
is used by legacy x86 bootloaders to pass the command line and initial
ramdisk parameters, among other things.

The setup block also contains the PE/COFF header of the entire combined
image, which includes the compressed kernel image, the decompressor and
the EFI stub.

This PE header describes the layout of the executable image in memory,
and currently, the fact that the setup block precedes it makes it rather
fiddly to get the right values into the right place in the final image.

Let's make things a bit easier by defining the setup_size in the linker
script so it can be referenced from the asm code directly, rather than
having to rely on the build tool to calculate it. For the time being,
add 64 bytes of fixed padding for the .reloc and .compat sections - this
will be removed in a subsequent patch after the PE/COFF header has been
reorganized.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_MIXED=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-13-ardb@google.com
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/setup.ld      | 4 ++++
 arch/x86/boot/tools/build.c | 6 ------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 72744ba..06bd72a 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -231,7 +231,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index b11c45b..9bd5c1a 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -39,6 +39,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
+
+		/* Reserve some extra space for the reloc and compat sections */
+		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 0694975..745d64b 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -48,12 +48,7 @@ typedef unsigned int   u32;
 u8 buf[SETUP_SECT_MAX*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
-
-#ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
@@ -388,7 +383,6 @@ int main(int argc, char ** argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
