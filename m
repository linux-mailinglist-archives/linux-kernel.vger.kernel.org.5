Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0978DF64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbjH3TK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbjH3N5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:57:49 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB892C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403866;
        bh=nVJMnv3VCXXs9TgaAACyjEPEMdvWPuaWCwde2DJ1HJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V9BTof8lCIK92dwQ2+z8QNcmYNiZGc9JvEryL2GwrA9Mnrg38AHNtUSdKoZDVI27O
         IFpMfYG4ijMEFBdHYCaf7KeBQRvYSlDGsMXk47lZMGfY7jM9hEzQoI1yjUOiX3gfw0
         xaWHDW3wWAekUKcKOg2x0NT55pIsNL9ATbDnQGpXu2Yz3hts1BgyQ9aGCm/U+Ng6JK
         yiYnatLh6DdcgbHr+ulXbY4JNgcmqQzqtRsHTAhqXWNHh+VZ06t53adm30upnsqlr4
         XI1SKifiy5fzhD+lxK6zc2r1CrI3o5Ko0GXkbMD0pXP+1LKpJpNdFeZ6UmE99m0k5q
         bsJJNgymS9X2w==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 2C4A124B327;
        Wed, 30 Aug 2023 20:57:42 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
Date:   Wed, 30 Aug 2023 20:57:23 +0700
Message-Id: <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
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
  00000000000010b1 <memset>:
    10b1: 48 89 f0              mov    %rsi,%rax
    10b4: 48 89 d1              mov    %rdx,%rcx
    10b7: 48 89 fa              mov    %rdi,%rdx
    10ba: f3 aa                 rep stos %al,%es:(%rdi)
    10bc: 48 89 d0              mov    %rdx,%rax
    10bf: c3                    ret
```

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 13 +++++++++++++
 tools/include/nolibc/string.h      |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index c5162170a2ccdff1..42f2674ad1ecdd64 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -179,6 +179,9 @@ void *memmove(void *dst, const void *src, size_t len);
 #define NOLIBC_ARCH_HAS_MEMCPY
 void *memcpy(void *dst, const void *src, size_t len);
 
+#define NOLIBC_ARCH_HAS_MEMSET
+void *memset(void *dst, int c, size_t len);
+
 __asm__ (
 ".section .text.nolibc_memmove\n"
 ".weak memmove\n"
@@ -199,6 +202,16 @@ __asm__ (
 	"movq %rdx, %rcx\n"
 	"rep movsb\n"
 	"retq\n"
+
+".section .text.nolibc_memset\n"
+".weak memset\n"
+"memset:\n"
+	"movq %rsi, %rax\n"
+	"movq %rdx, %rcx\n"
+	"movq %rdi, %rdx\n"
+	"rep stosb\n"
+	"movq %rdx, %rax\n"
+	"retq\n"
 );
 
 #endif /* _NOLIBC_ARCH_X86_64_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 6eca267ec6fa7177..1bad6121ef8c4ab5 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -84,6 +84,7 @@ void *memcpy(void *dst, const void *src, size_t len)
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMCPY */
 
+#ifndef NOLIBC_ARCH_HAS_MEMSET
 /* might be ignored by the compiler without -ffreestanding, then found as
  * missing.
  */
@@ -99,6 +100,7 @@ void *memset(void *dst, int b, size_t len)
 	}
 	return dst;
 }
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMSET */
 
 static __attribute__((unused))
 char *strchr(const char *s, int c)
-- 
Ammar Faizi

