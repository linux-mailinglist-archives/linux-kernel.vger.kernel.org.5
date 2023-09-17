Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA657A3710
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjIQSNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbjIQSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:13:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F4193;
        Sun, 17 Sep 2023 11:12:52 -0700 (PDT)
Date:   Sun, 17 Sep 2023 18:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694974371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4R1VVypAmNtRAtSZGqDkFuQH4C8pYAgt5jxU9SCqsY=;
        b=YQMsAm3QiN1rYIgHMmlCsQHKPTCmiRr1QYBLdvyeinaE/tFmvuygQiQJsEndZi/eJLWInG
        f82+jNHSd0pifUXKLLO7XpAh6Ra24Rlm335MBJaiU/mzl7v9O69aErHQ8ZbeU70BWsdG4E
        q3gVNc9wbwW/WYw6k3GS0IWUD8dvS5zFhQjd79mAk31zs9ukfxIP3KBPgMfAtPfRxs7Ehp
        OWu7v22iseFLOwYd4TfQMPkHcBTU+KrbV5u70lmpCSquSEup84rMVNmeyiSsf7c0SY2CKk
        CFh/WqoAhX+t7pM+dq2LX+HaJQ4Ra+B7wo15+wWJhuE8p1/7dve3/+02LCJM2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694974371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4R1VVypAmNtRAtSZGqDkFuQH4C8pYAgt5jxU9SCqsY=;
        b=+VUL5SqHMxgA8Va56pUaDvmXRzNCuDHIMe/frCJfuIe6MgiiZ82LyihV9PdEW3209ggl0v
        QP93KGyh9n6cj6DA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Construct PE/COFF .text section from assembler
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915171623.655440-15-ardb@google.com>
References: <20230915171623.655440-15-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169497437050.27769.9197452501392752841.tip-bot2@tip-bot2>
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

Commit-ID:     efa089e63b56bdc5eca754b995cb039dd7a5457e
Gitweb:        https://git.kernel.org/tip/efa089e63b56bdc5eca754b995cb039dd7a5457e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 15 Sep 2023 17:16:29 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 19:48:43 +02:00

x86/boot: Construct PE/COFF .text section from assembler

Now that the size of the setup block is visible to the assembler, it is
possible to populate the PE/COFF header fields from the asm code
directly, instead of poking the values into the binary using the build
tool. This will make it easier to reorganize the section layout without
having to tweak the build tool in lockstep.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-15-ardb@google.com
---
 arch/x86/boot/header.S      | 22 +++++------------
 arch/x86/boot/tools/build.c | 47 +------------------------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 34e9b35..2b07bc5 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -75,14 +75,12 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	# Filled in by build.c
-	.long	0				# SizeOfCode
+	.long	setup_size + ZO__end - 0x200	# SizeOfCode
 
 	.long	0				# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
-	# Filled in by build.c
-	.long	0x0000				# AddressOfEntryPoint
+	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
 	.long	0x0200				# BaseOfCode
 #ifdef CONFIG_X86_32
@@ -105,10 +103,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	#
-	# The size of the bzImage is written in tools/build.c
-	#
-	.long	0				# SizeOfImage
+	.long	setup_size + ZO__end 		# SizeOfImage
 
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -199,18 +194,15 @@ section_table:
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".text"
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
+	.long	ZO__end
+	.long	setup_size
+	.long	ZO__edata			# Size of initialized data
 						# on disk
-	.long	0x0				# startup_{32,64}
+	.long	setup_size
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index e792c6c..9712f27 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -50,10 +50,8 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_RELOC_RESERVE 0x20
 #define PECOFF_COMPAT_RESERVE 0x20
 
-static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _edata;
-static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
@@ -216,32 +214,6 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
-{
-	unsigned int pe_header;
-	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = _end - text_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-
-	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
-	 */
-	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
-
-	/* Size of image */
-	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
-
-	/*
-	 * Address of entry point for PE/COFF executable
-	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
-
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
-}
-
 static int reserve_pecoff_reloc_section(int c)
 {
 	/* Reserve 0x20 bytes for .reloc section */
@@ -249,22 +221,9 @@ static int reserve_pecoff_reloc_section(int c)
 	return PECOFF_RELOC_RESERVE;
 }
 
-static void efi_stub_defaults(void)
-{
-	/* Defaults for old kernel */
-#ifdef CONFIG_X86_32
-	efi_pe_entry = 0x10;
-#else
-	efi_pe_entry = 0x210;
-#endif
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz) {}
-static inline void efi_stub_defaults(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -307,10 +266,8 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
-		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -328,8 +285,6 @@ int main(int argc, char ** argv)
 	void *kernel;
 	u32 crc = 0xffffffffUL;
 
-	efi_stub_defaults();
-
 	if (argc != 5)
 		usage();
 	parse_zoffset(argv[3]);
@@ -376,8 +331,6 @@ int main(int argc, char ** argv)
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	update_pecoff_text(setup_sectors * 512, i + _edata);
-
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
