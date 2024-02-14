Return-Path: <linux-kernel+bounces-64980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED2854572
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36C5B21655
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8314F8C;
	Wed, 14 Feb 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="lSbVWGEu"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BB171A6;
	Wed, 14 Feb 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903260; cv=none; b=NrQeno+nXXlNITwioAmEo6+0OcLp/z639jumEoshMhdQOvmrIIa2I8ldcixcHQCW+fkySVSXp3KwIImSqlxkHI8HrrEjN2/odAAVaAd+QReoGwYqzwK8KM6tMbWG3n+0pgMh2CCEEKjyZFFj6DSztKD+lp2d3fILiy2d7+5oRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903260; c=relaxed/simple;
	bh=N32bS7Dr+HbXZpA1Y+5OXodrXUlj45EuuQ2+2Y27jS8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWq0Yi0Q09kxa9/bb/7saLZctAEIpx/9dxn8i6epXC4GD5bLEk0i+QeP2hIrhMcNXWvINHzS+zz5wJUfetBkvRNqjMP7Plw/BUNSNXMLKUPMkpnSAzKTD1ydt3hwy0yHTMIS/vcApx2Jo5OfADm5xvwJLTE/+nKRXJIdOYGqJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=lSbVWGEu; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:c389:e482:863d:6bfb])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id D2F2C7D4A4;
	Wed, 14 Feb 2024 09:34:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1707903251; bh=N32bS7Dr+HbXZpA1Y+5OXodrXUlj45EuuQ2+2Y27jS8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Wed,=2014=20Feb=202024=2009:34:11=20+0000|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Samuel=20Thibault=20<samuel.th
	 ibault@ens-lyon.org>,=0D=0A=09James=20Chapman=20<jchapman@katalix.
	 com>,=20edumazet@google.com,=0D=0A=09gnault@redhat.com,=20davem@da
	 vemloft.net,=20kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=20corbe
	 t@lwn.net,=20netdev@vger.kernel.org,=0D=0A=09linux-doc@vger.kernel
	 .org,=20linux-kernel@vger.kernel.org|Subject:=20Re:=20[PATCHv5]=20
	 PPPoL2TP:=20Add=20more=20code=20snippets|Message-ID:=20<ZcyJE4oCaw
	 Z6aBAW@katalix.com>|References:=20<20240214012102.dsdgcdgvwgfabzdi
	 @begin>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Reply
	 -To:=20<20240214012102.dsdgcdgvwgfabzdi@begin>;
	b=lSbVWGEufWRdvURg6uQdMzU4FIa75J+x4MVyK57MuSdnbx81Jy9/Fcg2k5yF87nex
	 UtyOZbjUoCp/FlW25AtfP0F335ZFI76lbO9RcUjeICNRh84mAwV5sCbe6vM2zGQSYq
	 VveXXWQY6xLqdysi6+VzSXu5ta27pOeAg6Hstf0wDo0k27qbZbDUKAKMNZIY1wYHjU
	 rS4BYSpsvcMd0Gi6xPE4cdsHN+1WmxxRTvdmMr5goWDvYjY1uh4U3371VaIQD0xtES
	 zuvZzEP9FE/F0w5F/lvw8kVA/4NQEl4hN8gcYm8RDGxaCuLNf2qo2FBHqaDxEHZTUZ
	 pIOuoD4bpYv3w==
Date: Wed, 14 Feb 2024 09:34:11 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] PPPoL2TP: Add more code snippets
Message-ID: <ZcyJE4oCawZ6aBAW@katalix.com>
References: <20240214012102.dsdgcdgvwgfabzdi@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GNCEsAiJMMSTxwir"
Content-Disposition: inline
In-Reply-To: <20240214012102.dsdgcdgvwgfabzdi@begin>


--GNCEsAiJMMSTxwir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Wed, Feb 14, 2024 at 02:21:02 +0100, Samuel Thibault wrote:
> The existing documentation was not telling that one has to create a PPP
> channel and a PPP interface to get PPPoL2TP data offloading working.
>=20
> Also, tunnel switching was not mentioned, so that people were thinking
> it was not supported, while it actually is.
>=20
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

LGTM.  Thanks again Samuel :-)

Acked-by: Tom Parkin <tparkin@katalix.com>

--GNCEsAiJMMSTxwir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXMiQsACgkQlIwGZQq6
i9Ao5wf+J5uZNWOxNgn6cWGD/gEB7ACloBRqvi19EMh5YAkOnxLWw0QaKkC040MC
gi6iwXzInBqcDa6nBI4MfMM4GOd5buOp5lG8dsEfKrWzqxrDxDwX/RyBVFEGcmOV
0TQ41ybnjeoXyfUCNIepd0T0hNqy3/jSi/1hXJwIzbEUjx3vURHDnucRzm+Uq0Ot
kqg1OpifXRbu4Wj3Ldn2fgQT8iqUjEKuDCac3rHrqSGkK15D2W3IsUr1eNKIrvS2
7aAzwXG9V3dtW9NS35RERZyHZ3ebI3gqT4hT1V9U0Ywivj0+gg5LZE0lAOYdspN/
56unm+WW9DlengWgam6Z45dNjVmM8Q==
=4qhT
-----END PGP SIGNATURE-----

--GNCEsAiJMMSTxwir--

