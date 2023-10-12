Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566497C76ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442416AbjJLTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442246AbjJLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13EDE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA62C433CD;
        Thu, 12 Oct 2023 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=XB7RYLaBpu7Y7ZioQNmQqVILHiWPINtCSN62QDYiSbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUegLFL+jnX29TDb2lgec+1a+0Hmh5JG0l4+dtP+baZNNRmQ1ZvqHOnkymXiIq38S
         do+ujhDW9WZnXlVOpLuY8JNCEmBMwhow7dhxd5goX1dMdml+KXIGDniJlrkJ2x6KiT
         YwKN1HCGEpKIEfp3sJEhZ+eEIxPjS4liecY5lDtCLVMGfplLiB0xc/8I2CzIDkPOys
         ZvynvtgiFbqn3wOF+HDfu6BDonckqvmOTAaBdM93ahFJVVxbG6k6J0QjWUvNe4mWTj
         T3hOKKiF5I7EHbVFGzw3S3PTUfScPVSB6PKE9RPhO64x3n2uFAhcl9mFs4MRWOUkyM
         wK6R7PQM0DHFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4A721CE0AE0; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@aculab.com>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH nolibc 06/19] tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
Date:   Thu, 12 Oct 2023 12:32:20 -0700
Message-Id: <20231012193233.207857-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

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
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-x86_64.h | 29 +++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e5ccb926c903..aece7d895153 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -173,4 +173,33 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
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
index 0c2e06c7c477..6eca267ec6fa 100644
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
2.40.1

