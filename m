Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC779F363
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjIMVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjIMVA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:00:59 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EA009B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:00:39 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 38DKwclr021811;
        Wed, 13 Sep 2023 22:58:38 +0200
Date:   Wed, 13 Sep 2023 22:58:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Sebastian Ott <sebott@redhat.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <20230913205838.GA21038@1wt.eu>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
 <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:19:00PM +0200, Thomas Weißschuh wrote:
> > All on aarch64 running fedora37 + upstream kernel. Any hints on what could
> > be borken here or how to actually fix it?
> 
> I reduced it to the following reproducer:
> 
>     $ cat test.c
>     int foo;  /* It works when deleting this variable */
>     
>     void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
>     {
>     	__asm__ volatile (
>     		"mov x8, 93\n"       /* NR_exit == 93 */
>     		"svc #0\n"
>     	);
>     	__builtin_unreachable();
>     }
>     
>     $ aarch64-linux-gnu-gcc -Os -static -fno-stack-protector -Wall -nostdlib test.c
>     $ ./a.out
>     Segmentation fault
> 
> Also when running under gdb the error message is:
> 
>     During startup program terminated with signal SIGSEGV, Segmentation fault.
> 
> So it seems the error already happens during loading.
> 
> Could be a compiler or kernel bug?

I tried here with gcc-11.4.0 native on an ubuntu-22.04 and using a
cross gcc-9.5 executed on another box and couldn't reproduce the issue
at all. It could be that the compiler inserts whatever, did someone
try to disassemble de resulting program to see what it looks like ?
Maybe we're even dealing with issues related to random stack alignment
that causes issues past a function call due to some garbage being placed
at the wrong place in the stack. Also, dmesg should generally report
what (and where) the segv happened. Similarly, gdb with "info reg"
and "disassemble $pc" should report some info.

In my case, I just have this:

  $ objdump -d a.out 

  a.out:     file format elf64-littleaarch64


  Disassembly of section .text:

  0000000000400144 <_start>:
    400144:       d2800ba8        mov     x8, #0x5d                       // #93
    400148:       d4000001        svc     #0x0

The kernel is a 6.2:

  $ uname -a
  Linux ampere 6.2.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Jul 13 20:49:15 UTC 2 aarch64 aarch64 aarch64 GNU/Linux

Cheers,
Willy
