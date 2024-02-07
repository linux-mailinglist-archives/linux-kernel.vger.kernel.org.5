Return-Path: <linux-kernel+bounces-56699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9AD84CDC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6EB1C21242
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1C7F7D0;
	Wed,  7 Feb 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Prwa5tDO"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330C7F7C6;
	Wed,  7 Feb 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318674; cv=none; b=cmwU3EQpEi2l6h+gZM61tOGlvIE4kPTs/heBf5R9uqzw96LAfCP3O5tXIEvdqXxxNUQmOvC5jvRjTLlJ+YfJyZyt7eDt33Wrg3eDgSJcXe0DmJS/EqMhlhqG4UfKqW4bmB3kmisqtMoi4c1Vg17GGMJKPpQbhHZyM9thC5+b4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318674; c=relaxed/simple;
	bh=XpXmSJ5tIDmLLHGbcjuy5nTY0IPHrjwwEgGQLeldJ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYE62MyryGEhipmkGrB0PxI/iNTOaPi0cs9q7aJ64ZmMgUhJozxQf97b506LyWq0eL5GIaeZN/ko4/fbn01I/v4g1ugme1Zuv/bjRli3N99t4jFRIH+IuucXLh7xO8WKeBFe+ZBx/VbSyeXdOM6FYwm9yI17894OVu+XbIi3Sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=Prwa5tDO; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 6701D635B069;
	Wed,  7 Feb 2024 16:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707318668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m0LSyLulnt3cUdxL9u5BZ7Lb4NfydxMhiplAhkfj+U=;
	b=Prwa5tDO4M9XeCAuK4tG4cGTpwcdoAKTSxs8Qlravb5utWAH4ps7Lgkn+UuqjYC1JP1TYR
	8dEDX1e8kFVgNo8rKeXr36YtkOPtRE7PI0szZZK0PpWXTlTDdQEal08JwM1pM2cpc/ilgc
	pkqQZqjigh56WbFlKUqE1iQ+gA1n+DM=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/7] cpufreq: amd-pstate: initialize new core precision boost
 state
Date: Wed, 07 Feb 2024 16:10:55 +0100
Message-ID: <3091564.e9J7NaK4W3@natalenko.name>
In-Reply-To: <2047184.tdWV9SEqCh@natalenko.name>
References:
 <cover.1707297581.git.perry.yuan@amd.com>
 <b4d4ced021e608268e87d630de9ed271cf5f3277.1707297581.git.perry.yuan@amd.com>
 <2047184.tdWV9SEqCh@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3443796.aeNJFYEL58";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3443796.aeNJFYEL58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 07 Feb 2024 16:10:55 +0100
Message-ID: <3091564.e9J7NaK4W3@natalenko.name>
In-Reply-To: <2047184.tdWV9SEqCh@natalenko.name>
MIME-Version: 1.0

On st=C5=99eda 7. =C3=BAnora 2024 15:45:20 CET Oleksandr Natalenko wrote:
> On st=C5=99eda 7. =C3=BAnora 2024 10:21:52 CET Perry Yuan wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >=20
> > Add gloal global_params to represent current CPU Performance Boost(cpb)
> > state for cpu frequency scaling, both active and passive modes all can
> > support CPU cores frequency boosting control which is based on the BIOS
> > setting, while BIOS turn on the "Core Performance Boost", it will
> > allow OS control each core highest perf limitation from OS side.
> >=20
> > If core performance boost is disabled while a core is in a boosted P-st=
ate,
> > the core transitions to the highest performance non-boosted P-state,
> > that is the same as the nominal frequency limit.
> >=20
> > Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 49 ++++++++++++------------------------
> >  include/linux/amd-pstate.h   | 14 +++++++++++
> >  2 files changed, 30 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 08e112444c27..3772f71f525f 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
> >  static int cppc_state =3D AMD_PSTATE_UNDEFINED;
> >  static bool cppc_enabled;
> >  static bool amd_pstate_prefcore =3D true;
> > +struct global_params global;
>=20
> Doesn't this require `EXPORT_SYMBOL_GPL(global)` then? Otherwise with v6.=
8 I get this:
>=20
> ```
> ERROR: modpost: "global" [drivers/cpufreq/amd-pstate-ut.ko] undefined!
> ```
>=20
> If so, I'd pretty mush rename this to be less generic, say, `amd_pstate_g=
lobal_params_struct` for the struct name itself and `amd_pstate_global_para=
ms` for the actual variable name.

Something like this should do the trick (compile-tested only):

```
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-u=
t.c
index 91780ec42712..c5e2ca02f5ea 100644
=2D-- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
=20
=2D		if (global.cpb_supported) {
+		if (amd_pstate_global_params.cpb_supported) {
 			if ((policy->max =3D=3D cpudata->max_freq) ||
 					(policy->max =3D=3D cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result =3D AMD_PSTATE_UT_RESULT_PASS;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index aebecd4e2e73..3e23d114c73f 100644
=2D-- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,7 +68,8 @@ static int cppc_state =3D AMD_PSTATE_UNDEFINED;
 static bool cppc_enabled;
 static bool amd_pstate_prefcore =3D true;
 static struct quirk_entry *quirks;
=2Dstruct global_params global;
+struct amd_pstate_global_params amd_pstate_global_params;
+EXPORT_SYMBOL_GPL(amd_pstate_global_params);
=20
 /*
  * AMD Energy Preference Performance (EPP)
@@ -496,7 +497,7 @@ static void amd_pstate_update(struct amd_cpudata *cpuda=
ta, u32 min_perf,
 	value |=3D AMD_CPPC_DES_PERF(des_perf);
=20
 	/* limit the max perf when core performance boost feature is disabled */
=2D	if (!global.cpb_boost)
+	if (!amd_pstate_global_params.cpb_boost)
 		max_perf =3D min_t(unsigned long, nominal_perf, max_perf);
=20
 	value &=3D ~AMD_CPPC_MAX_PERF(~0L);
@@ -672,7 +673,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	max_perf =3D READ_ONCE(cpudata->highest_perf);
=20
 	/* when boost is off, the highest perf will be limited to nominal_perf */
=2D	if (!global.cpb_boost)
+	if (!amd_pstate_global_params.cpb_boost)
 		max_perf =3D nominal_perf;
=20
 	boost_ratio =3D div_u64(max_perf << SCHED_CAPACITY_SHIFT,
@@ -737,8 +738,8 @@ static int amd_pstate_boost_init(struct amd_cpudata *cp=
udata)
 		return ret;
 	}
=20
=2D	global.cpb_supported =3D !((boost_val >> 25) & 0x1);
=2D	global.cpb_boost =3D global.cpb_supported;
+	amd_pstate_global_params.cpb_supported =3D !((boost_val >> 25) & 0x1);
+	amd_pstate_global_params.cpb_boost =3D amd_pstate_global_params.cpb_suppo=
rted;
=20
 	return ret;
 }
@@ -1337,7 +1338,7 @@ static int amd_cpu_boost_update(struct amd_cpudata *c=
pudata, u32 on)
 static ssize_t cpb_boost_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
=2D	return sysfs_emit(buf, "%u\n", global.cpb_boost);
+	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
 }
=20
 static ssize_t cpb_boost_store(struct device *dev, struct device_attribute=
 *b,
@@ -1348,7 +1349,7 @@ static ssize_t cpb_boost_store(struct device *dev, st=
ruct device_attribute *b,
 	int cpu;
=20
 	mutex_lock(&amd_pstate_driver_lock);
=2D	if (!global.cpb_supported) {
+	if (!amd_pstate_global_params.cpb_supported) {
 		pr_err("Boost mode is not supported by this processor or SBIOS\n");
 		return -EINVAL;
 	}
@@ -1357,7 +1358,7 @@ static ssize_t cpb_boost_store(struct device *dev, st=
ruct device_attribute *b,
 	if (ret)
 		return -EINVAL;
=20
=2D	global.cpb_boost =3D !!new_state;
+	amd_pstate_global_params.cpb_boost =3D !!new_state;
=20
 	for_each_possible_cpu(cpu) {
=20
@@ -1371,7 +1372,7 @@ static ssize_t cpb_boost_store(struct device *dev, st=
ruct device_attribute *b,
 			goto err_exit;
 		}
=20
=2D		amd_cpu_boost_update(cpudata, global.cpb_boost);
+		amd_cpu_boost_update(cpudata, amd_pstate_global_params.cpb_boost);
 		refresh_frequency_limits(policy);
 		cpufreq_cpu_put(policy);
 	}
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index b0db335f3883..f6e2c9825700 100644
=2D-- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -129,16 +129,16 @@ struct quirk_entry {
 };
=20
 /**
=2D * struct global_params - Global parameters, mostly tunable via sysfs.
+ * struct amd_pstate_global_params - Global parameters, mostly tunable via=
 sysfs.
  * @cpb_boost:		Whether or not to use boost CPU P-states.
  * @cpb_supported:	Whether or not CPU boost P-states are available
  *			based on the MSR_K7_HWCR bit[25] state
  */
=2Dstruct global_params {
+struct amd_pstate_global_params {
 	bool cpb_boost;
 	bool cpb_supported;
 };
=20
=2Dextern struct global_params global;
+extern struct amd_pstate_global_params amd_pstate_global_params;
=20
 #endif /* _LINUX_AMD_PSTATE_H */
```

> > =20
> >  /*
> >   * AMD Energy Preference Performance (EPP)
> > @@ -669,43 +670,21 @@ static int amd_get_lowest_nonlinear_freq(struct a=
md_cpudata *cpudata)
> >  	return lowest_nonlinear_freq * 1000;
> >  }
> > =20
> > -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int sta=
te)
> > +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
> >  {
> > -	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	u64 boost_val;
> >  	int ret;
> > =20
> > -	if (!cpudata->boost_supported) {
> > -		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (state)
> > -		policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > -	else
> > -		policy->cpuinfo.max_freq =3D cpudata->nominal_freq;
> > -
> > -	policy->max =3D policy->cpuinfo.max_freq;
> > -
> > -	ret =3D freq_qos_update_request(&cpudata->req[1],
> > -				      policy->cpuinfo.max_freq);
> > -	if (ret < 0)
> > +	ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> > +	if (ret) {
> > +		pr_err_once("failed to read initial CPU boost state!\n");
> >  		return ret;
> > +	}
> > =20
> > -	return 0;
> > -}
> > -
> > -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> > -{
> > -	u32 highest_perf, nominal_perf;
> > -
> > -	highest_perf =3D READ_ONCE(cpudata->highest_perf);
> > -	nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > -
> > -	if (highest_perf <=3D nominal_perf)
> > -		return;
> > +	global.cpb_supported =3D !((boost_val >> 25) & 0x1);
> > +	global.cpb_boost =3D global.cpb_supported;
> > =20
> > -	cpudata->boost_supported =3D true;
> > -	current_pstate_driver->boost_enabled =3D true;
> > +	return ret;
> >  }
> > =20
> >  static void amd_perf_ctl_reset(unsigned int cpu)
> > @@ -848,6 +827,9 @@ static int amd_pstate_cpu_init(struct cpufreq_polic=
y *policy)
> >  	if (ret)
> >  		goto free_cpudata1;
> > =20
> > +	/* initialize cpu cores boot state */
> > +	amd_pstate_boost_init(cpudata);
> > +
> >  	min_freq =3D amd_get_min_freq(cpudata);
> >  	max_freq =3D amd_get_max_freq(cpudata);
> >  	nominal_freq =3D amd_get_nominal_freq(cpudata);
> > @@ -899,7 +881,6 @@ static int amd_pstate_cpu_init(struct cpufreq_polic=
y *policy)
> > =20
> >  	policy->driver_data =3D cpudata;
> > =20
> > -	amd_pstate_boost_init(cpudata);
> >  	if (!current_pstate_driver->adjust_perf)
> >  		current_pstate_driver->adjust_perf =3D amd_pstate_adjust_perf;
> > =20
> > @@ -1310,6 +1291,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq=
_policy *policy)
> >  	if (ret)
> >  		goto free_cpudata1;
> > =20
> > +	/* initialize cpu cores boot state */
> > +	amd_pstate_boost_init(cpudata);
> > +
> >  	min_freq =3D amd_get_min_freq(cpudata);
> >  	max_freq =3D amd_get_max_freq(cpudata);
> >  	nominal_freq =3D amd_get_nominal_freq(cpudata);
> > @@ -1360,7 +1344,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq=
_policy *policy)
> >  			return ret;
> >  		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> >  	}
> > -	amd_pstate_boost_init(cpudata);
> > =20
> >  	return 0;
> > =20
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index d21838835abd..465e9295a60c 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -124,4 +124,18 @@ static const char * const amd_pstate_mode_string[]=
 =3D {
> >  	[AMD_PSTATE_GUIDED]      =3D "guided",
> >  	NULL,
> >  };
> > +
> > +/**
> > + * struct global_params - Global parameters, mostly tunable via sysfs.
> > + * @cpb_boost:		Whether or not to use boost CPU P-states.
> > + * @cpb_supported:	Whether or not CPU boost P-states are available
> > + *			based on the MSR_K7_HWCR bit[25] state
> > + */
> > +struct global_params {
> > +	bool cpb_boost;
> > +	bool cpb_supported;
> > +};
> > +
> > +extern struct global_params global;
> > +
> >  #endif /* _LINUX_AMD_PSTATE_H */
> >=20
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart3443796.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXDnX8ACgkQil/iNcg8
M0uFkw//WZKn4+Bmhi+BM9ezpqdhGEuMwd6DwtMnhk1hz+v56koPilY2ONMxP0oT
0mlMbIrXwprB1BjrsbMMjqqIvYcpDk2zjL7i+cXluZsKs9T/Aum/N4xCVHcP+Yzn
waHDs16TKSRIPBa1qouFOFj+IWs2NEFlHf8UBvfzL/wvpDoLeRowa/QYjAjMTP6n
9sIXyoorluf6UJkbrWsXNmVjM4/R0Lhx0l1wRkX0Ug0SQSzNnpNGv++LsNW7PFrP
q9HMDd025o4PkEBpGuR5a6QEd9fw6bA/UDxXJuiJno8sddMDqKtMZPB/OY4wmHnQ
PHiz2lQ6OPWNBKd/waHrFtlIE2YV2ln64hNJCLA1GW6WB1i4wQzX538Eyw25wv7m
iJ5otMjXlJNbWhBB7FH3bkUt093l+a2bD6vYp0ziu9qwCPbaf8+bPxquZJdj2VIB
u/urtk5RbbVpmsfXv/mBTY8yucxiYe/nPEJyzURctMY08BiZnKlDfRQ2Af2gLrVR
d95XKML6Pskj8eyWyzN6+nhq6F6N9QYoy9qwlLLxmud8OjGY6keGx+cdlMqFiRmq
kLb/gPdckSpvFoyUyNoNfaB7LSrA0loYCVY6AN+XP+E5ItQCTqtL3FY4SNYr2tEL
X/c6oEd2/Tl9HhFpakckxuKCOJEWe258Ha+5ZcPcdbFMa8Jz0HU=
=hQGY
-----END PGP SIGNATURE-----

--nextPart3443796.aeNJFYEL58--




