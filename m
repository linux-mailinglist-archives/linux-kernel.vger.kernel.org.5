Return-Path: <linux-kernel+bounces-81485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF961867688
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE441C29701
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7518C129A92;
	Mon, 26 Feb 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD9j5qlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB11292E5;
	Mon, 26 Feb 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954077; cv=none; b=Ums4zh49qgnP0saXg2H02ICJ4oTOBSlSwk/S7vsqFcGXe6s+dQO8qBm8tKQ0oyq/nUmzSu/yca9vovy8gnEkONOoWWZpHsdruSYLVLVmMJNyiRStxMStY7szByxQsxcgQuMADXILCFeUdbMBVYSBQOLn4BTD5wA4TGozFe21nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954077; c=relaxed/simple;
	bh=qSNmD04NX0uxX03mA5Bnx2zGeQcb1TM+eXxiBSZHmiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QskA9lGN5cJPQPEiy0ji4MlOjBkT/tsv6PNRSc/GA/nJFvyNRP13dSxBa1ykN5h8HDQU0Ga8noUg+mf7gxE9wVRbALYPOr+1GXPLVPcisfC9ZhHi1l2kAzysvAyzfowI2y8tbGpeahptJew3J750V94JfwGtDE9aMdftm+s04Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD9j5qlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB2C433C7;
	Mon, 26 Feb 2024 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954077;
	bh=qSNmD04NX0uxX03mA5Bnx2zGeQcb1TM+eXxiBSZHmiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VD9j5qlHNIDBi9UsdiwUzteRraIAplIWfHg9+v3XKWUNmb56Lyuuq9bDk6Ylu5MrI
	 CFLvdAdW+KLKvio5em12U6ZmiOrUMPLGtdHlLE6n7ZwnOpurlie9zQxS4swg4a0Xt2
	 DRTvxOeaJglCZ49DCfushR1DUih90TaRYfHsGqZI5YkRZQrPcuUL9i3vydFL66VDYY
	 ZbA551JC+7j7UlEQYmLc2QZ1blpe8QQkpNpeEr1Z5zA2iJ1rt3GDB7+h/5SwM12NPc
	 meRuCy6O+wxgZJu9VSs6+PKj4mRzMpPQRHNesEmC/QZ8y/RQdU9aSFTGKSndyox9jL
	 Jv519fg/PqPDw==
Date: Mon, 26 Feb 2024 13:27:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Nishanth <nm@ti.com>,
	Vignesh <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Message-ID: <69f3dcd7-b79f-4b4f-aecb-dc559d74e6e4@sirena.org.uk>
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KteanNWhmQRgXK0w"
Content-Disposition: inline
In-Reply-To: <20240226121803.5a7r5wkpbbowcxgx@dhruva>
X-Cookie: Walk softly and carry a BFG-9000.


--KteanNWhmQRgXK0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 05:48:03PM +0530, Dhruva Gole wrote:
> On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:

> > [1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
> >       commit: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc
> > [2/4] spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
> >       commit: 959043afe53ae80633e810416cee6076da6e91c6
> > [3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
> >       commit: 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a
> > [4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks
> >       commit: 078d62de433b4f4556bb676e5dd670f0d4103376

> It seems like between 6.8.0-rc5-next-20240220 and
> 6.8.0-rc5-next-20240222 some of TI K3 platform boot have been broken.

Is this with some specific kernel configuration?

> It particularly seemed related to these patches because we can see
> cqspi_probe in the call trace and also cqspi_suspend toward the top.

It would be useful to bisect which patch, there's only 4 of them...

> See logs for kernel crash in [0] and working in [1]

> [0] https://gist.github.com/DhruvaG2000/ed997452b41d6e5301598225fc579800
> [1] https://gist.github.com/DhruvaG2000/d4e73111aeafaca555ba2d5208deb6dd

The relevant section from the failing log is:

[    1.516342] printk: legacy bootconsole [ns16550a0] disabled
[    1.533247] Unable to handle kernel paging request at virtual address 12800000340001b4

..

[    1.709414] Call trace:
[    1.711852]  __mutex_lock.constprop.0+0x84/0x540
[    1.716460]  __mutex_lock_slowpath+0x14/0x20
[    1.720719]  mutex_lock+0x48/0x54
[    1.724026]  spi_controller_suspend+0x30/0x7c
[    1.728377]  cqspi_suspend+0x1c/0x6c
[    1.731944]  pm_generic_runtime_suspend+0x2c/0x44
[    1.736640]  genpd_runtime_suspend+0xa8/0x254

(it's generally helpful to provide the most relevant section directly.)

The issue here appears to be that we've registered for runtime suspend
prior to registering the controller...

--KteanNWhmQRgXK0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXckdcACgkQJNaLcl1U
h9C8qwf/aWk2Oc0jnjPM7OPFSUZBzjLTzK5mSIvNQfv7eHlBcSvSd2n25BM1+ix8
9GK9tBr3OZa6NRQYefwa5GUUiw9p0zmnHX5NKnXgJ+4KJxLJk+LW6vCeVXtMDu9D
s+7hdPwfp5Xxd8PM//OcmAyeMNZ5vW+eBJ9ZDuXNe/haCrqs9mFQLT0bfiqd7buO
dZmvMxLEdReetgzx3jzsTGa4UcBWDGHXi4ZaoXiIjCxI887XeKzFMOPp/z5VyUoM
ALntugF/rh0rbOvqK8d3TyOAh3Kj/u8akWnuYEtQrpziY4SiPkJ5tL5pke/Ye4yP
zurmIVrJvZheglxO/lmxZ+fWw8BIVg==
=7Gqg
-----END PGP SIGNATURE-----

--KteanNWhmQRgXK0w--

