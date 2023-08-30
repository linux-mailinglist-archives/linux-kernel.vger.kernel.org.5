Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267478DFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjH3TIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbjH3PKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:10:01 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C97E8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693408198;
        bh=1hHvAWMxdSN2VM1n8YGO/fwIUfb0YDlCWMQ+xRHCang=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AFDPDpRteVLGtmv66fsfik/l1GFfXAyJPcxJq4Lz1s6jS6oAtv+dc9VEkuRBEQvq+
         vj5cgqE/ZRFWrEyP1eCqlUDoe2zGAkdJRsCJ5OclCGGg+QWLJHHf+WZHdRC+HJpnPA
         h2ZeAdQowJxxfvNziurgILBa8m+GCvq4nXzLRHc0/xBDNQkS5skpHxzKVdmy74Wd6/
         +eIotgYX13vE4hcVEw6+2MWyHf/4IX5Z6tp56gvSYv8RGp37EDzZCw+gtsXmQ4F7Fx
         OU8AI7FuyiY5Agb+xRFBgl8Jnikbqm8hk5zQa7CQn5jqbkf9CwUnQin5E0bcL+fhZD
         uMnByZVVfApuA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 6621324B336;
        Wed, 30 Aug 2023 22:09:55 +0700 (WIB)
Date:   Wed, 30 Aug 2023 22:09:51 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:24:45PM +0700, Alviro Iskandar Setiawan wrote:
> Just a small idea to shrink this more, "mov %rdi, %rdx" and "mov %rdx,
> %rax" can be replaced with "push %rdi" and "pop %rax" (they are just a
> byte). So we can save 4 bytes more.
> 
> 0000000000001500 <memset>:
>     1500: 48 89 f0     mov    %rsi,%rax
>     1503: 48 89 d1     mov    %rdx,%rcx
>     1506: 57           push   %rdi
>     1507: f3 aa        rep stos %al,%es:(%rdi)
>     1509: 58           pop    %rax
>     150a: c3           ret
> 
> But I know you don't like it because it costs extra memory access.

Yes, that's an extra memory access. But I believe it doesn't hurt
someone targetting -Os. In many cases, the compilers use push/pop to
align the stack before a 'call' instruction. If they want to avoid extra
memory access, they could have used "subq $8, %rsp" and "addq $8, %rsp".

For example: https://godbolt.org/z/Tzc1xWGEn

C code:
```
int fx(int b);
int fy(int a)
{
    return 1 + fx(a);
}
```

Targetting -Os, both clang and gcc compile it to:
```
fy:
    pushq   %rax
    call    fx
    popq    %rdx
    incl    %eax
    ret
```

Targetting -O2:
```
fy:
    subq    $8, %rsp
    call    fx
    addq    $8, %rsp
    addl    $1, %eax
    ret
```

That pushq/popq pair doesn't actually preserve anything; it's just to
align the %rsp at 16 bytes on 'call'. IOW, sometimes having extra memory
access to get a smaller code size is acceptable.

-- 
Ammar Faizi

