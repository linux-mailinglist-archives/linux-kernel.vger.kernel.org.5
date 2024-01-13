Return-Path: <linux-kernel+bounces-25321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FF82CD77
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF461C20E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA551C16;
	Sat, 13 Jan 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phfmKvGO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839428E2;
	Sat, 13 Jan 2024 15:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FD9C433F1;
	Sat, 13 Jan 2024 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159608;
	bh=GZOOYpS2BDc6sZ47irtIxIDYwOaj+XK3lmlpTNGheQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=phfmKvGOFhCjk+GnkdfpsN0zB/O/g9AQ5M2LmxAraHo5G4kdp5cDRrtw4lsKUj6/d
	 29WoDulSC5dxrEZlVt/uJgFF3IDAqhA30orNjGsSUt/a/ca40snVcSL4h94W2q9UUR
	 agVz9SfLgaTiOl2ntmII9VcC3AYjkLKhO7KM9HLh4oKElBx6dfrdmBNtDCk1kPciRV
	 eZjQcgYrksRdZl1Y1tuyC6oqpXbF1fdNfL19U+MU6+k164IMHmej05l7iOm5cldiix
	 42wkSrRUwq+ZlwDx3EkVlJWiijYOysGqL1Yy/2kjfANbGkk5njWY/q8tIfpBi0G6sz
	 z01LdEuuZ8hyQ==
Date: Sat, 13 Jan 2024 15:26:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: use INDIO_ALL_BUFFER_MODES in
 iio_buffer_enabled()
Message-ID: <20240113152643.242c5fd5@jic23-huawei>
In-Reply-To: <d927b0b761eb7105d2193d9dca48f2c6df8868b7.camel@gmail.com>
References: <20240108200647.3916681-1-dlechner@baylibre.com>
	<d927b0b761eb7105d2193d9dca48f2c6df8868b7.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 09 Jan 2024 15:07:57 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-01-08 at 14:06 -0600, David Lechner wrote:
> > This replaces use of individual buffer mode flags with
> > INDIO_ALL_BUFFER_MODES in the iio_buffer_enabled() function.
> >=20
> > This simplifies the code and makes it robust in case of the addition of
> > new buffer modes.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> LGTM,
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for all t=
he
normal reasons.

>=20
> > =C2=A0drivers/iio/industrialio-core.c | 4 +---
> > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index c77745b594bd..8855d377d710 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -210,9 +210,7 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indi=
o_dev);
> > =C2=A0
> > -	return iio_dev_opaque->currentmode &
> > -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (INDIO_BUFFER_HARDWARE | INDIO_B=
UFFER_SOFTWARE |
> > -		INDIO_BUFFER_TRIGGERED);
> > +	return iio_dev_opaque->currentmode & INDIO_ALL_BUFFER_MODES;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(iio_buffer_enabled);
> > =C2=A0 =20
>=20


