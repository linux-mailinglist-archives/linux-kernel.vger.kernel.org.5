Return-Path: <linux-kernel+bounces-110202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26476885B73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E91BB20D41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10986245;
	Thu, 21 Mar 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="npC8qt99"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14C85943;
	Thu, 21 Mar 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033847; cv=none; b=Amg/QdpNL1PLK59Q8QTPVcq/GPPwkGB1rhDpkAcw+GA3CYiDwyIkvQICOdNXkaKgQXMGS9h9tOYz6lTL/umWnIhm42/0zGx4dwx0XOxxEtS4sxwgYgzJl2wD8KjMQNNQa+Ke8Gg7o7TfmQ9MoM9SB53rVH3Frw0vizFeKdI6DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033847; c=relaxed/simple;
	bh=RkoLFzk55SGpOZNBX4VDnwxYh/VJho2CpIjimqHw2ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIm64WHiQ190EohULh82jqq4D3PrHkr3YYpNwzK/bVN3DI5YibNYznpwIIrRICyoLGhlVqt6z/KUXQfAmBqzou0AuZgG3RG7RrZn7FOc9PQcRrEjCw8CmeBCyU9/MgPvJ8yy0d+oE+1C7FusHss5x/fwnMkzf4JbjI/iXujVSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=npC8qt99; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sR33xaU30Um4snYfukRTLS6V0tyKk01NYkb+5Qnbg54=; b=npC8qt99MBMb2phQUvPqfD74lB
	s9kZI8Qoo/CEjCgaEAT+nPqnoZD6/gR4YTDMAKHbRaKhYeqBwzzT1OF8UCe7En7FBuWEViJ2YKURd
	u9SoR1le5h6/R7QG6DngmJf6KtTg7g4cmcmT30IArRs3w/5WDVUMAqYCNKTtLbZsM75Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnK3u-00Asws-Ds; Thu, 21 Mar 2024 16:10:34 +0100
Date: Thu, 21 Mar 2024 16:10:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Message-ID: <37af3d75-68dd-41ea-b97e-7ce020ebaa8c@lunn.ch>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
 <793649ff-990c-46f0-9132-bc6e95fcb94f@lunn.ch>
 <78211827-7ffb-41ac-bd78-a2641bca7c00@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78211827-7ffb-41ac-bd78-a2641bca7c00@solid-run.com>

On Thu, Mar 21, 2024 at 10:26:54AM +0000, Josua Mayer wrote:
> Am 20.03.24 um 19:57 schrieb Andrew Lunn:
> >> With separators ('!') we have:
> >> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio
> >> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external
> >> Truncated to MII_BUS_ID_SIZE:
> >> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi
> >> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi
> > This has been made worse by the DT maintainers wanting
> > ethernet-switch@4, not switch@4. And i guess config-space was also
> > something shorter in the past.
> >
> > I think your idea of cropping from the beginning, not the end, is in
> > general a good solution. However, is there any danger of
> >
> > cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external
> >
> > and
> >
> > cp1!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external
> Since these will appear as links in /sys/bus/mdio_bus/devices,
> this danger exists.
> If the prefix is too similar, we can run into duplicates also when
> cropping from the front.
> 
> So we could crop at the front and reduce likelihood of this situation,
> but (imo) should still print a warning since it is not working as intended.

The problem with a warning is, what do you tell people who ask how to
fix the warning? Hack your device tree to short the node names?

A warning is best done when there is something which can be done to
fix the problem. If it is not fixable, it is just noise.

> > Another option would be if the name needs to be truncated, use the
> > fallback as if there was no np:
> >
> >                 bus->name = "mv88e6xxx SMI";
> >                 snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
> >
> > That at least gives you unique names.
> This ensures a unique suffix within a branch of device-tree.
> It could still collide with same structure on a cp1 or cp2.

static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
                                   struct device_node *np,
                                   bool external)
{
        static int index;
        struct mv88e6xxx_mdio_bus *mdio_bus;
        struct mii_bus *bus;
        int err;

index is static, so it is simply a counter. So you should get the
names mv88e6xxx-0, mv88e6xxx-1, mv88e6xxx-2, mv88e6xxx-3...

	Andrew

