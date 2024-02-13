Return-Path: <linux-kernel+bounces-62691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A185246E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4654E1C235F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D378685;
	Tue, 13 Feb 2024 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5jKDBM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1077F38;
	Tue, 13 Feb 2024 00:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783766; cv=none; b=X+RUlsmW2S8oXrx6NHM6VJIDeQN1aGCaldZ1GXDNKHqoCU+rsMOP8skZ3H0Z6/RUyc/SvDniP2G4zFUDieRvSyYHbNfl1hU7KN025b6pESKdEty8Z6vg5Eu82BLLY/lFyX5SpT1BD6eHvVvmrPgroJ+2a3IYj0tCISNxU3ahkLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783766; c=relaxed/simple;
	bh=TuTEr8omUxfqM1O8DocELWTt9yAKpzvpGXNjHsPxxuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu0MeY3X5d6ibsGSJpJMtV4f1Fn4dd+uailb5fFM4vCZ3BnkKLp+tBpd12SSiIPnUy7jXDwRXkh81QX+axhsJ8fl1YI6/aXM/0lq2RhslqS5VsxyOIM/eH6tz79Qy8uf6ibE2PBkqz8hEU3bKHAmK5pQ6M1JPa0F+SbDYmwW56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5jKDBM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF312C43399;
	Tue, 13 Feb 2024 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783765;
	bh=TuTEr8omUxfqM1O8DocELWTt9yAKpzvpGXNjHsPxxuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O5jKDBM0g7YIMdQomXfz1EQQYXPp37dpkB4EONhCwaIyb0zjxJCTGjHrZ/5TroElx
	 Bzp0e5kFbTmwK6t28wyoWt/fBp7Fixsbd6mWPSWid2Ore7tNbIwlNE7YT57QPQPzXM
	 PZadVo5wKMlLuZTowenZP9hVkjfSqkcgCaESHfYXE7OlUXW66va3IUrGWFZd5cyM7T
	 TIhWZx1SwFIgqa7Zo8rVTtomiFD7xJcdpfFm9ZXlH8pa9VIqtVWY7YWKYbOBUAECyR
	 F8yL2UCW4RJ+hOggfVngUXf+prjvJuhXRGRQ0i6e1IkrNFRxAxeq6az9LQtZ+sawD8
	 fMSgyCqhGKuEw==
Date: Mon, 12 Feb 2024 16:22:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: ppe: add
 support for multiple PPEs
Message-ID: <20240212162244.3c011072@kernel.org>
In-Reply-To: <20240210135620.28368-1-eladwf@gmail.com>
References: <Zcdtb-eyvxzX9yPe@makrotopia.org>
	<20240210135620.28368-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 15:56:07 +0200 Elad Yifee wrote:
> Add the missing pieces to allow multiple PPEs units, one for each GMAC.
> mtk_gdm_config has been modified to work on targted mac ID,
> the inner loop moved outside of the function to allow unrelated
> operations like setting the MAC's PPE index.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index a6e91573f8da..5d5cf73a5d5a 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2010,6 +2010,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  	struct mtk_rx_dma_v2 *rxd, trxd;
>  	int done = 0, bytes = 0;
>  	dma_addr_t dma_addr = DMA_MAPPING_ERROR;
> +	u8 ppe_index = 0;

Please don't use u8 for basic on-stack variables unless it matches some
HW field which is 8b.

> @@ -3358,6 +3350,8 @@ static int mtk_open(struct net_device *dev)
>  	struct mtk_mac *mac = netdev_priv(dev);
>  	struct mtk_eth *eth = mac->hw;
>  	int i, err;
> +	struct mtk_mac *target_mac;
> +	const u8 ppe_num = mtk_get_ppe_num(eth);

nit: Please order variable decl lines longest to shortest.
If the order breaks init, you should move the init to the body.

It's a bit unclear what the difference between ppe_num, num_ppe and
ppe_index, id and ppe_idx are. It'd be good to increase the naming
consistency.

> @@ -1311,6 +1313,7 @@ struct mtk_eth {
>  struct mtk_mac {
>  	int				id;
>  	phy_interface_t			interface;
> +	u8			ppe_idx;

this looks misaligned

>  	int				speed;
>  	struct device_node		*of_node;
>  	struct phylink			*phylink;

When you repost please do not reply in the same thread.
Start a new one. 

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

-- 
pw-bot: cr

