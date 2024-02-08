Return-Path: <linux-kernel+bounces-58750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869B84EB07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D301C24B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873250261;
	Thu,  8 Feb 2024 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tDFPPyG+"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928004F5EF;
	Thu,  8 Feb 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429581; cv=none; b=V4YzA1cgw57QU5f9NE0Y63YReZHuAKi4v2YnlZv/ItnezzdCvrzZEsRzG+G1gi8lvskyOFmPWMttiIp/ca9cttlbgo/mr9M+lmhuIeNEGBGHLCENr6W3jKtzgNaWn9RUsenkb96S0PokJFUqsdMg16hlXubcCqEbpJJ7rFdPEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429581; c=relaxed/simple;
	bh=UO7OBKW8qlkR32LtezaT9Qi3ivmkVEpFv1RuDTfkUMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDtZOhUJRaQtncXdyQdQdv0nBQWGQYYSePFsvGNLtZRGTW6feqNj0xVf6MRrITO9iN1zzy9gYKVl+DpyUVFH/zOH9LokORYIepbMJSK0yCgWBUgfUT2n4f4gTzCxE2wl64bcaNb1Owlc5BDWtsJCFtmtK7P85vQhkzWcJuMUDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tDFPPyG+; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707429574;
	bh=UO7OBKW8qlkR32LtezaT9Qi3ivmkVEpFv1RuDTfkUMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDFPPyG+Mau7Otuti88UvrNR+ye8pPLDG0v3xcZceaUKrFj7Uw8XnkzSdy1y5VaYQ
	 6Vfi/VkeYrCYI8009gZh0IHfpvUyqwRR0PuV4uPZITpK8PuVBJF7pzyy0PesemWeXJ
	 wPW1PqSZ27l9ywF5mLOXEglmOoWREpVwjibyUZau7wRowzTPs78nkxqHH+FZupn5Sf
	 lg2ADYGGLsaLEfRsZXuGvEKURHXbRYXwlsoAMZghFk/qq9i7isj1dZfi7zIjkAXong
	 +maazbzAtXFv8n5Jc/+x1SD4RYS/VyrvQXxeIO78tyq/yGs68pMgmBb7ppOkPQPyI4
	 XpqozCW/Vxe1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TW9r63kbkz4wby;
	Fri,  9 Feb 2024 08:59:34 +1100 (AEDT)
Date: Fri, 9 Feb 2024 08:59:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Cezary Rojewski
 <cezary.rojewski@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Message-ID: <20240209085932.6d4f09b6@canb.auug.org.au>
In-Reply-To: <6a129c31-54c0-4671-a8d4-dc0f72e60154@linux.intel.com>
References: <20240208145200.7590dc62@canb.auug.org.au>
	<6a129c31-54c0-4671-a8d4-dc0f72e60154@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3zWY=LTl157.ex/Zj=/EWz2";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3zWY=LTl157.ex/Zj=/EWz2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Amadeusz,

On Thu, 8 Feb 2024 14:32:15 +0100 Amadeusz S=C5=82awi=C5=84ski <amadeuszx.s=
lawinski@linux.intel.com> wrote:
>
> Ah! The avs path should've been:
> /sys/devices/pci0000:00/<dev>/avs/fw_version
> Will "avs/" in path this fix the error?

Presumably, since the path string will then be unique.

--=20
Cheers,
Stephen Rothwell

--Sig_/3zWY=LTl157.ex/Zj=/EWz2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXFTsQACgkQAVBC80lX
0Gy95gf+NuxonBpSfH7ev4FGkl6QQ27l8AQC2iAEnH6e2sg1AnsuWepZ2BKpVv0s
3JitCnaGE6mInSGS3pYzcjF6MMeVe+N0i7LtnOBuXLTny2JCx8kzVmwmdQquS5xL
oMpSK4LWoqTKhQepcIlWnXpDWMGUgS+xXfmDU+K4ChZqfwTJzcCp8cdNlIN4+bEo
pNzeJqIWtsucfBIJoH825ZDbCEUoU6LjdCoahyaorbs7cTdbnOvGqKoh25X5w8Mz
Lfe/TuTzaliNCEWZiBZ2MOVKYWZJef8Ngz4RD9no9j4lv49mbgcZt+Eo6mjYR1iP
/TOP/tEpIqx2YLDVNkX4kYny/pAT6w==
=URXK
-----END PGP SIGNATURE-----

--Sig_/3zWY=LTl157.ex/Zj=/EWz2--

