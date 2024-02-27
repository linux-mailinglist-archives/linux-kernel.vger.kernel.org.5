Return-Path: <linux-kernel+bounces-83556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817A869B60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD7E28345B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC614690C;
	Tue, 27 Feb 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haDg/0xO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB714691C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049369; cv=none; b=fQnDBWsXX820brhJO9sJA0UIzcxfyhsLvJFQTzTHhalKOzJjwGbdLuV/eplcyUy95/05l3LU80Ew+ZOCIQI3CEfVjXfPKX1jbLJarqzdrV8cNWTMDl3wDxS72rylkxlyaaOetDen0hlVp+EMSJZSiuEwWqry7/1OByB11ekrMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049369; c=relaxed/simple;
	bh=s3wlEquGysXZAaufy+BZCB9S+atZVvdmjHpRk6wPMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRC3PfqUXGyYaOg/v2cmrwf3saSClRmibpQuUmL4DkZ3b2kTPw+R/tKss2fwYMtQzGjW1kypN4KBlLfSbS0QG3H3l6DcLZF+IZqp8g4uHa5npVD1dhMtLxxCBxCZNf3m05jUHmAQbcDDFdqoh9qNr7I18WL/d7DJy7LMAavyXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haDg/0xO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709049366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3wlEquGysXZAaufy+BZCB9S+atZVvdmjHpRk6wPMeo=;
	b=haDg/0xOAo2Hr06NKLfCpPv+yiOfnEoX+cooNZXB+IPuNrUVa0o3b3PfQjGD8W0X0jZ/9Y
	wL61rvA+zcZKCy5fy2Q+ysilFoRfW5vAnm3Dz8aLpazrYRzizT5B+r4MPNwXW0mF8WNbDE
	MIY4q48OS4zMgoKLZ9wqW7t1e2ujWo0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Z9UyeypHOFWe3T3UrO0UeQ-1; Tue, 27 Feb 2024 10:55:57 -0500
X-MC-Unique: Z9UyeypHOFWe3T3UrO0UeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1082185A782;
	Tue, 27 Feb 2024 15:55:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE0F3492BE2;
	Tue, 27 Feb 2024 15:55:55 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:55:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: linux-next: Tree for Feb 26 (fs/fuse/virtio_fs.c)
Message-ID: <20240227155554.GD386283@fedora>
References: <20240226175509.37fa57da@canb.auug.org.au>
 <81c5b68d-90ca-4599-9cc8-a1d737750aaa@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P7SwKHF8daUBXYQU"
Content-Disposition: inline
In-Reply-To: <81c5b68d-90ca-4599-9cc8-a1d737750aaa@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--P7SwKHF8daUBXYQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 05:01:33PM -0800, Randy Dunlap wrote:
>=20
>=20
> On 2/25/24 22:55, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20240223:
> >=20
>=20
> on 20 randconfig builds (arm64, loongarch, riscv32, riscv64, i386, and x8=
6_64):
>=20
> WARNING: modpost: fs/fuse/virtiofs: section mismatch in reference: virtio=
_fs_init+0xf9 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit=
=2Etext)
>=20
> For
> static void __exit virtio_fs_sysfs_exit(void)
>=20
> probably just s/__exit// since it is called from both
> __init and __ext code.

Thanks, Randy. I am sending a fix.

Stefan

>=20
>=20
> --=20
> #Randy
>=20

--P7SwKHF8daUBXYQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXeBgoACgkQnKSrs4Gr
c8ixNggAug/rstk7tDL114D+Pvuc4VMmv9y4avToZ/AnAUhGuHymMB76nvVGpmnw
fvxQiTO7esRLuVXEdJ9MZHStvl6TP/dAP6ZgwHwew4WjAVG7lg369lgFn/QluZ1R
B4Fh6bkUVSETnvZRYL+7RwctDS0fcVQTg781QuMx2JP7GsBXUd7P9FFDTFTs1nYy
4EXJVXS/H0t5l9l6lQS1RZ70Qx+ozB3wlaU4pa5tQGxNH59fvJEu2UjtckQConqQ
nDFkn0O/9aqtImsKCXEKoqYKbk5WdxQyLPOhblTWxEqu7eUzWLQFLqMb3FfPxMgQ
GhSfVKjxQ8iIATRWfLl7qcSdnjJ3CQ==
=mGX0
-----END PGP SIGNATURE-----

--P7SwKHF8daUBXYQU--


