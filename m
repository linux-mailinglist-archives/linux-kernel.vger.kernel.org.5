Return-Path: <linux-kernel+bounces-144528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6498A4775
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ABC2828DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D86441F;
	Mon, 15 Apr 2024 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MUWtcC4T"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD92C7FF;
	Mon, 15 Apr 2024 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713156243; cv=none; b=YI1Ho6v36paxLpY+fY9ujwSwGbCOHJKn0lOEeyxMcvVSTLgKGzm6S32VMA+jmxCpXI5B1g222A8E6R4zHoYTzx7yfhzroW1fhfY28ITo4ZVpZKc8/l4POwEhBu3yClatPLxhdRh8QvPR3ghQ1GFACBeThWzExTFhOCnfOAjerwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713156243; c=relaxed/simple;
	bh=tROPoDs+YNbSfu3wO/cTBkEiIrCv0Tw11lrQXucmUuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GcwTFwbP4aJ0k5ZlFTUmQaVYyR/6NAgtlR0suwPL/MFbadW15Qs8XwquwQRSrz0CU4i2Xrv2XKTnvECCyU8unJrQ6tb1WBuK6FXo4IFoXX+rNGJ+oAh0v1LWe+A6pRpGEGWdH/x9pYgIzcvseVnHTMxp3hFDfq91sRKzReGC+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MUWtcC4T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713156240;
	bh=twty4K0CrsvQFb+F8K7zbMVF5RZ8yUMk6kgIDGLm//g=;
	h=Date:From:To:Cc:Subject:From;
	b=MUWtcC4TnFFNSt05Kvaan1FvOL7kqAERpIwnRo7YgQUyzytjR30oCNnAStLOhcJxF
	 cRHU1CDS3vP6ZOrFen9sWmy0b+1MR2dpI2QK8p9amzI/5CyP9uCqkEbjtjA5v+u9SO
	 /WoCNpfU2u6t+UUeNnTDwYcKgweQTIci9D9StLp5D42jliWzKiJExW/RcN3g1SoGv1
	 3354niw2BW5NapiJJMGXBvyqfiUJ6ZbP5PXIW4DM2PZPxxwlcZ7wBf7fw0CEq7rNCz
	 njS64PGyxZ4d387VIftooHrWfOKBcPZnuNuxBbD5DgWiVtAcHqKktcAOmrPOILy8JI
	 CvYDV4WO9W4MQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHvhH2bpnz4wcb;
	Mon, 15 Apr 2024 14:43:59 +1000 (AEST)
Date: Mon, 15 Apr 2024 14:43:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kselftest tree
Message-ID: <20240415144358.086d0a74@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dJhLPS3dA0bTEv+rMm2UAMQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dJhLPS3dA0bTEv+rMm2UAMQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  398d99519758 ("selftests/perf_events: Test FASYNC with watermark wakeups.=
")

This is commit

  e224d1c1fb93 ("selftests/perf_events: Test FASYNC with watermark wakeups")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/dJhLPS3dA0bTEv+rMm2UAMQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcsI4ACgkQAVBC80lX
0GzdoAgAh3hZWsCcTnjNQsxnepxurpAfHLbTYhKAvGVuTC/PXZzAwfiQxl9Q1O8e
vlJhGC45i7txPGr0E8qPr3UKN5lEGRiykWdbfRn6MhklFUSk6mfZ42DSPsJVrxX5
6R0k1+W9f6vp2B6vRVCCzwWba2W1ngDnpjw+myEUD3iM9N8Z6kGLArBdqSMDTVBV
6M1QlsWB26PXTACHt0PCNPVmk8e1u2K4xWG+7bPVuUrWZNtlPkmdqPASfMddrPUX
yxq5mlDawL8UmEwnafG0jJivWh8ZNc4QBHOujHwJEaXgTJYQbD/VCFopG5eqhNOG
a9tn9Z2l10zvdM+l98N70+/XlO1lTg==
=D67R
-----END PGP SIGNATURE-----

--Sig_/dJhLPS3dA0bTEv+rMm2UAMQ--

