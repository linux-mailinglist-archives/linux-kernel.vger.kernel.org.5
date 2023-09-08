Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB4798820
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjIHNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjIHNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:50:35 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B361BC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LbgxR6XC8LYMVBzfsv+O9qJkpfwcf2slpkIZbcLgfOw=; b=amB6TIzYbCI8yf9vGXczOH6gAb
        Necd/KYkOmHfQ8ShgSY+zaCPtTpDolSDpVYcgB0Cxgc967lR9v0sUO0K1oyH3at2+B8T23Ty2llYU
        qZalkl5ChML9LfUaG7ZDMjiUJFL7OTq/LrGs0Di+oblw2xGfDKfhCaymtM0ErZyPUcz27rf7oBn1A
        GM1LrIzFPqsJQWTrrzwvc6IqnrF0pr2ZUJgtLG1fn3wkRvJVaN6Z6p5eBIsICRxIPSrLEdZCUSS0H
        AMOV0UMv3c7zQY7CFUGDALXmUgOldxAa2fdUsX4UfJOcpU16jTr2s538brGD+AVocsrlL5c6h00bN
        xrdiy3KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36590)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qebs9-00050u-2n;
        Fri, 08 Sep 2023 14:50:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qebs1-0006wF-Av; Fri, 08 Sep 2023 14:50:01 +0100
Date:   Fri, 8 Sep 2023 14:50:01 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zhizhou Zhang <zhizhou.zh@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de,
        wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
Message-ID: <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
References: <20230907143302.4940-1-zhizhou.zh@gmail.com>
 <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:58:49PM +0200, Linus Walleij wrote:
> Hi Zhizhou,
> 
> wow a great patch! I'm surprised no-one has been hit by this before.
> I guess we were lucky.
> 
> On Thu, Sep 7, 2023 at 4:33 PM Zhizhou Zhang <zhizhou.zh@gmail.com> wrote:
> 
> > From: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> >
> > flush_cache_all() save registers to stack at function entry.
> > If it's called after cache disabled, the data is written to
> > memory directly. So the following clean cache operation corrupted
> > registers saved by flush_cache_all(), including lr register.
> > calling flush_cache_all() before turn off cache fixed the problem.
> >
> > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I would also add
> Cc: stable@vger.kernel.org
> 
> Then please put this into Russell's patch tracker once review
> is complete.

However, it makes a total nonsense of the comment, which explains
precisely why the flush_cache_all() is where it is. Moving it before
that comment means that the comment is now rediculous.

So, please don't put it in the patch system.

The patch certainly needs to be tested on TI Keystone which is the
primary user of this code.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
