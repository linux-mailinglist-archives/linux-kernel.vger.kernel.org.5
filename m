Return-Path: <linux-kernel+bounces-36165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38F839CED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2415928881C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FEA53E2F;
	Tue, 23 Jan 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qgkjjYHe"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CE210F6;
	Tue, 23 Jan 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051270; cv=none; b=Ai6zJLn4xhY1fM17XMjjBOGfU5bTsKKBCxUnUy01fnI9Ii4zcokd6wNzBp1aSLUcI0bD7Q6NtH/ft1vZG7SdRdnFJxbxYPNg8kXOTIc7eDFgTWcBAN05WGMkpYX2PIwZ2/vS3rmNfshOVRUT7mDxByhjtkl7xj/WF77sjb8VW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051270; c=relaxed/simple;
	bh=EF01pwf93jkw6zcgML//uN79n7gsoLCTDyk3XMANbsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gycRRVdkSDxaW9akkuaGr1Ibx2f37kb9lxoG6oxmYSFwshY7t56DQYM0MDpFpXAYOzhOItSLb3ZuiwEtse9IUAWUCLtNEAVi2T4Uh2SY4N6vWzhWd4Mvl81nvCmJ6NRYTlEIvtMdHd3BKiInNuzeVXr1bAxFq7PZLq5wIVODSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qgkjjYHe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LZZ7dIkzvXVF+O0UaEUz1mN+3JIr0400uS5HJQS+H80=; b=qg
	kjjYHeJxSBG3x262DYoZzND/Jb4HsUTj/VBsNGjbw2WGpe7iYlu7wGpCND/Y9E/rhux1yt5wZiTaa
	EjBZpn+SH0gc6pRxEL8Qy8gEyrm3oVjmrRZgeH+QWcXqWtlMa+rr7bIIkrbMQEV8Sxq0NyO/Fgdlm
	aquDAS16be7fs+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSPrh-005t3R-UQ; Wed, 24 Jan 2024 00:07:33 +0100
Date: Wed, 24 Jan 2024 00:07:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, petr.benes@ysoft.com
Subject: Re: [PATCH net] net: dsa: qca8k: fix illegal usage of GPIO
Message-ID: <82712052-e7e6-414d-9c11-5595e0d6e097@lunn.ch>
References: <1705925049-5756-1-git-send-email-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1705925049-5756-1-git-send-email-michal.vokac@ysoft.com>

On Mon, Jan 22, 2024 at 01:04:09PM +0100, Michal Vokáč wrote:
> When working with GPIO, its direction must be set either when the GPIO is
> requested by gpiod_get*() or later on by one of the gpiod_direction_*()
> functions. Neither of this is done here which result in undefined behavior
> on some systems.
> 
> As the reset GPIO is used right after it is requested here, it makes sense
> to configure it as GPIOD_OUT_HIGH right away.
> Fixes: a653f2f538f9 ("net: dsa: qca8k: introduce reset via gpio feature")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 4ce68e655a63..83b19c2d7b97 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -2037,8 +2037,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
>  	priv->dev = &mdiodev->dev;
>  	priv->info = of_device_get_match_data(priv->dev);
>  
> -	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
> -						   GPIOD_ASIS);
> +	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(priv->reset_gpio))
>  		return PTR_ERR(priv->reset_gpio);

Hi Michal

So the current code is:

	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
						   GPIOD_ASIS);
	if (IS_ERR(priv->reset_gpio))
		return PTR_ERR(priv->reset_gpio);

	if (priv->reset_gpio) {
		gpiod_set_value_cansleep(priv->reset_gpio, 1);
		/* The active low duration must be greater than 10 ms
		 * and checkpatch.pl wants 20 ms.
		 */
		msleep(20);
		gpiod_set_value_cansleep(priv->reset_gpio, 0);
	}

Doesn't your change make the gpiod_set_value_cansleep() pointless?

Please extend your patch to remove it, maybe extending the comment a
little.

Please also make sure what v2 Is Cc: to the qca8k Maintainers.

    Andrew

---
pw-bot: cr

