Return-Path: <linux-kernel+bounces-55106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CE84B7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890D11F27CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A230132C19;
	Tue,  6 Feb 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkdI95DM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0992132464;
	Tue,  6 Feb 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229515; cv=none; b=l4BMkL25NAw7zz7+IY1SLqEjgsDh/rLn+HvbLjI4ySyh0b7YPE1N10hg0uB7nFFAfo7keK/jd6rJ4qBbGhGUb6HzF0SlowG6qMaN0xVGsWcZNVhaYxE/45QsWFNxCrs6HmfPTzPVsExzizs8OCyVWGMjDrzrAXyO2B39Al1Ft5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229515; c=relaxed/simple;
	bh=0VGhK+HezmmVvyHrl6zdHaTbhG2VV9gWiHy3q9uuyQc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bpykOKiO16Qh4h7UygeN0XO/zoisPZ7vyWQrgxzX6HPjOjS0gh2vgS3jj/3NvC84NsgidFifeciiUNZie6sQIVhZhdCSqqGEsCpwUCwflRz/Zi0GmiZZ8NJNYBd/eTwJowLnXa+IHZ7lBCJYOY4TanTIkOkqfQAMVp0zA2Aq7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkdI95DM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707229514; x=1738765514;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0VGhK+HezmmVvyHrl6zdHaTbhG2VV9gWiHy3q9uuyQc=;
  b=UkdI95DMz3HRFW5974FB1wglCW30dtjh8odgQCHdpwAsyZ2St6kDdW+T
   MB5E7TCB2t9H66Lo5jVvUeN7KOXy15X4rRuRAGREEM9+Oemo6uCTiezCe
   lvc9AW1Xal9mj5M4pS4Gtgprh+SCWBJyJ9ja71fyKq3F5RBCRf8c5Lycf
   Hnd1F6aaygbjPGrQEhU+bcH8yWMlDHRAAq6tyW0bLKgsUpIf6knGkQD5V
   W8UZdbgnQ/1AQAB1o9DzsWq7IctBWQil0OcTeA+uxu57fJPGbQLcuQSeq
   U5S3/KqeuVP5jdbrYG6AVT/2c4VRvvJzZDGa91+Ey41ep2UwmYOL4pVjF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="918545"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="918545"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933474688"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="933474688"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:25:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 16:25:06 +0200 (EET)
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] MIPS: PCI: Return PCIBIOS_* from
 tx4927_pci_config_read/write()
In-Reply-To: <CAMhs-H9QaQCz70dmBfMWJ4xoSagrYCJLqejA72fqb50uDwZY9A@mail.gmail.com>
Message-ID: <a0db7b09-75e0-2e31-5287-60f6be180d60@linux.intel.com>
References: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com> <20240205133450.5222-4-ilpo.jarvinen@linux.intel.com> <CAMhs-H9QaQCz70dmBfMWJ4xoSagrYCJLqejA72fqb50uDwZY9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1474976237-1707152415=:1027"
Content-ID: <a6079b97-9e10-d27a-72a2-25462cc0603c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1474976237-1707152415=:1027
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <76afa036-4192-9aa8-2f0d-bde05d65a403@linux.intel.com>

On Mon, 5 Feb 2024, Sergio Paracuellos wrote:
> On Mon, Feb 5, 2024 at 3:35=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > pci_ops .read/.write must return PCIBIOS_* codes but
> > tx4927_pci_config_read/write() return -1 when mkaddr() cannot find
> > devfn from the root bus. Return PCIBIOS_DEVICE_NOT_FOUND instead and
> > pass that onward in the call chain instead of overwriting the return
> > value.
> >
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  arch/mips/pci/ops-tx4927.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
> > index f7802f100401..4dd8b93985fb 100644
> > --- a/arch/mips/pci/ops-tx4927.c
> > +++ b/arch/mips/pci/ops-tx4927.c
> > @@ -60,7 +60,7 @@ static int mkaddr(struct pci_bus *bus, unsigned int d=
evfn, int where,
> >  {
> >         if (bus->parent =3D=3D NULL &&
> >             devfn >=3D PCI_DEVFN(TX4927_PCIC_MAX_DEVNU, 0))
> > -               return -1;
> > +               return PCIBIOS_DEVICE_NOT_FOUND;
> >         __raw_writel(((bus->number & 0xff) << 0x10)
> >                      | ((devfn & 0xff) << 0x08) | (where & 0xfc)
> >                      | (bus->parent ? 1 : 0),
>=20
> Should we also return PCIBIOS_SUCCESSFUL instead of 'return 0' in
> 'mkaddr' for coherency?

Yeah right, I'll change it too.

I didn't take notice of that because the reason for all this is that I=20
intend to convert these functions to return generic errno and push the=20
PCIBIOS error code -> errno conversion into where it's really needed (real=
=20
PCIBIOS access functions in arch/x86/pci/pcbios.c). Returning 0 as literal=
=20
is very common cosmetic "error" in these functions. While calculating the=
=20
error rate in return values of these functions (I'm able to do that=20
because of the audit), those were not even included to 15% returning=20
-Esomething instead of PCIBIOS_*. It would be way above that if I'd count=
=20
return 0 also as an error.

> Other than that, changes look good to me.
>=20
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks for the review.

--=20
 i.
--8323328-1474976237-1707152415=:1027--

