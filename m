Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3D7F1763
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjKTPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjKTPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:34:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53DB4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:34:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332c46d5988so888040f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700494470; x=1701099270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3urVBxbF5NZPUeIYke5inWHKIb6xfBZ0lmHUZJ/m1IY=;
        b=FtTUpU2X5cQJWbcF8Cs8LgCW4n4FHQt/+tEUA4LrtBvFR9od4YCVNzsRd5YitYrExP
         7aKJw07oDLEEctj37088vIHugH3lTAf2ZG/XipwDljyeTqfhkXKxRgm1Rpkpn1vhQmSo
         tRlCNTpwS9H9ynXFDIZhg2depIcoeoNzVpHJUIUhEnttucdHk0+q/XfEHwgrGivQT605
         QN7tIBOhxL/Eg3F9FqTqmet1A9OCozZfzrKELvsoR9YVx5AsMMCi0zpj2vpWz1E+O4Ps
         YDC9S895601pk2idqRpJavrvV/AIK1fOhFIaRvvOZ/BCjnKZdWwPpn3SZ9Zllw7zulm7
         wgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494470; x=1701099270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3urVBxbF5NZPUeIYke5inWHKIb6xfBZ0lmHUZJ/m1IY=;
        b=WZ8Xp6sSm7NtzR7ey3MZFMPGtLEPfO3Y7KGuGaH2QkG9vcQSsXoqV21xG0/rHBB59I
         olNOBQq/Vy3VGmM6jxBEtmr8DD4KxI8zFBYk6KFYUAAf9BkPOqSa0YcZl5a+owqpbg+C
         fKP2xfmlVFKqxaE09HDt2oar+JW1EyWXmWZo23fhCTxmnl8Zgqs/x4AShLNEwxNZPBLG
         Xc8Mt3l0DI9OOlqmgYZLiRnCQaB0eTzfS5+/ArHWorWq8xtAmXiLVJUgocQ1r2EE2UaG
         aXnHBvPWhir+sfV45hKuLxP+iJiV7/sRa8b3FpKlr4wYQrbP7JOTJ77yL3WMnsA/kVRw
         d/4Q==
X-Gm-Message-State: AOJu0YyA+DDy0/gXFS//rafO0xUld45IRcAgF0djjKbPHwtD1IrW0s8l
        O5+Fk0bMwx3dpixkGD2yQRE=
X-Google-Smtp-Source: AGHT+IFzZpgEP+NrwDy5i54MbXIVNrrlgn9FMmtroSvGF406FBhWo9xOtPosqpUdEfVe+JR7v9Ximw==
X-Received: by 2002:a5d:6d0a:0:b0:32f:c5ea:72ac with SMTP id e10-20020a5d6d0a000000b0032fc5ea72acmr5924188wrq.46.1700494469688;
        Mon, 20 Nov 2023 07:34:29 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b0032f9688ea48sm11555870wrd.10.2023.11.20.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:34:29 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm/encrypt: Use %a asm operand modifier to obtain %rip-relative address
Date:   Mon, 20 Nov 2023 16:33:50 +0100
Message-ID: <20231120153419.3045-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "a" asm operand modifier substitutes a memory reference, with the
actual operand treated as address.  For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym".

Clang allows only "i" and "r" operand constraints with an "a" modifier,
so the patch normalizes the modifier/constraint pair to "a"/"i"
which is consistent between both compilers.

No functional change intended.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d73aeb16417f..6a351fdd1b39 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -346,9 +346,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * We're running identity mapped, so we must obtain the address to the
 	 * SME encryption workarea using rip-relative addressing.
 	 */
-	asm ("lea sme_workarea(%%rip), %0"
-	     : "=r" (workarea_start)
-	     : "p" (sme_workarea));
+	asm ("lea %a1, %0" : "=r" (workarea_start) : "i" (sme_workarea));
 
 	/*
 	 * Calculate required number of workarea bytes needed:
@@ -582,15 +580,9 @@ void __init sme_enable(struct boot_params *bp)
 	 * identity mapped, so we must obtain the address to the SME command
 	 * line argument data using rip-relative addressing.
 	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
+	asm ("lea %a1, %0" : "=r" (cmdline_arg) : "i" (sme_cmdline_arg));
+	asm ("lea %a1, %0" : "=r" (cmdline_on) : "i" (sme_cmdline_on));
+	asm ("lea %a1, %0" : "=r" (cmdline_off) : "i" (sme_cmdline_off));
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
 		active_by_default = true;
-- 
2.41.0

