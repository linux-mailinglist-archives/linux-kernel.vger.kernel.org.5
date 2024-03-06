Return-Path: <linux-kernel+bounces-94057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD6873936
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2B01F2271B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF6133425;
	Wed,  6 Mar 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="s16FWTi3"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C955B03B;
	Wed,  6 Mar 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735582; cv=none; b=KB0U8hA6mKvlEFmRw8FNXHJOsRuCh4m2Z9Wi+59xsUWXwiSolBYT4KxMUxQvw0KO87gkLGQVvo88LKzrU8DpXjZDQ2AlaVLuHWiULqWeDl/fjAfIF9UngPQbn547ithivExbmfKkX6fAnDtArtLEmnid5OsIpGyhPwrExrdeafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735582; c=relaxed/simple;
	bh=I905vKeftySFbgrROZxaLKFefVcmyRrmDjClc6ZvYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXnO385iELWMWO65CO8moWIOO4wXyJ0AWDjlCFM6FyMJgrXrI3P5xM+XoqGOOULxZH1+Nz7/rI+49LbKkUo+vJvlogztNyqbjuMGAo6SwiTyNLnuYjkMXVxGf66TyRm7B3+6NlD2OiBFwMdIJMJGTSyVHGA5S6uXJvoKUvke+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=s16FWTi3; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:c8aa:f3f:c939:97c8])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 4B7237D94E;
	Wed,  6 Mar 2024 14:32:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1709735579; bh=I905vKeftySFbgrROZxaLKFefVcmyRrmDjClc6ZvYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=206=20Mar=202024=2014:32:59=20+0000|From:=20Tom=20Pa
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
	 n|Message-ID:=20<Zeh+m84IESlWU1rE@katalix.com>|References:=20<2024
	 0306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>=0D=0A=20<ZehsL8sHd
	 3vgplv1@katalix.com>=0D=0A=20<c9dd0486-aacc-4263-bcce-630fad445e72
	 @infotecs.ru>|MIME-Version:=201.0|Content-Disposition:=20inline|In
	 -Reply-To:=20<c9dd0486-aacc-4263-bcce-630fad445e72@infotecs.ru>;
	b=s16FWTi33a53/Lbn2kOEYjOMgG6slLASmMaLLXB4SflD6sAQj6JNwkkNFnj1RaEsf
	 KPw8elxDs9y9PJPB4Qc8EF6r+l9nPhf2BVWXi2TMuBgnPTfh4EZnAWTZeD3pWfCr9r
	 q/EbigRn5GjaLsWcfxO+MS7mozHc+gTkcU3OkF8vm9sKpX5PJHIlY43+KkAXVevTUC
	 BdMp9SeVQ76sVIHt4KQka0dbS6co+Mu/xZE435ng3juQrxGTyCnQumEqSNvjv2StqL
	 VjY17AbwRs1I3zx7be1CejQd2u8iyPiIkbXNZUk1ogp+cSdn7OKkZtnrvDkeTzTJmV
	 MUyHr/bIf1ilQ==
Date: Wed, 6 Mar 2024 14:32:59 +0000
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
Message-ID: <Zeh+m84IESlWU1rE@katalix.com>
References: <20240306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>
 <ZehsL8sHd3vgplv1@katalix.com>
 <c9dd0486-aacc-4263-bcce-630fad445e72@infotecs.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KucCyUWbgIeZdCDv"
Content-Disposition: inline
In-Reply-To: <c9dd0486-aacc-4263-bcce-630fad445e72@infotecs.ru>


--KucCyUWbgIeZdCDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Wed, Mar 06, 2024 at 13:46:07 +0000, Gavrilov Ilia wrote:
> On 3/6/24 16:14, Tom Parkin wrote:
> > As it stands right now in the l2tp_ppp.c code, I think the check on
> > len will end up doing nothing, as you point out.
> >=20
> > So moving the len check to before the min_t() call may in theory
> > possibly catch out (insane?) userspace code passing in negative
> > numbers which may "work" with the current kernel code.
> >=20
> > I wonder whether its safer therefore to remove the len check
> > altogether?
>=20
> Thank you for answer.
>=20
> In my opinion, it is better to leave the 'len' check. This way it will=20
> be easier for the user to understand where the error is.

Fair enough.

My concern was that in doing so we add a new behaviour which userspace
may notice and care about, but realistically I'm probably being
paranoid to imagine that any such userspace exists.

Thanks for your work on l2tp_ppp.c :-)

Reviewed-by: Tom Parkin <tparkin@katalix.com>

--KucCyUWbgIeZdCDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXofpcACgkQlIwGZQq6
i9CkFgf+K3wQZilPIrEC8XWG/QMYY830jKjb24y9bpobYe7BwUoQ3XZp5x1YT63f
Exz8TcFjn1m5iPd8MbEBEGB+qXi8HTnuMQ+f4kexxp4qPeWnQa+wg/SFLm/Vv6E1
gwrHDwzKvsdL0TSbSgftLl1DLl3u5jkHWOCGpi+9AryOPUPHj1ERcoKWKKehfz6f
oEjzs6L6bW9p0FSyBYCqsdc18A0gwfqM/dq+bOhZfu81MTfhfIoXwCj15GwOssCX
Td2p57H56NICX6ybUqNfNQMhAnXiQsto1iHTQA1s/HCEltRQzq/3pxC1NS8zDs0d
i+E6S/XLXazXcxXF5DCpt4qYxsKRgg==
=/a9+
-----END PGP SIGNATURE-----

--KucCyUWbgIeZdCDv--

