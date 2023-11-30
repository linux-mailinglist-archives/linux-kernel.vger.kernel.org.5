Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF687FFD63
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbjK3VQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjK3VQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2978C4;
        Thu, 30 Nov 2023 13:16:34 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++ajJ8MhhDhnhvBDD8tcjV3Kz+H/QurA847J/WD+JG4=;
        b=Og4HQ6aSGps1amGSNvwSBdQemwXe9kfgvXjreUhh/9s1FA2ssrDDV42D//kQNUDsv3AGj1
        Fqvb2CHT9ZAo7rsK5nm0t5DZCdqBJXFpF/nefk9lC4zyyHH17mDAWEOYPXjvIgssDZdgno
        MAJJcqoeqzd/u82ULEYeF3UerH1H1rWO1kpLpDQJj6nc7Oi2S/l7nPcTPZfLFKlyu/6EK4
        CeTRPRICqR9R01dUcgfZMU4T5Q9Qsq67Hv194VNXGaZzlok3qFhJigLxnaMRvorOXlQ+MR
        eG+YlazlaTvgdSVQ2MhTsZiztS9CpQjJjOUaH2WET5AydhBW8TtK4TlkJHvJfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++ajJ8MhhDhnhvBDD8tcjV3Kz+H/QurA847J/WD+JG4=;
        b=mDAYyX0SeeYalVuZbQNBCNY8otQBLvEqQPuFQfvcd9jsYgXj4fbqQvZwJfuNrp8LbL+Eav
        r7Zu6qQQ1IyRHdCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/callthunks: Handle %rip-relative relocations in
 call thunk template
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231105213731.1878100-3-ubizjak@gmail.com>
References: <20231105213731.1878100-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899278.398.5103495389558631726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     17bce3b2ae2d52e8c5c12274ce4c3a631ce9e66b
Gitweb:        https://git.kernel.org/tip/17bce3b2ae2d52e8c5c12274ce4c3a631ce9e66b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 05 Nov 2023 22:34:36 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:06:17 +01:00

x86/callthunks: Handle %rip-relative relocations in call thunk template

Contrary to alternatives, relocations are currently not supported in
call thunk templates.  Re-use the existing infrastructure from
alternative.c to allow %rip-relative relocations when copying call
thunk template from its storage location.

The patch allows unification of ASM_INCREMENT_CALL_DEPTH, which already
uses PER_CPU_VAR macro, with INCREMENT_CALL_DEPTH, used in call thunk
template, which is currently limited to use absolute address.

Reuse existing relocation infrastructure from alternative.c.,
as suggested by Peter Zijlstra.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231105213731.1878100-3-ubizjak@gmail.com
---
 arch/x86/include/asm/text-patching.h |  2 ++-
 arch/x86/kernel/alternative.c        |  3 +--
 arch/x86/kernel/callthunks.c         | 32 +++++++++++++++++++++------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c3..ba8d900 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,6 +18,8 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
+void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len);
+
 /*
  * Currently, the max observed size in the kernel code is
  * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a5ead6a..aa86415 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -325,8 +325,7 @@ bool need_reloc(unsigned long offset, u8 *src, size_t src_len)
 	return (target < src || target > src + src_len);
 }
 
-static void __init_or_module noinline
-apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
+void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 {
 	int prev, target = 0;
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index c06bfc0..f56fa30 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -24,6 +24,8 @@
 
 static int __initdata_or_module debug_callthunks;
 
+#define MAX_PATCH_LEN (255-1)
+
 #define prdbg(fmt, args...)					\
 do {								\
 	if (debug_callthunks)					\
@@ -184,10 +186,15 @@ static const u8 nops[] = {
 static void *patch_dest(void *dest, bool direct)
 {
 	unsigned int tsize = SKL_TMPL_SIZE;
+	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *pad = dest - tsize;
 
+	memcpy(insn_buff, skl_call_thunk_template, tsize);
+	apply_relocation(insn_buff, tsize, pad,
+			 skl_call_thunk_template, tsize);
+
 	/* Already patched? */
-	if (!bcmp(pad, skl_call_thunk_template, tsize))
+	if (!bcmp(pad, insn_buff, tsize))
 		return pad;
 
 	/* Ensure there are nops */
@@ -197,9 +204,9 @@ static void *patch_dest(void *dest, bool direct)
 	}
 
 	if (direct)
-		memcpy(pad, skl_call_thunk_template, tsize);
+		memcpy(pad, insn_buff, tsize);
 	else
-		text_poke_copy_locked(pad, skl_call_thunk_template, tsize, true);
+		text_poke_copy_locked(pad, insn_buff, tsize, true);
 	return pad;
 }
 
@@ -297,20 +304,27 @@ void *callthunks_translate_call_dest(void *dest)
 static bool is_callthunk(void *addr)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
-	void *tmpl = skl_call_thunk_template;
+	u8 insn_buff[MAX_PATCH_LEN];
 	unsigned long dest;
+	u8 *pad;
 
 	dest = roundup((unsigned long)addr, CONFIG_FUNCTION_ALIGNMENT);
 	if (!thunks_initialized || skip_addr((void *)dest))
 		return false;
 
-	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
+	*pad = dest - tmpl_size;
+
+	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, tmpl_size, pad,
+			 skl_call_thunk_template, tmpl_size);
+
+	return !bcmp(pad, insn_buff, tmpl_size);
 }
 
 int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
-	void *tmpl = skl_call_thunk_template;
+	u8 insn_buff[MAX_PATCH_LEN];
 
 	if (!thunks_initialized)
 		return 0;
@@ -319,7 +333,11 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 	if (func && is_callthunk(func))
 		return 0;
 
-	memcpy(*pprog, tmpl, tmpl_size);
+	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, tmpl_size, *pprog,
+			 skl_call_thunk_template, tmpl_size);
+
+	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog += tmpl_size;
 	return tmpl_size;
 }
