Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50C790818
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjIBNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjIBNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:35:23 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84190
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693661720;
        bh=BviSAhSuY5a+5JtffMjPSetuD8uWCAQ/gD+/+Xi1l/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cMrXc1AO2CB4xdzsDMw6I+Vjo1rrfWkzd+x8I+jxJLS2I+B7Nl/uPHEm8LBDLZqDt
         eJz+FtfRWIReqM4vFUQS+yEyo4MMw3PwnpxOEbbqqzMpIyoeY+2gVKMjzCFgvP8yXS
         QYlJRm/++RzTrvkiTOf3K0IVxNv1WHEQQZFEKfovKGcCUB2yKsm5gTdYtBTf2qOzC5
         YH0mVCQWbSGxoOBfQeq0EMVmM2GZ0cp/3YRsClwfRniHW+ACpqXxFUAxjMLhobHK5y
         rqGpNXgLwQKAgal2NDZw0ZVGp4pl0pcS2d8d7BvJTU4qL4RkM/AgkP3EXRG/M/LyTF
         h7JjO5Oa2b5Gw==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 9823A24B3D2;
        Sat,  2 Sep 2023 20:35:16 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/4] tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
Date:   Sat,  2 Sep 2023 20:35:02 +0700
Message-Id: <20230902133505.2176434-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify memcpy() and memmove() on the x86-64 arch.

The x86-64 arch has a 'rep movsb' instruction, which can perform
memcpy() using only a single instruction, given:

    %rdi = destination
    %rsi = source
    %rcx = length

Additionally, it can also handle the overlapping case by setting DF=1
(backward copy), which can be used as the memmove() implementation.

Before this patch:
```
  00000000000010ab <memmove>:
    10ab: 48 89 f8              mov    %rdi,%rax
    10ae: 31 c9                 xor    %ecx,%ecx
    10b0: 48 39 f7              cmp    %rsi,%rdi
    10b3: 48 83 d1 ff           adc    $0xffffffffffffffff,%rcx
    10b7: 48 85 d2              test   %rdx,%rdx
    10ba: 74 25                 je     10e1 <memmove+0x36>
    10bc: 48 83 c9 01           or     $0x1,%rcx
    10c0: 48 39 f0              cmp    %rsi,%rax
    10c3: 48 c7 c7 ff ff ff ff  mov    $0xffffffffffffffff,%rdi
    10ca: 48 0f 43 fa           cmovae %rdx,%rdi
    10ce: 48 01 cf              add    %rcx,%rdi
    10d1: 44 8a 04 3e           mov    (%rsi,%rdi,1),%r8b
    10d5: 44 88 04 38           mov    %r8b,(%rax,%rdi,1)
    10d9: 48 01 cf              add    %rcx,%rdi
    10dc: 48 ff ca              dec    %rdx
    10df: 75 f0                 jne    10d1 <memmove+0x26>
    10e1: c3                    ret

  00000000000010e2 <memcpy>:
    10e2: 48 89 f8              mov    %rdi,%rax
    10e5: 48 85 d2              test   %rdx,%rdx
    10e8: 74 12                 je     10fc <memcpy+0x1a>
    10ea: 31 c9                 xor    %ecx,%ecx
    10ec: 40 8a 3c 0e           mov    (%rsi,%rcx,1),%dil
    10f0: 40 88 3c 08           mov    %dil,(%rax,%rcx,1)
    10f4: 48 ff c1              inc    %rcx
    10f7: 48 39 ca              cmp    %rcx,%rdx
    10fa: 75 f0                 jne    10ec <memcpy+0xa>
    10fc: c3                    ret
```

After this patch:
```
  // memmove is an alias for memcpy
  000000000040133b <memcpy>:
    40133b: 48 89 d1              mov    %rdx,%rcx
    40133e: 48 89 f8              mov    %rdi,%rax
    401341: 48 89 fa              mov    %rdi,%rdx
    401344: 48 29 f2              sub    %rsi,%rdx
    401347: 48 39 ca              cmp    %rcx,%rdx
    40134a: 72 03                 jb     40134f <memcpy+0x14>
    40134c: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40134e: c3                    ret
    40134f: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
    401354: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
    401359: fd                    std
    40135a: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40135c: fc                    cld
    40135d: c3                    ret
```

v3:
  - Make memmove as an alias for memcpy (Willy).
  - Make the forward copy the likely case (Alviro).

v2:
  - Fix the broken memmove implementation (David).

Link: https://lore.kernel.org/lkml/20230902062237.GA23141@1wt.eu
Link: https://lore.kernel.org/lkml/5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 29 +++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e5ccb926c90306b6..aece7d8951535a36 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -156,21 +156,50 @@
 
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
  * 1) %rsp must be 16-byte aligned right before the function call.
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
 		"mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
 		"and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
 		"call _start_c\n"         /* transfer to c runtime                           */
 		"hlt\n"                   /* ensure it does not return                       */
 	);
 	__builtin_unreachable();
 }
 
+#define NOLIBC_ARCH_HAS_MEMMOVE
+void *memmove(void *dst, const void *src, size_t len);
+
+#define NOLIBC_ARCH_HAS_MEMCPY
+void *memcpy(void *dst, const void *src, size_t len);
+
+__asm__ (
+".section .text.nolibc_memmove_memcpy\n"
+".weak memmove\n"
+".weak memcpy\n"
+"memmove:\n"
+"memcpy:\n"
+	"movq %rdx, %rcx\n\t"
+	"movq %rdi, %rax\n\t"
+	"movq %rdi, %rdx\n\t"
+	"subq %rsi, %rdx\n\t"
+	"cmpq %rcx, %rdx\n\t"
+	"jb   .Lbackward_copy\n\t"
+	"rep movsb\n\t"
+	"retq\n"
+".Lbackward_copy:"
+	"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
+	"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
+	"std\n\t"
+	"rep movsb\n\t"
+	"cld\n\t"
+	"retq\n"
+);
+
 #endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0c2e06c7c4772bc6..6eca267ec6fa7177 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -32,70 +32,74 @@ void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
 {
 	size_t pos = 0;
 
 	while (pos < len) {
 		((char *)dst)[pos] = ((const char *)src)[pos];
 		pos++;
 	}
 	return dst;
 }
 
 static __attribute__((unused))
 void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
 {
 	while (len) {
 		len--;
 		((char *)dst)[len] = ((const char *)src)[len];
 	}
 	return dst;
 }
 
+#ifndef NOLIBC_ARCH_HAS_MEMMOVE
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
 __attribute__((weak,unused,section(".text.nolibc_memmove")))
 void *memmove(void *dst, const void *src, size_t len)
 {
 	size_t dir, pos;
 
 	pos = len;
 	dir = -1;
 
 	if (dst < src) {
 		pos = -1;
 		dir = 1;
 	}
 
 	while (len) {
 		pos += dir;
 		((char *)dst)[pos] = ((const char *)src)[pos];
 		len--;
 	}
 	return dst;
 }
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMMOVE */
 
+#ifndef NOLIBC_ARCH_HAS_MEMCPY
 /* must be exported, as it's used by libgcc on ARM */
 __attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
 	return _nolibc_memcpy_up(dst, src, len);
 }
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMCPY */
 
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
 __attribute__((weak,unused,section(".text.nolibc_memset")))
 void *memset(void *dst, int b, size_t len)
 {
 	char *p = dst;
 
 	while (len--) {
 		/* prevent gcc from recognizing memset() here */
 		__asm__ volatile("");
 		*(p++) = b;
 	}
 	return dst;
 }
 
 static __attribute__((unused))
 char *strchr(const char *s, int c)
 {
-- 
Ammar Faizi

