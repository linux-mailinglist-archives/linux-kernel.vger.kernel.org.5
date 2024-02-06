Return-Path: <linux-kernel+bounces-54558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545584B0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847531F24693
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BBF12E1E9;
	Tue,  6 Feb 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFk7mKE0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940C12E1D5;
	Tue,  6 Feb 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210083; cv=none; b=cnudVqr6I/M1IQU1J9CHK67dEWdotbHHteTQ3s9pEA5ojmXJQWlF/vScwwRSHh8fFmmjAFBrRBgRsTaFEzfSk+KVnJh6X7TemL6Lh7StT1tCJG4VC+h59MNI78YnxSLzK+xP+yn6ZAeryiHZM2HIpNhsLOPFK8tNL16D2DQvMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210083; c=relaxed/simple;
	bh=2SDrB5JaxZL2HWqNxRD4Yrm8ISnPJv7zByBg6OlxiLw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t9uYNBj0BzOUMrCBEBgrIOBNUezuzfoYROsZpW6NOxb+Y/NTuk2qADByOBc+mvRK+r+ViUF5cn7JeHyJPEMQ2NQj7uSxG4Ht2Mxa+Dsn3LvkF4KPVhbY8e5gJYdZWonr5VORM3XPSHbbRaFajfHiYnpZ4Vwmmj5VPe9urPMr/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFk7mKE0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707210082; x=1738746082;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=2SDrB5JaxZL2HWqNxRD4Yrm8ISnPJv7zByBg6OlxiLw=;
  b=hFk7mKE0vML25hqsIJEG0rR0Z7wp21/S6g/M/MLwf/GP8rdKGu2hinU3
   ifIjet8QHKTgy08cEjMAieDGKnAFarVOzRY6sWCyIuFV+EISWbACFds2+
   EkuvEgyCACWq+x/iJ7a3ffCTwHN4xGLZjtbcLFa+6KAk2Dc4zjVJMPWmc
   gINT82UIcBNOpzLKUrEiB+247OtWJogEbOK3CEUF4zVZg6+q+DWLRn12y
   BDEkPBqC4MTxPm4INWMEZywPoU9ZeMBs8PIWxUtnLCJSgMaxfZI3b2lL+
   MIIqIa3XpiKm+6Ek1dLicF/fuYNj8s+q2yr/oMk5/qWLqe3vjRYcJjcHW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11289535"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11289535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="966340"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 01:01:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 11:01:13 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hans de Goede <hdegoede@redhat.com>, naveenkrishna.chatradhi@amd.com, 
    LKML <linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <2024020540-siesta-palm-03cd@gregkh>
Message-ID: <3522e43e-a54c-0ac1-e4b8-beea9b7e0bd0@linux.intel.com>
References: <2024020145-junior-outnumber-3e76@gregkh> <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com> <2024020243-blinks-pantomime-c51e@gregkh> <06e92b87-4d48-4519-b1db-6d7605bf3962@redhat.com> <e8605fd7-1ffc-00ff-ec3b-e125085d4e92@linux.intel.com>
 <2024020540-siesta-palm-03cd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1903269187-1707209279=:1141"
Content-ID: <21a85ceb-6a8f-fc9f-b2e0-de572ce81811@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1903269187-1707209279=:1141
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a1d6fb3c-5406-0c11-1250-74927851f899@linux.intel.com>

On Mon, 5 Feb 2024, Greg Kroah-Hartman wrote:

> On Mon, Feb 05, 2024 at 12:27:24PM +0200, Ilpo J=E4rvinen wrote:
> > On Fri, 2 Feb 2024, Hans de Goede wrote:
> > > On 2/2/24 16:32, Greg Kroah-Hartman wrote:
> > > > On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
> > > >> Hi Greg,
> > > >>
> > > >> On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> > > >>> The use of devm_*() functions works properly for when the device
> > > >>> structure itself is dynamic, but the hsmp driver is attempting to=
 have a
> > > >>> local, static, struct device and then calls devm_() functions att=
aching
> > > >>> memory to the device that will never be freed.
> > > >>
> > > >> As I mentioned in my reply to v1, this is not correct.
> > > >>
> > > >> There is a global data struct, but that holds a struct device
> > > >> pointer, not the device struct.
> > > >=20
> > > > Ooops, I misread that:
> > > > =09static struct hsmp_plat_device plat_dev;
> > > > was not the actual device struct anymore.
> > > >=20
> > > >> The device itself is created with platform_device_alloc() +
> > > >> platform_device_add() from module-init and it is removed
> > > >> on module-exit by calling platform_device_unregister()
> > > >=20
> > > > Ok, much better.
> > > >=20
> > > >> So AFAICT this should keep using the devm_ variant to properly
> > > >> cleanup the sysfs attributes.
> > > >=20
> > > > This devm_ variant is odd, and should never have been created as th=
e
> > > > sysfs core always cleans up the sysfs attributes when a device is
> > > > removed, there is no need for it (i.e. they do the same thing.)
> > > >=20
> > > > That's why I want to get rid of it, it's pointless :)
> > > >=20
> > > >> But what this really needs is to be converted to using
> > > >> amd_hsmp_driver.driver.dev_groups rather then manually
> > > >> calling devm_device_add_groups() I have already asked
> > > >> Suma Hegde (AMD) to take a look at this.
> > > >=20
> > > > The initial issue I saw with this is that these attributes are bein=
g
> > > > created dynamically, so using dev_groups can be a bit harder.  The =
code
> > > > paths here are twisty and not obvious as it seems to want to suppor=
t
> > > > devices of multiple types in the same codebase at the same time.
> > > >=20
> > > > But yes, using dev_groups is ideal, and if that happens, I'm happy.
> > > > It's just that there are now only 2 in-kernel users of
> > > > devm_device_add_groups() and I have a patch series to get rid of th=
e
> > > > other one, and so this would be the last, hence my attention to thi=
s.
> > > >=20
> > > > Again, moving from devm_device_add_groups() to device_add_groups() =
is a
> > > > no-op from a functional standpoint, so this should be fine.
> > >=20
> > > Ok, I was not aware that the core automatically cleans up
> > > all the attributes anyways.
> > >=20
> > > In that case this fine with me and I agree with merging this
> > > so that you can entirely remove the  devm_ variant:
> > >=20
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >=20
> > Greg,
> >=20
> > Does this same stuff apply to devm_device_add_group() which was added=
=20
> > along the ACPI changes?
>=20
> Probably, I haven't looked at that yet.
>
> > And the changelog is quite misleading as is, it should be changed to=20
> > match the real motivation.
>=20
> "Motivation" isn't always needed in a changelog text, I was trying to
> describe why this specific instance was not needed, not the overall
> pointlessness of the function :)
>=20
> I got the text wrong about this being a static variable (but one is
> still in there, so it's confusing.)

Yes, I mainly meant the not-dynamic part is no longer true so I don't want=
=20
to apply it as is and you likely want to extend the patch to include the=20
newly introduced devm_device_add_group() call conversion.

> I'll be glad to reword this if needed to just say "This function is
> pointless, does nothing, and is about to be removed from the kernel so
> stop using it", or something along those lines...

Given that it wasn't obvious to either me nor Hans, it would have been=20
useful to mention it. The current wording had a different undertone so
after the driver got changed it looked as if the patch become obsolete.
=2E..But that turned out was not the case because of motivation outside of
the one given in the commit message, so yes, if we look this from a
reviewer perspective, it would be useful information to tell the function=
=20
is pointless and does nothing useful on top of the other function.


--=20
 i.
--8323328-1903269187-1707209279=:1141--

