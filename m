Return-Path: <linux-kernel+bounces-131731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6908898B31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D011283149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07754129A7E;
	Thu,  4 Apr 2024 15:33:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9C84FDF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244837; cv=none; b=pTJlGIcOX9k8o/nYX+qcQ7KyoocUtvqwRjSReIrk6r9c9JfhY+EW6CwhqdAjxoNHQZt5pMRwqsfJzhUnqufngEc7AaIaLHK5q0/GYdr0+DOlFCWWSbCsKYsG7mums90dKqyC4L8PoA3uHLW8a74vf7jcdrem3d8Lthj3y8ubv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244837; c=relaxed/simple;
	bh=kC8z1LjQKKDzkZfrOH3QNMmDXYHkdOhUj44LuopUqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLVPYJd6ALWbWg1oT1+fapFL2aLNgeU4bfKVkxzUpHbOP7VAOx45liiQf6i4gf5TtjdUx0TnaAhFuMyZGOUUnQmHH5SBHp0IojGULRAJrEn+d+cHljBTmmCR+9MLLxDrRXQfwpwIr73CpaWYq7M+pmZ68w6G/zpD1OWLp1w6CdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsP64-0001tj-Ny; Thu, 04 Apr 2024 17:33:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsP61-00AP0e-EL; Thu, 04 Apr 2024 17:33:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsP61-00F9uU-18;
	Thu, 04 Apr 2024 17:33:45 +0200
Date: Thu, 4 Apr 2024 17:33:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de, linux-clk@vger.kernel.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] pwm: Add more locking
Message-ID: <adqtn6iljcguv3m3ovhltusbbf4mljzlwg73yklaudvjjtazxv@vyf5fvuzic6x>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
 <CGME20240404120932eucas1p1b3c1e07bf6f41f6330725148b0268b13@eucas1p1.samsung.com>
 <5a49cadd-21b7-4384-9e7d-9105ccc288b3@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4ybeyaskyjbjlzd"
Content-Disposition: inline
In-Reply-To: <5a49cadd-21b7-4384-9e7d-9105ccc288b3@samsung.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--q4ybeyaskyjbjlzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

[Cc +=3D linux-clk@vger.kernel.org, Alexander Stein, linux-arm-kernel@lists=
=2Einfradead.org]

On Thu, Apr 04, 2024 at 02:09:32PM +0200, Marek Szyprowski wrote:
> On 17.03.2024 11:40, Uwe Kleine-K=F6nig wrote:
> > This ensures that a pwm_chip that has no corresponding driver isn't used
> > and that a driver doesn't go away while a callback is still running.
> >
> > In the presence of device links this isn't necessary yet (so this is no
> > fix) but for pwm character device support this is needed.
> >
> > To not serialize all pwm_apply_state() calls, this introduces a per chip
> > lock. An additional complication is that for atomic chips a mutex cannot
> > be used (as pwm_apply_atomic() must not sleem) and a spinlock cannot be
> > held while calling an operation for a sleeping chip. So depending on the
> > chip being atomic or not a spinlock or a mutex is used.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
>=20
> This patch landed some time ago in linux-next as commit a740f7879609=20
> ("pwm: Add more locking"). Recently I've finally found that $subject=20
> patch is responsible for the following lock dep splat observed for some=
=20
> time during day-to-day linux-next testing:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.9.0-rc1+ #14790 Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0 C
> ------------------------------------------------------
> kworker/u24:4/59 is trying to acquire lock:
> ffff00003c65b510 (&chip->nonatomic_lock){+.+.}-{3:3}, at:=20
> pwm_apply_might_sleep+0x90/0xd8
>=20
> but task is already holding lock:
> ffff80008310fa40 (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0x4c/0x=
a8
>=20
> which lock already depends on the new lock.
>=20
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #1 (prepare_lock){+.+.}-{3:3}:
>  =A0=A0=A0=A0=A0=A0 lock_acquire+0x68/0x84
>  =A0=A0=A0=A0=A0=A0 __mutex_lock+0xa0/0x840
>  =A0=A0=A0=A0=A0=A0 mutex_lock_nested+0x24/0x30
>  =A0=A0=A0=A0=A0=A0 clk_prepare_lock+0x4c/0xa8
>  =A0=A0=A0=A0=A0=A0 clk_round_rate+0x38/0xd0
>  =A0=A0=A0=A0=A0=A0 meson_pwm_apply+0x128/0x220 [pwm_meson]
>  =A0=A0=A0=A0=A0=A0 __pwm_apply+0x64/0x1f8
>  =A0=A0=A0=A0=A0=A0 pwm_apply_might_sleep+0x58/0xd8
>  =A0=A0=A0=A0=A0=A0 pwm_regulator_set_voltage+0xbc/0x12c
>  =A0=A0=A0=A0=A0=A0 _regulator_do_set_voltage+0x110/0x688
>  =A0=A0=A0=A0=A0=A0 regulator_set_voltage_rdev+0x64/0x25c
>  =A0=A0=A0=A0=A0=A0 regulator_do_balance_voltage+0x20c/0x47c
>  =A0=A0=A0=A0=A0=A0 regulator_balance_voltage+0x50/0x9c
>  =A0=A0=A0=A0=A0=A0 regulator_set_voltage_unlocked+0xa4/0x128
>  =A0=A0=A0=A0=A0=A0 regulator_set_voltage+0x50/0xec
>  =A0=A0=A0=A0=A0=A0 _opp_config_regulator_single+0x4c/0x130
>  =A0=A0=A0=A0=A0=A0 _set_opp+0xfc/0x544
>  =A0=A0=A0=A0=A0=A0 dev_pm_opp_set_rate+0x190/0x284
>  =A0=A0=A0=A0=A0=A0 set_target+0x34/0x40
>  =A0=A0=A0=A0=A0=A0 __cpufreq_driver_target+0x170/0x290
>  =A0=A0=A0=A0=A0=A0 cpufreq_online+0x814/0xa3c
>  =A0=A0=A0=A0=A0=A0 cpufreq_add_dev+0x80/0x98
>  =A0=A0=A0=A0=A0=A0 subsys_interface_register+0xfc/0x118
>  =A0=A0=A0=A0=A0=A0 cpufreq_register_driver+0x150/0x234
>  =A0=A0=A0=A0=A0=A0 dt_cpufreq_probe+0x150/0x480
>  =A0=A0=A0=A0=A0=A0 platform_probe+0x68/0xd8
>  =A0=A0=A0=A0=A0=A0 really_probe+0xbc/0x2a0
>  =A0=A0=A0=A0=A0=A0 __driver_probe_device+0x78/0x12c
>  =A0=A0=A0=A0=A0=A0 driver_probe_device+0xdc/0x164
>  =A0=A0=A0=A0=A0=A0 __device_attach_driver+0xb8/0x138
>  =A0=A0=A0=A0=A0=A0 bus_for_each_drv+0x84/0xe0
>  =A0=A0=A0=A0=A0=A0 __device_attach+0xa8/0x1b0
>  =A0=A0=A0=A0=A0=A0 device_initial_probe+0x14/0x20
>  =A0=A0=A0=A0=A0=A0 bus_probe_device+0xb0/0xb4
>  =A0=A0=A0=A0=A0=A0 deferred_probe_work_func+0x8c/0xc8
>  =A0=A0=A0=A0=A0=A0 process_one_work+0x220/0x634
>  =A0=A0=A0=A0=A0=A0 worker_thread+0x268/0x3a8
>  =A0=A0=A0=A0=A0=A0 kthread+0x124/0x128
>  =A0=A0=A0=A0=A0=A0 ret_from_fork+0x10/0x20

This is the meson pwm driver calling clk_set_rate() in the .apply()
callback.

> -> #0 (&chip->nonatomic_lock){+.+.}-{3:3}:
>  =A0=A0=A0=A0=A0=A0 __lock_acquire+0x1318/0x20c4
>  =A0=A0=A0=A0=A0=A0 lock_acquire.part.0+0xc8/0x20c
>  =A0=A0=A0=A0=A0=A0 lock_acquire+0x68/0x84
>  =A0=A0=A0=A0=A0=A0 __mutex_lock+0xa0/0x840
>  =A0=A0=A0=A0=A0=A0 mutex_lock_nested+0x24/0x30
>  =A0=A0=A0=A0=A0=A0 pwm_apply_might_sleep+0x90/0xd8
>  =A0=A0=A0=A0=A0=A0 clk_pwm_prepare+0x54/0x84
>  =A0=A0=A0=A0=A0=A0 clk_core_prepare+0xc8/0x2f8
>  =A0=A0=A0=A0=A0=A0 clk_prepare+0x28/0x44
>  =A0=A0=A0=A0=A0=A0 mmc_pwrseq_simple_pre_power_on+0x4c/0x8c
>  =A0=A0=A0=A0=A0=A0 mmc_pwrseq_pre_power_on+0x24/0x34
>  =A0=A0=A0=A0=A0=A0 mmc_power_up.part.0+0x20/0x16c
>  =A0=A0=A0=A0=A0=A0 mmc_start_host+0xa0/0xac
>  =A0=A0=A0=A0=A0=A0 mmc_add_host+0x84/0xf0
>  =A0=A0=A0=A0=A0=A0 meson_mmc_probe+0x318/0x3e8
>  =A0=A0=A0=A0=A0=A0 platform_probe+0x68/0xd8
>  =A0=A0=A0=A0=A0=A0 really_probe+0xbc/0x2a0
>  =A0=A0=A0=A0=A0=A0 __driver_probe_device+0x78/0x12c
>  =A0=A0=A0=A0=A0=A0 driver_probe_device+0xdc/0x164
>  =A0=A0=A0=A0=A0=A0 __device_attach_driver+0xb8/0x138
>  =A0=A0=A0=A0=A0=A0 bus_for_each_drv+0x84/0xe0
>  =A0=A0=A0=A0=A0=A0 __device_attach_async_helper+0xb0/0xd4
>  =A0=A0=A0=A0=A0=A0 async_run_entry_fn+0x34/0xe0
>  =A0=A0=A0=A0=A0=A0 process_one_work+0x220/0x634
>  =A0=A0=A0=A0=A0=A0 worker_thread+0x268/0x3a8
>  =A0=A0=A0=A0=A0=A0 kthread+0x124/0x128
>  =A0=A0=A0=A0=A0=A0 ret_from_fork+0x10/0x20

This is the clk_pwm driver that calls pwm_enable() in its .prepare()
callback. Looking at
arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts the
pwm-clock uses &pwm_ef which is a meson pwm.

This alone only works because clk_prepare_lock() is reentrant for a
single thread (see commit 533ddeb1e86f ("clk: allow reentrant calls into
the clk framework")). (Is this really safe? What does the prepare_lock
actually protect?)

And because of this the lockdep splat is a false positive (as is every
ABBA splat involving the clk prepare_lock).

I think to properly address this, the global prepare_lock should be
replaced by a per-clk lock. This would at least make

	https://lore.kernel.org/all/20231017135436.1241650-1-alexander.stein@ew.tq=
-group.com/

(which I think is racy and needs a call to clk_rate_exclusive_get())
unnecessary.

Having said that, I don't know how to prevent that lockdep splat with
neither dropping the blamed commit (which is needed for race free
operation in the pwm framework) nor spending hours to rework the locking
of the clk framework.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q4ybeyaskyjbjlzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYOyFgACgkQj4D7WH0S
/k4RYwgArVz3a8+C0BZ9M8Hrv++No3FtYEZYgX2Sc0PU4bjrgat48gn6bEaFoDWj
zVXascQSvWsGhUsnfp41Pk8CtAUDuicbWnYlhyP2fJBRhOjus/XNUH/C9CklMkbD
Dk797Phjk4Xr8/wkZf83UxyTcUYW1/WwAqDdPVaRZQAU1kp6pG4NFOQWkX7SJI75
BEy6nUA7+kRuWc1nKNdPi0e4ME4xo3kfpocLohSIzOTqlOMt6lbpZ3i6K976RXs0
o+gKLuS4q2buDoBo4jTDZhjIEUMcK0uxnk+DOzcyKfAZNROsV/rsmCiBSdMrbZiQ
OJj/DcYqIVdoy3Z1l1FfjI4UonbimA==
=aqSg
-----END PGP SIGNATURE-----

--q4ybeyaskyjbjlzd--

