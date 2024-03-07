Return-Path: <linux-kernel+bounces-95569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED6874F98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51522856CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAA12BF11;
	Thu,  7 Mar 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9mDbwjc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC5512BEA5;
	Thu,  7 Mar 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816798; cv=none; b=g++4Ryx1oWJGH+KFjq356uCGzOU7Vw8Azzij6C88vUfMIrZzl9npFxpazumSw4pG9U99tpF0GKazBHFFzM4SrcDQFnwZO1T5FN2YL1ulGhDL5IOjbtfUkUeHdb/+StbZrlTWdJG4p/o7sd0BBza+DZA42r4N028OvUtfK+jJgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816798; c=relaxed/simple;
	bh=2RMapmPCobYn5uXk9EvUvUddEuIWAUjZ3Hmw1WtqFXI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gSacdbC5TIqand3WlkX265Cc3LoD10LRbpqUhutncTNglIEOfOWJlbx/J5eze2YlP4EL4fqjh5V5INgZDGUe/T/g+kVraT/3UZpCkrPsrjX/GJPOGIVU4ZtKbJedP2yCBeIpEtZ98hdTlNtoyQ4nRZXbd8WvL4uWE6+ZFMTTuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9mDbwjc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709816796; x=1741352796;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2RMapmPCobYn5uXk9EvUvUddEuIWAUjZ3Hmw1WtqFXI=;
  b=f9mDbwjc0SfnVzuqiJnNRL6IQdcShoHhKvMkrEb4ToVwBGkEJ8JIOeqs
   HI4jiJ/schW9+DX7PonRBtr07owys34SxFb/2jDnZP4QPxd6mpiGHX6lr
   K/WDqCZtqdUQHEaiBt8sBvEoc60kglsU0nRY4apY44wcP00ixI18WPfBu
   xMsyTOr1otKrIcL2tbcEUGd2Socf3YuhksdYJgdaAx097wU+KmntFmvM0
   koUV50hv/aJU2f2okV1TQYsvgiDvESUz0ZpCgYyBLAnFHRMILeoFcKGvy
   ytuV3rOgQguPQGzc71/IfO0QUp2vwh1OQps87fNMvHeT7FAV/ZDxh/PUy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15890618"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15890618"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="47594405"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:03:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 7 Mar 2024 15:03:07 +0200 (EET)
To: Kane Chen <kane.chen@intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    david.e.box@intel.com, kane.chen@intel.corp-partner.google.com
Subject: Re: [PATCH 1/1] platform/x86/intel/pmc: Improve PKGC residency
 counters debug
In-Reply-To: <20240307091011.877921-1-kane.chen@intel.com>
Message-ID: <f3d362bc-4ebf-3c36-6b10-06054e5e33dc@linux.intel.com>
References: <20240307091011.877921-1-kane.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1964956985-1709816587=:1003"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1964956985-1709816587=:1003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 7 Mar 2024, Kane Chen wrote:

> The current code only prints PKGC-10 residency when the PKGC-10
> is not reached in previous 'freeze' attempt. To debug PKGC-10 issues, we
> also need to know other PKGC residency counters to better triage issues.
> Ex:
> 1. When system is stuck in PC2, it can be caused short LTR from device.
> 2. When system is stuck in PC8, it can be caused by display engine.
>=20
> To better triage issues, all PKGC residency are needed when issues happen=
s.

happen.

> Example log:
>  CPU did not enter Package C10!!! (Package C10 cnt=3D0x0)
>  Prev Package C2 cnt =3D 0x2191a325de, Current Package C2 cnt =3D 0x21aba=
30724
>  Prev Package C3 cnt =3D 0x0, Current Package C3 cnt =3D 0x0
>  Prev Package C6 cnt =3D 0x0, Current Package C6 cnt =3D 0x0
>  Prev Package C7 cnt =3D 0x0, Current Package C7 cnt =3D 0x0
>  Prev Package C8 cnt =3D 0x0, Current Package C8 cnt =3D 0x0
>  Prev Package C9 cnt =3D 0x0, Current Package C9 cnt =3D 0x0
>  Prev Package C10 cnt =3D 0x0, Current Package C10 cnt =3D 0x0
>=20
> With this log, we can know whether it's a stuck PC2 issue, and we can
> check whether the short LTR from device causes the issue.
>=20
> Signed-off-by: Kane Chen <kane.chen@intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 47 ++++++++++++++++++++-------
>  drivers/platform/x86/intel/pmc/core.h |  7 ++--
>  2 files changed, 41 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 8f9c036809c79..b8910b671667e 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1389,6 +1389,15 @@ static int pmc_core_probe(struct platform_device *=
pdev)
>  =09=09return -ENOMEM;
>  =09pmcdev->pmcs[PMC_IDX_MAIN] =3D primary_pmc;
> =20
> +=09/* The last element in msr_map is empty */
> +=09pmcdev->num_of_pkgc =3D ARRAY_SIZE(msr_map) - 1;
> +=09pmcdev->pkgc_res_cnt =3D devm_kcalloc(&pdev->dev,
> +=09=09=09=09=09    pmcdev->num_of_pkgc,
> +=09=09=09=09=09    sizeof(*pmcdev->pkgc_res_cnt),
> +=09=09=09=09=09    GFP_KERNEL);
> +=09if (!pmcdev->pkgc_res_cnt)
> +=09=09return -ENOMEM;
> +
>  =09/*
>  =09 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
>  =09 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
> @@ -1432,6 +1441,7 @@ static __maybe_unused int pmc_core_suspend(struct d=
evice *dev)
>  {
>  =09struct pmc_dev *pmcdev =3D dev_get_drvdata(dev);
>  =09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> +=09int i;

unsigned int.

>  =09if (pmcdev->suspend)
>  =09=09pmcdev->suspend(pmcdev);
> @@ -1440,9 +1450,11 @@ static __maybe_unused int pmc_core_suspend(struct =
device *dev)
>  =09if (pm_suspend_via_firmware())
>  =09=09return 0;
> =20
> -=09/* Save PC10 residency for checking later */
> -=09if (rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter))
> -=09=09return -EIO;
> +=09/* Save PKGC residency for checking later */
> +=09for (i =3D 0; i < pmcdev->num_of_pkgc; i++) {
> +=09=09if (rdmsrl_safe(msr_map[i].bit_mask, &pmcdev->pkgc_res_cnt[i]))
> +=09=09=09return -EIO;
> +=09}
> =20
>  =09/* Save S0ix residency for checking later */
>  =09if (pmc_core_dev_state_get(pmc, &pmcdev->s0ix_counter))
> @@ -1451,14 +1463,15 @@ static __maybe_unused int pmc_core_suspend(struct=
 device *dev)
>  =09return 0;
>  }
> =20
> -static inline bool pmc_core_is_pc10_failed(struct pmc_dev *pmcdev)
> +static inline bool pmc_core_is_deepest_pkgc_failed(struct pmc_dev *pmcde=
v)
>  {
> -=09u64 pc10_counter;
> +=09u32 deepest_pkgc_msr =3D msr_map[pmcdev->num_of_pkgc - 1].bit_mask;
> +=09u64 deepest_pkgc_residency;
> =20
> -=09if (rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter))
> +=09if (rdmsrl_safe(deepest_pkgc_msr, &deepest_pkgc_residency))
>  =09=09return false;
> =20
> -=09if (pc10_counter =3D=3D pmcdev->pc10_counter)
> +=09if (deepest_pkgc_residency =3D=3D pmcdev->pkgc_res_cnt[pmcdev->num_of=
_pkgc - 1])
>  =09=09return true;
> =20
>  =09return false;
> @@ -1497,10 +1510,22 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev=
)
>  =09if (!warn_on_s0ix_failures)
>  =09=09return 0;
> =20
> -=09if (pmc_core_is_pc10_failed(pmcdev)) {
> -=09=09/* S0ix failed because of PC10 entry failure */
> -=09=09dev_info(dev, "CPU did not enter PC10!!! (PC10 cnt=3D0x%llx)\n",
> -=09=09=09 pmcdev->pc10_counter);
> +=09if (pmc_core_is_deepest_pkgc_failed(pmcdev)) {
> +=09=09/* S0ix failed because of deepest PKGC entry failure */
> +=09=09dev_info(dev, "CPU did not enter %s!!! (%s cnt=3D0x%llx)\n",
> +=09=09=09 msr_map[pmcdev->num_of_pkgc - 1].name,
> +=09=09=09 msr_map[pmcdev->num_of_pkgc - 1].name,
> +=09=09=09 pmcdev->pkgc_res_cnt[pmcdev->num_of_pkgc - 1]);
> +
> +=09=09for (i =3D 0; i < pmcdev->num_of_pkgc; i++) {
> +=09=09=09u64 pc_cnt;
> +
> +=09=09=09if (!rdmsrl_safe(msr_map[i].bit_mask, &pc_cnt)) {
> +=09=09=09=09dev_info(dev, "Prev %s cnt =3D 0x%llx, Current %s cnt =3D 0x=
%llx\n",
> +=09=09=09=09=09 msr_map[i].name, pmcdev->pkgc_res_cnt[i],
> +=09=09=09=09=09 msr_map[i].name, pc_cnt);
> +=09=09=09}
> +=09=09}
>  =09=09return 0;
>  =09}
> =20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 54137faaae2b2..fd7ae76984ac7 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -385,7 +385,8 @@ struct pmc {
>   * @pmc_xram_read_bit:=09flag to indicate whether PMC XRAM shadow regist=
ers
>   *=09=09=09used to read MPHY PG and PLL status are available
>   * @mutex_lock:=09=09mutex to complete one transcation
> - * @pc10_counter:=09PC10 residency counter
> + * @pkgc_res_cnt:=09PKGC residency counter

Array of PKGC residency counters


With those addressed, feel free to add:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.
--8323328-1964956985-1709816587=:1003--

