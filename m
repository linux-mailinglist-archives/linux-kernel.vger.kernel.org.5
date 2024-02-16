Return-Path: <linux-kernel+bounces-68329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083788578D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E31C22229
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8711BC26;
	Fri, 16 Feb 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs39C+Ih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421B1BC20;
	Fri, 16 Feb 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075671; cv=none; b=VWWAzOdJo5RUakRCOLTJYvj5DUeIx6FUXtLZ9V5hxSKH9oC12uwv/ijXagdW7pvY5NksbddRC0wArFnpuKZjTTZvxicgSVcH40RlMwNCT2bA2hauGPo+VLDeo9kx0lukScGU7hJ3c+Z/Fc101lsDpJE0K33Z3dJ8DRwoW11DLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075671; c=relaxed/simple;
	bh=uDyNk/CUqvtdvvFmpldWQBvEpFAGBNu8KcXmCGgBUNg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DzAgT7nHBL49VIFv2H24kBAvQC8XNhoms8rY3XOQZE7+PGUtMdWqgZiZTcHnFxIiYz5BTZGVdc7wejzgXGMQbM2V8BlGWYw8Wu/t1OzO5mGZHV9XOHPeuksHsCVkGHAlguCzokCGQcm24aa+mFRpvdyDFLA+qxjEVTkx/Dm7AJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs39C+Ih; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708075670; x=1739611670;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uDyNk/CUqvtdvvFmpldWQBvEpFAGBNu8KcXmCGgBUNg=;
  b=Cs39C+IhjtxC6VBAXca8fgFeah+Ao1Sk/2Y1K5mOB7sdj1Mzj+PKS2Xz
   Z7iuJgzA4a0yv+UAZxsVB+eWJn70zMr9rbIXa50ioiQbc2tsQYOEybobU
   y4kV+bYtloo4ImspWVqCjM6FWBiruWs4gcSYpeGmXp6Dj210g1Li9D9+d
   b1Ot52DOGqhF/S6/kmHT0qEbO8DHwwdTGI/TD9ETL+X53HEeuujku2r0Y
   SonNHQ5lt26Z3sk91zMlfirE1gsgrFAmh/W/tZZfJFyX3oHaDHrv6E+b9
   ExJCdESN7hfXBpUjqu7abtEH4WLJKSJ3AadBBNZGloedIoT1wszxNqpHb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2070894"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2070894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826556602"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="826556602"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:27:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 11:27:40 +0200 (EET)
To: Szilard Fabian <szfabian@bluemarch.art>
cc: W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, jwoithe@just42.net, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge
 control support
In-Reply-To: <Zc5wIViz3d8sBLHP@bluemarch.art>
Message-ID: <77f71c25-a3d5-225e-9fc4-1b9d8ad3797d@linux.intel.com>
References: <20240129163502.161409-2-szfabian@bluemarch.art> <20240129175714.164326-2-szfabian@bluemarch.art> <20240207023031.56805-2-szfabian@bluemarch.art> <43960922-d6bb-e5f6-2156-f1b35142244a@linux.intel.com> <Zc5wIViz3d8sBLHP@bluemarch.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-679996737-1708075660=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-679996737-1708075660=:1097
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Feb 2024, Szilard Fabian wrote:
> On Thu, Feb 15, 2024 at 12:34:00PM +0100, Ilpo J=C3=A4rvinen wrote:
> > Why is this posted as RFC?
>
> It's my third patch into the Linux kernel (the first two being a i8042 qu=
irk
> table related patch) and I was not sure if everything is okay with v1/v2.
> But it looks like the patch matured enough in v3 to reach it's near final
> form and there was not too much to comment anymore. Sorry for any
> inconvenience I've caused with that.

No problem. I asked just to gauge if there was something you still planned=
=20
to do in addition to what is there. I kind of guessed that in this case=20
"RFC" mostly meant "I'm being careful here" more than that you'd have=20
something you felt still missing from the patch. :-)

--=20
 i.

> Thanks for your feedback. I'll post v4 in a moment.
>=20
> Regards,
> Szilard
>=20
>=20

--8323328-679996737-1708075660=:1097--

