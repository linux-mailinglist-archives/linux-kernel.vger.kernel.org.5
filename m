Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8F79F2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjIMUTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:19:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E381BC8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694636341;
        bh=lBmo7mf5P9G8d/uhsBJm9ostdhSi5Tl1kSOEEW/9bZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQuqqvFovP6Vtg8eNFMRMJsOQ4NB/qQs7AL5bh29YdddvyzJz+2oGAw+UHLoq6Ox2
         QMYnIee+hf7jqi5ueaaQfAI/tvjrUQdZdcc8Hdnqt4oQMMEIqlOvj49e/D9tNsSKTX
         ol/QAg852j709vwUgN9F8qIVOKXjRRG04oL3uK/c=
Date:   Wed, 13 Sep 2023 22:19:00 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <2da5ce29-e0de-4715-aa77-453ff3cc48aa@t-8ch.de>
References: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 20:44:59+0200, Sebastian Ott wrote:
> Hi,
> 
> the tpidr2 selftest on an arm box segfaults before reaching the entry point.
> I have no clue what is to blame for this or how to debug it but for a
> statically linked binary there shouldn't be much stuff going on besides the
> elf loader?
> 
> I can reproduce this with a program using an empty main function. Also checked
> for other nolibc users - same result for init.c from rcutorture.
> 
> tools/testing/selftests/arm64/fp/za-fork is working though - the only
> difference I could spot here is that it is linked together with another object
> file. I also looked at the elf headers but didn't find anything obvious (but
> I'm a bit out of my comfort zone here..)
> 
> After playing around with linker options I found that using -static-pie
> lets the binaries run successful.
> 
> [root@arm abi]# cat test.c
> int main(void)
> {
>         return 1;
> }
> [root@arm abi]# gcc -Os -static -Wall -lgcc -nostdlib -ffreestanding  -include ../../../../include/nolibc/nolibc.h  test.c
> [root@arm abi]# ./a.out Segmentation fault
> [root@arm abi]# gcc -Os -static -Wall -lgcc -nostdlib -ffreestanding -static-pie -include ../../../../include/nolibc/nolibc.h  test.c
> [root@arm abi]# ./a.out [root@arm abi]#
> 
> All on aarch64 running fedora37 + upstream kernel. Any hints on what could
> be borken here or how to actually fix it?

I reduced it to the following reproducer:

    $ cat test.c
    int foo;  /* It works when deleting this variable */
    
    void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) _start(void)
    {
    	__asm__ volatile (
    		"mov x8, 93\n"       /* NR_exit == 93 */
    		"svc #0\n"
    	);
    	__builtin_unreachable();
    }
    
    $ aarch64-linux-gnu-gcc -Os -static -fno-stack-protector -Wall -nostdlib test.c
    $ ./a.out
    Segmentation fault

Also when running under gdb the error message is:

    During startup program terminated with signal SIGSEGV, Segmentation fault.

So it seems the error already happens during loading.

Could be a compiler or kernel bug?

Thomas
