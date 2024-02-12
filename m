Return-Path: <linux-kernel+bounces-62401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E2851FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF71C2245D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C7B4CE1F;
	Mon, 12 Feb 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="0OYZVpUe"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882504CE02;
	Mon, 12 Feb 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773671; cv=none; b=Kn7OWWxQ98cmRElhUWwzpnURkYfCZOUhVfJ0OraL3gl+9jM2wWUxbvaxp4Wn/qH2h64QEjv6T+EfQ78PpAw+/kQlvqBven/2OG/15VQQeqwp4MdwT82hzkYYwlkc4m0JGDyA7o2Jy6QCvr+QHvhlXhUPUDFF7nzXv5W7X8tmcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773671; c=relaxed/simple;
	bh=+qcu0DYPNoQipBt7EpDCR2pS5408YGljc/2HyDR4pFU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS2flfCEZD14g3trC0Xq/m5kssMXMno9BYNKfRb5K0t46D1KuFVj7nk95GEj0ID++zqKPQqq8u8JB5TXf8AXzPZLcHAHuvnTz47pf2QR+MDsS9pojAVJ5vVuDvvjG2livUgloN6aZt0K4xIE2Bwqa8W5wSWzMzIT/5YngSG7PK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=0OYZVpUe; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:a903:359f:8aea:3bdc])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 4C7B67D118;
	Mon, 12 Feb 2024 21:25:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1707773133; bh=+qcu0DYPNoQipBt7EpDCR2pS5408YGljc/2HyDR4pFU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Mon,=2012=20Feb=202024=2021:25:32=20+0000|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Samuel=20Thibault=20<samuel.th
	 ibault@ens-lyon.org>,=0D=0A=09James=20Chapman=20<jchapman@katalix.
	 com>,=20edumazet@google.com,=0D=0A=09gnault@redhat.com,=20davem@da
	 vemloft.net,=20kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=20corbe
	 t@lwn.net,=20netdev@vger.kernel.org,=0D=0A=09linux-doc@vger.kernel
	 .org,=20linux-kernel@vger.kernel.org|Subject:=20Re:=20[PATCHv3]=20
	 PPPoL2TP:=20Add=20more=20code=20snippets|Message-ID:=20<ZcqMzP1RQy
	 e9o4eB@katalix.com>|References:=20<20240203223513.f2nfgaamgffz6dno
	 @begin>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Reply
	 -To:=20<20240203223513.f2nfgaamgffz6dno@begin>;
	b=0OYZVpUe9YP/RBA64d2L6QacwiRppeqvdukjETNhog6SriqbA1jeDj9rV48kT/wdt
	 YeLNm/ijC9vkTkLxNW3FlhWevP7FTdkOs6USVYeR32pslQCrEGUBciUctrR5fkDqQy
	 iNOb+161qhJsBqMnBayut8Pxjr1X7WQHqi7y1axCot7u3kD0h7fu+9vDKfcLH0WUsV
	 lxVrMmn1GYEj93OyD9l7Q6dOUy78P9dhCN0LToDKrdEn0FLS5WWpqLGJsOGD8fVQCl
	 lbuiipIR5v+9A1bVbWevCt5+WJqHFxDwj0aEcVqRmjd5tYZLX+h/ybXkXLt5PC6t/S
	 d0ugTHrWtN1fg==
Date: Mon, 12 Feb 2024 21:25:32 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] PPPoL2TP: Add more code snippets
Message-ID: <ZcqMzP1RQye9o4eB@katalix.com>
References: <20240203223513.f2nfgaamgffz6dno@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYbjNzr0z0MM3ovf"
Content-Disposition: inline
In-Reply-To: <20240203223513.f2nfgaamgffz6dno@begin>


--TYbjNzr0z0MM3ovf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Samuel, comments inline below.

On  Sat, Feb 03, 2024 at 23:35:13 +0100, Samuel Thibault wrote:
> The existing documentation was not telling that one has to create a PPP
> channel and a PPP interface to get PPPoL2TP data offloading working.
>=20
> Also, tunnel switching was not mentioned, so that people were thinking
> it was not supported, while it actually is.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>=20
> ---
> Difference from v1:
> - follow kernel coding style
> - check for failures
> - also mention netlink and ip for configuring the link
> - fix bridging channels
>=20
> Difference from v2:
> - fix text alignment
>=20
>  Documentation/networking/l2tp.rst |   99 +++++++++++++++++++++++++++++++=
+++++--
>  1 file changed, 95 insertions(+), 4 deletions(-)
>=20
> --- a/Documentation/networking/l2tp.rst
> +++ b/Documentation/networking/l2tp.rst
> @@ -387,11 +387,16 @@ Sample userspace code:
>    - Create session PPPoX data socket::
> =20
>          struct sockaddr_pppol2tp sax;
> -        int fd;
> +        int session_fd;
> +        int ret;
> =20
>          /* Note, the tunnel socket must be bound already, else it
>           * will not be ready
>           */
> +        session_fd =3D socket(AF_PPPOX, SOCK_DGRAM, PX_PROTO_OL2TP);
> +        if (session_fd < 0)
> +                return -errno;
> +
>          sax.sa_family =3D AF_PPPOX;
>          sax.sa_protocol =3D PX_PROTO_OL2TP;
>          sax.pppol2tp.fd =3D tunnel_fd;
> @@ -406,11 +411,97 @@ Sample userspace code:
>          /* session_fd is the fd of the session's PPPoL2TP socket.
>           * tunnel_fd is the fd of the tunnel UDP / L2TPIP socket.
>           */
> -        fd =3D connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> -        if (fd < 0 ) {
> +        ret =3D connect(session_fd, (struct sockaddr *)&sax, sizeof(sax)=
);
> +        if (ret < 0 ) {
> +                close(session_fd);
> +                return -errno;
> +        }
> +
> +        return session_fd;
> +
> +L2TP control packets will still be available for read on `tunnel_fd`.
> +
> +  - Create PPP channel::
> +
> +        int chindx;
> +        int ppp_chan_fd;
> +
> +        ret =3D ioctl(session_fd, PPPIOCGCHAN, &chindx);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_chan_fd < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx);
> +        if (ret < 0) {
> +                close(ppp_chan_fd);
> +                return -errno;
> +        }
> +
> +        return ppp_chan_fd;
> +
> +LCP PPP frames will be available for read on `ppp_chan_fd`.
> +
> +  - Create PPP interface::
> +
> +        int ppp_if_fd;
> +        int ifunit =3D -1;
> +
> +        ppp_if_fd =3D open("/dev/ppp", O_RDWR);
> +        if (ppp_chan_fd < 0)

I think this should be 'if (ppp_if_fd < 0)' ..?

> +                return -errno;
> +
> +        ret =3D ioctl(ppp_if_fd, PPPIOCNEWUNIT, &ifunit);
> +        if (ret < 0) {
> +                close(ppp_if_fd);
> +                return -errno;
> +        }
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCCONNECT, ifunit);
> +        if (ret < 0) {
> +                close(ppp_if_fd);
> +                return -errno;
> +        }
> +
> +        return ppp_chan_fd;

=2E..and this should be 'return ppp_if_fd'.

> +
> +IPCP/IPv6CP PPP frames will be available for read on `ppp_if_fd`.
> +
> +The ppp<ifunit> interface can then be configured as usual with netlink's
> +RTM_NEWLINK, RTM_NEWADDR, RTM_NEWROUTE, or ioctl's SIOCSIFMTU, SIOCSIFAD=
DR,
> +SIOCSIFDSTADDR, SIOCSIFNETMASK, SIOCSIFFLAGS, or with the `ip` command.
> +
> +  - L2TP session bridging (also called L2TP tunnel switching or L2TP mul=
tihop)
> +    is supported by bridging the ppp channels of the two L2TP sessions t=
o be
> +    bridged::

Since we're in L2TP-world here it is probably worth making it clear
that this only applies to PPP pseudowire types.

> +
> +        int chindx1;
> +        int chindx2;
> +        int ppp_chan_fd;
> +
> +        ret =3D ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> +        if (ret < 0)
> +                return -errno;
> +
> +        ret =3D ioctl(session_fd2, PPPIOCGCHAN, &chind2x);

Typo here I think: s/chind2x/chindx2/ ?

> +        if (ret < 0)
> +                return -errno;
> +
> +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);

Missing a check on ppp_chan_fd -- we might as well check it since
we're checking returns everywhere else.

> +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
> +        if (ret < 0) {
> +                close(ppp_chan_fd);
>                  return -errno;
>          }
> -        return 0;
> +
> +        ret =3D ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
> +        close(ppp_chan_fd);
> +        if (ret < 0)
> +                return -errno;
> +
> +See more details for the PPP side in ppp_generic.rst.

I think we need to be clear here in this example what session_fd1 and
session_fd2 are, and how they have come to be, since they haven't been
mentioned in the examples so far.

I'm not sure whether it helps or not, but when we were working on l2tp-ktest
initially we had tests for the bridge ioctl.  The tests bridged a PPPoE
channel with a PPPoL2TP one (which was the original motivation for
PPPIOCBRIDGECHAN).  The code is here:

https://github.com/katalix/l2tp-ktest/blob/master/src/util.c#L592

So in that codebase we have a pppoe fd and a pppol2tp fd, both of
which have had been attached using PPPIOCATTCHAN.

We then bridge those two channels using PPPIOCBRIDGECHAN.

I think the bridging is a complex use-case for what is already quite
an involved API (lots of file descriptors and indices to keep track
of!).  So I think the code snippet needs to be as clear as we can make
it.

Thanks again for your work on the documentation.

--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--TYbjNzr0z0MM3ovf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXKjMkACgkQlIwGZQq6
i9BXwQgAoHqydyEGowgf3EVzDNRudUQUPc1Sk7KFUzOy21wjqyINwlRuoVVVd/W4
L0W2k6uCVv+BusU/A4Erubug2kVtGx/xf+DoK2uHYw6Qlrqwy3qtSa48eyvCZBhc
YPQhGqT4h9q7ijvW4ivndSpzzT2NHt3v56dWubs4UZd0PmW5gXjsqI73cOK/NjAs
dod8Ia25mgMuf+Eop/EvwKJQIDTkwJ/vJ8+r1oQ/EZh/gCXolxv8InaDoFyW3B7m
FPMZCqhF9e+MX7E9U8jrFerl5QMXsmAwz+lJGlmsD/HTABI+5PnwiiKNNGE5+jBN
ISeAuB0igrd7Pg4q7J4dh3ghr8zW5Q==
=udhW
-----END PGP SIGNATURE-----

--TYbjNzr0z0MM3ovf--

