Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58D776EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjHJEFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjHJEFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E413120
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzQb2VuQCXwMdF/Rvu48wxhx8ntZSb1KliAOBLDDWgc=;
        b=J9bu9AmFw8sltFqVpctH3UpjTbiNn38xvm5YfyPzVj0NAPZF94PD4yai4uMVrAkx+SgvE0
        mtztcBZ1Vt30AURyOgf2v2XIvsDcV6FHp1xYRt6ybra+UEuorEUacbOxP0nvpxIn/kvmLu
        zW6Rtua2lrppq8isvjhKcIiRptVlh98=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Z3_cq6pZP9W6V-MrCu7dNg-1; Thu, 10 Aug 2023 00:04:23 -0400
X-MC-Unique: Z3_cq6pZP9W6V-MrCu7dNg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a7d402fc85so77409b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640263; x=1692245063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzQb2VuQCXwMdF/Rvu48wxhx8ntZSb1KliAOBLDDWgc=;
        b=DYteQqfF1lXhZZ27UZGPGl+y6u8CWctTL8ocNYq+jNk1O0mkVkkMfPvGVDZPUcpYhl
         djcmC97Jt8jBTZfwwrm4IRQrVahsc62NL/jzGRfTMeTkSPcfqX09RABH6vUUVDoZFeVV
         QeDK3HXpxYycxFPoJNYJrGOZwbpm4hKWwM3k9yHoJ2ryo/nbeuBD52ckMGGI5MOiq47A
         Yj3luTsw+1mVWk6b4XcdQuO9dtO835JiWTravi4YOAKPad+Wc1Dj6Aauqs4PIugVpx3J
         XvemBpye4wHcLt/l5wdXFspJOXGpExw0bO9trVExF7Xuyr5cciW2130wJwX2EIHMC2PC
         +KyA==
X-Gm-Message-State: AOJu0YySb1a5FRCXEm6sC7/P5uTs0ViVaexzlContkfSFbf07F5Y9pl+
        9Mz157A95PVptOUrvM3AvDbrhaXks8mzgUEsbB/btsgXRN30IpyW0RKSOGp8cfSRKYVqG0G8Tkn
        RjZjL0sPesSx21+7jIZAYNAvt
X-Received: by 2002:a05:6808:998:b0:3a7:540f:ca71 with SMTP id a24-20020a056808099800b003a7540fca71mr1397765oic.53.1691640262935;
        Wed, 09 Aug 2023 21:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoKJIRWaoDwasWuxkhBvZiGi90hdZ5+o2Vt5j+J0Py97VRwdk+5mjOtZ8GjfL51BjhINmyUg==
X-Received: by 2002:a05:6808:998:b0:3a7:540f:ca71 with SMTP id a24-20020a056808099800b003a7540fca71mr1397752oic.53.1691640262690;
        Wed, 09 Aug 2023 21:04:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm310087oiy.19.2023.08.09.21.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:04:22 -0700 (PDT)
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
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v5 3/5] riscv/atomic.h : Deduplicate arch_atomic.*
Date:   Thu, 10 Aug 2023 01:03:45 -0300
Message-ID: <20230810040349.92279-5-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810040349.92279-2-leobras@redhat.com>
References: <20230810040349.92279-2-leobras@redhat.com>
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

