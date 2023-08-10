Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F604776EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjHJEF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjHJEFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD0E69
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9RDXJ5aWrysjU+rhwlqeMwMOsK56lpvgf+6LxPUCTg=;
        b=IRHbNtScy0/Nrm7nV9r/y/jDk0kJK6cOENHOsCDLgqyMBAi4IIpvX9ov2xnbrD/akhZIK8
        mHqHZOooBlGmgdisaSzREFkzPQr1WrS1myiJ40xZSsvnlGdAVUJhvHP8/1wnd50b2ko17m
        BLREvk0Csn+s2rLNZXYk0NViE+DvLIQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-Pk3jcTnrM8y507xMyNPyBQ-1; Thu, 10 Aug 2023 00:04:34 -0400
X-MC-Unique: Pk3jcTnrM8y507xMyNPyBQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5ab57036fso584576b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640273; x=1692245073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9RDXJ5aWrysjU+rhwlqeMwMOsK56lpvgf+6LxPUCTg=;
        b=AVHSK3m9lea5FMgXD2ccnwiFZZy4Z/kiHwvRVWDLZGzKwP8b/7bkEpCH/guNS+xikv
         Dh0C145D27s90BNR2srMaOU1d8i9b/r7O/FGmtQYn/FlI6T+jvgDHiNPNb6JB6pWdNxE
         DGIvmAFfDm383XezPuWfh2WIgTjFstkvY57FJG4Q0duahSAwh8kXzF67AFZ1mex+HAHV
         1ltq0Esv5Qttq+CeBJvR42/EnJ5SLlfD1yproadMVzADKn9I3x3oRO0TCqMakfvchmhQ
         ++EiKymOSch2tVu6mZCzz69a5gds8AvtFB27s4AmZ4hLlkUqu292cGWbFppUR5YE2X/X
         phzQ==
X-Gm-Message-State: AOJu0YyswhD9dX4SULSfce5BwzVDPYYbM1TQyMxxM+RAbD9txfu9A8zm
        dEMIYucBfRAFJrNZp5e56iao2sWlDi1cQyjEbytZY/O8A1VissYbI5CoEVz/Tn/8tGOl8ty4DW6
        ZXyyAE6cFKOnZS+GPP+BxdHjz
X-Received: by 2002:a05:6808:2124:b0:3a7:82e8:8fd1 with SMTP id r36-20020a056808212400b003a782e88fd1mr1804195oiw.20.1691640273706;
        Wed, 09 Aug 2023 21:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJGYyTweAhht6teeaheQlpzQ7zjq+oFXSk4DIrLLMDF2ExtlYA68o0L4A2hjKnDp8s+BMmiQ==
X-Received: by 2002:a05:6808:2124:b0:3a7:82e8:8fd1 with SMTP id r36-20020a056808212400b003a782e88fd1mr1804180oiw.20.1691640273540;
        Wed, 09 Aug 2023 21:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm310087oiy.19.2023.08.09.21.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:04:33 -0700 (PDT)
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
Subject: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
Date:   Thu, 10 Aug 2023 01:03:47 -0300
Message-ID: <20230810040349.92279-7-leobras@redhat.com>
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
index ac9d0eeb74e6..26cea2395aae 100644
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
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(*(__ptr)) __new = (new);				\
 	__typeof__(*(__ptr)) __ret;					\
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

