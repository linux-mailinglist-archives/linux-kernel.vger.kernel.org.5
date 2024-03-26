Return-Path: <linux-kernel+bounces-118366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F101188B99A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A0B2288B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA1823C7;
	Tue, 26 Mar 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pofAQ7wg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAB2E62D;
	Tue, 26 Mar 2024 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711429285; cv=none; b=CPoOvQrIHuTAhCWoHQD9ij6nVzYMLPXXMBHg1fUAqugzwsUed6idyJli5+oJihD8NuKb2nb4snKdH8xs5Tp84v4eviT1UOiIClvIZAeQN1wuBE38rmmO0wD834ZU0GMbtHrqYuXlpWkWuOW2t1zNIkvHJ4Uy8iXSBVJltcqdtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711429285; c=relaxed/simple;
	bh=NuH2yXjmlzjCLZrukY4ylilmRicRHDoEO3Iofl74e48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mbWtqyo0VCvTcPUZ5OTOm0uYRYZ/O4gxMVcwA9DhLH9cyjCWKYlNcvtF0wa/88MwDeaoFGd+tHIlvn0dcEP94BXCFbM1+Yc2msfZcah588VP786GCLSLIbZsmlR3EACjuch1hRBE5UDxDje3IgixnrF/y/jZa7ihRlUe8W8G1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pofAQ7wg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711429275;
	bh=BZS8B38UoxEfsrQsv+4f+CeflI2wtNmGcp7UflMWLiY=;
	h=Date:From:To:Cc:Subject:From;
	b=pofAQ7wgNwf+39TQ4cr7h/IUZSZ4abkEwYZqJ2ZL6xDuH7bTa2REz0Ll7ZTUpwYEl
	 OBTq+CMad/d1AeFJ0AIoEzKbkXX9zNpOkcCLVtI+7ydog6UpdJPxrzm/MgruPWEfM3
	 RnX087soBHbHIxldlkVgyQ2XqGxxsmVTJTvV0gVtV4SYOaUYSzy1QAPyTasgQcmrHc
	 gFTx+LElI3vreWbEXcjazK9gZYUhGriNCys5G7AnED217ZRMzXNsVf2Nq8mq9gqH7T
	 BeL2L8/d1TlcMRKuWMqpstpNjLq0A9GH+YNgOHRbSP2vCMCQCOPNSTzHPT2UdTIGQE
	 vsXuz9Vyp1l7Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3d1Q0sMGz4wqN;
	Tue, 26 Mar 2024 16:01:13 +1100 (AEDT)
Date: Tue, 26 Mar 2024 16:01:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20240326160110.4c00e1e5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NHVutHcftGYyKXZT7QaPzsB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/NHVutHcftGYyKXZT7QaPzsB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/ABI/testing/sysfs-driver-panfrost-profiling:2: ERROR: Unexpec=
ted indentation.

Introduced by commit

  b12f3ea7c188 ("drm/panfrost: Replace fdinfo's profiling debugfs knob with=
 sysfs")

Also, that file does not have a newline at the end of its last line.

--=20
Cheers,
Stephen Rothwell

--Sig_/NHVutHcftGYyKXZT7QaPzsB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCVpYACgkQAVBC80lX
0GyfEgf/eRSy/oMHGhm+gbLCZD/n8bfQbAGEGhaHDa83QS4uJWVjamtrjKtI444Y
qZn6cfJ7J9dAOBTiht/rgBoAhDKxhiPNeFJj0zsryAytLsfEWRnkjTG5CUvbP9bM
lC4Fi/+ciYmdwnSY/uq2kzryO//bZc9o2EYJiVBz6NTlc3jHNqy0DyNkdgq7+AE2
7kdB0bbanRuxzdNA0aD6JAKpKeQr8UoI7OAnltMwRuKRucYwknYye+V94nzZV673
NDEI8IX9/A/FJMk860TUhGyzGIEcJ67+8mThCgGxKypVqNNbZdX6xBSy9K/A5cDS
KU/qHS6ENO8vaagIBidJf9ORyzd/4g==
=zB0h
-----END PGP SIGNATURE-----

--Sig_/NHVutHcftGYyKXZT7QaPzsB--

