Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12578FE0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjIANGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjIANGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:06:37 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A7E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693573593;
        bh=Yh7Bhhmj/N2hz2kgioBCdiLSuNHPhfwNfuEtq7aDPuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MNzOqLab6Kv48mCwiH4BHhFBK/849CuzdybHQUl1gg48XQ+s+83rumFh0PrIwo6qF
         2ZmEPdaOoeR1WG5ncfR5HplqgF/0omGKgT6nLFPo4aCNLY8uhSqbpufMzrB77T4hPd
         Q8UY/c1lY9OrzPr7/Ca76TiaSOGdV/FDWo2eeNkfe0nmuNnrVBGP4AU7aZSvIXrPw1
         y5fehwuszH53w0mlFzesRB43jJqJlK8ZeQJ0+tJkqWxuFMJpVjHs815w8spA19/QpN
         IkToA8wYAaOm1iA8RGo7FCo2QCqloqtztHLJ89vd6BY3YbpKZJbwHv/jNn9VOGnJ9A
         4xsV8q6ByR3ig==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 727FC24B374;
        Fri,  1 Sep 2023 20:06:30 +0700 (WIB)
Date:   Fri, 1 Sep 2023 20:06:25 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/5] nolibc x86-64 string functions
Message-ID: <ZPHh0duonHnyAX6C@biznet-home.integral.gnuweeb.org>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <5a821292d96a4dbc84c96ccdc6b5b666@AcuMS.aculab.com>
 <ZPHPJDXIkFfP5Eux@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPHPJDXIkFfP5Eux@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:46:44PM +0200, Willy Tarreau wrote:
> On Fri, Sep 01, 2023 at 11:34:18AM +0000, David Laight wrote:
> > Isn't that completely broken?
> > 
> > You need to select between forwards and backwards moves.
> > Since forwards moves are preferred it is best to do
> > 	if (dst - src < len)
> > 		backards_copy()
> > 	else
> > 		formwards_copy()
> > 
> > 	David
> 
> You're completely right indeed, reminds me about the copy_up/copy_down
> that were not used anymore :-)

I'm an idiot, will fix that. Another attempt as suggested below:

__asm__ (
".section .text.nolibc_memmove\n"
".weak memmove\n"
"memmove:\n"
"    movq    %rdx, %rcx\n"
"    movq    %rdi, %rdx\n"
"    movq    %rdi, %rax\n"
"    subq    %rsi, %rdx\n"
"    cmpq    %rcx, %rdx\n"
"    jnb     .Lforward_copy\n"
"    leaq    -1(%rdi, %rcx, 1), %rdi\n"
"    leaq    -1(%rsi, %rcx, 1), %rsi\n"
"    std\n"
".Lforward_copy:\n"
"    rep movsb\n"
"    cld\n"
"    ret\n"
);

-- 
Ammar Faizi

