Return-Path: <linux-kernel+bounces-83304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606CD86919C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913381C27E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E43C13B790;
	Tue, 27 Feb 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nx26+HnF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B613B293;
	Tue, 27 Feb 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039936; cv=none; b=KpoWvU7VTF3o6tftY4AYvJgKeNQWTe6lJ/z3fq/TUPWEVRHzWGAYyeTRpcBXHN8MqMTrcVqXi4JPGy1edbFdkRX9vxmP1B/cjuvkXaMhW8RAO4t4tUT+pxMwv2UEWozuxe/1hPRBeEVO9favWBpQ59JZJe4w53BoBQ8Ay0ByBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039936; c=relaxed/simple;
	bh=m0XFN8Tee5EPflDKGWSpbSuSJDww3Edcr17LM7LJoBE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i6G8p7pCqOxlgsv/XQ6BqYFCESoQSxgUyXOn1iyL9a+Q3oxnDm7wZVQb1dDOY/ek0Iw3+R4k6JvVR1Mf4ONj0k72RUFt8elY9Uo7XZ36MZwEDxx7nuhrzoUxWlTsAPX0lYPCdU9c8lY4GgENA5vGWjxkpG0SsYfdJrLtcG6Glko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nx26+HnF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709039935; x=1740575935;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=m0XFN8Tee5EPflDKGWSpbSuSJDww3Edcr17LM7LJoBE=;
  b=nx26+HnFe7Cp+otwS6OPf7Vg8g1aX4kCq/7jvXOqaqxmrwkEWqORaAGf
   d0wyFLZFdhXyRSaluyJkYIanyj9uvbBOeyqvIxcSQ+KLQZqc495ez6TNK
   CPjuR78xRFKcmaJRwz7Se5CjiGfy151Z7s/gF5fQJoXgecR4FEBiU27JT
   FDGFrEoLybz3f/ZWmgWdMqxz9ov8ZtqsPwSvZDqYvS9QMQGc398ymkkVj
   apalnyW+ybWQT7azP4sbxvaVf76gxERomsClXSYicSlQSFUtJzEPwrc2t
   fN2y1PS3KuK/DYLBm7HbysliP73aRlWXFrZhEC1ojz6M4RDKYCT2KbW5g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3496076"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3496076"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7080184"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:18:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 15:18:48 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>
cc: Luiz Capitulino <luizcap@redhat.com>, shravankr@nvidia.com, 
    davthompson@nvidia.com, ndalvi@redhat.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
In-Reply-To: <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
Message-ID: <4f6169e5-dee6-2188-f0a5-601b516be5fe@linux.intel.com>
References: <cover.1708635408.git.luizcap@redhat.com> <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com> <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com> <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com> <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
 <eea32e56-2ea3-4a11-b1b9-8dd46dac7d72@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-606387716-1708967518=:1203"
Content-ID: <4d35180d-b1ce-72eb-222c-57381c067c0a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-606387716-1708967518=:1203
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <79410032-c4ee-96e4-c036-57960da3b45a@linux.intel.com>

On Mon, 26 Feb 2024, Hans de Goede wrote:

> Hi Luiz,
>=20
> On 2/26/24 17:10, Luiz Capitulino wrote:
> > On 2024-02-26 11:04, Ilpo J=E4rvinen wrote:
> >> On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> >>
> >>> On 2024-02-26 08:27, Ilpo J=E4rvinen wrote:
> >>>> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
> >>>>
> >>>>> The mlxbf-pmc driver fails to load when the firmware reports a new =
but not
> >>>>> yet implemented performance block. I can reproduce this today with =
a
> >>>>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since=
 this
> >>>>> reports the new clock_measure performance block.
> >>>>>
> >>>>> This[1] patch from Shravan implements the clock_measure support and=
 will
> >>>>> solve the issue. But this series avoids the situation by ignoring a=
nd
> >>>>> logging unsupported performance blocks.
> >>>>>
> >>>>> [...]
> >>>>
> >>>>
> >>>> Thank you for your contribution, it has been applied to my local
> >>>> review-ilpo branch. Note it will show up in the public
> >>>> platform-drivers-x86/review-ilpo branch only once I've pushed my
> >>>> local branch there, which might take a while.
> >>>
> >>> Thank you Ilpo and thanks Hans for the review.
> >>>
> >>> The only detail is that we probably want this merged for 6.8 since
> >>> the driver doesn't currently load with the configuration mentioned ab=
ove.
> >>
> >> Oh, sorry, I missed the mention in the coverletter.
> >>
> >> So you'd want I drop these from review-ilpo branch as there they end
> >> up into for-next branch, and they should go through Hans instead who
> >> handles fixes branch for this cycle?
> >=20
> > If that's the path to get this series merged for this cycle then yes,
> > but let's see if Hans agrees (sorry that I didn't know this before
> > posting).
>=20
> Hmm, new hw enablement typically goes through -next and not to
> the current fixes branch. And AFAICT this is new hw enablement,
> not a regression / bug-fix.
>=20
> Is there any special reason why this needs to be in 6.8 ?

To me it sounded like fix to 1a218d312e65 ("platform/mellanox: mlxbf-pmc:=
=20
Add Mellanox BlueField PMC driver") and 423c3361855c ("platform/mellanox:=
=20
mlxbf-pmc: Add support for BlueField-3") although not explicitly marked as=
=20
such.

But I'm fine with taking these through for-next, it's relatively late into=
=20
the cycle already anyway.

> For RHEL kernels you can cherry-pick patches from -next
> as necessary.

It's also possible to send them later directly to stable folks once=20
Linus' tree has them after the next merge window if you feel they're=20
useful for stable inclusion.

> > One additional detail is that this series is on top of linux-next, whic=
h
> > has two additional mlxbf-pmc changes:
> >=20
> > * https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26=
=2E1707808180.git.shravankr@nvidia.com/
> > * https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c=
=2E1707808180.git.shravankr@nvidia.com/
>=20
> Hmm, those are not small patches, any other reason
> why this really should go to -next IMHO.

Those two linked patches are totally unrelated.


--=20
 i.
--8323328-606387716-1708967518=:1203--

