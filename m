Return-Path: <linux-kernel+bounces-99957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D6878FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB2C1C21747
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9077F2C;
	Tue, 12 Mar 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="eAkPn0EO"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5177649;
	Tue, 12 Mar 2024 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232713; cv=none; b=PTc4X+VUja0b0zSLLkwWG62cqgzROFwih9r7N3Jf0+knXhTbD+iLLFjdaivzq0ok4lSOnnp2C8x39qB5ngsKZggFnEaNpc29lIUPAzy58ZltbJOAtL+WPoZvup9PHHESh5uUjZK2lamk1kDDO0jIse3JUGf5/D9w7dYPhlIglm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232713; c=relaxed/simple;
	bh=D0Dav/Qn1cv9bfxKazHy8Ke0NZ+LD2IcglLT273M/Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORKLsYJwtxZsxI+K/08whOdXUAiKkLisiy/NtZ6D5tdjkRfnQlgWyQtUGeSZA/7eOS7VWkQCWAuk/EeA4pfL0uFdF7mU/7knC9k1COhi9tdU4lmqKPGxSSCh6SVA6/KeiJai7qc/KwqiZptZrtCmol9AE4+l8gJth7RQ02B1+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=eAkPn0EO; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B5A651C006B; Tue, 12 Mar 2024 09:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710232706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LR2nwwqmgN2QbjgHc3Koo0qVoLVq9J7DOCiQPH0RGMA=;
	b=eAkPn0EOGw/osV4V95LaZ/AYDfXEWT0hpGgcikEcoVVy9btE2li73UchXhO44I2/SETQsz
	KKnKF/aJqRm+Nt0L4wj1lpU4tEu97pX4Rg2qSV5JO/4Pl+fh6YvCFjsJVilkwN0jWkCAyH
	viJd2lwZGjHsu+GuxK09lvW+p6+PmZQ=
Date: Tue, 12 Mar 2024 09:38:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
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
Message-ID: <ZfAUgYj0ksDmGuhN@amd.ucw.cz>
References: <20240229204039.2861519-1-sashal@kernel.org>
 <20240229204039.2861519-12-sashal@kernel.org>
 <Ze9x6qqGYdRiWy3h@duo.ucw.cz>
 <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q9rn6aD/S92U1E3N"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>


--Q9rn6aD/S92U1E3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: Rob Herring <robh@kernel.org>
> > >
> > > [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
> > >
> > > The dtc interrupt_provider warning is off by default. Fix all the war=
nings
> > > so it can be enabled.
> >
> > We don't have that warning in 6.1 and likely won't enable it, so we
> > should not need this.
>=20
> Still, this fixes issues in DTS that were not noticed before because
> the checks were disabled.

Is this patch known to fix user-visible behaviour?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Q9rn6aD/S92U1E3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfAUgQAKCRAw5/Bqldv6
8l6HAJ48NTNe0sjM5dmXZJpgVt2yUt0QewCgusqrfmeYba20Wbn4F2DCto9qrKQ=
=NHYi
-----END PGP SIGNATURE-----

--Q9rn6aD/S92U1E3N--

