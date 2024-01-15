Return-Path: <linux-kernel+bounces-25608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D182D374
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C6C28155C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4B1FCA;
	Mon, 15 Jan 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fDMXDdmo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0191842;
	Mon, 15 Jan 2024 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gSQcpz5a2KA1WVbsWMo1PtzyS08hgWrM79E7/t9KzpM=; b=fDMXDdmoA2Vt2xVK1N1NFXceLm
	01Gy+DsDk8UUwY6o8HeunPTZuL8bABCDc9r/tV8u0Jspr7Snb+NXY6FgIxscJt5s2OccosgzFXfw6
	4wFiGBAqFbMtRcLJVpPCYgv1HUEVHv00yAk//tu5FEpgHNyrCiOpnRKxUUsYCb2WsSv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPDub-005Cau-LK; Mon, 15 Jan 2024 04:45:21 +0100
Date: Mon, 15 Jan 2024 04:45:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Fix possible NULL pointer dereference
 issues caused by phy_attached_info_irq
Message-ID: <bd80fc69-d334-4b69-8ba3-3b2b86e1fd84@lunn.ch>
References: <20240112095724.154197-1-chentao@kylinos.cn>
 <627c9558-04df-43a6-b6e4-a13f24a8bc1d@lunn.ch>
 <b71c5e28-2dbe-48c8-ab92-e1dad9d6f2e4@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71c5e28-2dbe-48c8-ab92-e1dad9d6f2e4@kylinos.cn>

> > Here, i would just skip the print and continue with the reset of the
> > function. The print is just useful information, its not a big problem
> > if its not printed. However, if this function does not complete, the
> > network interface is likely to be dead.
> Thanks for the reminder.
> The second part doesn't look so perfect, can we just print an empty string
> when the irq_str is empty?
> 
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1886,7 +1886,7 @@ static int phylink_bringup_phy(struct phylink *pl,
> struct phy_device *phy,
>         irq_str = phy_attached_info_irq(phy);
>         phylink_info(pl,
>                      "PHY [%s] driver [%s] (irq=%s)\n",
> -                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
> +                    dev_name(&phy->mdio.dev), phy->drv->name, irq_str ?
> irq_str : "");
>         kfree(irq_str);

That is O.K, or skip the whole phylink_info().

     Andrew

