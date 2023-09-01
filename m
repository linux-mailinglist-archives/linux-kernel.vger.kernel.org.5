Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF578FC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbjIALrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbjIALru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:47:50 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25D291994
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:47:26 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 381Bkiql019545;
        Fri, 1 Sep 2023 13:46:44 +0200
Date:   Fri, 1 Sep 2023 13:46:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Ammar Faizi'" <ammarfaizi2@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Message-ID: <ZPHPJDXIkFfP5Eux@1wt.eu>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 11:34:18AM +0000, David Laight wrote:
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > Sent: 30 August 2023 14:57
> > 
> > This is an RFC patchset for nolibc x86-64 string functions. There are 5
> > patches in this series.
> > 
> > ## Patch 1-3: Use `rep movsb`, `rep stosb`, and `rep cmpsb` for:
> >     - memcpy() and memmove()
> >     - memset()
> >     - memcmp()
> > respectively. They can simplify the generated ASM code.
> > 
> ...
> > After this series:
> > ```
> >   000000000000140a <memmove>:
> >     140a: 48 89 f8              mov    %rdi,%rax
> >     140d: 48 89 d1              mov    %rdx,%rcx
> >     1410: 48 8d 7c 0f ff        lea    -0x1(%rdi,%rcx,1),%rdi
> >     1415: 48 8d 74 0e ff        lea    -0x1(%rsi,%rcx,1),%rsi
> >     141a: fd                    std
> >     141b: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi)
> >     141d: fc                    cld
> >     141e: c3                    ret
> 
> Isn't that completely broken?
> 
> You need to select between forwards and backwards moves.
> Since forwards moves are preferred it is best to do
> 	if (dst - src < len)
> 		backards_copy()
> 	else
> 		formwards_copy()
> 
> 	David

You're completely right indeed, reminds me about the copy_up/copy_down
that were not used anymore :-)

Willy
