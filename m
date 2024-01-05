Return-Path: <linux-kernel+bounces-17676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FB82510E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B6CB21713
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974424B3D;
	Fri,  5 Jan 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iVMxKve7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6224B54;
	Fri,  5 Jan 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6cx3AkYeOtWVTGHKX5Q/998ueJhhIC2qCjF0VHKq/4A=; b=iVMxKve7K1xzBcy7We6EzxyoZs
	1AIders3rvB0HG8Nw86dNGjQynKVRTUTQCfTtJeDFgpQbrRQQTRUsW+WTsOX5H/6BQCjVHP4Mp0lZ
	WtuX5jYOkIIetzcMy54+FhuJlPnd4800S83Cv2VGAHo7NFfUkE+BdneBSLbBamGdtdk2G4Bl8QvCu
	76U2lsHSPChYfGP8u8uAOMt2s/5yTtxHlZlV2cAFAj0CkZWvb43er5rhhz8QY92rC5YWQcg4QfbK5
	g9lF9M+ZDQCVRbOvskNwizBC9NSDxA5DgaSM87XQa1uaWLZWFzuOB7OQY4J1lmwbT2BbiNDs9fSUn
	EBxHnYxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49732)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rLgjZ-0000mS-1i;
	Fri, 05 Jan 2024 09:43:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rLgja-0008VX-9Y; Fri, 05 Jan 2024 09:43:22 +0000
Date: Fri, 5 Jan 2024 09:43:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yuiko.oshino@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Message-ID: <ZZfPOky2p/ZJMKCQ@shell.armlinux.org.uk>
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 05, 2024 at 10:52:42AM +0200, Claudiu wrote:
> The order of PHY-related operations in ravb_open() is as follows:
> ravb_open() ->
>   ravb_phy_start() ->
>     ravb_phy_init() ->
>       of_phy_connect() ->
>         phy_connect_direct() ->
> 	  phy_attach_direct() ->
> 	    phy_init_hw() ->
> 	      phydev->drv->soft_reset()
> 	      phydev->drv->config_init()
> 	      phydev->drv->config_intr()
> 	    phy_resume()
> 	      kszphy_resume()
> 
> The order of PHY-related operations in ravb_close is as follows:
> ravb_close() ->
>   phy_stop() ->
>     phy_suspend() ->
>       kszphy_suspend() ->
>         genphy_suspend()
> 	  // set BMCR_PDOWN bit in MII_BMCR

Andrew,

This looks wrong to me - shouldn't we be resuming the PHY before
attempting to configure it?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

