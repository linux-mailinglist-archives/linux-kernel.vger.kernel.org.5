Return-Path: <linux-kernel+bounces-54677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574A84B259
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D5BB25FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995812D777;
	Tue,  6 Feb 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arNQsvqK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E812E1FF;
	Tue,  6 Feb 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214653; cv=none; b=izTueArmWkbkSs1PriPOIQXbNdcfX7R603mmxi4muacpfMdq59imdo8rPZW3zsCmz8zG46P85V0F9gLibEsCK6oFfBuCG4rUcupP2a/8LQswBu6bdIf/7K0uWzqs1Cyyvh7Al7prtr/2MnOOw2DuxNOfdnVZvC4H81eN2aPyNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214653; c=relaxed/simple;
	bh=oFoZrkj5hSrIBFV+8cbsdJVafz0I/YimdsJSybYVGUU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Pp8KoKaG6zJhO8MrwN/93MUfuYTViEI8Q3xa5QOpPT0r5kQhR2QK/5pLqa5rjf7SraUGIPooTcOoEbV7L5g5PSI164cfGlgbIm7wg7mMBJahgJ1P+NN6BuNGQ5lpzGgyHe+CQZ3sYdTb4l4Vv3cvepea0KpUEA/O4Q7b9E9JF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arNQsvqK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707214652; x=1738750652;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oFoZrkj5hSrIBFV+8cbsdJVafz0I/YimdsJSybYVGUU=;
  b=arNQsvqKFtxvVlGwurx9mvshXf4lynhj1u+LpJHsdQIQte900VQhzFiS
   0gdxqJlRAne5eFpFZS77VP6j+uonyFBawMHDe8+TUEmbps8hq9GdzZ6uR
   pLHGydRort8XimIwGWKts4z5WKnPCFMPuJvcaLR1xhLrrTdtr4fwBA1tJ
   rseS/IVV+4v7gVSFS42VlXR58pNgu0fhy2zTn9hHdjiiea2Jqj4Ij45Fu
   97YoWjfNSiOBNEREpvEcG/y0nQyEdkz1lYKv6jscgfzJXcLswCNAZs/x9
   Qd3nzXjH8P9SJPzdKyyOHSik1K0kTRPC2RSojDXSwJqd9d+LAeQNpyKQy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18233866"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="18233866"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="976750"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.36.139])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:17:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 6 Feb 2024 12:17:21 +0200 (EET)
To: Maximilian Luz <luzmaximilian@gmail.com>, Ivor Wanders <ivor@iwanders.net>
cc: Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, 
    Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
    Mark Gross <markgross@kernel.org>, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
In-Reply-To: <6659d49c-4a70-1a92-2a76-ce7144fed50c@linux.intel.com>
Message-ID: <f79f050d-708d-a9c3-fb6d-b06e046603c3@linux.intel.com>
References: <20240131005856.10180-1-ivor@iwanders.net> <20240131005856.10180-3-ivor@iwanders.net> <7e392c1e-2cb2-43e4-804e-227551ed2dd7@roeck-us.net> <8552a795-9ce4-417a-bc71-593571a6b363@gmail.com> <6659d49c-4a70-1a92-2a76-ce7144fed50c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2118278718-1707214641=:1141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2118278718-1707214641=:1141
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Feb 2024, Ilpo J=E4rvinen wrote:

> On Wed, 31 Jan 2024, Maximilian Luz wrote:
>=20
> > Am 1/31/2024 um 2:24 PM schrieb Guenter Roeck:
> > > On Tue, Jan 30, 2024 at 07:58:56PM -0500, Ivor Wanders wrote:
> > > > Add an entry for the fan speed function.
> > > > Add this new entry to the Surface Pro 9 group.
> > > >=20
> > > > Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> > > > Link: https://github.com/linux-surface/kernel/pull/144
> > > > Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> > >=20
> > > I wasn't sure if the Reviewed-by: tag means that I should apply the p=
atch
> > > through the hwmon subsystem. If so, please let me know. For now I'll
> > > assume that it will be applied through a platform tree.
> >=20
> > I think it would make more sense for it to go through pdx86 (as usual
> > for platform/surface). That would avoid any potential merge conflicts
> > if we get more changes to the surface_aggregator_registry later on.
> >=20
> > Hans, Ilpo, could you please take this?
> >=20
> > Also I just noticed that Ilpo wasn't CCd, I assume because of an older
> > MAINTAINERS list. Ivor, please add him for any next submissions to
> > platform/surface.
>=20
> Okay, thanks for letting me know (I assumed the opposite). I'll take it=
=20
> through pdx86.

Patch 2/2 applied to review-ilpo.

--=20
 i.

--8323328-2118278718-1707214641=:1141--

