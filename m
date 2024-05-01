Return-Path: <linux-kernel+bounces-165464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9F18B8CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E260B20CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33A12F589;
	Wed,  1 May 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FEf2ohJw"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FC12F595;
	Wed,  1 May 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577005; cv=none; b=TR+n3gr13gY5L2Qb/BzEiI9dm+YNMONy/Rp4fLM9PYTf8zGKTQsDG0FPaGUJbQeYhivK3XBUTGgOArVpVQDFDptiPn6dCPHdxIVcd0/s8sN9lYaZaEM/jpf0He3wEWH7Bcsk7IygKPFyZsLJqwtfUUwC2aMDf9aw01PCeddbySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577005; c=relaxed/simple;
	bh=Wu4p3dA+4jNndGCJvdWgLlsMPzvrGK+CYRTQiaA9HlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHAcxhVd5FPvl4RdQAFeQY0TzDAJKC1rUYwZ/5n65Okbaj1k3Uu6srEgtCN9TP9hNIkuLBmW21uxp9iQ+bgJ1BmHBSeB4LotQOczTX+hg/kFjnFUGhzkwChoxOLpmHzrllHdELfotcjIQq7CKQKmyjmiA7c+afcV9cUnC904saM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FEf2ohJw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QZtc4ADsuFNoYEFTaxp6L+njnzX7pXdzg+EYMtUefqo=; b=FEf2ohJwKWmJjApy+pRB7qWNcL
	xvQoZk9HXAECcN0eOm1yRC04j+ZUnzyReFd10iFjXxEH3Gc8lO+9La8tg0Ms/8elH84/5WDQ01acn
	nMe70KXhqx3p7eZ4s9OBovy1fPwjCL9w+1O4iM75+zcxcY39SrEXi0AZO9zZ4Y9YT2n8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2Bne-00EQz3-Vz; Wed, 01 May 2024 17:23:14 +0200
Date: Wed, 1 May 2024 17:23:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <4fdf3a29-a380-4db7-b652-51214d5b15fb@lunn.ch>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <229b5a82-1086-40be-8ee5-16b7f3a03b30@lunn.ch>
 <ZjJddIUpXQqH/IA+@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJddIUpXQqH/IA+@shell.armlinux.org.uk>

> > It seems unlikely, but one possibility is:
> > 
> > static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
> >                                        int phyreg)
> > {
> >         struct net_device *ndev = bus->priv;
> >         struct stmmac_priv *priv;
> >         u32 addr;
> > 
> >         priv = netdev_priv(ndev);
> > 
> >         /* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
> >         if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
> >             phyaddr > MII_XGMAC_MAX_C22ADDR)
> >                 return -ENODEV;
> > 
> > Maybe if the interface is down, priv->synopsys_id has not been set
> > yet? Your devices are at address 8 and 10, so if priv->synopsys_id
> > where 0, this would give you the ENODEV.
> 
> Yes, I did look at that, but didn't read the DT snippet to realise
> that the addresses would be trapped by that. So, looking at where
> priv->synopsys_id is set... is in stmmac_hwif_init(), which is
> called from stmmac_hw_init(), which in turn is called from
> stmmac_dvr_probe(). This is the only path that leads here.
> 
> This all happens before the MDIO bus is registered, so the value of
> priv->synopsys_id should be set by the time the MDIO bus is registered.
> 
> So I'm unconvinced...

Me too. I just wanted to give an example of why it is important to
track down the source of the ENODEV.

      Andrew

