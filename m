Return-Path: <linux-kernel+bounces-56287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02F84C853
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E421C24320
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E624B5B;
	Wed,  7 Feb 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="KyL7oM7i"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D924B2A;
	Wed,  7 Feb 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300678; cv=none; b=ldXa7Fp0ZdIpjHVqdQi/J4xK6pWdqs7KEMt+R8Q8TAEQvQfYY5aL7TS4dy0/znlTVXPcsqEJtP0ur8uszkV/NfPwR9vBMaQZ4UZtFQQMnDxL7RH5yQXdmt/xo9pQwoVha7DeY6R4mrzs/BnlxPafvUaanx4Sp47YoFuxaqAW7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300678; c=relaxed/simple;
	bh=fy0MuGEeBqq0yRk9q1POmHQUTTNM7NnZ5ogEzRYEj/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsWIaYsBulZX1olSOvNYrC4Yoqci3oSRWcJFkFLEMlPaAbQHVMEqaAod0M5BIWHhQ02O4kvJhLfRFjQYHCaqf8DKxJyAcX8XcpT29j8nFqSS1I7gUO/hMCrzj7fU4MNcPdJK+jeGQnUfBibCIsfO92KheOH6vET266IzOZx9q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=KyL7oM7i; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id D1D67635B069;
	Wed,  7 Feb 2024 11:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1707300666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qk89De6FrqTdMkAJYqG4hQmTMMefgxmhKdx6js2QarM=;
	b=KyL7oM7iafK7DSybwDFdAZAMiJ3ehUyp+BRzcCbLYde4BRADgMdlGp3/4m3KvueGghizKu
	T0CBG9kR9OpEUCFUfp22+dQ1cirlFfG0ekAzHWklbRNhWJLx1n4TrPnGeXmeCokEA72M6M
	CNT5dMy4P44VGic0SsjSOmoIvXjKcFo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com, Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost callback for
 passive mode
Date: Wed, 07 Feb 2024 11:10:52 +0100
Message-ID: <2887380.mvXUDI8C0e@natalenko.name>
In-Reply-To:
 <fb14f6e7748f1b872f68eb2549d4e6033f0facbc.1707297581.git.perry.yuan@amd.com>
References:
 <cover.1707297581.git.perry.yuan@amd.com>
 <fb14f6e7748f1b872f68eb2549d4e6033f0facbc.1707297581.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12544814.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12544814.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 07 Feb 2024 11:10:52 +0100
Message-ID: <2887380.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0

Hello.

On st=C5=99eda 7. =C3=BAnora 2024 10:21:57 CET Perry Yuan wrote:
> With new freqency boost interface supported, legacy boost control
> doesn't make sense any more which only support passive mode.
> so it can remove the legacy set_boost interface from amd-pstate driver
> in case of there is conflict with new boost control logic.
>=20
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  include/linux/amd-pstate.h   | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 35791efc6e88..1dd523db3871 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1675,7 +1675,6 @@ static struct cpufreq_driver amd_pstate_driver =3D {
>  	.exit		=3D amd_pstate_cpu_exit,
>  	.suspend	=3D amd_pstate_cpu_suspend,
>  	.resume		=3D amd_pstate_cpu_resume,
> -	.set_boost	=3D amd_pstate_set_boost,
>  	.update_limits	=3D amd_pstate_update_limits,
>  	.name		=3D "amd-pstate",
>  	.attr		=3D amd_pstate_attr,
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 465e9295a60c..ab7ca26974da 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -93,7 +93,6 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf prev;
> =20
>  	u64	freq;
> -	bool	boost_supported;

As a result of this removal the kernel-doc for this struct should be amende=
d too because even after this patch is applied the `boost_supported` field =
remains documented.

>  	bool	hw_prefcore;
> =20
>  	/* EPP feature related attributes*/
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12544814.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXDVywACgkQil/iNcg8
M0usJA/8DvFsv4pQV0fQtw4hJh2XYcd5dI7x9P7ACTWNem6eWk5h8r8E50qAAj/i
mhw1eZ7XKEALojhZPehAs4FBkFSZDKwfj7mO4crwDvBtX4sN+zKQI92YAmxY08fu
jWzGSL607lbFJosXKQ5AUwj4oFLbntWt3I8sYgY9/7LqiaUbyGf376QIDr2+1aNQ
i3kcCrALsnN0mFmCXmyc7mJLMDRy41v859TBNVpjprq7GUxdhmp42uLl8n49B3uN
3P4McJLQ1UGc+mOB64MGMypZcBpPGQdGOF+a+0ijNOuUnLKvGm8vxc4vmZFn/lwF
HVqhnDdFG5e0i4recu3ExN3n43Ji28pcfFYhfBNlu+ro8b4fypF1ija184fl5w44
POv5QVTLELrLBGE+lzvigTZip/afLojug6VSGVq+PwSAc6UzB0akJTRXO4p5vNyl
F1l8wcEhKN0flzJkp0q18hIKDLKr9n+Ja3pr+EDkZPQ3W8Fu3dXBHOg4IDWvyvEC
C5V5UyU1KDF7S3bEIDj1hgDuHG2rGtCNp5UWhCeIxR5GnI4KXgEU1flOu3Yp3VN8
f4rTaKJHgwZCC1vmK3QejH762nTxqLuAmQXe728nEjEO9Kbs0pPuY9FUQhLRjf6z
YRDiGifZxWVomkZbz1ueePf5U3zwH1QtnyZbgVUeTWcyftSGC0w=
=B1Jv
-----END PGP SIGNATURE-----

--nextPart12544814.O9o76ZdvQC--




