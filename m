Return-Path: <linux-kernel+bounces-11584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0281E885
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B5C28147A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD34F883;
	Tue, 26 Dec 2023 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5gGxoLAA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F74F885;
	Tue, 26 Dec 2023 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PvHe/a/YIlDPbdV9IQijzEnnceejPuf4FbyuqmV0tac=; b=5gGxoLAACjK/8qVzAl1USxjjLg
	lmSrQP35WDsJBenObM+sC/o8Ss7o+qutgAC/EkuD/sQ+dmDSXlRiccUjTItTyUgpgT/Buu80JaWmT
	V7eCAqlgSVd/QnlNxO+56lPPSGIHRZtJaMXOUWoDHse8VxZM5/5mx76DuL6MBAdE2aMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rIAcu-003mcG-Hk; Tue, 26 Dec 2023 17:49:56 +0100
Date: Tue, 26 Dec 2023 17:49:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
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
Message-ID: <5ec0c324-b07a-4001-b495-f34bfdd8ffe0@lunn.ch>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226153055.4yihsmu6kiak6hkf@skbuf>

> Ok. The WARN_ON() is saying that the DSA user port's phy_start() found
> the attached PHY already in the RUNNING state. As if there was already
> someone else driving it.
> 
> That "someone else" seems to be the FEC driver from the log above, which
> for some reason has connected to the DP83849I by itself, and phylink/phylib
> hasn't denied the second attempt to connect to the same PHY for some
> reason.
> 
> If you look at fec_enet_mii_probe(), I see it has 2 code paths, one for
> when fep->phy_node (defined as the "phy-handle" reference) is non-NULL,
> and one for when it is NULL. What you're missing is a fixed-link
> specifier in the device tree for FEC, otherwise it tries to call
> phy_connect() to some random MDIO address on the bus and that breaks
> things in some way which I don't understand.

At has an open coded phy_find_first(), or something similar. The FEC
is a bit of a mess in this respect, but it is hard to fix because of
backwards compatibility.

> The code which should have prevented this from happening is in
> phy_attach_direct():
> 
> 	if (phydev->attached_dev) {
> 		dev_err(&dev->dev, "PHY already attached\n");
> 		err = -EBUSY;
> 		goto error;
> 	}

Yes, that is odd.

     Andrew

