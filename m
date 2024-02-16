Return-Path: <linux-kernel+bounces-69458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E31F8589C3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E191FB23D93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA851487D6;
	Fri, 16 Feb 2024 23:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ps4L3dEf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBD38DFE;
	Fri, 16 Feb 2024 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124880; cv=none; b=ggxjUrU2uI/eAL4iSlMAC4PBilJlHJEdEXVNbwAp0IqFcWqoG3snLS07JSsVjYf6pCNYWIvvjmVk7+n5zeBRqP5QKXrrg0GXfDvyQEijoDM/gfQOkj0pGKxZ1/tYAbc26XwYbD7mJsw7qbpcB3kxw5k5h7UBMln75EUdyOYc5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124880; c=relaxed/simple;
	bh=q7ADwbeBXwmo7E9aTVnbzqVj7QgPJRlOcrrBDZiAmdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLHxhlfFONj69pD2mkf0b9zdLiYzMEPMG1dFiuHuFKQCSs+0xnq3z1Mv3ETIdtSmLx772Xp60/OrcSrTlkxSdHBHbbj4yThh38rx7mLOzT2CFtSm1cAKigB2+ferBeKNBjyWIKvfXZqpKXQLW6hGW5MsrjxS+qB7O0HAqy+JmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ps4L3dEf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708124877;
	bh=q7ADwbeBXwmo7E9aTVnbzqVj7QgPJRlOcrrBDZiAmdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ps4L3dEfm8WT/rFjNO3i1cLkclFgUjDwjhKEpFI4fdjWkTmR0JyWaMtjMpYDsXY9l
	 75Ba7sjCDEp/va0JXt8iaCpyYlXyZrze2ZSKbd3wWQeVdtXroVEMW4DZa0IY8oye7X
	 fE6QTQbq+Y+7VzbEjjQFzdpKsApI+dEfyJm4m/AuIaj0YrfnpCcpxT359Ujq4inYAV
	 3lgRo5JBA97/J4Q6asiF4iR2tpU2euJqhJi41ow2b6mPSXeYn4qrdfyxKb+L3jAsks
	 ZmyWtTUizHFjgjvy1rgw2pHjVAWHQ+lB6xbK0Qsl4CDFn7e0zQTEgYlyE7bMSPmEta
	 GpBTocr4QPcgA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3A8783782042;
	Fri, 16 Feb 2024 23:07:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B61D71061C38; Sat, 17 Feb 2024 00:07:56 +0100 (CET)
Date: Sat, 17 Feb 2024 00:07:56 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] power: supply: Add STC3117 fuel gauge unit driver
Message-ID: <ed5vkqpi2vipycdpy6fwszowiuk37ltuurqpe6t3yuekxynidc@ad7zvejmu5v5>
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
 <eccj4u6ewr33mlp4xqwx5medeysrjuwof7ntwhm6vypmmkss73@qjbpyw5hj3t7>
 <MAZPR01MB6957FE701F89D83DF57F7402F24C2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksq33adg27c6w63k"
Content-Disposition: inline
In-Reply-To: <MAZPR01MB6957FE701F89D83DF57F7402F24C2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>


--ksq33adg27c6w63k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Feb 16, 2024 at 01:34:11PM +0000, Bhavin Sharma wrote:
> I apologize if I'm mistaken, but I noticed other minimal drivers
> in the codebase.

Please point me to a driver, which just exposes the voltage.

> My understanding is that using a minimal driver shouldn't cause
> any issues. Additionally, we can easily update this driver at any
> time, as we're actively updating all other drivers.

So why are you not doing it now? Adding current, state of charge,
temperature and OCV is trivial. I'm not talking about supporting
every feature of the chip, but just the bits that are a simple
mapping between standard power supply properties and a chip
register.

-- Sebastian

--ksq33adg27c6w63k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXP6sAACgkQ2O7X88g7
+po5vg//XQHEu60f6Sq5WXycuGpwD2Rrwky4z2q70+qOWfZlOx02RIoQVRPpivS7
AhINrWWioIm6NeRXCKwpG+6GDCRYnn0fUjM/cIgdRG1rMBClZB2aqeJ+3VdZ51H6
f+212OtdSeKoHcblWbiHbwAJ4xr0fiV0iKxrAplJUy83l0WMykOjbAnuS5HDymXI
6JuReyWIdjG/4NfWqGAEOOw6GdQCRBNl/u/BgkWkpKA+stJUcjK7h+2NSkfHdk+y
zQRX0OUI0wyHA8uMSzk6MxbbWALkvm4o9IYhY36q84iekKG4W+qa6Kzpxk2n96Nq
9bfmKQbWVEMSQz2ES2sNTjXcE+YO8LyQWZBf6D9MVtlvune4pb30nWFkIkdbd8fV
YwheuZybikIIpfAmbOiSO2NbCH0l9iHaNcyyTXhpnIh9zylgely8La1EoQsDFwnJ
w9zhIO/3RSMJITgAvi1nc7Z0rC2nppEMLeTV0tS3lvLU8ioiHbGR57lSMNsA7Shk
1jF2ebCFHCHG7bZLx3kPtOByJtv/Ln8UiNXQfeNJub3xikQP/ilQbGsVnqr4wly5
4gEdkXg+5kj4Wub1OafAwYAnVDAqJwVxK5RhUwZ9EK6r/GoH61nyOceby+tk7KL9
omnEO+kFeYarmfYDirMkj4k43legzBrAozWg8m5zIYL1CpjnlyM=
=B5bh
-----END PGP SIGNATURE-----

--ksq33adg27c6w63k--

