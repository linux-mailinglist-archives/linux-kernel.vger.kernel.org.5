Return-Path: <linux-kernel+bounces-63192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBD852C28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE8A1C22E10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE2225A4;
	Tue, 13 Feb 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="BmfTHJra"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B10224CF;
	Tue, 13 Feb 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815926; cv=none; b=O8IcWj6g2vMy3xUiRQhWEsV3F/EzuhChOeAzXlBLhAfxKsnPh492l47h5bhi3zFbIMdaUAXsw80AYpxQW860NZCWjFsth+fhp723vKC2LMVebvOKqsMuvskzkIwRUqY/1D+qqD/yvk91R9ypNZgQVGVWoXtVICXscU4T/hPBUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815926; c=relaxed/simple;
	bh=cvSxx7Ohr60BHYOexEqdTgq+FckwJDQkZo+QPbEUsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI6F9Z/hWFsQToL4Nr3e4xlj9RI9lvG5YptRhrLQI2rVAlWtqHsVwvGYbvcw9R0fQvPf6LGZljLfpOczcOk30G7slQbtPEPT1aIYCVzVQ43y+V44em6r1GE7fXSk16fDLvmXM6KkJEDEy28PrwapJODtGV/Jy/DcMS9He00Wvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=BmfTHJra; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8E5951C007F; Tue, 13 Feb 2024 10:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707815919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6Lvb6WvQfO/ZL1XThmMYEqS/uVfVMsg69aI8jKXas=;
	b=BmfTHJra1LbjfT7B71ztCOLmv3KVsOka7y/FL5r1hyHIBIS21mFjFxUrWAuqQi7vERaObl
	E0Y25zcIoxlJFNzo/9irxLO7q9aHaN8fncF0SYq3DFXymh/JQvKXp9HGgRpCLXgLxL/yaD
	tpQHyK/eBzaiSjdtrn4MSwj5296x8ek=
Date: Tue, 13 Feb 2024 10:18:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <Zcsz7x1rXgYP3e7b@duo.ucw.cz>
References: <20240203175910.301099-1-alkuor@gmail.com>
 <20240203175910.301099-2-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pIcXbQiXcgKFKqs/"
Content-Disposition: inline
In-Reply-To: <20240203175910.301099-2-alkuor@gmail.com>


--pIcXbQiXcgKFKqs/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  .../sysfs-class-led-multicolor-driver-ncp5623 |  46 +++
>  drivers/leds/rgb/Kconfig                      |  11 +
>  drivers/leds/rgb/Makefile                     |   1 +
>  drivers/leds/rgb/leds-ncp5623.c               | 320 ++++++++++++++++++
>  4 files changed, 378 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor-=
driver-ncp5623
>  create mode 100644 drivers/leds/rgb/leds-ncp5623.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-=
ncp5623 b/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp56=
23
> new file mode 100644
> index 000000000000..6b9f4849852b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp5623
> @@ -0,0 +1,46 @@
> +What:		/sys/class/leds/<led>/direction
> +Date:		Feb 2024
> +What:		/sys/class/leds/<led>/dim_step

You are reinventing hardware_pattern trigger. NAK.

I suggest you add basic support first, then look at hardware pattern
trigger and add that support in separate patch.

Thanks,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pIcXbQiXcgKFKqs/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcsz7wAKCRAw5/Bqldv6
8ojFAJ9xenpCaeaaI2rONzaxvf3vOwURYQCgmCO+rVjSS3JO30mgiLqi40kQ0gY=
=Ijkc
-----END PGP SIGNATURE-----

--pIcXbQiXcgKFKqs/--

