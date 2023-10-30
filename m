Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57727DBBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJ3OZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJ3OZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:25:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF29D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:25:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF9D521D09;
        Mon, 30 Oct 2023 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698675922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3iQt5G91J6sbDJSILGZsPCJYY2SyUk44Azdroc+sL6s=;
        b=iAPjbKUTc5G4JV+D/wYKw7PVbHI5C4U9dvqfFUrYhPpyFCsFWgJnnP9GXdhNYChDaUUjmp
        3p7x54hf+qEOkCeKdQhz6OI9Gc/QOqFPYEZM30yud6i/sYTQwoa2hHJxQxSWa+4TIYWiVq
        lNTnCkfDj+/4V4PZ4oxRRAS1XRYONjU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D30C138F8;
        Mon, 30 Oct 2023 14:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yvb2HNK8P2XmQAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 30 Oct 2023 14:25:22 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 2/5] x86/alternative: add indirect call patching
Date:   Mon, 30 Oct 2023 15:25:05 +0100
Message-Id: <20231030142508.1407-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231030142508.1407-1-jgross@suse.com>
References: <20231030142508.1407-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/include/asm/alternative.h |  9 ++++++
 arch/x86/kernel/alternative.c      | 45 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 484f16dfc429..2a74a94bd569 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -10,6 +10,9 @@
 
 #define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_FLAG_CALL		(1 << 1)
+#define ALT_CALL(feature)	((ALT_FLAG_CALL << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_CALL_ALWAYS		ALT_CALL(X86_FEATURE_ALWAYS)
 
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
index ff9ad30a9484..dd14db12c573 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,45 @@ noinstr void BUG_func(void)
 }
 EXPORT_SYMBOL_GPL(BUG_func);
 
+/*
+ * Rewrite the "call BUG_func" replacement to point to the target of the
+ * indirect pv_ops call "call *disp(%ip)".
+ */
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+{
+	void *target, *bug = &BUG_func;
+
+	if (a->replacementlen != 5 || insn_buff[0] != CALL_INSN_OPCODE) {
+		pr_err("Alternative: ALT_FLAG_CALL set for a non-call replacement instruction\n");
+		pr_err("  Ignoring the flag for the instruction at %pS (%px)\n", instr, instr);
+		return 5;
+	}
+
+	if (a->instrlen != 6 || instr[0] != 0xff || instr[1] != 0x15) {
+		pr_err("Alternative: ALT_FLAG_CALL set for unrecognized indirect call\n");
+		pr_err("  Not replacing the instruction at %pS (%px)\n", instr, instr);
+		return -1;
+	}
+
+#ifdef CONFIG_X86_64
+	/* ff 15 00 00 00 00   call   *0x0(%rip) */
+	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
+#else
+	/* ff 15 00 00 00 00   call   *0x0 */
+	target = *(void **)(*(s32 *)(instr + 2));
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
@@ -462,6 +501,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
+		if (a->flags & ALT_FLAG_CALL) {
+			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+			if (insn_buff_sz < 0)
+				continue;
+		}
+
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-- 
2.35.3

