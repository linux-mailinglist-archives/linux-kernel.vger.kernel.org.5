Return-Path: <linux-kernel+bounces-65260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3000854A40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25741C21FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E88535D3;
	Wed, 14 Feb 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY3bpbnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95A524D1;
	Wed, 14 Feb 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916638; cv=none; b=cfBBJxbQIEQtwa1hLU0ckbJnwA0OEsFvIEq5H2moKivD8uk8y64ItB4kAjsNHSfK5qLTEQedSOzePwO+MrXZ7DreoDcTR/Vu3MfJoRwwbpXwJmchYc256Dk23Lnzdmg3Gn4AVyJ61lPvVhboA2Cdsd48rmV+kfV+PnGwweVqDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916638; c=relaxed/simple;
	bh=UApSOBR43ZErywnbuS/xYxhg9vy8q5S6orxIgMpHkjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW29ziUo1VjvOP6s3LxYUKniupStqGUDndSitPrdQr3dr8avAronbZxDD/lgzcnnAanAnZ9Qbe8+7Lk1o5W84rhTAv2JyrN/NHigFXIiOvlmnQJwUoXNsnsieo4M0uXKwjM42X8zCTh0MEcZ5EcVjCOSMzPf+zWPY4+cJmxy3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY3bpbnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D65C433F1;
	Wed, 14 Feb 2024 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916638;
	bh=UApSOBR43ZErywnbuS/xYxhg9vy8q5S6orxIgMpHkjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TY3bpbnNhie8GtyO8aiz0eioHSdBBP/douxMvsSJ09YBRQbmZPZTKLOQRfmtrWoc2
	 W78REzwGHDKhHj16IKbu/1TNsVztq32er0FxP+/Y87TE273Kavu+W41vZFKnfnFqJ/
	 adOMbNhOnmp4sKuCSJeUhtf8iAVkKCRUS6w8A9Qt4EkDVoM9059pYqjNIE/IlObdzT
	 Ch4bnEQ9wcz6hqxpQPU9fBBb9CtuVIyt4gRy8MXREW1dcpk+UJm8sOy29p54URpcH5
	 iy46+lIoLovquQF/6kUMnwjBLZ4FX7eTffaQTxnBS/IlfbXLrAkdrl7y6p2e5V95kS
	 Om0g5uXb/YjTg==
Date: Wed, 14 Feb 2024 13:17:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/4] gpio: fix SRCU bugs
Message-ID: <4c629a0b-95ff-4ad6-af04-61b25d437f89@sirena.org.uk>
References: <20240214084419.6194-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PHKFQMsyP2YjnSWd"
Content-Disposition: inline
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>
X-Cookie: Available while quantities last.


--PHKFQMsyP2YjnSWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 09:44:15AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Here are four fixes to some bugs in recent SRCU changes. The first one fi=
xes
> an actual race condition. The other three just make lockdep happy.

This doesn't fix the issue I reported yesterday when applied on top of
today's next:

   https://lava.sirena.org.uk/scheduler/job/585469

[    1.995518] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000078

=2E..

[    2.176162] Call trace:
[    2.178610]  check_init_srcu_struct+0x1c/0xa0
[    2.182974]  synchronize_srcu+0x1c/0x100
[    2.186904]  gpiod_request_commit+0xec/0x1e0
[    2.191183]  gpiochip_request_own_desc+0x58/0x124
[    2.195894]  gpiod_hog+0x114/0x1b4
[    2.199305]  of_gpiochip_add+0x208/0x370
[    2.203232]  gpiochip_add_data_with_key+0x71c/0xf10
[    2.208117]  devm_gpiochip_add_data_with_key+0x30/0x7c
[    2.213261]  mxc_gpio_probe+0x208/0x4b0

--PHKFQMsyP2YjnSWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXMvVgACgkQJNaLcl1U
h9DroAf/eoRSfe3T0pX2R2UAPt8d7/BSID9HbANJ6umEl9wiMdKWZLXBBle0rNVJ
/GXxwUVieNoywwrzqFjXXVeYkT889xYplvblstaBjiFl0W2FpM+ab09bhIuF/7Vc
SyN0fDZ9uxPZZBNboXagkMIL2+lTdGAPWZSfABNM+HUPiQBhLU3XxBbYS1KqB0XC
RlifSVRr9K0FBN7Wws/u2qNRt0deopzIKXSDyiZLYjCmoYLrUTV3VyGYQK0vOoX7
oit/bnXUgIo9s4Td0tebiRxke7JtX3avSnlBPG2Urr5+r3/kFRMfaBPWifXtuvay
CkzYCKvSBl8H9nmicCjCZzyY6CMpdQ==
=bF5W
-----END PGP SIGNATURE-----

--PHKFQMsyP2YjnSWd--

