Return-Path: <linux-kernel+bounces-133409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6289A355
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C2E280F70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD82171E40;
	Fri,  5 Apr 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KhL05J9E"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F01E494;
	Fri,  5 Apr 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337137; cv=none; b=LWxx3AOWABz0nPDfAE15mBe9yOk5lcUhY4utjtXgwklB8YGyvAyswheXw9zIERcb0ffxuHcRxuaZQB6sYuJtPIC/opyRTqCJXZcrpVWaa+oFiXGWnoCZt5vOVhPSbQk7VtBybadEMW1FV0Iz51FYm+jQiJGlfXuPwdTmNZKggx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337137; c=relaxed/simple;
	bh=EjEhvGpQHWkXm/d1oJBCSAtQ/Wz2K2eGahlUA2OWXXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeouaFgpE7aXF/oe7oG1b3JX+letn5ILALkXDVrpZNImcoShJbBCNUpJWHwCfDl3byORaINECczRq6/F3Is1YkfEbwtX/3uGV33/9UWzwKOpn5GEHvYZbNAffYeUVuqaRsFA8ALi2wNEx1y+0NM4VOdzcuEw2ko1MuIKtZdNCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KhL05J9E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+22rtd2z1pUzSX7rSsXM4c8F52aki0yNAAXAw/kE4Q=; b=KhL05J9EbjxxDRl08burLR9ZqO
	S8GLom2p7EfkNhooyqD2EE/eJYw12rlfAZSnOteTZICnrAARt6BsWIRpMqQ+IEM5BuE0u83ZyTcaZ
	EsvAidjK2mwADeDNIQTwvDVkiO3/ljXYJWkw16q7EPdzrbLrqegQqAaUmYLQ8KMw2mps=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsn6k-00CKAC-2h; Fri, 05 Apr 2024 19:12:06 +0200
Date: Fri, 5 Apr 2024 19:12:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <fb5a6f19-ae4c-443e-babb-cbbcf6ba5fc6@lunn.ch>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
 <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB87003ABBCA98F00F3EEA9AB09F032@LV8PR11MB8700.namprd11.prod.outlook.com>

On Fri, Apr 05, 2024 at 08:17:22AM +0000, Raju.Lakkaraju@microchip.com wrote:
> Hi Andrew,
> 
> Sorry for delayed response.
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, March 21, 2024 4:23 AM
> > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> > pabeni@redhat.com; edumazet@google.com; linux-kernel@vger.kernel.org;
> > Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
> > PHY does not
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > > +     if (netdev->phydev) {
> > > +             ret = phy_ethtool_set_wol(netdev->phydev, wol);
> > > +             if (ret != -EOPNOTSUPP && ret != 0)
> > > +                     return ret;
> > 
> > I'm not sure this condition is correct.
> > 
> > If there is an error, and the error is not EOPNOTSUPP, you want to report that
> > error. However, if the PHY can support the WoL configuration, it will return 0,
> > and this function should exit, WoL in the MAC is not needed. And doing WoL
> > in the PHY consumes less power since you can suspend the MAC.
> > 
> > So i think it should simply be:
> > 
> > > +             if (ret != -EOPNOTSUPP)
> > > +                     return ret;
> > 
> > Do you have a board with this MAC with a PHY which does have some WoL
> > support. Could you test PHY WoL is used when appropriate?
> 
> Yes. 
> We have external PHY (Max Linear GPY211C) attach to MAC of PCI11x1x (PCIe Ethernet chip) 
> If I don't register the Ethernet module in wakeup source, WOL is not working. Ethernet device power state shows as disable.

So i'm talking about the case where the PHY is doing the wakeup,
without help from the MAC. In that case, "Ethernet device power state
shows as disable." is sensible.

> i.e.
> /sys/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/0000:06:03.0/0000:09:00.0/power/wakeup   <--  disabled
> 
> PCI11x1x is PCIe bridge device between PCIe and Ethernet along with other peripherals (i.e. UART, SPI, I2C, USB and PCIe devices)
> 0000:09:00.0 - Ethernet device
> 0000:05:00.0 - PCIe Bridge Up link 

How does the PHY indicate wake up? It could be you can power off the
MAC, but you need to keep parts of the PCIe bridge up, in order the
wake up gets delivered?

> When I test the WOL_PHY option on setup (PCI11x1x MAC + GPY211C
> PHY), observe the following:

> 1. When enable WOL_PHY by using ethtool (i.e. ethtool -s enp9s0 wol
> p), GPY211 PHY configure the WOL. After resume from sleep, GPY211
> WOL configuration vanish. Observed that gpy_config_init( ) function
> reset. Is it expected behaviour ? In other mail thread, we discussed
> that Ethtool configuration should retain after resume from sleep.

The whole point of suspend/resume is that the configuration is
retained. So i would expect from the users perspective WoL is still
enabled.

As you point out, we might have a logic issue here, that on resume we
hit the PHY with a hardware reset. That could be clearing out WoL?  We
might need to cache the PHY WoL configuration in phydev, and on resume
re-apply it. WoL is complex so we need to be careful who is actually
managing it. But this seems like something which could be done in the
phylib core.

> 2. when WOL configure with ethtool, Either Link-down and Link-up on
> CLI, WOL configuration vanish. Is it expected behaviour ? Due to
> this, every time we have to configure WOL through Ethtool.

This is unexpected. I would expect WoL to remain configured until the
configuration is changed.

> Based on above information, We need to check for return < 0
> condition and return the error. Else enable the wakeup by calling
> "device_set_wakeup_enable( )" function.

Once it is clear how the PHY does the wakeup, we can look at
this. However, if the PHY can support the WoL, you should not be
configuring the MAC as well to do the same WoL, you should be putting
the MAC into a low power mode.

    Andrew

