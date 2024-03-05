Return-Path: <linux-kernel+bounces-93074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70B872A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0253B2342B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4D12D209;
	Tue,  5 Mar 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H9IaqC1j"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A01EB33;
	Tue,  5 Mar 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679347; cv=none; b=I7FA37ZxLD/FXfFosV/BvYlU8au5LX77K4njf4G/ybBi5pwqPTmu8s4lzg0lVi2vHxb5sXESa5xbRmeMMCSxn6yjMD8pY3ITh9fVvIGaM5+7fXiLfydRnybKLGdoLYlISZrR02OETznh5pKyLrkbbNfcGpQ53tZ1Ih3xth1UgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679347; c=relaxed/simple;
	bh=QKM3YMngCbu7nFuUu6jfK9gIuihRTijKWZtbkOvvipE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZR+S3f2m0lGoProCgVxDZxm2oGWcl1lLNICyeTBayGuzDNHnUsSbE2QqkfFM8f4JvPg7+IWUlzTEwirSOkoEJjePZL8zZgUfI97XcRKxiJmt6BqPjcL9hiDzwyVKQEWNp9292NWxT+u2O+oBWRZ5twnIKY/cXCZdX9AN2M05po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=H9IaqC1j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709679341;
	bh=VkrIjl0vhWafhAzUcWT3t54lRsEQJ+z7KSOEVYEquqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9IaqC1jzxgPJ1ZKOoOpZyHXjLaKka5jBcNOfFDz2yhxgHkJj+2pWBeFXcpgkKObO
	 2zztPN8ZoJgBn+Qs9v5N73fJbSFmEdFvfY5WPYXJZ1iptBCZvT1v2nQq7+VOBt2UXR
	 U0gcDCHStHD1tjP34yLoglyIir6zlC3kpTxC5avEo7xZXrIEMUPjCxYPVOlYk/AU7I
	 q+h6tu/sCqYn+yMgUvPjpLxq5Bzys96tvVxYFf3giDjPJa0YDNpFwAEIkmRi97cSKG
	 48KShZGlxXFlu08lDbVY6x1R1GYiCw9WFnCeOaCBRZwWYZC2xUFN33z6OmPqazGaqj
	 YURf8L8XVaJTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tq9rr5K4Jz4wcD;
	Wed,  6 Mar 2024 09:55:40 +1100 (AEDT)
Date: Wed, 6 Mar 2024 09:55:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the backlight tree
Message-ID: <20240306095539.0da4e342@canb.auug.org.au>
In-Reply-To: <20240305091737.GB5206@google.com>
References: <20240226132828.7524baec@canb.auug.org.au>
	<20240305111634.57e84398@canb.auug.org.au>
	<20240305091737.GB5206@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9vXR_ao69_KeVYq+j3VzeXr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9vXR_ao69_KeVYq+j3VzeXr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, 5 Mar 2024 09:17:37 +0000 Lee Jones <lee@kernel.org> wrote:
> On Tue, 05 Mar 2024, Stephen Rothwell wrote:
> > On Mon, 26 Feb 2024 13:28:28 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > After merging the backlight tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
> > > drivers/video/backlight/ktd2801-backlight.c:8:10: fatal error: linux/=
leds-expresswire.h: No such file or directory
> > >     8 | #include <linux/leds-expresswire.h>
> > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >=20
> > > Caused by commit
> > >=20
> > >   48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")
> > >=20
> > > I have used the backlight tree from next-20240223 for today. =20
> >=20
> > I am still getting this failure. =20
>=20
> I just pushed a bunch of patches.

I saw only 3 new ones (forgot to push?) none of which addressed this
problem.

> Please let me know if this is still an issue tomorrow.

The problem is that after Feb 23, you rebased your tree and dropped commit

  25ae5f5f4168 ("leds: Introduce ExpressWire library")

which (added the leds-expresswire.h header), but kept commit

  48749e2f14e3 ("backlight: Add Kinetic KTD2801 backlight support")

which uses it.

--=20
Cheers,
Stephen Rothwell

--Sig_/9vXR_ao69_KeVYq+j3VzeXr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXnousACgkQAVBC80lX
0GzvpQf+LpW0f+pPYZGMDwa9MVRZzaUhvS3XxC+acND+xC7mZ8LAY+Bcj+1MAOIW
T6xquxtXWQ+pc0RVP01HujbcbmaKj53EZC4VkbjSpytUkucuMY7/omqJ7NExvHDr
T8EvnPbL83L2Xv3vfnr6CfbuapCQG/LzZuwCYM75/sJpGOqNWY4BcX22FQ+VGRtS
CJHLBb8hmPbW5q/eN3Sk0vGRo2Zqn/pkPDcE7wdB78AYeX7VEe3dBFgd4ICKNkzk
fS4kWXjx78QaaUn2q4J0JsDwaL8mucaREezOZV97A3RP9XD/V4gKxTc9xd1ATuM8
5Zl2U7JhKFA1AcG8h2FqM2prUXQ4Vw==
=2YMI
-----END PGP SIGNATURE-----

--Sig_/9vXR_ao69_KeVYq+j3VzeXr--

