Return-Path: <linux-kernel+bounces-94684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A26874367
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 023E8B20E80
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA61C686;
	Wed,  6 Mar 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SWTqGsj1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065ECA4E;
	Wed,  6 Mar 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766279; cv=none; b=I1ccN9WieVi5bHIvu3SbROcuHS8EaLc5PvJA41ma7XcnzxVUmrdkU3fTCStUk+8foGhE2B+TaCQzKaxFgNPGdvi6kjA0rW3jwDgWGmwb0BBHoNw+H+HgsV3GAVEixkVtBut2turBRnNvKkqmzSWPNISV0HmOogkoz5bA72MVHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766279; c=relaxed/simple;
	bh=0BkBoxjoUbL8I9dtSSBP//w6m324kaP3H030ANrh3d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O12Ze/jdOMFUECO6hITxd0/JQEHm+zLaU6Rne1br6L86s9XINLHvg+FmHPr1BaXVKCi0+saTSN/P44XSDECMfQ8H8KjI5wpSMykatgPDEr87Pjr53I62pcUuXhsD/zsz47DGVSdC9FFB9OfgxM2d2ZXVzkq3qVubb0yDJ6lwmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SWTqGsj1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tu+kkEy+3vhioMBzuND7fGdxFOSgZ74kUNWaXmcwZi0=; b=SWTqGsj17HGAsi2jz7pUwne5Rn
	vpi7Fce/yxQpCEkCfCEednlu5X6urS5nPzbn5GIqgkGjJcOW+lSpN2p/BeDUIZ1OW4Qy7NwBok6JL
	vmkO71up2W3KVX86Cw0ypk4mG1ziPUfHK11nccWbQG8ON5LegIJxuTrfqVwp2kqdbV3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri0Je-009XDq-Dw; Thu, 07 Mar 2024 00:04:50 +0100
Date: Thu, 7 Mar 2024 00:04:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Message-ID: <8de1d4e3-6d80-45a5-a638-48451d9b5c15@lunn.ch>
References: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>

On Wed, Mar 06, 2024 at 06:14:46PM +0100, Catalin Popescu wrote:
> Unlike other ethernet PHYs from TI, PHY dp83822x has WOL enabled
> at reset.

This is rather odd behaviour. Is this stated in the datasheet?

> @@ -572,11 +584,17 @@ static int dp83826_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	if (dp83822->wol_enabled)
> +		return 0;
>  	return dp8382x_disable_wol(phydev);
>  }
>  
>  static int dp8382x_config_init(struct phy_device *phydev)
>  {
> +	struct dp83822_private *dp83822 = phydev->priv;
> +
> +	if (dp83822->wol_enabled)
> +		return 0;
>  	return dp8382x_disable_wol(phydev);

Since it is rather odd behaviour, there might be some BIOSes which
disable WoL. So i would not rely on it being enabled by
default. Explicitly enable it.

    Andrew

---
pw-bot: cr

