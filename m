Return-Path: <linux-kernel+bounces-22970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCA82A5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3924428A160
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6D8F53;
	Thu, 11 Jan 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G7CYmmba"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F445663;
	Thu, 11 Jan 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704939837;
	bh=y3zg8DRHWACr6iG7oCCXR9nMZmLa9pK1+1GoYga4RIM=;
	h=Date:From:To:Cc:Subject:From;
	b=G7CYmmbaq5bdjj5RP9oz98qvLalfc7h5aaHTYSmI96D9TozeaGQDBYjumHpbRibSi
	 8zljHraDO93xTg7bwaO1A3xerx832PPnF+rX4ZHD57c1Gjn8JHxCM0O4LTSXJvVByj
	 juyvr9XY7zSoRowIWeZoQDKUWwdNuY0ZL7jDDBQJ0FLNHd+DIPMj8dBHLlWSR0t743
	 H2iE04z/VCosMF0+MMqGBGDpKWafvmUwxB9D2J5GWUHI9uQ/93Yyx3JFarTZdZIdsx
	 G4myWsmzeo2ZVhA2CPnamga+rQ4HQZQizs81prF4zCnOpE6p4ILWa0R21UOYOftR3P
	 Bw5FuwoUG0jYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9T4X4JbNz4wcJ;
	Thu, 11 Jan 2024 13:23:56 +1100 (AEDT)
Date: Thu, 11 Jan 2024 13:23:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: linux-next: manual merge of the cxl tree with Linus' tree
Message-ID: <20240111132355.66a1240c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F8w1+gnMp5lJtZdPlIm1pv6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F8w1+gnMp5lJtZdPlIm1pv6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  drivers/acpi/apei/ghes.c

between commit:

  a70297d22132 ("ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED=
 on synchronous events")

from Linus' tree and commit:

  671a794c33c6 ("acpi/ghes: Process CXL Component Events")

from the cxl tree.

Thanks for the heads up, Dan.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/acpi/apei/ghes.c
index ab2a82cb1b0b,56a5d2ef9e0a..000000000000
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@@ -706,7 -762,23 +779,23 @@@ static bool ghes_do_proc(struct ghes *g
  			ghes_handle_aer(gdata);
  		}
  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 -			queued =3D ghes_handle_arm_hw_error(gdata, sev);
 +			queued =3D ghes_handle_arm_hw_error(gdata, sev, sync);
+ 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+ 			struct cxl_cper_event_rec *rec =3D
+ 				acpi_hest_get_payload(gdata);
+=20
+ 			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+ 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+ 			struct cxl_cper_event_rec *rec =3D
+ 				acpi_hest_get_payload(gdata);
+=20
+ 			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+ 		} else if (guid_equal(sec_type,
+ 				      &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+ 			struct cxl_cper_event_rec *rec =3D
+ 				acpi_hest_get_payload(gdata);
+=20
+ 			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
  		} else {
  			void *err =3D acpi_hest_get_payload(gdata);
 =20

--Sig_/F8w1+gnMp5lJtZdPlIm1pv6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfUTsACgkQAVBC80lX
0GwEYwf+KAPPTMtMbemBGwQgI8S4t9PlweH6cbxfkEr0imzTpff4KdGWvjgy3ADu
yd3fXkSI9FsaPDyBhOp0hvErnHsxRlPBafcaYqz6a5MkXnslFt2l8CgMsgEx/Ghp
/qZ5jtcwFs7RpGjMmCUvNAVT1s42E8tyX25/NPmvyXaqJO/cYu94a0/EwQXdiNTC
xIxn7lfY8KLuuVF23dB8twWQEKLxbBbW3XUs4rQEg/spBRjFuQ2JIZzLEiTLFFqV
b7pOtrBLqMzZqfZ7ej6ZT96E0R062fMw3SgAyZ736ZyjCKTzJuRT0DmnUyrGWeWX
m3mgbGi1Ji3FXmm1iKNPSaCBRgT8qg==
=YMTH
-----END PGP SIGNATURE-----

--Sig_/F8w1+gnMp5lJtZdPlIm1pv6--

