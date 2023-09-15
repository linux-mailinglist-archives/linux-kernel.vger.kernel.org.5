Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDF7A1AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjIOJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjIOJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:38:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58772121;
        Fri, 15 Sep 2023 02:37:49 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:37:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694770668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02CNNYdQjVfmj16GKHZtFnohxkv6LTnS13rVtwj3by8=;
        b=Xbqfen0LUvyCYp0eYT79H7LUhDwbh0ZlGygp6KogUPTQSfwx1hR1KTghu9OoJo+uDXUPPJ
        qE23DCX99XyyV8VxbLtAWcS3k6t42lvB/vN7IuCHY5NbRDyQSVH1NXgp/sgPWZQgWGCoum
        DmwKQd5kqs9hUl8mOVzGi43MRlYh/+r1rWBUWYYk+Q5ALtv7rXen/T5WevFl2kuBGZL7vL
        Q5HVVYJmAerpUMiyq5JJLH6YxwLPwuy5yrJBwGt/UT7m/a2njXiCYyVDoicQ/8AczVWncY
        cTvIDgGehPFTfO/cP0l2Q5kHE8mPLhw67ounbLHFVO5f4bCJgTRLEwHcTFbwxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694770668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02CNNYdQjVfmj16GKHZtFnohxkv6LTnS13rVtwj3by8=;
        b=wD8FyGhcPZ3ohclfdo6szcTy4S825eWyf1Ou8uUO+GXp9Eoqj5uXnzN5Q4Hvdjir55wv3w
        jVKtdnk6xxnpbKDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Omit compression buffer from PE/COFF image
 memory footprint
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912090051.4014114-22-ardb@google.com>
References: <20230912090051.4014114-22-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169477066777.27769.18147290809049651725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     8eace5b3555606e684739bef5bcdfcfe68235257
Gitweb:        https://git.kernel.org/tip/8eace5b3555606e684739bef5bcdfcfe68235257
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 09:00:56 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 11:18:41 +02:00

x86/boot: Omit compression buffer from PE/COFF image memory footprint

Now that the EFI stub decompresses the kernel and hands over to the
decompressed image directly, there is no longer a need to provide a
decompression buffer as part of the .BSS allocation of the PE/COFF
image. It also means the PE/COFF image can be loaded anywhere in memory,
and setting the preferred image base is unnecessary. So drop the
handling of this from the header and from the build tool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-22-ardb@google.com
---
 arch/x86/boot/header.S      |  6 +---
 arch/x86/boot/tools/build.c | 50 ++++--------------------------------
 2 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b24fa50..a87d913 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -90,12 +90,10 @@ optional_header:
 #endif
 
 extra_header_fields:
-	# PE specification requires ImageBase to be 64k aligned
-	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	image_base			# ImageBase
+	.long	0				# ImageBase
 #else
-	.quad	image_base			# ImageBase
+	.quad	0				# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index bd24769..0354c22 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -65,7 +65,6 @@ static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long kernel_info;
 static unsigned long startup_64;
-static unsigned long _ehead;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -229,35 +228,22 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz,
-			       unsigned int init_sz)
+static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
 {
 	unsigned int pe_header;
 	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = init_sz - file_sz;
+	unsigned int bss_sz = _end - text_sz;
 
 	pe_header = get_unaligned_le32(&buf[0x3c]);
 
 	/*
-	 * The PE/COFF loader may load the image at an address which is
-	 * misaligned with respect to the kernel_alignment field in the setup
-	 * header.
-	 *
-	 * In order to avoid relocating the kernel to correct the misalignment,
-	 * add slack to allow the buffer to be aligned within the declared size
-	 * of the image.
-	 */
-	bss_sz	+= CONFIG_PHYSICAL_ALIGN;
-	init_sz	+= CONFIG_PHYSICAL_ALIGN;
-
-	/*
 	 * Size of code: Subtract the size of the first sector (512 bytes)
 	 * which includes the header.
 	 */
 	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
 
 	/* Size of image */
-	put_unaligned_le32(init_sz, &buf[pe_header + 0x50]);
+	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
 
 	/*
 	 * Address of entry point for PE/COFF executable
@@ -308,8 +294,7 @@ static void efi_stub_entry_update(void)
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz,
-				      unsigned int init_sz) {}
+				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
 static inline void efi_stub_entry_update(void) {}
 
@@ -360,7 +345,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
-		PARSE_ZOFS(p, _ehead);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -371,7 +355,7 @@ static void parse_zoffset(char *fname)
 
 int main(int argc, char ** argv)
 {
-	unsigned int i, sz, setup_sectors, init_sz;
+	unsigned int i, sz, setup_sectors;
 	int c;
 	u32 sys_size;
 	struct stat sb;
@@ -442,31 +426,9 @@ int main(int argc, char ** argv)
 	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
-	init_sz = get_unaligned_le32(&buf[0x260]);
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * The decompression buffer will start at ImageBase. When relocating
-	 * the compressed kernel to its end, we must ensure that the head
-	 * section does not get overwritten.  The head section occupies
-	 * [i, i + _ehead), and the destination is [init_sz - _end, init_sz).
-	 *
-	 * At present these should never overlap, because 'i' is at most 32k
-	 * because of SETUP_SECT_MAX, '_ehead' is less than 1k, and the
-	 * calculation of INIT_SIZE in boot/header.S ensures that
-	 * 'init_sz - _end' is at least 64k.
-	 *
-	 * For future-proofing, increase init_sz if necessary.
-	 */
-
-	if (init_sz - _end < i + _ehead) {
-		init_sz = (i + _ehead + _end + 4095) & ~4095;
-		put_unaligned_le32(init_sz, &buf[0x260]);
-	}
-#endif
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16), init_sz);
+	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-
 	/* Update kernel_info offset. */
 	put_unaligned_le32(kernel_info, &buf[0x268]);
 
