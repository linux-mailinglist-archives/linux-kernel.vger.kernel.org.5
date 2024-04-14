Return-Path: <linux-kernel+bounces-144313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B98A4479
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB125B218BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E80135A6A;
	Sun, 14 Apr 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VXFF7a42"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF413443E;
	Sun, 14 Apr 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117127; cv=none; b=G6mLmp2Ff5sWFuoosUZDG8yKPNPYxiBjPlXmHln/8HY1WBtHFxUJUjC2UBoTf4wghG2af9ZHksVAlt0Ki23ulMSGA2x0YpYgqpBpKW0UwKZKJt4fBNWvKkhCY/Sbv37kyJqoVD3l4WtMclriSZVeWEEcL+H56AmkzfhT56L1XOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117127; c=relaxed/simple;
	bh=7oeIJBJB28bTtI1s924RfikvUhz080zhzK+OctRWIX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF/Br0HklLcq+snRgt2GPtcP/1KItjPrw1vOnhP7qd+HlhlWWTlsUlhOXrjvfeA1rM109k2zVGOG33bOcz8FFmNEGCih484IuSHqRD/wH3oziRiGnAUCMuFwAg1uWK3NgX/cKhqcRd3xXKNe2CDLnBaDy2uSv8dbjELJ8Qqjekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VXFF7a42; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713117124;
	bh=7oeIJBJB28bTtI1s924RfikvUhz080zhzK+OctRWIX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXFF7a42IADRYKhS+sBrSGfjmdAs85LDOwP9HMq5H+vYSp75SKYhQSrdMb8cRKQnq
	 usMzPmf4/OLD6WNVR+2Urku1hyGSmMzjkknl66wX0hCEY+8yfh1LDUSc4ZUkOawl33
	 QX6sOma7NStoOGHe3GB0KT9hFoIepEbrwgoYvuagBXZEFoxHPgB2IGZ95+e/LIciZ2
	 fhtV6yxJQJR6ecWLrfdW3MR2/SFAUmmitHsYWcFw/CBd+eOnTpmkXsIq6ZyoaZ/vVT
	 brPfDterPmxMmSLExE/4MKlFtOIEYggBvAj5v5utI0I6GqjEJlHaRxol2UCWYGZMnF
	 JsSCt4nRcMvTA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9273B37813CA;
	Sun, 14 Apr 2024 17:52:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3376D106134A; Sun, 14 Apr 2024 19:52:03 +0200 (CEST)
Date: Sun, 14 Apr 2024 19:52:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andrew Davis <afd@ti.com>, linux-openrisc@vger.kernel.org
Subject: Re: [PATCH] openrisc: Use do_kernel_power_off()
Message-ID: <rfbxtgppobtvtp2flghzpw7mzlrhnzwuk5gulwdauf5ecfkpa7@xk4qspf3mo3c>
References: <20240331070230.2252922-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5g3tqu2f5hovaone"
Content-Disposition: inline
In-Reply-To: <20240331070230.2252922-1-shorne@gmail.com>


--5g3tqu2f5hovaone
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 31, 2024 at 08:02:28AM +0100, Stafford Horne wrote:
> After commit 14c5678720bd ("power: reset: syscon-poweroff: Use
> devm_register_sys_off_handler(POWER_OFF)") setting up of pm_power_off
> was removed from the driver, this causes OpenRISC platforms using
> syscon-poweroff to no longer shutdown.
>=20
> The kernel now supports chained power-off handlers. Use
> do_kernel_power_off() that invokes chained power-off handlers.  All
> architectures have moved away from using pm_power_off except OpenRISC.
>=20
> This patch migrates openrisc to use do_kernel_power_off() instead of the
> legacy pm_power_off().
>=20
> Fixes: 14c5678720bd ("power: reset: syscon-poweroff: Use devm_register_sy=
s_off_handler(POWER_OFF)")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  arch/openrisc/kernel/process.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/proces=
s.c
> index 86e02929f3ac..3c27d1c72718 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -65,7 +65,7 @@ void machine_restart(char *cmd)
>  }
> =20
>  /*
> - * This is used if pm_power_off has not been set by a power management
> + * This is used if a sys-off handler was not set by a power management
>   * driver, in this case we can assume we are on a simulator.  On
>   * OpenRISC simulators l.nop 1 will trigger the simulator exit.
>   */
> @@ -89,10 +89,8 @@ void machine_halt(void)
>  void machine_power_off(void)
>  {
>  	printk(KERN_INFO "*** MACHINE POWER OFF ***\n");
> -	if (pm_power_off !=3D NULL)
> -		pm_power_off();
> -	else
> -		default_power_off();
> +	do_kernel_power_off();
> +	default_power_off();
>  }
> =20
>  /*
> --=20
> 2.44.0
>=20

--5g3tqu2f5hovaone
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYcF78ACgkQ2O7X88g7
+pq5mQ/+M+426GVgXDcqLWaBeZW3HA03bp5BIZ/MDyTJhm0Rddyq9+9y1SftS9bc
A1Hn5oGq3LBhUarGxPIsDzum+BFAnY9H0iLLNSa9GxFNHvatxsEsPPLAgF1+M3Q5
PaU9fBuC25Kihszf9bfnopMAt+3RbgDc2IVQv/f9sPjnd2S//342bFq2e8E7MTGp
sMa91/Jn4/2OPwjiSogBx1LehE4cnREYOWo7ruBCp8fW4e6G+wpQ5FhSVfe3NF/m
RYVpsVXGvVoIU1XecjC2CTi6g0MKJ6xZhXfjjRnmYDHnod04lVggh5zKzWgO6j+b
7M+7pw7EaCce/38W5u/hM40X0FH1GT/ZUdmTFhaBPUFzBBTpw1X9HXe0VLJhIYGe
urGx2G6QnX/x0YbDrbKJv27NsgVorKfE5qwPtpbD4MEhQqWovEl80Ysv0gCajs08
RmPVqqmFsxSqbPjsrzP8BL1bPTMBN/2iM05hzScis9/OgrGHRuSm8TNCGx7stYpE
PBoiE8bMlEKREoLriPRrcKvkpPCcKD1T19hsjonZZpLry6sTiQaCQbbeugNM97uK
EWy5DmeTgiYSQ/10auOYWkJG2Tp1FKPWz9o5D892DBrRKeyweHnJEF5g7LYjC+hy
5IQvYdd8SKIyrJACVazpoPbMWk8bjnmXuwBcXp8x2G+o7NtSzxY=
=fROO
-----END PGP SIGNATURE-----

--5g3tqu2f5hovaone--

