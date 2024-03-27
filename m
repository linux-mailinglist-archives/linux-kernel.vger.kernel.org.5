Return-Path: <linux-kernel+bounces-121785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE488EDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269C41C328D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077D14E2F0;
	Wed, 27 Mar 2024 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrtmX0td"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946F14E2D0;
	Wed, 27 Mar 2024 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562927; cv=none; b=BQjis2renq1XbEZ7jwSBZ0Y6p4FAg+4VrKj7OKwrR/b8Bb+K5TgevkbLyDZLN94ZFiTjK0grJc7adgUtkegUMIMFAKeeDsHwsu/ToNYL2zwITQjYvf0RRy8Du871oVHQO1AiEnncg2QSYqmrro5H2WV0mKM9hhv+NAwoUZZjQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562927; c=relaxed/simple;
	bh=r+MgBwOSBmx+FMDmtcmiqTwVcXn5T3HZLzrrHM5Byh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sirxFysSWdMF8N8/g2AhDKq5+p82Gl0QxsdPNZFXqIp1ZLXFB4kBRTXTQVctfzIXFBtiV1PO23u/gFafTGPB7V6tYS80g6UW9OZQhOi00eSY+mPhLyiMWxlMhQdF7/JslOr+LIk8tNRmgTMUgfR3H9ClCMS1cH2FLbHECgSIaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrtmX0td; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711562924; x=1743098924;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r+MgBwOSBmx+FMDmtcmiqTwVcXn5T3HZLzrrHM5Byh8=;
  b=VrtmX0tdxuliyhozkjD3BihbHkhEDhTBzxm/HWH/WqnnzOfx604Ycy6w
   1gjTwKKu5NzVSLUTyhG7ka/7XIQt8oIWC0XzEmwfmxpGMNnzL8h1p9PYo
   m9P0LuzBIX/P+ExBOB2uKfhITyOJSOiFIjsHFeP8aP82Sqjk9fvLRRvHZ
   oYMHYgwodPNmJXoPTizHlG7k0OKnaFPw1kLBFIIkE243Qp83+Z6ukS9JF
   2CWhuVPBqhozjgbskhpqbYH5LWebd1Kq3Owu9hPZeXr5ZL1GNUv98xw2p
   ANOvPqSeERZrr5Y7rCp8nRGrLNIU8+KbyWGOJ5b4Rxse0iW9ADdzKDQrY
   A==;
X-CSE-ConnectionGUID: Zv0dCqpXSe+JBKIaQqj8Lg==
X-CSE-MsgGUID: Bry9A9oIT0O0+nPX/LdMMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24138214"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24138214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16312915"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.18.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:08:43 -0700
Message-ID: <f1bdd6a971c67ea83697278ed2f1beff89a78f1f.camel@linux.intel.com>
Subject: Re: [PATCH v1 6/6] cpufreq: intel_pstate: Update the maximum CPU
 frequency consistently
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 27 Mar 2024 11:08:42 -0700
In-Reply-To: <9269494.CDJkKcVGEf@kreacher>
References: <13494237.uLZWGnKmhe@kreacher> <9269494.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 18:06 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> There are 3 places at which the maximum CPU frequency may change,
> store_no_turbo(), intel_pstate_update_limits() (when called by the
> cpufreq core) and intel_pstate_notify_work() (when handling a HWP
> change notification).=C2=A0 Currently, cpuinfo.max_freq is only updated b=
y
> store_no_turbo(), although it principle it may be necessary to update
> it at the other 2 places too.

It also works for intel_pstate_notify_work() path as is without this
change.

To start with:

$ sudo rdmsr 0x771
6080c14
$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
2000000
800000
0

Now trigger a max frequency change via SST. intel_pstate_notify_work()
called because guaranteed also changed. We didn't subscribe for max
change only (although we should).

Max changed from 2GHz to 1.9 GHz.

$ sudo rdmsr 0x771
6080e13
[labuser@gnr-bkc ~]$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
1900000
800000
0

Now trigger SST to change to max frequency to 2GHz.

sudo rdmsr 0x771
6080c14

cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
2000000
800000
0

May be you mean something else.

Thanks,
Srinivas


>=20
> Make all of them mutually consistent.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0 23 ++++++++++++++++++-=
----
> =C2=A01 file changed, 18 insertions(+), 5 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1153,18 +1153,32 @@ static void intel_pstate_update_policies
> =C2=A0static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpufreq_policy
> *policy)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_get_hwp_cap(cpuda=
ta);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0policy->cpuinfo.max_freq =
=3D READ_ONCE(global.no_turbo) ?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu=
data->pstate.max_freq : cpudata-
> >pstate.turbo_freq;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0refresh_frequency_limits(=
policy);
> =C2=A0}
> =C2=A0
> =C2=A0static void intel_pstate_update_limits(unsigned int cpu)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&intel_pstate_drive=
r_lock);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cpufreq_policy *policy =
=3D cpufreq_cpu_acquire(cpu);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_update_policy(cpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!policy)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&intel_pstate_dri=
ver_lock);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__intel_pstate_update_max_freq=
(all_cpu_data[cpu], policy);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_cpu_release(policy);
> +}
> +
> +static void intel_pstate_update_limits_for_all(void)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cpu;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for_each_possible_cpu(cpu)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0intel_pstate_update_limits(cpu);
> =C2=A0}
> =C2=A0
> =C2=A0/************************** sysfs begin ************************/
> @@ -1311,7 +1325,7 @@ static ssize_t store_no_turbo(struct kob
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&intel_pstat=
e_limits_lock);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_update_policies()=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intel_pstate_update_limits_for=
_all();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch_set_max_freq_ratio(n=
o_turbo);
> =C2=A0
> =C2=A0unlock_driver:
> @@ -1595,7 +1609,6 @@ static void intel_pstate_notify_work(str
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cpufreq_policy *po=
licy =3D cpufreq_cpu_acquire(cpudata-
> >cpu);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (policy) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0intel_pstate_get_hwp_cap(cpudata);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0__intel_pstate_update_max_freq(cpudata, policy);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0cpufreq_cpu_release(policy);
>=20
>=20
>=20


