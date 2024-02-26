Return-Path: <linux-kernel+bounces-81755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE108679C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDAB1C2B26D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD654136675;
	Mon, 26 Feb 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKGj/6yJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDE136661;
	Mon, 26 Feb 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959704; cv=none; b=IFcMkB3b1C1Q0mkwSdF+zlzk92KZlbByBuV4S9rT7+W5BSOps99qHm+rdRLJpRfBzBufCytH5nYmDP9sfD5May4TDU2Hka+EreAQ+sFGO+DfdNHC4QMaeb/P4R/n2M2/fYYKcBwoLYxPLAsjRmUUIIJZPHSb0EA0IL9QcLRuHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959704; c=relaxed/simple;
	bh=R+uQ0hRx/vA5qggGzFvGS3bH0flG0Ewa3jslw9Le/u4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QJ4QOAb6taLeJfydtUeAltdhKQ8cik66e+HU0U5jL0REgAdmf1gJMHlwHFFfxOCRbhYcTd6DYb6kxY8vyAAGBqt/Ovg+Fythwr9eNIEa/dE6vtpF5NLzuXVvwOWo0KzsC/ORd7YIPmH5ipn7sZqA/kkCAruNwN+FbezDjlV3Gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKGj/6yJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708959702; x=1740495702;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+uQ0hRx/vA5qggGzFvGS3bH0flG0Ewa3jslw9Le/u4=;
  b=eKGj/6yJBQBHlE/qgm/X8c/SJqk1HA62uSnqeis9XlYfSpIJBuA/Amlh
   f3UdL3pcQdtdQtOPJiummO3oM+x52ODW+UXYRFMwDu00e77/z16/KjzzJ
   l9a0VggKoe4CZwgWSNIwTOS19q2zxwlF1EQ0xSU51e/fl2pjZOaQatF0T
   t81pmz5Y87ybEKiZA62QHPzIfGqWXzyZ9GkIgSIIusRtbOde1w92CPB7r
   p14KzWOi8lxzlIUt/FJHnrueC+S+14B7dphTAXiseVq24HqTgDHeB43JT
   tGeLujS6Vy7YCZfmSuFjS3b0VOyrmhxMhrbpqTREzQ5orV0cP/LgQE2GI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="7063234"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7063234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7043912"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:01:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Feb 2024 17:01:15 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
In-Reply-To: <20240221211204.515159-3-david.e.box@linux.intel.com>
Message-ID: <62a64727-5732-ace0-2a29-f5d883c6e370@linux.intel.com>
References: <20240221211204.515159-1-david.e.box@linux.intel.com> <20240221211204.515159-3-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-988846203-1708959675=:1203"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-988846203-1708959675=:1203
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Feb 2024, David E. Box wrote:

> To unblock Package C state entry, put the GNA device in D3 by default if =
no

Hi David,

It would be nice if this kind of not so well-known acronyms are opened by=
=20
default in the commit message so reviewers have a chance to understand=20
what this is about (me included, I had to look it up).

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> driver is loaded for it.
>=20
> Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to=
 intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index 683ae828276b..34b4cd23bfe5 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] =3D {
>  };
> =20
>  #define ARL_NPU_PCI_DEV=09=09=090xad1d
> +#define ARL_GNA_PCI_DEV=09=09=090xae4c
>  /*
>   * Set power state of select devices that do not have drivers to D3
>   * so that they do not block Package C entry.
> @@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] =3D {
>  static void arl_d3_fixup(void)
>  {
>  =09pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
> +=09pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
>  }
> =20
>  static int arl_resume(struct pmc_dev *pmcdev)

--8323328-988846203-1708959675=:1203--

