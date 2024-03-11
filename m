Return-Path: <linux-kernel+bounces-99579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E86878A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCE11F21AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6756B9D;
	Mon, 11 Mar 2024 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="D+Rxwz68"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544D56B6A;
	Mon, 11 Mar 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194077; cv=none; b=Y0eSbe1GhveAyIEN7tCCejdpjqLq06LEg8yE/fygUEXJi1aVoI6grZeA5KIApMI3vbjdJ8TmaYsl/vCOd0k/NJitPmRxuKWrEJVT0xosWSmjQ9erzjPKqcsrI36VIsPSbO8bPpDTp9urBIyMPBEVnvssk1xwv8eHMW04wbXs6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194077; c=relaxed/simple;
	bh=qKOCBiRdT7ONIMPrX5An2YO9OtQTJjkEdoD2DYEw3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1BO20dIXvdKr+zqR1rwG69Px/dlGFYGrn2+8fLFWWcyaxHlXHKRA1xwBVOUNw6dOBJRPIsG+wB5Mvvd+arHWXzon7i+ANu9tW2AV5NhugpL3F3iCKKTSRob7eNbHBAyjAXsuPE+EBOZf1r4l0d6kSA03mU2/3WhyrivhVnHVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=D+Rxwz68; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710194073;
	bh=RUmKkEb0MJyRI0HMKJM0OFW6Ocq9ArGyg20ZV6sGG0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+Rxwz68Q18EtsmongkmEUVp2m0FQHrlrgc9+F/Zah+MVI3sDnd89+pC6FZ9sSO1e
	 ZXnVoYcnnFBQWozd1Okj/eGlgrhi0YCLo120HAJW9Lz+tUMyDb4iVw+7GITUNWzqM2
	 HJCZ5PDJ1WTCb531brlW3KWRG4ZfuwrHYYIqk9E4Og6nG7jSyC3zbxIDKhEQaWavhd
	 dMPm5s9IHOAFIuey/jlQCThudLzWJuHeIaVgfvWOoVZtsr/GpoR/CD8OfywqJQ++ap
	 PgsjL7nhk6m42lyZuwbP5B2JHy1w7pVF8IeSrQ7dCL5UuvecnTpq90GlVF5g5RFKAT
	 gOaZjMd1QTg9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtrCX2z9hz4wyy;
	Tue, 12 Mar 2024 08:54:31 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:54:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
Message-ID: <20240312085431.19a66507@canb.auug.org.au>
In-Reply-To: <20240214112519.153c8480@canb.auug.org.au>
References: <20240214112519.153c8480@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uwa=wNrVgQ0bNBNVNM0J=gu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uwa=wNrVgQ0bNBNVNM0J=gu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 14 Feb 2024 11:25:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   include/linux/sched.h
>=20
> between commit:
>=20
>   d9233ee073c9 ("mm: document memalloc_noreclaim_save() and memalloc_pin_=
save()")
>=20
> from the mm-unstable branch of the mm tree and commit:
>=20
>   06b23f92af87 ("block: update cached timestamp post schedule/preemption")
>=20
> from the block tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/sched.h
> index 5b27a548d863,15b7cb478d16..000000000000
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@@ -1642,9 -1641,8 +1642,9 @@@ extern struct pid *cad_pid
>   #define PF__HOLE__02000000	0x02000000
>   #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to medd=
le with cpus_mask */
>   #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process pol=
icy */
>  -#define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained t=
o zones which allow long term pinning. */
>  +#define PF_MEMALLOC_PIN		0x10000000	/* Allocations constrained to zones=
 which allow long term pinning.
>  +						 * See memalloc_pin_save() */
> - #define PF__HOLE__20000000	0x20000000
> + #define PF_BLOCK_TS		0x20000000	/* plug has ts that needs updating */
>   #define PF__HOLE__40000000	0x40000000
>   #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_p=
rocesses() and should not be frozen */
>  =20

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/uwa=wNrVgQ0bNBNVNM0J=gu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvfZcACgkQAVBC80lX
0Gwl4wf/W7kbtcjKWDx0I+da/JKoTRRMGI860y/nieM+Mdj7ynVPg300jREifuom
4SBgjQn4UoHNIut34nPCtG2vkw530e8RgFVr9RpvD3SVWR+VHzyydmBJk3v89srq
THPBKY9DXxdEzCqSYFTpAJ61AxIqcIuQ9Q7wcBCc/tEoQTZhAx0L44GGPp/RcQ0y
CRaxbH3PJaDBeS2MxjveBtsGBPF+9sugN8SRyjPIc6sC6xexj+VR0AtcvZyybAdA
CmicjhAuleFBPQI5YWoRP8VCgH7sp+kQdbSplqK3TCnNdeZlYNKPFuBN+QmFs413
vAElabw3mHQAzDFI1lrJYbUt2I7dgw==
=hGfe
-----END PGP SIGNATURE-----

--Sig_/uwa=wNrVgQ0bNBNVNM0J=gu--

