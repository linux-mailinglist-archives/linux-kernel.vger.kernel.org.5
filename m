Return-Path: <linux-kernel+bounces-92699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB587247C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA8D1F26DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20399C129;
	Tue,  5 Mar 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+50sRCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6F8BF7;
	Tue,  5 Mar 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656781; cv=none; b=lAqHptvHMLO3/QrmVpcBh8JYnQU/sP0M5v/Zkb3c/pBI+XOtouInU3JFB4gRlbmUkMG2/jgTTZvZtykknafcYV3RfXRDut5eustL8WcP++dPWEgDHJPUa274IHUxysm9rEvfynPWnr10kGo5A67OZSoxh8T2V4CTeNvEarZ0lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656781; c=relaxed/simple;
	bh=7vgMXiC1hDBo2W+mPCaSNE01HYivT5LVBqveRukvTZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvCvnLJx2jGu8PSXs7qdYl5zNgGmY5GF/VGMiDQjR97jOrTRuDmiyTma3FrTA8KtreZ2b48AU0HthXa0W9XB/ou37e0j6nely8B96xGpYz9RKY0oEfTW4+d3DQWjPAqBOVnnDeb5dGvi4Q7kc2XKTaI/tYO4voRuryy9W0eLtlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+50sRCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81467C433F1;
	Tue,  5 Mar 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709656780;
	bh=7vgMXiC1hDBo2W+mPCaSNE01HYivT5LVBqveRukvTZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e+50sRCAFYr9qssxAd2CCEJWSD8uQoONX21r70DvAh5vq/CV13lCDJ9kLNl/G08qi
	 FbNe0AyeYDE4BTW6WG1J3ljJh7aOujNuPjGA6nbQRi9vyBA30MnY3m2PLTUTYms4LY
	 gX0EUGQUBevvHchQpSM4v6ruUlfxhd0FXES/YJhbxhzLpmdzel/OCAM3LlzoNE0NaK
	 mw9hp0COR3vTDCfGssJG8fv/Hi2mZNudmwrMzD9eo6FleRcHPbGzlR4ui7BDKYG/vT
	 erQ4EKSrMJNEjVekC356EL2lA1/LJ0ve26ybTMK4pCfZX3V3NJhha2UD7AuNOKpXyn
	 LXSWK5g0EXaOw==
Date: Tue, 5 Mar 2024 08:39:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20240305083938.6977335f@kernel.org>
In-Reply-To: <20240305163546.3b9f3ed9@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
	<20240304185734.5f1a476c@kernel.org>
	<ZebZpspMCqjLES/W@shell.armlinux.org.uk>
	<20240305111021.5c892d5a@kmaincent-XPS-13-7390>
	<20240305065939.2d419ff2@kernel.org>
	<20240305163546.3b9f3ed9@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 16:35:46 +0100 K=C3=B6ry Maincent wrote:
> > Still, wouldn't it be simpler to store all accessible PTP instances=20
> > in the netdev? =20
>=20
> You are talking about something like the phy topology but for the ptp?
>=20
> Then when asking information on a PHC (tsinfo or hwtstamp config) from et=
htool
> we would have to look at the PHC topology of the netdev. This could work.=
 Not
> sure it is much simpler, do you see other advantages that it could have?

I was thinking just an array indexed by enum hwtstamp_source.
But you're right, once we can express more than one phy per
netdev we're basically back to doing similar walks. Fair.

