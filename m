Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F367789825
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHZQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjHZQhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 12:37:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619E122
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 09:37:36 -0700 (PDT)
X-QQ-mid: bizesmtp70t1693067817txikufn0
Received: from linux-lab-host.localdomain ( [116.30.128.222])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 27 Aug 2023 00:36:47 +0800 (CST)
X-QQ-SSF: 00200000000000E0Y000000A0000000
X-QQ-FEAT: WP/PdQRFMYsz/mSHuYOc6yi0FsMCGeBxAKUoOgqZy23x0rBGJvn2x/KL90lrP
        bE7bw+BW+HcwR0Wx9fBAxXVJ6ODEsOef9drEx0WZRrMsllZTqPDJaJtb7NhbvfZS9qq8rZv
        AbBFW9iwhhklLPXquXvk7JbzunYsacKSTELJbuageFmXtCmGjgH4qwCiPwqSNL2s/s7F1JK
        Fb8DYEHrZc6IkhJ4/mNvkyGj0KRd1ZlFr4e04Y7vy+VVmzAg449AZOoFfLlY2eouEJomg1E
        +dLAaO3/fcAUsTmaDchwMd8j3RjUdsYPLF65FkAYn6vhjQ2q/YEUGijIG9UuGQq1hW+ITt/
        fsHkIr0gfGTlGq8wTnkMOIxYWhp9g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9061740249613107006
From:   Zhangjin Wu <falcon@tinylab.org>
To:     ammarfaizi2@gnuweeb.org
Cc:     falcon@tinylab.org, gwml@vger.gnuweeb.org, inori@vnlx.org,
        linux-kernel@vger.kernel.org, linux@weissschuh.net,
        moe@gnuweeb.org, w@1wt.eu
Subject: Re: [PATCH v1 0/1] Fix a stack misalign bug on _start
Date:   Sun, 27 Aug 2023 00:36:47 +0800
Message-Id: <20230826163647.8178-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org>
References: <ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ammar

> On Sat, Aug 26, 2023 at 11:20:24PM +0800, Zhangjin Wu wrote:
> > >   $eax   : 0x56559000  →  0x00003f90
> > >   $ebx   : 0x56559000  →  0x00003f90
> > >   $ecx   : 0x1
> > >   $edx   : 0xf7fcaaa0  →   endbr32 
> > >   $esp   : 0xffffcdbc  →  0x00000001
> > >   $ebp   : 0x0
> > >   $esi   : 0xffffce7c  →  0xffffd096
> > >   $edi   : 0x56556060  →  <_start+0> xor %ebp, %ebp
> > >   $eip   : 0x56556489  →  <sse_pq_add+25> movaps %xmm0, 0x30(%esp)
> > > 
> > >     <sse_pq_add+11>  pop    %eax
> > >     <sse_pq_add+12>  add    $0x2b85, %eax
> > >     <sse_pq_add+18>  movups -0x1fd0(%eax), %xmm0
> > >   → <sse_pq_add+25>  movaps %xmm0, 0x30(%esp)     <== trapping instruction
> > >     <sse_pq_add+30>  movups -0x1fe0(%eax), %xmm1
> > >     <sse_pq_add+37>  movaps %xmm1, 0x20(%esp)
> > >     <sse_pq_add+42>  movups -0x1ff0(%eax), %xmm2
> > >     <sse_pq_add+49>  movaps %xmm2, 0x10(%esp)
> > >     <sse_pq_add+54>  movups -0x2000(%eax), %xmm3
> > > 
> > >   [#0] Id 1, Name: "test", stopped 0x56556489 in sse_pq_add (), reason: SIGSEGV
> > > 
> > >   (gdb)  bt
> > >   #0  0x56556489 in sse_pq_add ()
> > >   #1  0x5655608e in main ()
> > >
> > 
> > Since we have a new 'startup' test group, do you have a short function
> > to trigger this error?
> 
> Here is a simple program to test the stack alignment.
> 
> #include "tools/include/nolibc/nolibc.h"
> 
> __asm__ (
> "main:\n"
>     /*
>      * When the call main is executed, the
>      * %esp is 16 bytes aligned.
>      *
>      * Then, on function entry (%esp mod 16) == 12
>      * because the call instruction pushes 4 bytes
>      * onto the stack.
>      *
>      * subl $12, %esp will make (%esp mod 16) == 0
>      * again.
>      */
>     "subl  $12, %esp\n"
> 
>     /*
>      * These move instructions will crash if %esp is
>      * not a multiple of 16.
>      */
>     "movdqa (%esp), %xmm0\n"
>     "movdqa %xmm0, (%esp)\n"
>     "movaps (%esp), %xmm0\n"
>     "movaps %xmm0, (%esp)\n"
> 
>     "addl   $12, %esp\n"
>     "xorl   %eax, %eax\n"
>     "ret\n"
> );
>

Thanks very much for sharing this code.

> > Perhaps it is time for us to add a new 'stack alignment' test case for
> > all of the architectures.
> 
> I don't know the alignment rules for other architectures (I only work on
> x86 and x86-64). While waiting for the maintainers' comment, I'll leave
> the test case decision to you. Feel free to take the above code.
>

Yes, the stack alignment rule is architecture dependent, so, we need
more discussion and more work, not sure if there is a 'C' test function
for all, let's delay this after v6.6.

> Extra:
> It's also fine if you take my patch with the 'sub $(16 - 4), %esp'
> change and batch it together in your next series.
>

Ammar, your fixup patch is urgent since our _start_c() is for v6.6-rc1 (already
in linux-next), let's wait for comments from Thomas or Willy, they will
determine that merge it directly or require a v2. I'm ok with v1 code, but the
old comment looks not that clear.

Thanks,
Zhangjin

> -- 
> Ammar Faizi
