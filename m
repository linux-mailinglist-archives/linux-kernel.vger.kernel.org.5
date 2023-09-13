Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293E379F3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjIMVXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIMVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:23:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A41739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694640220;
        bh=7UMXyUu1H7AInb4Jf1UkOFSbvi8aI+lZ+c555okXulk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD4NZh66O4MJk7Y9JGURpc7BrqLSXa+ZkQkaeR0V2UdefICVXhMUpkBFN3sGQRg56
         82zT9QNobZLmMPa0TOyFybnriF7s2lDZFWLjsfuCwc2pR5XROAzPAI7Gj6wmccXXJO
         F8vms5XZ4j7Zh0mDK3bJdwsEm32Fvaa9ILjIkgWA=
Date:   Wed, 13 Sep 2023 23:23:40 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sebastian Ott <sebott@redhat.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <af79d880-9b0c-49c2-83b3-09ce5bd75093@t-8ch.de>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
 <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
 <20230913205838.GA21038@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913205838.GA21038@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 22:58:38+0200, Willy Tarreau wrote:
> On Wed, Sep 13, 2023 at 10:19:00PM +0200, Thomas Weißschuh wrote:
> > > All on aarch64 running fedora37 + upstream kernel. Any hints on what could
> > > be borken here or how to actually fix it?
> > 
> > I reduced it to the following reproducer:
> > 
> >     $ cat test.c
> >     int foo;  /* It works when deleting this variable */
> >     
> >     void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
> >     {
> >     	__asm__ volatile (
> >     		"mov x8, 93\n"       /* NR_exit == 93 */
> >     		"svc #0\n"
> >     	);
> >     	__builtin_unreachable();
> >     }
> >     
> >     $ aarch64-linux-gnu-gcc -Os -static -fno-stack-protector -Wall -nostdlib test.c
> >     $ ./a.out
> >     Segmentation fault
> > 
> > Also when running under gdb the error message is:
> > 
> >     During startup program terminated with signal SIGSEGV, Segmentation fault.
> > 
> > So it seems the error already happens during loading.
> > 
> > Could be a compiler or kernel bug?
> 
> I tried here with gcc-11.4.0 native on an ubuntu-22.04 and using a
> cross gcc-9.5 executed on another box and couldn't reproduce the issue
> at all. It could be that the compiler inserts whatever, did someone
> try to disassemble de resulting program to see what it looks like ?
> Maybe we're even dealing with issues related to random stack alignment
> that causes issues past a function call due to some garbage being placed
> at the wrong place in the stack. Also, dmesg should generally report
> what (and where) the segv happened. Similarly, gdb with "info reg"
> and "disassemble $pc" should report some info.

Im using:

aarch64-linux-gnu-gcc (GCC) 13.2.0

It's reproducible reliably.

No output in dmesg, binary works in qemu-user.
There should be no function calls at all, or?
GDB also doesn't show any registers, it seems to fail before anything is
executed.

> 
> In my case, I just have this:
> 
>   $ objdump -d a.out 
> 
>   a.out:     file format elf64-littleaarch64
> 
> 
>   Disassembly of section .text:
> 
>   0000000000400144 <_start>:
>     400144:       d2800ba8        mov     x8, #0x5d                       // #93
>     400148:       d4000001        svc     #0x0

Looks absolutely identical for me.

> 
> The kernel is a 6.2:
> 
>   $ uname -a
>   Linux ampere 6.2.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Jul 13 20:49:15 UTC 2 aarch64 aarch64 aarch64 GNU/Linux

Linux fedora-4gb-fsn1-1 6.4.11-200.fc38.aarch64 #1 SMP PREEMPT_DYNAMIC Wed Aug 16 18:01:59 UTC 2023 aarch64 GNU/Linux

(Just a default ARM VM on Hetzner with Fedora 38)
