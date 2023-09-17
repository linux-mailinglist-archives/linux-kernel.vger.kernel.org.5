Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11417A3713
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbjIQSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjIQSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:13:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B6137;
        Sun, 17 Sep 2023 11:12:56 -0700 (PDT)
Date:   Sun, 17 Sep 2023 18:12:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAP5sltfIcvMA4Q2ijBQ4PWfxzckzT5fgVQ66E1pkdo=;
        b=CXwEOsj3Cq0eXdGLZSqGiJ/8RQItPFa3orVAwlFOws8iHOwzibvR/JixfzeR2TyE8YZv9K
        rsrkGBoAsReuw2q8VflB3mLcGhWUzLQdafXApbkjdLdQMOUC7jyvcdxVfEgvwKrr6pO4DQ
        HemdHIlFNMEViLz/AYM5UZJ0JOLoEL0TBgrI58h8uXmV/ocRlbhpPn9hwwGHf4Y0L2Q8tr
        sZEaEuu3WdHlPOLYnDY/IK2akMlOrIFlpzrlYp0K34P0YtJXSvIhO3XXpIsKcBl/Cy1oHy
        4DXImyeWMM2pB8qUPDSKn0DHT6NimyjPADKZ8fyDREIkRUefiPbZSBtcNgQsIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694974372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAP5sltfIcvMA4Q2ijBQ4PWfxzckzT5fgVQ66E1pkdo=;
        b=5/l1GVMCPIPIz70/jw76Oangr4ZLCZgtBDLYvPo/apb/EmMaQY7whssCCgP66Lc1mQlHa6
        AAQBJD4DX4QXwLDA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Grab kernel_info offset from zoffset header
 directly
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230915171623.655440-11-ardb@google.com>
References: <20230915171623.655440-11-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169497437238.27769.749289405935929274.tip-bot2@tip-bot2>
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

Commit-ID:     2e765c02dcbfc2a8a4527c621a84b9502f6b9bd2
Gitweb:        https://git.kernel.org/tip/2e765c02dcbfc2a8a4527c621a84b9502f6b9bd2
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 15 Sep 2023 17:16:25 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 19:48:42 +02:00

x86/boot: Grab kernel_info offset from zoffset header directly

Instead of parsing zoffset.h and poking the kernel_info offset value
into the header from the build tool, just grab the value directly in the
asm file that describes this header.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-11-ardb@google.com
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6059f87..5575d0f 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -526,7 +526,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 10b0207..14ef13f 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -337,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -419,8 +417,6 @@ int main(int argc, char ** argv)
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
