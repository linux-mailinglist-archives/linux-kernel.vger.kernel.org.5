Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A817750D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHICPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHICPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA68E1BDA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSwkRG8bcSleBdtSsjCnyBmp/8Y+sHuiXOKQQOlQtH4=;
        b=WnzLQHsd7uNV/mInjNmcgWwQEaaqMqkhL+Q107HLGkQxwVk+E14r9nXvBDSaoKZqojPxDe
        bBNsRJqoffpb6Jizzm1e8sJSbD5PzZGvcLIfGXyRBI/JhxsbdJP8Klkiw4P+vk0kjVQl0r
        +dkCqWxK7VGWw0LjZUJ6ab14NaHa8/k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-5fwvUZTtMJeHDZxbD_W5lg-1; Tue, 08 Aug 2023 22:14:21 -0400
X-MC-Unique: 5fwvUZTtMJeHDZxbD_W5lg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1b0812d43a0so597717fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547261; x=1692152061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSwkRG8bcSleBdtSsjCnyBmp/8Y+sHuiXOKQQOlQtH4=;
        b=dFc0LrQprMs9CqGnkc3Wbbm2DVSObRM1LEPTfAs7XL03ee32d3gBqsivnQdLqWe26R
         qdB2KWtFZMTOYsbcyLtH9Flpz88ELwpi63B95tr6E3n+YkAat9lLPWBw9AsQOB0Jm2Yc
         9NgVctX+dNVJD3zMUjmG6LdQ0tP1ziWazSpt7bOoczSuCz93aPqV63H+xSW02zkFm4Mg
         t50d7I+nutIAp03kSVOlCZHGCNDLlXqH0o0miTVJn+Y19AuhFnFwtaY0+lNa4zhaf2Us
         tfeyCWF0/8GoL2VW9p5fHGrEggJg06X9L8LFW1kkCGOfwTujn8Y/SzJPhf0T3EI5pzkc
         NP2Q==
X-Gm-Message-State: AOJu0YyEgv2SRvyg14A8BBynm4qyKFGSkdZ33GKCEC5njkl/7pumrmTY
        BzrZFMbFmo6ngyc6tf6fS8fs1W15HqPjRftyQ8c1TJINpGSdeo2+2meIRlGD7Tjjj1s/sY46D4y
        qN5H2/W8MjztJxxRl/bBY05R1
X-Received: by 2002:a05:6870:b6a9:b0:1bf:1c49:749c with SMTP id cy41-20020a056870b6a900b001bf1c49749cmr8730778oab.13.1691547260770;
        Tue, 08 Aug 2023 19:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlHClRw7hdQrrpejz4vuDyEoE85EOUKHc1btv2W4ZMe793U+R5Uo/+moePgCrObCJ/o3ANw==
X-Received: by 2002:a05:6870:b6a9:b0:1bf:1c49:749c with SMTP id cy41-20020a056870b6a900b001bf1c49749cmr8730768oab.13.1691547260529;
        Tue, 08 Aug 2023 19:14:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm6475518ooj.47.2023.08.08.19.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:14:20 -0700 (PDT)
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
Subject: [RFC PATCH v4 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date:   Tue,  8 Aug 2023 23:13:10 -0300
Message-ID: <20230809021311.1390578-7-leobras@redhat.com>
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
index cfada8a7cfd2..1640308f3c4d 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -11,6 +11,31 @@
 #include <asm/barrier.h>
 #include <asm/fence.h>
 
+#define __arch_xchg_masked(prepend, append, r, p, n)			\
+({									\
+	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __retx;							\
+	ulong __rc;							\
+									\
+	__asm__ __volatile__ (						\
+	       prepend							\
+	       "0:	lr.w %0, %2\n"					\
+	       "	and  %1, %0, %z4\n"				\
+	       "	or   %1, %1, %z3\n"				\
+	       "	sc.w %1, %1, %2\n"				\
+	       "	bnez %1, 0b\n"					\
+	       append							\
+	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
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
+		__arch_xchg_masked(prepend, append,			\
+				   __ret, __ptr, __new);		\
+		break;							\
 	case 4:								\
 		__arch_xchg(".w" sfx, prepend, append,			\
 			      __ret, __ptr, __new);			\
-- 
2.41.0

