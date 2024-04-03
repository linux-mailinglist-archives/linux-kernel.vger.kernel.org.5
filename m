Return-Path: <linux-kernel+bounces-130403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70168977A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF362833BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EC153BC7;
	Wed,  3 Apr 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SllZaHCM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BA152513
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167133; cv=none; b=oGc0l/GTIEHwVn4jlZCu61pO99WO8yuznR4tVS1O6JUp2XrWCgfDXkmy9Eh6rJe0NaLdw6FAEbHhdIy431NeIBfpD0mnKLxwBPhgiByISNO79ME9fbYYlZXh8DKbetOc6KfUEiHx7dzvhsGKt4ZNwZmzm9VaCfuh3N0RDEmRD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167133; c=relaxed/simple;
	bh=rVUr+9Z6zFvc1AIV7RSHph6ecLl/6yxn7os2D1j1n1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6mawVWZd/vl0rA0b79FiwL3xLHsciZQCiZ4j2fqrjmhbi1Z15bpVmmdxoCagyvR1oGwID0ESvC30TEVC8Lk/1UYlCvpaDunq4BCdgrC5OQ/8QF/NVagQ2UquSpohn+QY8BrdFmxLVramG0w7AdhmAgJ4MrY07dLtH+KneZDiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SllZaHCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712167130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoWWC9fUfdXuL312/PrgDfdNTqMt9C2B7PqNvW2X5jk=;
	b=SllZaHCMuFmL4zJ1Y+gkd/hBNEW8Cxi9zp+sa7ly3QrJl838dWAfCG+5T/qXbmFMtpjmn1
	yTc8Sj3Ic8E1wsXTCA7wRBjQ4mGcb+2BRev2vkJbzrZaGTkOGXpnOIXuTRwKeFDwhCWiH0
	8SipTDX60F6HBfazj/7qVNxNlyi9Ge4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-3meuzdLsN1u0ha3OmoqVeg-1; Wed,
 03 Apr 2024 13:58:45 -0400
X-MC-Unique: 3meuzdLsN1u0ha3OmoqVeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27F9529AA2CD;
	Wed,  3 Apr 2024 17:58:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC6EC01600;
	Wed,  3 Apr 2024 17:58:44 +0000 (UTC)
Date: Wed, 3 Apr 2024 13:58:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 4/9] dm: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <20240403175838.GB2534900@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-5-stefanha@redhat.com>
 <6awt5gq36kzwhuobabtye5vhnexc6cufuamy4frymehuv57ky5@esel3f5naqyu>
 <20240403141147.GD2524049@fedora>
 <mi3yp4kel6junjk2corv4hi56s56pmwilnm2bb4gg2tbbvyq2n@zmzaqpdq2rlq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N31yZm+DVUhVXgFt"
Content-Disposition: inline
In-Reply-To: <mi3yp4kel6junjk2corv4hi56s56pmwilnm2bb4gg2tbbvyq2n@zmzaqpdq2rlq>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--N31yZm+DVUhVXgFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:02:19PM -0500, Eric Blake wrote:
> On Wed, Apr 03, 2024 at 10:11:47AM -0400, Stefan Hajnoczi wrote:
> ...
> > > > +static loff_t dm_blk_do_seek_hole_data(struct dm_table *table, lof=
f_t offset,
> > > > +		int whence)
> > > > +{
> > > > +	struct dm_target *ti;
> > > > +	loff_t end;
> > > > +
> > > > +	/* Loop when the end of a target is reached */
> > > > +	do {
> > > > +		ti =3D dm_table_find_target(table, offset >> SECTOR_SHIFT);
> > > > +		if (!ti)
> > > > +			return whence =3D=3D SEEK_DATA ? -ENXIO : offset;
> > >=20
> > > ...but this blindly returns offset for SEEK_HOLE, even when offset is
> > > beyond the end of the dm.  I think you want 'return -ENXIO;'
> > > unconditionally here.
> >=20
> > If the initial offset is beyond the end of the table, then SEEK_HOLE
> > should return -ENXIO. I agree that the code doesn't handle this case.
> >=20
> > However, returning offset here is correct when there is data at the end
> > with SEEK_HOLE.
> >=20
> > I'll update the code to address the out-of-bounds offset case, perhaps
> > by checking the initial offset before entering the loop.
>=20
> You are correct that if we are on the second loop iteration of
> SEEK_HOLE (because the first iteration saw all data), then we have
> found the offset of the start of a hole and should return that offset,
> not -ENXIO.  This may be a case where we just have to be careful on
> whether the initial pass might have any corner cases different from
> later times through the loop, and that we end the loop with correct
> results for both SEEK_HOLE and SEEK_DATA.
>=20
> >=20
> > >=20
> > > > +
> > > > +		end =3D (ti->begin + ti->len) << SECTOR_SHIFT;
> > > > +
> > > > +		if (ti->type->seek_hole_data)
> > > > +			offset =3D ti->type->seek_hole_data(ti, offset, whence);
> > >=20
> > > Are we guaranteed that ti->type->seek_hole_data will not return a
> > > value exceeding end?  Or can dm be used to truncate the view of an
> > > underlying device, and the underlying seek_hold_data can now return an
> > > answer beyond where dm_table_find_target should look for the next part
> > > of the dm's view?
> >=20
> > ti->type->seek_hole_data() must not return a value larger than
> > (ti->begin + ti->len) << SECTOR_SHIFT.
>=20
> Worth adding as documentation then.
>=20
> >=20
> > >=20
> > > In which case, should the blkdev_seek_hole_data callback be passed a
> > > max size parameter everywhere, similar to how fixed_size_llseek does
> > > things?
> > >=20
> > > > +		else
> > > > +			offset =3D dm_blk_seek_hole_data_default(offset, whence, end);
> > > > +
> > > > +		if (whence =3D=3D SEEK_DATA && offset =3D=3D -ENXIO)
> > > > +			offset =3D end;
> > >=20
> > > You have a bug here.  If I have a dm contructed of two underlying tar=
gets:
> > >=20
> > > |A  |B  |
> > >=20
> > > and A is all data, then whence =3D=3D SEEK_HOLE will have offset =3D =
-ENXIO
> > > at this point, and you fail to check whether B is also data.  That is,
> > > you have silently treated the rest of the block device as data, which
> > > is semantically not wrong (as that is always a safe fallback), but not
> > > optimal.
> > >=20
> > > I think the correct logic is s/whence =3D=3D SEEK_DATA &&//.
> >=20
> > No, with whence =3D=3D SEEK_HOLE and an initial offset in A, the new of=
fset
> > will be (A->begin + A->end) << SECTOR_SHIFT. The loop will iterate and
> > continue seeking into B.
> >=20
> > The if statement you commented on ensures that we also continue looping
> > with whence =3D=3D SEEK_DATA, because that would otherwise prematurely =
end
> > with the new offset =3D -ENXIO.
> >=20
> > >=20
> > > > +	} while (offset =3D=3D end);
> > >=20
> > > I'm trying to make sure that we can never return the equivalent of
> > > lseek(dm, 0, SEEK_END).  If you make my above suggested changes, we
> > > will iterate through the do loop once more at EOF, and
> > > dm_table_find_target() will then fail to match at which point we do
> > > get the desired -ENXIO for both SEEK_HOLE and SEEK_DATA.
> >=20
> > Wait, lseek() is supposed to return the equivalent of lseek(dm, 0,
> > SEEK_END) when whence =3D=3D SEEK_HOLE and there is data at the end.
>=20
> It was confusing enough for me to write my initial review, I apologize
> if I'm making it harder for you.

No worries, if my code is hard to understand I can learn from your
feedback.

> Yes, we want to ensure that:
>=20
> off1 =3D lseek(fd, -1, SEEK_END);
> off2 =3D off1 + 1; // =3D=3D lseek(fd, 0, SEEK_END)
>=20
> if off1 belongs to a data extent:
>   - lseek(fd, off1, SEEK_DATA) =3D=3D off1
>   - lseek(fd, off1, SEEK_HOLE) =3D=3D off2
>   - lseek(fd, off2, SEEK_DATA) =3D=3D -ENXIO
>   - lseek(fd, off2, SEEK_HOLE) =3D=3D -ENXIO

Agreed.

> if off1 belongs to a hole:
>   - lseek(fd, off1, SEEK_DATA) =3D=3D -ENXIO
>   - lseek(fd, off1, SEEK_HOLE) =3D=3D off1
>   - lseek(fd, off2, SEEK_DATA) =3D=3D -ENXIO
>   - lseek(fd, off2, SEEK_HOLE) =3D=3D -ENXIO

Agreed.

>=20
> Anything in my wall of text from the earlier message inconsistent with
> this table can be ignored; but at the same time, I was not able to
> quickly convince myself that your code properly had those properties,
> even after writing up the table.
>=20
> Reiterating what I said elsewhere, it may be smarter to document that
> for callbacks, it is wiser to require intermediate behavior that the
> input value 'offset' is always between the half-open range
> [ti->begin<<SECTOR_SHIFT, (ti->begin+ti->len)<<SECTOR_SHIFT), and on
> success, the output must be in the fully-closed range [offset,
> (ti->begin+ti->len)<<SECTOR_SHIFT], errors like -EIO are permitted but
> -ENXIO should not be returned; and let the caller worry about
> synthesizing -ENXIO from that (since the caller knows whether or not
> there is a successor ti where adjacency concerns come into play).
>=20
> That is, we can never pass in off2 (beyond the bounds of the table),
> and when passing in off1, I think this interface may be easier to work
> with in the intermediate layers, even though it differs from the
> lseek() interface above.  For off1 in data:
>   - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) =3D=3D off1
>   - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) =3D=3D off2
> and for a hole:
>   - dm_blk_do_seek_hole_data(dm, off1, SEEK_DATA) =3D=3D off2
>   - dm_blk_do_seek_hole_data(dm, off1, SEEK_HOLE) =3D=3D off1

I'll take a look again starting from block/fops.c, through dm.c, and
into dm-linear.c to see how to make things clearest. Although I would
like to have the same semantics for every seek function, maybe in the
end your suggestion will make the code clearer. Let's see.

Stefan

--N31yZm+DVUhVXgFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNmM4ACgkQnKSrs4Gr
c8iAvgf/VrPqldLYrcFp72kYDOeOuDaMtnQx8rd3kAITiBtLHObhWuXOUCa4tb6i
npUgJhyNkUTfzPjkrbvEVjiGsRcVHTPCCAo1OiGU/na+hb2XpU8vAWi7kaoUWco/
K2nyJWOH8WLKSnF7/BysPZDlPa9q2mOsdFIndzIHuNwAQfqTdxvM0Qw6S8TnGmsO
5GAyjMkBQsxssBhymMz9/5HBUdGY1g5mGOJY3d0KB4QZZ3OpnvxcHLynq3RSl+wZ
2dRwccLASS6HiwCeUnWWpFqpe0/EZKkVeGiIlb2iCWK5VMM2eETRXGj/JXYECZfw
+JBARUyqNE2uYBGSpws1RS8qdssnMQ==
=f+tw
-----END PGP SIGNATURE-----

--N31yZm+DVUhVXgFt--


