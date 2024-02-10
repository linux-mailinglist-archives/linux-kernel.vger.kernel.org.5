Return-Path: <linux-kernel+bounces-60481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44171850577
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94301F23B70
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4DA5C918;
	Sat, 10 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF+DfxKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E25CDC2;
	Sat, 10 Feb 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584017; cv=none; b=Jjh7m3/hecSzP0BvaImFm6hFCY77uAsk1YMkw0H3F+hUYcQ0+7Lb5mmXiDBX5H42MQbZJfyQpllTcb3ylYmBUs86nDzuJscYwIC9PXpfvhUVeNc8m3ongbWDDGUeEZzM+G3GNXBvfVR8ay23S1z7HxZ6GUTOZoFvY49oFGJhYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584017; c=relaxed/simple;
	bh=Qj7DoYcKqdsQC8NTzQop4/PVEkDoZoq1GWacI2BcOWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3PiDceU11sCTi+/FGlmw0AnqCZQWX60Hry0Es7fCIDzWZ2aB1KwAixqzKodfdACAJg9g1wtJtQ37PRG9pwkxm06jfn5dK+YW01q2OlqkivR9bi486xunSwGygDFP1ahuOxbYZwkARsnGuoWzbuZiJWIGUGujzJewD8L9HjLgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF+DfxKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B5BC433F1;
	Sat, 10 Feb 2024 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707584017;
	bh=Qj7DoYcKqdsQC8NTzQop4/PVEkDoZoq1GWacI2BcOWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PF+DfxKDlpmpFv07iP1Ip6cumCCIQ2aJkk8EKwEJYX5ZBvvYMLGrsSS3nTq4gFjZN
	 bpZnO5fabwlXBo3kRaBTnRfK16BHfMrpEyKEyzdRKKo62pmNQ++gbGbjfZkKutcEep
	 gdnaA9TevUPVO4LWpC8kRVa//XhGMUgRMUlQxShTz+sF+JBNx/KktrUeTezwxSEzSY
	 OYFJe/aZncr898m+Bnat567lWTy+VqpermKTXTOQ+odvM82MuUTlRUR4pvrudjS9Aw
	 2ac8oOmz7SMLg1yxB9bqWAUnOHrHiha1myFv+/2cF2PYf/WjSHr2x4Wd2E5KO7LfUd
	 37BzyLeEoty3w==
Date: Sat, 10 Feb 2024 16:53:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Cosmin Tanislav <demonsingur@gmail.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen  <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4130: zero-initialize clock init data
Message-ID: <20240210165325.6aa34d06@jic23-huawei>
In-Reply-To: <fd81a6127a9b7abb6eae0785281836a238af8b57.camel@gmail.com>
References: <20240207132007.253768-1-demonsingur@gmail.com>
	<fd81a6127a9b7abb6eae0785281836a238af8b57.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 08 Feb 2024 09:15:08 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-02-07 at 15:20 +0200, Cosmin Tanislav wrote:
> > The clk_init_data struct does not have all its members
> > initialized, causing issues when trying to expose the internal
> > clock on the CLK pin.
> >=20
> > Fix this by zero-initializing the clk_init_data struct.
> >=20
> > Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
> > Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Both applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad4130.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> > index 53e19a863198..c7df499f9775 100644
> > --- a/drivers/iio/adc/ad4130.c
> > +++ b/drivers/iio/adc/ad4130.c
> > @@ -1794,7 +1794,7 @@ static int ad4130_setup_int_clk(struct ad4130_sta=
te *st)
> > =C2=A0{
> > =C2=A0	struct device *dev =3D &st->spi->dev;
> > =C2=A0	struct device_node *of_node =3D dev_of_node(dev);
> > -	struct clk_init_data init;
> > +	struct clk_init_data init =3D {};
> > =C2=A0	const char *clk_name;
> > =C2=A0	int ret;
> > =C2=A0 =20
>=20


