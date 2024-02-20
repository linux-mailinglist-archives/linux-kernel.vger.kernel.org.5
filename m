Return-Path: <linux-kernel+bounces-73191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B225A85BF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E500B1C234C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233EB6D1D3;
	Tue, 20 Feb 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lC5Dvzlw"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2782C6AA;
	Tue, 20 Feb 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440433; cv=none; b=JoKP3LaBx4KThUbOwxiGobiBST5IziBBC8NzyWrK12lqUBXdbhkLryJgIboifFX17FaoqufLsljbVPMddiMatTUGtHfVrUNa7gYTHPVOl84PKdFzLvK2QdqA2dQUykAoYnwbCUEVln6KSqJ/sUvE5nVKMRVvVoMw1uZY+6wxgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440433; c=relaxed/simple;
	bh=pCdDjSGJ9J9PvY8Zh4xJ8tmH3oTP9TSlRh2eeBJpLzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyF7Tevcs96iJpKDXLcyeptiFhI9Mbp+MDfnfOC/fPMxSI2ICWVt7bCnmMM/CSh/OpHA2ZhIWeJO72xBKVOgSRx8cZ/90XTyFI+YxJ59veRItS4qToJw8tZPhBdFyhZaYuir8ugQsY0hKEq2K7tDuA8VqjQMRadUS2UclT+9YUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lC5Dvzlw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1zdNjHcqPugIf4Zw2EB6aLcTZtqonnwTaHUPJU0bi/w=; b=lC5DvzlwuEcreFh/z1w63BLTFZ
	tHnhJ9TvLr6D228PLFJn763Pc604Vq4m/SX4kMiBoZHnGGPC/hH3ypfuxx0CKLDUoNQwQ4DPlx3Vd
	EJs3qZ3eBvBB3kbeiqhE0tlQ7uT5TEIGlEp46ctcZO3LbGSe7E9VaE3vBKiftm0oC5Eg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcROs-008I5V-Qt; Tue, 20 Feb 2024 15:47:14 +0100
Date: Tue, 20 Feb 2024 15:47:14 +0100
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
Subject: Re: [PATCH net-next v4 4/9] net: ethernet: ixgbe: Convert EEE to use
 linkmodes
Message-ID: <610e70a3-eb3e-4a64-87c8-d03a17332dcb@lunn.ch>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-4-71f13b7c3e60@lunn.ch>
 <20240220120643.GZ40273@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220120643.GZ40273@kernel.org>

On Tue, Feb 20, 2024 at 12:06:43PM +0000, Simon Horman wrote:
> On Sun, Feb 18, 2024 at 11:07:01AM -0600, Andrew Lunn wrote:
> > Convert the tables to make use of ETHTOOL link mode bits, rather than
> > the old u32 SUPPORTED speeds. Make use of the linkmode helps to set
> > bits and compare linkmodes. As a result, the _u32 members of keee are
> > no longer used, a step towards removing them.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 48 ++++++++++++------------
> >  1 file changed, 25 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> 
> ...
> 
> > @@ -3436,28 +3437,29 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
> >  	if (rc)
> >  		return rc;
> >  
> > -	edata->lp_advertised_u32 = 0;
> >  	for (i = 0; i < ARRAY_SIZE(ixgbe_lp_map); ++i) {
> >  		if (info[0] & ixgbe_lp_map[i].lp_advertised)
> > -			edata->lp_advertised_u32 |= ixgbe_lp_map[i].mac_speed;
> > +			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> > +					 edata->lp_advertised);
> >  	}
> >  
> > -	edata->supported_u32 = 0;
> >  	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
> >  		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
> > -			edata->supported_u32 |= ixgbe_ls_map[i].supported;
> > +			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> > +					 edata->lp_advertised);
> 
> Hi Andrew,
> 
> should this be edata->supported rather than edata->lp_advertised?

Correct :-(

	Andrew

