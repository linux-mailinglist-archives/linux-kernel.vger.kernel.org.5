Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D22790817
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjIBNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjIBNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:35:19 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AAB90
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693661715;
        bh=dOizpCeKcWiqHfK/TIK4PgjyO+qU5NUWbEh7jGDo3Pw=;
        h=From:To:Cc:Subject:Date;
        b=EQQEvHobvocU+bL3K3qcULYN0PlfYPi6NPL0bNZsBsWmRq+N7umcSOliTZeIQRRlW
         kjB2CScDfPZE19lVxMJ9jHDORnJVV89Y2QhwT6IixHbE+8oWI4EkqGOTlj6NT1yd61
         ML8cK15PnaCQgf5RQSaJ6QJbn4Tl0gut6UqNYYNsxsSAbUeGZbw7/+D7iH64rYbwMc
         QCtNFcrdtKb5ywBn1K0FKCRJ06N+M+kolPtNDdKaQ7iHwUu8aKzKlMKA4IG8g+DKho
         FjF1yOR2kvYfTHNklwW5qNruw/jVX79ybR0l43EmrYqr8WKmiJoc2nnUVzSQBP/MhE
         YsalLB2kcqg8A==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 5420724B39E;
        Sat,  2 Sep 2023 20:35:11 +0700 (WIB)
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
Subject: [RFC PATCH v3 0/4] nolibc x86-64 string functions
Date:   Sat,  2 Sep 2023 20:35:01 +0700
Message-Id: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
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

This is an RFC patchset v3 for nolibc x86-64 string functions.

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
  00000000004013aa <memmove>:
    4013aa: f3 0f 1e fa           endbr64
    4013ae: 48 39 f7              cmpq   %rsi,%rdi
    4013b1: 48 c7 c1 ff ff ff ff  movq   $0xffffffffffffffff,%rcx
    4013b8: 48 89 f8              movq   %rdi,%rax
    4013bb: 48 0f 43 ca           cmovaeq %rdx,%rcx
    4013bf: 48 19 ff              sbbq   %rdi,%rdi
    4013c2: 83 e7 02              andl   $0x2,%edi
    4013c5: 48 ff cf              decq   %rdi
    4013c8: 48 85 d2              testq  %rdx,%rdx
    4013cb: 74 10                 je     4013dd <memmove+0x33>
    4013cd: 48 01 f9              addq   %rdi,%rcx
    4013d0: 48 ff ca              decq   %rdx
    4013d3: 44 8a 04 0e           movb   (%rsi,%rcx,1),%r8b
    4013d7: 44 88 04 08           movb   %r8b,(%rax,%rcx,1)
    4013db: eb eb                 jmp    4013c8 <memmove+0x1e>
    4013dd: c3                    retq

  00000000004013de <memcpy>:
    4013de: f3 0f 1e fa           endbr64
    4013e2: 48 89 f8              movq   %rdi,%rax
    4013e5: 31 c9                 xorl   %ecx,%ecx
    4013e7: 48 39 ca              cmpq   %rcx,%rdx
    4013ea: 74 0d                 je     4013f9 <memcpy+0x1b>
    4013ec: 40 8a 3c 0e           movb   (%rsi,%rcx,1),%dil
    4013f0: 40 88 3c 08           movb   %dil,(%rax,%rcx,1)
    4013f4: 48 ff c1              incq   %rcx
    4013f7: eb ee                 jmp    4013e7 <memcpy+0x9>
    4013f9: c3                    retq

  00000000004013fa <memset>:
    4013fa: f3 0f 1e fa           endbr64
    4013fe: 48 89 f8              movq   %rdi,%rax
    401401: 31 c9                 xorl   %ecx,%ecx
    401403: 48 39 ca              cmpq   %rcx,%rdx
    401406: 74 09                 je     401411 <memset+0x17>
    401408: 40 88 34 08           movb   %sil,(%rax,%rcx,1)
    40140c: 48 ff c1              incq   %rcx
    40140f: eb f2                 jmp    401403 <memset+0x9>
    401411: c3                    retq
```

After this series:
```
  // `memmove` is an alias for `memcpy`
  000000000040149c <memcpy>:
    40149c: 48 89 d1              movq   %rdx,%rcx
    40149f: 48 89 f8              movq   %rdi,%rax
    4014a2: 48 89 fa              movq   %rdi,%rdx
    4014a5: 48 29 f2              subq   %rsi,%rdx
    4014a8: 48 39 ca              cmpq   %rcx,%rdx
    4014ab: 72 03                 jb     4014b0 <memcpy+0x14>
    4014ad: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    4014af: c3                    retq
    4014b0: 48 8d 7c 0f ff        leaq   -0x1(%rdi,%rcx,1),%rdi
    4014b5: 48 8d 74 0e ff        leaq   -0x1(%rsi,%rcx,1),%rsi
    4014ba: fd                    std
    4014bb: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    4014bd: fc                    cld
    4014be: c3                    retq

  00000000004014bf <memset>:
    4014bf: 96                    xchgl  %eax,%esi
    4014c0: 48 89 d1              movq   %rdx,%rcx
    4014c3: 57                    pushq  %rdi
    4014c4: f3 aa                 rep stosb %al,%es:(%rdi)
    4014c6: 58                    popq   %rax
    4014c7: c3                    retq
```

## Changelog

Changes in v3:
  - Make memmove as an alias for memcpy (Willy).
  - Make the forward copy the likely case (Alviro).

Changes in v2:
  - Shrink the memset code size:
      - Use pushq %rdi / popq %rax (Alviro).
      - Use xchg %eax, %esi (Willy).
  - Drop the memcmp patch (need more pondering).
  - Fix the broken memmove implementation (David).

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (4):
  tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
  tools/nolibc: x86-64: Use `rep stosb` for `memset()`
  tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
  tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

 tools/include/nolibc/arch-x86_64.h | 42 ++++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      | 36 +++++++++----------------
 2 files changed, 55 insertions(+), 23 deletions(-)


base-commit: 3c9b7c4a228bf8cca2f92abb65575cdd54065302
-- 
Ammar Faizi

