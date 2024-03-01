Return-Path: <linux-kernel+bounces-88185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA986DE47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4811C2152F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02736A8DE;
	Fri,  1 Mar 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E3r8JZ91"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6E6A8D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285292; cv=none; b=Xm6TaGoAoT1L6bKAzBffCV/sEYqBd3RpnPhpqbIpPbZDCuKJ3P7XMNxH5J7vCA7mTfcIPqy7VipI1y8rIbeRdeyyI+NAv6tEWcETr1Lxwtk1fTUJQODejkzzn4p1uHMjAIF19r9SkYA2mLm1bP6KJXGvtjf8gab74A3lLlkgCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285292; c=relaxed/simple;
	bh=l7/w/M9Qg8/uTF4RCzKi8u0Y/0s8UezyrPjWXYLzReY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHMwb6KQDGczamoJLeoMaKamLOzMIIsoUivt2E7IxAstEjHpq8GZ5hqalfZlD45zhT0e1BbMAMbJTG1pnYouRgAM+grUwjZEIIbhGNpH3b8PW7pZM6cwI4gMtqhUGz4A10qYa3mWntX62fAZt7RexXucZq7/PPTR3szoRJlcZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E3r8JZ91; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709285289; x=1740821289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7/w/M9Qg8/uTF4RCzKi8u0Y/0s8UezyrPjWXYLzReY=;
  b=E3r8JZ91XbFUDYTC/PSNRPAuDRdWIPMz19g1ZhyS6td3xvSJHeUNRM6c
   10vzfnnn7uPDHLLoTCYw4XTS2FRY3dB3Qb0jjPoMAo1KgrXID7F2gM78T
   oupnJXyEqcLMbk/Kov4OMiehFgN0OaeHhMBpZSId0bVAWQMpR0Y06cB43
   OlYJeyeYvqC0RQYs6WxKUQl6m64/8Bsphr93eg4kGhicpaYr4UGF/cMwn
   eUD7j2ukflzXjOvVftS41dml2I1tmI7qBJw1rzLatdapB6W7GQWiUVUdZ
   22ljIlRjOLHETDn6+wXhSsy9pzsQpz38TZ8Up/BaVASz0H15NpQC7/wmo
   Q==;
X-CSE-ConnectionGUID: ygVnSIYfQEKFz2nIe+wEow==
X-CSE-MsgGUID: v34koBgySemG9lkf8xSESQ==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="asc'?scan'208";a="17056042"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 02:28:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 02:27:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 02:27:41 -0700
Date: Fri, 1 Mar 2024 09:26:58 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Message-ID: <20240301-reload-gristle-b417fe02f980@wendy>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
 <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
 <20240229-company-taste-daa305961e3a@spud>
 <ZeDO4CVOi6q4u8Lt@ghost>
 <20240229-dolphin-pennant-eef41ce44043@spud>
 <ZeDZnIemm06yU4KF@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OWPJFMUiteII9XLr"
Content-Disposition: inline
In-Reply-To: <ZeDZnIemm06yU4KF@ghost>

--OWPJFMUiteII9XLr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:23:08AM -0800, Charlie Jenkins wrote:
> > > > 1 probe: probe at boot time, falling back to emulated if not perfor=
mant
> > > > 2 emulated: always emulate it in the kernel
> > > > 3 slow: don't probe or emulate in the kernel
> > > > 4 fast: Your current fast option
> > >=20
> > > Emulated doesn't mean that the kernel will always emulate the unalign=
ed
> > > accesses. It means that the kernel has the ability to emulate them. It
> > > will only emulate them if the CPU traps on unaligned accesses. Kernel
> > > code can choose to forcefully align an address it thinks may cause an
> > > unaligned access, but that's slightly different from emulated.
> >=20
> > Sure, make option 2 "don't probe at boot time, emulate it in the kernel
> > if we trap". I suppose in this case though, to get a correct output in
> > hwprobe you'd have to still attempt an unaligned access at boot time to
> > see if you trap but it will not perform the speed test?
>=20
> Are you trying to cover the case here that the kernel is compiled as
> "emulate unaligned accesses" but the kernel isn't actually needed to
> emulate unaligned accesses?

Nope, the case "don't probe at boot time, emulate it in the kernel if
we trap" which is replacing 2 above.

> Seems like if the kernel is compiled as
> such it would make sense to report emulated with the assumption that if
> the kernel isn't emulating it, something else is.

Or maybe nothing is emulating it, we don't know. Feels to me like it
should report slow by default, given that's the option you can infer the
least information from, and then report emulated on trap.

--OWPJFMUiteII9XLr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeGfXgAKCRB4tDGHoIJi
0md+AQC9ln9J1hgmg38Hb8NELNWiEuurKRN0vtr8/lu8ceH4fQD/RjZiXsoMUXMx
e4Gjfj0VS2ezNPwHU685ZVn5/3sqogI=
=dmRT
-----END PGP SIGNATURE-----

--OWPJFMUiteII9XLr--

