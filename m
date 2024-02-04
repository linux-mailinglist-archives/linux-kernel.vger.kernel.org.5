Return-Path: <linux-kernel+bounces-51718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBDF848E90
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2111C20E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B121340;
	Sun,  4 Feb 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="UKqMtLJX"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEB22307;
	Sun,  4 Feb 2024 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057944; cv=none; b=rkoEsm3vfmPXrSSGMwEUX1EIztS3d7/lHHvbALia1COCmLEmOkbCAxUrL3p5aYca35UWdhEWUgHcG0PW1QWM7+F4x0AZqPC0xxvwoDA2590SCPosTy2PN8Vg1+lRu4twyabelBtgV7RY91CgIETPq3ksWF89DGM8T9hZyz0apXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057944; c=relaxed/simple;
	bh=Q/DyrLb6XiAQIQICqdB41c7MRHiIXAynuv6Olj4mq4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Id5u71Mn43tIcBlTDrejXiqJTo+dNxn+2ABbr3fApRcLKguw6zMrIea63U58Ptt4sRBiqiamKXhx+DmramJXKK9NkkyTIsNE5LKXmNa2qKGdSJutakXKQ+TNQWBlIfBLj2/NK8tli70ytUkEjl1V4NJk9FQt0sRj9m6PEJG1AiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=UKqMtLJX; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 4A83A6356CC0;
	Sun,  4 Feb 2024 15:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707057932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVQ5IU3bsTJjSUmo0oW7TLJ+lNbPq3M7Fw7/MWc1gzo=;
	b=UKqMtLJX0zhJHBTyiFml2TgEAWrgJix2FD1n8tDzQ67hDu4ipjdgmo7j9xl4BY8tgOOBkE
	/sCmhNLXekxmeC4N3N/BQUOx7H/UMBhCPp1V592f2o84wet1DOey04LZDuInxo7984S/YO
	1/lS7mTcB4sDfXiC5IKYOOKsmYnj1o4=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Date: Sun, 04 Feb 2024 15:45:19 +0100
Message-ID: <2719030.mvXUDI8C0e@natalenko.name>
In-Reply-To:
 <dc7fc753b596a4e262b21d2c2e8eec3570e4a97c.1707016927.git.perry.yuan@amd.com>
References:
 <cover.1707016927.git.perry.yuan@amd.com>
 <dc7fc753b596a4e262b21d2c2e8eec3570e4a97c.1707016927.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12375092.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12375092.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sun, 04 Feb 2024 15:45:19 +0100
Message-ID: <2719030.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0

Hello.

On ned=C4=9Ble 4. =C3=BAnora 2024 4:26:14 CET Perry Yuan wrote:
> Add quirks table to get CPPC capabilities issue fixed by providing
> correct perf or frequency values while driver loading.
>=20
> If CPPC capabilities are not defined in the ACPI tables or wrongly
> defined by platform firmware, it needs to use quick to get those
> issues fixed with correct workaround values to make pstate driver
> can be loaded even though there are CPPC capabilities errors.
>=20
> The workaround will match the broken BIOS which lack of CPPC capabilities
> nominal_freq and lowest_freq definition in the ACPI table.
>=20
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> 0
> $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
> 0
>=20
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 49 ++++++++++++++++++++++++++++++++++--
>  include/linux/amd-pstate.h   |  6 +++++
>  2 files changed, 53 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 77effc3caf6c..25a6d8a808c4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state =3D AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore =3D true;
> +static struct quirk_entry *quirks;
> =20
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -111,6 +112,33 @@ static unsigned int epp_values[] =3D {
> =20
>  typedef int (*cppc_mode_transition_fn)(int);
> =20
> +static struct quirk_entry quirk_amd_7k62 =3D {
> +	.nominal_freq =3D 2600,
> +	.lowest_freq =3D 550,
> +};
> +
> +static int __init dmi_matched(const struct dmi_system_id *dmi)
> +{
> +	quirks =3D dmi->driver_data;
> +	pr_info("hardware type %s found\n", dmi->ident);
> +
> +	return 1;
> +}
> +
> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst =
=3D {
> +	{
> +		.callback =3D dmi_matched,
> +		.ident =3D "AMD EPYC 7K62",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
> +			DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019");

I think this is incorrect, and there should be a comma "," instead of semic=
olon ";" at the end of the string. Otherwise the build will fail.

> +		},
> +		.driver_data =3D &quirk_amd_7k62,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> +
>  static inline int get_mode_idx_from_str(const char *str, size_t size)
>  {
>  	int i;
> @@ -600,13 +628,19 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 lowest_freq;
> =20
>  	int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
> =20
> +	if (quirks && quirks->lowest_freq)
> +		lowest_freq =3D quirks->lowest_freq;
> +	else
> +		lowest_freq =3D cppc_perf.lowest_freq;
> +
>  	/* Switch to khz */
> -	return cppc_perf.lowest_freq * 1000;
> +	return lowest_freq * 1000;
>  }
> =20
>  static int amd_get_max_freq(struct amd_cpudata *cpudata)
> @@ -635,12 +669,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpu=
data)
>  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>  {
>  	struct cppc_perf_caps cppc_perf;
> +	u32 nominal_freq;
> =20
>  	int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>  	if (ret)
>  		return ret;
> =20
> -	return cppc_perf.nominal_freq;
> +	if (quirks && quirks->nominal_freq)
> +		nominal_freq =3D quirks->nominal_freq;
> +	else
> +		nominal_freq =3D cppc_perf.nominal_freq;
> +
> +	return nominal_freq;
>  }
> =20
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> @@ -1672,6 +1712,11 @@ static int __init amd_pstate_init(void)
>  	if (cpufreq_get_current_driver())
>  		return -EEXIST;
> =20
> +	quirks =3D NULL;
> +
> +	/* check if this machine need CPPC quirks */
> +	dmi_check_system(amd_pstate_quirks_table);
> +
>  	switch (cppc_state) {
>  	case AMD_PSTATE_UNDEFINED:
>  		/* Disable on the following configs by default:
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..7b2cbb892fd9 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -124,4 +124,10 @@ static const char * const amd_pstate_mode_string[] =
=3D {
>  	[AMD_PSTATE_GUIDED]      =3D "guided",
>  	NULL,
>  };
> +
> +struct quirk_entry {
> +	u32 nominal_freq;
> +	u32 lowest_freq;
> +};
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12375092.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmW/ov8ACgkQil/iNcg8
M0tc0g/+P9RKvchdcskUBEqJ1UgfSndpl/44T4VuBeiXLlxYPEMg8qiYVBSrGlez
3uAmn7pW25mfgddTYDTSe1m+tdwGEErg0WzN3A/Y+pJ6DM1rItEaNBEmVV+NDcF+
rKcpNzQ+7cSGFKTLmJvAsgrYCB5Ahlt0FWq3psFOmc1bHAoQ3mnnE+3RgEZJgIuO
YAAK1D6TfKRHAHcc+zUZdK+HiJe2ZaOpj4MJWXQVQudvCzCi7eLWehwS7NK+qBvF
WtKXVfvC+/CivXSk9NwPkAlm2t0pXxpfrm+9IX47v9QEt/WHKM0C/3z5cCfIKBOd
oVn1cVliakaO+J4OW/z+nd/a/8BpBPEtUPTLKHI/8DpQ44wc+Gcsq9SdqFX8kfFs
8EZUGytcI4ZeOXah7eQInrmwAUOQxkkfhKiEI86NiAOia5Qr4c2G+3zsE1UbKFX3
42gzkBTjFHKaqUz0sGUo/5s9I60b93ykc/mjxJQ+x3wLTXNZk02Q6sG6APzFFwa5
TCSMlxH3ty8MFxedDBRsZ+r/+plPydQLeMTYDwjCEe4xyvr+4SEI/mrGWnhvm49s
bvA9bonikWXkzSSE94DRr7+LqXtF4lUAihr86SiewQ4K5iarbttg4XLVEb5CPuCU
h1hwLV9BkvQR47d5ul0gm4fKGk5RI8V+Kk6uNi/XUYWQq/KPySM=
=gfuJ
-----END PGP SIGNATURE-----

--nextPart12375092.O9o76ZdvQC--




