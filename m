Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CB7A1ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjIOJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjIOJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872FD1FFA;
        Fri, 15 Sep 2023 02:38:09 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694770669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bCKWANC2GXvzvUx2vkt1IGRivAk16ALP4TvP76bo+4=;
        b=tTMDtsU0+khuJpFGwX0ejZyYNxb2rGnjR8eLr22bGdn94qpBXFY4E92WjskcVzgU7AafLH
        9mtbR8SvOWQUYUN5Le/9XuTGSB1lt2F0LT4GkKJ6DG/qC8liZcmBHPDSWUbpyg1gt9fQ+R
        bJkU63Yen8Geg6W+YakCypetaD56Oxtiara/u3qkmI1zL6S3BsoYo+ntW9yQHuHr9JW8Zc
        +l+Ri2GEKE3OgGGnsaj8VKEoJynaIzeTZNFeE/3l6I74RoJ3p7XxdDntv2/VS0L+h3caVl
        EBU5lIXhBxBd5OrztkG2Aoo/+SzXj2F8IP0K2roXx4AwutHda15ADdYcURyOMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694770669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bCKWANC2GXvzvUx2vkt1IGRivAk16ALP4TvP76bo+4=;
        b=9H0WzwOgfkjKB4b1ZAa3MFn874cRBtrEElkoFEMG9Gsp5YWTbdbEatlXc8tFscBuLUwRXT
        /QmzD7lf8eEgyiAQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efi: Drop alignment flags from PE section headers
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912090051.4014114-20-ardb@google.com>
References: <20230912090051.4014114-20-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169477066885.27769.9830822733543215583.tip-bot2@tip-bot2>
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

Commit-ID:     bfab35f552ab3dd6d017165bf9de1d1d20f198cc
Gitweb:        https://git.kernel.org/tip/bfab35f552ab3dd6d017165bf9de1d1d20f198cc
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 09:00:54 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 11:18:41 +02:00

x86/efi: Drop alignment flags from PE section headers

The section header flags for alignment are documented in the PE/COFF
spec as being applicable to PE object files only, not to PE executables
such as the Linux bzImage, so let's drop them from the PE header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-20-ardb@google.com
---
 arch/x86/boot/header.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b04ca8e..8c8148d 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -209,8 +209,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -230,8 +229,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -249,8 +247,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -271,8 +268,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
