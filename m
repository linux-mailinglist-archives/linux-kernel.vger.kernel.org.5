Return-Path: <linux-kernel+bounces-56642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4084CD1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9957A288712
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494CF7E778;
	Wed,  7 Feb 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="BNHvEvQf"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7D76C99;
	Wed,  7 Feb 2024 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317138; cv=none; b=iSM/1HhHBI8O734pBGDJE1JUHgJLgFpOzCxz2zgYugdKkJtiCUjxzJvpNlMwBd2pLGj/nm9e+t7v5+ciN+JalGRG96z3+c9phfa5OCNCHhGbc8rYjVqPmNpIVSdEJc6rUbfRIklbaAd8IjZ/XYWRwU0oiRTxrfoqOkXrWwe4P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317138; c=relaxed/simple;
	bh=WYLy1ikNrA+6+T+L8K9tKy9zTDz4q3WCaNH+QvfN3rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOhhqJo45yN38/P2061jAJoOXrRSlkL/lC/aD2SFQzEL7yflc9XhuaNyUpo81VOaYI3P65me7iGsdrBfJuPbebGm7CdLPiFjSSWbttpaYye4lo99BR6+/aTPLRKWV94ovEn1sLwJWnh6CK5roA+Zi6yBjt6Akj/A4duPqlOJ2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=BNHvEvQf; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 5BD48635B069;
	Wed,  7 Feb 2024 15:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707317132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn52Yoi+UGfVo9bYNXUq7jjC9PgpLePUr/u26cyBj50=;
	b=BNHvEvQfuI8eC+qUUdIeix2J7orI/fVyxVe7Vg9ZUg/BmwDXfrgcV/YAoR/keAeJF99cje
	yvejiwGdQNnRhoqVY5r9OVa2IDxwhRAomNX/+Wr/LLkYcG3guO+jKIwlI8JaAxntgbNu6B
	BVqNd7H8nrR0xN2238vmCWuQuvMUSvo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/7] cpufreq: amd-pstate: initialize new core precision boost
 state
Date: Wed, 07 Feb 2024 15:45:20 +0100
Message-ID: <2047184.tdWV9SEqCh@natalenko.name>
In-Reply-To:
 <b4d4ced021e608268e87d630de9ed271cf5f3277.1707297581.git.perry.yuan@amd.com>
References:
 <cover.1707297581.git.perry.yuan@amd.com>
 <b4d4ced021e608268e87d630de9ed271cf5f3277.1707297581.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2342470.irdbgypaU6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2342470.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 07 Feb 2024 15:45:20 +0100
Message-ID: <2047184.tdWV9SEqCh@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 7. =C3=BAnora 2024 10:21:52 CET Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
>=20
> Add gloal global_params to represent current CPU Performance Boost(cpb)
> state for cpu frequency scaling, both active and passive modes all can
> support CPU cores frequency boosting control which is based on the BIOS
> setting, while BIOS turn on the "Core Performance Boost", it will
> allow OS control each core highest perf limitation from OS side.
>=20
> If core performance boost is disabled while a core is in a boosted P-stat=
e,
> the core transitions to the highest performance non-boosted P-state,
> that is the same as the nominal frequency limit.
>=20
> Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 49 ++++++++++++------------------------
>  include/linux/amd-pstate.h   | 14 +++++++++++
>  2 files changed, 30 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 08e112444c27..3772f71f525f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state =3D AMD_PSTATE_UNDEFINED;
>  static bool cppc_enabled;
>  static bool amd_pstate_prefcore =3D true;
> +struct global_params global;

Doesn't this require `EXPORT_SYMBOL_GPL(global)` then? Otherwise with v6.8 =
I get this:

```
ERROR: modpost: "global" [drivers/cpufreq/amd-pstate-ut.ko] undefined!
```

If so, I'd pretty mush rename this to be less generic, say, `amd_pstate_glo=
bal_params_struct` for the struct name itself and `amd_pstate_global_params=
` for the actual variable name.

> =20
>  /*
>   * AMD Energy Preference Performance (EPP)
> @@ -669,43 +670,21 @@ static int amd_get_lowest_nonlinear_freq(struct amd=
_cpudata *cpudata)
>  	return lowest_nonlinear_freq * 1000;
>  }
> =20
> -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  {
> -	struct amd_cpudata *cpudata =3D policy->driver_data;
> +	u64 boost_val;
>  	int ret;
> =20
> -	if (!cpudata->boost_supported) {
> -		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> -		return -EINVAL;
> -	}
> -
> -	if (state)
> -		policy->cpuinfo.max_freq =3D cpudata->max_freq;
> -	else
> -		policy->cpuinfo.max_freq =3D cpudata->nominal_freq;
> -
> -	policy->max =3D policy->cpuinfo.max_freq;
> -
> -	ret =3D freq_qos_update_request(&cpudata->req[1],
> -				      policy->cpuinfo.max_freq);
> -	if (ret < 0)
> +	ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> +	if (ret) {
> +		pr_err_once("failed to read initial CPU boost state!\n");
>  		return ret;
> +	}
> =20
> -	return 0;
> -}
> -
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> -{
> -	u32 highest_perf, nominal_perf;
> -
> -	highest_perf =3D READ_ONCE(cpudata->highest_perf);
> -	nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> -
> -	if (highest_perf <=3D nominal_perf)
> -		return;
> +	global.cpb_supported =3D !((boost_val >> 25) & 0x1);
> +	global.cpb_boost =3D global.cpb_supported;
> =20
> -	cpudata->boost_supported =3D true;
> -	current_pstate_driver->boost_enabled =3D true;
> +	return ret;
>  }
> =20
>  static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -848,6 +827,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy =
*policy)
>  	if (ret)
>  		goto free_cpudata1;
> =20
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq =3D amd_get_min_freq(cpudata);
>  	max_freq =3D amd_get_max_freq(cpudata);
>  	nominal_freq =3D amd_get_nominal_freq(cpudata);
> @@ -899,7 +881,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy =
*policy)
> =20
>  	policy->driver_data =3D cpudata;
> =20
> -	amd_pstate_boost_init(cpudata);
>  	if (!current_pstate_driver->adjust_perf)
>  		current_pstate_driver->adjust_perf =3D amd_pstate_adjust_perf;
> =20
> @@ -1310,6 +1291,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_p=
olicy *policy)
>  	if (ret)
>  		goto free_cpudata1;
> =20
> +	/* initialize cpu cores boot state */
> +	amd_pstate_boost_init(cpudata);
> +
>  	min_freq =3D amd_get_min_freq(cpudata);
>  	max_freq =3D amd_get_max_freq(cpudata);
>  	nominal_freq =3D amd_get_nominal_freq(cpudata);
> @@ -1360,7 +1344,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_p=
olicy *policy)
>  			return ret;
>  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
>  	}
> -	amd_pstate_boost_init(cpudata);
> =20
>  	return 0;
> =20
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..465e9295a60c 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -124,4 +124,18 @@ static const char * const amd_pstate_mode_string[] =
=3D {
>  	[AMD_PSTATE_GUIDED]      =3D "guided",
>  	NULL,
>  };
> +
> +/**
> + * struct global_params - Global parameters, mostly tunable via sysfs.
> + * @cpb_boost:		Whether or not to use boost CPU P-states.
> + * @cpb_supported:	Whether or not CPU boost P-states are available
> + *			based on the MSR_K7_HWCR bit[25] state
> + */
> +struct global_params {
> +	bool cpb_boost;
> +	bool cpb_supported;
> +};
> +
> +extern struct global_params global;
> +
>  #endif /* _LINUX_AMD_PSTATE_H */
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart2342470.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXDl4AACgkQil/iNcg8
M0vQmw//efRzOEuZDnINpGwhYSq28niZyIIA62SB5IvTGgWEEIAHpXiQHXvdWmmk
g41Y/PWPFBpveCP7TkoGe7nbZ1ooqwTzTN70UTC+6OCjd3BY9kzxNL5nUDjQBrMQ
3tOaOMkxkxRWmqBSyWin46rrlWPfX+utwAOKlWmbxffXTGtkynwXjdTtIS8j9psJ
QvKJThu+GW5V5TTZSvLMZIxb5tTeaGcTgGWTQnt6MJBlYZLRfuG2/lUAKNF2u0e7
eGVSoZiFP3B90fYVWZy/m0EL4qAhYrHmEJP0Dl0PJsxYcLeo/OJ5SuFL/1194WSk
PczMSDmCqJStqNewrastcIlsvQCzUmGayMwfuUv6vBvrpsKvmYMHqmY9Z94gAzan
ffgR7A8NjjD4Kuu/AtqY1s1Vpp0ovPq7S9MLGreEptZ6oHf9kToD4YYcbnccsgYd
FWehyKmMb9PrIZ3r9o2dywOqY5KjzORcNsN3412VtLkUtgcsKZJJsqklMmuD7zHJ
NV4LfTf/ebrrBQ5AvIozfxw6Deuqiwk1KR0bO/Xf4yiQnaGFf/OVlXMxyQLE4Aev
0tqk3wRqvvJbRwfcBNweS8YVKlv4RQ/pOnZWwU1FGsci/5LufcFqKkKQDFKD3k8h
IWuyNv0oEGZVyzD3F5Ey+Pxft7aYwyaw30Q3vFz2+yZwaf74A48=
=20/u
-----END PGP SIGNATURE-----

--nextPart2342470.irdbgypaU6--




