Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FA76FCA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjHDIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHDIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F4349F8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691138983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3amwd/lpP8rvZ9IhpcoisHZeefZgWLzf3BsTgVcPLgw=;
        b=RUw9KxHl6bjjS75FGcDCm3R4QKkADOXkMAFdvD+SVovKRB6BVSjnpAxj4cVCjgejaz/c/e
        KszWSzqvWdjs9XlMhcv5ttVpGON7XM+0WfYF+T+O2E1B2c9q50Z+5rsGY+g+4t4nq4Yj8b
        ZpYl/KQM4PS2zbG+S3KS5JkPS/5cUR4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-aAxCM3J-NIi8aXpUABlmLQ-1; Fri, 04 Aug 2023 04:49:42 -0400
X-MC-Unique: aAxCM3J-NIi8aXpUABlmLQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56ca7604435so2579038eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138981; x=1691743781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3amwd/lpP8rvZ9IhpcoisHZeefZgWLzf3BsTgVcPLgw=;
        b=PjRa1wWZidsVzoHiN9JdINRSH53miCIOx2fK1GoIGXx7QJFKNt13A70YS++w4uHqvq
         EC5ga/DKxObEcv1dHH4H1bSAAxBXapwHfM3EbHHDiqzGbiBlTL4i4WUUuodyIclVSZxy
         meVBTSWvLdNaRmb77cpFf2QCUsSXVRxfTll2nlwLdCHWTvTxffVZv3KKsaVqzCUYW3JB
         iphbkqAR7v1k08AOGUzpvj67XHGpt2L8aY5bYSXOJDapera+xq8Km5SuhrDmnsBD45V6
         KgqKPRdW3RCsRECNZ+DIjrHKyDYQtlfE2mWcH3Y5DGFlSr3mxmefBguVcVXXSU0vStDs
         HHqw==
X-Gm-Message-State: AOJu0YycCZQ8KXwylcTGUxFa3JDEfJF57spkbiw6auQlq1ZkQkavFZES
        Jx8C2v3Qju0E/fvZ0zdjZmiExIanCVGOys4y1kdpqdezvOMKwBbbiMcir3JB/bCeAnJ1v65Yzsa
        w9VLdAJ4GgU/LivSc+eMKTThy
X-Received: by 2002:a4a:6519:0:b0:56c:e856:8b2c with SMTP id y25-20020a4a6519000000b0056ce8568b2cmr1003967ooc.9.1691138981682;
        Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvsWBOYEPFQASeYA1dLIyHiNIkhde3nNiq2XUol3devppgxjgdj9GmPoeRlh/oNYHjlwpP4w==
X-Received: by 2002:a4a:6519:0:b0:56c:e856:8b2c with SMTP id y25-20020a4a6519000000b0056ce8568b2cmr1003954ooc.9.1691138981435;
        Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ab008000000b0055516447257sm685679oon.29.2023.08.04.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:41 -0700 (PDT)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date:   Fri,  4 Aug 2023 05:48:58 -0300
Message-ID: <20230804084900.1135660-7-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804084900.1135660-2-leobras@redhat.com>
References: <20230804084900.1135660-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes xchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index dfb433ac544f..943f094375c7 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,31 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define __arch_xchg_mask(prepend, append, r, p, n)			\
+({									\
+	/* Depends on 2-byte variables being 2-byte aligned */		\
+	ulong __s = ((ulong)(p) & 0x3) * BITS_PER_BYTE;			\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __retx;							\
+	register unsigned int __rc;					\
+									\
+	__asm__ __volatile__ (						\
+	       prepend							\
+	       "0:	lr.w %0, %2\n"					\
+	       "	and  %1, %0, %z4\n"				\
+	       "	or   %1, %1, %z3\n"				\
+	       "	sc.w %1, %1, %2\n"				\
+	       "	bnez %1, 0b\n"					\
+	       append							\
+	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(p))		\
+	       : "rJ" (__newx), "rJ" (~__mask)				\
+	       : "memory");						\
+									\
+	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+})
+
 #define __arch_xchg(sfx, prepend, append, r, p, n)			\
 ({									\
 	__asm__ __volatile__ (						\
@@ -27,7 +52,13 @@
 	__typeof__(*(ptr)) __new = (new);				\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(ptr) __ptr = (ptr);					\
+									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_xchg_mask(prepend, append,			\
+				 __ret, __ptr, __new);			\
+		break;							\
 	case 4:								\
 		__arch_xchg(".w" sfx, prepend, append,			\
 			      __ret, __ptr, __new);			\
-- 
2.41.0

