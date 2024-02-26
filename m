Return-Path: <linux-kernel+bounces-82174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462F868044
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1755B23F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BE1E866;
	Mon, 26 Feb 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U/G3rUNl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD112EBF6;
	Mon, 26 Feb 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973965; cv=none; b=rCNctQnEhEzR0kNZ7M9raPfEPq4OBtaCY6PAf20/wFg0MfTcFNTHgUKUeNG37+J/np4Xf3dhXmqGXDac76TfbV+RWv3LWNf7/JOtSyUbtoZKR1NzH0pLGxilaKkqdAJ7LxJiEnAEVxElU6OWt7hqLhSzEC/ICsQwcLxqf459Dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973965; c=relaxed/simple;
	bh=qlAmNKHGR7vwy7bKxbfNjwMCIzUTjBUjhpOzPJgm7ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHvzVHVCcdlCHkW/aKuYwRCVroaiAtf/c6mK1l/oaRDC3Jp+Ib//zKWohHucLoLdfEgOKOo+n1rGTkIduskqlBy/xu4Do3YpPYqSsdLO7ljbpjMPf82V9+OtUKwm7wz3e/KbPuGVx4EGqHgoR/SEcXg4rlYS9mEIHd1hfsyLheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U/G3rUNl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QGUT/3moj2OhsxsxICwpbLQML/W18VFE18o89MKHXvw=; b=U/G3rUNlaV4fF493SyQmav3vC2
	ARJZzTqt9VPnTCGOzK5BBRZUHEgyd4s2/64ilvkL3ArZJDIM2EbAdRZnbJpsyHiTF3ckTMXDI7KlA
	bbHcwR5lcIcDC1MolngdfESjvbVkKsDtqNtNA2omCqE8KB70lYLZF9c6DxP9uWZZFtZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1regCG-008kvg-CP; Mon, 26 Feb 2024 19:59:28 +0100
Date: Mon, 26 Feb 2024 19:59:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <fe071598-64eb-4dd2-8926-d4d0954e7e7e@lunn.ch>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
 <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
 <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
 <ZdzQG6t2slqEyH0m@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdzQG6t2slqEyH0m@shell.armlinux.org.uk>

On Mon, Feb 26, 2024 at 05:53:31PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 26, 2024 at 09:50:02AM -0800, Florian Fainelli wrote:
> > This is the source of the concern, we don't know which MAC drivers we might
> > end-up breaking by calling adjust_link(link == 1) twice in a row, hopefully
> > none, because they should be well written to only update the parameters that
> > need updating, but who knows?
> 
> Just quickly... There are some (I went through a bunch.) They don't
> support EEE. I haven't been through all though, so there could be
> some which support EEE and where adjust_link() with phydev->link=true
> twice in a row could result in badness.

So i think we all agree the MAC needs to see a down/up, even if the
link itself never went down. Anything else is too risky and will
probably break something somewhere.

	 Andrew


