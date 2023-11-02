Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F17DF127
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347403AbjKBL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbjKBL3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:29:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD3132
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:29:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40838915cecso6059665e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698924543; x=1699529343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENp6FOnR5GB+Ukedmf+eZL7XOs80yvuA3UZNbpkC5yw=;
        b=G1tZ92eN5IySeufq2ZBdtSRSw7mWs+skrMYclDOcRVZe4WsIwizZ5r65TSheopW/sp
         HXvIL9OYaFr30xNuv2Os3ESCHp2FTJx6UpIIuPrlvdotPMOYEh8FOOELKRwwIyvBA0o7
         coLu3P+wbbOBhTdmtV1H+6V283ooP3/3Uxe0eVYAkJUimEuOIi3e30iEdCOEhb6DS6Wv
         j/1ha5z10KRtlLh8tbUEM6yrvw2VW43oo+75DdNeCDkLSL78YHnWFIUEbnFUhxLnyThc
         LktOqAB6avs5GESbdtpsHZxojtIwzldTkXDa6tLiNSL6iukB1K2dFFs967EdnSXYkOQ1
         uiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924543; x=1699529343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENp6FOnR5GB+Ukedmf+eZL7XOs80yvuA3UZNbpkC5yw=;
        b=Rz2N3PSEXJX6emBREhE67BwCZv2hoaemZ8v/OXaSOfwRQ/COtSINQ0CPmCP9WUA3GC
         1pNhuNHAcw3tWmx6HmwvNJ/Hcw85ZKZJBiCrGVfKT8cZvLHbCFdARyZiYaVwZnpfSffZ
         VnWOCcnu7nVi4KGBmdw3HoK4CO4GmlV4yWPX1L0kG0TeqKIVgibOKp+3ba4wSyCvLpqm
         bsvvADKhJu3IhSpNEanOE5XH/CCj7Kmh1DH3CtP9/R+8E1Jv3eRVHibZxXKE2Fcy8L17
         jKrqF2Nkr1eXFgUZT/uRM7okCCdDAEdVyYX4TiETK3BTtSZbnzfKzRv0cClgkE+17+5K
         dtKQ==
X-Gm-Message-State: AOJu0YyUaAkwtD6CG3xgA3kWcRdrFy4KNGrjklgdf3vBys9qtOlO4nrA
        3FKi32NWK6ScJOo9plYHUcU=
X-Google-Smtp-Source: AGHT+IEndYIk0+Gp9DXyJ9utA2kH9YVSYrwleZ0ulRNCDC2KtYX9W4mCslo1kZ3QVmWe+zQP7Uy/Bw==
X-Received: by 2002:a05:6000:686:b0:32f:9ac4:6f29 with SMTP id bo6-20020a056000068600b0032f9ac46f29mr6281726wrb.70.1698924543282;
        Thu, 02 Nov 2023 04:29:03 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d4f8a000000b003232f167df5sm2168227wru.108.2023.11.02.04.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:29:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] x86/callthunks: Handle %rip-relative relocations in call thunk template
Date:   Thu,  2 Nov 2023 12:25:47 +0100
Message-ID: <20231102112850.3448745-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102112850.3448745-1-ubizjak@gmail.com>
References: <20231102112850.3448745-1-ubizjak@gmail.com>
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
call thunk templates.  Implement minimal support for relocations
when copying template from its storage location to handle %rip-relative
addresses.

Support for relocations will be needed when PER_CPU_VAR macro switches
to %rip-relative addressing.

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
 arch/x86/kernel/callthunks.c | 63 ++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index d0922cf94c90..bda09d82bff7 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -24,6 +24,8 @@
 
 static int __initdata_or_module debug_callthunks;
 
+#define MAX_PATCH_LEN (255-1)
+
 #define prdbg(fmt, args...)					\
 do {								\
 	if (debug_callthunks)					\
@@ -166,13 +168,51 @@ static const u8 nops[] = {
 	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
 };
 
+#define apply_reloc_n(n_, p_, d_)				\
+	do {							\
+		s32 v = *(s##n_ *)(p_);				\
+		v += (d_);					\
+		BUG_ON((v >> 31) != (v >> (n_-1)));		\
+		*(s##n_ *)(p_) = (s##n_)v;			\
+	} while (0)
+
+static __always_inline
+void apply_reloc(int n, void *ptr, uintptr_t diff)
+{
+	switch (n) {
+	case 4: apply_reloc_n(32, ptr, diff); break;
+	default: BUG();
+	}
+}
+
+static void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src)
+{
+	for (int next, i = 0; i < len; i = next) {
+		struct insn insn;
+
+		if (WARN_ON_ONCE(insn_decode_kernel(&insn, &buf[i])))
+			return;
+
+		next = i + insn.length;
+
+		if (insn_rip_relative(&insn))
+			apply_reloc(insn.displacement.nbytes,
+				    buf + i + insn_offset_displacement(&insn),
+				    src - dest);
+	}
+}
+
 static void *patch_dest(void *dest, bool direct)
 {
 	unsigned int tsize = SKL_TMPL_SIZE;
+	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *pad = dest - tsize;
 
+	memcpy(insn_buff, skl_call_thunk_template, tsize);
+	apply_relocation(insn_buff, tsize, pad, skl_call_thunk_template);
+
 	/* Already patched? */
-	if (!bcmp(pad, skl_call_thunk_template, tsize))
+	if (!bcmp(pad, insn_buff, tsize))
 		return pad;
 
 	/* Ensure there are nops */
@@ -182,9 +222,9 @@ static void *patch_dest(void *dest, bool direct)
 	}
 
 	if (direct)
-		memcpy(pad, skl_call_thunk_template, tsize);
+		memcpy(pad, insn_buff, tsize);
 	else
-		text_poke_copy_locked(pad, skl_call_thunk_template, tsize, true);
+		text_poke_copy_locked(pad, insn_buff, tsize, true);
 	return pad;
 }
 
@@ -281,20 +321,26 @@ void *callthunks_translate_call_dest(void *dest)
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
+	apply_relocation(insn_buff, tmpl_size, pad, skl_call_thunk_template);
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
@@ -303,7 +349,10 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 	if (func && is_callthunk(func))
 		return 0;
 
-	memcpy(*pprog, tmpl, tmpl_size);
+	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
+	apply_relocation(insn_buff, tmpl_size, *pprog, skl_call_thunk_template);
+
+	memcpy(*pprog, insn_buff, tmpl_size);
 	*pprog += tmpl_size;
 	return tmpl_size;
 }
-- 
2.41.0

