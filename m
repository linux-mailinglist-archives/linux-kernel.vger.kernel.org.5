Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C360802800
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 22:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjLCVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 16:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 16:37:46 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DE2BC2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 13:37:52 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3B3LbnMF021009;
        Sun, 3 Dec 2023 22:37:49 +0100
Date:   Sun, 3 Dec 2023 22:37:49 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nolibc: optimise _start() on x86_64
Message-ID: <20231203213749.GA20917@1wt.eu>
References: <38183c29-9b7f-4960-8702-d71ce816cf80@p183>
 <20231202132359.GA15040@1wt.eu>
 <4d12b353-7417-4776-90de-0f04462cc221@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d12b353-7417-4776-90de-0f04462cc221@p183>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 03:00:48PM +0300, Alexey Dobriyan wrote:
> On Sat, Dec 02, 2023 at 02:23:59PM +0100, Willy Tarreau wrote:
> > Hi Alexey,
> > 
> > On Sat, Dec 02, 2023 at 03:45:13PM +0300, Alexey Dobriyan wrote:
> > > Just jump into _start_c, it is not going to return anyway.
> > 
> > Thanks, but what's upper in the stack there ?
> 
> argc
> 
> (gdb) break _start
> (gdb) run
> 
> (gdb) x/20gx $sp
> 0x7fffffffdae0: 0x0000000000000004      0x00007fffffffdf33
> 0x7fffffffdaf0: 0x00007fffffffdf49      0x00007fffffffdf4b
> 0x7fffffffdb00: 0x00007fffffffdf4d      0x0000000000000000
> 0x7fffffffdb10: 0x00007fffffffdf4f      0x00007fffffffdf70
> 0x7fffffffdb20: 0x00007fffffffdf80      0x00007fffffffdfce
> 
> (gdb) x/s 0x00007fffffffdf33
> 0x7fffffffdf33: "/home/ad/s-test/a.out"
> 
> > I'm trying to make sure
> > that if _start_c returns we don't get a random behavior.
> 
> Yes, it should segfault executing from very small address.
> I tested with
> 
> .intel_syntax noprefix
> .globl _start
> _start:
> 	ret
> 	mov	eax, 231
> 	xor	edi, edi
> 	syscall

Well, this could possibly be acceptable then but the ABI also says that
we need rsp to be 16-byte aligned before the call, so it's supposed to
be 8 on top of this, so this would actually require more code to maintain
this guarantee, since a sub rsp,8 is longer than just the hlt we're saving.

> > If we get a
> > systematic crash (e.g. 0 always there) that's fine, what would be
> > annoying would be random infinite loops etc. In the psABI description
> > (table 3.9) I'm seeing "undefined" before argc, which I don't find
> > much appealing.
> > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > > 
> > > 	Also, kernel clears all registers before starting process,
> > > 	I'm not sure why
> > > 
> > > 		xor ebp, ebp
> > > 
> > > 	was added.
> > 
> > Hmmm psABI says:
> > 
> >   Only the registers listed below have specied values at process entry:
> > 
> >   %rbp The content of this register is unspecied at process initialization
> >        time, but the user code should mark the deepest stack frame by setting
> >        the frame pointer to zero.
> > 
> >   %rsp The stack pointer holds the address of the byte with lowest address
> > 	which is part of the stack. It is guaranteed to be 16-byte aligned at
> >         process entry.
> > 
> >   %rdx a function pointer that the application should register with atexit (BA_OS).
> > 
> > Thus apparently it's documented as being our job to clear it :-/
> 
> I meant, ELF loader clears all registers except rsp and aligns the stack to 16 bytes.
> There were problems with stack aligning, but registers, I think, were always zeroed.

But there's a strong difference between what's observed and what's
specified. If you get the x86_64 ABI spec to reflect this, it becomes
the standard and we can rely on it. Otherwise the standard remains what
is documented, and what is implemented may change while remaining within
the specs above.

Willy
