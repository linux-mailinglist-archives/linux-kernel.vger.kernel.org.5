Return-Path: <linux-kernel+bounces-111269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47388869EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1218D1C24313
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58E2C689;
	Fri, 22 Mar 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXybtDfH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056F13ADD;
	Fri, 22 Mar 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101967; cv=none; b=jpQ3djRpMYmC851mmWiuiYVnuJnChdXw17+1Xl4B+fbWSWgMTgCUT4zju6VZjsPesobO4uGwUpaok7n+HrOsjVlbGiJAoe06+rzQ9I8rQ1+lTsKAZHBBPoQl/LZeRiPmE28MH5peqW/c/jVna8YqVgRXzHb6mF+qZ0msFZGiujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101967; c=relaxed/simple;
	bh=42h8wfy/T6zcYftxDkn6CpEmueXefJ7lgGagO93KwZI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gqkWei7TMjblcMByjfPnY8w99qi1+SJutiP91Y8y1/0JYjxXoGC78uCW/l0ffbIAm1sirhH++KZiL/q8dTOPEQoFoxqx1OH/Y38Q9ybS16hFEbmMGkxUhoh9BBxJ1SyLrH8EjJCbkLidOJ0rMQ8ZAQSb1QEBKCplGpb7RxdWj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXybtDfH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101965; x=1742637965;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=42h8wfy/T6zcYftxDkn6CpEmueXefJ7lgGagO93KwZI=;
  b=fXybtDfHDRqi/NwpLGhGGmA6kzVDzFK5xAM0oFi6NE3DfHKYsHCD9R5r
   GZNBgV0HSKcko4gfiDVPu5auyTHsjkmaxnvsuzh7NxXirqM4ulRZ5yHKs
   40r/pH3MkG+4OFWOcyWVxgxoqmA3o+nbAsTghHeAWqKRlbZQl4J7jsK/j
   z+a+puyaO0TazL9kza4J2mvfM1/PyagsPT5rItHiCoPj0HVKOY2cyPjTT
   g/vnnITRU4KSK+ycTvadEZQEOijFGq3dglhqS8HxO4FK4U4KVRrRytgWe
   U5mhhbauF0EaoxQU9DsZNxHQXI6RcYTldw1eJjbuTobLmQ4Ho8WJ0+xj/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5997510"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="5997510"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="19559041"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.18])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:06:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 22 Mar 2024 12:05:57 +0200 (EET)
To: Ivor Wanders <ivor@iwanders.net>
cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    luzmaximilian@gmail.com, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/surface: platform_profile: add fan
 profile switching
In-Reply-To: <20240321212521.3834-1-ivor@iwanders.net>
Message-ID: <424d43f0-bcbc-f904-03bf-9f4c0488d706@linux.intel.com>
References: <71c9e24b-c64b-581c-87f0-fb0c58066ceb@linux.intel.com> <20240321212521.3834-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-787903796-1711101549=:1315"
Content-ID: <cb297c0a-ff37-eb02-7a38-466af40263f9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-787903796-1711101549=:1315
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <05229851-2721-282d-8862-61abe999deb4@linux.intel.com>

On Thu, 21 Mar 2024, Ivor Wanders wrote:

> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> What is the process to get this merged if no further review is coming in?
> Maximilian Luz approved v1 already. I just confirmed this patch still
> applies cleanly on the latest upstream master.

Hi Ivor,

We're currently in the two weeks merge window (the time between kernel=20
release and the next -rc1). Usually, nothing happens during it for new=20
patches that are not fixes (there might be exceptions with some=20
subsystems but that's a good general rule and even with fixes severity=20
matters a lot if they are considered until -rc1 is out).
=20
Maintainer will consider your patch after the merge window (in this case,=
=20
it will be Hans' turn for 3.10 cycle to handle for-next while I handle=20
fixes branch).

> Do I need to send v3 with
> this reviewed-by tag added to the commit or can this version be merged?

Our tools take care of the tags such as Reviewed-by when they're made=20
against the latest version, there is no need to resubmit just because of=20
tags people give to your patch.

(That being said, whenever submitting a new version for other reasons,=20
remember to add the tags to the new version because tools only capture=20
them for the latest version.)

--=20
 i.
--8323328-787903796-1711101549=:1315--

