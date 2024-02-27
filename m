Return-Path: <linux-kernel+bounces-83672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC7869D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B662028B315
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A7249F5;
	Tue, 27 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RZWe+Ivl"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B747F60
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053495; cv=none; b=EG5zCzrJ4nqwxYPromq8tKoicHCW4DV56+0nhf6uPlBcFDuUcIYPNgUWxed3r4r9FTUzTS2U2E9136yO8yIswMn2BRwjiw2Wewx6DsUpoAGiyhj1B/0TU1QjXP8oHpYYsvRYJeW88nkYSqBq1sc6eu4nvZ+D85Tn7smNeRVab0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053495; c=relaxed/simple;
	bh=nx3Al3sJLVHlvfnNiUefu/fSlBGWeq90iTuG8ElMJVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4dJd2BfUYpRFLix5es0jl2RLq09ApEc0PcWhnNBNq/th2Ow3akBDt1FsCa5sM/ATUROhLeMX17BWxdO9zdlZrHokB+H2Evdh/oeYJH+NN6B5yFbVjC54W3HKVZuexHA75BwKtiqug5x5RwXk/O/gCJb6T2JIqphTRX2vieDrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RZWe+Ivl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nx3A
	l3sJLVHlvfnNiUefu/fSlBGWeq90iTuG8ElMJVI=; b=RZWe+IvlEXiNRgwQBlBr
	HkeuLQlomaOzt17btM8FfRjYYXz3GxFr9/zMIUUmAYdMi944hjqvJ6n1YYD/421j
	IAJ0Fy4gEbKYmsPmAAwLkD9BlkG/fVGmFIEg0cx3oeWCRBJr4gfIZ6DeaPo7i7rU
	hgyz3v8BnPUXTrABKnkLDBhaejAUAiV/qndSkX11xH0QRyV34l29hMAF6gN/Pxyt
	kZIYL8ltx8O8ESK60+lQeYkJJyzijLo4Ge+qQm5/9PN7gX/37Zt4vYeNBZRZdlig
	T9o2CB+cbVIyoVuE440kLAtcQ6NSNZisaw76X7iZOQuY4xoAHZ1qnXFozdWiq9FF
	Iw==
Received: (qmail 1670908 invoked from network); 27 Feb 2024 18:04:42 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Feb 2024 18:04:42 +0100
X-UD-Smtp-Session: l3s3148p1@CKOvBWASTKUujnu9
Date: Tue, 27 Feb 2024 18:04:41 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-i3c@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: Remove obsolete i2c.txt
Message-ID: <Zd4WKY966qe4DC3i@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-i3c@lists.infradead.org,
	linux-sound@vger.kernel.org
References: <20240222174343.3482354-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J5qK8c/j+dsQwcO0"
Content-Disposition: inline
In-Reply-To: <20240222174343.3482354-2-robh@kernel.org>


--J5qK8c/j+dsQwcO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:43:42AM -0700, Rob Herring wrote:
> Everything in i2c.txt is covered by schemas/i2c/i2c-controller.yaml in
> dtschema project, so remove i2c.txt and update links to it in the tree.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--J5qK8c/j+dsQwcO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXeFiUACgkQFA3kzBSg
KbY1UxAAs23gIOVvLkCmeyrbAAN7i3d7cIQP2kzKq9Z4iouxjZavNTtUoLQI3Dkk
i2BhJMPBbngmCwt4X+FDvI5qNRbBLNmX11fyuXpND15iRR6dPZ4jPm7VvMBxy62h
CrNy9H6KK6ydfsaaRCKZvx6SuvcRcPd+rZeHSFLh6/3ESldx7JA/dAtCsFI6KUxF
58lIqJZg++rAfqxaa2lJJFu180EMRcJzRmGx/c14ySOtYszfEU/KMnSFxdLlStBu
S74TiQ8Aif+WUILLavWSCBiXJ3L6eiba+0fS0m+68z3x4UbpiMX8J1Zs4wq0TF+I
wkPJl9iI0EhNZCy2T0l+iAFCBkLG84w9iyd3eQuTyp6Wl2y1jlbw7B4h57P/8CK+
SWI/E6NdS3Gda5CwQw4zqAMlTv1VaJXpOlJv4MohCy1VfzaK/q/9bR9w9WVFOf0T
N4ub2OU3EmKrLvxZfJPPbWgSNsS4zuDrZ1EoC7LYP7+Wx15ktYux9a8pRNC2RwhL
xrRYAR7lPkZwz3IVgrhAFeIssOsWD0C4qOeXvX27cd2mqnDa9xWHIGd1ZEAaiLm7
5tbuk7aF9qizAL35XAeM7/zZnIvGGNDPeu696we834v6Ud5ThnMqjVTnmDgdBT6h
ftuE2WjABe5yP+zBZtKDrNFl0Cf1UtJ6DXn7TyDGkdV1GB0IYBk=
=PXn7
-----END PGP SIGNATURE-----

--J5qK8c/j+dsQwcO0--

