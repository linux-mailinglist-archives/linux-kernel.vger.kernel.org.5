Return-Path: <linux-kernel+bounces-129914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C818971F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6021F28A74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11847149009;
	Wed,  3 Apr 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ej5TuduV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4383148831;
	Wed,  3 Apr 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153361; cv=none; b=YB+2F0tDP1mwS3W4RkTQ8axqmognJkOFMrOYw45oSBAfo3iXqdZhChQ6hi8QkAajSAuKty2+AqMMEr0zDFLFVyPVdVecHbgh18MW1jtOSrhEuMYCsvBd99eUZZQ82AZdkEH68m3ukSkac0TUyCztz/YZNluTCfthYBpAzpIcMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153361; c=relaxed/simple;
	bh=agTHV4kamLLPYcNHOfaIhrtk8c/lda8kF/YWjh1kBJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puvw8YLfBR2R+vytGC0dMLTmM8FSXNesMLWJaQd5pI6rnI0zEib8F7jB4sQSsUpXgwCIMjHpabBV6+B6+nJodh05t6DX8G2wUieyR8090qOpLrdvb+HgVADZhBpkNEqPnzDEfSTxRF53lRM1aWXYwyqaipM2+JdDQ/Tl5o5gXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ej5TuduV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712153358;
	bh=agTHV4kamLLPYcNHOfaIhrtk8c/lda8kF/YWjh1kBJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ej5TuduVQzkPKOqmLXBWFS4juFDp4MmlKPVPcTaeoSqlAy48WAn1nq0ecYlAIQow6
	 J6TlBihY4qc7QNKs9/1bOWSpoNpAndiX5VWK+c5LnV7z1vcADEOzZUEdLIQ0EwxrS0
	 Ru8uWgGZZOmthtVp/8LCe/1/PDhwVA33EnZUzGvCqClWTmlJXIdZODfRAzRdcsw6QO
	 LEUPf4ZMmk8WIvt/EKwilFZ3oOXrIV2eSy66+zHF9cH9tPVoajTUo/RLplO5XmtOp0
	 tBZ65nThRBz5Fp2SVGYPf4AuGbV4z0R+xST8gP6it6QkMgNgk3yg6qlDrc96fmLaRr
	 9ul7GpGOBrqGQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E10B037814A4;
	Wed,  3 Apr 2024 14:09:17 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id D07B01060E07; Wed,  3 Apr 2024 15:52:11 +0200 (CEST)
Date: Wed, 3 Apr 2024 15:52:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Saravana Kannan <saravanak@google.com>, 
	Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <4zlnwwycmjt4p2efqvvxirgcxqyyptf4ndqmbm5uxjjbk2toyz@uyxh2lmwb2fz>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com>
 <ac4246bf3786230eb9ca85b329e7d0df@manjaro.org>
 <CAGETcx89V5CJrAq6XwuGiusQnkR804pTgYAtS94v7Q+v=Cv+qA@mail.gmail.com>
 <D0A122WK7CB9.33B2TP6UCMJBJ@thefossguy.com>
 <CAGETcx_ToHsp_c+Yt0qqST4Zd-GC7dPn_j=PpB1n1xpZtOnMfg@mail.gmail.com>
 <D0A2ZL6S8UG6.2BQKIBQWYB36D@thefossguy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4danktmrrrxcg4g2"
Content-Disposition: inline
In-Reply-To: <D0A2ZL6S8UG6.2BQKIBQWYB36D@thefossguy.com>


--4danktmrrrxcg4g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 03, 2024 at 01:03:07AM +0000, Pratham Patel wrote:
> > > > Also, can you give the output of <debugfs>/devices_deferred for the
> > > > good vs bad case?
> > >
> > > I can't provide you with requested output from the bad case, since the
> > > kernel never moves past this to an initramfs rescue shell, but follow=
ing
> > > is the output from v6.8.1 (**with aforementioned patch reverted**).
> > >
> > > # cat /sys/kernel/debug/devices_deferred
> > > fc400000.usb    platform: wait for supplier /phy@fed90000/usb3-port
> > > 1-0022  typec_fusb302: cannot register tcpm port
> > > fc000000.usb    platform: wait for supplier /phy@fed80000/usb3-port
> > >
> > > It seems that v6.8.2 works _without needing to revert the patch_. I w=
ill
> > > have to look into this sometime this week but it seems like
> > > a8037ceb8964 (arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only f=
rom rk3588 i2s)
> > > seems to be the one that fixed the root issue. I will have to test it
> > > sometime later this week.
> >
> > Ok, once you find the patch that fixes things, let me know too.
>=20
> Will do!

FWIW the v6.8.1 kernel referenced above is definitely patched, since
upstream's Rock 5B DT does neither describe fusb302, nor the USB
port it is connected to.

We have a few Rock 5B in Kernel CI and upstream boots perfectly
fine:

https://lava.collabora.dev/scheduler/device_type/rk3588-rock-5b

So it could be one of your downstream patches, which is introducing
this problem.

-- Sebastian

--4danktmrrrxcg4g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYNXwcACgkQ2O7X88g7
+ppSBQ//WsXoLg+w00Vt6lS7Fu+Ry1/gMQ7+0b0R66GBVrconK+w8cdxwNCmJe+z
0/5ehaf6Wd4Btp2YcDywLFVFv+nHEg6H3t+PSyVzST2EnEGpJBzL9FBGq/J8XIVv
TSyMJPEb911F63xSgZXoqlLa/Jti4ccqYIJUy6LYLJ97/3Wm1rtzPvPyrs2ySJ8I
5l3zLA4POdS6I7vdbPNVjzY4LVEG9CwQIJIwGoScCwoxESlMpiB1+hLYil/2GsVq
1OKAwEZuRycmROdMobiYYsO/a1GQU2FcIcZ4ocmX5e1U94qmP578endIVW+lFz8+
S5FXoSOmxCZY6x4mczQ2nrGNI0vHfUuiNZHOxpoUZa2Y6Lw1D1v2a9Ek1IKH0LUt
t8vp4w2k9nvMAXpRXaCK17zR/x92osn5SNNKz7RCd2Q9yGeB4a0iSDoA82xCYpGd
lTtrxBkBSLKJlraVeeCuuwRxINRRg5DFwhleXfSEvIFXOHPVV+Fc/UPoq1bNzgF/
jDVLTdRtfiWgl0c833WyLvCU7A3AjuFmO3AmxV+Z6gvv97o7JknuX5fsW5cjfAHx
UIp/OBj+aEG/fZc5cG74LxfVZbxpK9McusBysf8BsFNAmHIzMoCsnGstfmSNHGr+
fRntqsaKh8rDFgN5rKRB7svYg2dmFVKjtH7uPmQl9DPhfx5zSG8=
=feq8
-----END PGP SIGNATURE-----

--4danktmrrrxcg4g2--

