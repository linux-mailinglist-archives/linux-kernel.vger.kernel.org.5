Return-Path: <linux-kernel+bounces-109957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB78885838
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE9528245E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB85D58AB2;
	Thu, 21 Mar 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZFp7utj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F658AA6;
	Thu, 21 Mar 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020247; cv=none; b=ESgjal+5VbUUwE0D/0Ok8Zl6eeDutoH+K48uWb6TVyr81EfDzznaCdukeF8sxAgej34JB6B4pwWLzDWaqziaWQe/QOgn0XP6qLdT6QbRMATQdC2uPWPJY8XlKgKRDQFyxKmeT4oYoz8TJxeNrQ6u5EC8ojyAF0e1mqFqxFvMYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020247; c=relaxed/simple;
	bh=KygQcTYzy0e/Wu1RvdlKwFFGHESw3IH6K2dNI06TR0s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tr5oRew1m0PM5Bwxb+pnsCXegHCLip2/w8fBclHf3FEAv1gac9SnBo3g+F+Fu4ifh0MxGU9MlSfEdmphLiifrTz6AKgv0bB58yBS+YSgk4AGUmhNeFMRZaWSA8XEhkg82gRLXV3Jd3OLGgK8iB5aKJtAUlzU3oB4yfI0crHntLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZFp7utj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711020246; x=1742556246;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KygQcTYzy0e/Wu1RvdlKwFFGHESw3IH6K2dNI06TR0s=;
  b=nZFp7utjaKmMLZdrisq5h1YZNmq68nJJfm5UHVXPphwMFXu9dv36Rf3R
   LNJFbxgqVtZnEQQ5jnBNTLf4ACSEif9AOQsQlWyqPdwxMdN7lsoBiQrt0
   dlwg4mR+xzGB16Oh3LYuXrbbRVwKWMQoJnsENO8DNniKdB22p6L5Vto80
   nD7y4jeqOHDOTF/jUd/FI1s2H7FR+KiDUh4rp6ffMGYzTF0iWLl8h9U4T
   nW/g9g/p/hB6bqeSXz4QwR6VO4vpv2G5aL/3Ol2J+BqJvkh0K/1xKPh6I
   eB6NvlS/6Y8gP+MxXPlac5LrjyOabZ2d9VeI+PSiwVetxYcsUeO73zwUW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17449097"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="17449097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="18955599"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.17])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:24:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Mar 2024 13:23:59 +0200 (EET)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: store a min default for ppt
 options
In-Reply-To: <1006a1d3-86f2-4770-9cf2-4f7e3e12a787@app.fastmail.com>
Message-ID: <954e6e5c-dfeb-68b7-6e02-af26ef92c572@linux.intel.com>
References: <20240310233722.30884-1-luke@ljones.dev> <ebe48668-dfca-775c-880e-dfa333b7e562@linux.intel.com> <1006a1d3-86f2-4770-9cf2-4f7e3e12a787@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-648248580-1711020239=:1077"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-648248580-1711020239=:1077
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Mar 2024, Luke Jones wrote:

>=20
>=20
> On Thu, 21 Mar 2024, at 2:13 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 11 Mar 2024, Luke D. Jones wrote:
> >=20
> > > Laptops with any of the ppt or nv tunables default to the minimum set=
ting
> > > on boot so we can safely assume a stored value is correct.
> > >=20
> > > This patch adds storing of those values in the local struct, and enab=
les
> > > reading of those values back.
> > >=20
> > > Secondary to the above it renames some internal variables to be more
> > > consistent (which makes code grepping show all related parts)
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >  drivers/platform/x86/asus-wmi.c | 141 +++++++++++++++++++++++++-----=
--
> > >  1 file changed, 111 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/a=
sus-wmi.c
> > > index e4341abb71e0..482e23b55e1e 100644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c
> > > @@ -272,12 +272,19 @@ struct asus_wmi {
> > > =20
> > >  /* Tunables provided by ASUS for gaming laptops */
> > >  bool ppt_pl2_sppt_available;
> > > + u32 ppt_pl2_sppt;
> > >  bool ppt_pl1_spl_available;
> > > + u32 ppt_pl1_spl;
> > >  bool ppt_apu_sppt_available;
> > > - bool ppt_plat_sppt_available;
> > > + u32 ppt_apu_sppt;
> > > + bool ppt_platform_sppt_available;
> > > + u32 ppt_platform_sppt;
> > >  bool ppt_fppt_available;
> > > - bool nv_dyn_boost_available;
> > > - bool nv_temp_tgt_available;
> > > + u32 ppt_fppt;
> > > + bool nv_dynamic_boost_available;
> > > + u32 nv_dynamic_boost;
> > > + bool nv_temp_target_available;
> > > + u32 nv_temp_target;
> > > =20
> > >  bool kbd_rgb_mode_available;
> > >  u32 kbd_rgb_dev;
> >=20
> > Can you check with pahole if this structure is now full of 31-bit holes=
?
> >=20
> > The benefit of keeping bool & u32 doesn't seem that big to begin with=
=20
> > (in visual sense because of the 1 char variation in column).
>=20
> I don't really understand what you mean here. I do most of this stuff=20
> when I have time, so because my time is limited I usually don't have=20
> opportunity to learn much more than the minimum.

pahole is a tool with which you can look into struct layout. Compile the=20
driver with debug info on, and run pahole on the object file, then check=20
the layout of the members of that struct (mainly holes in this case).

So enable the debug info in .config if not yet enabled and then run:

$ make drivers/platform/x86/asus-wmi.o
$ pahole -C asus_wmi drivers/platform/x86/asus-wmi.o

--=20
 i.

--8323328-648248580-1711020239=:1077--

