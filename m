Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4678DE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbjH3TCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbjH3PwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:52:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560EC122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:52:01 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37UFpq87028074;
        Wed, 30 Aug 2023 17:51:52 +0200
Date:   Wed, 30 Aug 2023 17:51:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Message-ID: <ZO9lmGoMDh10jdsk@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
 <ZO9bv+GvgpphtGEi@biznet-home.integral.gnuweeb.org>
 <ZO9e6h2jjVIMpBJP@1wt.eu>
 <ZO9j9WhSj7PmsM8b@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO9j9WhSj7PmsM8b@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:44:53PM +0700, Ammar Faizi wrote:
> On Wed, Aug 30, 2023 at 05:23:22PM +0200, Willy Tarreau wrote:
> > Then "xchg %esi, %eax" is just one byte with no memory access ;-)
> 
> Perfect!
> 
> Now I got this, shorter than "movl %esi, %eax":
> ```
> 0000000000001500 <memset>:
>     1500: 96          xchg   %eax,%esi
>     1501: 48 89 d1    mov    %rdx,%rcx
>     1504: 57          push   %rdi
>     1505: f3 aa       rep stos %al,%es:(%rdi)
>     1507: 58          pop    %rax
>     1508: c3          ret
> ```
> 
> Unfortunately, the xchg trick doesn't yield smaller machine code for
> %rdx, %rcx. Lol.

Normal, that's because historically "xchg ax, regX" was a single-byte 0x9X
on 8086, then it turned to 32-bit keeping the same encoding, like many
instructions (note that NOP is encoded as xchg ax,ax). It remains short
when you can sacrifice the other register, or restore it later using yet
another xchg. For rcx/rdx a push/pop could do it as they should also be
a single-byte 0x5X even in long mode unless I'm mistaken. Thus if you
absolutely want to squeeze that 9th byte to end up with a 8-byte function
you could probably do:

    xchg %eax, %esi      1
    push %rdx            1
    pop %rcx             1
    push %rdi            1
    rep movsb            2
    pop %rax             1
    ret                  1
    ------------- Total: 8 bytes :-)

Willy
