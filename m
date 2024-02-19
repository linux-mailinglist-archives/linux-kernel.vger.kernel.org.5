Return-Path: <linux-kernel+bounces-71259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0385A297
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98D01F21118
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9C2C85C;
	Mon, 19 Feb 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCk+6lzP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EE2561A;
	Mon, 19 Feb 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343835; cv=none; b=AXkU69WCMG3JGl2iF7XKDz4JmvPFjHAEdmZoC6gAPj2u/jcv5uZymb8DM6fjrNBTSPlbvyueILpDmVFeIvO3jANh3LYZqBOzde5WtnCXXMUBESuSafiOLogeB0xx0eOC8dPz5j5p/gTWDcIsPQP5QUU3kxQM9ui7nu2yImoZfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343835; c=relaxed/simple;
	bh=tpEZvY4JNPf3zA/5+c+vBc9IYvKrcWuT2LwwwYik6zA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XI5F9wmd2PpQk6NuVvAk50VlZpPuHB4vn4ZVTO+GD6cFupWiO3XrI2Gx3QpS/9lkSbeCJGI/GltGQz6zW/zdIcKkuw038kNirhyNfwODVVSmXaN3IP0zA9zVNGU6HbwiukNTzlcPOdHKXpYR1hfC5sAtGIZnk10JJ60p0zyb64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCk+6lzP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343834; x=1739879834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tpEZvY4JNPf3zA/5+c+vBc9IYvKrcWuT2LwwwYik6zA=;
  b=nCk+6lzPdj0a8NULbSi84dMxbTDb3sOJGialrv2RWdtpMiG60eNzFih1
   FEyB2lMX0jSGtN9QHmG/+qBSN/DqG4QhH8eNKg3VD6e80dtVWk9edznnF
   dXDJZbyPqSG7zR5frQ2DYBoN8kvhNYjUSH1ekgVaXTzf2hMFEt6vpdXCX
   6cYDFtRbdFiXqLIi2XEbLnWCjBI/DaUnJDGsJnM33Y05X0E4G9MmQpYaC
   jNdGtXslzDYfIasDm+zWj2dmQK3HfBSnrKcE3DX8wuzbcGA5ERN2fMtRz
   KZ2L6gbjT0esPLYv5UBEVfXyKlENZIkPzcNu88W43DZmn8EMSd7ieeVci
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6196084"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6196084"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="41967148"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:57:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Feb 2024 13:57:01 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] platform/x86: wmi: Check if event data is not NULL
In-Reply-To: <80bc19ce-7111-4a5d-b875-2712bdf2bb72@gmx.de>
Message-ID: <1fb172ff-b085-185e-90ea-1cd131f42b84@linux.intel.com>
References: <20240214070433.2677-1-W_Armin@gmx.de> <20240214070433.2677-3-W_Armin@gmx.de> <e03b600e-6ad2-1dd1-c4af-56ebfce51f12@linux.intel.com> <80bc19ce-7111-4a5d-b875-2712bdf2bb72@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1334979965-1708343821=:1174"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1334979965-1708343821=:1174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Feb 2024, Armin Wolf wrote:

> Am 15.02.24 um 13:31 schrieb Ilpo J=C3=A4rvinen:
>=20
> > On Wed, 14 Feb 2024, Armin Wolf wrote:
> >=20
> > > WMI event drivers which do not have no_notify_data set expect
> > > that each WMI event contains valid data. Evaluating _WED however
> > > might return no data, which can cause issues with such drivers.
> > >=20
> > > Fix this by validating that evaluating _WED did return data.
> > >=20
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/platform/x86/wmi.c | 11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > > index 34d8f55afaad..8a916887c546 100644
> > > --- a/drivers/platform/x86/wmi.c
> > > +++ b/drivers/platform/x86/wmi.c
> > > @@ -1211,6 +1211,7 @@ static void wmi_notify_driver(struct wmi_block
> > > *wblock)
> > >   {
> > >   =09struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver=
);
> > >   =09struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > > +=09union acpi_object *obj =3D NULL;
> > >   =09acpi_status status;
> > >=20
> > >   =09if (!driver->no_notify_data) {
> > > @@ -1219,12 +1220,18 @@ static void wmi_notify_driver(struct wmi_bloc=
k
> > > *wblock)
> > >   =09=09=09dev_warn(&wblock->dev.dev, "Failed to get event
> > > data\n");
> > >   =09=09=09return;
> > >   =09=09}
> > > +
> > > +=09=09obj =3D data.pointer;
> > > +=09=09if (!obj) {
> > > +=09=09=09dev_warn(&wblock->dev.dev, "Event contains not event
> > > data\n");
> > > +=09=09=09return;
> > > +=09=09}
> > >   =09}
> > >=20
> > >   =09if (driver->notify)
> > > -=09=09driver->notify(&wblock->dev, data.pointer);
> > > +=09=09driver->notify(&wblock->dev, obj);
> > >=20
> > > -=09kfree(data.pointer);
> > > +=09kfree(obj);
> > Hi Armin,
> >=20
> > While looking into this patch, I failed to connect the mention of
> > no_notify_data in the commit message with the code change that does
> > nothing differently based no_notify_data being set or not, AFAICT.
> >=20
> > It could be just that you need to explain things better in the commit
> > message, I'm not sure.
>=20
> Here the _WED ACPI control method is only evaluated if driver->no_notify_=
data
> is not set.
> So the returned ACPI object should only be validated in this case, as we =
pass
> NULL otherwise.

Yes, I'm sorry, it seems fine. For some reason I was very confused while=20
reviewing even if no_notify_data was mentioned right in the previous=20
context (maybe Iused some older version of the code while trying to figure=
=20
things out, I dunno).

--=20
 i.

--8323328-1334979965-1708343821=:1174--

