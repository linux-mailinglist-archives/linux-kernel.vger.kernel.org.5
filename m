Return-Path: <linux-kernel+bounces-38984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20583C95B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13684298967
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C231386C9;
	Thu, 25 Jan 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mt/ittrQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4801133426;
	Thu, 25 Jan 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201954; cv=none; b=UTKyzmYTV9xTPfbJLj2yteeZr51flkCx3ddxRt5pCfW5aruATUxB/hxQy3L/wvYxyD/Zcq6MvWqWnm0mIjtD3Mnh2SgQI90weQWUk2wFnYpDTJzCVIqDc+rhlwza2o11Tt/CGJKXsAKq0NDtPO7CIBxQ3qlsGNqU6+Nm8oCqoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201954; c=relaxed/simple;
	bh=Fw8zkpgWbRgecvNR6KYdozr/aJucW2Q7H+2sM+Tocj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEdutGDmNOO72oKJC/Wa2J5tIoLuvN3kacIq7e8LPILfQsIzXz8SFC2exTeLTWRWGcAUvHij/6A5avYBGRwTtKghpUPjtOUeI29O12LxJwaNuT+3766xlAY+UFMCJpROkfDRBVDzvKnpqPC58WZxzxIlSJDoTrt4yQAaWMMdqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mt/ittrQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EYYNnNB/ACJkHAzXIbkBzWfCnx4/ZTGkKYLvDGMO7II=; b=Mt/ittrQ413wEjpO6XByH96pAa
	TlaJO1gLvV+h4vzxSPu3b4C4Y3DsBVCL6U5A6nR9mZqYlgQEaHDoq8gv1j7nR2JbyBL6OAv1cq9WD
	/5wHkYUOWQHjQ9SBNULx3Dkf8WQ7eO+KlFLG5lJ/lY9LX3fY532sLLNm81vKCx/vPuXE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT34E-0066Uo-Em; Thu, 25 Jan 2024 17:59:06 +0100
Date: Thu, 25 Jan 2024 17:59:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, petr.benes@ysoft.com
Subject: Re: [PATCH net v2] net: dsa: qca8k: fix illegal usage of GPIO
Message-ID: <2477cf4a-6824-4997-aef8-3f8e5f9b2399@lunn.ch>
References: <1706096225-23468-1-git-send-email-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706096225-23468-1-git-send-email-michal.vokac@ysoft.com>

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index ec57d9d52072..3663de8f2617 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -2037,13 +2037,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
>  	priv->dev = &mdiodev->dev;
>  	priv->info = of_device_get_match_data(priv->dev);
>  
> -	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
> -						   GPIOD_ASIS);
> +	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);

Sorry, i should of pointed this out on the previous version. netdev
kept with 80 character lines. That is why what you deleted was split
over two lines, and what you add should also split at the same point.

    Andrew

---
pw-bot: cr

