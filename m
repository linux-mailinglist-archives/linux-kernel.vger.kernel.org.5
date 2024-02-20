Return-Path: <linux-kernel+bounces-73187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDE85BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7321C23247
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9F6F51A;
	Tue, 20 Feb 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xlZXnOWK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C566BB4A;
	Tue, 20 Feb 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440019; cv=none; b=r4rutRXLtAp8PWsOlbAroeDtXa27DP5WNouMpeVmdk+zAvRV56CxlXjCfDCma8N+G6nzDFBTuyWI7298olrcLvyiBEAgjG/JrtHBCa4H5wgXOLilF6IPalwPE3+//I/NCIulkJDGAC1Cpy2flpnuvJ6Nltt7UVO/6sT9d9ma1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440019; c=relaxed/simple;
	bh=YXroGioVcbZWvHCBYKMA6eeWcKlnKNnCpmo6XOAzkpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM8f82XhSPyWnrtlqhPW8J7uqNrpjZ0X9qqRRo1owfY98yFqJ9Ih6htvKrjzsmXnJu17ju5cJa8n7mM6d8q/CQCjDkgjpdNCtv/OelZ3SxCVLBYrj4kOvhaJ9AUxxtIiwdTMB31VumweXVoS9PfRwPQ10ddDFFcz35FI/MGcGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xlZXnOWK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iiizQyI51jITzT4Y9FB1PoUvVXRX7qZCnb+Qa6MZ8EY=; b=xlZXnOWKTx17XVtDLHKy+gjOwG
	Xs6SM6iprYji/Cub/GfOPiYnvj4KZWrn8Gf0ZaKj/tfx23rlWXfn3ujsYDyqv0zP8WOWdy1DNJNfb
	tbj5DvNWGo4cqpujMg6wlIZtyBlSuzk1hQasZqN4qCZNps8nLyjxTtMSZjxLnCqUJ+4U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcRIA-008I2R-TM; Tue, 20 Feb 2024 15:40:18 +0100
Date: Tue, 20 Feb 2024 15:40:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 2/9] net: usb: ax88179_178a: Use linkmode
 helpers for EEE
Message-ID: <a8b728c0-f191-47d5-b61d-f2c7a9617eeb@lunn.ch>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-2-71f13b7c3e60@lunn.ch>
 <20240220123924.GA40273@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220123924.GA40273@kernel.org>

On Tue, Feb 20, 2024 at 12:39:24PM +0000, Simon Horman wrote:
> On Sun, Feb 18, 2024 at 11:06:59AM -0600, Andrew Lunn wrote:
> > Make use of the existing linkmode helpers for converting PHY EEE
> > register values into links modes, now that ethtool_keee uses link
> > modes, rather than u32 values.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/usb/ax88179_178a.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> > index d6168eaa286f..d4bf9865d87b 100644
> > --- a/drivers/net/usb/ax88179_178a.c
> > +++ b/drivers/net/usb/ax88179_178a.c
> > @@ -676,21 +676,21 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
> >  					    MDIO_MMD_PCS);
> >  	if (val < 0)
> >  		return val;
> > -	data->supported_u32 = mmd_eee_cap_to_ethtool_sup_t(val);
> > +	mii_eee_cap1_mod_linkmode_t(data->supported, val);
> >  
> >  	/* Get advertisement EEE */
> >  	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_ADV,
> >  					    MDIO_MMD_AN);
> >  	if (val < 0)
> >  		return val;
> > -	data->advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
> > +	mii_eee_cap1_mod_linkmode_t(data->advertised, val);
> >  
> >  	/* Get LP advertisement EEE */
> >  	val = ax88179_phy_read_mmd_indirect(dev, MDIO_AN_EEE_LPABLE,
> >  					    MDIO_MMD_AN);
> >  	if (val < 0)
> >  		return val;
> > -	data->lp_advertised_u32 = mmd_eee_adv_to_ethtool_adv_t(val);
> > +	mii_eee_cap1_mod_linkmode_t(data->lp_advertised, val);
> >  
> >  	return 0;
> >  }
> > @@ -698,7 +698,7 @@ ax88179_ethtool_get_eee(struct usbnet *dev, struct ethtool_keee *data)
> >  static int
> >  ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
> >  {
> > -	u16 tmp16 = ethtool_adv_to_mmd_eee_adv_t(data->advertised_u32);
> > +	u16 tmp16 = linkmode_to_mii_eee_cap1_t(data->advertised);
> >  
> >  	return ax88179_phy_write_mmd_indirect(dev, MDIO_AN_EEE_ADV,
> >  					      MDIO_MMD_AN, tmp16);
> > @@ -1663,7 +1663,6 @@ static int ax88179_reset(struct usbnet *dev)
> >  	ax88179_disable_eee(dev);
> >  
> >  	ax88179_ethtool_get_eee(dev, &eee_data);
> > -	eee_data.advertised_u32 = 0;
> 
> Hi Andrew,
> 
> could you clarify why advertised no longer needs to be cleared?

Ah, that is me being too delete happy. When the ethtool core calls
into the driver for eee_get(), it first zeros the structure passed
in. Some drivers than again zeroed members, so i deleted them.

However, this is not a eee_get() call, eee_data is actually a stack
variable. ax88179_ethtool_get_eee() has set it, so it is at least not
random junk. But the intention here is to not advertise any EEE link
modes until the user calls set_eee(). So this zero'ing is needed.

Good catch, thanks.

    Andrew

---
pw-bot: cr

