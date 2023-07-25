Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5B7609AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGYFqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGYFqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:46:12 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47101BCF;
        Mon, 24 Jul 2023 22:45:47 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id E8E5C16EA4A;
        Tue, 25 Jul 2023 07:45:44 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1690263945; bh=cOZeUdr74EYlNDHR9of8tJEBAX9HIYqAko8R41MuQqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGeSK3kRe6UuRl+DgoknKfuT4M+rnFaJFUpWpASoZqkF80f8hrsEAx1xzlYH2lPKC
         uC4KOcCC9cH4OfeeorC7papriHKjW2yCnvw89HTt87WElQzzSx+KQU77I965kMLQkX
         JIDWqRMoCNRfuOPQ5monhwK1ABUec/Ik8cDv8ZQ/jdi+D1TcfQ4EA+h05Ph8nWtuad
         ntKP4jtJRBSDl2iWh7sNKFTLwm4Qt2OCD5iZNVe5VajacoDKCh1gIss+qeChdyJ/Bx
         GVpnoSnZ0Pt4vutdHGJF5Dm+z1nxQeQSyiWnX2sFwC26X+o/KbvPwEiDW6sxSHXPV3
         nE8Rfm+HH19AA==
Date:   Tue, 25 Jul 2023 07:45:44 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
Message-ID: <20230725074544.4ae1d77e@meshulam.tesarici.cz>
In-Reply-To: <20230724174331.GD11977@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
        <20230724171229.GC11977@pendragon.ideasonboard.com>
        <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
        <20230724174331.GD11977@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 20:43:31 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Mon, Jul 24, 2023 at 07:29:27PM +0200, John Paul Adrian Glaubitz wrote:
> > On Mon, 2023-07-24 at 20:12 +0300, Laurent Pinchart wrote:  
> > > On Mon, Jul 24, 2023 at 02:07:42PM +0200, Petr Tesarik wrote:  
> > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > > 
> > > > In all these cases, the last argument to dma_declare_coherent_memory() is
> > > > the buffer end address, but the expected value should be the size of the
> > > > reserved region.
> > > > 
> > > > Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> > > > Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> > > > Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> > > > Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> > > > Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")
> > > > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>  
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > But given that nobody noticed for 5 years, maybe we should drop
> > > renesas-ceu support from those boards ? Or drop the boards completely ?  
> > 
> > arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
> > going to convert the architecture to using Device Trees which should reduce the maintenance
> > burden anyways.  
> 
> Keeping the architecture is fine for newer systems, but is anyone really
> maintaining the Renesas SH board ?

FWIW I don't have any opinion here. I found these calls as a side
effect of making an overview of DMA-capable devices (in preparation for
moving all DMA-related members away from struct device). I don't have
any of those boards myself.

Petr T
