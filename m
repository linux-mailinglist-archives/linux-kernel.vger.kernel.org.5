Return-Path: <linux-kernel+bounces-13246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A38201F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E8282BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFC14A94;
	Fri, 29 Dec 2023 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BfaaFV8s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4914A87;
	Fri, 29 Dec 2023 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cMOZBS1WdL8uj8Ggp/P2n0JMmGvQkfKOgui0I7cGEWw=; b=BfaaFV8sXwsHVLWMsU5Im3F2xz
	aKX0bDP4/bThvxouXffBZAPPvgNj5TNy8VMNLbaimO/ayRJ9zz6Mm4GayiwZlvY+TLJ22gP4GjX8u
	9OiHRg42Bda0Zeqhl29KfhqR43DQ3hXFKen8JK3RhIFQY4YayvxRAXcpZsTWPohA2sgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rJKdw-003vKD-5J; Fri, 29 Dec 2023 22:43:48 +0100
Date: Fri, 29 Dec 2023 22:43:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
Message-ID: <dc66ab0e-1c63-4a57-98a5-a440d97d13f7@lunn.ch>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
 <CAMty3ZDnAFR9a1BM89mx3bmrQzGC7nvazt42_v4JF_QpwPkS4w@mail.gmail.com>
 <20231229152519.2jxrwaeltp4pxlms@skbuf>
 <CAMty3ZAOM5+EMw9sLVOq-=CH_sP=1TLAGEMF9LYOZ4aFbNUtsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZAOM5+EMw9sLVOq-=CH_sP=1TLAGEMF9LYOZ4aFbNUtsg@mail.gmail.com>

> > If you are truly using MII, then you should remove the RGMII delay
> > properties, and since you are using a 6.1 kernel - hence after kernel
> > commit 5d645df99ac6 ("net: dsa: sja1105: determine PHY/MAC role from PHY
> > interface type") - you should be using phy-mode = "rev-mii" to put this
> > port in MII PHY ("RevMII") mode - to interoperate with the FEC in MII
> > MAC mode.
> 
> Okay, I will remove RGMII delay. is phy-mode = "rev-mii" applicable to
> all ports or only for fec port4?

phy-mode indicates what the PHY should be doing. In this case, the
switch is taking the place of the PHY and so the switch MAC needs to
be revMII so that it acts like a PHY. For the other ports of the
switch, you have a real PHY connected, so you want MII.

	Andrew

