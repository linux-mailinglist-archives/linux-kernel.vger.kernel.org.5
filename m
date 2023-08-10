Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89B776EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHJEFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjHJEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2180125
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcBubYngvVAQlkkTX8jFLD9nX24FtmcCz/1wvQAzhyI=;
        b=cTZvnkiYYwwOpSbpPxaZmn29lguBQ7qfGV3cONZr8skO6qpNC/8WDBtn101ckVda9A7YdI
        lZJ6kEDHzpP1McDsHyKIAAkNhn3pZcWowAk5xlO6U33rN3yWMZSwJxHPL5HtFg1/jSGi3L
        lMBGgY/m6jvDcFCETue+rfCVtkyf3/A=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-oUqOPZcyM-KfO_CCY-vZPA-1; Thu, 10 Aug 2023 00:04:18 -0400
X-MC-Unique: oUqOPZcyM-KfO_CCY-vZPA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a7d4302c71so47670b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640258; x=1692245058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcBubYngvVAQlkkTX8jFLD9nX24FtmcCz/1wvQAzhyI=;
        b=T4Mq/buAdRDFmBzjnnsaD5KUr0IfrBCR2cWo1VwiAyiVbq6CP//RhaFM41R4K01Mje
         8qtppI+5664kUtFIMMhju2ozshQhlyewiIAV0+ORWy1+TsaYlTVKpb1M0fwTgSr3UzZ8
         pSYDQZkw8FkrKptswJXQGGQMEWWye36jyqC9eXoxuKTkgE+oTfaTaMQchEG/nyM44Ixc
         w2/GzMWAKkcJv2WZ+Ifm/yPSgXThOGg+dP34lScjFeM/IJNNeEBFttc+ACFOUW27k2B4
         wkxys20403B0E8hdZ03I5VgJVtcNL4cfxEaELhqT3JUAQB6XdZuSNyUc7c6lr9CA0oLs
         nb1A==
X-Gm-Message-State: AOJu0Yx3MY1/YLnhXb6RTtRA/ioFGoXKg2cPocTu80WbGzfxKgLjsDMT
        qdSemwdt6/TdZZg+ANOUZMcU73OoWikRL6CUc/VoxOYSAlzcBblJUNJFRMYN17EAwd4oLSadw0w
        rc248I5o4eQ/zcZeL6WmSwVac
X-Received: by 2002:a05:6808:1514:b0:3a2:5d31:b299 with SMTP id u20-20020a056808151400b003a25d31b299mr594885oiw.28.1691640257834;
        Wed, 09 Aug 2023 21:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyCNfWl+g7sjPkEBxDgZwisNNLc1LhGyzcSUUej8NIuwUa4eFN8ZtD/RMr0iEkJ8Ba0KVwgw==
X-Received: by 2002:a05:6808:1514:b0:3a2:5d31:b299 with SMTP id u20-20020a056808151400b003a25d31b299mr594877oiw.28.1691640257554;
        Wed, 09 Aug 2023 21:04:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm310087oiy.19.2023.08.09.21.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:04:17 -0700 (PDT)
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
Subject: [RFC PATCH v5 2/5] riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
Date:   Thu, 10 Aug 2023 01:03:44 -0300
Message-ID: <20230810040349.92279-4-leobras@redhat.com>
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

In this header every cmpxchg define (_relaxed, _acquire, _release,
vanilla) contain it's own asm file, both for 4-byte variables an 8-byte
variables, on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

Then unify the result under a more general define, and simplify
arch_cmpxchg* generation

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/include/asm/cmpxchg.h | 195 ++++++-------------------------
 1 file changed, 33 insertions(+), 162 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 48478a8eecee..e3e0ac7ba061 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -71,190 +71,61 @@
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-#define __cmpxchg_relaxed(ptr, old, new, size)				\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
 
-#define arch_cmpxchg_relaxed(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_relaxed((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
 
-#define __cmpxchg_acquire(ptr, old, new, size)				\
+#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			RISCV_ACQUIRE_BARRIER				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_cmpxchg_acquire(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_acquire((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr" lr_sfx " %0, %2\n"				\
+		"	bne  %0, %z3, 1f\n"				\
+		"	sc" sc_sfx " %1, %z4, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
+		: "rJ" (co o), "rJ" (n)					\
+		: "memory");						\
 })
 
-#define __cmpxchg_release(ptr, old, new, size)				\
+#define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
 ({									\
 	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
+	__typeof__(*(__ptr)) __old = (old);				\
+	__typeof__(*(__ptr)) __new = (new);				\
+	__typeof__(*(__ptr)) __ret;					\
+									\
+	switch (sizeof(*__ptr)) {					\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
+		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
+				__ret, __ptr, (long), __old, __new);	\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
+		__arch_cmpxchg(".d", ".d" sc_sfx, prepend, append,	\
+				__ret, __ptr, /**/, __old, __new);	\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	__ret;								\
+	(__typeof__(*(__ptr)))__ret;					\
 })
 
-#define arch_cmpxchg_release(ptr, o, n)					\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg_release((ptr),			\
-					_o_, _n_, sizeof(*(ptr)));	\
-})
+#define arch_cmpxchg_relaxed(ptr, o, n)					\
+	_arch_cmpxchg((ptr), (o), (n), "", "", "")
 
-#define __cmpxchg(ptr, old, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(*(ptr)) __old = (old);				\
-	__typeof__(*(ptr)) __new = (new);				\
-	__typeof__(*(ptr)) __ret;					\
-	register unsigned int __rc;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.w %0, %2\n"				\
-			"	bne  %0, %z3, 1f\n"			\
-			"	sc.w.rl %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" ((long)__old), "rJ" (__new)		\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"0:	lr.d %0, %2\n"				\
-			"	bne %0, %z3, 1f\n"			\
-			"	sc.d.rl %1, %z4, %2\n"			\
-			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
-			"1:\n"						\
-			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
-			: "rJ" (__old), "rJ" (__new)			\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+#define arch_cmpxchg_acquire(ptr, o, n)					\
+	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
+
+#define arch_cmpxchg_release(ptr, o, n)					\
+	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_cmpxchg(ptr, o, n)						\
-({									\
-	__typeof__(*(ptr)) _o_ = (o);					\
-	__typeof__(*(ptr)) _n_ = (n);					\
-	(__typeof__(*(ptr))) __cmpxchg((ptr),				\
-				       _o_, _n_, sizeof(*(ptr)));	\
-})
+	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
 
 #define arch_cmpxchg_local(ptr, o, n)					\
-	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
+	arch_cmpxchg_relaxed((ptr), (o), (n))
 
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
-- 
2.41.0

