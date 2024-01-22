Return-Path: <linux-kernel+bounces-34120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7792C8373E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6188B245D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3FA46B98;
	Mon, 22 Jan 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RBRyKjYe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629193A8F0;
	Mon, 22 Jan 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955765; cv=none; b=Q18czVEicUq59crRbKL0UtJ5rSbvFCmLjMzvc6wCJrEprICSgBACX6tjE8I/D70l5x9wK9MPZqiDTDhFqSx+e9dsghgG4IzdKAr29y5hZnv4yAk2L/ZSnBmQsUE8H3m4A5ehL/5bQJudDde8DfCoE9z4aU4wPkDPOdTUL/qOshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955765; c=relaxed/simple;
	bh=yK/fwSyAmupdpdxdS2/NJ6V1I8XnT6cVjPtiRFkTRug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rtM78UoqnQXY+zuiOYJl32cFAyFtqwNZXq0NPA4hyKa+WimqxRtc1HVqGEgoLjuITYYfceZsVDtbdqk96iXaSHaSyobiUWDPUELbA6cxbTOEHxOS8dCmTp2DtVtsWiXd7VPpIOtNVPmiwPic7cKoz2o6l9Dhvf6WA0yJjcnKccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RBRyKjYe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705955760;
	bh=Lr+KHjgkw1ARvgpjfb7xHuKvdkjQXh+WnTdxlXJO42I=;
	h=Date:From:To:Cc:Subject:From;
	b=RBRyKjYeKbr6y9Ry5dMiydCWyipRA2cOM84iH0jLIOxx2WlG6qLETZsWEIFF4ZurQ
	 Wvw6amXaeA98ECLY2MVw1EO5Aj0u0kFcOg9ga9E7rD+WxbbatZIcvaOyorkA5lp4/2
	 1pJirbR7QeFnD3nCDo8gGMVBnMu8D1rUXL3SZI+8hpwag0wwhTuWWKZgNxv5Pu9n0X
	 0A+KehCiQ7Lneahq86pUw93j+8dcPfiDN+vYTSChv4ul8RJ/TJDYyG/ngKp1zfMNco
	 pXUNBGsC39Mcc3XRnZhPJqhTGNR73ZPtidb4/GPvZbcGCruHiIjjwRhDxmJGGKU5GU
	 yjR/zs85MnQWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJhnV67K3z4wcH;
	Tue, 23 Jan 2024 07:35:58 +1100 (AEDT)
Date: Tue, 23 Jan 2024 07:35:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, Andreas Klinger
 <ak@it-klinger.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the iio tree
Message-ID: <20240123073557.5b2eb64b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Z79Gw7Ue/lPQ2fDmXb60lV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//Z79Gw7Ue/lPQ2fDmXb60lV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  53fb4e15b972 ("iio: pressure: mprls0025pa fix off-by-one enum")

Fixes tag

  Fixes: <713337d9143ed> ("iio: pressure: Honeywell mprls0025pa pressure se=
nsor")

has these problem(s):

  - No SHA1 recognised

Please just use

	git log -1 --format=3D'Fixes: %h ("%s")' <commit>

so

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")

--=20
Cheers,
Stephen Rothwell

--Sig_//Z79Gw7Ue/lPQ2fDmXb60lV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWu0a0ACgkQAVBC80lX
0GyvZggAgcR4RJRQpM9+1Y9KSOhlqO1U7YtFuvMwSZoimI4aeyzAWwhT8OuIC8pc
IMaWiGl/EeHqe2pWLsH/Zo8NxsFerkpaZOVp54pJoxvZVWJ6esxTjLEBIG5/6GWT
J2wFVy6fnRawmHJqb2/fpKUIqqQR9FE14Kb5JipwO8CdVJcAM9YilwamLBotLY9V
GW1TvhmTBYwSN65ASo1cYg8E8wxWw/DjxqDcwwB4WMKizdnpYmyNwRW85x/dfCA2
Xvv09bw66Aq5tE7EaG5zbTBckWAfp9CwF1rUlPA8XPv/8zypd/N5jTRbO8G0A8Qj
P6rHIV5RH6woeWx97lgVOyNpNvcBlA==
=fF/D
-----END PGP SIGNATURE-----

--Sig_//Z79Gw7Ue/lPQ2fDmXb60lV--

