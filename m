Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7480B941
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjLJGWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjLJGV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:21:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046AC102
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:22:00 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F0F01F821;
        Sun, 10 Dec 2023 06:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702189319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNFLcF3+dT84muIemKcGgbbF2fxsQQWEPZkaixQ+cIc=;
        b=RpqY6pE5NwywWzr4uICiXSRRoZHjvfzM8TPGq7uyjwuewg0PJRpWyCznJsvuWbtRsuHCby
        TPG5+n5DwW7CIaBceECIk5RCtEvdJ8fg1YW3lsFPbpBZyN5OYHs1+iQxDWI+YdhFyaaKqw
        wL59evcj5uYSUHyS4TFCfT9hyqTl3Ak=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1702189318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNFLcF3+dT84muIemKcGgbbF2fxsQQWEPZkaixQ+cIc=;
        b=msDKDzIzHXkH4NI3aveYDEjzxaSdMs8VcqJdDUhiUj51ZSm93FjgCZowcXsw4t+R17WEZz
        oMs7FjooxL7ZlRF8VtIdoMyM61kmzelR8ChAUcYStcUncHTAIEyFEVghm+Mz0S8Oh+2Em2
        6auiDfrbWz6yfGtTwWNEK0NabM5KALU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E1A7413240;
        Sun, 10 Dec 2023 06:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id +NTPNQVZdWUdewAAn2gu4w
        (envelope-from <jgross@suse.com>); Sun, 10 Dec 2023 06:21:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 3/5] x86/alternative: add indirect call patching
Date:   Sun, 10 Dec 2023 07:21:36 +0100
Message-Id: <20231210062138.2417-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231210062138.2417-1-jgross@suse.com>
References: <20231210062138.2417-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***************
X-Spam-Score: 15.95
X-Spamd-Result: default: False [-1.90 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.com:+];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         NEURAL_HAM_SHORT(-0.09)[-0.427];
         DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         R_SPF_FAIL(0.00)[-all];
         R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
         SPAM_FLAG(5.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         WHITELIST_DMARC(-7.00)[suse.com:D:+];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,infradead.org:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 2F0F01F821
X-Spam-Score: -1.90
Authentication-Results: smtp-out2.suse.de;
        dkim=pass header.d=suse.com header.s=susede1 header.b=msDKDzIz;
        spf=fail (smtp-out2.suse.de: domain of jgross@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=jgross@suse.com;
        dmarc=pass (policy=quarantine) header.from=suse.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- 32-bit mode doesn't have %rip relative addressing (kernel test robot)
- define ALT_CALL_INSTR in assembly, too (kernel test robot)
V5:
- BUG() in case of inconsistent flag/instruction (Boris Petkov)
- rename flag (Boris Petkov)
- make target address calculation more readable (Boris Petkov)
V6:
- make target address calculation even more readable (Boris Petkov)
- print flags value in DPRINTK() (Boris Petkov)
---
 arch/x86/include/asm/alternative.h |  9 +++++
 arch/x86/kernel/alternative.c      | 58 ++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

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
index ca25dd280b8c..888205234f15 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,53 @@ noinstr void BUG_func(void)
 }
 EXPORT_SYMBOL_GPL(BUG_func);
 
+#define CALL_RIP_REL_PREFIX	0xff
+#define CALL_RIP_REL_MODRM	0x15
+
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
+	if (a->instrlen != 6 ||
+	    instr[0] != CALL_RIP_REL_PREFIX ||
+	    instr[1] != CALL_RIP_REL_MODRM) {
+		pr_err("ALT_FLAG_DIRECT_CALL set for unrecognized indirect call\n");
+		BUG();
+	}
+
+	/* Skip CALL_RIP_REL_PREFIX and CALL_RIP_REL_MODRM */
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
@@ -452,16 +499,21 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
-			(a->flags & ALT_FLAG_NOT) ? "!" : "",
+		DPRINTK(ALT, "feat: %d32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen);
+			replacement, a->replacementlen, a->flags);
 
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

