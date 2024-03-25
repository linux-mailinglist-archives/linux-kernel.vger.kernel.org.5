Return-Path: <linux-kernel+bounces-117437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522F88AB67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46AB300B72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E06CDAF;
	Mon, 25 Mar 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BhsgGyDX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DE5490D;
	Mon, 25 Mar 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382796; cv=none; b=gxNdEajpZd3TUk7pTdNHc2Xk0foTbMnc5SeZ53XiJqlPIozX2gYHw2Rj5AanNiDF1cGHQDiiBcA4C4RW0NHqjt9kp2f04TVwI2oBqJuL4mHVzJTMqYnr9LAOyOFcdoHL2JfMiipGW9I37REJC8FgmFb5nWg5wtZPo64TsKekFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382796; c=relaxed/simple;
	bh=6R/YDODy0mvmEaE7xbmqBZ9G0H9VSOniImpYBdZb5us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWhB+vZWirEUrainqp6K8/ywTbQFtBDM3tZ8/oIBxBcD5VPdOPUe9xN+NkOuS5yXuRsut4RK3vN+n4nT9ns5lJwSeTe19+1xlF6uz6LnLYPqbEzbpiIedwobmHg73fxO4izIV84CbbQ0WKiqifWx21yZGF+H21kR4jzS+9jNeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BhsgGyDX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711382792;
	bh=6R/YDODy0mvmEaE7xbmqBZ9G0H9VSOniImpYBdZb5us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhsgGyDX6O6ycfg4PMeg1+RsPU7ckHPQRIpR9JBaqzCP/pmXEMBSgs13FxK5M3kNU
	 y6zJwVvFX6HaeTUS04E324dpHPhuWJL7QmCyTIKuyNUg2kRZo7Mo4pzWBa8ZQYvf5G
	 bGyzQgeDlRSgb/YAW0Y+vT2O0oElGuHIGUQrK9Zyuz0TMJi6s5jXV2og/9REZlS9gK
	 hWr43W7GD4m+KJ5ZyuKUaLNATFbrrjbW2cJJvOnj4TOJZXyhd//ConRtHHJGppqY8q
	 HylaBPtGx2wPyiKsHUFVGCXsmv5yOSLn5QXM0Hv1v3Yk6GSyi5QvZXK94L0wUNu3Qm
	 scxifwE4k6I4g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8176A37820BB;
	Mon, 25 Mar 2024 16:06:32 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 152DF106074E; Mon, 25 Mar 2024 17:06:32 +0100 (CET)
Date: Mon, 25 Mar 2024 17:06:32 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v1 4/4] arm64: dts: rockchip: rk3588-evb1: Enable GPU
Message-ID: <dskay7po64y7fewkf32yhfolxxwdubihdib54ytvg2senovum7@6v6qf3waija5>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
 <20240325153850.189128-5-sebastian.reichel@collabora.com>
 <20240325165308.483b01b3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6t2fecdpx4yxkblu"
Content-Disposition: inline
In-Reply-To: <20240325165308.483b01b3@collabora.com>


--6t2fecdpx4yxkblu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 04:53:08PM +0100, Boris Brezillon wrote:
> [...]
> > @@ -484,12 +490,15 @@ rk806_dvs3_null: dvs3-null-pins {
> > =20
> >  		regulators {
> >  			vdd_gpu_s0: dcdc-reg1 {
> > +				regulator-always-on;
>=20
> IIRC, this is only needed because of some bug in the power-domain
> driver (or elsewhere). Is there any other reason to flag those as
> always-on? I mean, it's working but probably not ideal from a PM
> standpoint, as that means the regulators will stay on even when the GPU
> is idle.

EVB1 needs it for the generic coupler infrastructure. The Linux
coupler code cannot handle non always-on regulators at the moment.
That's something, which could be improved, but I think for now we
can just make the regulator always-on for the EVB1. The EVB1 is not
running from a battery anyways.

Greetings

-- Sebastian

--6t2fecdpx4yxkblu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYBoQcACgkQ2O7X88g7
+pp+rQ/8CbVqn3AIkLQp1cGlyaXbLIeiuWKBDLqqm+uO9zJIPLjt05HgBd2I9ULk
WYiqvzNlhjoFZG6a6NR7psLECc/PPhy2R+de5q5K7YZT+I4YpMgR2dc8KQkzAJMw
vDbq+WTPXshiKoNpcg4Snz6IUUFghFJygNbYD2GYD0RF0nBu1HNAVDAFOu/U6u5h
d8VWeJVJNYK23ak8Gf8cLvk6hpBw0GuijpH4nmundM2ZbWpIMniRj5N80zgBa6Dq
rPmfM0b29Ki1nYIcDtZH1p/EpOWKx0FE0xtBaQ54cd6i1q4mK5uBDJRFQVHE08bi
K/66sWZI0Mx5jFZyV8BLBIWArbX/8Lc4g2U4rDNq5bUehAiPfb/VAxR6m83dGR0W
4qTJIMoVbnq0ifJBHkecN9tYrbNoHcnL367ZwYfvvjk6dtWUKmJm4Wo4LbwaWUXz
meeH1p8OgOqueyW5x9kWBvGDG75MU6Wdu3cBvhyKlccQJuAocAUNf41GKKTpmUBz
Hk82Qj6XhsriaxGoiYKXb98sd7LnIzscQsNQpSNy50x0p8xqPIRL43QvW2FakCsv
ydhlocwajYAk66x12LHbD7TxE8TMreKVTeAuAv2wqbcdzRe7eL3lAjbGGIl+iLd0
BbANZL9w1VnEe8ck2U6U4WKslKyd5bFQj2kVsdynXau1FsMGirc=
=3mNC
-----END PGP SIGNATURE-----

--6t2fecdpx4yxkblu--

