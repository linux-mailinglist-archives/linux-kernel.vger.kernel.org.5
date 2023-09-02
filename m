Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D190790592
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351654AbjIBGW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:22:56 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8948B10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:22:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3826MbQZ023182;
        Sat, 2 Sep 2023 08:22:37 +0200
Date:   Sat, 2 Sep 2023 08:22:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Message-ID: <20230902062237.GA23141@1wt.eu>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
 <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 01:11:06PM +0700, Ammar Faizi wrote:
> On Sat, Sep 02, 2023 at 01:07:50PM +0700, Alviro Iskandar Setiawan wrote:
> > Btw, sir, this can be simplified more by merging the forward copy
> > path, only using two "rep movsb" for both memmove() and memcpy()
> > should be enough?
> > ```
> > __asm__ (
> > ".section .text.nolibc_memmove_memcpy\n"
> > ".weak memmove\n"
> > ".weak memcpy\n"
> > "memmove:\n"
> >         "movq %rdx, %rcx\n"
> >         "movq %rdi, %rdx\n"
> >         "movq %rdi, %rax\n"
> >         "subq %rsi, %rdx\n"
> >         "cmpq %rcx, %rdx\n"
> >         "jnb __nolibc_forward_copy\n"
> >         "leaq -1(%rdi, %rcx, 1), %rdi\n"
> >         "leaq -1(%rsi, %rcx, 1), %rsi\n"
> >         "std\n"
> >         "rep movsb\n"
> >         "cld\n"
> >         "retq\n"
> > 
> > "memcpy:\n"
> >         "movq %rdi, %rax\n"
> >         "movq %rdx, %rcx\n"
> > "__nolibc_forward_copy:\n"
> >         "rep movsb\n"
> >         "retq\n"
> > );
> > ```
> 
> Looks good. I'll apply that change.

Note that in this case we simply don't need a special
version of memcpy(), memmove() is always OK for this,
so you can simplify this further by starting with:

  memcpy:
  memmove:
        ...

Willy
