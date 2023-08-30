Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D880A78DDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbjH3SwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244769AbjH3N5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:57:45 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF400C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403862;
        bh=BxyzFCZWmrBfXUbxKI5hpgIUfXerIGQlN4Xd8JmlKXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WNYAvS3/NWcw6XUmXtRSU3QIarGWY0PURwgpv+hGiaYnJr1hkqSTwbbXoTOWnkj7h
         bo707kQwh1NlGqN7PNU8WKliDb+EAZxMZgbqB3jt6GU3BGUEdgRXn86vwyhoJXz8T1
         la4LCpSlcUgv/uJWriTLTRXvQoBwVEa8FIDs+JhjXxb4YD38dbBTZ/dJfYf7lsPJuX
         Yn5sffu6chAOkZyQfgw6/oJIqefiRrCTBVkhctiOYMTQXHaD0B5H7vojKcwH/ziAVS
         hIqj1x7sFJgltOO8ZMxezwQNMyB63iracCKFcQgn5Kipz0hh+bpW8ywo9dP4IgVVFo
         I1D0dVDJH9vpg==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 1D13624B2B0;
        Wed, 30 Aug 2023 20:57:38 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/5] tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
Date:   Wed, 30 Aug 2023 20:57:22 +0700
Message-Id: <20230830135726.1939997-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
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
  0000000000001093 <memmove>:
    1093: 48 89 f8              mov    %rdi,%rax
    1096: 48 89 d1              mov    %rdx,%rcx
    1099: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
    109e: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
    10a3: fd                    std
    10a4: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    10a6: fc                    cld
    10a7: c3                    ret

  00000000000010a8 <memcpy>:
    10a8: 48 89 f8              mov    %rdi,%rax
    10ab: 48 89 d1              mov    %rdx,%rcx
    10ae: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    10b0: c3                    ret
```

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 28 ++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e5ccb926c90306b6..c5162170a2ccdff1 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -173,4 +173,32 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
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
+	"movq %rdi, %rax\n"
+	"movq %rdx, %rcx\n"
+	"leaq -1(%rdi, %rcx), %rdi\n"
+	"leaq -1(%rsi, %rcx), %rsi\n"
+	"std\n"
+	"rep movsb\n"
+	"cld\n"
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
@@ -49,6 +49,7 @@ void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
 	return dst;
 }
 
+#ifndef NOLIBC_ARCH_HAS_MEMMOVE
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
@@ -72,13 +73,16 @@ void *memmove(void *dst, const void *src, size_t len)
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
-- 
Ammar Faizi

