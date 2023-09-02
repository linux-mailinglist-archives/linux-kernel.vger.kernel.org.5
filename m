Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4B1790555
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbjIBFvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIBFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:51:09 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574D10F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693633863;
        bh=UHno/JWI0MBgfHfa0kPGFIPSUgcUucYGvk9sIYhwtKk=;
        h=From:To:Cc:Subject:Date;
        b=tf5ROm1ZwD7wi+HxnBaMI1ztIR93mrsjILjXJBPe9JEE44n5jHhQWsP4ELvVmqZaq
         IlqF7QNRx174rvoJYUXERtxyU8ORkZkcSit0x7tOCz1gQc9JYQZcQEm+jdWVMqEDp1
         YZCllkeGJu74WDQOlI3a8hwYD7hVuRE36MBuBOEV5kgpGK9cixzFLSao9YF4j6vnmD
         CINjdJXD82h78T8IBo2Nts+PbQfA7lUKvSYrShBJC7fxOEpsQS5A1Nt5YdTsRkUQla
         4K/pDlaEZ68kFhwTF8opKJPqzYVZ3cAFt70eKUr/kbgyDDeh0250IO2AZvuzH9HKHP
         cEs32bEBTLFVw==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id B762624B376;
        Sat,  2 Sep 2023 12:50:59 +0700 (WIB)
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
Subject: [RFC PATCH v2 0/4] nolibc x86-64 string functions
Date:   Sat,  2 Sep 2023 12:50:41 +0700
Message-Id: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
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

Hi Willy,

This is an RFC patchset v2 for nolibc x86-64 string functions.

Changes in v2:
  - Shrink the memset code size:
      - Use pushq %rdi / popq %rax (Alviro).
      - Use xchg %eax, %esi (Willy).
  - Drop the memcmp patch (need more pondering).
  - Fix the broken memmove implementation (David).

There are 4 patches in this series:

## Patch 1-2: Use `rep movsb`, `rep stosb` for:
    - memcpy() and memmove()
    - memset()
respectively. They can simplify the generated ASM code.

Patch 3 and 4 are not related, just a small cleanup.

## Patch 3: Remove the `_nolibc_memcpy_down()` function
This nolibc internal function is not used. Delete it. It was probably
supposed to handle memmove(), but today the memmove() has its own
implementation.

## Patch 4: Remove the `_nolibc_memcpy_up()` function
This function is only called by memcpy(), there is no real reason to
have this wrapper. Delete this function and move the code to memcpy()
directly.

Before this series:
```
  0000000000401058 <memmove>:
    401058: 48 89 f8              movq   %rdi,%rax
    40105b: 31 c9                 xorl   %ecx,%ecx
    40105d: 48 39 f7              cmpq   %rsi,%rdi
    401060: 48 83 d1 ff           adcq   $0xffffffffffffffff,%rcx
    401064: 48 85 d2              testq  %rdx,%rdx
    401067: 74 25                 je     40108e <memmove+0x36>
    401069: 48 83 c9 01           orq    $0x1,%rcx
    40106d: 48 39 f0              cmpq   %rsi,%rax
    401070: 48 c7 c7 ff ff ff ff  movq   $0xffffffffffffffff,%rdi
    401077: 48 0f 43 fa           cmovaeq %rdx,%rdi
    40107b: 48 01 cf              addq   %rcx,%rdi
    40107e: 44 8a 04 3e           movb   (%rsi,%rdi,1),%r8b
    401082: 44 88 04 38           movb   %r8b,(%rax,%rdi,1)
    401086: 48 01 cf              addq   %rcx,%rdi
    401089: 48 ff ca              decq   %rdx
    40108c: 75 f0                 jne    40107e <memmove+0x26>
    40108e: c3                    retq

  000000000040108f <memcpy>:
    40108f: 48 89 f8              movq   %rdi,%rax
    401092: 48 85 d2              testq  %rdx,%rdx
    401095: 74 12                 je     4010a9 <memcpy+0x1a>
    401097: 31 c9                 xorl   %ecx,%ecx
    401099: 40 8a 3c 0e           movb   (%rsi,%rcx,1),%dil
    40109d: 40 88 3c 08           movb   %dil,(%rax,%rcx,1)
    4010a1: 48 ff c1              incq   %rcx
    4010a4: 48 39 ca              cmpq   %rcx,%rdx
    4010a7: 75 f0                 jne    401099 <memcpy+0xa>
    4010a9: c3                    retq

  00000000004010aa <memset>:
    4010aa: 48 89 f8              movq   %rdi,%rax
    4010ad: 48 85 d2              testq  %rdx,%rdx
    4010b0: 74 0e                 je     4010c0 <memset+0x16>
    4010b2: 31 c9                 xorl   %ecx,%ecx
    4010b4: 40 88 34 08           movb   %sil,(%rax,%rcx,1)
    4010b8: 48 ff c1              incq   %rcx
    4010bb: 48 39 ca              cmpq   %rcx,%rdx
    4010be: 75 f4                 jne    4010b4 <memset+0xa>
    4010c0: c3                    retq
```

After this series:
```
  0000000000401040 <memmove>:
    401040: 48 89 d1              movq   %rdx,%rcx
    401043: 48 89 fa              movq   %rdi,%rdx
    401046: 48 89 f8              movq   %rdi,%rax
    401049: 48 29 f2              subq   %rsi,%rdx
    40104c: 48 39 ca              cmpq   %rcx,%rdx
    40104f: 73 0f                 jae    401060 <memmove+0x20>
    401051: 48 8d 7c 0f ff        leaq   -0x1(%rdi,%rcx,1),%rdi
    401056: 48 8d 74 0e ff        leaq   -0x1(%rsi,%rcx,1),%rsi
    40105b: fd                    std
    40105c: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40105e: fc                    cld
    40105f: c3                    retq
    401060: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    401062: c3                    retq

  0000000000401063 <memcpy>:
    401063: 48 89 f8              movq   %rdi,%rax
    401066: 48 89 d1              movq   %rdx,%rcx
    401069: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    40106b: c3                    retq

  000000000040106c <memset>:
    40106c: 96                    xchgl  %eax,%esi
    40106d: 48 89 d1              movq   %rdx,%rcx
    401070: 57                    pushq  %rdi
    401071: f3 aa                 rep stosb %al,%es:(%rdi)
    401073: 58                    popq   %rax
    401074: c3                    retq
```

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (4):
  tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
  tools/nolibc: x86-64: Use `rep stosb` for `memset()`
  tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
  tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

 tools/include/nolibc/arch-x86_64.h | 48 ++++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      | 36 ++++++++--------------
 2 files changed, 61 insertions(+), 23 deletions(-)


base-commit: 3c9b7c4a228bf8cca2f92abb65575cdd54065302
-- 
Ammar Faizi

