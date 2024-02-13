Return-Path: <linux-kernel+bounces-64324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F71853D12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6EA28B361
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E662817;
	Tue, 13 Feb 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYjotN8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9F62807;
	Tue, 13 Feb 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858997; cv=none; b=piBk7CNhRY0PDt/onrtgLstd9GmSmey6zqmocOfqS6vayiTSeQI6CnDrawsR3dmUNgojjPQ5AiPEdZcwKE++8nmfav6/wkuVIlQxnmqvwF6NvlyyQJV+C+QWJMaJaXw1bI1WAdCpiU7SqQaxTEfZOQWodHQK8cqbg/3z1Ic1FxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858997; c=relaxed/simple;
	bh=zDKhA64ioM9k5pqN+62pwEEnbtSLyu6ONrO3J1sfrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8cIsowVPkoBhuSDBdRUjjVKOpPGP58LJNr3IEU3Yt7GoL9a/wPzDrx2CZftCg9KSwGof6ZYbSgiBIBJn1hLasrpj9I0yeSVtR1VRqeGLUC4DwvG2TMm8XgCp1fAqmHc3T0TbblMtebX2qrnKF3aH7DaDVNlnMWkNoxeWeOA/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYjotN8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F299DC433C7;
	Tue, 13 Feb 2024 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707858997;
	bh=zDKhA64ioM9k5pqN+62pwEEnbtSLyu6ONrO3J1sfrbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYjotN8BKSn1n4vhKp8wGMbnWZZHynYaLNNynbcu9tsPrJ/uWYW23Wb97x46SVfx6
	 p+VMv9qxj3TNhJbYtNBmHK1+31zQf1TbWxJUeqMBLz3mcWfNSDt4I6tNdIpRLmfqoi
	 x0dst/jIYbftsUPahQ0dFO62hkXUqB2znVutv1GB/m+rEanVivasSz80sj/+b9DmYX
	 /wnYmturKmh8TdRNYkILwYqfGgUX7DEkRZWN/A+N9p0kMpzlPPeBQeMXJPzr5gGvHl
	 UFXRabHGO4Ic9KMVJMDLJp1PnSmbwwZGVtDD+sNg3DJWNNUPV11bhIwl6DA7jnVYUc
	 rzb3EkucHNabw==
Date: Tue, 13 Feb 2024 21:16:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 07/24] gpio: protect the descriptor label with SRCU
Message-ID: <2ab076da-a4ea-46d5-874e-854a7d6efb69@sirena.org.uk>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-8-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hx/I//qx/IsDQLMA"
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-8-brgl@bgdev.pl>
X-Cookie: In specially marked packages only.


--hx/I//qx/IsDQLMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 10:59:03AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> In order to ensure that the label is not freed while it's being
> accessed, let's protect it with SRCU and synchronize it everytime it's
> changed.

This patch, which is now in -next as 1f2bcb8c8ccd, appears to cause a
boot regression on imx8mp-verdin-nonwifi-dahlia with arm64 defconfig.
We die with an invalid pointer dereference after registering the GPIOs:

[    1.973513] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    1.982467] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000078

=2E..

[    2.161467] Call trace:
[    2.163915]  check_init_srcu_struct+0x1c/0xa0
[    2.168284]  synchronize_srcu+0x1c/0x100
[    2.172216]  gpiod_request_commit+0xec/0x1e0
[    2.176496]  gpiochip_request_own_desc+0x58/0x124
[    2.181205]  gpiod_hog+0x74/0x140
[    2.184529]  of_gpiochip_add+0x208/0x370
[    2.188456]  gpiochip_add_data_with_key+0x720/0xf14

and a bisect appears to converge smoothly onto this commit.  None of my
other platforms (including the i.MX8MP EVK with the same SoC in it) are
showing similar issues, I've not checked the CI systems and haven't done
any investigation beyond checking that the commit does look like it
could plausibly be related to the symptom.

You can see a full boot log at:

   https://lava.sirena.org.uk/scheduler/job/579038

bisect log:

git bisect start
# good: [7b17b1384cd6454c4ea2744c8e8a06de0d27b5b3] Merge branch 'for-linux-=
next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good 7b17b1384cd6454c4ea2744c8e8a06de0d27b5b3
# bad: [46d4e2eb58e14c8935fa0e27d16d4c62ef82849a] Add linux-next specific f=
iles for 20240213
git bisect bad 46d4e2eb58e14c8935fa0e27d16d4c62ef82849a
# good: [f85363faaa040a9b9ac6502464a8b1ed7f711eab] Merge branch 'master' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect good f85363faaa040a9b9ac6502464a8b1ed7f711eab
# good: [0ca88723ff14aa0a28d31772ef330f3eef97cba1] Merge branch 'next' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git bisect good 0ca88723ff14aa0a28d31772ef330f3eef97cba1
# good: [c9545b54561efbedfe184a97dd07b4cdd8176146] Merge branch 'usb-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
git bisect good c9545b54561efbedfe184a97dd07b4cdd8176146
# good: [4e22a2de97fb3b37e241058a4f9b91f3245590ea] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
git bisect good 4e22a2de97fb3b37e241058a4f9b91f3245590ea
# bad: [903a65bcdcda676e86b1504f909c6565b1bd9df2] Merge branch 'pwm/for-nex=
t' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
git bisect bad 903a65bcdcda676e86b1504f909c6565b1bd9df2
# good: [a3468cca30fe896b58f9f7b3bb5484f079010a12] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
git bisect good a3468cca30fe896b58f9f7b3bb5484f079010a12
# bad: [7fe595b3c3cf3f9b8f21fce72f1f48a2cb41522e] gpio: don't dereference g=
dev->chip in gpiochip_setup_dev()
git bisect bad 7fe595b3c3cf3f9b8f21fce72f1f48a2cb41522e
# good: [f57595788244a838deec2d3be375291327cbc035] gpio: vf610: allow disab=
ling the vf610 driver
git bisect good f57595788244a838deec2d3be375291327cbc035
# good: [ccfb6ff4f6c0574e01fb16934fb60a46285c5f3f] gpio: don't set label fr=
om irq helpers
git bisect good ccfb6ff4f6c0574e01fb16934fb60a46285c5f3f
# bad: [b6f87adbacfab9001d08e56ac869e1c75734633d] gpio: remove unneeded cod=
e from gpio_device_get_desc()
git bisect bad b6f87adbacfab9001d08e56ac869e1c75734633d
# bad: [2a9101e875bc3aa6423b559e0ea43b2077f3be87] gpio: sysfs: use gpio_dev=
ice_find() to iterate over existing devices
git bisect bad 2a9101e875bc3aa6423b559e0ea43b2077f3be87
# bad: [1f2bcb8c8ccdf9dc2e46f7986e1e22408506a6d6] gpio: protect the descrip=
tor label with SRCU
git bisect bad 1f2bcb8c8ccdf9dc2e46f7986e1e22408506a6d6
# good: [be711caa87c5c81d5dc00b244cac3a0b775adb18] gpio: add SRCU infrastru=
cture to struct gpio_desc
git bisect good be711caa87c5c81d5dc00b244cac3a0b775adb18
# first bad commit: [1f2bcb8c8ccdf9dc2e46f7986e1e22408506a6d6] gpio: protec=
t the descriptor label with SRCU

--hx/I//qx/IsDQLMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXL3C8ACgkQJNaLcl1U
h9A33gf/a2HntqcvzKA2Zfjsu+PvShEl3wuajDAUtGzuthiF8lMiT1XFJQA9b+a3
YiXcA44uBIPsEb4i2vVG/BaSHrPJ81YPjCmGmNVwL/46nvp42X0y6i+KM9v+b3sx
+4eAN5ChJ3MJCkkeABIUmQQn5Kte3+oQpTktv+GaUijuIT7K2GuEWRcXS3HTJK1c
2w4DT7ceEKAfW+XKhJoFxVSXIS3hqFDgdLuYRTunT5pxEOZGrdnI5e6L90DvPRJM
PGkdTZqph6o2rHf5UoSHpD3+Ud9n98dZiwcwahFb8wQdKdDXjcLezTPKvN+3Vu1+
HWl5FdEDOHC5yaS5UxS1Stbr4qsUhQ==
=D/G+
-----END PGP SIGNATURE-----

--hx/I//qx/IsDQLMA--

