Return-Path: <linux-kernel+bounces-122399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7285388F65A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138281F264E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D581DA58;
	Thu, 28 Mar 2024 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LBm55BpC"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E381CAA4;
	Thu, 28 Mar 2024 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600159; cv=none; b=g2Gp/asTBvqvqqyYcIdoThrbf3QbTghnQ8fnssTj8VwRlftpgJAO/rhn390co7en2XKedEfWPHkfYVi3suk/7/gBRC4QXek8FkaTW9Za/hSlvC2npbg9v4ZlyqciwMC/MKlHGK3YT4FI+GM6/bapzonHzsJsl/0WTPZb9gMU+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600159; c=relaxed/simple;
	bh=CIvzlnavrIbUG7FqYLS7xePzVNGoLaww1aoB8ja2nZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2Qv/D5TYpVozg/wfkRwJzgh/RVXlEjj7tlclrtjNOxx/UXhRR996/IhxHDNBculA7Cd/hc9SDp46Qxpj+uOP9xHmwWw/44DeSrurYBki/ji0/endG9jMv7b5tFxZ8WOEbPBfsU0B0QiSVmKG4CjupABRDkTvrdesdLYPDd1EDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LBm55BpC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711600153;
	bh=8SmmU3G4Hba/aeZ/s+Rd6VFUIQbRgqQJ5YUydkamXfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBm55BpCa8LwCH3SDDu1oPYaJF3LmeXFiKiNZM3kLqr+xCgfBk4f30h3dBX4vgno/
	 E5YpoVE+nx+fc5jI+6+Uw+sX+uNKzi98s42bR47Tw1AomDw2HmpIGiU9Z6T0LttvMH
	 XTzBSe+DLEYe6A+EyJM4piBudwP6ugvRnk8u52Tn/QNeAJMiQ+SuxR2IcM1T6fh7Pw
	 i3zXx0FXpJMu+LCorxtFSFz6s0U5+hcXPxTeUSzW8fHbAKwg3b84BVxmPVQ4uGXJ5/
	 bfj+nzJ0OfORgC9ZPVGkEeY5+c3+AXLR8GZ/3bJH6iN/6Hb+b5lPg9JSG2Z6F1nryG
	 NTloOGo1GUQNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4rCY5cqFz4wcb;
	Thu, 28 Mar 2024 15:29:13 +1100 (AEDT)
Date: Thu, 28 Mar 2024 15:29:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20240328152911.305df593@canb.auug.org.au>
In-Reply-To: <ZgTPGJamrN+nJsfr@MiWiFi-R3L-srv>
References: <20240328091337.03421187@canb.auug.org.au>
	<ZgTPGJamrN+nJsfr@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vg/GUONZ4Ar4/kh7RpDQFpf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Vg/GUONZ4Ar4/kh7RpDQFpf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 28 Mar 2024 09:59:52 +0800 Baoquan He <bhe@redhat.com> wrote:
>
> On 03/28/24 at 09:13am, Stephen Rothwell wrote:
> >=20
> > After merging the mm tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > mm/page_alloc.c: In function 'build_zonelists':
> > mm/page_alloc.c:5324:13: warning: unused variable 'node' [-Wunused-vari=
able]
> >  5324 |         int node, local_node;
> >       |             ^~~~
> >=20
> > Introduced by commit
> >=20
> >   95d0185255a3 ("mm/page_alloc.c: remove unneeded codes in !NUMA versio=
n of build_zonelists()")
> >=20
> > from the mm-unstable branch of the mm tree. =20
>=20
> Thanks. Below code change has been queued on mm-unstable branch to fix it.

In my i386 defconfig build, this became an error, so I applied your fix pat=
ch.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vg/GUONZ4Ar4/kh7RpDQFpf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYE8hcACgkQAVBC80lX
0GxvUQf/TfAM2CALsjL+wc1wBlqg5l2hI/yUP5i9DR0yoZGaGPklheEJAMA3HQk0
lTcpUfqWhjQTv+OHAn8/ppEk1zB9Hzaj4Dpx36a5Lpl/aoZUOZNgLKTKhMkQrvL7
QfktpWpnEyzaDTyADHvxyaa6u29/1qNkppsgiyzcoCUpw4ocQVdGKu2gEsFzLL3c
MAUMkqx6usV/cKrTL2sIpMIQQxyrtIGRHLNibOfHCWh/mfK3wuj5a2MG/Y6dKWa7
tRFhjBBv8KzkVb1Yay7SIitx2qqtwbG/1dEPHiEG0D7t0hMrRQkwn04/t8WC4ni8
QWWgr6q+M8fyKqFEGYHCWb83xKj5dw==
=qDn+
-----END PGP SIGNATURE-----

--Sig_/Vg/GUONZ4Ar4/kh7RpDQFpf--

