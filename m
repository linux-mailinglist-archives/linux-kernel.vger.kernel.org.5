Return-Path: <linux-kernel+bounces-11587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873B81E891
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379EC1C20F67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9BB4F898;
	Tue, 26 Dec 2023 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X51qlWeZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A364F880;
	Tue, 26 Dec 2023 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6oO/nH2dTlO47uvvrA8XfEBvbbkUP87KpzAhKCfS8Po=; b=X51qlWeZpB7a5LmhCmAqMgit9V
	5wlCoUbGKhz50VybZ0LOPHKRcANysy7WkeNOqBgGsqdH4sQlA0nBX5N5Womnn9mdtDNWVJ+19GBUA
	5hNmsXpSFhp0iJ6dj4WSf4I69dbtZgzu5Eshaa7bJOpmpVHOl22E4cdtfowmrnUmTacc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rIAmv-003meD-Cw; Tue, 26 Dec 2023 18:00:17 +0100
Date: Tue, 26 Dec 2023 18:00:17 +0100
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
Message-ID: <f7b894d0-9378-4c4d-8a3e-e35bb9593c72@lunn.ch>
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

> The code which should have prevented this from happening is in
> phy_attach_direct():
> 
> 	if (phydev->attached_dev) {
> 		dev_err(&dev->dev, "PHY already attached\n");
> 		err = -EBUSY;
> 		goto error;
> 	}

The problem might be dsa_shared_port_phylink_register():

        err = phylink_of_phy_connect(dp->pl, port_dn, 0);
        if (err && err != -ENODEV) {
                pr_err("could not attach to PHY: %d\n", err);
                goto err_phy_connect;
        }

        return 0;

Since it is not -ENODEV, it just keep going.

      Andrew

