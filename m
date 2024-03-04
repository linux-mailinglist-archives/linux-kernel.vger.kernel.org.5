Return-Path: <linux-kernel+bounces-90807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6978870540
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147C51C23C33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AAF47F46;
	Mon,  4 Mar 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="n6JDnEaB"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE12C18D;
	Mon,  4 Mar 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565470; cv=none; b=o9q9ybajKgB+q6RtAbtJ2CQFc8K/um1EHgeURlg8w72l43sUzRkFZ7zNmhPFFtf+byNLzBrqi35BWV1wB4m6vLUiG2+GLiXdW3gBTCaWwgagcQDyZcQ5d/gIlCD6daFBOQEXt0X2CC1wZSpEhgBwPw6+y9ZpNmS6u8LidrwKRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565470; c=relaxed/simple;
	bh=z3F2OYMszvnRIPoGc6Z6uw/DcVkCj5UXNrrtVZGh/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFpcPwApWwqKGt7/LNZtmYWCjW447LWgNzB+ZufFzmhD1G3UTxQi8JeD5OWrgiQidxEKsBKtjMqyv75BqBRyRqiqyZ8Y7e6Kva0sD8Eya4P4PTq6viDMmkvY7Kie+b++EEGFLgJvHRkjuQcByeoRRoLAZcSPUSObVCfrr5b2I38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=n6JDnEaB; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4928787FAE;
	Mon,  4 Mar 2024 16:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709565465;
	bh=SiJFFDcJ1G5N/oDqz5nfDb5RfxaofB8Dmaiikpx9tIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6JDnEaBWjq1/XyKwDLyLlobhIRpkIaBTDLQGKHjJUqVTJN830/3gEVS+NkCK2Vaj
	 91+xJVuOtkH57l81Uhsfi8OW0FeSEcchaWUVvduLvP1vC6rv7lgMNzP20MuT39xsy/
	 xS1FGUOojm7kqVZjDDVK1iU/18FdQNTy4WVMS1yHWRlnZUYLzmU9psSoBWB/B+2Ay1
	 F7QPte3TFIePh+CwW/oo6oqjhjyCplBXBUO5RYDywqZHrAasiW2LG3+X5MBIYdHpcJ
	 x0zALFOm50xNwokirT2w2ROdAoXSdZvV8aGBtM446bGRjtjuootNLxx9YrSgLxr8bK
	 gdsG2sJW+ymxA==
Date: Mon, 4 Mar 2024 16:17:35 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Eric Dumazet
 <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Ziyang
 Xuan <william.xuanziyang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Use full string description when opening HSR
 network device
Message-ID: <20240304161735.75b14548@wsk>
In-Reply-To: <3f2fc5cb-8c79-4e8a-b72e-edcbbc78971e@lunn.ch>
References: <20240304093220.4183179-1-lukma@denx.de>
	<3f2fc5cb-8c79-4e8a-b72e-edcbbc78971e@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/feukiOtbZ5tDUoJE=MvPUT/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/feukiOtbZ5tDUoJE=MvPUT/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Mon, Mar 04, 2024 at 10:32:20AM +0100, Lukasz Majewski wrote:
> > Up till now only single character ('A' or 'B') was used to provide
> > information of HSR slave network device status.
> >=20
> > As it is also possible and valid, that Interlink network device may
> > be supported as well, the description must be more verbose. As a
> > result the full string description is now used.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  net/hsr/hsr_device.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 9d71b66183da..9a60489fba96 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device
> > *dev) {
> >  	struct hsr_priv *hsr;
> >  	struct hsr_port *port;
> > -	char designation;
> > +	char *designation =3D NULL; =20
>=20
> Thanks for splitting this into a patch.
>=20
> Reverse Christmas tree. I know it is broken already, but we should not
> make it worse.
>=20
> I guess you can also add a const, since "Slave A" is probably const.
>=20

Yes, "Slave A/B" would be allocated in .rodata (as it it just a string
label).

const keyword added would help with the readability.=20

> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/feukiOtbZ5tDUoJE=MvPUT/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXl5g8ACgkQAR8vZIA0
zr10bAf/W9J8h5CHGGhdey5IJgO5608R6oaCdJFoNs8kZuIWBaVVdtRQwJURCjLi
gzj1jimxMQd0If/Ha8fqTZ1U4cIdNHM3oevkWKFAzyyhlor/jAF7m/yIKjuwhnVz
Mo+zcf1+1nBVe0tYaHKuCAiffsVjrODDK+wWi8gBUNqW2nGmQ81v9E23YTSpdE7a
LnkbyWprWx8VtUzMSyKbi41YIs1vQbpUfjJ/vJpvkxYntVm7ZL6O7Kb3rsGpST81
t+Yhqs7Pdomgkj/wJLGvX3fa9LCFq/hLaPu/uIrwWXVwvMmz/KWrguOqYLcFmM4v
mPSrHEnIrr8xmDI4WnWjq5eb1dWGdQ==
=djua
-----END PGP SIGNATURE-----

--Sig_/feukiOtbZ5tDUoJE=MvPUT/--

