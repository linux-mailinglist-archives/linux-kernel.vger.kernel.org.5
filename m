Return-Path: <linux-kernel+bounces-81861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B4867B19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D9E2850FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB712C54F;
	Mon, 26 Feb 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBWeWbLm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3E60274;
	Mon, 26 Feb 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963507; cv=none; b=eTJGV/3qXzW24C5nzTCxz/X3fQjaAEsO9yP9WSczSg08iat49tJD/QU5WXZ6GHudczCoYS4M2qMlRyAkTEj+LV0EAFczKD8MdjeaQ0jUcD8Pjrfv8bu9yWgjomSQk++IrvGdAYSLmajlxVj3BOyBdg2jUuhYarfuseUZBH4Mkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963507; c=relaxed/simple;
	bh=WSnrVoHPaDGwsifGqLkbqfrlQFgxZVfaj0VRMWT2aqc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cn32RM0cmREYkzRhEi9YrR1K6fcLxLsm3MM8rV5sECf45oEU4VVOj0IQrK617K492+EyM6zag8aXprLA+XeUVcZ7k8aEEdFPVoKioHGqGspKOulvrKWV2rwdw1qyggdlza1IG1MyjRxhQr66yaRVJXAZ2zLLVRLCz+1oBtQd4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBWeWbLm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708963505; x=1740499505;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WSnrVoHPaDGwsifGqLkbqfrlQFgxZVfaj0VRMWT2aqc=;
  b=IBWeWbLmAcMn3fW3mLJyuto3DRvyN+BD6UrocGgsHcpFC1/DxDoLlGIo
   VhHOcPIz+YoBwVoJun3xZ853fc4YfRxhOemceIrf6e9h+PnMxH7zsLbOp
   OruvLVjgfWVVfCEiXMSbcP31MAcntLG6Od8TTlGUSVwWNV8mj1nOMEbNZ
   qDFjaeXK2ptXl1ffEEywAvCYBpa2wxcdgBZzk9RE93h2615ZRhoyuGHA/
   DdS0cksV8KgC/fw7UDba1N6UFs3piBaACwytjwbCuyznbplad18xk7zaO
   I3p0LPqQnRhbFDNrCuombQuMaTtXEeFzBGSK+R0+o3NorE7DH/ehSS9S2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13962025"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13962025"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6851195"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:05:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 18:04:55 +0200 (EET)
To: Luiz Capitulino <luizcap@redhat.com>
cc: shravankr@nvidia.com, davthompson@nvidia.com, ndalvi@redhat.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
In-Reply-To: <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
Message-ID: <29863354-4efe-d199-a9d4-7daf83f6cde9@linux.intel.com>
References: <cover.1708635408.git.luizcap@redhat.com> <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com> <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-81220712-1708963495=:1203"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-81220712-1708963495=:1203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Feb 2024, Luiz Capitulino wrote:

> On 2024-02-26 08:27, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
> >=20
> > > The mlxbf-pmc driver fails to load when the firmware reports a new bu=
t not
> > > yet implemented performance block. I can reproduce this today with a
> > > Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since t=
his
> > > reports the new clock_measure performance block.
> > >=20
> > > This[1] patch from Shravan implements the clock_measure support and w=
ill
> > > solve the issue. But this series avoids the situation by ignoring and
> > > logging unsupported performance blocks.
> > >=20
> > > [...]
> >=20
> >=20
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > local branch there, which might take a while.
>=20
> Thank you Ilpo and thanks Hans for the review.
>=20
> The only detail is that we probably want this merged for 6.8 since
> the driver doesn't currently load with the configuration mentioned above.

Oh, sorry, I missed the mention in the coverletter.

So you'd want I drop these from review-ilpo branch as there they end
up into for-next branch, and they should go through Hans instead who=20
handles fixes branch for this cycle?

--=20
 i.

--8323328-81220712-1708963495=:1203--

