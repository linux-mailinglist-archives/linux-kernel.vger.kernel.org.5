Return-Path: <linux-kernel+bounces-14006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A378216C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05841B2152C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517C2101;
	Tue,  2 Jan 2024 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iImMsRKf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461A1856;
	Tue,  2 Jan 2024 03:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704167736;
	bh=9EJzV/K6BJHDIpYls8ca3lyX+yAhIKGtHlsors8qaBw=;
	h=Date:From:To:Cc:Subject:From;
	b=iImMsRKf9IcHsewduk7yOdcFUvwJ0vk7FY2bCgvNCLevQqnxDE9th4olCvzoBxeeH
	 1ZUfScF63xjpEKkhVHmUSAjnGc5vIp1kkiuxaF6f2h0uvAL5F+Jz5Ff/cYWMDzKaO8
	 aAHpWut+HRwyXOh6n5NDJKlg3rxlYpr56JgCngxkRL50Z6MvQh77NUCllLCg1RWnei
	 HU6+dJG+jnkgIs7CB/KwvWX0Zn89OugN9czqQ+8/Lx+n4EX4xJwRUM4FK/I6MBubXM
	 GXlHDySAbtjOWYNA/k19Y8oWyciYBaLazzqJz7YTcikOyf9DcEnY4d02CazctuOupS
	 3fTmfNKeTqrPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3zXS431hz4wx8;
	Tue,  2 Jan 2024 14:55:36 +1100 (AEDT)
Date: Tue, 2 Jan 2024 14:55:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Dave Jiang <dave.jiang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Yuntao Wang <ytcoode@gmail.com>
Subject: linux-next: manual merge of the cxl tree with the pm tree
Message-ID: <20240102145534.5c977c95@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a.JrPGJ7CTLo+ha_W7wqBAa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/a.JrPGJ7CTLo+ha_W7wqBAa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  lib/fw_table.c

between commit:

  4b3805daaacb ("ACPI: tables: Correct and clean up the logic of acpi_parse=
_entries_array()")

from the pm tree and commit:

  60e43fe5285e ("lib/firmware_table: tables: Add CDAT table parsing support=
")

from the cxl tree.

Dan, thanks again for the heads up.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/fw_table.c
index c49a09ee3853,1e5e0b2f7012..000000000000
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@@ -85,9 -98,27 +98,22 @@@ acpi_get_subtable_type(char *id
  	return ACPI_SUBTABLE_COMMON;
  }
 =20
- static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
- 					  union acpi_subtable_headers *hdr,
- 					  unsigned long end)
+ static unsigned long __init_or_fwtbl_lib
+ acpi_table_get_length(enum acpi_subtable_type type,
+ 		      union fw_table_header *header)
+ {
+ 	if (type =3D=3D CDAT_SUBTABLE) {
+ 		__le32 length =3D (__force __le32)header->cdat.length;
+=20
+ 		return le32_to_cpu(length);
+ 	}
+=20
+ 	return header->acpi.length;
+ }
+=20
 -static __init_or_fwtbl_lib bool has_handler(struct acpi_subtable_proc *pr=
oc)
 -{
 -	return proc->handler || proc->handler_arg;
 -}
 -
+ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *pr=
oc,
+ 					    union acpi_subtable_headers *hdr,
+ 					    unsigned long end)
  {
  	if (proc->handler)
  		return proc->handler(hdr, end);
@@@ -127,10 -158,14 +153,13 @@@ acpi_parse_entries_array(char *id, unsi
  {
  	unsigned long table_end, subtable_len, entry_len;
  	struct acpi_subtable_entry entry;
+ 	enum acpi_subtable_type type;
  	int count =3D 0;
 -	int errs =3D 0;
  	int i;
 =20
- 	table_end =3D (unsigned long)table_header + table_header->length;
+ 	type =3D acpi_get_subtable_type(id);
+ 	table_end =3D (unsigned long)table_header +
+ 		    acpi_table_get_length(type, table_header);
 =20
  	/* Parse all entries looking for a match. */
 =20
@@@ -168,9 -209,31 +197,31 @@@
  	}
 =20
  	if (max_entries && count > max_entries) {
 -		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
 -			id, proc->id, count);
 +		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
 +			id, proc->id, count - max_entries, count);
  	}
 =20
 -	return errs ? -EINVAL : count;
 +	return count;
  }
+=20
+ int __init_or_fwtbl_lib
+ cdat_table_parse(enum acpi_cdat_type type,
+ 		 acpi_tbl_entry_handler_arg handler_arg,
+ 		 void *arg,
+ 		 struct acpi_table_cdat *table_header)
+ {
+ 	struct acpi_subtable_proc proc =3D {
+ 		.id		=3D type,
+ 		.handler_arg	=3D handler_arg,
+ 		.arg		=3D arg,
+ 	};
+=20
+ 	if (!table_header)
+ 		return -EINVAL;
+=20
+ 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
+ 					sizeof(struct acpi_table_cdat),
+ 					(union fw_table_header *)table_header,
+ 					&proc, 1, 0);
+ }
+ EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);

--Sig_/a.JrPGJ7CTLo+ha_W7wqBAa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTiTYACgkQAVBC80lX
0Gxfjwf7BoXSKRmPb56yX1xFojky3aQn1ISSt90PYAKtNAarGy4pJOkLHznVjg+l
tcI5bWjvzanbSOZ3BJRPfOUdtyNBoM6tbfnstOFZJTyQNIe2amlgZppMDzr3MVeG
Vp+oIr6m3+V5/4n3No1uknJvr7c0DtpJJdj+pJbFzS9F5vTGwlSn076lDnrtaQgS
hN/p9pC1WgRNRO31m1cw862P99CfMvP9WWBX3g9KLxYk4pnlM5eJrwHYFpy3jV7g
fJWoA+tTD4et4pT1/YOlcCRTfje29lWG4s3NNfApUN+rOf3dM4W5rtcey+6tm0sf
0fYsdSS0H2jEArM9S7A9d6CMTuex/g==
=zpug
-----END PGP SIGNATURE-----

--Sig_/a.JrPGJ7CTLo+ha_W7wqBAa--

