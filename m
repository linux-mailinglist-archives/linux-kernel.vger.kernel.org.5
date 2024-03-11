Return-Path: <linux-kernel+bounces-99543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B88789CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A32E1F21502
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DD5677A;
	Mon, 11 Mar 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="k5YXabBP"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EE40866;
	Mon, 11 Mar 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191086; cv=none; b=JF4I3hiGS44ysXgQwM/m3UKReQfBkPPmp1UjAUmDzX5bkjNFEHB4rmorGk+DMXQG2Is5LRKJ65Qc7dO/iJHd6/ZAQ0eNx+mDmG+LvTZW9UxqZ8jFGoxzH6JezGCuRrsyWRRl8eAhhZmyVwJybkLW3c46ssp5WivVq9j7d8cxMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191086; c=relaxed/simple;
	bh=OfZPRHC/NTNtDRjQJi5+yv2yxrNr7S0IlMceVxwvhC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POry5V73gV6YHvcDLcYk54ZGUplA+05C4HZF5QokMflamUYZPqrAxK5FLSQm6TgJOHe2bZW7VOCr0zp4dA6yCOYqw/44uqcFUOCV1QV5q89PdQJQMRynpmPgJX4FQrDM0Ck+BldNN3N8m7pZfJk4pcKhp+Xw6o5jj1HSOC+RRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=k5YXabBP; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 239C21C006B; Mon, 11 Mar 2024 22:04:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710191083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWKYOYEVoTjFTjEaOl+GY72vx6MkMiK/T1nV//CxK1Y=;
	b=k5YXabBPci6TAodHddzyx4y1TYt8ecxjtkd7QYnRxmQxH62IfrGXfKKcPo4faZRGmlV0wE
	pfzrPDWvIG90hG8SKhkZT0Y05EMUVM8ADHSrqgoXe+3Y/etwPbv0xsS4Kmj1Dd1Yah4bOm
	wSZ1UpjMcfmU1tQXERA3c5IP7c3w1WA=
Date: Mon, 11 Mar 2024 22:04:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Chanho Min <chanho.min@lge.com>, Arnd Bergmann <arnd@arndb.de>,
	tsahee@annapurnalabs.com, atenart@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	rjui@broadcom.com, sbranden@broadcom.com, andrew@lunn.ch,
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	matthias.bgg@gmail.com, magnus.damm@gmail.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 12/12] arm64: dts: Fix dtc interrupt_provider
 warnings
Message-ID: <Ze9x6qqGYdRiWy3h@duo.ucw.cz>
References: <20240229204039.2861519-1-sashal@kernel.org>
 <20240229204039.2861519-12-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Qt9dsw4Yel33kO/"
Content-Disposition: inline
In-Reply-To: <20240229204039.2861519-12-sashal@kernel.org>


--8Qt9dsw4Yel33kO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Rob Herring <robh@kernel.org>
>=20
> [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
>=20
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.

We don't have that warning in 6.1 and likely won't enable it, so we
should not need this.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--8Qt9dsw4Yel33kO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZe9x6gAKCRAw5/Bqldv6
8k23AKCohjgfYZMEaizYp8b4irlIqXjE2gCdHBiIfD3co6vqw2yumT637ihoC2o=
=YhHl
-----END PGP SIGNATURE-----

--8Qt9dsw4Yel33kO/--

