Return-Path: <linux-kernel+bounces-83307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F98691A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B931C28344
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130A13B2AC;
	Tue, 27 Feb 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knzFP1iE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0813B293;
	Tue, 27 Feb 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040030; cv=none; b=cVEQs0nXx1AruRRQyJ680rKQGLJUtNlRdxYmCMpWlIWEj8R/pOD0IXXI2nG2Q3dDCNyJX9vMZpGW+4GuTIyjJ0+7szc8UB6Uiw8nvmTDBZUX21IlEXeyG5lhqh2uoOw7YLH/3EK8hed6mtLARUqKc0UsiwokY6+BHsGzAxGszjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040030; c=relaxed/simple;
	bh=EBs4betfL1RKBwgp2ebp0GSA1ZBOXqHaPeKzovpf0VQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b7VL5I+WUKLIronVdBbRMJCncCVVNt8cabyBGp7+8AQ6UiEP6jNUsza868Xo2z18IaEN3pcvo8+wYaaSLApI21mdHJhY5Ato5J11Gd7ohaa5oVV+Iux36mwts5tfjqrbTYYLYNgF+nhj7cReLtAs3tc+TzVpiVKFwwAYUVmM10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knzFP1iE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709040029; x=1740576029;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EBs4betfL1RKBwgp2ebp0GSA1ZBOXqHaPeKzovpf0VQ=;
  b=knzFP1iEAzacT7ZcxRN6oDO9Vm+E2ld+63fRT/GmUZOwhZ+PSymWzuAe
   hZ56HiryZ0mPcUJnejSca8Qy8gJqU10ALCU/x6FQo0hJ4RDEQL028ECGn
   cqLY4Dxo9GqAQmKzBVTnMEHgOmRATWjoBlpiH7YX3gX/5knO1Z6I4abiv
   TXDTn3xAzboj+7QlA5LlwdVOyrcQWqJ5iMS0tLQjnnI7+t4n6aE7SuNZ8
   4m7s2S9HTuTQ0A9spt5R5slyAFrME56FeH99HYo0xcv1RC3eK5squwjyA
   1OeDB3/KGo+QxAxfwBxxwSAHbKdw5SHMETocMQem1IE9o3wMVX8VwZo1r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13928489"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13928489"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11643767"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 05:20:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 15:20:22 +0200 (EET)
To: Luiz Capitulino <luizcap@redhat.com>
cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
In-Reply-To: <eaef16d8-d43a-49c8-b1a0-450ab4c1ba9f@redhat.com>
Message-ID: <4bb37259-5626-b32f-f21b-b88df52d4afb@linux.intel.com>
References: <cover.1708635408.git.luizcap@redhat.com> <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com> <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com> <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com> <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
 <8a05120e-fcdf-f7f2-6b60-22e3ee819d37@linux.intel.com> <eaef16d8-d43a-49c8-b1a0-450ab4c1ba9f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1367976222-1709040022=:1099"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1367976222-1709040022=:1099
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Feb 2024, Luiz Capitulino wrote:

> On 2024-02-26 11:59, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> >=20
> > > On 2024-02-26 11:04, Ilpo J=C3=A4rvinen wrote:
> > > > On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> > > >=20
> > > > > On 2024-02-26 08:27, Ilpo J=C3=A4rvinen wrote:
> > > > > > On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
> > > > > >=20
> > > > > > > The mlxbf-pmc driver fails to load when the firmware reports =
a new
> > > > > > > but
> > > > > > > not
> > > > > > > yet implemented performance block. I can reproduce this today=
 with
> > > > > > > a
> > > > > > > Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035,
> > > > > > > since
> > > > > > > this
> > > > > > > reports the new clock_measure performance block.
> > > > > > >=20
> > > > > > > This[1] patch from Shravan implements the clock_measure suppo=
rt
> > > > > > > and
> > > > > > > will
> > > > > > > solve the issue. But this series avoids the situation by igno=
ring
> > > > > > > and
> > > > > > > logging unsupported performance blocks.
> > > > > > >=20
> > > > > > > [...]
> > > > > >=20
> > > > > >=20
> > > > > > Thank you for your contribution, it has been applied to my loca=
l
> > > > > > review-ilpo branch. Note it will show up in the public
> > > > > > platform-drivers-x86/review-ilpo branch only once I've pushed m=
y
> > > > > > local branch there, which might take a while.
> > > > >=20
> > > > > Thank you Ilpo and thanks Hans for the review.
> > > > >=20
> > > > > The only detail is that we probably want this merged for 6.8 sinc=
e
> > > > > the driver doesn't currently load with the configuration mentione=
d
> > > > > above.
> > > >=20
> > > > Oh, sorry, I missed the mention in the coverletter.
> > > >=20
> > > > So you'd want I drop these from review-ilpo branch as there they en=
d
> > > > up into for-next branch, and they should go through Hans instead wh=
o
> > > > handles fixes branch for this cycle?
> > >=20
> > > If that's the path to get this series merged for this cycle then yes,
> > > but let's see if Hans agrees (sorry that I didn't know this before
> > > posting).
> > >=20
> > > One additional detail is that this series is on top of linux-next, wh=
ich
> > > has two additional mlxbf-pmc changes:
> > >=20
> > > *
> > > https://lore.kernel.org/lkml/
39be055af3506ce6f843d11e45d71620f2a96e26.1707808180.git.shravankr@nvidia.co=
m/
> > > *
> > > https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c=
=2E1707808180.git.shravankr@nvidia.com/
> > >=20
> > > Maybe those two should be included for 6.8 as well?
> >=20
> > Those look a new feature to me so they belong to for-next. So no, they
> > will not end up into 6.8 (to fixes branch). If the 2 patches in this
> > series do not apply without some for-next targetting dependencies, you
> > should rebase on top of fixes branch and send a new version.
>=20
> Understood.
>=20
> > About those two patches, please also see my reply. I intentionally only=
 2
> > patches of that series because I wanted to see sysfs documentation firs=
t
> > so you should resend those two patches to for-next with sysfs
> > documentation.
>=20
> I'm actually not author of the other patches :)

Ah, sorry. I didn't pay enough attention to that. :-)


--=20
 i.

--8323328-1367976222-1709040022=:1099--

