Return-Path: <linux-kernel+bounces-33964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258E8370FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243F92829C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF559B5B;
	Mon, 22 Jan 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8fifh16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E73DBAB;
	Mon, 22 Jan 2024 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947523; cv=none; b=qEZOgSEFJXjaKNxE87CRy/SkohIrSozxB91koJUj/XpLifCa9QMcALm56DkXKhwv380yANeyGj7lOSRK4sZmKP9xO0/fzJ9TiYdDt2Q+Phr+HN0Pdg4X1ivbQh5/TUvYo4MatvjREfibdBghksCD1Fh7GSsg+kxRrnRNdL5Z38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947523; c=relaxed/simple;
	bh=McOauSyMQNxtPZ0g7TEpEiNFuLd+iPYfNexDMsX/FI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvbDUZPsH/VZPN2Ia6l7KpBEVdMu4clKpDNnOLPhtVK7ErD96AHrvD0zeM0V2YbtEKNYJ+nL4byKWBd2RKU/zjTKs2c7aljVoIHBFGo6hWSGSkRA32YrysgZJ/Vrt5g3lidz61ffXph01lv+ExR3uRTpHf0bm+Q918mGcPRxn88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8fifh16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84691C433F1;
	Mon, 22 Jan 2024 18:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947523;
	bh=McOauSyMQNxtPZ0g7TEpEiNFuLd+iPYfNexDMsX/FI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8fifh16cqrlBPFhmdK0/1YCmVp+FCQJRM3mcc61e8B54POXfNtNHCezXLI06U+BW
	 2HyC31K2GKN8pqxyPoe5eH43Wr1IvzJ4qYvgVKrZ28cOHRapgl4U0tO7nRd1Hg96Gu
	 /I85mPr8fKbNlof8bDAKADfRcHtOpPxmy3YbesJ0DqFFZ2OTYAI+xKJ3khkG5PRPqb
	 IkZ7Lha5tDCBsHZjVT1Pc0QMwPbNJ0JMPGxW7jUMjEknv7bvXLCARAShkNA8Yp5eXw
	 Jxu0Ft8Uip4jzu6W9VwfTzuvxciZJpio1DrdN7XFmAH69ub0PysqfBMv84es2fWtex
	 o4y4YVecDwVTQ==
Date: Mon, 22 Jan 2024 18:18:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	linux-mtd@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, Max Filippov <jcmvbkbc@gmail.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/33] spi: get rid of some legacy macros
Message-ID: <e62cdf7f-ce58-4f46-a0a0-25ce9fb271b1@sirena.org.uk>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+I3YsJdHvT4lja9"
Content-Disposition: inline
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Cookie: Nice guys don't finish nice.


--T+I3YsJdHvT4lja9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 07:06:55PM +0100, Uwe Kleine-K=F6nig wrote:

> Note that Jonathan Cameron has already applied patch 3 to his tree, it
> didn't appear in a public tree though yet. I still included it here to
> make the kernel build bots happy.

It's also going to be needed for buildability of the end of the series.

--T+I3YsJdHvT4lja9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWusW0ACgkQJNaLcl1U
h9AR1Af8DbPI9TFuBXKEh4BM61G07z/XXFesQgMYJFn7hnO/3qPq0DB2udfdH+HR
WrEFwWfImJcLCzV8lyZSjyQS8FeUMRbP7r99FeoYIb8amMJfpQIN7gD1IJ+OzZGL
9PhsdsnLY3FgKjHbQCA6B6TnEDwI/0zpTfNjtElcXbWRB+V9uqBR/i8Uk02ngrKd
MFM4BWy/tlEQvi0AQcylB9znY58FISMxd4ww1jeW0euV6Do4c1U3/9N+ivg6WNfs
rKxD/BMTdGNcwlR3dWzHBLLYk3YAMLSi8p37kFSHwDGoHFtHCuUNPhA4RsVlbb9P
SyEM0rudlzp/uFBuKSBT2nWslCLfjA==
=Dr9Y
-----END PGP SIGNATURE-----

--T+I3YsJdHvT4lja9--

