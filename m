Return-Path: <linux-kernel+bounces-93966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9915787379A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BAF286BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66305130E2D;
	Wed,  6 Mar 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ttJ51xY0"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF41E519;
	Wed,  6 Mar 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731219; cv=none; b=Li6vj++DcLDHWc13cG42zuwfotO/ooTUICM9lhHeeFIhA0wCmnBx+riIgGofbLYWTFpq6+YUqs0BIWqR0zcqiuXG8WO0pm/EfyTAsDOsQ6u5R+GW0abNXIq2T1b35PM+XAzqqOsCHnBAzn+wFBJ+7sg1OejRl9ZMmhRPjqCPyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731219; c=relaxed/simple;
	bh=CUAADeia9xCRNvbVj33pXO7igoeK6KC1Vqe4KSLLyFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA1jEjjIEy8sXJWOTqv7/ZImW+lrThVayv8SimXDNKRzy+Eb/JAu07dJaYlGCeqDDgk304j6jhlUDDIED+VIS2iTuK0B13kD+SplIPmJytdkwf7rYjJDCb0mbU8P2J4pqI7lRruEnnUBnKV3/o4p67ib/kGSQI5BLIs0DhDxSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ttJ51xY0; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:c8aa:f3f:c939:97c8])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 666B87D94E;
	Wed,  6 Mar 2024 13:14:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1709730863; bh=CUAADeia9xCRNvbVj33pXO7igoeK6KC1Vqe4KSLLyFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=206=20Mar=202024=2013:14:23=20+0000|From:=20Tom=20Pa
	 rkin=20<tparkin@katalix.com>|To:=20Gavrilov=20Ilia=20<Ilia.Gavrilo
	 v@infotecs.ru>|Cc:=20James=20Chapman=20<jchapman@katalix.com>,=0D=
	 0A=09"David=20S.=20Miller"=20<davem@davemloft.net>,=0D=0A=09Eric=2
	 0Dumazet=20<edumazet@google.com>,=0D=0A=09Jakub=20Kicinski=20<kuba
	 @kernel.org>,=20Paolo=20Abeni=20<pabeni@redhat.com>,=0D=0A=09"netd
	 ev@vger.kernel.org"=20<netdev@vger.kernel.org>,=0D=0A=09"linux-ker
	 nel@vger.kernel.org"=20<linux-kernel@vger.kernel.org>,=0D=0A=09"lv
	 c-project@linuxtesting.org"=20<lvc-project@linuxtesting.org>|Subje
	 ct:=20Re:=20[PATCH=20net-next]=20l2tp:=20fix=20incorrect=20paramet
	 er=20validation=20in=20the=0D=0A=20pppol2tp_getsockopt()=20functio
	 n|Message-ID:=20<ZehsL8sHd3vgplv1@katalix.com>|References:=20<2024
	 0306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>|MIME-Version:=201.
	 0|Content-Disposition:=20inline|In-Reply-To:=20<20240306095449.178
	 2369-1-Ilia.Gavrilov@infotecs.ru>;
	b=ttJ51xY02xPMTip2o1mIXJ1daaWJkddLTexc5aaB0lhGr7/f/BFJOrGcULMnAmnYr
	 pX7gDdD9VDuKf0+XtRaQwbThGGrp9GLQi74k1dqBqQ/c52R3ykEDr9p240QTmzVSRK
	 oLrG33UhCGUnhL43hdTLKNczsgfvL7yg0/SAEfSN/HukviDATtZWtikztBN3M5WYaU
	 yK3OxI+Fk++1cWRXu3qvrPtnW87epDYNfv7A1xEskrdH8rBL5ennhXRCYaNOjd90Nu
	 zIuY82J6mKG3brNMQkrBKgfXS4HqXyIb2kDN8QfUd12z/hzpxcpUA4UJRfNrm/FSDq
	 Zf3kIdtH1GfmA==
Date: Wed, 6 Mar 2024 13:14:23 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] l2tp: fix incorrect parameter validation in the
 pppol2tp_getsockopt() function
Message-ID: <ZehsL8sHd3vgplv1@katalix.com>
References: <20240306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sRqq1QTNgT2eAlVi"
Content-Disposition: inline
In-Reply-To: <20240306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>


--sRqq1QTNgT2eAlVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Wed, Mar 06, 2024 at 09:58:10 +0000, Gavrilov Ilia wrote:
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index f011af6601c9..6146e4e67bbb 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *soc=
k, int level, int optname,
>  	if (get_user(len, optlen))
>  		return -EFAULT;
> =20
> -	len =3D min_t(unsigned int, len, sizeof(int));
> -
>  	if (len < 0)
>  		return -EINVAL;
> =20
> +	len =3D min_t(unsigned int, len, sizeof(int));
> +
>  	err =3D -ENOTCONN;
>  	if (!sk->sk_user_data)
>  		goto end;

I think this code in l2tp_ppp.c has probably been inspired by a
similar implementations elsewhere in the kernel -- for example
net/ipv4/udp.c udp_lib_getsockopt does the same thing, and apparently
has been that way since the dawn of git time.

I note however that plenty of other getsockopt implementations which
are using min_t(unsigned int, len, sizeof(int)) don't check the length
value at all: as an example, net/ipv6/raw.c do_rawv6_getsockopt.

As it stands right now in the l2tp_ppp.c code, I think the check on
len will end up doing nothing, as you point out.

So moving the len check to before the min_t() call may in theory
possibly catch out (insane?) userspace code passing in negative
numbers which may "work" with the current kernel code.

I wonder whether its safer therefore to remove the len check
altogether?
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--sRqq1QTNgT2eAlVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXobCoACgkQlIwGZQq6
i9CJ3ggAnMVBtH7FFAb+vH6t/MidRzhvkMZ4t9DE5Tt3WOwm1aN2YKKsvuUdzR5f
32KbhH2EI2S8uEqwJBNwl5+rZ1QWmPFHdL62N0yW3juzR9K64+WpXGeGmdIFZXgS
R0J7b0u/GvsWleVV/HNuqrMCnAxSxAs9f9FKrcyqx2zsFsi2P3cwpsbEaXOsdnkM
W7yeGoDbx9J2BkWp9OdItzhv8y+ecb6CtgbGMVHDC7/iL3A+P9bgZqh/BFfON+s1
IDmtSE0OJFYb3KgQLxMAybXe4B+w7jyWKcCpu30cEOwSd9waDJotoeTOktINyLSb
8mpupV5PgGYvZzgSZ1IVQ25fZKel/w==
=7U9S
-----END PGP SIGNATURE-----

--sRqq1QTNgT2eAlVi--

