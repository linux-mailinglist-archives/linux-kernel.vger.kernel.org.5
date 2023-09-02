Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B115790556
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbjIBFvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351582AbjIBFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:51:15 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55510F6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693633872;
        bh=x9sDKPf10aSubQx2+ufgoe1wqMoNjeL92ALh+yOhHx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=o4zLcBRCrL11CYdrGjjX08nuRkrk+qRYSsiofmENoJwnRI3qMFfSlW3dPmKX7ikJe
         D1O7lw53EpIDE5jAlrAAQiSm/ypgfp1nnd6zka7mf6bKzzu+hNA1FSJGo8zt+c3Vvt
         sQJDXVDYq2wshI46JktOqy+8wSgbJR2BYMi4fbt7XybqhB2j5uSibWY8qsHVjyEAxX
         7WpcJNZvJHAAPoFWao9Jyalab+t4IJqMMetzKzRTLB6gAn3Zvjyyc9fFQr4MSXOd7P
         0HvQktXpoIhNfCNH2+PRh/xHZANu2iqNSe4Mgz4WQdjJNbC4HLkXDuOPjHR7pKc2Pu
         b8z8wkOXW4JtQ==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id A5B8624B3A7;
        Sat,  2 Sep 2023 12:51:08 +0700 (WIB)
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
Subject: [RFC PATCH v2 2/4] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
Date:   Sat,  2 Sep 2023 12:50:43 +0700
Message-Id: <20230902055045.2138405-3-ammarfaizi2@gnuweeb.org>
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

Simplify memset() on the x86-64 arch.

The x86-64 arch has a 'rep stosb' instruction, which can perform
memset() using only a single instruction, given:

    %al  = value (just like the second argument of memset())
    %rdi = destination
    %rcx = length

Before this patch:
```
  00000000000010c9 <memset>:
    10c9: 48 89 f8              mov    %rdi,%rax
    10cc: 48 85 d2              test   %rdx,%rdx
    10cf: 74 0e                 je     10df <memset+0x16>
    10d1: 31 c9                 xor    %ecx,%ecx
    10d3: 40 88 34 08           mov    %sil,(%rax,%rcx,1)
    10d7: 48 ff c1              inc    %rcx
    10da: 48 39 ca              cmp    %rcx,%rdx
    10dd: 75 f4                 jne    10d3 <memset+0xa>
    10df: c3                    ret
```

After this patch:
```
  0000000000001511 <memset>:
    1511: 96                    xchg   %eax,%esi
    1512: 48 89 d1              mov    %rdx,%rcx
    1515: 57                    push   %rdi
    1516: f3 aa                 rep stos %al,%es:(%rdi)
    1518: 58                    pop    %rax
    1519: c3                    ret
```

v2 code size shrink:
  - Use pushq %rdi / popq %rax (Alviro).
  - Use xchg %eax, %esi (Willy).

Link: https://lore.kernel.org/lkml/ZO9e6h2jjVIMpBJP@1wt.eu
Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Suggested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 13 +++++++++++++
 tools/include/nolibc/string.h      |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 297ffa364b2312eb..ed01b130e25c6740 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -162,50 +162,63 @@
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
 
 #define NOLIBC_ARCH_HAS_MEMMOVE
 void *memmove(void *dst, const void *src, size_t len);
 
 #define NOLIBC_ARCH_HAS_MEMCPY
 void *memcpy(void *dst, const void *src, size_t len);
 
+#define NOLIBC_ARCH_HAS_MEMSET
+void *memset(void *dst, int c, size_t len);
+
 __asm__ (
 ".section .text.nolibc_memmove\n"
 ".weak memmove\n"
 "memmove:\n"
 	"movq %rdx, %rcx\n"
 	"movq %rdi, %rdx\n"
 	"movq %rdi, %rax\n"
 	"subq %rsi, %rdx\n"
 	"cmpq %rcx, %rdx\n"
 	"jnb  .Lforward_copy\n"
 	"leaq -1(%rdi, %rcx, 1), %rdi\n"
 	"leaq -1(%rsi, %rcx, 1), %rsi\n"
 	"std\n"
 	"rep movsb\n"
 	"cld\n"
 	"retq\n"
 ".Lforward_copy:\n"
 	"rep movsb\n"
 	"retq\n"
 
 ".section .text.nolibc_memcpy\n"
 ".weak memcpy\n"
 "memcpy:\n"
 	"movq %rdi, %rax\n"
 	"movq %rdx, %rcx\n"
 	"rep movsb\n"
 	"retq\n"
+
+".section .text.nolibc_memset\n"
+".weak memset\n"
+"memset:\n"
+	"xchg  %eax, %esi\n"
+	"movq  %rdx, %rcx\n"
+	"pushq %rdi\n"
+	"rep stosb\n"
+	"popq  %rax\n"
+	"retq\n"
 );
 
 #endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 6eca267ec6fa7177..1bad6121ef8c4ab5 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -67,55 +67,57 @@ void *memmove(void *dst, const void *src, size_t len)
 	}
 
 	while (len) {
 		pos += dir;
 		((char *)dst)[pos] = ((const char *)src)[pos];
 		len--;
 	}
 	return dst;
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMMOVE */
 
 #ifndef NOLIBC_ARCH_HAS_MEMCPY
 /* must be exported, as it's used by libgcc on ARM */
 __attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
 	return _nolibc_memcpy_up(dst, src, len);
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMCPY */
 
+#ifndef NOLIBC_ARCH_HAS_MEMSET
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
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMSET */
 
 static __attribute__((unused))
 char *strchr(const char *s, int c)
 {
 	while (*s) {
 		if (*s == (char)c)
 			return (char *)s;
 		s++;
 	}
 	return NULL;
 }
 
 static __attribute__((unused))
 int strcmp(const char *a, const char *b)
 {
 	unsigned int c;
 	int diff;
 
 	while (!(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
 		;
-- 
Ammar Faizi

