Return-Path: <linux-kernel+bounces-15380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E6822B34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81197284F05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB318B0D;
	Wed,  3 Jan 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GyMoxmXb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AC18AFA;
	Wed,  3 Jan 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eS1bFHrnk2KWQBXWffBjoZi4RGwbnIYkXxhSCL0bEkA=; b=GyMoxmXbyozBK6/NcYSLE8N81y
	Xg/b9GHTx6JkxUeAnlSxR9SsDNW5S+gw+7I/gv0mFCz6gGFMZ+/h/UXC25yEk0RCuXNntZnjuqFyS
	0SxwmWhwVlO6/1hwcBImW+DtT0acvOKK23AW7FBzoQN+dK0ml+VNueDMbLXIq8yCB3zgQq0FwAwy9
	XtvAAT2G+AOGsnSYPcKuG1eKFIDtUUWkXEDgZXIJcT4fSuLSnZLYIUMQOCtjDULdAPNUSPMuMwgBV
	a+NarzvSxBfTT5zOv9HjKp+JUTQDYYadmzctC+DHL2vUdr4+U+9gmHVcwDmIz0OtxGd1LORlBmm4T
	ZeJrxemg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37916)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKyNq-0007Kl-20;
	Wed, 03 Jan 2024 10:21:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKyNs-0006HI-NO; Wed, 03 Jan 2024 10:22:00 +0000
Date: Wed, 3 Jan 2024 10:22:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: get/put device node during
 (un)registration
Message-ID: <ZZU1SJlKpeU38c9I@shell.armlinux.org.uk>
References: <20231220045228.27079-2-luizluca@gmail.com>
 <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
 <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 06:57:35PM -0300, Luiz Angelo Daros de Luca wrote:
> > On Wed, Dec 20, 2023 at 01:52:29AM -0300, Luiz Angelo Daros de Luca wrote:
> > > The __of_mdiobus_register() function was storing the device node in
> > > dev.of_node without increasing its reference count. It implicitly relied
> > > on the caller to maintain the allocated node until the mdiobus was
> > > unregistered.
> > >
> > > Now, __of_mdiobus_register() will acquire the node before assigning it,
> > > and of_mdiobus_unregister_callback() will be called at the end of
> > > mdio_unregister().
> > >
> > > Drivers can now release the node immediately after MDIO registration.
> > > Some of them are already doing that even before this patch.
> > >
> > > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> >
> > I don't like this, certainly not the use of a method prefixed by a
> > double-underscore, and neither the conditional nature of "putting"
> > this. That alone seems to point to there being more issues.
> 
> Thanks Russel.

Hi Lewis,

> At least one driver (bcm_sf2_mdio_register) is writing directly to the
> mii_bus->dev.of_node and not using of_mdiobus_register(). We should
> not put a node in the MDIO bus if the bus didn't get it before. That's
> the reason for the conditional putting the node.

I agree with the idea that a node placed in a bus needs to have it's
reference count increased before hand, _unless_ the reference is being
passed from the code registering.

What I don't agree with is the conditional putting of the node. What
I think should have happened is a review of all the code, and either
a justification needed to be put forward (and considered *before*
this patch was merged) about why to do this conditionally, _or_ all
the places where the refcounting is not correct get fixed at the
same time.

Adding this conditional mechanism adds more complexity which makes
the situation more difficult to analyse and fix later.

> I wasn't sure about the names. What would be an appropriate name? The
> same without the prefix? In order to put the node only when the bus
> was registered by __of_mdiobus_register, I opted for a callback but it
> might be a better approach.

Normally, the callback is just named "release".

> > I also notice that netdev have applied this without *any* review from
> > phylib maintainers. Grr.
> 
> Some reviews are required. Should we revert it?

Clearly reviews are needed, even more so as there is indeed an issue
with this patch. Looking at __of_mdiobus_register(), let's assume
__mdiobus_register() succeeds. While scanning the PHYs, we hit an
error that calls us to head to the unregister label.

This calls mdiobus_unregister(), which calls your
bus->__unregister_callback function, which puts the node. When that
returns, we continue past the "put_node" label, which does *another*
of_node_put() on the same node.

So, this patch has traded a lack-of-get for a double-put bug. Given
that it wasn't reviewed before being applied, and I think we can do
much better, I am definitely in the mindset that it should be reverted.

> > Indeed there are more issues with the refcounting here. If one looks at
> > drivers/net/phy/mdio_bus.c::of_mdiobus_link_mdiodev(), we find this:
> >
> >                 if (addr == mdiodev->addr) {
> >                         device_set_node(dev, of_fwnode_handle(child));
> >                         /* The refcount on "child" is passed to the mdio
> >                          * device. Do _not_ use of_node_put(child) here.
> >                          */
> >                         return;
> >
> > but there is nowhere that this refcount is dropped.
> 
> The same file where we have the get should also contain the put,
> ideally in a reverse function like register/unregister.

Not necessarily true. There are cases where we need the node to hang
around until the device is actually released, so putting the node in
the release callback for the device tends to be the best place. The
rule for all devices of that class then becomes that the node must be
"got" before assigning them to the device which then becomes easy to
audit.

> I'm trying to address an issue I ran into while modifying a DSA
> driver. We have drivers putting the node passed to of_mdiobus_register
> just after it returns. In my option, it feels more natural and this
> patch fixes that scenario.

I agree with that approach, but as you rightly point out, we need MDIO
to behave correctly, and I don't think that patching just one bit of
MDIO to fix this mess is the right approach.

Jakub: please revert, if that's still possible.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

