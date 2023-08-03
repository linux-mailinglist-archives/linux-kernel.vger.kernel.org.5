Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80E276DF97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHCFP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjHCFPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE8630F3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691039676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZcGwtCjzhW0OBBycEUaxWbT2VDTB4yqfuLafpABV3I=;
        b=BXZ0FV9j6TjX2EYvOwAwdRSW7R618ud/eBxwJNt20dZkzlXWx630dXa5ap8FjkKZLpEwSe
        QwpOS0hG+AhS2NY8W8h/HAkpe1N9MHLpc5HXyc8rtL6NdGvbhHyERfISuwPDAw5D7hhnlu
        bDbyn6KW+ia4jX8bQRKM56Ox7am1xnc=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-fG-lvLzbPhaETRbcPBGo8Q-1; Thu, 03 Aug 2023 01:14:35 -0400
X-MC-Unique: fG-lvLzbPhaETRbcPBGo8Q-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56c7be22ca8so596318eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 22:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039674; x=1691644474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZcGwtCjzhW0OBBycEUaxWbT2VDTB4yqfuLafpABV3I=;
        b=U1PcKAT7hEGgrTTOI90vlzTHIlbbu7MVr8WnVvizyypOKB6GPu+xb59W+PIGxIj0m8
         Tv3h/ofWpivQ22FaLt2qdmSUtxsqxCsKrPBV8FRTq69gaotHZy4xwMi6a5fcjc7LuHPq
         NWfJjYsox0OCFvUn2DIcQIZbpJyDTBNGMVYjNTuy3yh9TDdUkiOmFu5H5gZGJ4tF6yXc
         kcK/2HAAhk/C2Y/FdqnaCkuUfAHN7s3ny1LDQq4eLOYYpP8bFsfCESclEGoVq5CxYJ8s
         yZ60zWhs0SNoOGUPUMuxrDHA6FQP5rzfPK2OAnr5HewwKanJAoYo+4i+30gAdXIExON4
         AsXw==
X-Gm-Message-State: ABy/qLYKNzf4ux3oRlEf3E/4Quk4b80RnmIvoex9QeLcQDoTtRnSiVUv
        668kcB5UVU6Wx9uDy9QuL3lH4AhNvkNi/xsS+/ahWS+CMr3SRTDb7efAox4Cfrpcq6Bm/ROSqo3
        EvmzAjMV+Ux503fLEmAnvTHdd
X-Received: by 2002:a05:6808:b08:b0:3a7:5314:e572 with SMTP id s8-20020a0568080b0800b003a75314e572mr5934128oij.53.1691039674431;
        Wed, 02 Aug 2023 22:14:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfiz2uOFuhiqR6748NuQ/vIPQxwC/CwbLPbjx+5B22xsQA9uZm1XAzQNvPTBTAb3fsMZ+03g==
X-Received: by 2002:a05:6808:b08:b0:3a7:5314:e572 with SMTP id s8-20020a0568080b0800b003a75314e572mr5934111oij.53.1691039674128;
        Wed, 02 Aug 2023 22:14:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id g51-20020a0568080df300b003a75593746asm1675473oic.57.2023.08.02.22.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:14:33 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v2 1/3] riscv/cmpxchg: Deduplicate xchg() asm functions
Date:   Thu,  3 Aug 2023 02:13:58 -0300
Message-ID: <20230803051401.710236-3-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803051401.710236-2-leobras@redhat.com>
References: <20230803051401.710236-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this header every xchg define (_relaxed, _acquire, _release, vanilla)
contain it's own asm file, both for 4-byte variables an 8-byte variables,
on a total of 8 versions of mostly the same asm.

This is usually bad, as it means any change may be done in up to 8
different places.

Unify those versions by creating a new define with enough parameters to
generate any version of the previous 8.

Then unify the result under a more general define, and simplify
arch_xchg* generation.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 136 +++++--------------------------
 1 file changed, 22 insertions(+), 114 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..ec4ea4f3f908 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,60 +11,30 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
-#define __xchg_relaxed(ptr, new, size)					\
+#define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
-
-#define arch_xchg_relaxed(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"	amoswap" sfx " %0, %2, %1\n"			\
+		append							\
+		: "=r" (r), "+A" (*(p))					\
+		: "r" (n)						\
+		: "memory");						\
 })
 
-#define __xchg_acquire(ptr, new, size)					\
+#define _arch_xchg(ptr, new, sfx, prepend, append)			\
 ({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __new = (new);				\
 	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
+	__typeof__(ptr) __ptr = (ptr);					\
+	switch (sizeof(*__ptr)) {					\
 	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		__arch_xchg(".w" sfx, prepend, append,			\
+			      __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d %0, %2, %1\n"			\
-			RISCV_ACQUIRE_BARRIER				\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
+		__arch_xchg(".d" sfx, prepend, append,			\
+			      __ret, __ptr, __new);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -72,79 +42,17 @@
 	__ret;								\
 })
 
-#define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+#define arch_xchg_relaxed(ptr, x)					\
+	_arch_xchg(ptr, x, "", "", "")
 
-#define __xchg_release(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.w %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			RISCV_RELEASE_BARRIER				\
-			"	amoswap.d %0, %2, %1\n"			\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+#define arch_xchg_acquire(ptr, x)					\
+	_arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
-
-#define __arch_xchg(ptr, new, size)					\
-({									\
-	__typeof__(ptr) __ptr = (ptr);					\
-	__typeof__(new) __new = (new);					\
-	__typeof__(*(ptr)) __ret;					\
-	switch (size) {							\
-	case 4:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.w.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	case 8:								\
-		__asm__ __volatile__ (					\
-			"	amoswap.d.aqrl %0, %2, %1\n"		\
-			: "=r" (__ret), "+A" (*__ptr)			\
-			: "r" (__new)					\
-			: "memory");					\
-		break;							\
-	default:							\
-		BUILD_BUG();						\
-	}								\
-	__ret;								\
-})
+	_arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(ptr, x, ".aqrl", "", "")
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.41.0

