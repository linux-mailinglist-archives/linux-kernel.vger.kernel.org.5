Return-Path: <linux-kernel+bounces-52442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B3084983E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C7A1F21C63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532318037;
	Mon,  5 Feb 2024 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cyhf8SbM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BC175A5;
	Mon,  5 Feb 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130701; cv=none; b=fD5C1xzeNSAK617QsvJ16hrDtpqAl3gYvvgN/qnfUEr1mSgrkIGF8uRCaxxuh649WLwsYaPApWGVGEmJzsbWvsDMR206eq+IwvH5mojFCX9Mf4bp1p8Yw14Kutmvd6vrMdhSksiYlpmLKWCty7YXlaUmBAZqtTwsbPbqH4/ZhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130701; c=relaxed/simple;
	bh=mEaFTy6bJYF+ZKoSXTVJN7JbVsL2cMY4NnXCamRHkn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epp7vMboVh6QOnRG7F7k82JF7e6Bifz1jFO3KLx87p+PJnxUxCRKygByK+Mb0cB9+joVc0RVdnW6FFJGSDieMliqc2g3sP0xc2W2rPL57N6iHX33ADat6mCmdVEtDTgHSj7vy/j4klwVqXZ1H+xZoCPnCzJ1GOReJXISQM3Ekok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cyhf8SbM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707130699; x=1738666699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEaFTy6bJYF+ZKoSXTVJN7JbVsL2cMY4NnXCamRHkn8=;
  b=Cyhf8SbMjXSp3uOvtRzlAYt0pH/Tx+m/JPWrIImN1V0kymPhniKl+2Fn
   AoygO/CFf5rUtcu7hdP9DMFFYUhHCKLBc+VLv1kQxKfGQjjbeHWNUXpk0
   lGgBiL9CL6BWWHx0iEibh+Ye70OyYpdItUc1rF3q+kmeOngEaxz+q5q8e
   QmT9mPGvu3wIs1HK+N6hCL7GgzyBcNCH7dn0ivPDeEtmLIG2oISMw9stS
   ZExtdS3Dj7+vKZA17GhW/xYpwQbhNr1EMPgbacNDiOC/QIEs7lRWozr3/
   qSXwF49mO4oKC9SstrSaQsie0GWD3WEL5LDJIqSxcjR2HIlTk8bSaCikF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="412773"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="412773"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="688849"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 02:58:16 -0800
Date: Mon, 5 Feb 2024 11:58:05 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] lan966x: Fix crash when adding interface under a lag
Message-ID: <ZcC/PZZXpA4ovZY6@mev-dev>
References: <20240205080756.2134143-1-horatiu.vultur@microchip.com>
 <ZcCf4IGJHhY8uQQd@mev-dev>
 <20240205094434.bwhjufxtrnlkwbrf@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205094434.bwhjufxtrnlkwbrf@DEN-DL-M31836.microchip.com>

On Mon, Feb 05, 2024 at 10:44:34AM +0100, Horatiu Vultur wrote:
> The 02/05/2024 09:44, Michal Swiatkowski wrote:
> 
> Hi Michal,
> 
> > 
> > On Mon, Feb 05, 2024 at 09:07:56AM +0100, Horatiu Vultur wrote:
> > > There is a crash when adding one of the lan966x interfaces under a lag
> > > interface. The issue can be reproduced like this:
> > > ip link add name bond0 type bond miimon 100 mode balance-xor
> > > ip link set dev eth0 master bond0
> > >
> > > The reason is because when adding a interface under the lag it would go
> > > through all the ports and try to figure out which other ports are under
> > > that lag interface. And the issue is that lan966x can have ports that are
> > > NULL pointer as they are not probed. So then iterating over these ports
> > > it would just crash as they are NULL pointers.
> > > The fix consists in actually checking for NULL pointers before accessing
> > > something from the ports. Like we do in other places.
> > >
> > > Fixes: cabc9d49333d ("net: lan966x: Add lag support for lan966x")
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  drivers/net/ethernet/microchip/lan966x/lan966x_lag.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > > index 41fa2523d91d3..89a2c3176f1da 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c
> > > @@ -37,19 +37,24 @@ static void lan966x_lag_set_aggr_pgids(struct lan966x *lan966x)
> > >
> > >       /* Now, set PGIDs for each active LAG */
> > >       for (lag = 0; lag < lan966x->num_phys_ports; ++lag) {
> > > -             struct net_device *bond = lan966x->ports[lag]->bond;
> > > +             struct lan966x_port *port = lan966x->ports[lag];
> > >               int num_active_ports = 0;
> > > +             struct net_device *bond;
> > >               unsigned long bond_mask;
> > >               u8 aggr_idx[16];
> > >
> > > -             if (!bond || (visited & BIT(lag)))
> > > +             if (!port || !port->bond || (visited & BIT(lag)))
> > >                       continue;
> > >
> > > +             bond = lan966x->ports[lag]->bond;
> > Why not bond = port->bond?
> 
> That is also correct and more clear.
> I think I just copy the line that I have removed and put it here. As it
> has the same effect.
> I can update this in the next version.
> 

Great, thanks, fell free to add my reviewed-by tag in next version.

Michal

> > 
> > >               bond_mask = lan966x_lag_get_mask(lan966x, bond);
> > >
> > >               for_each_set_bit(p, &bond_mask, lan966x->num_phys_ports) {
> > >                       struct lan966x_port *port = lan966x->ports[p];
> > >
> > > +                     if (!port)
> > > +                             continue;
> > > +
> > >                       lan_wr(ANA_PGID_PGID_SET(bond_mask),
> > >                              lan966x, ANA_PGID(p));
> > >                       if (port->lag_tx_active)
> > > --
> > > 2.34.1
> > >
> > Only nit, otherwise:
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> > Thanks,
> > Michal
> 
> -- 
> /Horatiu

