Return-Path: <linux-kernel+bounces-38873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A231983C7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C321C251DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB5129A66;
	Thu, 25 Jan 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwqjdWA1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF12AACA;
	Thu, 25 Jan 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199129; cv=none; b=ssN+F4yFwnOJMtoazyAtE+SKNDFroa0BiB10RN8X6/glVafib/sGbnLxipxKKGCibv9T+VUUWo7+NdQOpnSoLs03MhgJxVfgj71+AwLqBkFBuYcUR2cPOQQJG/Bfxwff/bTjxkRPLx1bAUbWtneAVnf2m01C97Puf8KmhCeoPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199129; c=relaxed/simple;
	bh=mDUOlVLrhkHD8tGE4iHD3AeMXzlT68MxWClAhVJxWjw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TgFDTOCpr3sPeXlfw+KGW80eepSAJKHnRmDwyTqBkkSu/93jtMr1tb80AlEMtliW5rWzqncF19xKh/EgzzaIMbMw1FanTmLEsgIghZLrFwgQfXo+LQIpdNYIw6M2DpndhmbUEysaXcscb+jW7BxtYxBq1yxiuHyVpF+yxUaA5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwqjdWA1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706199128; x=1737735128;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mDUOlVLrhkHD8tGE4iHD3AeMXzlT68MxWClAhVJxWjw=;
  b=YwqjdWA103rASeC93L+wVnYkTwViUWHO9TVxA8F6fBNLOWJzQvY5bv0w
   FBWKe+KHCASYWr2aqfE2rAAkMBbL2a7s12Jif9rgL3cUcndzqE6REBM87
   1VuLd4NKFalbM9mUAwU1Lpekwie0VKXw262R6uTbm+kPe7rmmfcy8POXL
   osQPAzei+If/zdJ6yBaxz+zbBc/LiPb2MJazJbUzebojwCRql6puFzRME
   5B8k/AlxCraLIuxx0VSKk+qZkS201qUZpzR5Dnz/CkhHTxV1QV5q45yNU
   ZWHcI0G6A4auwwHL2ocEnI056mKX2n9GHrYsO74QVNgBbgYxjAS5Bj6Gs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2074478"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2074478"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21092170"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 08:12:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jan 2024 18:12:00 +0200 (EET)
To: Ashok Raj <ashok.raj@intel.com>
cc: Jithu Joseph <jithu.joseph@intel.com>, Tony Luck <tony.luck@intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] platform/x86/intel/ifs: Remove unnecessary ret
 init
In-Reply-To: <ZbJ8gp47CWDDqCb4@a4bf019067fa.jf.intel.com>
Message-ID: <b9368410-e084-8d4e-1c81-55c4e6a22434@linux.intel.com>
References: <20240125130328.11253-1-ilpo.jarvinen@linux.intel.com> <ZbJ8gp47CWDDqCb4@a4bf019067fa.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-817356417-1706199120=:1444"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-817356417-1706199120=:1444
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 25 Jan 2024, Ashok Raj wrote:

> Hi Ilpo
>=20
> thanks for looking into it.
>=20
> On Thu, Jan 25, 2024 at 03:03:28PM +0200, Ilpo J=E4rvinen wrote:
> > ret variable is assigned unconditionally in ifs_load_firmware(), thus
> > remove the unnecessary initialization of it.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel/ifs/load.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x=
86/intel/ifs/load.c
> > index a1ee1a74fc3c..03e49b836a6b 100644
> > --- a/drivers/platform/x86/intel/ifs/load.c
> > +++ b/drivers/platform/x86/intel/ifs/load.c
> > @@ -383,7 +383,7 @@ int ifs_load_firmware(struct device *dev)
> >  =09unsigned int expected_size;
> >  =09const struct firmware *fw;
> >  =09char scan_path[64];
> > -=09int ret =3D -EINVAL;
> > +=09int ret;
> > =20
>=20
> Looks reasonable to me.=20
>=20
> I can keep this as a separate cleanup patch, or merge the change in this
> patch.
>=20
> What ever Hans/You prefer.=20

Hi,

I was thinking of merging it myself into pdx86 review-ilpo -> next after=20
allowing it sit on the queue a day or two. IMO, doesn't need to be more=20
complicated than the usual process kernel process with patches, it would=20
just take extra time from all the more there are middlemens handling the=20
patch (after all this is just a trivial cleanup which I noticed while=20
reviewing the patches you sent and since it didn't conflict the series,=20
I just sent the obvious cleanup).

But that's assuming you don't have anything conflicting beyond those=20
patches which you sent? If that's the case, it would be better for you to=
=20
take care of it so just let me and I won't merge it myself until it comes=
=20
back.


--=20
 i.

--8323328-817356417-1706199120=:1444--

