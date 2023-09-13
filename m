Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3079E1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbjIMIRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbjIMIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:17:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C319A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XR3dh35/QhQEf+862guB3I5IbCeKyOZ1Ck8CZrTaQWs=; b=sNsEsHkn+tRAnBd8vQ4F3MyjfW
        YjdQwu6IW7FMpBKjwmcukhcpSlB7x6XF12uorKvvFex3T5Bkh1cq7uhcStvxSCkAHXr3Tkcp1q2bX
        AOGrEQ0UC8UG1SRXoEj/IkQ4rRNSipNkr/FuvqzJZeDiVHTZW/37aWVL3N1CbtpAVIRDxZGB4BG85
        R1/YTVKgG7IG6SLyerkyLay/in0KEt3utgTJxNp1R5UKTiQ6dXccZAjjB/3yB1fzMfbyXtRkwZN0C
        x7e0g6PpKiCh0DzAzigUsikVFdNERxsBxHPQWRsICeRTlT1CldSrmfZ/5TB21zJkhdurPJWVuSYRM
        d7VXL3uQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54172)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgL3Q-000284-1y;
        Wed, 13 Sep 2023 09:16:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgL3L-0003aA-TC; Wed, 13 Sep 2023 09:16:51 +0100
Date:   Wed, 13 Sep 2023 09:16:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com
Subject: Re: [PATCH] arch: arm: remove redundant clear_page when
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on
Message-ID: <ZQFv8+tI/hEaOzcD@shell.armlinux.org.uk>
References: <20230912103334.2074140-1-zhaoyang.huang@unisoc.com>
 <ZQBW23Upv/CdN9v6@casper.infradead.org>
 <CAGWkznEt+mAGtEN+mQm3ZdxTpScmBBOa0TT=oLtuTF6Z-ipqZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznEt+mAGtEN+mQm3ZdxTpScmBBOa0TT=oLtuTF6Z-ipqZw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:13:14AM +0800, Zhaoyang Huang wrote:
> On Tue, Sep 12, 2023 at 8:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Sep 12, 2023 at 06:33:34PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Double times of clear_page observed in an arm SOC(A55) when
> > > CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on, which introduced by
> > > vma_alloc_zeroed_movable_folio within do_anonymous_pages.
> > > Since there is no D-cache operation within v6's clear_user_highpage,
> > > I would like to suggest to remove the redundant clear_page.

So if CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, then what ensures
that the page is cleared?

> > >
> > > struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> > >                                  unsigned long vaddr)
> > > {
> > >       struct folio *folio;
> > >
> > > //first clear_page invoked by vma_alloc_folio==>alloc_page==>post_alloc_hook
> > >       folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
> > >       if (folio)
> > > //second clear_page which is meaningless since it do nothing to D-cache in armv6
> > >               clear_user_highpage(&folio->page, vaddr);

If this clear_user_highpage() is removed, how is this code then safe when
CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled?

> >
> > This is, of course, not the only place which calls clear_user_highpage().
> > Please explain why this patch is safe for all the _other_ places which
> > call clear_user_highpage().
> Here are all positions called clear_user_highpage which are paired
> with alloc_pages. IMO,  it is safe to skip the second clear_page under
> armv6.

No.

Looking at, for example, the v4l case... This allocates a page and
provides it to userspace. The page is allocated using GFP_USER |
__GFP_DMA32. This does not set __GFP_ZERO. If
CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not enabled, the page will not
be initialised, and thus we will leak any data in that page to
userspace.

Now, it's not just about whether that configuration symbol is enabled
in the kernel configuration - there is a command line argument to
consider as well. CONFIG_INIT_ON_ALLOC_DEFAULT_ON can be y, but with
init_on_alloc=0 passed to the kernel, if we remove the above
clear_user_highpage(), the kernel then becomes unsafe.

However, it's more than that. The kernel allocator has no idea that the
page will be mapped to userspace, so it can't do the "clear the page at
the user cache colour" trick for VIPT aliasing caches, which ensures
that we hit cache lines that the user will see. So, I think we would
then have to add arch specific cache operations to write-back the
zeroing of the kernel mapping, _and_ cache operations to discard any
data in the user cache colour.

So, essentially, I don't think that _even_ when init_on_alloc is
enabled, we can skip calling clear_user_highpage() as that would lead
to data exposure to userspace.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
