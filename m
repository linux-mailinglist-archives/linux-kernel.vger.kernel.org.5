Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E07B5425
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbjJBNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjJBNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:41:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2620B4;
        Mon,  2 Oct 2023 06:41:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B437AC15;
        Mon,  2 Oct 2023 06:41:53 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 279FA3F59C;
        Mon,  2 Oct 2023 06:41:13 -0700 (PDT)
Date:   Mon, 2 Oct 2023 14:41:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Edward AD <twuufnxlz@gmail.com>, alex@ghiti.fr,
        aou@eecs.berkeley.edu, conor@kernel.org,
        gregkh@linuxfoundation.org, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Test for riscv fixes
Message-ID: <ZRrIcaa-2Co2cSJm@FVFF77S0Q05N.cambridge.arm.com>
References: <CAHVXubhG2c=ShFHF4hMMFm8=BYDTyDUduOizujbUWQBW+55wTw@mail.gmail.com>
 <20230929230549.45206-2-twuufnxlz@gmail.com>
 <CAHVXubiBVKJ89fBtV1fvEpoOyLvdvjkWfeDmw2yZsod5ao9hPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubiBVKJ89fBtV1fvEpoOyLvdvjkWfeDmw2yZsod5ao9hPw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:13:52AM +0200, Alexandre Ghiti wrote:
> Hi Edward,
> 
> On Sat, Sep 30, 2023 at 1:06 AM Edward AD <twuufnxlz@gmail.com> wrote:
> >
> > Hi Alexandre,
> >
> > On Fri, 29 Sep 2023 10:25:59 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> > > I'm still not convinced this will fix the kasan out-of-bounds
> > > accesses, the page can be valid but the read can happen at an offset
> > > not initialized and trigger such errors right? I still think there is
> > > something weird about the stack frame, as to me this should not happen
> > > (but admittedly I don't know much about that).
> > The added check can confirm that the physical page is invalid (whether it is a
> > vmalloc allocated page or a slab allocated page), and exit the for loop when it is invalid.
> 
> Yes, but to me this is not what happens in the bug report you link:
> 
> | BUG: KASAN: out-of-bounds in walk_stackframe+0x130/0x2f2
> arch/riscv/kernel/stacktrace.c:59
> | Read of size 8 at addr ff20000006d37c38 by task swapper/1/0
> 
> So the read at address ff20000006d37c38 is not "normal" according to
> KASAN (you can see there is no trap, meaning the physical mapping
> exists).
> 
> | The buggy address belongs to the virtual mapping at
> |  [ff20000006d30000, ff20000006d39000) created by:
> | kernel_clone+0x118/0x896 kernel/fork.c:2909
> 
> The virtual address is legitimate since the vma exists ^
> 
> | The buggy address belongs to the physical page:
> | page:ff1c00000250dbc0 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x9436f
> 
> And the physical page also exists ^
> 
> So I insist, checking that a physical mapping exists to exit the loop
> is not enough, to me, the error here is that the backtrace goes "too
> far" at an address where nothing was written before and then KASAN
> complains about that, again, we don't take any page fault here so it's
> not a problem of existing physical mapping.

Yep!

I believe what's happening here is one task unwinding another (starting from
whatever gets saved in switch_to()), and there's nothing that prevents that
other task from running concurrently and modifying/poisoning its stack. In
general trying to unwind a remote stack is racy and broken, but we're stuck
with a few bits of the kernel tryingto do that occasionally and so the arch
code needs to handle that without blowing up.

For KASAN specifically you'll need to access the stack with unchecked accesses
(e.g. using READ_ONCE_NOCHECK() to read the struct stackframe), and you'll
probably want to add some explicit checks that pointers are within stack bounds
since concurrent modification (or corruption) could result in entirely bogus
pointers.

I *think* that we do the right thing on arm64, so you might want to take a look
at arm64's unwinder in arch/arm64/kernel/stacktrace.c,
arch/arm64/include/asm/stacktrace.h, and
arch/arm64/include/asm/stacktrace/common.h.

Mark.
