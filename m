Return-Path: <linux-kernel+bounces-129882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05F897197
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394241F2569A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E514882F;
	Wed,  3 Apr 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSRab5p/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22551487E0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152259; cv=none; b=L/BvKWv9ZcjnoTmRCR48P14tcC3Gz9siH8xUTtJ1UEEYICcRprEPlA2ncaYvdzGha0kud87vglsrQsWNkNEN6dPDSrsygOFis3nq10KBb6f3qJdiYu8MzDshlBSqNN/+Nhjxl/lfZKOOSTkDJM+dgC/+DiD+H4pBhe2OEdJ768c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152259; c=relaxed/simple;
	bh=0w2WrMPgBEF7P+KBFC1PiBOaaNAE12UV7ArGCbs4Fpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcmwgV1EQwzh/6Dy2O1awflZTqnrWYqk18iM/R42Gle9LZlTa3f33GLOPPvnfiKuv73h5EeQZ0lXhdrwNjEFfIAuBYTLpwWGgqOBZi60ludMikVLu4viHJs5vETohOHwFcw5fG9NbxzK2bWfutHr1LXMn/T1MyU3ku4LAxPqBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSRab5p/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712152256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fbnyxTPoivxdulGiRzybrkcGRwKo49Gh1MYbg192HZY=;
	b=iSRab5p/C4pXQeGNdOCCiyW3CFtX3M8SOQDFoF8WIJfyurhrzdXJNoeW953AgJmH2I3XyY
	r6MFozkuiSWYAeA/71AKdxg1djHH0/YEg+yN8OKxWverapZfPOmspyVLnS8Uek8hTDZa93
	u6Pc9MHVo5pFD5nRz/+9M+Sav4XSnt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-h1MQqg0sPVK2IoQWIgyF3g-1; Wed, 03 Apr 2024 09:50:55 -0400
X-MC-Unique: h1MQqg0sPVK2IoQWIgyF3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A10DA101A535;
	Wed,  3 Apr 2024 13:50:54 +0000 (UTC)
Received: from localhost (unknown [10.39.194.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9649A40735E1;
	Wed,  3 Apr 2024 13:50:53 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:50:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 3/9] selftests: block_seek_hole: add loop block driver tests
Message-ID: <20240403135032.GB2524049@fedora>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-4-stefanha@redhat.com>
 <xh2nqmndk4rfnvghhmv6xlueleb4mdfa6v5vvamnxfyxb3eomb@yz5u2nldqewf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wef+JxaAyeGLmzI+"
Content-Disposition: inline
In-Reply-To: <xh2nqmndk4rfnvghhmv6xlueleb4mdfa6v5vvamnxfyxb3eomb@yz5u2nldqewf>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--wef+JxaAyeGLmzI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 07:11:30PM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 04:39:04PM -0400, Stefan Hajnoczi wrote:
> > Run the tests with:
> >=20
> >   $ make TARGETS=3Dblock_seek_hole -C tools/selftests run_tests
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/block_seek_hole/Makefile        |  17 +++
> >  .../testing/selftests/block_seek_hole/config  |   1 +
> >  .../selftests/block_seek_hole/map_holes.py    |  37 +++++++
> >  .../testing/selftests/block_seek_hole/test.py | 103 ++++++++++++++++++
> >  5 files changed, 159 insertions(+)
> >  create mode 100644 tools/testing/selftests/block_seek_hole/Makefile
> >  create mode 100644 tools/testing/selftests/block_seek_hole/config
> >  create mode 100755 tools/testing/selftests/block_seek_hole/map_holes.py
> >  create mode 100755 tools/testing/selftests/block_seek_hole/test.py
> >=20
> > +++ b/tools/testing/selftests/block_seek_hole/test.py
>=20
> > +
> > +# Different data layouts to test
> > +
> > +def data_at_beginning_and_end(f):
> > +    f.write(b'A' * 4 * KB)
> > +    f.seek(256 * MB)
> > +
> > +    f.write(b'B' * 64 * KB)
> > +
> > +    f.seek(1024 * MB - KB)
> > +    f.write(b'C' * KB)
> > +
> > +def holes_at_beginning_and_end(f):
> > +    f.seek(128 * MB)
> > +    f.write(b'A' * 4 * KB)
> > +
> > +    f.seek(512 * MB)
> > +    f.write(b'B' * 64 * KB)
> > +
> > +    f.truncate(1024 * MB)
> > +
> > +def no_holes(f):
> > +    # Just 1 MB so test file generation is quick
> > +    mb =3D b'A' * MB
> > +    f.write(mb)
> > +
> > +def empty_file(f):
> > +    f.truncate(1024 * MB)
>=20
> Is it also worth attempting to test a (necessarily sparse!) file
> larger than 2GiB to prove that we are 64-bit clean, even on a 32-bit
> system where lseek is different than lseek64?  (I honestly have no
> idea if python always uses 64-bit seek even on 32-bit systems,
> although I would be surprised if it were not)

Yes, it wouldn't hurt to add a test case for that. I'll do that.

Stefan

--wef+JxaAyeGLmzI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmYNXqcACgkQnKSrs4Gr
c8haRQf6AwEcxzTy4yYaPyNMUFI4yW1gzKFlXN451KGhjcejq6HevACTbBTLUy4o
uIiH5kiBM2XSl5k5m8E4oZeB5x6sWdHR+3OpwP9KoPvJfZinyoJbQM4CqIMQsWMM
RJ5pIM9XRqG6BkeNT5ni8zs7VgF8aIxXkzhuSLf5H3WKKpqcXNfmMTuHUOWyOhtn
AkfAYK6Mvzwucyv3HonafDbHokCB09BY5SKOcx4U2dz+7PKmiGxkjdanEOsAPHko
SUAF2pM1Koi3X+9xfs63eJAfwVGqMZB9W36nAMEybCnNedVPoJUiT6JUdfjQSDa+
hbxtZbvKkwZvaSxNRS81RwSszsK4vQ==
=qDQS
-----END PGP SIGNATURE-----

--wef+JxaAyeGLmzI+--


