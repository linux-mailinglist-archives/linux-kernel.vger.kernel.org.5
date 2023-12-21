Return-Path: <linux-kernel+bounces-8120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19C81B25E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2568C288C99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229D4D114;
	Thu, 21 Dec 2023 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HGG1wa2r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC44D108;
	Thu, 21 Dec 2023 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Q5cOIVW2NXQCgE8m7MOSUxp7IMMRSApRmgjadLhzFs=; b=HGG1wa2raGGp05ho8o8RKqOknz
	KILTqZixOLLzlW1a6Z03U2rsSkmIsk7JIuRgI+NqiPxoYcBVRpxgdeLiYbBbxyAt0MoyPCTeDj6WD
	QpTNzCi+vTCe8a4ZECCa54w7drc3WtfQ5+bzb8g+u5Wd8ssmwJrO+OiPSAZ6JbRIKrRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGFKu-003Uho-BE; Thu, 21 Dec 2023 10:27:24 +0100
Date: Thu, 21 Dec 2023 10:27:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Message-ID: <8e248f59-007a-4c53-877f-6026f4a74d0b@lunn.ch>
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <d78949f0-bb03-82ea-b40f-1bb92b41e200@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78949f0-bb03-82ea-b40f-1bb92b41e200@ti.com>

> > @@ -2177,7 +2180,9 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
> >  	if (priv->irq)
> >  		mt7530_setup_mdio_irq(priv);
> >  
> > -	ret = devm_mdiobus_register(dev, bus);
> > +	mnp = of_get_child_by_name(np, "mdio");
> 
> If the node is not found, then the return value would be NULL.
> Though devm_of_mdiobus_register() and of_node_put() take care of NULL references,
> other drivers that use devm_of_mdiobus_register() mostly perform a early exit if the node is NULL.

Actually, many don't as well. of_mdiobus_register() falls back to
mdiobus_register() is np==NULL. That causes a scan of the bus to find
all the PHYs and you can then use phy_find_first() to access them.

So this code is O.K.

   Andrew

