Return-Path: <linux-kernel+bounces-44705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA6842648
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF331C258F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F206D1AA;
	Tue, 30 Jan 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hETJ1YYl"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688616BB4E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622027; cv=none; b=VPFI+5m6ydq2sb4E+9BQC1a+Gpb1/X6bdBuKozivLTgTDto6lYo2MU+zgvXPpuo27upmh7gEEJoe4Zbcv87P5X6Qz2ZygsQsuqfolafvU8oPGZdlMEQM2VuvLWK2T+C/u0oxXvd6qChLa3webGQOQeyAoAzNY6ceZ5c/kr1ldFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622027; c=relaxed/simple;
	bh=LBb7sT5Nl3jU1/yQicrNZLPhGLRYw1QDuFbrZiy36WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij7hRX0vNftpjvR2pvkH1y3nW+CWPF6Akk5+L8e8gkauSsewvHrrzag8d90BBdBEYRu9ipS36p4mADlT+dwTEP6NbYfiUlKU/tU0vXg4yZBJX0cjRD70X9TAbcvZCbu7fOpQ1WjPm5njN380RNUPP6VEQiQlPuNniWwSoNVtgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hETJ1YYl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LBb7
	sT5Nl3jU1/yQicrNZLPhGLRYw1QDuFbrZiy36WM=; b=hETJ1YYl0GYlJq+/7lHF
	Nt4qb7RS0gT/ART42YJh1aSAr/bV0lUdYieqVDt8pcgGPyhXOo5ovQ4Nz2tJxAY5
	I2CKv/6aH1sRa+727UAozj2hR1EIr3/XBukmLP+7ca3wD6SUmkfcnoktPOpqByuk
	10g4UYgDX1aW86KJZQy0CMFFbqyOSfWENgOf7iQy2uX+IZlFO6blZcJqaiHeSZ0b
	d3jcvTbnEHwqiMbK3xttbt48veAkv9sV0Y8Osv1e1d2GSXRDNUNQQ3kGiU6CXHMk
	zcIbIv5q6or9KVCGZY6hpHoN+5Fc+HuXef0kwsGJ4PJg939U+fdelBlf8WAVLW34
	HA==
Received: (qmail 2856890 invoked from network); 30 Jan 2024 14:40:20 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jan 2024 14:40:20 +0100
X-UD-Smtp-Session: l3s3148p1@wQFJ5ykQGuBehhtJ
Date: Tue, 30 Jan 2024 14:40:19 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
Message-ID: <Zbj8Qyqu8KQ4Rshp@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUMeHCCiAkNyJMHTGUSTqewt=AWPUy+beA_kR26vcS8_Q@mail.gmail.com>
 <Zbjc_p_Pin7TAHw4@ninjato>
 <CAMuHMdVBXXpv9QfttBETQAeeRQjWRvfVJnrpPNiQj-N1SB9GQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wiSvPfKpqb9oap3e"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVBXXpv9QfttBETQAeeRQjWRvfVJnrpPNiQj-N1SB9GQw@mail.gmail.com>


--wiSvPfKpqb9oap3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > But they don't match, so we can't unify them?
>=20
> I stand corrected...

So, the patch is good as-is?


--wiSvPfKpqb9oap3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW4/D8ACgkQFA3kzBSg
KbYoXRAAjh/crtb5kD/iWDZL989vy3GBwPk69nrBJtCiZmrKjtZ8GofcV2xy30+Q
+bNR8ugcnYoDD86cwtZy71W7qSMACteNN5MsNnsYYyLjymy/Z1LG7P3M8nFlhfR3
3tgCqHzJvbtJPz05qkuEpaZgy65SuuyPl51pCfFSTRyiaC0BSceazFLfrtwd137f
YVii/5K3GczebEfy4ogZQ3AvAQNvkaJn7vWHHEv2IiYOF1ecDZkJt79KG8HgOkuZ
B161qoswDEaocmm6gMSx48rdblJV85vj3LQm6pZ3u6+2wpHSuTxGBQrEfd/G0p2k
8dcdMtqMSTfUcnt6FvttkhRtYaNkcnOf/VjDmDLmawiYgNNCSHwU/mP/bEr4QK4V
VMDMxk8kTsjVs0s8678fXxWIPFR3mdIus68IVHWmd0Y34vpaGHV/rcT3wBeqz06K
NZOKVERmoeJSyDjU7bvsbAyA3ykfI5TCqYkzxu+5YtL4bAYh82uk+Xp4q3s9lrnG
24mFTiO16z1wVBekUcpJghZyGW7Swqlu7HKr0L+c1Y61XB/6u9/0ar0wrgx0iWQ6
szE7oZ4s+VCjUTM2TXTWpzVTCQl9zhGgFSSVwAyVN7/6hVbgfWtQOXnwBrt5ldIQ
ufaaUtheHP1V84BeYVy4OB6eXst1b+5Ea4U6ja/6VGLmbRboMDc=
=cKu5
-----END PGP SIGNATURE-----

--wiSvPfKpqb9oap3e--

