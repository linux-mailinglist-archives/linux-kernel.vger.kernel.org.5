Return-Path: <linux-kernel+bounces-53037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3D5849FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05061C21A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855C3D558;
	Mon,  5 Feb 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="XS9v4CKu"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB53A1C3;
	Mon,  5 Feb 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151702; cv=none; b=POJbxcdYO85dfmOmPctM3A73CadGcRBqUUPlMfoRdhSeI0Jhx734eePrxymJpuJb7TV/7wCwy3pxJr+d5/6XFWAuJMJvf4+tRZb9MBHXpzVkQEwqOFsUS9lqbE6DR+wn9ZFNHmRkDp+ils3wCPC41nuuwlz3fWRtsSk+JULjlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151702; c=relaxed/simple;
	bh=rypfT/kD5L+1VJyGe4VKW1ttuWQxYs5lhHHbn9d071s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1dSRRDREtZu4h20oEzkKXWVx9D9qy18xQRpxCfQlJlt1n1lXb1rn5RiwTtxEWwDmUmPCHCWnMZ5vA1SaAva8bo3aBEdmAwhLihaSYJdHtoiy58vHO46kVU8Pm/sQSn0mTNSsM2q/B03anGQ94kZSXgTSvtBEsgRVjhgNrX6Gwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=XS9v4CKu; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0CC77331873;
	Mon,  5 Feb 2024 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707151144;
	bh=rypfT/kD5L+1VJyGe4VKW1ttuWQxYs5lhHHbn9d071s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XS9v4CKuRQqHcvD5X9jRzINdXBIOSx2cEZNrDjIU4AldWKo0mRSxvJom2hjrPGtyz
	 tYvB44syszDm3W/VPWnibo/PS9uEn7w7K73xhu+7xpAJMjfcS88gJDnxtdHvSoHZWw
	 D694Hgdv4HwxOBvuV8rvQw763gomfhHl0GzRAPWE=
Date: Mon, 5 Feb 2024 18:39:02 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <ZcEPJh1i7cc0xyBW@sunspire>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
 <20240127160405.19696-5-petre.rodan@subdimension.ro>
 <Zb-1UGJt27OV-vjc@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IYwKfNCRI6ua9wNH"
Content-Disposition: inline
In-Reply-To: <Zb-1UGJt27OV-vjc@surfacebook.localdomain>


--IYwKfNCRI6ua9wNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Andy,

On Sun, Feb 04, 2024 at 06:03:28PM +0200, andy.shevchenko@gmail.com wrote:
[..]
> > +	memcpy(&data->scan.chan[1], &data->buffer[2], 2);
>=20
> Hmm... We don't have fixed-size memcpy() :-(

	__be16 *ptr;

	ptr =3D (__be16 *) data->buffer;
	data->scan.chan[0] =3D *ptr;
	data->scan.chan[1] =3D *++ptr;

is this an acceptable replacement? I do not understand that your concern wa=
s, my
intent was to copy exactly 2 bytes over.

> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > +					   iio_get_time_ns(indio_dev));

thanks,
peter

--IYwKfNCRI6ua9wNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmXBDyEACgkQzyaZmYRO
fzD5aRAAyEwbN+bRogoQcgxhxBjDkfJFOodGLosVP/2TDfSoS4LpPphpuDORkEcX
BpIXgVxh4qCyI8nzrXFH01+N9PQvi+ZtC6nw6xBA/64Jf3JJGZPjdlrcwHmCP/H8
9dVfiZj6n3LcUw5ojzyZZbIsAPMq/BPXiNXdRk+rW4VUH12NNHykA95Wrejk+J6g
vsoSo/Bz+5Z2uZBzKAX9YOtCegHW5RQ++WnZ/4YKvdWTdHVkXGBoHVfGAuil7RWY
Q2rORin3ihDOol2KWVgC3zTgZrc9OkBWw+mDT1SD+Z2g1tdnzceMuQFkPBVL8Iti
tEdVZ8aaXm1yJ7GgpzPEG3rPp5Pig02zBW3jWoz0plIpVDQzJxPhLVCCvpEKCvaL
nefniFzg9KbK215rFGZKwR5VYla8EK9tSIaz2XFfvzKzSSC5UmFs6Hqtfwew/k7m
GcPeyKZxcGJGgkbkvdXaBGNgmXpht+1Mg/C8ya2TVaA1ytTs8GO3T8W7bKlo2EGx
OQkXGCUyXkhNq7PIxdAxngjeBGVby8FgxE9eZqyqvwngDZkZhAuABsalvc80N1jN
NZvUSgcHXAU3tvj0SpKHWEGJmCBom3D+fV6nn74YVnfRWYoso15EKoF+j/9sPjjj
qoylAXZL1mavW/DlS5zrAxv9Y/HFmF5M6Ga13NPfnJ+StJNv7Xg=
=XpUp
-----END PGP SIGNATURE-----

--IYwKfNCRI6ua9wNH--

