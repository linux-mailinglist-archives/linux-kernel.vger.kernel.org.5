Return-Path: <linux-kernel+bounces-15898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5044823547
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFFDB23D81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A01CAA3;
	Wed,  3 Jan 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OILfO9U1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BA1CA8F;
	Wed,  3 Jan 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28aa47bd15so85309166b.2;
        Wed, 03 Jan 2024 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308570; x=1704913370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/MJgpoiYX2ieK9G59Tpv6u4Pnf7MXXAZFvpISXd2cjQ=;
        b=OILfO9U1Om6jnWZ9En6zZ81AMIXP1rk3zZKbXrTpmRKx+JaCJYBWhYzilNaMRggj8N
         OkOqzLiRhogRvK7pE3C8UCZf7CNpFWO7gBKubRCYVbY3v7JIGxMkyOs6ONkFE/y58Pqs
         /CZ9WHZqv30QGyj70+zdxkKwFKykVzvAke/GnNzz4wYaekebsymeCmE5uKykoCcq9E2j
         hutHmp12bHTCOq3GGErZ0MeNEid/IMWUl/DmrEjVAvYCIeGnx2EK4iA+sZjEoQz8Ty90
         t9K2iCL28lrdKn8WXtl0EnFpzzGMfgyfwMP9gqzgBhoOjeCt9n3C3GYztvrn//AlnU04
         Ojuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308570; x=1704913370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MJgpoiYX2ieK9G59Tpv6u4Pnf7MXXAZFvpISXd2cjQ=;
        b=p3GGlJSl+cybRyxihlZuGtNebsr8FswZ30f6nN7Ko/gbsLvCBaNxbb6veC86OyIQGy
         dp8h2Pb1hLT7lSd4yA0DAvhJmzOcqwrCaI0N4jkjb/mLPEekb11U2tjlicqJ5tR00JQS
         99/PZc8cSDjkbuvUXVxO3/eT1eaTJyyewI4rBWHaoN924qmlhoy/C0oZ/CkFS9YdEVXd
         PSkEkIi9vW/+griINncYHgVpe1DkQLLElM9UnBmvRiRWWafgNfR8ip5l7XVJtt8MCOl8
         mZPasWqfKNda5dcaBw24VxwuAxlPA4Mil+f1uoUjE3JGEc/OV6gxCftqcxsNh8snp2md
         U/cg==
X-Gm-Message-State: AOJu0YxmlBamyQYUvW+fEimIOHjoxPL7IFurc6X/NdyFf/nAn7klKPw7
	44kzGRbs+hY94dcqzMxw0/M=
X-Google-Smtp-Source: AGHT+IGUH8UoqdtTD6HYFLZRnvMAdGqAM2Civpr13lPO+LrJfvwYUVRvVPe9b2Z+NgdZ2JAyrQq2qw==
X-Received: by 2002:a17:906:a1c2:b0:a26:874f:4847 with SMTP id bx2-20020a170906a1c200b00a26874f4847mr7510133ejb.65.1704308569468;
        Wed, 03 Jan 2024 11:02:49 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id kb6-20020a170907924600b00a27a32e6502sm4939779ejb.117.2024.01.03.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:02:49 -0800 (PST)
Date: Wed, 3 Jan 2024 21:02:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
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
	erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
Message-ID: <20240103190246.ctyeehvfmhctpphf@skbuf>
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
 <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
 <20231227191154.6jkqdlqdxciidpfw@skbuf>
 <bdbe24b2-30f6-48fa-b6eb-a1ae3afe9076@arinc9.com>
 <20231227200217.kdltxpmhvlp6z4cd@skbuf>
 <d2a7cc7e-bb27-472f-8921-5579a894c71d@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2a7cc7e-bb27-472f-8921-5579a894c71d@arinc9.com>

On Thu, Dec 28, 2023 at 07:58:13PM +0300, Arınç ÜNAL wrote:
> As Daniel stated on a previous submission of this patch, being able to
> reference the PHYs on the switch MDIO bus is mandatory on MT7988 as
> calibration data from NVMEM for each PHY is required, so defining the MDIO
> bus is required to support MT7988. Therefore, we should support interrupts
> on device trees with the switch MDIO bus defined.

Understood and no objection there. I was just making sure that there is
no existing case in upstream where the internal PHYs are described in OF,
that we'd have to preserve IRQ functionality for.

> The implementation below follows this logic:
> 
> No switch MDIO bus defined: Register the MDIO bus, set the interrupts for
> PHYs if "interrupt-controller" is defined at the switch node.
> 
> Switch MDIO bus defined: Register the MDIO bus, set the interrupts for PHYs
> if ["interrupt-controller" is defined at the switch node and "interrupts"
> is defined at the PHY nodes under the switch MDIO bus node].
> 
> I think this approach fits your description so I'd like to agree that this
> should be the way for all DSA subdrivers. Please let me know what you
> think.
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 391c4dbdff42..bbd230a73ead 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2155,15 +2155,21 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  {
>  	struct dsa_switch *ds = priv->ds;
>  	struct device *dev = priv->dev;
> +	struct device_node *np, *mnp;
>  	struct mii_bus *bus;
>  	static int idx;
>  	int ret;
> +	np = priv->dev->of_node;
> +	mnp = of_get_child_by_name(np, "mdio");
> +

Empty line between variable declarations and code. Or you can initialize
them as part of their declaration, but you need to stick to the "longest
line first" rule.

Also, it would be good to also check of_device_is_available(mnp).

>  	bus = devm_mdiobus_alloc(dev);
>  	if (!bus)
>  		return -ENOMEM;
> -	ds->user_mii_bus = bus;
> +	if (mnp == NULL)

!mnp

> +		ds->user_mii_bus = bus;
> +
>  	bus->priv = priv;
>  	bus->name = KBUILD_MODNAME "-mii";
>  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> @@ -2174,10 +2180,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	bus->parent = dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
> -	if (priv->irq)
> +	if (priv->irq && mnp == NULL)
>  		mt7530_setup_mdio_irq(priv);
> -	ret = devm_mdiobus_register(dev, bus);
> +	ret = devm_of_mdiobus_register(dev, bus, mnp);
> +	of_node_put(mnp);

This is going to be interesting. There isn't really a correct way to
manage the reference to "mnp", as far as I can tell. Normally, it should
have been possible to release the reference as you did. But you need
something along the lines of what Luiz/Russell have been discussing
here:

https://lore.kernel.org/netdev/20231220045228.27079-2-luizluca@gmail.com/

In any case, the devres variant of of_mdiobus_register() seems incompatible
with the mt7530 driver owning the "mnp" node for any longer than this,
because it has no hook to call of_node_put() once the MDIO bus is unregistered.

>  	if (ret) {
>  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
>  		if (priv->irq)
> 
> With this device tree:
> 
> switch {
> 	interrupt-controller;
> }
> 
> [    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
> [    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
> [    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
> [    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
> [    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)
> 
> With this device tree:
> 
> switch {
> 	interrupt-controller;
> 
> 	mdio {
> 		phy {
> 			reg = <0>;
> 		}
> 	}
> }
> 
> [    1.413101] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    1.429954] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    1.443704] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    1.455876] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=POLL)
> [    1.468079] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=POLL)
> 
> With this device tree:
> 
> switch {
> 	interrupt-controller;
> 
> 	mdio {
> 		phy {
> 			reg = <0>;
> 			interrupts = <0>;
> 		}
> 	}
> }
> 
> [    1.420534] mt7530-mdio mdio-bus:1f lan1 (uninitialized): PHY [mt7530-0:00] driver [MediaTek MT7530 PHY] (irq=17)
> [    1.433224] mt7530-mdio mdio-bus:1f lan2 (uninitialized): PHY [mt7530-0:01] driver [MediaTek MT7530 PHY] (irq=18)
> [    1.445338] mt7530-mdio mdio-bus:1f lan3 (uninitialized): PHY [mt7530-0:02] driver [MediaTek MT7530 PHY] (irq=19)
> [    1.457472] mt7530-mdio mdio-bus:1f lan4 (uninitialized): PHY [mt7530-0:03] driver [MediaTek MT7530 PHY] (irq=20)
> [    1.469587] mt7530-mdio mdio-bus:1f wan (uninitialized): PHY [mt7530-0:04] driver [MediaTek MT7530 PHY] (irq=21)

Looks sane.

FWIW, I found Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml
where internal PHYs don't have an 'interrupts' property, yet they are
probably still expected to use interrupts - according to ksz_irq_phy_setup().

Anyway, what's done is done, but I still don't see the point of making
the binding much more flexible than it needs to be.

