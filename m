Return-Path: <linux-kernel+bounces-96446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5155F875C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069E8283656
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006E2376D;
	Fri,  8 Mar 2024 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MCaHs1KZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0D22F11;
	Fri,  8 Mar 2024 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864381; cv=none; b=QDhtNMpqvVp7H0tZNsGNQdklbJ9OAbFNuNPkpqBZEc/grXTrIxlD/9sbMN1gFsRtMbssyZ5frpxS40I/iWnQ95T+e8fTDZ/Lz2Tkq3rIEBLYn112eb4QGFNA0491K5hIPr3iUjmmgWyENCTWjuiMlmh0CbJ0YeBfElpWoUsaKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864381; c=relaxed/simple;
	bh=jEKKWncFIet1rufkYRe68mqLkxAYAZAXq4oAsoY2bkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G58/jPCL4bz04Am/6X25eKbwP5vjJbWVQY962tm7eOvrA6m0LlIyTIRKewwYn837xbt/QP30h5+BVOWUecZgrw5+mz/nzSgSyPRwFrhn8WaKF7RWLjO/Q01NAgPZVSqc1QVJPYDSSfIq1hVw1EdyYpI6cDxY0AfiNeMydU55qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MCaHs1KZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709864376;
	bh=zIKQGstiXQEbvKG3LHJksm4TTs9yh+WBovi6ZfCV02o=;
	h=Date:From:To:Cc:Subject:From;
	b=MCaHs1KZG4HnP6sXNFscaDy7G7tBG8D9Ylx7Hd9Oi8ZLDLuo/GGDOVsSZ/XYeXJSI
	 jmVsaPxs0MdbpZACTI55LXeITZxC1k1u3ltO/Oqv3wPxheGB213iNr3FXjBX+WNGgs
	 jnRxoR4BYVUGFFzET1qXiI7p/RRmxLT7G7nKQiY0j17hhEHxUJjf1gAcq567vC4SYU
	 ALP4/vs/f9cn6A+th14POZ0PBCvqJ1SpbN8Mo2jQAK0uh1TopLJxrq4N6+z0+uSVB6
	 M0oIrViOcaGKlwD6m9KzQxTFPdNhcdmCGDrg4b8IOfRDsdbR1wAUL22zYspR1JNbKN
	 pWm4/NsSyhlEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TrVHC2vCxz4wcF;
	Fri,  8 Mar 2024 13:19:35 +1100 (AEDT)
Date: Fri, 8 Mar 2024 13:19:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Patil Rajesh Reddy <Patil.Reddy@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20240308131934.298896a6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8+YDfKVQAwrzrWrwQvV.Eem";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8+YDfKVQAwrzrWrwQvV.Eem
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/amd/pmf/core.c

between commit:

  11e298f3548a ("platform/x86/amd/pmf: Fix TEE enact command failure after =
suspend and resume")

from Linus' tree and commit:

  6eacd474b8be ("platform/x86/amd/pmf: Add support to notify sbios heart be=
at event")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/amd/pmf/core.c
index 4f734e049f4a,53c0f61e5c5f..000000000000
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@@ -296,9 -297,11 +297,12 @@@ static int amd_pmf_suspend_handler(stru
  {
  	struct amd_pmf_dev *pdev =3D dev_get_drvdata(dev);
 =20
 -	kfree(pdev->buf);
 +	if (pdev->smart_pc_enabled)
 +		cancel_delayed_work_sync(&pdev->pb_work);
 =20
+ 	if (is_apmf_func_supported(pdev, APMF_FUNC_SBIOS_HEARTBEAT_V2))
+ 		amd_pmf_notify_sbios_heartbeat_event_v2(pdev, ON_SUSPEND);
+=20
  	return 0;
  }
 =20
@@@ -313,9 -316,9 +317,12 @@@ static int amd_pmf_resume_handler(struc
  			return ret;
  	}
 =20
+ 	if (is_apmf_func_supported(pdev, APMF_FUNC_SBIOS_HEARTBEAT_V2))
+ 		amd_pmf_notify_sbios_heartbeat_event_v2(pdev, ON_RESUME);
+=20
 +	if (pdev->smart_pc_enabled)
 +		schedule_delayed_work(&pdev->pb_work, msecs_to_jiffies(2000));
 +
  	return 0;
  }
 =20

--Sig_/8+YDfKVQAwrzrWrwQvV.Eem
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXqdbYACgkQAVBC80lX
0Gw90Af/WbMcpALSA2+OiGKe5pjACDO8alCbWBoMIJNaCjqzHMcIXChPX9YGPSb2
95VvXIKh0FEurqLd62oJxJlPP8caNjztLBa5OBSEBnMArTJbOr2wp/NuSSaLZgum
CKiGJIv4v3In145CX/dR7Th7JkrvzneWZuKURfltYGYcBANUrEPah4/4vcagGr47
ntsDdzg9EYygJtZQA01eeGowTh38sQpm+OJ2n8Ln0/hDJcrhxxlJgEQ/RYBYZUOX
MGd/+h5hnqM4c+rg16bFbbJ1h65socgrg6Mj94Lm2OxHmSEBv3Jkd2c5zdkPrIGc
5hr+ct7V6AS0VtZ7iTrBylCpFMYNGQ==
=erO+
-----END PGP SIGNATURE-----

--Sig_/8+YDfKVQAwrzrWrwQvV.Eem--

