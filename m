Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF37CA82D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjJPMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjJPMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:39:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1BB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:39:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DD4421958;
        Mon, 16 Oct 2023 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697459987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Dn2km2xrB+B5vKWOSjXaC3oIb3VD9PnFa2PlRKN8Us=;
        b=M7Ov8DqINADiD52TRl8/PYXfFhhBpU4i2WSWbMKAH+IiBF5C4W3TJ3t+AQ9ShNRFnVpH1P
        iurcbVMyuY847AEFOrrEtHbm9FtBGujgkm8gkLAEiyauSvnCMh4SZqUwh+focrVE6ewdKc
        0vkAnN76iDyYl7PzC6MCHWxPpVqjHgo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A8E5133B7;
        Mon, 16 Oct 2023 12:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O5JZARMvLWUbIwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 12:39:47 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/4] x86/alternative: add indirect call patching
Date:   Mon, 16 Oct 2023 14:39:31 +0200
Message-Id: <20231016123933.17284-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231016123933.17284-1-jgross@suse.com>
References: <20231016123933.17284-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-0.999];
         NEURAL_SPAM_LONG(3.00)[1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/include/asm/alternative.h |  5 ++++
 arch/x86/kernel/alternative.c      | 40 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 67e50bd40bb8..dd63b96577e9 100644
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
 
+#define ALT_CALL_INSTR		"call x86_BUG"
+
 #define b_replacement(num)	"664"#num
 #define e_replacement(num)	"665"#num
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1c8dd8e05f3f..01b89a10d219 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,40 @@ noinstr void x86_BUG(void)
 }
 EXPORT_SYMBOL_GPL(x86_BUG);
 
+/*
+ * Rewrite the "call x86_BUG" replacement to point to the target of the
+ * indirect pv_ops call "call *disp(%ip)".
+ */
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+{
+	void *target, *bug = &x86_BUG;
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
+	/* ff 15 00 00 00 00   call   *0x0(%rip) */
+	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
+	if (!target)
+		target = bug;
+
+	/* (x86_BUG - .) + (target - x86_BUG) := target - . */
+	*(s32 *)(insn_buff + 1) += target - bug;
+
+	if (target == &x86_nop)
+		return 0;
+
+	return 5;
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -462,6 +496,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
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

