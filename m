Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE31E7750CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHICO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjHICOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C01BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzQb2VuQCXwMdF/Rvu48wxhx8ntZSb1KliAOBLDDWgc=;
        b=VTf0kHbf7syq69H4/SQEYMO9GkiNYyaTPxkSTZu+98gfHMc7u8FW4BPIxfYo1tKRp5P3Ah
        MoH0q9QGqh0dhWyduypETmfPdlS0ewAek7a22/afqNGywudfH0TC/QFyZPwZsZZbL2Bqcj
        gM8yJDNLy2kI7XZCOUm6LZGOsy8WhiM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-CDIct0agM8-iaz0Gjnwp2g-1; Tue, 08 Aug 2023 22:14:09 -0400
X-MC-Unique: CDIct0agM8-iaz0Gjnwp2g-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a73fbef692so12356399b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547249; x=1692152049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzQb2VuQCXwMdF/Rvu48wxhx8ntZSb1KliAOBLDDWgc=;
        b=LHXAc9nM6zHt59Gqpc09SlFcQ6zr4302QgGsqUh+NHYPLqec5IW3Vung9dR3yyiPZN
         Wa2/0XDCI+p/pzPy65mFjN49uKhls8vFRJ24HVH0DQJhJJf8B3AD6UMScN8z5psXlTbX
         +p6JsQDcDhkOaT3c6WTWwX/GGGDAyI3+HVzdQkbw9JuVDEo/SXAb44m7otbbBTvhAxSk
         05Ik0BDqE7hR2MGJfzMKOvwD51JyLqOeKDwHpnukYIB4kLM76AtAEQ3yJE+TtmYnkTHT
         qbSYLftnTi1M4bOWmydnke4+mXR3n2Vi/r6gly2QG8W+wwiPa97jTk5fFXXb73fjFwXd
         QWjQ==
X-Gm-Message-State: AOJu0YzjMoxFMm4U/HnbOLATkI5lCSRVDsAywgXj2xYFTsRN65huRs9Q
        JsRXwKCvCNq/tqE3dKHC0c0364/sfFOHIAx//Tb/9o37DNbwE0jndow/keDlabPfqUoe7p2zd81
        wqRfRdOjqfEEgWEA/3bztVuax
X-Received: by 2002:a05:6870:c082:b0:1bf:74cc:c815 with SMTP id c2-20020a056870c08200b001bf74ccc815mr1491705oad.19.1691547248946;
        Tue, 08 Aug 2023 19:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzmTXNkLqFmS1q1/FR/HeyFRU6fl+VZuoTT+xk0Lf/Zu30HJE0YhZ23Lp17N5hlJIuru2Olg==
X-Received: by 2002:a05:6870:c082:b0:1bf:74cc:c815 with SMTP id c2-20020a056870c08200b001bf74ccc815mr1491689oad.19.1691547248647;
        Tue, 08 Aug 2023 19:14:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm6475518ooj.47.2023.08.08.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:14:08 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v4 3/5] riscv/atomic.h : Deduplicate arch_atomic.*
Date:   Tue,  8 Aug 2023 23:13:08 -0300
Message-ID: <20230809021311.1390578-5-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809021311.1390578-2-leobras@redhat.com>
References: <20230809021311.1390578-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions use mostly the same asm for 32-bit and 64-bit versions.

Make a macro that is generic enough and avoid code duplication.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-----------------
 1 file changed, 76 insertions(+), 88 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f5dfef6c2153..80cca7ac16fd 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
+#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "     %[p],  %[c]\n"			\
+		"	beq	       %[p],  %[u], 1f\n"		\
+		"	add            %[rc], %[p], %[a]\n"		\
+		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
+		"	bnez           %[rc], 0b\n"			\
+		"	fence          rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		: [a]"r" (_a), [u]"r" (_u)				\
+		: "memory");						\
+})
+
 /* This is required to provide a full barrier on success. */
 static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w     %[p],  %[c]\n"
-		"	beq      %[p],  %[u], 1f\n"
-		"	add      %[rc], %[p], %[a]\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [a]"r" (a), [u]"r" (u)
-		: "memory");
+	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w");
+
 	return prev;
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
@@ -222,77 +228,86 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
        s64 prev;
        long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d     %[p],  %[c]\n"
-		"	beq      %[p],  %[u], 1f\n"
-		"	add      %[rc], %[p], %[a]\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [a]"r" (a), [u]"r" (u)
-		: "memory");
+	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d");
+
 	return prev;
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 #endif
 
+#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "      %[p],  %[c]\n"			\
+		"	bltz            %[p],  1f\n"			\
+		"	addi            %[rc], %[p], 1\n"		\
+		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
+		"	bnez            %[rc], 0b\n"			\
+		"	fence           rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 {
 	int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w      %[p],  %[c]\n"
-		"	bltz      %[p],  1f\n"
-		"	addi      %[rc], %[p], 1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
+
 	return !(prev < 0);
 }
 
 #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
 
+#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "      %[p],  %[c]\n"			\
+		"	bgtz            %[p],  1f\n"			\
+		"	addi            %[rc], %[p], -1\n"		\
+		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
+		"	bnez            %[rc], 0b\n"			\
+		"	fence           rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
 {
 	int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w      %[p],  %[c]\n"
-		"	bgtz      %[p],  1f\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
+
 	return !(prev > 0);
 }
 
 #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
 
+#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)		\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "     %[p],  %[c]\n"			\
+		"	addi           %[rc], %[p], -1\n"		\
+		"	bltz           %[rc], 1f\n"			\
+		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
+		"	bnez           %[rc], 0b\n"			\
+		"	fence          rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 {
        int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w     %[p],  %[c]\n"
-		"	addi     %[rc], %[p], -1\n"
-		"	bltz     %[rc], 1f\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
+
 	return prev - 1;
 }
 
@@ -304,17 +319,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
 	s64 prev;
 	long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d      %[p],  %[c]\n"
-		"	bltz      %[p],  1f\n"
-		"	addi      %[rc], %[p], 1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
+
 	return !(prev < 0);
 }
 
@@ -325,17 +331,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
 	s64 prev;
 	long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d      %[p],  %[c]\n"
-		"	bgtz      %[p],  1f\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
+
 	return !(prev > 0);
 }
 
@@ -346,17 +343,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
        s64 prev;
        long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d     %[p],  %[c]\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	bltz     %[rc], 1f\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
+
 	return prev - 1;
 }
 
-- 
2.41.0

