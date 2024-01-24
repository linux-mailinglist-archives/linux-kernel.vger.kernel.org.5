Return-Path: <linux-kernel+bounces-37623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD283B2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E81C23022
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CDD134731;
	Wed, 24 Jan 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIXWtyFH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C6133985;
	Wed, 24 Jan 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126562; cv=none; b=iF8NcSRmX5jYJfEKs2DSY3wb2nvf0BvuIrnHMxBn8K3c1G1gYmsKf6wwbrWx/SGKAxc1mLDlyaIDtOT8FgiUVOj6p4O59UwZdAarm+Za7iscpku3F2yhWWc3c6Ql7zwPzewIvCAKsR9cdyBiJo1NO8gxVHryMUW0IO0Qr42y1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126562; c=relaxed/simple;
	bh=jfXWrPM5ALhDnKgFnFkdz4CMio32hmCt3xWSsf12HKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C57I24B3iGHxq4RC1uR7Z4VOqayNXANOWtpZUKYn/jWdtALZMmthT64kMeDRf+r5j8VM4gqMsyADXVZqlj+XzBYowmN0G/oEOP7N4OPbfF32hOAuymA8mvoJUEPk/uZjeb5+EVmjchaXdsDD3LOKC9Sks3n+UKF5BI9SgTDN6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIXWtyFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9C4C433F1;
	Wed, 24 Jan 2024 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706126562;
	bh=jfXWrPM5ALhDnKgFnFkdz4CMio32hmCt3xWSsf12HKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIXWtyFH5yxUa2sKS25qW3wOvsP8Ed2klnxIK0jQEvMXqnYVHZWCU0zqLjO7+ilCR
	 JWdnVZmbglYShezSvqIcZWDN/Vh46HywERZIGBwdalc9QELX9rTL+upLtWfATkdWgT
	 WOJSdLKuC7J9/6NYjh+DNGAalqkPr+gBHAK+jK1uAFFeeu8RJwLSBlu58kMYFUoEl1
	 Yp7MPDfACwXPwjaV1u4/U968HoLm30T94Tl/mdr2QRYc4fOG1E9E30BuK8sKFpJ4U8
	 n+9CHV5JSYN6y7zhCegxJ1IM+OVstyfug/6ZJ17Jvqz0l9lgm0LjUJl94LQR9K86D2
	 ni5ld1wGOGq1w==
Date: Wed, 24 Jan 2024 20:02:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, Moritz Fischer <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
 <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Ulf
 Hansson <ulf.hansson@linaro.org>, Rayyan Ansari <rayyan@ansari.sh>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Martin Tuma
 <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-media@vger.kernel.org, Sergey Kozlov
 <serjk@netup.ru>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Yang Yingliang <yangyingliang@huawei.com>,
 linux-mmc@vger.kernel.org, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Heiko
 Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, Amit Kumar
 Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
 linux-mtd@lists.infradead.org, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Simon Horman <horms@kernel.org>, Ronald Wahl <ronald.wahl@raritan.com>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, Max
 Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-arm-msm@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>, Amit
 Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Viresh Kumar <vireshk@kernel.org>, Rui
 Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>, Alex
 Elder <elder@kernel.org>, greybus-dev@lists.linaro.org, Peter Huewe
 <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Herve Codina
 <herve.codina@bootlin.com>, Alan Stern <stern@rowland.harvard.edu>, Aaro
 Koskinen <aaro.koskinen@iki.fi>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-usb@vger.kernel.org, Helge Deller
 <deller@gmx.de>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/33] spi: get rid of some legacy macros
Message-ID: <20240124200207.7e02b501@jic23-huawei>
In-Reply-To: <20240122192343.148a0b6d@jic23-huawei>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
	<e62cdf7f-ce58-4f46-a0a0-25ce9fb271b1@sirena.org.uk>
	<20240122192343.148a0b6d@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 19:23:43 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 22 Jan 2024 18:18:22 +0000
> Mark Brown <broonie@kernel.org> wrote:
>=20
> > On Mon, Jan 22, 2024 at 07:06:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> >  =20
> > > Note that Jonathan Cameron has already applied patch 3 to his tree, it
> > > didn't appear in a public tree though yet. I still included it here to
> > > make the kernel build bots happy.   =20
> >=20
> > It's also going to be needed for buildability of the end of the series.=
 =20
>=20
> Ah.  I thought intent was to split this across all the different trees
> then do the final patch only after they were all gone?
>=20
> I'm fine with it going all in one go if people prefer that.
>=20
> My tree will be out in a few mins. Was just waiting to rebase on rc1
> which I've just done.
>=20
> Jonathan
>=20

Dropped from my tree.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

