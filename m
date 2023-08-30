Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA878DFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbjH3TMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbjH3PQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41075E8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a1de3417acso222168466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408595; x=1694013395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OOKbT4FJuE87W3c+tcAZEG/K9HCBdEeJeMYqb3buhY=;
        b=blvYceGJYBCSSmOcPcD//vbaE+Bxuo4rGKEqxd9LIEsTt01WHF0YAFtcXrD073lmpE
         +zxyOIQK7XXNf+YiLg9bgv2WXg7vdn/l4xVbB6VFojrUJAfFv5Zaqy0qW/y3G3g79B94
         ktjIImwHQNcOT93LGe7YzJAVvmNs7OMDtAGdilfQIw6yZRFe2WJFx2j1zJlSkTssywno
         0F3Wb2YPNvbhn6P1Qcr7tkJOvfGTrsKu21UtYtzq1GV8KCxrkFul4kdQ5dChTTFUzxDn
         M3uWTTRjPX2mVKoxfhjix7fbQngOq6yqgUXkQEdbPK+qoFeUgFgKLIZN34B8Tg/h7lbn
         M+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408595; x=1694013395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OOKbT4FJuE87W3c+tcAZEG/K9HCBdEeJeMYqb3buhY=;
        b=SC+YjWk2B4YK9HrboRMi0CHz5ntR71mJl/9Nr0e9dZSPigLiFErNKgO3v8/NK9+ZiO
         UbbA3rxBxPaU7rxDOoBuRdNSMcoLn/MawHHzOuqO0EMe+Cfv4HnFk0F1+7jNs56tL6Hg
         5SJs44ZgiBYGecPKgF2DqcKsNa6eiF7+x9LEHys+drcl8tGicbxwYGAURuw7KYLqQqAf
         lKhWMZEd5egHVYf8DqgIOmA007By578RsHe1xCwjO/wBT4TOZtoKW6x2auhnbQWQRivd
         GXLB29jvxZ3Qq/0WjHDTJT7wa/6UQmy9YkUDB3LYM+YjAjZTxmQT5ueIRSIvh+035dDK
         it8A==
X-Gm-Message-State: AOJu0YwY1NBZ15nIxb4CTli0Mw0NIj8Va9Y9rLdIFs0xGGklY09FDLBL
        iCKHYn5ZZfg8Ki+F2Bq4jkc=
X-Google-Smtp-Source: AGHT+IFhCZjxUpWtdQX1ulKwaHofL3BCxgKfYCU/qHlEvwR+9RXl9oOtDSNb2t50CM5d6xjzYVshLA==
X-Received: by 2002:a17:906:5d16:b0:9a1:ee8c:7f3b with SMTP id g22-20020a1709065d1600b009a1ee8c7f3bmr6261358ejt.7.1693408594455;
        Wed, 30 Aug 2023 08:16:34 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709063e0b00b009a1a653770bsm7241627eji.87.2023.08.30.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/percpu: Define raw_cpu_try_cmpxchg and this_cpu_try_cmpxchg
Date:   Wed, 30 Aug 2023 17:13:56 +0200
Message-ID: <20230830151623.3900-1-ubizjak@gmail.com>
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

Define target-specific raw_cpu_try_cmpxchg_N and
this_cpu_try_cmpxchg_N macros. These definitions override
the generic fallback definitions and enable target-specific
optimized implementations.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d730463..c8309f260d98 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,25 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#define percpu_try_cmpxchg_op(size, qual, _var, _ovalp, _nval)		\
+({									\
+	bool success;							\
+	__pcpu_type_##size *pco_oval__ = (__pcpu_type_##size *)(_ovalp); \
+	__pcpu_type_##size pco_old__ = *pco_oval__;			\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [oval] "+a" (pco_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pco_new__)		\
+		  : "memory");						\
+	if (unlikely(!success))						\
+		*pco_oval__ = pco_old__;				\
+	likely(success);						\
+})
+
 #if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
@@ -343,6 +362,9 @@ do {									\
 #define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, , pcp, ovalp, nval)
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
@@ -350,6 +372,9 @@ do {									\
 #define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, volatile, pcp, ovalp, nval)
 
 /*
  * Per cpu atomic 64 bit operations are only available under 64 bit.
@@ -364,6 +389,7 @@ do {									\
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
@@ -373,6 +399,7 @@ do {									\
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-- 
2.41.0

