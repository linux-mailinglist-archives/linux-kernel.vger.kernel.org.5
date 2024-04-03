Return-Path: <linux-kernel+bounces-129946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509DF89725F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747351C26F58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55914900F;
	Wed,  3 Apr 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gg7nhjKo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF27172B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154147; cv=none; b=WYe63+jIy+dzoOTz2TJIGrMFYuoov6RyWqRbRSfRpNrACqoJIZdue2eNzR++KkiJauACR9n6DpAxdtje9Is4qHmsShRJmf37XVN5uL/t0ylFA7L7DiR4/QHk+po50X35Cp7C/AlHMViRA4Uu2VTIEUWv2M/uQUOOUCtZzxumWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154147; c=relaxed/simple;
	bh=3LYCqRqJo7b/t9ay+AOpHdpbPnfNnxwvrpYGkT0RZ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/eKrUrDUQqAvUwYfAjyT0kK5P5w84kQew5weaFXV4zNaWpeRU9OgibBNJjHRRmGHZ1W5IntFpXGvgLGGbMUl0Sw30nAE5/cBIL5yp2CLSg6R3UwOXhUpr+uHvJgukUf6w8pj28ecJU5T6Rj7DL3Kj1nm958h2hYyMacBCE74eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gg7nhjKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712154145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTya/Q/Rf62E0aPWH36/IoxV0HlxJNgIz/hJZH8wy6Q=;
	b=Gg7nhjKo9D02KfDMwqD6ukQUb/ic1VLT2vxifh9G3f5bQk7kgn2Ss2Prrmlu03wyT+w3gd
	T6OLPFqHcIpjx7IfL4+wGZ0Qt9PMVc1Y46114Yhfx34cMk8wI/BOpIujsSNysLx+UdXcOV
	Dt88fmcrbCLmcyxP4PS8YRFYxt7NCl0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-3qwNAFrBPFS-6OvUtkQ42A-1; Wed,
 03 Apr 2024 10:22:23 -0400
X-MC-Unique: 3qwNAFrBPFS-6OvUtkQ42A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB7473C13AA3;
	Wed,  3 Apr 2024 14:22:22 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFDC2492BCD;
	Wed,  3 Apr 2024 14:22:21 +0000 (UTC)
Date: Wed, 3 Apr 2024 10:22:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 6/9] dm-linear: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240403142216.GF2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-7-stefanha@redhat.com>
 <zetfekdpoq6rmas26o7jl2uvricjcv6zygi6cngf6mkmiev5kn@e5d4ie3m77ku>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ThZrXlOWPAzKv2kI"
Content-Disposition: inline
In-Reply-To: <zetfekdpoq6rmas26o7jl2uvricjcv6zygi6cngf6mkmiev5kn@e5d4ie3m77ku>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--ThZrXlOWPAzKv2kI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:54:21PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:07PM -0400, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  drivers/md/dm-linear.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> > index 2d3e186ca87e3..9b6cdfa4f951d 100644
> > --- a/drivers/md/dm-linear.c
> > +++ b/drivers/md/dm-linear.c
> > @@ -147,6 +147,30 @@ static int linear_report_zones(struct dm_target *t=
i,
> >  #define linear_report_zones NULL
> >  #endif
> > =20
> > +static loff_t linear_seek_hole_data(struct dm_target *ti, loff_t offse=
t,
> > +		int whence)
> > +{
> > +	struct linear_c *lc =3D ti->private;
> > +	loff_t ti_begin =3D ti->begin << SECTOR_SHIFT;
> > +	loff_t ti_len =3D ti->len << SECTOR_SHIFT;
> > +	loff_t bdev_start =3D lc->start << SECTOR_SHIFT;
> > +	loff_t bdev_offset;
>=20
> Okay, given my questions in 4/9, it looks like your intent is that
> each callback for dm_seek_hole_data will obey its own ti-> limits.

Yes, exactly.

>=20
> > +
> > +	/* TODO underflow/overflow? */
> > +	bdev_offset =3D offset - ti_begin + bdev_start;
> > +
> > +	bdev_offset =3D blkdev_seek_hole_data(lc->dev->bdev, bdev_offset,
> > +					    whence);
> > +	if (bdev_offset < 0)
> > +		return bdev_offset;
> > +
> > +	offset =3D bdev_offset - bdev_start;
> > +	if (offset >=3D ti_len)
> > +		return whence =3D=3D SEEK_DATA ? -ENXIO : ti_begin + ti_len;
>=20
> However, this is inconsistent with dm_blk_seek_hole_data_default in
> 4/9; I think you want to unconditionally return -ENXIO here, and let
> the caller figure out when to turn -ENXIO back into end to proceed
> with the next ti in the list.
>=20
> OR, you may want to document the semantics that dm_seek_hole_data
> callbacks must NOT return -ENXIO, but always return ti_begin + ti_len
> when the answer (either SEEK_HOLE or SEEK_END) did not lie within the
> current ti - it is DIFFERENT than the semantics for
> blkdev_seek_hole_data, but gets normalized back into the expected
> -ENXIO answer when dm_blk_do_seek_hole_data finally advances past the
> last ti.
>=20
> At any rate, I know this is an RFC series, but it goes to show that
> comments will be essential, whichever interface you decide for
> callbacks to honor (both a guarantee that callbacks will only ever see
> SEEK_HOLE/SEEK_DATA in bounds, because earlier points in the call
> stack have filtered out out-of-bounds and SEEK_SET; and constraints on
> what the return value(s) must be for the various callbacks, especially
> if it is different from the eventual return value of the overall
> llseek syscall)

It's easier to understand the code when lseek function has the same
semantics, so I'd rather not customize the semantics for certain lseek
functions.

I'll make sure that the device-mapper targets match the
dm_blk_seek_hole_data_default() behavior. To be honest, I relied on dm.c
always passing offset values that are within the target, but that in
itself is customizing the semantics :).

--ThZrXlOWPAzKv2kI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNZhgACgkQnKSrs4Gr
c8hVBwgAl+Oz9WpdlpjFEbKoWMaJLh87SOHRM4LmyIy6J2xn736XJygEI434ZFda
OJrd1q8tc7E2r97Qg6m48sFXDJKsRwtqS/3g+sLaSKbtTgHkZEOQMHLjazDMtZC0
YPDyuzXMyupUDGNGkgQmAan1CXjIM0nVZekB/aIEBuAqOjXgPS02HAOgwM83o7O/
m55VskGkdJfM9WLg6yW32Y8HPstVkM2kK+67p7bSfXuGRwfkFj9v5vLqG93LVRLG
FWyh1qeBW2ufk1/ygBXasP3Fe60DlK36V2nrRs2tTOWXOMsNQUsq/fygjHlZmByI
n7SCc62GB/dCK5e6X7kHgpOyjd8AfA==
=sXQ1
-----END PGP SIGNATURE-----

--ThZrXlOWPAzKv2kI--


