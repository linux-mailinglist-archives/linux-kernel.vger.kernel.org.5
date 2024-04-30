Return-Path: <linux-kernel+bounces-164050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FB8B77C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688D82839BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E848B172BB5;
	Tue, 30 Apr 2024 13:59:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207D168A9;
	Tue, 30 Apr 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485582; cv=none; b=KiHfgBy2FYSgfmRKqi0u2iRA/NtUD7aCfagscwRJyiZ1fL1e1gtr4JsrFXaa4MubRo020NEuz7l2RiN6AoHdXVLixPvThFBP0OsBTkyyrAayNNM6MHNwuis4IENePn2Lty4yqo7JH2IYSW/YrZ07KWKiVj4lukPylciIYfIWKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485582; c=relaxed/simple;
	bh=BF/HcpVihLl6z0OazbQoAOflp/oOteZiMrbMpBDAbOA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn0cAGwmj1f7KGAv4Ebl25v08vxlrPp53Um2EsnZBJlMm1ISevzeB2ko0owpq+Y1NnW6pASaecbKt1veLsSSZs4/x5NDD1EcQXqgCrOZrV017DUZdepEnJgubkzor5ypCNe4WRv0GDsPGqL+QYXpv92JPBW/XTuFoUESa0aLDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMJ70qSVz6K910;
	Tue, 30 Apr 2024 21:59:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 946DE140A08;
	Tue, 30 Apr 2024 21:59:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 14:59:37 +0100
Date: Tue, 30 Apr 2024 14:59:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <marc.ferland@gmail.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Marc Ferland
	<marc.ferland@sonatest.com>
Subject: Re: [PATCH] iio: dac: ad5592r: fix temperature scale
Message-ID: <20240430145935.0000055d@Huawei.com>
In-Reply-To: <20240430131330.1555849-1-marc.ferland@sonatest.com>
References: <20240430131330.1555849-1-marc.ferland@sonatest.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 09:13:30 -0400
marc.ferland@gmail.com wrote:

> From: Marc Ferland <marc.ferland@sonatest.com>
>=20
> For temperature readings, the remainder is returned as nano Celsius
> _but_ we mark it as IIO_VAL_INT_PLUS_MICRO. This results in incorrect
> temperature reporting through hwmon for example. I have a board here
> which reports the following when running 'sensors':
>=20
> iio_hwmon-isa-0000
> Adapter: ISA adapter
> temp1:        +93.3=B0C
>=20
> With the patch applied, it returns the correct temperature:
>=20
> iio_hwmon-isa-0000
> Adapter: ISA adapter
> temp1:        +30.5=B0C
>=20
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>

IIO temperature units are milli celcius, so I'm not following
the argument here.  The driver might be reporting in pico celcius
I suppose?  Call out that this is the scale factor though, so
it corresponds to 1LSB hence a small number is certainly plausible..

Reasonable to argue it's taking the integer and dividing by 10^9 hence
INT_PLUS_NANO is the right answer, but it isn't nano celsius.


Jonathan


> ---
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-bas=
e.c
> index 076bc9ecfb49..4763402dbcd6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			s64 tmp =3D *val * (3767897513LL / 25LL);
>  			*val =3D div_s64_rem(tmp, 1000000000LL, val2);
> =20
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_VAL_INT_PLUS_NANO;
>  		}
> =20
>  		mutex_lock(&st->lock);
>=20
> base-commit: 98369dccd2f8e16bf4c6621053af7aa4821dcf8e


