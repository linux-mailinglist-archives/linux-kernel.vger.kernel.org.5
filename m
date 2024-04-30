Return-Path: <linux-kernel+bounces-163653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B38B6E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D830C284722
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874411A38D7;
	Tue, 30 Apr 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt6Xx7Zd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90C19DF53
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468731; cv=none; b=qZq4wavJAUEmcVeFCTr+Yx5J4Ikq8C8jmvq3HKggVNxm1CbarRoWPesmkCdu0i1jRVoBJ5SHQoUqgzswp6cyKbW31aFVurKYXmXJ0I5ShrhU6UIZaY84nlguPes4np3nZYAu4G9prHaG+b7RXeWy/pHAwUQ7ibEBI3MFWOxx3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468731; c=relaxed/simple;
	bh=vtOoDYl1aOUNmIEBJBr5nX9rVdVflOoQ11HE29qUj9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgdQmtWDUNTwNmsbq8+2Qm56/qT/xpYqogl4q4rKIet8eKAdLCkwg3BVBVT7gok242YAuKuMQllzZlfwoBtP1SMV5pGiP05Yl1tY92S+Vl8e5FPDf6RqHSZkJjuMeRjWHHxy4uhsdfJQeVUsVE5QSeIL69OT1i70l6qYczmk0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt6Xx7Zd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so19042071fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468728; x=1715073528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLIOsVy4cce4j8541l0tytwI1rGz4XmyB8qtCnnEfYc=;
        b=gt6Xx7Zd/3+mcC6pnPPVwuF/w2zMVdase0cUTmO2E9viJjRp3kLa/S44FZFVpSZ2/V
         qOPCZpP7HEz6r67wpWhMFsb+dndgxr69WXbWd56Frl8ZXWUYa4pZG7EqL9iyiJ1tE2fG
         c3PCN/2w4I12RjMVA81rIuivRHsT3nSkGODbI5qPy+A4oSGHOL5Kl1ygP+nwTSzhon2g
         kWy/p83WkfSQrVSXbrI7Ex0v5GOY6QPSDugWnX8HGfUQcAnS2V0yEcog6/Tzzbb35ABK
         J6A+djmfwiDtIJozZ5WgXvqbE7x6mU9RXXikM8QiOKn8APv291p1x41ogBp0jtqwAO+e
         XIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468728; x=1715073528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLIOsVy4cce4j8541l0tytwI1rGz4XmyB8qtCnnEfYc=;
        b=WXzF9qWPQiv+j9xI/kdepQ9ZBQwN6TGwMYvjHqcschOS+UyhMohjETWQnhu7EATDwq
         x1y48+Wcy/C45wIlLlIL90FZR8ip999BdjM664nxnmm6KuZvzPqEJmS8tW5n+PFFd+ov
         ZGysnuWwyfmlcb9dnDWBSq/8hyEdYFbZ1prM8l7GzR+fUh5g1GmPj6G0yF9pWFTGRfSe
         W8+CiY4289rcoaPYlFi2VC5US6eKtm6tVqdxRxJnLa/EJ7M9O7Di0cFRoLEzFBTmT603
         W/NqlEXxSeCZOQbXSmphFqf98e9DJQVn5/4ymwQvJC+Dn8rqejhHcrF4Fl2hcoqfxKVe
         I8pw==
X-Forwarded-Encrypted: i=1; AJvYcCXUGK3eNmIZ61+/ZX9wj8J0yc3ms0HM/ccAnJANaVT79XMrsLr3F5pBgH0TgYcocpRGZURPFcqRswL4VUtDOiSuYyOd2MDfB3+35BvP
X-Gm-Message-State: AOJu0YwKq6DaxuIquCvrOfPpHiza01Z7X+JYFbk4Gajz8j+jmAykaeUN
	7TxHDmTQOalyNBlX6/u7/pJpwUmx5ZzzSacE0yAH4ur2OUE1sgQ5
X-Google-Smtp-Source: AGHT+IGq0JHGGV4suFQNlXHMRJPOzpZeLkPxwJ5JnVkNeqV8AWgt6T/IxjGn9ytnQwfA7zfFZSyTWg==
X-Received: by 2002:a2e:be8d:0:b0:2e0:eb96:7b53 with SMTP id a13-20020a2ebe8d000000b002e0eb967b53mr1314561ljr.44.1714468727617;
        Tue, 30 Apr 2024 02:18:47 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm26324458wmo.13.2024.04.30.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:18:47 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 3/5] x86/percpu: Unify percpu read-write accessors
Date: Tue, 30 Apr 2024 11:17:22 +0200
Message-ID: <20240430091833.196482-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430091833.196482-1-ubizjak@gmail.com>
References: <20240430091833.196482-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Redefine percpu_from_op() and percpu_to_op() as __raw_cpu_read()
and __raw_cpu_write().  Unify __raw_cpu_{read,write}() macros
between configs w/ and w/o USE_X86_SEG_SUPPORT in order to
unify {raw,this}_cpu{read_write}_N() accessors between configs.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 72 ++++++++++++-----------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 08113a2e5377..f360ac5fccde 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -146,28 +146,28 @@
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
 
-#define __raw_cpu_read(qual, pcp)					\
+#define __raw_cpu_read(size, qual, pcp)					\
 ({									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
 })
 
-#define __raw_cpu_write(qual, pcp, val)					\
+#define __raw_cpu_write(size, qual, pcp, val)				\
 do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define percpu_from_op(size, qual, op, _var)				\
+#define __raw_cpu_read(size, qual, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
-#define percpu_to_op(size, qual, op, _var, _val)			\
+#define __raw_cpu_write(size, qual, _var, _val)				\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 	if (0) {		                                        \
@@ -175,7 +175,7 @@ do {									\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
-	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	asm qual(__pcpu_op2_##size("mov", "%[val]", __percpu_arg([var])) \
 	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
@@ -448,54 +448,32 @@ do {									\
  */
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-#define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(, pcp, val)
-#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(, pcp, val)
-#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(, pcp, val)
-
-#define this_cpu_read_1(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_read_2(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_read_4(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_write_1(pcp, val)	__raw_cpu_write(volatile, pcp, val)
-#define this_cpu_write_2(pcp, val)	__raw_cpu_write(volatile, pcp, val)
-#define this_cpu_write_4(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
+#define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
+#define raw_cpu_read_4(pcp)		__raw_cpu_read(4, , pcp)
+#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(1, , pcp, val)
+#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(2, , pcp, val)
+#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(4, , pcp, val)
+
+#define this_cpu_read_1(pcp)		__raw_cpu_read(1, volatile, pcp)
+#define this_cpu_read_2(pcp)		__raw_cpu_read(2, volatile, pcp)
+#define this_cpu_read_4(pcp)		__raw_cpu_read(4, volatile, pcp)
+#define this_cpu_write_1(pcp, val)	__raw_cpu_write(1, volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)	__raw_cpu_write(2, volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)	__raw_cpu_write(4, volatile, pcp, val)
 
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		__raw_cpu_read(, pcp)
-#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
 
-#define this_cpu_read_8(pcp)		__raw_cpu_read(volatile, pcp)
-#define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
 #endif
 
-#define this_cpu_read_const(pcp)	__raw_cpu_read(, pcp)
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+#define this_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
-#define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
-
-#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
-
-#ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		percpu_from_op(8, , "mov", pcp)
-#define raw_cpu_write_8(pcp, val)	percpu_to_op(8, , "mov", (pcp), val)
-
-#define this_cpu_read_8(pcp)		percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
-#endif
-
 /*
  * The generic per-cpu infrastrucutre is not suitable for
  * reading const-qualified variables.
-- 
2.44.0


