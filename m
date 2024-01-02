Return-Path: <linux-kernel+bounces-14003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919B98216BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DADF1F218A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671AC10E1;
	Tue,  2 Jan 2024 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MSH5f8Dt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F00EBF;
	Tue,  2 Jan 2024 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704167367;
	bh=fHH2oL5nwatjdyOgNtoiTqFaYGBo4OoqMQjSZLVF+N8=;
	h=Date:From:To:Cc:Subject:From;
	b=MSH5f8DtAwJHOoRk1DPqduTTJeF/Xi4jsKsBhsoW/i3fEs/aBNKK6AVpeWxcc+iKV
	 I2UIs0/oSe5yE18b722exYGgudFhIYW8TDtQKFftE8Dn81d4MRphXKNHekMZyUlKUv
	 hSqiun8yL48o18f0r+NUlHaRN/zhKZMDRmdnL3qmZCyI1Ub8m6LZR+ljVH8zqPHKQn
	 jIopWmPOwBOTkJEZWj9vZRrHziA5dhs7De3oMxOSnlYOf2BzGBOrFa4cH0SQ4BAU7A
	 FMzXrd7rg7r0Y7FI8vqoGaXWhFdv2x000cS9wZjbM22IOZL+RbhG5+UW4JFq0RNAZb
	 FyMdXwfhfxtOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3zPL2C8kz4wxX;
	Tue,  2 Jan 2024 14:49:26 +1100 (AEDT)
Date: Tue, 2 Jan 2024 14:49:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Dave Jiang <dave.jiang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the cxl tree with the pm tree
Message-ID: <20240102144924.1fdfa044@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f6bH5xUlDv/hJA7yK.XU.zQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/f6bH5xUlDv/hJA7yK.XU.zQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  include/linux/acpi.h

between commit:

  f47507988145 ("thermal: ACPI: Move the ACPI thermal library to drivers/ac=
pi/")

from the pm tree and commit:

  ca53543d8e34 ("acpi: numa: Add helper function to retrieve the performanc=
e attributes")

from the cxl tree.

Dan, thanks for the heads up.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/acpi.h
index 118a18b7ff84,8b0761c682f9..000000000000
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@@ -424,13 -425,16 +425,23 @@@ extern int acpi_blacklisted(void)
  extern void acpi_osi_setup(char *str);
  extern bool acpi_osi_is_win8(void);
 =20
 +#ifdef CONFIG_ACPI_THERMAL_LIB
 +int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *=
ret_temp);
 +int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_tem=
p);
 +int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
 +int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_te=
mp);
 +#endif
 +
+ #ifdef CONFIG_ACPI_HMAT
+ int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord=
);
+ #else
+ static inline int acpi_get_genport_coordinates(u32 uid,
+ 					       struct access_coordinate *coord)
+ {
+ 	return -EOPNOTSUPP;
+ }
+ #endif
+=20
  #ifdef CONFIG_ACPI_NUMA
  int acpi_map_pxm_to_node(int pxm);
  int acpi_get_node(acpi_handle handle);

--Sig_/f6bH5xUlDv/hJA7yK.XU.zQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTh8QACgkQAVBC80lX
0GxdPAgAhA+s3BHKsaU1OvdOYJ4rEh13P2Xvl3m1AR36VmgCbDO6QtLramQl5dW8
V7dpjHs5wJbifzj2HLfhsL/jHFgykZOMvdkBK8N/ZDmW3TQ5xNKbrKWFx7HCSdkg
BgH3OAHkYJI2y5glhMFm4UyBy0uGr7kqzpRzFA21/35q1BRCzlcwJI7qT9tB8Dn1
gyNVfDt0wZrI20cg7EizQyVbraTPzq43xWX3FsnJjyh8XWi4kgR4mp7Q3llJhRld
4UkExckcrVBK2YPAcovWDY1RGVoO5nHlQVgSg8xk5Q91RvdNYmRXqU0tR/WNg9mc
cb1MeiKVjgq9Nuny8pt0WjYsSZbAkQ==
=OyXZ
-----END PGP SIGNATURE-----

--Sig_/f6bH5xUlDv/hJA7yK.XU.zQ--

