Return-Path: <linux-kernel+bounces-56999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A4784D28A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D92228AFA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328C126F12;
	Wed,  7 Feb 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LrJq38fd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C786ACD;
	Wed,  7 Feb 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336167; cv=none; b=UDUiiJiTR+saq6YFawA+LiC/Ar7vr4EjJ8oYWNIAOeK1MOQq39ZwbtlLrq/NS+Kkjt85sZ2YI8hZCus0H2kjOmvZ+6EQXods5zexSCnQqfMsQD2CCAKuY6WNLcUjp0P4Z0EIeyrbsc6ykSgyZ5tQ8SiBK6NXpWFNBPt8kBeQ6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336167; c=relaxed/simple;
	bh=DB7B69i3jx8KDB+O/YvXLsnTNXdtzAUcpJasF/SRJ60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYlXY3mOTXzbeB8cy2WR3lBMfeu7To+maZ4d0v2GnHWQ7muX/JGD4SSBbIi8HKb1Sta5pvVfo97xdmynNb+6tW168WS3objK1SkfVdhNwSKiq27FuOzNZHRHupGS35k5jEsx/PtNjp4hJRC+xpCBe7GTS2Lh8m7bZYXAT0BADLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LrJq38fd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707336160;
	bh=hBrq3eGQs3vOihvMl7KS8EhNCc86jiUVjvV8SoA2+bE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrJq38fdwda0XSw/lp+m2I7pyYdAJix5s8cb9ecKKfJoKzu/HnZd0xfFURR7UwfwI
	 s+f6ip+INA4rLmB28O/5mxQDVvgfRv4MdsfpniFswLu+fV42tD/pxdNFo7uCueqCKn
	 vkbPPEhM/bwjO/+YqEq1g/DzOu1hTy5cdIvVWYr6Ulg86FynuDfk/KAsbcZ4uUBaNC
	 z7I/SaYOIRFz9KP3s8a+KbUNe7VlG68801WT1X0HOX+C6MotPzdTUUYm6KBOyprXKV
	 N/0i88NFWCNWGOfd2xVyw7iwgu1DuhTnapcM1oFRQ/AtI4CZMpcz5ppFdiSAioFZBs
	 6CnPELCsZVc5g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVWHh3XFTz4wcW;
	Thu,  8 Feb 2024 07:02:40 +1100 (AEDT)
Date: Thu, 8 Feb 2024 07:02:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>, Linux
 Next Mailing List <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: MediaTek for-next: Replace matthias.bgg tree with mediatek
Message-ID: <20240208070222.3a916478@canb.auug.org.au>
In-Reply-To: <9e20a488-870f-4ff4-bfea-195a3f62b92e@gmail.com>
References: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
	<20240207090505.515d8977@canb.auug.org.au>
	<9e20a488-870f-4ff4-bfea-195a3f62b92e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fmv6X/wDyIF3AuBMd7QQ58L";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fmv6X/wDyIF3AuBMd7QQ58L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Wed, 7 Feb 2024 16:08:22 +0000 Matthias Brugger <matthias.bgg@gmail.com>=
 wrote:
>
> Please add Angelo to the contact list.

Done

For Angelo's benefit:

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/fmv6X/wDyIF3AuBMd7QQ58L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXD4c4ACgkQAVBC80lX
0GwLhAf/QYcyF+rsj9GN/2uMKqkIAkPCiPbwd4wrxpNG629jTIUb1A+bJMZj2SZ3
GKjY4/VgNaoQqDRv+c2J6YvHE+lJxV+aNXNl/QyM9DZXx7iftWxpQlb5QlSViz9I
LzyAhI1gaZvzHEXCAWcqDFiWwxJ96r5RNzhmZBezL4BY7hl7k1lH91SPO/+1zJs8
34J1G6tYUMq/ITnKMJX11zSgsWYy/bzZNaP1YgydV9e9K7lcYegYJyGEHCAKKdJ6
xR/le0eyVgUVakiP1p4RyOp1/TjyIXl+sChwtEqrE94c/qXpzsLKsTRpjphedFej
o9usQKVZ0UGkePL9O3/zwGBCBFiuDw==
=L0Bt
-----END PGP SIGNATURE-----

--Sig_/fmv6X/wDyIF3AuBMd7QQ58L--

