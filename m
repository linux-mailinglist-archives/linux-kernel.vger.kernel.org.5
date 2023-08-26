Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB657897F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjHZQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHZQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:04:55 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25A1BE6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693065892;
        bh=+SGIC5dxof8GjOe3TXq/u5jq4AcqCToAtMLWOcxfXuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NMc6oDfrFJVVpZ1Fs+xnzNsqDfIUGlVyTHSuzeXw25zDnP2xtcBbtE7PkGTDmtKgf
         v8R1nLBoNLgXBYEQ7y7rCoBvviHgG1jD/iVlwspXNTlR4awOLkbAAnxXCdFWuDhQcB
         NltGo158Wqh4+OchlBrJYWDgMkAZfPuTGmr9gKDfEUuNsANGh00e14P80RlLQ0xThx
         Eky5S+D+hN7lWyLw7L29/FsYy0JCboKq2aIVFPTcvu9l4jLpUF4pKoIZtOHG4mXUps
         E7edd52VKn66DihASghC8rH+yqLUscn3iy4XueGoCacSkmgp4Zgsdzg69iI6lijfKa
         fjy9lqI2oovLw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id F355724B175;
        Sat, 26 Aug 2023 23:04:49 +0700 (WIB)
Date:   Sat, 26 Aug 2023 23:04:45 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/1] Fix a stack misalign bug on _start
Message-ID: <ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org>
References: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
 <20230826152024.7773-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230826152024.7773-1-falcon@tinylab.org>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:20:24PM +0800, Zhangjin Wu wrote:
> >   $eax   : 0x56559000  →  0x00003f90
> >   $ebx   : 0x56559000  →  0x00003f90
> >   $ecx   : 0x1
> >   $edx   : 0xf7fcaaa0  →   endbr32 
> >   $esp   : 0xffffcdbc  →  0x00000001
> >   $ebp   : 0x0
> >   $esi   : 0xffffce7c  →  0xffffd096
> >   $edi   : 0x56556060  →  <_start+0> xor %ebp, %ebp
> >   $eip   : 0x56556489  →  <sse_pq_add+25> movaps %xmm0, 0x30(%esp)
> > 
> >     <sse_pq_add+11>  pop    %eax
> >     <sse_pq_add+12>  add    $0x2b85, %eax
> >     <sse_pq_add+18>  movups -0x1fd0(%eax), %xmm0
> >   → <sse_pq_add+25>  movaps %xmm0, 0x30(%esp)     <== trapping instruction
> >     <sse_pq_add+30>  movups -0x1fe0(%eax), %xmm1
> >     <sse_pq_add+37>  movaps %xmm1, 0x20(%esp)
> >     <sse_pq_add+42>  movups -0x1ff0(%eax), %xmm2
> >     <sse_pq_add+49>  movaps %xmm2, 0x10(%esp)
> >     <sse_pq_add+54>  movups -0x2000(%eax), %xmm3
> > 
> >   [#0] Id 1, Name: "test", stopped 0x56556489 in sse_pq_add (), reason: SIGSEGV
> > 
> >   (gdb)  bt
> >   #0  0x56556489 in sse_pq_add ()
> >   #1  0x5655608e in main ()
> >
> 
> Since we have a new 'startup' test group, do you have a short function
> to trigger this error?

Here is a simple program to test the stack alignment.

#include "tools/include/nolibc/nolibc.h"

__asm__ (
"main:\n"
    /*
     * When the call main is executed, the
     * %esp is 16 bytes aligned.
     *
     * Then, on function entry (%esp mod 16) == 12
     * because the call instruction pushes 4 bytes
     * onto the stack.
     *
     * subl $12, %esp will make (%esp mod 16) == 0
     * again.
     */
    "subl  $12, %esp\n"

    /*
     * These move instructions will crash if %esp is
     * not a multiple of 16.
     */
    "movdqa (%esp), %xmm0\n"
    "movdqa %xmm0, (%esp)\n"
    "movaps (%esp), %xmm0\n"
    "movaps %xmm0, (%esp)\n"

    "addl   $12, %esp\n"
    "xorl   %eax, %eax\n"
    "ret\n"
);

> Perhaps it is time for us to add a new 'stack alignment' test case for
> all of the architectures.

I don't know the alignment rules for other architectures (I only work on
x86 and x86-64). While waiting for the maintainers' comment, I'll leave
the test case decision to you. Feel free to take the above code.

Extra:
It's also fine if you take my patch with the 'sub $(16 - 4), %esp'
change and batch it together in your next series.

-- 
Ammar Faizi

