Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD07E9B72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjKMLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKMLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:52:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F63D6D;
        Mon, 13 Nov 2023 03:52:46 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699876364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zi02sD89LPlH8uLlp7X1mPLBNiLp7U3VPX96M0xr2FU=;
        b=UEfCYzuuCupns2FPfK92kW94mFfK/+59IDtM9/2QPjEMajuwNLguSa9vOmUvpuxfojR4C0
        ZcEk2zfrXT7tbhYX8n7gS0dXvt7pBnohdrTwuyW2BPotSgx+IHZapa1PJhQxR4nmk+odLY
        AfKTWpwyDhnAkufW+D7S+JLX7fTE5s3CUVvx1U0/VJ3ImgmS9wd/Ey8NPMjugC33Xh7zYI
        u1/2sbbGDYdHWT4hjAAZoVc3JDH84ZTHQFJ1FEm1O2YSe5EZO5+2lRxGeypIEU+TGSMJq5
        5oWj2ehsC0BT21vwgY5C0Lg09hemmlvCxYb/V6mtAgzy/bhgk1nHOu5O7/WC0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699876364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zi02sD89LPlH8uLlp7X1mPLBNiLp7U3VPX96M0xr2FU=;
        b=HrmgOVbPZZlhNAMUjAIZjnJBb3GDsunVrC4jgRMQY7MOxjlxiGemthgmGP2dAuMCQoWiM2
        ovHiWb0By+SCX9BA==
From:   "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Use relative reference for the
 original instruction offset
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9e6053107fbaabc0d33e5d2865c5af2c67ec9925=2E16863?=
 =?utf-8?q?01237=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3C9e6053107fbaabc0d33e5d2865c5af2c67ec9925=2E168630?=
 =?utf-8?q?1237=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169987636414.3135.6610650526442498008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     5c22c4726e4a9c6b2e182c0b21c2d3dd63f608c4
Gitweb:        https://git.kernel.org/tip/5c22c4726e4a9c6b2e182c0b21c2d3dd63f608c4
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Fri, 09 Jun 2023 17:45:31 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Nov 2023 12:23:27 +01:00

x86/paravirt: Use relative reference for the original instruction offset

Similar to the alternative patching, use a relative reference for original
instruction offset rather than absolute one, which saves 8 bytes for one
PARA_SITE entry on x86_64.  As a result, a R_X86_64_PC32 relocation is
generated instead of an R_X86_64_64 one, which also reduces relocation
metadata on relocatable builds. Hardcode the alignment to 4 now.

  [ bp: Massage commit message. ]

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/9e6053107fbaabc0d33e5d2865c5af2c67ec9925.1686301237.git.houwenlong.hwl@antgroup.com
---
 arch/x86/include/asm/paravirt.h       | 10 +++++-----
 arch/x86/include/asm/paravirt_types.h |  8 ++++----
 arch/x86/kernel/alternative.c         |  8 +++++---
 arch/x86/kernel/callthunks.c          |  2 +-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6c8ff12..d9384e9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -743,16 +743,16 @@ void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, ops, word, algn)		\
+#define _PVSITE(ptype, ops)			\
 771:;						\
 	ops;					\
 772:;						\
 	.pushsection .parainstructions,"a";	\
-	 .align	algn;				\
-	 word 771b;				\
+	 .align	4;				\
+	 .long 771b-.;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 _ASM_ALIGN;				\
+	 .align 4;				\
 	.popsection
 
 
@@ -760,7 +760,7 @@ void native_pv_lock_init(void) __init;
 #ifdef CONFIG_PARAVIRT_XXL
 
 #define PARA_PATCH(off)		((off) / 8)
-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 #ifdef CONFIG_DEBUG_ENTRY
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 772d034..e1bfb71 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch_site {
-	u8 *instr;		/* original instructions */
+	s32 instr_offset;	/* original instructions */
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 };
@@ -263,11 +263,11 @@ extern struct paravirt_patch_template pv_ops;
 #define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
-	_ASM_ALIGN "\n"					\
-	_ASM_PTR " 771b\n"				\
+	"  .align 4\n"					\
+	"  .long 771b-.\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	_ASM_ALIGN "\n"					\
+	"  .align 4\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be393..be35c8c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1431,20 +1431,22 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 {
 	struct paravirt_patch_site *p;
 	char insn_buff[MAX_PATCH_LEN];
+	u8 *instr;
 
 	for (p = start; p < end; p++) {
 		unsigned int used;
 
+		instr = (u8 *)&p->instr_offset + p->instr_offset;
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
-		memcpy(insn_buff, p->instr, p->len);
-		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
+		memcpy(insn_buff, instr, p->len);
+		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
 
 		BUG_ON(used > p->len);
 
 		/* Pad the rest with nops */
 		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(p->instr, insn_buff, p->len);
+		text_poke_early(instr, insn_buff, p->len);
 	}
 }
 extern struct paravirt_patch_site __start_parainstructions[],
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e9ad518..57e5c2e 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -240,7 +240,7 @@ patch_paravirt_call_sites(struct paravirt_patch_site *start,
 	struct paravirt_patch_site *p;
 
 	for (p = start; p < end; p++)
-		patch_call(p->instr, ct);
+		patch_call((void *)&p->instr_offset + p->instr_offset, ct);
 }
 
 static __init_or_module void
