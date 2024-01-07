Return-Path: <linux-kernel+bounces-18971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111D8265D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E5328195D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50911700;
	Sun,  7 Jan 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdZwIGQJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A71119B;
	Sun,  7 Jan 2024 19:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB244C433C8;
	Sun,  7 Jan 2024 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704657168;
	bh=0mJ6xiLJKj/jFKQ9JbI84trjO4v1ZovLdA3D35k6E5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdZwIGQJFl8v61u03DHLyxb8H18WGB3ANDT6V1AoQakIo4HuJ/ZgwABc/u2PG+cJg
	 SQ4Ezh7Z4iuRBNuy5xVFSOoDRhawTG7oBLNtgZlQLMWkGAWk0mlupo7rv9CGgUtNoe
	 HCgQipBweZqqyE3p2Sf1SNQqEfJW75qYDw8YbM9lXPYKwUMkOhexuDF/ed4g7gMjor
	 2ArRk9zQ1BakM6/jOjxT2vYFEeNvALvfYC3H0NJmNdDKuFky4BgjzTmd+bvLIuzVXL
	 61sJ2EUJuu2mqWvyvtDQJqR+v4Z+p6+HZzW/lGopyoF8Cxdu8/y2Xfh8h4JHFbQnW8
	 3cAoYaBGML5+w==
Date: Sun, 7 Jan 2024 19:52:41 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Message-ID: <20240107195241.GB132648@kernel.org>
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240106122142.235389-1-arinc.unal@arinc9.com>

On Sat, Jan 06, 2024 at 03:21:42PM +0300, Arınç ÜNAL wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> Currently the MDIO bus of the switches the MT7530 DSA subdriver controls
> can only be registered as non-OF-based. Bring support for registering the
> bus OF-based.
> 
> The subdrivers that control switches [with MDIO bus] probed on OF must
> follow this logic to support all cases properly:
> 
> No switch MDIO bus defined: Populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if "interrupt-controller" is defined at
> the switch node. This case should only be covered for the switches which
> their dt-bindings documentation didn't document the MDIO bus from the
> start. This is to keep supporting the device trees that do not describe the
> MDIO bus on the device tree but the MDIO bus is being used nonetheless.
> 
> Switch MDIO bus defined: Don't populate ds->user_mii_bus, register the MDIO
> bus, set the interrupts for PHYs if ["interrupt-controller" is defined at
> the switch node and "interrupts" is defined at the PHY nodes under the
> switch MDIO bus node].
> 
> Switch MDIO bus defined but explicitly disabled: If the device tree says
> status = "disabled" for the MDIO bus, we shouldn't need an MDIO bus at all.
> Instead, just exit as early as possible and do not call any MDIO API.
> 
> The use of ds->user_mii_bus is inappropriate when the MDIO bus of the
> switch is described on the device tree [1], which is why we don't populate
> ds->user_mii_bus in that case.
> 
> Link: https://lore.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/ [1]
> Suggested-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 391c4dbdff42..39d7e7ad7154 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
>  static int
>  mt7530_setup_mdio(struct mt7530_priv *priv)
>  {
> +	struct device_node *mnp, *np = priv->dev->of_node;
>  	struct dsa_switch *ds = priv->ds;
>  	struct device *dev = priv->dev;
>  	struct mii_bus *bus;
>  	static int idx;
> -	int ret;
> +	int ret = 0;
> +
> +	mnp = of_get_child_by_name(np, "mdio");
> +
> +	if (mnp && !of_device_is_available(mnp))
> +		goto out;

nit: I think it would easier on the eyes to simply

		return 0;

>  
>  	bus = devm_mdiobus_alloc(dev);
>  	if (!bus)
>  		return -ENOMEM;
>  
> -	ds->user_mii_bus = bus;
> +	if (!mnp)
> +		ds->user_mii_bus = bus;
> +
>  	bus->priv = priv;
>  	bus->name = KBUILD_MODNAME "-mii";
>  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> @@ -2174,16 +2182,18 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	bus->parent = dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
>  
> -	if (priv->irq)
> +	if (priv->irq && !mnp)
>  		mt7530_setup_mdio_irq(priv);
>  
> -	ret = devm_mdiobus_register(dev, bus);
> +	ret = devm_of_mdiobus_register(dev, bus, mnp);
> +	of_node_put(mnp);
>  	if (ret) {
>  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
>  		if (priv->irq)
>  			mt7530_free_mdio_irq(priv);
>  	}
>  
> +out:
>  	return ret;
>  }
>  
> -- 
> 2.40.1
> 

