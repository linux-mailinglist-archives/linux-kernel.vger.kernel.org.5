Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102C97E16DE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjKEVhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKEVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:37:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDEFCC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:37:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so9636179a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699220264; x=1699825064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWoTXFWh8QhoMIOAEXcP9Z3H1Z7HK9iPUfGCUZ9d8xA=;
        b=kfP3BLMj31VbHR5yLGP2TgI5Qrcfh6F268pJAznApGtPiHxDAO1AdFewCgqoNsYK+2
         q+jdoou+hqBYW0Hc2sNBeWIMZmq4FTly6B7XQgbEa/pSgkWrsbgjoAMjlm5namqLS4vL
         A0Kfizk2wAlOlT1WVH5ur6lXFp9P6dEZ9o+eFEUdeZcvrvP4ZWt5MMeJaA008BeIJrFt
         MFQfbNL4TXSuxjf5kVMb4H7ap1P0LVGLuxmqePzhaTt7eTsHBJLp9BDoCMgZ1RUZuXWx
         nwjJxBrVgGWNsuFYPUHXk4RAbolnnhHj0BxFEUmjEmKk7MbTmQdidIFinJC/sY1wmE+t
         oCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699220264; x=1699825064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWoTXFWh8QhoMIOAEXcP9Z3H1Z7HK9iPUfGCUZ9d8xA=;
        b=hddOKAB9W31mHWdDXU3IHKZL9wmi7fnwoPw7P3nGwwSzcFS9fvs78xS1muBxSjJVLt
         n+uGSC94pg6GmmuMpgApi51/pCzBdXZ3C9NILofahsskTESM8Uy4MQCVWxduvLgm+jaK
         JK8/TsPrsGxd7g5a51AVNgvlnoomJVOCOiS7lD35HGB8/jrbJgqS+R2czHv3zgQlA1tn
         z6yKUq6kM4a4d+LzCfe2K4f90z9GJq5jB3TUtiztHo3lzFb1oZx7Y77zM4+YfqB02+P4
         ZmyPUW2eFAMPmEVpbBnSuhsQzlGHc1Nkhss8+qSxJf09JzIO5Lk3TRIdWAAj6Bvty9w8
         Ux0w==
X-Gm-Message-State: AOJu0Yw1rsz2gXcHfU9GLT6BZQ0ndrVKCTtby3JGr1QSykk46Hrh9QJU
        xEE+SpBxqua0jCupCkmy+6Y=
X-Google-Smtp-Source: AGHT+IGyuFhdDqaEX51WwdMsmORV8JuNrCfbBLptM4ba0fIP9R5uSRLc3pqGrspyQbkr2ACSwX0kDQ==
X-Received: by 2002:a17:907:e8d:b0:9de:9ecb:eb03 with SMTP id ho13-20020a1709070e8d00b009de9ecbeb03mr4469048ejc.33.1699220263848;
        Sun, 05 Nov 2023 13:37:43 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709064e5700b009c5c5c2c5a4sm3386559ejw.219.2023.11.05.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:37:42 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip v2 2/3] x86/callthunks: Handle %rip-relative relocations in call thunk template
Date:   Sun,  5 Nov 2023 22:34:36 +0100
Message-ID: <20231105213731.1878100-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105213731.1878100-1-ubizjak@gmail.com>
References: <20231105213731.1878100-1-ubizjak@gmail.com>
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

Contrary to alternatives, relocations are currently not supported in
call thunk templates.  Re-use the existing infrastructure from
alternative.c to allow %rip-relative relocations when copying call
thunk template from its storage location.

The patch allows unification of ASM_INCREMENT_CALL_DEPTH, which already
uses PER_CPU_VAR macro, with INCREMENT_CALL_DEPTH, used in call thunk
template, which is currently limited to use absolute address.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Reuse existing relocation infrastructure from alternative.c.
---
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        |  3 +--
 arch/x86/kernel/callthunks.c         | 32 ++++++++++++++++++++++------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c338cdc..ba8d900f3ebe 100644
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
index 73be3931e4f0..66140c54d4f6 100644
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
index e9ad518a5003..ef9c04707b3c 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -24,6 +24,8 @@
 
 static int __initdata_or_module debug_callthunks;
 
+#define MAX_PATCH_LEN (255-1)
+
 #define prdbg(fmt, args...)					\
 do {								\
 	if (debug_callthunks)					\
@@ -179,10 +181,15 @@ static const u8 nops[] = {
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
@@ -192,9 +199,9 @@ static void *patch_dest(void *dest, bool direct)
 	}
 
 	if (direct)
-		memcpy(pad, skl_call_thunk_template, tsize);
+		memcpy(pad, insn_buff, tsize);
 	else
-		text_poke_copy_locked(pad, skl_call_thunk_template, tsize, true);
+		text_poke_copy_locked(pad, insn_buff, tsize, true);
 	return pad;
 }
 
@@ -291,20 +298,27 @@ void *callthunks_translate_call_dest(void *dest)
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
@@ -313,7 +327,11 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
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
-- 
2.41.0

