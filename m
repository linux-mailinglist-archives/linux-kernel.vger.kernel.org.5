Return-Path: <linux-kernel+bounces-24804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F7D82C2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AA1C21D24
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5173164;
	Fri, 12 Jan 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KOsCe2Ix"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313373178;
	Fri, 12 Jan 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=85qADMULPEZDkA2EsspL4/DXh5uWHSumVah5xCfPd2c=; b=KOsCe2IxmDGDyoQUwKb0peqW9f
	kaGwxaLExgF6q2FNPLMh6Nkz8r3GYtx5n8L+6cNdYF23OTcBQGHASobbH3TAl0Gk3Ng/eAtyhyzyz
	rEHJS9UHfOXg3SWSOTmXt7wWw0SuHWEWBZc/pFqqlmimPtCer+21e2e5dmH1goS93QyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rOJW2-0055MK-GA; Fri, 12 Jan 2024 16:32:14 +0100
Date: Fri, 12 Jan 2024 16:32:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Fix possible NULL pointer dereference
 issues caused by phy_attached_info_irq
Message-ID: <627c9558-04df-43a6-b6e4-a13f24a8bc1d@lunn.ch>
References: <20240112095724.154197-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112095724.154197-1-chentao@kylinos.cn>

On Fri, Jan 12, 2024 at 05:57:24PM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Fixes: e27f178793de ("net: phy: Added IRQ print to phylink_bringup_phy()")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/net/phy/phy_device.c | 3 +++
>  drivers/net/phy/phylink.c    | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3611ea64875e..10fa99d957c0 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1299,6 +1299,9 @@ void phy_attached_print(struct phy_device *phydev, const char *fmt, ...)
>  	const char *unbound = phydev->drv ? "" : "[unbound] ";
>  	char *irq_str = phy_attached_info_irq(phydev);
>  
> +	if (!irq_str)
> +		return;
> +
>  	if (!fmt) {
>  		phydev_info(phydev, ATTACHED_FMT "\n", unbound,
>  			    phydev_name(phydev), irq_str);

This part looks O.K.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index ed0b4ccaa6a6..db0a545c9468 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1884,6 +1884,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	phy->phy_link_change = phylink_phy_change;
>  
>  	irq_str = phy_attached_info_irq(phy);
> +	if (!irq_str)
> +		return -ENOMEM;

Here, i would just skip the print and continue with the reset of the
function. The print is just useful information, its not a big problem
if its not printed. However, if this function does not complete, the
network interface is likely to be dead.

	Andrew

