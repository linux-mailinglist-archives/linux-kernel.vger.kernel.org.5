Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC078DE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbjH3TBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbjH3N5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:57:42 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4FC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693403858;
        bh=OGGfSrZuXx4X9dJyDymdDwT5vXSDpXnwWDnYpK3i+6w=;
        h=From:To:Cc:Subject:Date;
        b=YsQantIts00P7ZcfMPxZNbjj8AM2tIohLTifNdaekJ51rr7sPvAj+hMZJoOgJKKwL
         eMg+Rc8YR4ejcB/Il+6bH8Ah9fIIYnMjqAK8FgeSGOCXZtzN2ZaqvtMp+Gj/5AW7OO
         cWV3vpHdpw9FYhpoaAgeiF5/t6QTu1ooJMtu4OE0epelv/iMZXQYIB/Gv+ObRfHDI9
         viwtlwJ55/PU7YSut1/va7IlwajH+eUrdMlxJL2aH1YRnp7dWFqLrNs8bmv+ticesc
         idYfj5zIwK8Jvwdls5a8hYcJB/APMk0KDer8yBo/u6Rp8QCGKsBA0hbHaddR3DUZa2
         w3mwHGwiOn+Xg==
Received: from localhost.localdomain (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 0D39424B0F3;
        Wed, 30 Aug 2023 20:57:34 +0700 (WIB)
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Date:   Wed, 30 Aug 2023 20:57:21 +0700
Message-Id: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
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

This is an RFC patchset for nolibc x86-64 string functions. There are 5
patches in this series.

## Patch 1-3: Use `rep movsb`, `rep stosb`, and `rep cmpsb` for:
    - memcpy() and memmove()
    - memset()
    - memcmp()
respectively. They can simplify the generated ASM code.

Patch 4 and 5 are not related, just a small cleanup.

## Patch 4: Remove the `_nolibc_memcpy_down()` function
This nolibc internal function is not used. Delete it. It was probably
supposed to handle memmove(), but today the memmove() has its own
implementation.

## Patch 5: Remove the `_nolibc_memcpy_up()` function
This function is only called by memcpy(), there is no real reason to
have this wrapper. Delete this function and move the code to memcpy()
directly.

Before this series:
```
  0000000000001479 <memmove>:
    1479: f3 0f 1e fa           endbr64 
    147d: 48 39 f7              cmp    %rsi,%rdi
    1480: 48 c7 c1 ff ff ff ff  mov    $0xffffffffffffffff,%rcx
    1487: 48 89 f8              mov    %rdi,%rax
    148a: 48 0f 43 ca           cmovae %rdx,%rcx
    148e: 48 19 ff              sbb    %rdi,%rdi
    1491: 83 e7 02              and    $0x2,%edi
    1494: 48 ff cf              dec    %rdi
    1497: 48 85 d2              test   %rdx,%rdx
    149a: 74 10                 je     14ac <memmove+0x33>
    149c: 48 01 f9              add    %rdi,%rcx
    149f: 48 ff ca              dec    %rdx
    14a2: 44 8a 04 0e           mov    (%rsi,%rcx,1),%r8b
    14a6: 44 88 04 08           mov    %r8b,(%rax,%rcx,1)
    14aa: eb eb                 jmp    1497 <memmove+0x1e>
    14ac: c3                    ret

  00000000000014ad <memcpy>:
    14ad: f3 0f 1e fa           endbr64 
    14b1: 48 89 f8              mov    %rdi,%rax
    14b4: 31 c9                 xor    %ecx,%ecx
    14b6: 48 39 ca              cmp    %rcx,%rdx
    14b9: 74 0d                 je     14c8 <memcpy+0x1b>
    14bb: 40 8a 3c 0e           mov    (%rsi,%rcx,1),%dil
    14bf: 40 88 3c 08           mov    %dil,(%rax,%rcx,1)
    14c3: 48 ff c1              inc    %rcx
    14c6: eb ee                 jmp    14b6 <memcpy+0x9>
    14c8: c3                    ret

  00000000000014c9 <memset>:
    14c9: f3 0f 1e fa           endbr64 
    14cd: 48 89 f8              mov    %rdi,%rax
    14d0: 31 c9                 xor    %ecx,%ecx
    14d2: 48 39 ca              cmp    %rcx,%rdx
    14d5: 74 09                 je     14e0 <memset+0x17>
    14d7: 40 88 34 08           mov    %sil,(%rax,%rcx,1)
    14db: 48 ff c1              inc    %rcx
    14de: eb f2                 jmp    14d2 <memset+0x9>
    14e0: c3                    ret
```

After this series:
```
  000000000000140a <memmove>:
    140a: 48 89 f8              mov    %rdi,%rax
    140d: 48 89 d1              mov    %rdx,%rcx
    1410: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
    1415: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
    141a: fd                    std    
    141b: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    141d: fc                    cld
    141e: c3                    ret

  000000000000141f <memcpy>:
    141f: 48 89 f8              mov    %rdi,%rax
    1422: 48 89 d1              mov    %rdx,%rcx
    1425: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
    1427: c3                    ret

  0000000000001428 <memset>:
    1428: 48 89 f0              mov    %rsi,%rax
    142b: 48 89 d1              mov    %rdx,%rcx
    142e: 48 89 fa              mov    %rdi,%rdx
    1431: f3 aa                 rep stos %al,%es:(%rdi)
    1433: 48 89 d0              mov    %rdx,%rax
    1436: c3                    ret
```

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (5):
  tools/nolibc: x86-64: Use `rep movsb` for `memcpy()` and `memmove()`
  tools/nolibc: x86-64: Use `rep stosb` for `memset()`
  tools/nolibc: x86-64: Use `rep cmpsb` for `memcmp()`
  tools/nolibc: string: Remove the `_nolibc_memcpy_down()` function
  tools/nolibc: string: Remove the `_nolibc_memcpy_up()` function

 tools/include/nolibc/arch-x86_64.h | 60 ++++++++++++++++++++++++++++++
 tools/include/nolibc/string.h      | 38 ++++++++-----------
 2 files changed, 75 insertions(+), 23 deletions(-)


base-commit: 3c9b7c4a228bf8cca2f92abb65575cdd54065302
-- 
Ammar Faizi

