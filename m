Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7FD78F911
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbjIAH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIAH1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:27:43 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E910CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693553259;
        bh=ksi0N4bkY4vYdPJRy7584Sb6QNv7wTjPKtpgW3gRMDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h6Zh8YGHc9wyCl7XeR5kfndRlwlkWmvBho3inO3tFxWmIWGaELZFCfKpXP/+pnve4
         wDGRj8NEcD4y9gPNiy9N8MfQmp6ih+SbDBTTK3SFXJXN2hGzLEYzLdcXHU8toRP1L4
         m4PzIvQZMk6RPhYCdb2RTraXXQrLWsMKy9Lb+aJpNLMy4Qgu231GJaPuAp4VTQSlbd
         BkGH3OPSXtyimXKDqOSQidJfWrlidoFSVQFVv42x0aaznSu9KqyFWOiz94p2cGn0GC
         7noDMvDolP8/TRls/WR57aPYhlaSkm9qqVGgZ1LfkR9ASVC673VE5vMxJCC3xaicAu
         ZHnBLDbvFnneQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id A86D424B367;
        Fri,  1 Sep 2023 14:27:36 +0700 (WIB)
Date:   Fri, 1 Sep 2023 14:27:28 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Message-ID: <ZPGSYKJeSlk4y7tE@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
 <ZO+0IW1zS9QNpP4y@1wt.eu>
 <ZPFZejgd0h7ErwLL@biznet-home.integral.gnuweeb.org>
 <ZPFb7DkAYQW8+XwT@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPFb7DkAYQW8+XwT@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,MONEY_NOHTML,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:35:08AM +0200, Willy Tarreau wrote:
> On Fri, Sep 01, 2023 at 10:24:42AM +0700, Ammar Faizi wrote:
> > After thinking about this more, I think I'll drop the memcmp() patch
> > because it will prevent optimization when comparing a small value.
> > 
> > For example, without __asm__:
> > 
> >     memcmp(var, "abcd", 4);
> > 
> > may compile to:
> > 
> >     cmpl $0x64636261, %reg
> >     ...something...
> > 
> > But with __asm__, the compiler can't do that. Thus, it's not worth
> > optimizing the memcmp() in this case.
> 
> Ah you're totally right!

So, it turns out that such assumption is wrong. The compiler cannot
optimize the current memcmp() into that. I just posted a question on SO:

   https://stackoverflow.com/questions/77020562/what-prevents-the-compiler-from-optimizing-a-hand-written-memcmp

Given:
```
  bool test_data(void *data)
  {
          return memcmp(data, "abcd", 4) == 0;
  }
```

The result when using default the <string.h> memcmp (good):
```
  test_data:
      cmpl    $1684234849, (%rdi)
      sete    %al
      ret
```

The result when using nolibc memcmp() (bad):
```
  test_data:
      cmpb    $97, (%rdi)
      jne     .L5
      cmpb    $98, 1(%rdi)
      jne     .L5
      cmpb    $99, 2(%rdi)
      jne     .L5
      cmpb    $100, 3(%rdi)
      sete    %al
      ret
  .L5:
      xorl    %eax, %eax
      ret
```

Link: https://godbolt.org/z/TT94r3bvf

This is because apart from the input length, the current nolibc
`memcmp()` must stop comparing the next byte if it finds a non-match
byte. Imagine what happens if we call:

```
  char xstr[] = {'a', 'b', 'x'};
  test_data(x);
```

In that case, the compiler may read past xstr if it uses a dword cmp, it
can also lead to segfault in particular circumstances using a dword cmp.

What the current nolibc memcmp() does from the C language view:

  1) Compare one byte at a time.
  2) Must stop comparing the next byte if it finds a non-match byte.

Because point (2) comes in, the compiler is not allowed to optimize
nolibc memcmp() into a wider load; otherwise, it may hit a segfault.
That also means it cannot vectorize the memcmp() loop.

On the other hand, memcpy() and memset() don't have such a restriction
so they can vectorize.

The real memcmp() assumes that both sources are at least `n` length in
size, allowing for a wider load. The current nolibc memcmp()
implementation doesn't reflect that assumption in the C code.

IOW, the real built-in memcmp() is undefined behavior for this code:
```
    char x = 'q';
    return memcmp(&x, "abcd", 4);
```
but the current nolibc memcmp() is well-defined behavior (well, must be,
as what the C code reflects).

We can improve nolibc memcmp() by casting the sources to a wider type
like (ulong, uint, ushort). But that's another story for another RFC
patchset.

-- 
Ammar Faizi

