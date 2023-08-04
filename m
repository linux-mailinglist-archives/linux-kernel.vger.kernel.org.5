Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011776FCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHDIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHDIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A94C3D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691138979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qr15U85Ji6JaTSGdRUgCJIrXJMY4cTkIs1Ye7aZqqk=;
        b=Sb9o5KTux0eFuu7yZ+1zcbboNAeVrAgotBnJYlfnab2sb+EF31NGHdhtI6F4ZElBB4Jljs
        y6iwhg08EBNw/j8mfU6WPEYw9lh2XNuFpV2cGSE9g9ppi7dwqIakIgUFxSW57F2ZwqgCqX
        PaYGNPAXIOnwSzSSNxVaQghAeOBDHxo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-FanNZGoTM3OJwwoHoaOIPA-1; Fri, 04 Aug 2023 04:49:38 -0400
X-MC-Unique: FanNZGoTM3OJwwoHoaOIPA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56d46f0ac4bso1099820eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138977; x=1691743777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qr15U85Ji6JaTSGdRUgCJIrXJMY4cTkIs1Ye7aZqqk=;
        b=HHWIW2dNKY+y/lcvOS5p3EFI3O2MwBKiAY6ufKyA3uaOFw9K0hMypVnkYqFkFhWd70
         uAjQJ5ZAETt5LZD2rau03TCncEl8YyZAUoBB2muvoZ22ZQLf1WabZIsOY2FEpdX8NbGS
         EM9g3fiy+4IaFRY9WSRXzXedtDvapNdcJZA2Eg+7E7X9vDqLVI/s4J/IoTYqWYuKrGML
         jGgh5R87nhoONQjG0hEg6qLC/0tthkJFcJX4YQAuoDsPWehPotTL3C7TT584t764RE5C
         Y7N2DodajPr6namD5tSyU+csAwNMLwLKN2ERc8kOWSnz+RdS5r/S/FEWuSLOWG58aIDr
         T/ug==
X-Gm-Message-State: AOJu0YwdagciWe07dtQYOGW/wKzOXftt/XCxS6GigeQ1mvXNb0A2Q3RH
        eu8D7neZhqXKvYn0frVUM9uCo9FDq0kETMu23eSFR2FHGiUdkgzDCqbBP1OYgZwugyrPdXewuGF
        NNHbg8kaqhaOBlJV4C/2GE0T8
X-Received: by 2002:a4a:d2dc:0:b0:56c:43cd:7267 with SMTP id j28-20020a4ad2dc000000b0056c43cd7267mr1155030oos.8.1691138977547;
        Fri, 04 Aug 2023 01:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGpSmCpCsEW2JBmJiIqK4JHv1sEJQk4u7ARhdPhe1GUzhItUEcAzOrA7h+bfUyOp/7X0uLgw==
X-Received: by 2002:a4a:d2dc:0:b0:56c:43cd:7267 with SMTP id j28-20020a4ad2dc000000b0056c43cd7267mr1155011oos.8.1691138977273;
        Fri, 04 Aug 2023 01:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ab008000000b0055516447257sm685679oon.29.2023.08.04.01.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:36 -0700 (PDT)
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
Subject: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
Date:   Fri,  4 Aug 2023 05:48:57 -0300
Message-ID: <20230804084900.1135660-6-leobras@redhat.com>
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

cmpxchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 5a07646fae65..dfb433ac544f 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -72,6 +72,36 @@
  * indicated by comparing RETURN with OLD.
  */
 
+#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)	\
+({									\
+	/* Depends on 2-byte variables being 2-byte aligned */		\
+	ulong __s = ((ulong)(p) & 0x3) * BITS_PER_BYTE;			\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __oldx = (ulong)(o) << __s;				\
+	ulong __retx;							\
+	register unsigned int __rc;					\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr.w %0, %2\n"					\
+		"	and  %0, %0, %z5\n"				\
+		"	bne  %0, %z3, 1f\n"				\
+		"	and  %1, %0, %z6\n"				\
+		"	or   %1, %1, %z4\n"				\
+		"	sc.w" sc_sfx " %1, %1, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (__retx), "=&r" (__rc), "+A" (*(p))		\
+		: "rJ" ((long)__oldx), "rJ" (__newx),			\
+		  "rJ" (__mask), "rJ" (~__mask)				\
+		: "memory");						\
+									\
+	r = (__typeof__(*(p)))(__retx >> __s);				\
+})
+
 
 #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
@@ -98,6 +128,11 @@
 	__typeof__(*(ptr)) __ret;					\
 									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_cmpxchg_mask(sc_sfx, prepend, append,		\
+					__ret, __ptr, __old, __new);	\
+		break;							\
 	case 4:								\
 		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
 				__ret, __ptr, (long), __old, __new);	\
-- 
2.41.0

