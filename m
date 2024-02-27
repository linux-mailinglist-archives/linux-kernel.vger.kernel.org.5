Return-Path: <linux-kernel+bounces-82622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E76D86875D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F54C1C26690
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D1171A4;
	Tue, 27 Feb 2024 02:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bwT5wfSp"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDC1D54C;
	Tue, 27 Feb 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001841; cv=none; b=R/3uqtVFq6Ezq0soYqmozocnUJiGdo7t6Ya0VRE6cz6zsUYmhLv/soO/FtAz1kA1/3lH5j5T27nYdMfEmKNRVoGjZocGgYGs/9NB93NMgIMNWFuunze9de8N352iGmLcy1kUiSkP5SKUwz0ARutoz/B2azv70CC0FR3BO6BKisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001841; c=relaxed/simple;
	bh=iiGq6K19zAQWXKWSjpFfhyZI2qumKee2vIntciyHMTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=j63lL3n2KMgBO9l5x9o/pHZ8qpdFaOtV7CpDj4YtyjTdZW/YvnWV+55emasUbHopHxbFByhENW+IwgJ8JOb+Cj7hGD5pA7O2LS4Un1VuUw8CvkmMqi++nczTlchh2AHy0sGNZDhfb5V0Q7dbSVfx3rM8FSTc5Sr4OpMeJexwIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bwT5wfSp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709001836;
	bh=Rila1gg/PwUEodNHF5d59wbHdMS0gxNf9i+WHdZ8M2A=;
	h=Date:From:To:Cc:Subject:From;
	b=bwT5wfSpEIGceao1id0C/PfJ5URlDJBnh1fe+lWEHnp8zLh7ZnPc4QPEiYSmaUoZr
	 JTExUEqk77vvuzu4Ey8j9GSOJ/fe5zBr4ZEnvBdMWxGRhcq7AXVlPAZdGPDCsZAncE
	 4S3zOJXHuFJLSp647Y2diQyfMu/+17XhvhYHMl8CFIrB6rCtieAdKupHogCnARgjj2
	 +7pGyKJGS619gGD1uSgGyD8uSpUO+aTw8fGO6EzxOdcBFqXl0rzqugefL2e2hqzjs2
	 XACihR3JJDxL3nF4pod41oqCTWUPIyPrJjUXQKmLIBSc63f2lzlbDk2cr0J+8SQeM+
	 TNL4PWkY11sSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TkMHt6pdzz4wbQ;
	Tue, 27 Feb 2024 13:43:54 +1100 (AEDT)
Date: Tue, 27 Feb 2024 13:43:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the edac tree
Message-ID: <20240227134352.6deda860@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C4dCoS1g5NUh.vzFQtk/I=s";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/C4dCoS1g5NUh.vzFQtk/I=s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the edac tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/ras/amd/atl/umc.c: In function 'get_die_id':
drivers/ras/amd/atl/umc.c:318:44: error: implicit declaration of function '=
amd_get_nodes_per_socket' [-Werror=3Dimplicit-function-declaration]
  318 |         return topology_die_id(err->cpu) % amd_get_nodes_per_socket=
();
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  3f3174996be6 ("RAS: Introduce AMD Address Translation Library")

interacting with commit

  c749ce393b8f ("x86/cpu: Use common topology code for AMD")

from the tip tree.

I applied the following merge resolution patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 27 Feb 2024 13:22:56 +1100
Subject: [PATCH] fix up for "RAS: Introduce AMD Address Translation Library"

interacting with "x86/cpu: Use common topology code for AMD"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ras/amd/atl/umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 08c6dbd44c62..65a0ab651ee2 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -315,7 +315,7 @@ static u8 get_die_id(struct atl_err *err)
 	 * For CPUs, this is the AMD Node ID modulo the number
 	 * of AMD Nodes per socket.
 	 */
-	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
+	return topology_die_id(err->cpu) % topology_amd_nodes_per_pkg();
 }
=20
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/C4dCoS1g5NUh.vzFQtk/I=s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXdTGgACgkQAVBC80lX
0Gwa+QgAiQIbP1j90MTyouxjS1jTdKVwUt6L4/+hapVf4UC8lXVP8SyZEf2pdHDk
rDHtMCFLdNORLab67PYDLHZAH0HIsQfWXrPUt0GDXcv694aap2Jjo55eZSZ5pV5d
Iuci56176bd3uz5W70sFY7cU7/NlpcIQZUhhFmDSTM1JSY5ByJ3AYFWOg/OQjnt7
i6Qz6pxh70QW4B0dPz7ruyA4rwHe91MCiNJqaxS5vdrz1BDuZcpp0S2CBfFgNa6H
5Mo4VHHdAyx7Xd9pF2zNMXsD3/a9rkyOwz0/9oozDQ4XJRVXU3G+jvgxDT94LHrh
nDPGZ6N7ShNuRlPvApfH09O+oTDfLg==
=1um8
-----END PGP SIGNATURE-----

--Sig_/C4dCoS1g5NUh.vzFQtk/I=s--

