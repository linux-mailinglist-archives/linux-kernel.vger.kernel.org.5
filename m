Return-Path: <linux-kernel+bounces-159544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A436D8B3003
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C81B22692
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF213A40D;
	Fri, 26 Apr 2024 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F6KURqXb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BF26AE3;
	Fri, 26 Apr 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111285; cv=none; b=N1n+LqJdX5dUtSbS+PJye5TFjXQNTSTPDrlFtYE1cYRZYLfW845FdCGrvuFIluYH8DaOXDTw2hY9eox6mOgAOa0vWN0a89VgHp6yoYIGHTqs4sAHyf2do7ekksKAMIID1PZx0hWiDxdE9m0MtQN085Go+LDUdXaz15oNeLnU1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111285; c=relaxed/simple;
	bh=DHy1YJTwuP4MLr0w/sLo3b5t2nMYXW8OcBH26mpmf6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f52iUOkgb09pPRcWY2bLN4AgYwZ2NS0aTZXT5k0EWZQhTP+Hf+N/Arxx85tiH3zBjuzPti7J+7za1VA1cfp2pbxtoqfsuJQkhbEPaTfS9P7jyeotgw9RHX3H9GPhSxnLqlxwd8J/9XfzU7hrxuXYmxiRfo+x7PJmXvzw6Un63UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=F6KURqXb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714111279;
	bh=MoGuqSkvq3te2HqshVymfGO+yIdfJnPtyUAQu8kGXEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6KURqXbjhcB45pBbwT7+NSQGiR6PjF7vLbEJ7VimfJodfi6ABQa2lvK64o9abzfX
	 XjY3wD2Gct1Cwcypg1DD6K0zi9E7uB7ZUCceEhJDLYd3+b/eWDfbfKShTa2fp7jg2l
	 Zqv13nGP6uvMI+Hm7eG6xbi48cZdoJkb7PiyOw6frF6qL5yHfRWzZmKYwdbuX8FtcR
	 JQs3W4RVbSR0pw56qT/CeuB717ePiuXJViXA9ZtyMnvRnM6ilG8VzGBn1mQsbrrx3a
	 UbrdIWszpeMi2cKCr//8Yddg0Fqe9fGBdk77JPOIkTof7NtpwVqPRDy+GhaaXbMThX
	 SNL2SNiVmT+Sw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQhtN70j4z4wcp;
	Fri, 26 Apr 2024 16:01:16 +1000 (AEST)
Date: Fri, 26 Apr 2024 16:01:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig
 <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with the block
 tree
Message-ID: <20240426160115.7797a43a@canb.auug.org.au>
In-Reply-To: <20240418145554.7a93325b@canb.auug.org.au>
References: <20240418145554.7a93325b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KKT_rzaTn=lRwZe/uW7OAsn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KKT_rzaTn=lRwZe/uW7OAsn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 18 Apr 2024 14:55:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the scsi-mkp tree got conflicts in:
>=20
>   block/blk-settings.c
>   include/linux/blkdev.h
>=20
> between commit:
>=20
>   e4eb37cc0f3e ("block: Remove elevator required features")
>=20
> from the block tree and commit:
>=20
>   ec84ca4025c0 ("scsi: block: Remove now unused queue limits helpers")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc block/blk-settings.c
> index 8e1d7ed52fef,292aadf8d807..000000000000
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@@ -1048,28 -822,22 +825,6 @@@ void blk_queue_write_cache(struct reque
>   }
>   EXPORT_SYMBOL_GPL(blk_queue_write_cache);
>  =20
> --/**
> -  * blk_queue_can_use_dma_map_merging - configure queue for merging segm=
ents.
> -  * @q:		the request queue for the device
> -  * @dev:	the device pointer for dma
>  - * blk_queue_required_elevator_features - Set a queue required elevator=
 features
>  - * @q:		the request queue for the target device
>  - * @features:	Required elevator features OR'ed together
> -- *
> -  * Tell the block layer about merging the segments by dma map of @q.
>  - * Tell the block layer that for the device controlled through @q, only=
 the
>  - * only elevators that can be used are those that implement at least th=
e set of
>  - * features specified by @features.
> -- */
> - bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
> - 				       struct device *dev)
>  -void blk_queue_required_elevator_features(struct request_queue *q,
>  -					  unsigned int features)
> --{
> - 	unsigned long boundary =3D dma_get_merge_boundary(dev);
> -=20
> - 	if (!boundary)
> - 		return false;
> -=20
> - 	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
> - 	blk_queue_virt_boundary(q, boundary);
> -=20
> - 	return true;
>  -	q->required_elevator_features =3D features;
> --}
> - EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
>  -EXPORT_SYMBOL_GPL(blk_queue_required_elevator_features);
> --
>   /**
>    * disk_set_zoned - inidicate a zoned device
>    * @disk:	gendisk to configure
> diff --cc include/linux/blkdev.h
> index 2c535af79529,e3c7082efa39..000000000000
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@@ -924,9 -942,15 +926,6 @@@ disk_alloc_independent_access_ranges(st
>   void disk_set_independent_access_ranges(struct gendisk *disk,
>   				struct blk_independent_access_ranges *iars);
>  =20
> - extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
> - 					      struct device *dev);
>  -/*
>  - * Elevator features for blk_queue_required_elevator_features:
>  - */
>  -/* Supports zoned block devices sequential write constraint */
>  -#define ELEVATOR_F_ZBD_SEQ_WRITE	(1U << 0)
>  -
>  -extern void blk_queue_required_elevator_features(struct request_queue *=
q,
>  -						 unsigned int features);
> --
>   bool __must_check blk_get_queue(struct request_queue *);
>   extern void blk_put_queue(struct request_queue *);
>  =20

This is now a conflict between the scsi tree and the block tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/KKT_rzaTn=lRwZe/uW7OAsn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrQysACgkQAVBC80lX
0Gz8Ygf/T9YDKkxxEewjA5z7RTHeZjrUambwAv2KWd2lU/A4h5jMu3VrfkNf4JVA
HsO6qL+geu1zH5/2ge/bGbz9tje0QoqECirMostG6a7mevwSI4vhIy0x8UWRYR/t
lLn9TtRs2lhmhu4LLsshsiT7+ID+wd9Ydr+dFxZHAcN4zrvrtQAwO9T7Rltq7wdH
tLU5RVZ4b1reMjtlus4kH6UHeksA7xyTKSVEvPukCk3DFfPAClZ+Q9LRhjwPve81
MOzHMg5D4YqgMBAEOJDSm4Afh+L3B+wPVKmFH6bF3QcnmyolxYKWqpEQOxSRCiU1
qW/E5jF9NrL72805B5ODFgrPk4B2oA==
=m3ng
-----END PGP SIGNATURE-----

--Sig_/KKT_rzaTn=lRwZe/uW7OAsn--

