Return-Path: <linux-kernel+bounces-65701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03ED855093
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC9D1C29912
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B00126F30;
	Wed, 14 Feb 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrtblwVz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0A85652;
	Wed, 14 Feb 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932520; cv=none; b=aK9ZBq68CJ1iMzEvFzW854todBNl7rppbebM+A8i+fnwudYuqdKabdzskXE8G/9RAVs+DMyvy/Yd/ZF1x/jysWqEM3iKoyyzoYQv1bUQTGNtQfeTYtLNxDSe5eEh/UOWTA8z3vHXfQu0CghyRTpyR+9zi3NBAsfsKkfbbPjevug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932520; c=relaxed/simple;
	bh=18RszC4I8pEDrlSkWAbUMwdU0cYJAABOUQcbOwK+3Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlFyBuDrD4EO1yZNwVXGnpFTE6oMSflGi41got40TYNLruH+COjMgRZiWXoBBlp5xxz7nGFygT952RC40yUDtjfQfmNjXmg9UmIKSKBLb+UrnZ3FKcT8h1XoyjVhIQlS0/ucA3SmMRaYpzkbC8bE/oxxWx51Yvrtdh+D1kEsQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SrtblwVz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kOGAHmD/uHrlUe44DhBhYcWGT30uiiQkd/1lln/pcVw=; b=SrtblwVzS4QvgGQuOIxuEhnC4L
	IwNhY16DPDkp+NQg+RUcII2EC8ynVuSwhBUgVIitNM55OebksLAuCn4bn24bbSzAUxwXep6QXiyrF
	hTDdDSqJMlq5cwG37rDB3QN8hl68J6+PRgRnWY68Jdve4z3GkFW6BiQjUFu/IS2s3DWA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJGc-007oMN-Q1; Wed, 14 Feb 2024 18:41:54 +0100
Date: Wed, 14 Feb 2024 18:41:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <618be4b1-c52c-4b8f-8818-1e4150867cad@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
 <ZciUQqjM4Z8Tc6Db@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZciUQqjM4Z8Tc6Db@pengutronix.de>

> Alternative A and B Overview
> ----------------------------
> 
> - **Alternative A:** Utilizes the data-carrying pairs for power transmission in
>   10/100BaseT networks. The power delivery's polarity in this alternative can
>   vary based on the MDI (Medium Dependent Interface) or MDI-X (Medium Dependent
>   Interface Crossover) configuration.
> 
> - **Alternative B:** Delivers power over the spare pairs not used for data in
>   10/100BaseT networks. Unlike Alternative A, Alternative B's method separates
>   power from data lines within the cable. Though it is less influenced by data
>   transmission direction, Alternative B includes two configurations with
>   different polarities, known as variant X and variant S, to accommodate
>   different network requirements and device specifications.

Thanks for this documentation.

It might be worth pointing out that RJ-45 supports up to 4
pairs. However, 10/100BaseT only makes use of two pairs for data
transfer from the four. 1000BaseT and above make use of all four pairs
for data transfer. If you don't know this, it is not so obvious what
'data-carrying pairs' and 'spare pairs' mean.

And what happens for 1000BaseT when all four pairs are in use?

    Andrew

