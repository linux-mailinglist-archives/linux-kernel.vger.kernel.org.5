Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3CC78F778
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348224AbjIADfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:35:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7571FCF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:35:27 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3813Z8tH015864;
        Fri, 1 Sep 2023 05:35:08 +0200
Date:   Fri, 1 Sep 2023 05:35:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Message-ID: <ZPFb7DkAYQW8+XwT@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org>
 <ZO+0IW1zS9QNpP4y@1wt.eu>
 <ZPFZejgd0h7ErwLL@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPFZejgd0h7ErwLL@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:24:42AM +0700, Ammar Faizi wrote:
> On Wed, Aug 30, 2023 at 11:26:57PM +0200, Willy Tarreau wrote:
> > Out of curiosity, given that you implemented the 3 other ones directly
> > in an asm statement, is there a particular reason this one mixes a bit
> > of C and asm ?
> 
> Because this one maybe unused. The other are explicitly exported.

Makes sense, indeed.

> > It would probably be something around this, in the same vein:
> > 
> >   memcmp:
> >     xchg  %esi,%eax   // source1
> >     mov   %rdx,%rcx   // count
> >     rep   cmpsb       // source2 in rdi; sets ZF on equal, CF if src1<src2
> >     seta  %al         // 0 if src2 <= src1, 1 if src2 > src1
> >     sbb   $0, %al     // 0 if src2 == src1, -1 if src2 < src1, 1 if src2 > src1
> >     movsx %al, %eax   // sign extend to %eax
> >     ret
> > 
> > Note that the output logic could have to be revisited, I'm not certain but
> > at first glance it looks valid.
> 
> After thinking about this more, I think I'll drop the memcmp() patch
> because it will prevent optimization when comparing a small value.
> 
> For example, without __asm__:
> 
>     memcmp(var, "abcd", 4);
> 
> may compile to:
> 
>     cmpl $0x64636261, %reg
>     ...something...
> 
> But with __asm__, the compiler can't do that. Thus, it's not worth
> optimizing the memcmp() in this case.

Ah you're totally right!

Willy
