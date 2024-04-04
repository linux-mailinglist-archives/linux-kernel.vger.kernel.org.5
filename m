Return-Path: <linux-kernel+bounces-130810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11948897D58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F91C25030
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953F14A81;
	Thu,  4 Apr 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+KmZwJl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA8BE40;
	Thu,  4 Apr 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193350; cv=none; b=CkYzm6AaQMwXmxkJ+w2MGiIbZlwfhkeLI2qFnV6lc8wIhFOGe/Tk6ZxIXBjbREB6lroAy3C5i/MMRs8moj7tzBZxyDgAjM2BAZHo2vUk9g9fhv3KRWfszmK1QiXhKCHOO77y8ieTQxF+YEAECx8GyRTAH6pidl0DMX7Rk/MMvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193350; c=relaxed/simple;
	bh=bTWiElf3y9Mb72tsq/IL9WbaI71cY8hVMEjcnYahzoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3aZyhU+DXLmSrPb31gZW0+4iT+M644Nb7qvtq+7hoKTIlZGlb2wGxEVLe3jsciW+ALUi1UHZ0+S/RYfAtOPTAD5DLuIY+321dQI8Fw9D6pxzCxbzXqN76ie6GKrnuBDVzDepUo9wbbBeLvkOSUei8a9FmDh65HCdJIwNNval6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+KmZwJl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712193349; x=1743729349;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bTWiElf3y9Mb72tsq/IL9WbaI71cY8hVMEjcnYahzoQ=;
  b=c+KmZwJlQS3vQYXtGA68MRG+arOzr4Vs1F36xTii+itM7xbrOyJqAtE0
   22wEDPOEuBb/r4NidVhpGxesKBPHbjNuZLRv+ktqX1kSNe7YKtcw3i4+S
   OBIWXy7FS38tdfZKuRA2JYpPLnkUq/fVnVIMPkwYxo1SPK7RkXUue47L5
   3JGYi295Z6lULMqxkbJNdjJju4eMSdTdKCCWL/vuHRwH2tvJPWwURy300
   nSsMwsQg0zlVFiaNPWVhfb6A3kU0ZoC/k9o+ZcRvFuB3yT4Xl47B5K8H0
   5CBReRliSuShfm1rTjQ/QmJ1e4ZyYgGix3h4euRxOzfvyuw5gYcOlzukY
   w==;
X-CSE-ConnectionGUID: B3OSSMmQTHut9DYyFJFL2w==
X-CSE-MsgGUID: ol5M3NH4QA6cKnBjrPx0MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11232322"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11232322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 18:15:48 -0700
X-CSE-ConnectionGUID: 7ep+mN8GSBaDSDyIrjVxYA==
X-CSE-MsgGUID: WtNWftyFTcu9u3gDFtobGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18722413"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.37.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 18:15:49 -0700
Message-ID: <8b4cb4ad67032fad69f29df8e6b83054c7fa15db.camel@linux.intel.com>
Subject: Re: [RFC PATCH] therm_throt: test bits as we build
 therm_intr_core_clear_mask
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kyle McMartin <kyle@infradead.org>, "Rafael J. Wysocki"
	 <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, kernel-team@fb.com,
 linux-kernel@vger.kernel.org
Date: Wed, 03 Apr 2024 18:15:47 -0700
In-Reply-To: <Zg3GhhTZotBNvlRR@merlin.infradead.org>
References: <Zg3GhhTZotBNvlRR@merlin.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Kyle,

On Wed, 2024-04-03 at 17:13 -0400, Kyle McMartin wrote:
> X86_FEATURE_HWP appears to be insufficient on some platforms, and
> writing 1 to BIT(13)|BIT(15) results in the wrmsrl trapping and
> failing
> to clear PROCHOT_LOG.
>=20
> Instead, also try to wrmsrl_safe with those bits set in the mask, and
> check if we get -EIO back. If so, those bits will trap and prevent us
> from writing to THERM_STATUS.
>=20
> Signed-off-by: Kyle McMartin <jkkm@fb.com>
>=20
> ---
>=20
> We noticed a problem on some of our production hosts while rolling
> out
> 6.4 kernels where we were seeing PROCHOT_LOG set but never cleared,
> along with a warn on once in wrmsr.
>=20
> I tracked this down to:
>=20
> commit 930d06bf071aa746db11d68d2d75660b449deff3
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:=C2=A0=C2=A0 Tue Nov 15 18:54:17 2022 -0800
>=20
> =C2=A0=C2=A0=C2=A0 thermal: intel: Protect clearing of thermal status bit=
s
>=20
> which started setting some unexpected bits in THERM_STATUS on our
> platform. Previously, the mask had these bits set, but we were
> masking
> with the MSR which was resulting in them not being written to 1.
>=20
> Starting with 117e4e5bd9d47b89777dbf6b37a709dcfe59520f, these bits
> were
> protected by the HWP CPUID flag, but on some of our platforms, this
> doesn't seem sufficient.
>=20
> On Broadwell and Broadwell-DE, the HWP flag is not set, but writing
> these bits does not trap.
>=20
> On our Skylake-DE, Skylake, and Cooper Lake platforms, the HWP flag
> is
> set in CPUID, and writing 1 to these bits traps attempting to write
> 0xAAA8 to MSR 0x19C (THERM_STATUS). Writing 0xAA8 from userspace
> works
> as expected to un-stick PROCHOT_LOG.

I think this issue happens only on Skylake, Cascade Lake, Cooper Lake
and not on any other systems.

Please verify:
GP# happens only when bit13 (Current Limit Log) or bit15 (Cross Domain
Limit Log) is 1.

Basically writing 0x2000 or 0x8000  or A000 will cause this issue.
Are you using the latest BIOS with microcode?
Please confirm your microcode version, I can check internally.

Thanks,
Srinivas


>=20
> On our Sapphire Rapids platforms, the HWP flag is set, and writing 1
> to
> these bits is successful.
>=20
> =C2=A0drivers/thermal/intel/therm_throt.c | 29 ++++++++++++++++++++++----=
-
> --
> =C2=A01 file changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/intel/therm_throt.c
> b/drivers/thermal/intel/therm_throt.c
> index e69868e868eb..3058d8fcfcef 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -196,8 +196,14 @@ static const struct attribute_group
> thermal_attr_group =3D {
> =C2=A0static u64 therm_intr_core_clear_mask;
> =C2=A0static u64 therm_intr_pkg_clear_mask;
> =C2=A0
> +/* Probe each addition to the mask to ensure that our wrmsrl
> + * won't fail to clear bits.
> + */
> =C2=A0static void thermal_intr_init_core_clear_mask(void)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 bits =3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 mask =3D 0;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (therm_intr_core_clear=
_mask)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> @@ -211,25 +217,34 @@ static void
> thermal_intr_init_core_clear_mask(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 1, 3, 5: CPUID.01H=
:EDX[22] =3D 1. This driver will not
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * enable interrupts, whe=
n 0 as it checks for
> X86_FEATURE_ACPI.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0therm_intr_core_clear_mask =3D=
 (BIT(1) | BIT(3) | BIT(5));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mask =3D (BIT(1) | BIT(3) | BI=
T(5));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 7 and 9: Thermal T=
hreshold #1 and #2 log
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If CPUID.01H:ECX[8] =
=3D 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_T=
M2))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0therm_intr_core_clear_mask |=3D (BIT(7) | BIT(9));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bits =3D BIT(7) | BIT(9);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_T=
M2) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl_safe=
(MSR_IA32_THERM_STATUS, mask | bits) >=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mask |=3D bits;
> +
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Bit 11: Power Limitati=
on log (R/WC0) If CPUID.06H:EAX[4] =3D
> 1 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_P=
LN))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0therm_intr_core_clear_mask |=3D BIT(11);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bits =3D BIT(11);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_P=
LN) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl_safe=
(MSR_IA32_THERM_STATUS, mask | bits) >=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mask |=3D bits;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 13: Current Limit =
log (R/WC0) If CPUID.06H:EAX[7] =3D 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Bit 15: Cross Domain L=
imit log (R/WC0) If CPUID.06H:EAX[7]
> =3D 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_H=
WP))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0therm_intr_core_clear_mask |=3D (BIT(13) | BIT(15));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bits =3D BIT(13) | BIT(15);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (boot_cpu_has(X86_FEATURE_H=
WP) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl_safe=
(MSR_IA32_THERM_STATUS, mask | bits) >=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0mask |=3D bits;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0therm_intr_core_clear_mask =3D=
 mask;
> =C2=A0}
> =C2=A0
> =C2=A0static void thermal_intr_init_pkg_clear_mask(void)


