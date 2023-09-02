Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA18790554
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbjIBFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbjIBFvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:51:11 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46D10F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693633867;
        bh=NQWKtbuv3O/n7tmkR45L8qVDPkXuYuS7O3N5c4Qqga8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aRA5svkaD5fuRYhfod9nEh4DoKa3Vz/4HH86s8cDl+Gag9qyOE+qzSdbive2LxJbf
         4OC3O2RmmE/YZ2mD9xitl5DB6+u89q2VQTUIQN7d5V+prORNjuUphgA5+WwXeumaZr
         pwAjGQ0+cncze+ny6F7T0BAHp3A/AuHVFXguDi2YgfhWwdeFciegZFZlnDIz+2Y0hg
         U/wPgUoAl3s+y+Bmk7Rij+fUsBT43HGA1CcMJ8mGJ/TEUoYF872Fb5AmjTQk4yWZIG
         4vkMsOHwN+vayFlQmKRWUVFPq6pJvxkV1rMY4O/LaPuEbr7jn5qYicfsyNnho3rw8j
         Pmj/1xOIncIAQ==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 3635624B39E;
        Sat,  2 Sep 2023 12:51:03 +0700 (WIB)
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
Subject: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
Date:   Sat,  2 Sep 2023 12:50:42 +0700
Message-Id: <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
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
  0000000000401040 <memmove>:
    401040: 48 89 d1              mov    %rdx,%rcx
    401043: 48 89 fa              mov    %rdi,%rdx
    401046: 48 89 f8              mov    %rdi,%rax
    401049: 48 29 f2              sub    %rsi,%rdx
    40104c: 48 39 ca              cmp    %rcx,%rdx
    40104f: 73 0f                 jae    401060 <memmove+0x20>
    401051: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
    401056: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
    40105b: fd                    std
    40105c: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40105e: fc                    cld
    40105f: c3                    ret
    401060: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    401062: c3                    ret

  0000000000401063 <memcpy>:
    401063: 48 89 f8              mov    %rdi,%rax
    401066: 48 89 d1              mov    %rdx,%rcx
    401069: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40106b: c3                    ret
```

Link: https://lore.kernel.org/lkml/5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 35 ++++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e5ccb926c90306b6..297ffa364b2312eb 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -156,21 +156,56 @@
 
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
+".section .text.nolibc_memmove\n"
+".weak memmove\n"
+"memmove:\n"
+	"movq %rdx, %rcx\n"
+	"movq %rdi, %rdx\n"
+	"movq %rdi, %rax\n"
+	"subq %rsi, %rdx\n"
+	"cmpq %rcx, %rdx\n"
+	"jnb  .Lforward_copy\n"
+	"leaq -1(%rdi, %rcx, 1), %rdi\n"
+	"leaq -1(%rsi, %rcx, 1), %rsi\n"
+	"std\n"
+	"rep movsb\n"
+	"cld\n"
+	"retq\n"
+".Lforward_copy:\n"
+	"rep movsb\n"
+	"retq\n"
+
+".section .text.nolibc_memcpy\n"
+".weak memcpy\n"
+"memcpy:\n"
+	"movq %rdi, %rax\n"
+	"movq %rdx, %rcx\n"
+	"rep movsb\n"
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

