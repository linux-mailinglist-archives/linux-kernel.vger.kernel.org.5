Return-Path: <linux-kernel+bounces-33730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB246836DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F71C27A09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08485B5A2;
	Mon, 22 Jan 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+t36IAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48C3D972;
	Mon, 22 Jan 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942536; cv=none; b=NmMceTqclG3693uPnITrhSMFdb966uKkBdA6rWWqUkjtyDQcNoz0S6udSTCzr26lwszQ+8gocOa1r169DBdtTKm5D8SmT03X1ltk7/8voN849aSSbjEnCgDrJrJAYh15mUQOvBCRM7HKF96VHqEtA79zL/Q3LjxHWMTm96yFb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942536; c=relaxed/simple;
	bh=8T0ucgjfyXJd5NvhWFta/df8Q6IEWrQ3KgZIzNuukxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCiKedPYiEiDqZmBdcqxDqEVVdepvWSP1SUAfZEj1OkyRt/ARj4mTti60jz8QN9ez4p37Zm780uiA+EsuCnxHviIdbTTyVtK+UCV/7R4mmzymGe/RpKQheU2kPqeisa+WESlska3Pub6gtyNf2Gb8LxLLN3QsERifgEKnjQKTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+t36IAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2ECC433C7;
	Mon, 22 Jan 2024 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942535;
	bh=8T0ucgjfyXJd5NvhWFta/df8Q6IEWrQ3KgZIzNuukxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+t36IAEXRN0EzeicIjVOqkYYa8UkpBLp6d4LHyP7PIL/KyxtPlv6rg0f9eyVU3UY
	 7emrR1fDVXXhERnUfVNKiKo61V6I3tH7tIxbfssm8b/6zuhuQ3xifa2STUgrV1oXX0
	 zaMq78qpDVbS5XpQTWhPzojQal6XA4yBS7SqchbC7vVzFGfkaym0gYc+RzBI806Hex
	 VdW7NBmQQSJJgjkoa1SP73Q/Yf/4+I2rpRxG0TQWtJ43tYG6vUuF54bTHwqxpHRupC
	 /n10Cd+pskxQZnA/HwIxtP4KSe+4q+OfXYNYUf/RBH4dsLRbo4OecYuL9SZXLP1Vi1
	 qKo+cTrdKPCcA==
Date: Mon, 22 Jan 2024 16:55:28 +0000
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	William Qiu <william.qiu@starfivetech.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?utf-8?q?Emil_Renner_Berthing_=3Ckernel=40esmil=2Edk=3E=2C_Rob_Herring_?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?=3Crobh+dt=40kernel=2Eorg=3E=2C_Thierry_Reding_=3Cthierry=2Eredin?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?g=40gmail=2Ecom=3E=2C_Philipp_Zabel_=3Cp=2Ezabel=40pengutronix=2E?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?de=3E=2C_Krzysztof_Kozlowski_=3Ckrzysztof=2Ekozlowski+dt=40linaro?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?=2Eorg=3E=2C_Conor_Dooley_=3Cconor+dt=40kernel=2Eorg=3E=2C_Uwe_Kl?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?eine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E=2C_Hal?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?_Feng_=3Chal=2Efeng=40starfivetech=2Ecom=3E=2C_Paul_Walmsley_=3Cp?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?aul=2Ewalmsley=40sifive=2Ecom=3E=2C_Palmer_Dabbelt_=3Cpalmer=40da?=@spud.smtp.subspace.kernel.org,
	=?utf-8?q?bbelt=2Ecom=3E=2C_Albert_Ou_=3Caou=40eecs=2Eberkeley=2Eedu=3E?=@spud.smtp.subspace.kernel.org
Subject: Re: (subset) [PATCH v10 0/4] StarFive's Pulse Width Modulation
 driver support
Message-ID: <20240122-palm-maximize-75522ae88b8a@spud>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20240122-twitter-scroll-75416c5bbd27@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S+zxDKzeEYPgrYkE"
Content-Disposition: inline
In-Reply-To: <20240122-twitter-scroll-75416c5bbd27@spud>


--S+zxDKzeEYPgrYkE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:50:25PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> On Fri, 22 Dec 2023 17:45:44 +0800, William Qiu wrote:
> > This patchset adds initial rudimentary support for the StarFive
> > Pulse Width Modulation controller driver. And this driver will
> > be used in StarFive's VisionFive 2 board.The first patch add
> > Documentations for the device and Patch 2 adds device probe for
> > the module.
> >=20
> > Changes v9->v10:
> > - Rebased to v6.7rc6.
> > - Dropped unuseful dependency.
> > - Added error handling.
> >=20
> > [...]
>=20
> Applied to riscv-dt-for-next, thanks!
>=20
> [1/4] dt-bindings: pwm: Add bindings for OpenCores PWM Controller
>       https://git.kernel.org/conor/c/2529085831b0
> [3/4] riscv: dts: starfive: jh7100: Add PWM node and pins configuration
>       https://git.kernel.org/conor/c/26c3112c10f8
> [4/4] riscv: dts: starfive: jh7110: Add PWM node and pins configuration
>       https://git.kernel.org/conor/c/92df97487208

Something went super wrong here with the CC list that b4 generated for
me, there was a bunch of utf8 encoding crap in the middle of it. Perhaps
I should update the version of b4 that I have been running...

--S+zxDKzeEYPgrYkE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6eAAAKCRB4tDGHoIJi
0vanAP9sqv+lnua3IrSO2oAtWeacHEw1X3F2Zdr6Ewh5/RTWVgEAsNs/8NwnyYis
DM3sjdeahWoQWza4LobW7lTD7M2vyAk=
=TxP9
-----END PGP SIGNATURE-----

--S+zxDKzeEYPgrYkE--

