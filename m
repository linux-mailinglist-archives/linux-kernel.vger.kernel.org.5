Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F177A370F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbjIQSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbjIQSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:13:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990A130;
        Sun, 17 Sep 2023 11:12:53 -0700 (PDT)
Date:   Sun, 17 Sep 2023 18:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694974371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc5PxrgzEDtVTUwkrlgZiBsRLqJMevC/M2Heog0Vp98=;
        b=2753SDDAmd6wH3hReW9/nrtFvFQ9h3SQNwN/HRv+RcT1aGY/orgkRXekYG6pBl5d25gk90
        JRucJ7FXQV5S9iQoJRQa9JmCR49twuOHH+2CdDn+xHgTrUFRXu8uc9DxiYJwXPDiCkf7Bh
        kKqsTTl1s3ptBAJX4+HVDt9W8yJbVYhlDXwa21eP1GkYpATW78ZaUtwrFMV3oLZ4hnB9Kt
        b32iHl2p6xh9QFT0+d0R9rp16U9DBpIQlb/SBq65W8aauH13mNjrF49ZcS4uzlduiTJ+bt
        C4RXzhc59RViCaalX8/An7E08NmVI1ppD8EbjxAf+8FcitY5qOhFsTcksZqaqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694974371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc5PxrgzEDtVTUwkrlgZiBsRLqJMevC/M2Heog0Vp98=;
        b=BtoskRjKCmv4eSQfaXKHlRXvC4E0lcvyG8o/W08daw91E2FuBkrimq9P1Zs4tEsLuMKPmz
        MWof4i6fzX39UgCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Derive file size from _edata symbol
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915171623.655440-14-ardb@google.com>
References: <20230915171623.655440-14-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169497437095.27769.15826720788686734939.tip-bot2@tip-bot2>
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

Commit-ID:     aeb92067f6ae994b541d7f9752fe54ed3d108bcc
Gitweb:        https://git.kernel.org/tip/aeb92067f6ae994b541d7f9752fe54ed3d108bcc
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 15 Sep 2023 17:16:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 19:48:42 +02:00

x86/boot: Derive file size from _edata symbol

Tweak the linker script so that the value of _edata represents the
decompressor binary's file size rounded up to the appropriate alignment.
This removes the need to calculate it in the build tool, and will make
it easier to refer to the file size from the header directly in
subsequent changes to the PE header layout.

While adding _edata to the sed regex that parses the compressed
vmlinux's symbol list, tweak the regex a bit for conciseness.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_STUB=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-14-ardb@google.com
---
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/vmlinux.lds.S |  3 +++-
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/boot/tools/build.c            | 30 +++++--------------------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 0e98bc5..cc04917 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 4ff6ab1..b688598 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -47,6 +47,9 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+
+		/* Add 4 bytes of extra space for a CRC-32 checksum */
+		. = ALIGN(. + 4, 0x20);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 06bd72a..34e9b35 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -233,7 +233,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 hdr:
 		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
-syssize:	.long 0			/* Filled in by build.c */
+syssize:	.long ZO__edata / 16
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
 root_dev:	.word 0			/* Default to major/minor 0/0 */
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 745d64b..e792c6c 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -52,6 +52,7 @@ u8 buf[SETUP_SECT_MAX*512];
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
+static unsigned long _edata;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -308,6 +309,7 @@ static void parse_zoffset(char *fname)
 	while (p && *p) {
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
+		PARSE_ZOFS(p, _edata);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -320,7 +322,6 @@ int main(int argc, char ** argv)
 {
 	unsigned int i, sz, setup_sectors;
 	int c;
-	u32 sys_size;
 	struct stat sb;
 	FILE *file, *dest;
 	int fd;
@@ -368,24 +369,14 @@ int main(int argc, char ** argv)
 		die("Unable to open `%s': %m", argv[2]);
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
+	if (_edata != sb.st_size)
+		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
+		    sb.st_size);
+	sz = _edata - 4;
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
-	sys_size = (sz + 15 + 4) / 16;
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * COFF requires minimum 32-byte alignment of sections, and
-	 * adding a signature is problematic without that alignment.
-	 */
-	sys_size = (sys_size + 1) & ~1;
-#endif
-
-	/* Patch the setup code with the appropriate size parameters */
-	put_unaligned_le32(sys_size, &buf[0x1f4]);
-
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
+	update_pecoff_text(setup_sectors * 512, i + _edata);
 
 
 	crc = partial_crc32(buf, i, crc);
@@ -397,13 +388,6 @@ int main(int argc, char ** argv)
 	if (fwrite(kernel, 1, sz, dest) != sz)
 		die("Writing kernel failed");
 
-	/* Add padding leaving 4 bytes for the checksum */
-	while (sz++ < (sys_size*16) - 4) {
-		crc = partial_crc32_one('\0', crc);
-		if (fwrite("\0", 1, 1, dest) != 1)
-			die("Writing padding failed");
-	}
-
 	/* Write the CRC */
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
