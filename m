Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885079435C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbjIFTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjIFS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:59:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79551717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:59:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so117384a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694026790; x=1694631590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=276KKM87k7JPS03fWRSBAhab8yYbGj1pfUBVIYq9nXc=;
        b=bojjjfDyeEzBhcJt0eQVPHMmJU4Vy1zNPfDG6eLwgYYu9mDgVq8Q0fovC57tY9EbgD
         c0gawPT6QAvCWtx44pRioojZizZX6jqU1Q5RIoGiiJ14L46zDY9C6Q2hlDLazUvmsfkv
         7ef18DV1yP57yWsdgiCbyy4jx6K+PsarqaZG71cxKOsXdhDF1+7OELhX8IOJHBz4MzBl
         Yr+KsK0w6CpZe/Kwt3SsxOwv9UElzEIGOhOpIec4PnN4H0odpeghHIH29B+AgD0BhGr7
         TL/0nK6ISXplHxJlprTTuv3SNnGW6QSDbbrpOxrL0qoUOzNfqgbaqtMzhp07MePS+0Ut
         Sgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026790; x=1694631590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=276KKM87k7JPS03fWRSBAhab8yYbGj1pfUBVIYq9nXc=;
        b=dmqMPgjkFHpWWgVjnV1SnWr3iDR/0IXEZXJfqD+Y9yln8bUFoSfSC0ds4OOHEgh0h4
         kPfncnLCKLrkFr2L5IbXcjsYT9FWppvSbBwwk9jWrZUOj+OqGeVuMgBTIdyxrQwV9/KL
         IRLMEJ7V8GEaC5fF3l/i5yK5sNNseBsHqodEVxDI0vN37stHtl2zP99UgWGzm1bRUdKk
         IlYMBN9q3IpMtkR2ZZIJp/2q1F1+ynNmisL0FwNXrc1trG27AZa3FHUVTgb8GfEJccbn
         Cd74AejVIAToRdrzXFM/iAtc65l88NEkRL2pbcuJ5TiAbLzueY4a2p9M57lPYcHZHFQq
         VhJw==
X-Gm-Message-State: AOJu0YwwYj8ToAVuKMKtXyWwJ/EPcAA64Q/lWwAImT4lWj3TuN4kEfTn
        FCBb1/GxNT0MlOJlpJSL0kw=
X-Google-Smtp-Source: AGHT+IG2BDKoyEgFNGH2VDWeYuqsWCnknWAs4D+C+BWim7gAMZS1R98Sf6eaQCCMlJR5aKtwR9BJLA==
X-Received: by 2002:a17:907:2c75:b0:99b:dd1d:64ba with SMTP id ib21-20020a1709072c7500b0099bdd1d64bamr3231759ejc.50.1694026789829;
        Wed, 06 Sep 2023 11:59:49 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b0099cc402d3ddsm9217955ejb.202.2023.09.06.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:59:49 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
Date:   Wed,  6 Sep 2023 20:58:44 +0200
Message-ID: <20230906185941.53527-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define target-specific {raw,this}_cpu_try_cmpxchg64 and
{raw,this}_cpu_try_cmpxchg128 macros. These definitions override
the generic fallback definitions and enable target-specific
optimized implementations.

Several places in mm/slub.o improve from e.g.:

    53bc:	48 8d 4f 40          	lea    0x40(%rdi),%rcx
    53c0:	48 89 fa             	mov    %rdi,%rdx
    53c3:	49 8b 5c 05 00       	mov    0x0(%r13,%rax,1),%rbx
    53c8:	4c 89 e8             	mov    %r13,%rax
    53cb:	49 8d 30             	lea    (%r8),%rsi
    53ce:	e8 00 00 00 00       	call   53d3 <...>
			53cf: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    53d3:	48 31 d7             	xor    %rdx,%rdi
    53d6:	4c 31 e8             	xor    %r13,%rax
    53d9:	48 09 c7             	or     %rax,%rdi
    53dc:	75 ae                	jne    538c <...>

to:

    53bc:	48 8d 4a 40          	lea    0x40(%rdx),%rcx
    53c0:	49 8b 1c 07          	mov    (%r15,%rax,1),%rbx
    53c4:	4c 89 f8             	mov    %r15,%rax
    53c7:	48 8d 37             	lea    (%rdi),%rsi
    53ca:	e8 00 00 00 00       	call   53cf <...>
			53cb: R_X86_64_PLT32	this_cpu_cmpxchg16b_emu-0x4
    53cf:	75 bb                	jne    538c <...>

reducing the size of mm/slub.o by 80 bytes:

   text    data     bss     dec     hex filename
  39758    5337    4208   49303    c097 slub-new.o
  39838    5337    4208   49383    c0e7 slub-old.o

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d730463..4c3641927f39 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -237,12 +237,47 @@ do {									\
 
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg64_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u64 *_oval = (u64 *)(_ovalp);					\
+	union {								\
+		u64 var;						\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "esi");					\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg64_op(8,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg64_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 #ifdef CONFIG_X86_64
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
 
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg_op(8,         , pcp, ovalp, nval);
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval);
+
 #define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
@@ -269,6 +304,38 @@ do {									\
 
 #define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
 #define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg128_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u128 *_oval = (u128 *)(_ovalp);					\
+	union {								\
+		u128 var;						\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "rsi");					\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
 #endif
 
 /*
-- 
2.41.0

