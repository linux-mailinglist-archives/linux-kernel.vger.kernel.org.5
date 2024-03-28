Return-Path: <linux-kernel+bounces-122783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84D88FD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5301F294C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E17BB1E;
	Thu, 28 Mar 2024 10:35:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D6364DA;
	Thu, 28 Mar 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622120; cv=none; b=ia5CdBHPUw2QnQnmR4jo0NDoXQC56e5YQR4mADsUDxC8e5fJtKmctTbq+uQpop+wyyCqPN9GPrUg85uRwfxqpPAefVhaW21WRU+YsJnPVnRwFOgl8Vreiosr3sDVAfZRMvMUyEsuNgyMPrE+1Vmh0AnggFFxUAcYjtAtdBbq5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622120; c=relaxed/simple;
	bh=7vFSQ747FM06KN1wrNfHC48TjsBeAGoEHNFZdXAOOxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRKtlYrwq0HZPE4ZfDnifoG6jYgGUgknRaLIOyQTR0mxTHogSA1XFMrkeQCPOpXMXJBqJ8dDZFRArHSwDtko5pdc+VvuaIsjRiqkCJwLnyEicXni1ED+lXuJUhkgxyp4dFuY+toTGn2BkMenLqMe7GMKWG4yFsBh0m8OZb3U9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B1D141C0081; Thu, 28 Mar 2024 11:35:16 +0100 (CET)
Date: Thu, 28 Mar 2024 11:35:16 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.1 140/451] ipv6: mcast: remove one synchronize_net()
 barrier in ipv6_mc_down()
Message-ID: <ZgVH5FhlyKXmbJ99@duo.ucw.cz>
References: <20240324231207.1351418-1-sashal@kernel.org>
 <20240324231207.1351418-141-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jR9q48rvjneaP0k+"
Content-Disposition: inline
In-Reply-To: <20240324231207.1351418-141-sashal@kernel.org>


--jR9q48rvjneaP0k+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Eric Dumazet <edumazet@google.com>
>=20
> [ Upstream commit 17ef8efc00b34918b966388b2af0993811895a8c ]
>=20
> As discussed in the past (commit 2d3916f31891 ("ipv6: fix skb drops
> in igmp6_event_query() and igmp6_event_report()")) I think the
> synchronize_net() call in ipv6_mc_down() is not needed.
>=20
> Under load, synchronize_net() can last between 200 usec and 5 ms.
>=20
> KASAN seems to agree as well.

This is performance tweak, not a bugfix. We probably should not have
it in stable.

Best regards,
								Pavel

> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 566f3b7b957e9..a777695389403 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -2722,7 +2722,6 @@ void ipv6_mc_down(struct inet6_dev *idev)
>  	/* Should stop work after group drop. or we will
>  	 * start work again in mld_ifc_event()
>  	 */
> -	synchronize_net();
>  	mld_query_stop_work(idev);
>  	mld_report_stop_work(idev);
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--jR9q48rvjneaP0k+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVH5AAKCRAw5/Bqldv6
8uwFAJ4jiqh3X7yU1KwHULt+PeY5XCqq7QCfSPZ1HLmE8WjWvaJvbb6vDYMqS6Y=
=Ft3s
-----END PGP SIGNATURE-----

--jR9q48rvjneaP0k+--

