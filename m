Return-Path: <linux-kernel+bounces-111290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9941886A43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701A4281F94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050C3A1DE;
	Fri, 22 Mar 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqaazPFL"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBBE39AC3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103257; cv=none; b=OAwHRFYG7fz4pmq7IbNp/bfPqzf1YBS9rcT3tughUFzmu9kdpprrzPPgmA6ok4CH2eA+0aUCGvyxXnzRUp9K7RhbdVfwlAXGcFEP3g787inL2yG+XQy7N30rmctMty0jp9wDZ4FSII4O4Rrl7n1eYIOplI6I4piMQoOw2+GZ1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103257; c=relaxed/simple;
	bh=sbFqd5ZgpP00ubZvGKM8iZqglUgcWqr5tvzFzkN2QXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXCfBfE+yNxKV+HRxRhmDEucxlR5ufL5j+AWLyKmplkH+/hk8XWp3plrVevLJYRczBMgyNl0NxZqsoQwqP/P+86KE+KmPWV62dFp/zqYTmimx6PXRzvlAFzxiV213moLXN/bOkAWxAj/0MGZkLba8E7tECEGAsL14MdUt2/8jFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqaazPFL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450bedffdfso234766566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711103254; x=1711708054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWXXc3p3LdUb+vMcJ113MPa0aGrf8bNT9hHNuIl7wLU=;
        b=EqaazPFLSma/SCqidtDKomh7rsh/vcTNVA4qEQb9xEkie0bfeKj3y9p7YB9wST/Otk
         Wz4/V7ItPjV3VgaVuK3QosHaoGgxUb0hXWmVyiCEXJnoQrblqnTKPz4P1IFwh1/IB8G5
         w3iuej3w5SdiWP1f6DSRNz392obSNAxT1aqFZzxsUsZD590G42B+TOHO3yIpF4cp5lMp
         6rViB76QaPKacUk3Db/vSS9MgJCPvM9OCxXVyyGMXF2i/oMzSe1USB/vDXB4v7kMumsW
         ahv15owcflNAzNBR2pxoPlgwdky00kF6U6ZlkJMN/aGQVYUdiFpl2QVKcF8msl8ENXDF
         i17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711103254; x=1711708054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWXXc3p3LdUb+vMcJ113MPa0aGrf8bNT9hHNuIl7wLU=;
        b=EXdGn3pcKhNEicGEcCX9eaAdLzoHqr2Qp4Eqqj9HBvrDs2fdntP7lr7jzTxHqdzpNq
         vaC9QraLnPs6jzqYgUAsM8ySFJguQeXdSOvwOOQjsGwrLwy1bk8OYq1Gfiqb0Vuslwzh
         xopIN3oCcpSaOq3A2o/YCETzW7sYaPANFr56sQ3Rxq5gj6ON7g6NoBVh4AWD50t2vrdg
         ddctIVO1RidB5+UW8ZlS7tZY3MNd0aB0JiOYV2ric1IdigFQgYEQ1h/O30WJS969f/ir
         yAZ0Z28fdtBQCCFK9SDvMH/7rbNz0Uq88bhtww9JDUNrGQAY37XSQ99DdmHPOSqW9eDR
         b2iA==
X-Forwarded-Encrypted: i=1; AJvYcCUj2IFR/eAOy1lgFOP/BijcydaPSB5aJO/iRpOgrte3ET8ObgU+Hbpe0wURihNsCBDLRVZ3vzBAozXyaqQ1tM4pENaazlv96EBX/EPB
X-Gm-Message-State: AOJu0YxPLsuSmqy50PyPpS9anENM35Vrnvtv+TGZyGNDxyXZbheHxs+L
	1MbSFvRuYFhWf9A3IQJ7eE1zLUq/gLcuAniDVLyRSTldAVDtL6bw
X-Google-Smtp-Source: AGHT+IGic8GZ+EjxoSUYAQa9fUpgn8OLrXT+51EgS1fgNua+QOWd4Tw1cOA/rB3kd9y8B8RGHWb4AQ==
X-Received: by 2002:a17:906:f246:b0:a47:3447:865 with SMTP id gy6-20020a170906f24600b00a4734470865mr590471ejb.19.1711103253893;
        Fri, 22 Mar 2024 03:27:33 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906bc4900b00a46e86c6c7esm855483ejv.204.2024.03.22.03.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:27:33 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Unify arch_raw_cpu_ptr() defines
Date: Fri, 22 Mar 2024 11:27:14 +0100
Message-ID: <20240322102730.209141-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building a 32 bit VDSO for a 64 bit kernel, games are played with
CONFIG_X86_64. {this,raw}_cpu_read_8() macros are conditionally defined
on CONFIG_X86_64 and when CONFIG_X86_64 is undefined in fake_32bit_build.h
various build failures in generic percpu header files can happen. To make
things worse, the build of 32 bit VDSO for a 64 bit kernel grew dependency
on arch_raw_cpu_ptr() macro and the build fails if arch_raw_cpu_ptr()
macro is not defined.

To mitigate these issues, x86 carefully defines arch_raw_cpu_ptr() to
avoid any dependency on raw_cpu_read_8() and thus CONFIG_X86_64. W/o
segment register support, the definition uses size-agnostic MOV asm
mnemonic and hopes that _ptr argument won't ever be 64 bit size on
32 bit targets (although newer GCCs warn for this situation with
"unsupported size for integer register"), and w/ segment register
support the definition uses size-agnostic __raw_cpu_read() macro.

Fortunately, raw_cpu_read() is not used in 32 bit VDSO for a 64 bit kernel.
However, we can't simply omit the definition of arch_raw_cpu_read(),
since the build will fail when building vdso/vdso32/vclock_gettime.o.

The patch defines arch_raw_cpu_ptr to BUILD_BUG() when BUILD_VDSO32_64
macro is defined. This way, we are sure that arch_raw_cpu_ptr() won't
actually be used in 32 bit VDSO for a 64 bit kernel, but it is still
defined to prevent build failure.

Finally, we can unify arch_raw_cpu_ptr() between builds w/ and w/o
x86 segment register support, substituting two tricky macro definitions
with a straightforward implementation.

There is no size difference and no difference in number of this_cpu_off
accesses between patched and unpatched kernel when the kernel is built
either w/ and w/o segment register support.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/percpu.h | 42 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 7563e69838c4..39d394ce1fca 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,36 +59,30 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-/*
- * Efficient implementation for cases in which the compiler supports
- * named address spaces.  Allows the compiler to perform additional
- * optimizations that can save more instructions.
- */
-#define arch_raw_cpu_ptr(ptr)					\
-({								\
-	unsigned long tcp_ptr__;				\
-	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
-								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
-})
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
+#ifdef CONFIG_X86_64
+#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
+#else
+#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
+#endif
+
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
+ *
+ * arch_raw_cpu_ptr should not be used in 32 bit VDSO for a 64 bit
+ * kernel, because games are played with CONFIG_X86_64 there and
+ * sizeof(this_cpu_off) becames 4.
  */
-#define arch_raw_cpu_ptr(ptr)					\
+#ifndef BUILD_VDSO32_64
+#define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__;				\
-	asm ("mov " __percpu_arg(1) ", %0"			\
-	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)));		\
-								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	tcp_ptr__ += (unsigned long)(_ptr);			\
+	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#else
+#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
 
-- 
2.44.0


