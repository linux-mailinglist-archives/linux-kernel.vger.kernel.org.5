Return-Path: <linux-kernel+bounces-82008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAF867DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CE01C285A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAF13328B;
	Mon, 26 Feb 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4SNCihX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A459712C807;
	Mon, 26 Feb 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966750; cv=none; b=MR2yzSMAN21Co9ZJ/uNZYRnpphtPHGjciO7MnbTtHBMpZfH82HzYU2eD9UPtaXwxbHfCr7rXda0O1iJFoOhnW8ErEuGij9C1/DtcKq8az29nJBi8W1e0jLEBOQNFvUg6U8cf+AMrooFkYpnNFpI3oJeZAaFMJ/T7yT40MmwFb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966750; c=relaxed/simple;
	bh=BLAS03sOMxIrSy3dV5ost75fW5umBREUcI8rl3VAb3A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iUXCdLYQ8JgFQy3d/8GpC/6Z8BumUTAmFvEodAiyY1RrI/HEuIRB3UO5i16Tbz//8ZxCvxoJdSxkxrnfxRui29/y512txvtwtooB5D8aGa4EKA2JrLaNsUTnSxMQgTvLeTFQx7C45GFh/az2YPrqwqwpvpoblKUx8LffMcB7bjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4SNCihX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708966749; x=1740502749;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BLAS03sOMxIrSy3dV5ost75fW5umBREUcI8rl3VAb3A=;
  b=R4SNCihXvVwHSornTPea3RdglxrpsuMUrA2dGwFcYuri3etLggJaLnb3
   1DJ2gNNmVjjUCKvJr23cCXtWG4fABgFYC1CRGV1mtgVMebe4YPMf65y8i
   wYYQ5lsJkPwj4oya+BZ12HcC+2+/12vK0uVwNTXgWNSmBwKaitMvF4ois
   9Mw/cBFPRVRkMXlDdYYYDQ+2XNaTpAboyJrhNY8h7sgIbrGzVIFHiVDkq
   tZMvO7+WdVyimRo3GeGDhXuCy8HswT0jrvat4hPkFnozHBx5vQ3Et9YOp
   wxtrs0dwBx7cnxSlApcancypid0/rS7T8I47HbmWcStpIzuPSKhMRGhrx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3133426"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3133426"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7269610"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:59:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 18:59:00 +0200 (EET)
To: Luiz Capitulino <luizcap@redhat.com>
cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
In-Reply-To: <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
Message-ID: <8a05120e-fcdf-f7f2-6b60-22e3ee819d37@linux.intel.com>
References: <cover.1708635408.git.luizcap@redhat.com> <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com> <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com> <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
 <1608d86a-24e8-403b-b199-ce23f8411cfd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-730537961-1708964317=:1203"
Content-ID: <4b808e5d-8e8a-3c86-7ca7-e69e8bd41f28@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-730537961-1708964317=:1203
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0b7f7ff4-48f1-66a2-0394-e1037cd78cc7@linux.intel.com>

On Mon, 26 Feb 2024, Luiz Capitulino wrote:

> On 2024-02-26 11:04, Ilpo J=E4rvinen wrote:
> > On Mon, 26 Feb 2024, Luiz Capitulino wrote:
> >=20
> > > On 2024-02-26 08:27, Ilpo J=E4rvinen wrote:
> > > > On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
> > > >=20
> > > > > The mlxbf-pmc driver fails to load when the firmware reports a ne=
w but
> > > > > not
> > > > > yet implemented performance block. I can reproduce this today wit=
h a
> > > > > Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, sin=
ce
> > > > > this
> > > > > reports the new clock_measure performance block.
> > > > >=20
> > > > > This[1] patch from Shravan implements the clock_measure support a=
nd
> > > > > will
> > > > > solve the issue. But this series avoids the situation by ignoring=
 and
> > > > > logging unsupported performance blocks.
> > > > >=20
> > > > > [...]
> > > >=20
> > > >=20
> > > > Thank you for your contribution, it has been applied to my local
> > > > review-ilpo branch. Note it will show up in the public
> > > > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > > > local branch there, which might take a while.
> > >=20
> > > Thank you Ilpo and thanks Hans for the review.
> > >=20
> > > The only detail is that we probably want this merged for 6.8 since
> > > the driver doesn't currently load with the configuration mentioned ab=
ove.
> >=20
> > Oh, sorry, I missed the mention in the coverletter.
> >=20
> > So you'd want I drop these from review-ilpo branch as there they end
> > up into for-next branch, and they should go through Hans instead who
> > handles fixes branch for this cycle?
>=20
> If that's the path to get this series merged for this cycle then yes,
> but let's see if Hans agrees (sorry that I didn't know this before
> posting).
>
> One additional detail is that this series is on top of linux-next, which
> has two additional mlxbf-pmc changes:
>
> *
> https://lore.kernel.org/lkml/39be055af3506ce6f843d11e45d71620f2a96e26.170=
7808180.git.shravankr@nvidia.com/
> *
> https://lore.kernel.org/lkml/d8548c70339a29258a906b2b518e5c48f669795c.170=
7808180.git.shravankr@nvidia.com/
>=20
> Maybe those two should be included for 6.8 as well?

Those look a new feature to me so they belong to for-next. So no, they=20
will not end up into 6.8 (to fixes branch). If the 2 patches in this=20
series do not apply without some for-next targetting dependencies, you=20
should rebase on top of fixes branch and send a new version.

About those two patches, please also see my reply. I intentionally only 2=
=20
patches of that series because I wanted to see sysfs documentation first=20
so you should resend those two patches to for-next with sysfs=20
documentation.

--=20
 i.
--8323328-730537961-1708964317=:1203--

