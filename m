Return-Path: <linux-kernel+bounces-121894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94C88EF07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B162C1C34858
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89459152508;
	Wed, 27 Mar 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iDGCHKto"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECC14F116;
	Wed, 27 Mar 2024 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566808; cv=none; b=GDDnZhMI3Dta07ih4qDnZbUcrYcMjLCFaOv9OYsRKKF7VExuICM0p8pSqb6CYPP4BiOEzsyMjYzvtsye4gJbDK0UraWXIut753jwsNK1QNH5JGmtimwcseAMiAg5olNizVOWbnqWrpyV9/FKae6ioaCe/uk2+ikXzcMJASrmIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566808; c=relaxed/simple;
	bh=GiBvZGM5d+MJ9nL+XKeF311lIglVFwLbNL8+lh9qVog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKS2LKAYGN8gN1DYiMwjQz16oTYqObbM5Vrz7E6YBBtauZCwZHOIzAApUf/PoMad0gtLi0ZstFX7r/RCEIS4ZOFuoyywjFmfeEwJHDJQEfmtFBINiLi5CmTEgjfh0YPlMbsMBdVmrtxK/5r4XdH4RA7XtHNFTJk7NNGYbqTTHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iDGCHKto; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711566805;
	bh=GiBvZGM5d+MJ9nL+XKeF311lIglVFwLbNL8+lh9qVog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDGCHKtoN/WGgRDfzhPHfQ4Ets+5rW/KMANIGd5fysyNxdDG2QsMcP2sePtGKV6YV
	 XlFr7T/MqmMppB/BJkHWfepXlTbO62dzdCe88ikh//Ou8Cpti44rhNCTRtCQDfwe3B
	 LgDfSrYUNRgLfwjRvuHhCoOs8BWYy/kEzQF95ArUrOsN5oZqPr3pzWiBFES46Bmjni
	 /CNOqNQdiA9RGI5PG6u5jh0pX95XZMQ+8bnsqRQOb51r1H7fHn2NALag+47FVGZPwS
	 90tIc7EqcwTuPEtoB5SqqUbYKyH8IM/W9hqUavyDsjKA9ZBK68Ab0FkuUpkCEx+a4m
	 QBZEvOllLL8oQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9270B3782112;
	Wed, 27 Mar 2024 19:13:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 091EE10608D9; Wed, 27 Mar 2024 20:13:24 +0100 (CET)
Date: Wed, 27 Mar 2024 20:13:24 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Message-ID: <awrqnnmesuzhfowt5ewnur4snndcrhroymgb74wc2tfdwn7bdi@pwohlf77vcko>
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
 <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
 <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>
 <daactalkmzucga47cmncjkgnxyppouqnrj3vtsz34d5edrkmzu@p32ylpv3nqwx>
 <2e4f42b3-fe64-43f2-a55b-c745a6903ddc@redhat.com>
 <8661d581-838d-4bcd-96df-2ae4b7572c82@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z4ongljrh52uqxfz"
Content-Disposition: inline
In-Reply-To: <8661d581-838d-4bcd-96df-2ae4b7572c82@t-8ch.de>


--z4ongljrh52uqxfz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 07:30:03PM +0100, Thomas Wei=DFschuh wrote:
> On 2024-03-27 14:34:00+0100, Hans de Goede wrote:
> > Thomas, can you do a follow-up patch with the simplifications
> > which I suggested in my review of patch v2 3/4?
>=20
> Will do!

Thanks for taking care of it!

-- Sebastian

--z4ongljrh52uqxfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYEb9QACgkQ2O7X88g7
+poyMRAAou7HlyNM793s56EBLVDdIgq4gVdEp8RykZ4rwst+Koe0p3u0whI425Pn
QfK17m/nJaIpLkeMO7zOO+1ncsCXKi2OxpwJkyD/BpoqQl4KjTZoJcI5txHELlyT
4g5VvH+rKQhwMfku2+rx8rcBlBYRXlYSVa8VyxGAqMl5/1068MsNal2McAuCjHGE
wjcr+9yZhoa31TkjBs+zZpK2gtp4nPA3gWg0soxSqWNI/cR/bcZXo5JZA/6Tzh6a
FBiTAFe5zX+E+oyWrV54xjWi3aQ60oA38V37eu6W01XSjJwz8VA8g4+Prc8QufaO
/q6Dqq4yHzk9U0HLL5svCMV+5a27ZGySNrScZ4sZ1G/2To4YEoFd9XSYDxK7YwDL
ubdgkyv8+7nmsbg899u7de5L6DiNRwega5Kf3abqe15z7fncBcCj9vWd1GcrD+fe
uZQy9Cfr+E7+v61g+UHqPSYxa9a9zDYGEk5h3Q3EV48elYhsTit+KIxlj/9ezYnz
XzHw9C71g8V5AuB4E7Bo1khitYnz+cm99WYbL24/7m3rcleWFZiBTSFtz5xTwDeC
2rNspqo7wp3bEL4TnH27Q1bBzWwIMS+0Ddg2NPT6VP9GIrK/7yazKVFVW7LGVBTK
aFY+otEvrI2c7LgtfzrsrqJ018R7MXPA2aLYYKw5QonojAyOM5M=
=77mQ
-----END PGP SIGNATURE-----

--z4ongljrh52uqxfz--

