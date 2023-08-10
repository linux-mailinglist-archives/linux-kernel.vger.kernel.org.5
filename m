Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36AC776EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjHJEFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjHJEFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34328E5B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLwtkHrR4Hnv0SG2htyTx6O/VUdZ3YGDzB9YQqYciKw=;
        b=a7fZc30nn5A0fu6C+UEEAnHvDKtTYklJnVxbW8MFMub1FRC78+JKbkGFm9ZrM3oS5ZS/af
        3ffBd5L+OGY+swKWFLcR8GCWjeXI2gIypR9UNHiMnwKYAcxXeiTeSGj6ptZZrUe25nEVnK
        YO8XjPNqGbWmLLvrQ4eEEcKzs7Iwp+E=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-Euk6dC1sOp2ePg5o-fUyVQ-1; Thu, 10 Aug 2023 00:04:29 -0400
X-MC-Unique: Euk6dC1sOp2ePg5o-fUyVQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a7697e580fso597222b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640268; x=1692245068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLwtkHrR4Hnv0SG2htyTx6O/VUdZ3YGDzB9YQqYciKw=;
        b=FWEQ9nZdtJXGNUh6AM/klGNeSQpsDYcv510oRhXpOVtOn0m/4ULAZQi4uXkrYugk7O
         NfiQ17tR5YIYwNJV+gsR3p/Q9iYpoGMoujF60BMOle7uQgb4EalWhm+UYqo5x46//dIk
         oRrK8Ra/ZgiNbtqNLXjV5FnszjENBonXVNQ0N7vxVHplLCFfKMqIBgZVbN6dhOlGv1Gk
         pbMc+eong9++mLNF2Sj+0DS70Ti3PXzCbveqgLUkKUeb8wRxqq0maAPT88qmgggMZH/7
         +OlaRV22eikSsdaCNnODt068dvkUngPeBkPDb5DTU1J53AzgOLCMeBDLYQumJTTCoep/
         iRKQ==
X-Gm-Message-State: AOJu0Yw1OGdDwXxohznE3nVi9BWvTCtxPDO4UclenRsX3rSNwEwCS0k7
        8dvomI62iBq7vSfQfZmXtWvZTyqy1OTrsYRtCHZ7ZcyHyQYxFBs0BdXe1AsH3LW1+vEzdiQVaVo
        rxHCaW/VB2RMrA0E0ARHTCR9X
X-Received: by 2002:a05:6808:10cc:b0:3a3:d7de:5cfa with SMTP id s12-20020a05680810cc00b003a3d7de5cfamr1819128ois.11.1691640268304;
        Wed, 09 Aug 2023 21:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdIAbs7Buum1URpEJTh5T57eb0r1XDUCa+aKbZcc1fbEPGJr7vKxHbONmynKMK+8Fsxl9cg==
X-Received: by 2002:a05:6808:10cc:b0:3a3:d7de:5cfa with SMTP id s12-20020a05680810cc00b003a3d7de5cfamr1819092ois.11.1691640268064;
        Wed, 09 Aug 2023 21:04:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm310087oiy.19.2023.08.09.21.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:04:27 -0700 (PDT)
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
Subject: [RFC PATCH v5 4/5] riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
Date:   Thu, 10 Aug 2023 01:03:46 -0300
Message-ID: <20230810040349.92279-6-leobras@redhat.com>
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

cmpxchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index e3e0ac7ba061..ac9d0eeb74e6 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -72,6 +72,35 @@
  * indicated by comparing RETURN with OLD.
  */
 
+#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
+({									\
+	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __oldx = (ulong)(o) << __s;				\
+	ulong __retx;							\
+	ulong __rc;							\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr.w %0, %2\n"					\
+		"	and  %1, %0, %z5\n"				\
+		"	bne  %1, %z3, 1f\n"				\
+		"	and  %1, %0, %z6\n"				\
+		"	or   %1, %1, %z4\n"				\
+		"	sc.w" sc_sfx " %1, %1, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+		: "rJ" ((long)__oldx), "rJ" (__newx),			\
+		  "rJ" (__mask), "rJ" (~__mask)				\
+		: "memory");						\
+									\
+	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+})
 
 #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
@@ -98,6 +127,11 @@
 	__typeof__(*(__ptr)) __ret;					\
 									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
+					__ret, __ptr, __old, __new);	\
+		break;							\
 	case 4:								\
 		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
 				__ret, __ptr, (long), __old, __new);	\
-- 
2.41.0

