Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE237F3917
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKUWXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKUWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:23:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0C113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:23:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4497AC433C8;
        Tue, 21 Nov 2023 22:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700605407;
        bh=yDGhoyYN7O13RtyxLMKEk9K+AYdzCA8ZJvlLQmLrGa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U81xuoRrfse1IXY4EQDKJ7urwN00Qj6C/nWIBsLpw70KefSTQmfjc2ssfyoZC7zAN
         1z+fyiLg2uKB/E2nuXSxDc6x2h293eBsBG2YS3+0xt45PLEMtYGG7bQLfH9SxiJh7z
         Zd5awGMCZu1h7N6NPzzE8rCoaGPAMEF2jYuFgQU5jajSFDDUCU36OmWUUw2apk+36+
         ujLVgzd6G779e9cbuoN4lagSOPrxnSi6jjDq3ChhehPyQDPQoFvIzwU5z6c05pGB8E
         2P9KAYq6JPB0e5b5zh0DXGJUl/9x5bRtQY5Yv11A7DgyRrq5cdXKGjPDbIf0yYRHMR
         Xho78yQ44vR9A==
Date:   Tue, 21 Nov 2023 16:23:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, skinsburskii@gmail.com
Subject: Re: [PATCH] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Message-ID: <20231121222325.GA260057@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121220556.GA21969@skinsburskii.>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:05:56PM -0800, Stanislav Kinsburskii wrote:
> On Tue, Nov 21, 2023 at 03:37:55PM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 20, 2023 at 03:40:33PM -0800, Stanislav Kinsburskii wrote:
> > > Explicitly cast __iomem pointer to const void* with __force to fix the
> > > following warning:
> > > 
> > >   warning: incorrect type in argument 1 (different address spaces)
> > >      expected void const volatile *address
> > >      got void [noderef] __iomem *
> > 
> > I have two questions about this:
> > 
> >   1) There's no other use of __force in drivers/pci, so I don't know
> >   what's special about pcie-mediatek.c.  There should be a way to fix
> >   the types so it's not needed.
> 
> __force suppreses the following sparse warning:
> 
>     warning: cast removes address space '__iomem' of expression

I'm suggesting that the cast is a band-aid that covers up a type
mismatch, and there shouldn't be a mismatch in the first place.

> >   2) virt_to_phys() is not quite right to begin with because what we
> >   want is a *bus* address, not the CPU physical address we get from
> >   virt_to_phys().  Obviously the current platforms that use this must
> >   not apply any offset between bus and CPU physical addresses, but
> >   it's not something we should rely on.
> > 
> >   There are only three drivers (pci-aardvark.c, pcie-xilinx.c, and
> >   this one) that use virt_to_phys(), and they're all slightly wrong
> >   here.
> > 
> > The *_compose_msi_msg() methods could use a little more consistency
> > across the board.
> 
> Could you elaborate on what do you suggest?
> Should virt_to_phys() be simply removed?

The DMA API (Documentation/core-api/dma-api.rst) is the usual way to
get bus addresses, since an MSI is basically a DMA on the PCI bus.

https://lore.kernel.org/linux-pci/20230914203146.GA77870@bhelgaas/

Nobody is very motivated to fix these, I guess ;)  I sort of hate to
just throw in a cast to shut up the warning because it doesn't really
solve the problem.

> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index 66a8f73296fc..27f0f79810a1 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> > >  	phys_addr_t addr;
> > >  
> > >  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> > > -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > +	addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> > >  	msg->address_hi = 0;
> > >  	msg->address_lo = lower_32_bits(addr);
> > >  
> > > @@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
> > >  	u32 val;
> > >  	phys_addr_t msg_addr;
> > >  
> > > -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > > +	msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
> > >  	val = lower_32_bits(msg_addr);
> > >  	writel(val, port->base + PCIE_IMSI_ADDR);
