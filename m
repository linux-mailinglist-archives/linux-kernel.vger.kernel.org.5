Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460BA7FD840
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjK2NeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjK2NeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:34:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C11990
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:34:09 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DADD21FCE8;
        Wed, 29 Nov 2023 13:34:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5441376F;
        Wed, 29 Nov 2023 13:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id oQk1Jc89Z2WVHwAAn2gu4w
        (envelope-from <jgross@suse.com>); Wed, 29 Nov 2023 13:34:07 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 3/5] x86/alternative: add indirect call patching
Date:   Wed, 29 Nov 2023 14:33:30 +0100
Message-Id: <20231129133332.31043-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129133332.31043-1-jgross@suse.com>
References: <20231129133332.31043-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DADD21FCE8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare replacing of paravirt patching with alternative
patching, add the capability to replace an indirect call with a direct
one to alternative patching.

This is done via a new flag ALT_FLAG_CALL as the target of the call
instruction needs to be evaluated using the value of the location
addressed by the indirect call. For convenience add a macro for a
default call instruction. In case it is being used without the new
flag being set, it will result in a BUG() when being executed. As in
most cases the feature used will be X86_FEATURE_ALWAYS add another
macro ALT_CALL_ALWAYS usable for the flags parameter of the ALTERNATIVE
macros.

For a complete replacement handle the special cases of calling a nop
function and an indirect call of NULL the same way as paravirt does.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V4:
- 32-bit mode doesn't have %rip relative addressing (kernel test robot)
- define ALT_CALL_INSTR in assembly, too (kernel test robot)
V5:
- BUG() in case of inconsistent flag/instruction (Boris Petkov)
- rename flag (Boris Petkov)
- make target address calculation more readable (Boris Petkov)
---
 arch/x86/include/asm/alternative.h |  9 ++++++
 arch/x86/kernel/alternative.c      | 47 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ce788ab4e77c..472334eed6f3 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -10,6 +10,9 @@
 
 #define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_FLAG_DIRECT_CALL	(1 << 1)
+#define ALT_DIRECT_CALL(feature) ((ALT_FLAG_DIRECT_CALL << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_CALL_ALWAYS		ALT_DIRECT_CALL(X86_FEATURE_ALWAYS)
 
 #ifndef __ASSEMBLY__
 
@@ -150,6 +153,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 }
 #endif	/* CONFIG_SMP */
 
+#define ALT_CALL_INSTR		"call BUG_func"
+
 #define b_replacement(num)	"664"#num
 #define e_replacement(num)	"665"#num
 
@@ -386,6 +391,10 @@ void nop_func(void);
 	.byte \alt_len
 .endm
 
+.macro ALT_CALL_INSTR
+	call BUG_func
+.endm
+
 /*
  * Define an alternative between two instructions. If @feature is
  * present, early code in apply_alternatives() replaces @oldinstr with
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ca25dd280b8c..e7e53b9e801b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,47 @@ noinstr void BUG_func(void)
 }
 EXPORT_SYMBOL_GPL(BUG_func);
 
+/*
+ * Rewrite the "call BUG_func" replacement to point to the target of the
+ * indirect pv_ops call "call *disp(%ip)".
+ */
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+{
+	void *target, *bug = &BUG_func;
+	s32 disp;
+
+	if (a->replacementlen != 5 || insn_buff[0] != CALL_INSN_OPCODE) {
+		pr_err("ALT_FLAG_DIRECT_CALL set for a non-call replacement instruction\n");
+		BUG();
+	}
+
+	if (a->instrlen != 6 || instr[0] != 0xff || instr[1] != 0x15) {
+		pr_err("ALT_FLAG_DIRECT_CALL set for unrecognized indirect call\n");
+		BUG();
+	}
+
+	disp = *(s32 *)(instr + 2);
+#ifdef CONFIG_X86_64
+	/* ff 15 00 00 00 00   call   *0x0(%rip) */
+	/* target address is stored at "next instruction + disp". */
+	target = *(void **)(instr + a->instrlen + disp);
+#else
+	/* ff 15 00 00 00 00   call   *0x0 */
+	/* target address is stored at disp. */
+	target = *(void **)disp;
+#endif
+	if (!target)
+		target = bug;
+
+	/* (BUG_func - .) + (target - BUG_func) := target - . */
+	*(s32 *)(insn_buff + 1) += target - bug;
+
+	if (target == &nop_func)
+		return 0;
+
+	return 5;
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -462,6 +503,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
+		if (a->flags & ALT_FLAG_DIRECT_CALL) {
+			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+			if (insn_buff_sz < 0)
+				continue;
+		}
+
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-- 
2.35.3

