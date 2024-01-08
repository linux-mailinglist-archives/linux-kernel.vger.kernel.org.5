Return-Path: <linux-kernel+bounces-19396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C7826C57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E5D282460
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9514282;
	Mon,  8 Jan 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrAC5YaC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A71426B;
	Mon,  8 Jan 2024 11:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE990C433C7;
	Mon,  8 Jan 2024 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704712510;
	bh=3onyJACON7UN+r62nN4g7w7HHbRgM+h21qgM1D0k0r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrAC5YaC8C/78giFGYGDmAO9hHqI3cDeSUnGDufaz+cC39G+F4UziFgYogb6u2b7m
	 s0/BFGaX7LSMtEXbDTbVufZhX0s+xPtXJB2ylD9Dl5a/sGc4EmcrjerEGAwqbZfH2p
	 k3cb0Z0ZJBWANO3X35IRgq9ozi7qLcGxzPXx2QlQjZqy/6rwnsbk/iqjUFuPvO6GN1
	 0wtZBFUZggsU8UHeHWMqg19y5k8b2j1NqHV8Jstg3VFNmsPg7MJJRaImu/vqxolo2M
	 yOQ3bimzkhEhBk37koV4IwJ7P3++y9xTMUOG8/YNEUGEMX5KjGVSG+cWSXDlbx2zCD
	 2PD+Mjyl74ZAg==
Date: Mon, 8 Jan 2024 11:15:03 +0000
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Message-ID: <20240108111503.GI132648@kernel.org>
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
 <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
 <20240108110000.aujqhlufehngtkjj@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108110000.aujqhlufehngtkjj@skbuf>

On Mon, Jan 08, 2024 at 01:00:00PM +0200, Vladimir Oltean wrote:
> On Mon, Jan 08, 2024 at 01:22:18PM +0300, Arınç ÜNAL wrote:
> > > > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > > > index 391c4dbdff42..39d7e7ad7154 100644
> > > > --- a/drivers/net/dsa/mt7530.c
> > > > +++ b/drivers/net/dsa/mt7530.c
> > > > @@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
> > > >   static int
> > > >   mt7530_setup_mdio(struct mt7530_priv *priv)
> > > >   {
> > > > +	struct device_node *mnp, *np = priv->dev->of_node;
> > > >   	struct dsa_switch *ds = priv->ds;
> > > >   	struct device *dev = priv->dev;
> > > >   	struct mii_bus *bus;
> > > >   	static int idx;
> > > > -	int ret;
> > > > +	int ret = 0;
> > > > +
> > > > +	mnp = of_get_child_by_name(np, "mdio");
> > > > +
> > > > +	if (mnp && !of_device_is_available(mnp))
> > > > +		goto out;
> > > 
> > > nit: I think it would easier on the eyes to simply
> > > 
> > > 		return 0;
> 
> Actually "return 0" leaks "mnp". An of_node_put() is needed.

Yes, sorry for not noticing that.

