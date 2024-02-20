Return-Path: <linux-kernel+bounces-72158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C710685B02B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017911C22861
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47073107A8;
	Tue, 20 Feb 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kFH28boZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28778F5A;
	Tue, 20 Feb 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390887; cv=none; b=ZMA+hl76BXm9VRtwKJUEUpxapSkURvCUdRPQEhkPGzxGUsH4lEA42ARJHgG5s52GWC0zJste9/ZwsxTa0a5eqLhHEYh+TpeXtOGBFc4+eeTI2YwwMh7QLjKl2KsIgaAjR9jRPgagde0CmGdd61MZPvKIpSIOf05US0NuX+4QRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390887; c=relaxed/simple;
	bh=3aq2fG9f3nGwD78W3+sZWhZmMz+P5W0q49/GZ7VZqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N1IuYQv0F6V1z4HeGFR8UAnZ28hje/rOq9aDWGD6ohFY3wYR5wUcnvbb15BOnp9/e3EOs4B5tHIKCb9jaVZInUcCE3D4xH6eLD26Ic0oS6mSu3Zj3IoaTbKCOD03cmLE2zceuxxYdh2QYE88+hS4FW28+2VChTjZqcgHAum3z6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kFH28boZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708390880;
	bh=/QnbAA4UFZibDJNMm9t2mwl+yycC9dhq5zbaE88Sa8E=;
	h=Date:From:To:Cc:Subject:From;
	b=kFH28boZbH/wdO38XVlkSkKOGuR9vjhV5pMfL3m5+i5IsvOu8QMcU+oEe/1kuCXbt
	 XBDyme+LFyfbsmtwGZHClqJT6GFzwQo5SxOZXhet4hBtcKbPDroy657+AS49KEW9K5
	 0d66ISl+V6v53Hwab6HHbv/daW8iiJ9D6pXjSf5YkYXHO7NiS2q0pdWulMD40dTjEk
	 FObd86f1crvR+Y4TW+MweoHbBNqz/5hFHFvc7y+Exq37daupeJzoP1TN6UaMLvh7Lz
	 ya+TvCgURGUcQnQL594ilm8Bb+sldFLuTRKmW6yb9JywpmuncSMYD4Uoo7gj8TmHBS
	 RXg7we2mr6FoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tf1Ll30c1z4wby;
	Tue, 20 Feb 2024 12:01:19 +1100 (AEDT)
Date: Tue, 20 Feb 2024 12:01:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Linus Walleij
 <linus.walleij@linaro.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mmc tree with the block tree
Message-ID: <20240220120117.15188a66@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e0IN+NzY_zOnSLZlol0gDPe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e0IN+NzY_zOnSLZlol0gDPe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mmc tree got a conflict in:

  drivers/mmc/core/queue.c

between commit:

  616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk")

from the block tree and commit:

  069279d6fef5 ("mmc: core Drop BLK_BOUNCE_HIGH")

from the mmc tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mmc/core/queue.c
index 2ae60d208cdf,316415588a77..000000000000
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@@ -343,50 -341,10 +343,47 @@@ static const struct blk_mq_ops mmc_mq_o
  	.timeout	=3D mmc_mq_timed_out,
  };
 =20
 -static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 +static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
 +		struct mmc_card *card)
  {
  	struct mmc_host *host =3D card->host;
 -	unsigned block_size =3D 512;
 +	struct queue_limits lim =3D { };
 +	struct gendisk *disk;
 +
 +	if (mmc_can_erase(card))
 +		mmc_queue_setup_discard(card, &lim);
 +
- 	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
- 		lim.bounce =3D BLK_BOUNCE_HIGH;
-=20
 +	lim.max_hw_sectors =3D min(host->max_blk_count, host->max_req_size / 512=
);
 +
 +	if (mmc_card_mmc(card) && card->ext_csd.data_sector_size)
 +		lim.logical_block_size =3D card->ext_csd.data_sector_size;
 +	else
 +		lim.logical_block_size =3D 512;
 +
 +	WARN_ON_ONCE(lim.logical_block_size !=3D 512 &&
 +		     lim.logical_block_size !=3D 4096);
 +
 +	/*
 +	 * Setting a virt_boundary implicity sets a max_segment_size, so try
 +	 * to set the hardware one here.
 +	 */
 +	if (host->can_dma_map_merge) {
 +		lim.virt_boundary_mask =3D dma_get_merge_boundary(mmc_dev(host));
 +		lim.max_segments =3D MMC_DMA_MAP_MERGE_SEGMENTS;
 +	} else {
 +		lim.max_segment_size =3D
 +			round_down(host->max_seg_size, lim.logical_block_size);
 +		lim.max_segments =3D host->max_segs;
 +	}
 +
 +	disk =3D blk_mq_alloc_disk(&mq->tag_set, &lim, mq);
 +	if (IS_ERR(disk))
 +		return disk;
 +	mq->queue =3D disk->queue;
 +
 +	if (mmc_host_is_spi(host) && host->use_spi_crc)
 +		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, mq->queue);
 +	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 =20
  	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);

--Sig_/e0IN+NzY_zOnSLZlol0gDPe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXT+d0ACgkQAVBC80lX
0GwSfQgAgVC/E7k+USeeFPFDDx//0VWoqW9KH5gnJil7zZdGqOrmxKhCkJYwa2g6
5OpHhSoqi4YH3A1du6ZrjzSRU2kVxuV0GPh2lcMqEB0nGTgsFHOaPvcm/3JZg7n9
JRMIYTRUT0K4UBL5ei+t3NQwokBul4bj2a4gRnlW6/9MxMZ2ETTZ+YqDsVHLLm/q
hXsTpg7MTmpWehWOwjOSjDdfSoglAcbBeg9JbWupwxpP8I+9EsP5j7FA5+FGG4Iw
gy8swEZA97/WrcvJia8ZRo+1+u4YyoSGFec+73TEPm8nxVaxYfEy0fkouB7FlAGG
PdVvbT3ahsBfKd6PyfQ7BcOXiAVlgQ==
=j7sO
-----END PGP SIGNATURE-----

--Sig_/e0IN+NzY_zOnSLZlol0gDPe--

