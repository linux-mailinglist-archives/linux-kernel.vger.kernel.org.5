Return-Path: <linux-kernel+bounces-91028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0588708A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C09283A82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633F61670;
	Mon,  4 Mar 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rL9oDXXu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA384CE1F;
	Mon,  4 Mar 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574663; cv=none; b=bQ1Szp/C30zL0a1P35C7fnqcJJl+pBVRHZ4Vyhhm97VFhC9c7j8CWqbeqDgJKFfpeUg6fUq4iQ/zaprYf++CSev4DWQu189GLu41SZTyFG2Zu+ezRNt4CMDKkY/UxdvY1HVdIdOmSYIDs+BGh0ppRwaCc1aoelo+DXsYF08hYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574663; c=relaxed/simple;
	bh=IEfyQHB5drkN2Pf7mBgjnQOQbwiZ4e8OASVcOBlHP30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFRc9Z2ixspvWupTrwiHdgoTcnY4oSfhfj7j6LyiV1qnVZia0dk+0Wn6KImVwW5h3NJCR5DD7Pyd3S9EYIZKOe/JOPwQtf1OoZurRXsZhw/IIHqF0a8TuxkLeWmHKHyxvicYyzse2YWJj8SWsW+WvVk3sEAjp8VMiTfC3hQL2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rL9oDXXu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709574660;
	bh=IEfyQHB5drkN2Pf7mBgjnQOQbwiZ4e8OASVcOBlHP30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rL9oDXXufoqtetIG69lDf0xPo6EDtEwbrF3VPmFBgWJPwD6IFWzMAiXsB1O+kBmn5
	 YY0z7KFES05ymi+VLZ9EuzAor2Gpk+2yaAdDbVXi6bfztSDclaTu2AM3N09ABXBB7M
	 /Pp3SZyM+2ZQjvEB4CgpCJE7y3rw8w3eeMRziTW2Lv2ypcNoMuaefcVxIibRp1aFBG
	 mc652suxkNAPnuHoJWgnscGAewmZiJ11UZ+XhmrN7wIRvgGtNU71v8NIrarStrlKWq
	 s5BRKi7aPwGozH+w209+kJMywi2HjJVRTIHNOJLA3klfag2bUTuX9BG8dAhjd5QPsf
	 m+57xFB/icYfA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D76637813CB;
	Mon,  4 Mar 2024 17:51:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9E05D1060B14; Mon,  4 Mar 2024 18:50:59 +0100 (CET)
Date: Mon, 4 Mar 2024 18:50:59 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP
 and fan
Message-ID: <j3krazypdc7gsvnp4kcocaftxsbjrfhj6nr2kf2cieo4bjxbv7@bqdfbirk5tei>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ak4cnebufzoozkz"
Content-Disposition: inline
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>


--3ak4cnebufzoozkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 11:26:31PM +0400, Alexey Charkov wrote:
> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> active cooling on Radxa Rock 5B via the provided PWM fan.
>=20
> Some RK3588 boards use separate regulators to supply CPUs and their
> respective memory interfaces, so this is handled by coupling those
> regulators in affected boards' device trees to ensure that their
> voltage is adjusted in step.
>=20
> In this revision of the series I chose to enable TSADC for all boards
> at .dtsi level, because:
>  - The defaults already in .dtsi should work for all users, given that
>    the CRU based resets don't need any out-of-chip components, and
>    the CRU vs. PMIC reset is pretty much the only thing a board might
>    have to configure / override there
>  - The boards that have TSADC_SHUT signal wired to the PMIC reset line
>    can still choose to override the reset logic in their .dts. Or stay
>    with CRU based resets, as downstream kernels do anyway
>  - The on-by-default approach helps ensure thermal protections are in
>    place (emergency reset and throttling) for any board even with a
>    rudimentary .dts, and thus lets us introduce CPU DVFS with better
>    peace of mind
>=20
> Fan control on Rock 5B has been split into two intervals: let it spin
> at the minimum cooling state between 55C and 65C, and then accelerate
> if the system crosses the 65C mark - thanks to Dragan for suggesting.
> This lets some cooling setups with beefier heatsinks and/or larger
> fan fins to stay in the quietest non-zero fan state while still
> gaining potential benefits from the airflow it generates, and
> possibly avoiding noisy speeds altogether for some workloads.
>=20
> OPPs help actually scale CPU frequencies up and down for both cooling
> and performance - tested on Rock 5B under varied loads. I've split
> the patch into two parts: the first containing those OPPs that seem
> to be no-regret with general consensus during v1 review [2], while
> the second contains OPPs that cause frequency reductions without
> accompanying decrease in CPU voltage. There seems to be a slight
> performance gain in some workload scenarios when using these, but
> previous discussion was inconclusive as to whether they should be
> included or not. Having them as separate patches enables easier
> comparison and partial reversion if people want to test it under
> their workloads, and also enables the first 'no-regret' part to be
> merged to -next while the jury is still out on the second one.
>=20
> [1] https://lore.kernel.org/linux-rockchip/1824717.EqSB1tO5pr@bagend/T/#m=
a2ab949da2235a8e759eab22155fb2bc397d8aea
> [2] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjph=
Gkyq=3DwDnctnEhdoSdPPpw@mail.gmail.com/T/#m49d2b94e773f5b532a0bb5d3d7664799=
ff28cc2c
>=20
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Changes in v3:
> - Added regulator coupling for EVB1 and QuartzPro64
> - Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks Che=
nYu)
> - Added comments regarding two passive cooling trips in each zone (thanks=
 Dragan)
> - Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
> - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's be=
en quite some
>   churn there since the version he acknowledged
> - Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-c6=
222c4c78df@gmail.com
>=20
> Changes in v2:
> - Dropped the rfkill patch which Heiko has already applied
> - Set higher 'polling-delay-passive' (100 instead of 20)
> - Name all cooling maps starting from map0 in each respective zone
> - Drop 'contribution' properties from passive cooling maps
> - Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-58=
79275db36f@gmail.com
>=20
> ---
> Alexey Charkov (5):
>       arm64: dts: rockchip: enable built-in thermal monitoring on RK3588
>       arm64: dts: rockchip: enable automatic active cooling on Rock 5B
>       arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
>       arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
>       arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs
>=20
>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385 +++++++++++++++=
+++++-
>  4 files changed, 437 insertions(+), 2 deletions(-)

I'm too busy to have a detailed review of this series right now, but
I pushed it to our CI and it results in a board reset at boot time:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jobs=
/300950

I also pushed just the first three patches (i.e. without OPP /
cpufreq) and that boots fine:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/jobs=
/300953

Note, that OPP / cpufreq works on the same boards in the CI when
using the ugly-and-not-for-upstream cpufreq driver:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/comm=
it/9c90c5032743a0419bf3fd2f914a24fd53101acd

My best guess right now is, that this is related to the generic
driver obviously not updating the GRF read margin registers.

Greetings,

-- Sebastian

--3ak4cnebufzoozkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXmCfYACgkQ2O7X88g7
+pqRxw//dmh+UPfuN299VZFiTBD4G31/BgIFF7igZ+Czx3TwyuYbjkYyTJW7GgoC
9Z4oPhc+nxIeVcaQmyx1XBwTiBiwKhQG1GDFKNYkb7cZ5WPv/pcKRAWsSuT4sf49
o7C2z8AHix35qa/W9hM0/jlpBl2In9ghQEdZUNYtGNt85lfddOcTDiAEhHa0Zl7E
QN59+YL+EVzQLzVakKlOoJibAoTOJ6dmJwC+OA4MiZ4aZ3M6IVdaSE9ERlWYVW8v
Dv2gic754YORD9QeWYgRSY+PId2bBwl20psXJbbUGAJOhaWPWJfyAzpFIJncONEM
es+WpwnlbIiMtZcHYNfU006gqifvkDyOIAjAz+vrOyJa9EL1jUhkbnQ0YGINTR1z
drgmMWVLKhYuFXvA0Uz+65wvkVynct+zRUzP+zEooSrIzu7xjI6JmF+HDEj1U7z4
XwWfGR4UViqak+1wqFNhiH0u6nnJmel56WKVFWGd5WolFRHJAaCi04sMrZfhARiM
Q31gdx8C5c6ZVscST2mn5xNCorshDxuyGR5rQ68HkSZTL1A+x6T0W8SMpz9ugJi+
j1kpcgvN3AGiZEmxqY6tPMDGMYO6HCqzl2IOvPEFApDGtaxVYl112BxJ1EdfCpIU
V4HbrC8Esp1TUspWiR5s3oubSYCoUyPxsVfUPTBdjYynsPNozp0=
=RoA+
-----END PGP SIGNATURE-----

--3ak4cnebufzoozkz--

