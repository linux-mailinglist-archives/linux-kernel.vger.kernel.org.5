Return-Path: <linux-kernel+bounces-130027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5D897367
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA2DB2CCA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEAD14A4C6;
	Wed,  3 Apr 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KppKmpx9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40314A4C5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156657; cv=none; b=YS2QSV8eUAutz+kCT/xs7xZyLg5BemuA6paQRlbEWZqlOrnycH94dGcgi20Hr990fA4TEFZnB4747fY8j5LubCjH7d2ZnshcrzMsd4Iqqj4QISKdI9Ni0XP8PMVW8D0Uvle3HcbO15LGE2ZjYKeS3nLKJPiN9wcg63vH47vZAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156657; c=relaxed/simple;
	bh=k8uce1rf56gQTid1JBeAXtJeS2WnwUoqGN9N80BabCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiGOx42y/6ueXcDbWcm+DBTQT1wIWMfsxw1sFGZF4nTPOcRJDURwu/n+/ixfL1wJgeuGC8w+Q4wXU29FkxhgWeHbzAHNh5Qs8n9swHL1RbtapEo228yBmNbcP5hz+I0FmbNig0ixs4qC758jUAoXw3kncq/A0cM6uNpz+vP2Z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KppKmpx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712156654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t/jx0gVWX+z6DL+RdUWe4Xtrtk69fV0JhZ/qa15t2TM=;
	b=KppKmpx9T82zEP5tBn8HXYWb3KipkSBLsIgWKTmeOf3aPONgCHOTpSpIh1Qs5ZiEkBwgTr
	kea7u4jnDZIzfTBTW3RWzMKN+Iwi+E9xUiQgrst1ABeq1u7xjgTgbQE3kN6pffFcv63KwV
	j7dP/uzknOuyKoYM8FReyBxhSzVKRXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-2cBnbDAkODaeNogeLgoMow-1; Wed,
 03 Apr 2024 11:04:09 -0400
X-MC-Unique: 2cBnbDAkODaeNogeLgoMow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A4273816B4D;
	Wed,  3 Apr 2024 15:04:08 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA7E64073484;
	Wed,  3 Apr 2024 15:04:07 +0000 (UTC)
Date: Wed, 3 Apr 2024 11:03:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 8/9] dm thin: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240403150346.GH2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-9-stefanha@redhat.com>
 <c4pit5qf3sgiynx3jcnngdj7d3m62c5fdsgmla7twxynh6wfai@7jvhgxya4xo6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RRfDDrHk+pzHnTwS"
Content-Disposition: inline
In-Reply-To: <c4pit5qf3sgiynx3jcnngdj7d3m62c5fdsgmla7twxynh6wfai@7jvhgxya4xo6>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--RRfDDrHk+pzHnTwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 08:31:21PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:09PM -0400, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Open issues:
> > - Locking?
> > - thin_seek_hole_data() does not run as a bio or request. This patch
> >   assumes dm_thin_find_mapped_range() synchronously performs I/O if
> >   metadata needs to be loaded from disk. Is that a valid assumption?
> > ---
> >  drivers/md/dm-thin.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >=20
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 4793ad2aa1f7e..3c5dc4f0fe8a3 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -4501,6 +4501,82 @@ static void thin_io_hints(struct dm_target *ti, =
struct queue_limits *limits)
> >  	}
> >  }
> > =20
> > +static dm_block_t loff_to_block(struct pool *pool, loff_t offset)
> > +{
> > +	sector_t offset_sectors =3D offset >> SECTOR_SHIFT;
> > +	dm_block_t ret;
> > +
> > +	if (block_size_is_power_of_two(pool))
> > +		ret =3D offset_sectors >> pool->sectors_per_block_shift;
> > +	else {
> > +		ret =3D offset_sectors;
> > +		(void) sector_div(ret, pool->sectors_per_block);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static loff_t block_to_loff(struct pool *pool, dm_block_t block)
> > +{
> > +	return block_to_sectors(pool, block) << SECTOR_SHIFT;
> > +}
> > +
> > +static loff_t thin_seek_hole_data(struct dm_target *ti, loff_t offset,
> > +		int whence)
> > +{
> > +	struct thin_c *tc =3D ti->private;
> > +	struct dm_thin_device *td =3D tc->td;
> > +	struct pool *pool =3D tc->pool;
> > +	dm_block_t begin;
> > +	dm_block_t end;
> > +	dm_block_t mapped_begin;
> > +	dm_block_t mapped_end;
> > +	dm_block_t pool_begin;
> > +	bool maybe_shared;
> > +	int ret;
> > +
> > +	/* TODO locking? */
> > +
> > +	if (block_size_is_power_of_two(pool))
> > +		end =3D ti->len >> pool->sectors_per_block_shift;
> > +	else {
> > +		end =3D ti->len;
> > +		(void) sector_div(end, pool->sectors_per_block);
> > +	}
> > +
> > +	offset -=3D ti->begin << SECTOR_SHIFT;
> > +
> > +	while (true) {
> > +		begin =3D loff_to_block(pool, offset);
> > +		ret =3D dm_thin_find_mapped_range(td, begin, end,
> > +						&mapped_begin, &mapped_end,
> > +						&pool_begin, &maybe_shared);
> > +		if (ret =3D=3D -ENODATA) {
> > +			if (whence =3D=3D SEEK_DATA)
> > +				return -ENXIO;
> > +			break;
> > +		} else if (ret < 0) {
> > +			/* TODO handle EWOULDBLOCK? */
> > +			return -ENXIO;
>=20
> This should probably be -EIO, not -ENXIO.

Yes. XFS also returns -EIO, so I guess it's okay to do so.

I still need to get to the bottom of whether calling
dm_thin_find_mapped_range() is sane here and what to do when/if it
returns EWOULDBLOCK.

> > +		}
> > +
> > +		/* SEEK_DATA finishes here... */
> > +		if (whence =3D=3D SEEK_DATA) {
> > +			if (mapped_begin !=3D begin)
> > +				offset =3D block_to_loff(pool, mapped_begin);
> > +			break;
> > +		}
> > +
> > +		/* ...while SEEK_HOLE may need to look further */
> > +		if (mapped_begin !=3D begin)
> > +			break; /* offset is in a hole */
> > +
> > +		offset =3D block_to_loff(pool, mapped_end);
> > +	}
> > +
> > +	return offset + (ti->begin << SECTOR_SHIFT);
>=20
> It's hard to follow, but I'm fairly certain that if whence =3D=3D
> SEEK_HOLE, you end up returning ti->begin + ti->len instead of -ENXIO
> if the range from begin to end is fully mapped; which is inconsistent
> with the semantics you have in 4/9 (although in 6/9 I argue that
> having all of the dm callbacks return ti->begin + ti->len instead of
> -ENXIO might make logic easier for iterating through consecutive ti,
> and then convert to -ENXIO only in the caller).

Returning (ti->begin + ti->len) << SECTOR_SHIFT for SEEK_HOLE when there
is data at the end of the target is intentional. This matches the
semantics of lseek().

I agree there is adjustment necessary in dm.c, but I want to seek the
semantics of all lseek() functions identical to avoid confusion.

Stefan

--RRfDDrHk+pzHnTwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNb9IACgkQnKSrs4Gr
c8iUVwf/Zpv3IsSznycexR7MwM8g1Pl1+FVxzDf79d7uGFplkj6L9AEhUrePfHRh
cGxgeFgNqzKAAfDc6rWkEoGxm8Jq5J/OwaTQnMfS5qhmCSekIanhihEtmh2o+3vQ
5ugyOOADTaWx4AvxKNrfr+16kosIWS8NOHreUzqvYxEsqJ8H07PwZBDNUslQociS
BtFimE8NmN40GYgH9KetDIyfzxwDE87WPWD61iQBKtsjpHaHcFcI1wsu+jqItN3i
u7kLKlLBFyLGnuQjuCCYsOQR629RC1ZE4z2j2IEzJEOeQvnAD2YfGjBk7fdt1mXw
bk76t2gtHwIgCVbdS5wnu6Bt+Wl6Ow==
=zZmQ
-----END PGP SIGNATURE-----

--RRfDDrHk+pzHnTwS--


