Return-Path: <linux-kernel+bounces-134602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49389B370
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6021F2121E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21E3C08D;
	Sun,  7 Apr 2024 17:53:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7043BBE0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512395; cv=none; b=lJljLkDPOF61r+SQLl3MGnmg5pObP/7jPSSJJ03wx9O4DqzYRdrLJ5UUXOP7vxCCqgkJMTpwrAZIa1eXMqw6/SoUfh4QN7lZduxH/Yp1W6OwHRwjkoCIrEW7t9eZY/b1nbkPFxM0jj3FjsLXvrkKRcKZUheQ9Vcm7Rq8r/IiZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512395; c=relaxed/simple;
	bh=m7xjJrsZsamBvH244i4AhQh7nkrbLwZAUnx45zvG9jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJXA1EFWn9ogzeW3tm2CFjpH++fFBxihp6qL9zC1tWIjkrkJ2Hx2FlxxIJhGtO8yHWl/Eaoze3/NBxtn8aXfs5BKGy+2DBjcCMn2Nat/SHGPNj6OrRASGCuXLCx968wfVlWroRpmY+UUqEWb49y/QGEK92+zmdn8dzMQMuOg9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWhS-0006UL-6v; Sun, 07 Apr 2024 19:53:02 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWhR-00AxlK-Q8; Sun, 07 Apr 2024 19:53:01 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rtWhR-001Gre-2I;
	Sun, 07 Apr 2024 19:53:01 +0200
Date: Sun, 7 Apr 2024 19:53:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: lan743x: Fixup EEE
Message-ID: <ZhLdfavmCRXO-XAH@pengutronix.de>
References: <20240406-lan78xx-eee-v1-0-2993b14b849c@lunn.ch>
 <20240406-lan78xx-eee-v1-2-2993b14b849c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406-lan78xx-eee-v1-2-2993b14b849c@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2024 at 03:16:00PM -0500, Andrew Lunn wrote:
> The enabling/disabling of EEE in the MAC should happen as a result of
> auto negotiation. So move the enable/disable into
> lan743x_phy_link_status_change() which gets called by phylib when
> there is a change in link status.
> 
> lan743x_ethtool_set_eee() now just programs the hardware with the LTI
> timer value, and passed everything else to phylib, so it can correctly
> setup the PHY.
> 
> lan743x_ethtool_get_eee() relies on phylib doing most of the work, the
> MAC driver just adds the LTI timer value.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Probably same as lan78xx - if something is wrong, it was before this
patch.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

