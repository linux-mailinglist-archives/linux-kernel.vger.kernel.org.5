Return-Path: <linux-kernel+bounces-31203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06205832A84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCC21F23F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53854737;
	Fri, 19 Jan 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b9x1nmu/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D353E18;
	Fri, 19 Jan 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670832; cv=none; b=GjsK+JkhxYsxaOnZNzkRvE6oA5obahbrvh4ToPgpzsei8HMmROxn33y76qYc/nS+m4LRYAn+9uwGHpVXEh+VmKK9+6WpGPeeCojTQP+X/a80qkROatFVAf0rSP6tXDq/ywshqQTVPNU7UkPUsW88aQnSYS5EgBySanVBvvhIGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670832; c=relaxed/simple;
	bh=C9ZWVjgbefXWApSOG+jjr14zfL+3/NQPQVKowbPJEwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIk9q9LlDSGEISDMyJFhiXDJJLXXmWrDRTt7QvUVYgVM201ReWXeME4dmqpMxbrLCklHrcRe50/Zl0oO/HlJpP7OHTned+heTpePpiHEaS85Lvd58R4pTb5TnXmUpIuv8oIdXeULNLycXLAU8lW4vkeE8LvBfnpVBV/jHdUv7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b9x1nmu/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oAX/SO+ppExiD053wec+IhSfmBvN9fcB5BYMFRjEhXg=; b=b9x1nmu/gvlmcdwUw+GMi3PwqM
	2whYk+wzShzv/BCcxll9cEDkBSbu5kfw1r4OovmJTsAxlJio1dU8sB2OovPUYPHm/IqZm3X/kbBq/
	ui8HCERJWRoD+vRoEtyfT00uVupxyxFJPww2dpeZ73kifGXfrWOKM1K99olA2og6x5SM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQoth-005Yn4-1a; Fri, 19 Jan 2024 14:27:01 +0100
Date: Fri, 19 Jan 2024 14:27:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 1/2] net: phy: phy_device Prevent nullptr
 exceptions on ISR
Message-ID: <fa47c497-a831-4e11-bbb9-c3901b174d0d@lunn.ch>
References: <20240119093503.6370-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119093503.6370-1-andre.werner@systec-electronic.com>

On Fri, Jan 19, 2024 at 10:32:25AM +0100, Andre Werner wrote:
> If phydev->irq is set unconditionally by MAC drivers, check
> for valid interrupt handler or fall back to polling mode to prevent
> nullptr exceptions.

Hi Andre

A few more process things...

Please don't post a new version within 24 hours. Reviews need time to
review, and you could miss comments made on older versions of the
patches.

For a multi part patch set, its normal to include a clover
letter. When using git format-patch add --cover-letter and than edit
patch 0000-*.patch to describe the big picture of what the patchset
does. The text will be used for the merge commit message.
 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
> v3:
> - No changes to v2. Just to complete the series.
> ---
>  drivers/net/phy/phy_device.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3611ea64875e..3986e103d25e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1413,6 +1413,11 @@ int phy_sfp_probe(struct phy_device *phydev,
>  }
>  EXPORT_SYMBOL(phy_sfp_probe);
>  
> +static bool phy_drv_supports_irq(struct phy_driver *phydrv)
> +{
> +	return phydrv->config_intr && phydrv->handle_interrupt;
> +}
> +
>  /**
>   * phy_attach_direct - attach a network device to a given PHY device pointer
>   * @dev: network device to attach
> @@ -1527,6 +1532,18 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	if (phydev->dev_flags & PHY_F_NO_IRQ)
>  		phydev->irq = PHY_POLL;
>  
> +	/*
> +	 * Some drivers may add IRQ numbers unconditionally to a phy device that does
> +	 * not implement an interrupt handler after phy_probe is already done.
> +	 * Reset to PHY_POLL to prevent nullptr exceptions in that case.
> +	 */
> +	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev)) {
> +		phydev_warn(phydev,
> +			    "No handler for IRQ=%d available. Falling back to polling mode\n",
> +			    phydev->irq);
> +		phydev->irq = PHY_POLL;
> +	}

Please drop the phydev_warn(). Interrupt handling has always been
optional, and we have always silently dropped back to polling if
interrupts are not supported.

The comment wording is also not great. The MAC driver is not supposed
to have any idea what the PHY driver is. It just uses the phylib API,
which is PHY driver independent. So the MAC driver cannot tell if the
PHY driver supports interrupts or not.

I don't think a comment is needed. The code is pretty readable as is.

    Andrew

---
pw-bot: cr

