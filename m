Return-Path: <linux-kernel+bounces-125046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57461891F31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63401F2EABB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A01153813;
	Fri, 29 Mar 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/jVvJI1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D612FF96
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716875; cv=none; b=pyPAR5gJ36igdfs+SvAqoC0vlv5dDtEtn4SVC1nzLnJdtDVy9Y4W0pELSzBGSb9o/YJ/h/5YM1QY1tg7tUt3GsSi3x5XeGrc7dEd1Xp3MxlLpUd3pwN3U9BlQq3OJTwRO5Ei/nS8L25R62QskPaKNXrW6hOetbI1oHdKUbx7hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716875; c=relaxed/simple;
	bh=q4ISZa1bjkpgcxTzPsAa/bfGXgqOjWEakuRnIBOiMzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2OLh7aTY4KnQ+pvyuTJEeRtHaWAeVYYqQkPifuw509+Ki1gdguyzN5+m/nzzmLHag0m3O6Oe7DPgIsjqpYAABikNRtvAbUnOROW6M+ILgA4yGoEjsSErQWxBMwBVdNwh4Kt+GAibaEHgEAcPRmo1EF617iwvMVGrDPM91lL2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/jVvJI1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711716872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WXr5ge2Ro0Gfnb1mE6GR/iBdI4y0shJZvyEqCg4t9i8=;
	b=D/jVvJI19Y0VWdNtVpNpuEEf9YyjBPkeLvN8ZX9Nq9GmW1IRp1YKy6MoMeK9gLbEvGr5Uc
	WX3jP5oWurKyzMts9RyCsVK76p2uQS47Gzn+FdUhO0W2Pm+o1kCYyHBNrpzYjBQB8B2V9c
	5x8a9j6bZYoMdwAzgpYqnG+opWbuNv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-cGgNYPFEM-ml5sNMqfrsYw-1; Fri, 29 Mar 2024 08:54:28 -0400
X-MC-Unique: cGgNYPFEM-ml5sNMqfrsYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C11C0800267;
	Fri, 29 Mar 2024 12:54:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F72F40C6CB1;
	Fri, 29 Mar 2024 12:54:26 +0000 (UTC)
Date: Fri, 29 Mar 2024 08:54:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 2/9] loop: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240329125405.GA2382288@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-3-stefanha@redhat.com>
 <wvdjesmnq6xrkanncathyciocbtxa6m3fefvx3za3ikxfs7uqx@wo22n4cvndr3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O0O0CfUZc75I8i/Q"
Content-Disposition: inline
In-Reply-To: <wvdjesmnq6xrkanncathyciocbtxa6m3fefvx3za3ikxfs7uqx@wo22n4cvndr3>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--O0O0CfUZc75I8i/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:00:26PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:03PM -0400, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Open issues:
> > - The file offset is updated on both the blkdev file and the backing
> >   file. Is there a way to avoid updating the backing file offset so the
> >   file opened by userspace is not affected?
> > - Should this run in the worker or use the cgroups?
> > ---
> >  drivers/block/loop.c | 36 ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 28a95fd366fea..6a89375de82e8 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -750,6 +750,29 @@ static void loop_sysfs_exit(struct loop_device *lo)
> >  				   &loop_attribute_group);
> >  }
> > =20
> > +static loff_t lo_seek_hole_data(struct block_device *bdev, loff_t offs=
et,
> > +		int whence)
> > +{
> > +	/* TODO need to activate cgroups or use worker? */
> > +	/* TODO locking? */
> > +	struct loop_device *lo =3D bdev->bd_disk->private_data;
> > +	struct file *file =3D lo->lo_backing_file;
> > +
> > +	if (lo->lo_offset > 0)
> > +		offset +=3D lo->lo_offset; /* TODO underflow/overflow? */
> > +
> > +	/* TODO backing file offset is modified! */
> > +	offset =3D vfs_llseek(file, offset, whence);
>=20
> Not only did you modify the underlying offset...
>=20
> > +	if (offset < 0)
> > +		return offset;
> > +
> > +	if (lo->lo_offset > 0)
> > +		offset -=3D lo->lo_offset; /* TODO underflow/overflow? */
> > +	if (lo->lo_sizelimit > 0 && offset > lo->lo_sizelimit)
> > +		offset =3D lo->lo_sizelimit;
>=20
> ...but if this code kicks in, you have clamped the return result to
> EOF of the loop device while leaving the underlying offset beyond the
> limit, which may mess up assumptions of other code expecting the loop
> to always have an in-bounds offset for the underlying file (offhand, I
> don't know if there is any such code; but since loop_ctl_fops.llseek =3D
> noop_lseek, there may be code relying on an even-tighter restriction
> that the offset of the underlying file never changes, not even within
> bounds).

I don't think anything relies on the file offset. Requests coming from
the block device contain their own offset (which may have been based on
the block device file's offset, but not the backing file's offset).

> Furthermore, this is inconsistent with all other seek-beyond-end code
> that fails with -ENXIO instead of returning size.

You're right, in the SEEK_DATA case the return value should be -ENXIO.
The SEEK_HOLE case is correct with lo_sizelimit. There is also an
off-by-one error in the comparison.

It should be:

  if (lo->lo_sizelimit > 0 && offset >=3D lo->lo_sizelimit) {
  	if (whence =3D=3D SEEK_DATA)
  		offset =3D -ENXIO;
  	else
  		offset =3D lo->lo_sizelimit;
  }

> But for an RFC, the idea of being able to seek to HOLEs in a loop
> device is awesome!
>=20
> > @@ -2140,7 +2164,7 @@ static int loop_control_remove(int idx)
> >  		pr_warn_once("deleting an unspecified loop device is not supported.\=
n");
> >  		return -EINVAL;
> >  	}
> > -	=09
> > +
> >  	/* Hide this loop device for serialization. */
> >  	ret =3D mutex_lock_killable(&loop_ctl_mutex);
> >  	if (ret)
>=20
> Unrelated whitespace change?

Yes, I'll drop it.

Stefan

--O0O0CfUZc75I8i/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYGue0ACgkQnKSrs4Gr
c8jpDggAtKqqz4GIKlteqyYksQXgYleVmkngDOnQAQp9bkmubJmmml9ZX6CMhB7X
HnmKX80aoDVIcy5KTFh1bcRLGJgzidr5vjuO3UT5MP3P+fEMiZzp2EfBRGqUsnY9
Sooj/8pCs7vLKcfXxKLRH15ME4+1tj1LhG8LVZRhKLYtuHXPE9MP3N4x4lwPOWy5
vypvEnduzoCor/mPGM7OUMroQd7BZtuZteACWSoI77koQ3pB/296Z5WJv3+Sg/SJ
jdJX963d2ylggR3CMeetgftzGfpP5Cb/ev26LwbTpAyLe3Uv2hBobhQaB2pKZ9ry
17rpr2bJwObaeAqsXmVDPAlUOqAHTg==
=iCZg
-----END PGP SIGNATURE-----

--O0O0CfUZc75I8i/Q--


