Return-Path: <linux-kernel+bounces-85155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F42186B13A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9191F1C22044
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB1154C02;
	Wed, 28 Feb 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF89elJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304D145341;
	Wed, 28 Feb 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129088; cv=none; b=OVGZJwI+xTolmXKZ6SfZsZkqVcVg/N716rmceqSqiNZzsiwFHQF1YZcUp9q704P1AhG6z2rdC7zWV91157dmOBuho7LdDS9+/ExkigTHXAiEWlzTPJkdb2p7dEMroSDMRHLH2hGgH2F6w3olhB8J3nSsEuy9DyuFKa7YY/Z7FlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129088; c=relaxed/simple;
	bh=mkN9EphVfkwSKkkJ22QmMJJrH82VGPuV04x7Zbl5Fd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktx08lH4wSLCVcAxSYyeWZ7piari9szdxipGy6N9R9idD8M30D9g7/krYQKhJVRwiNczXo/8URw4fu8qr7ErKFIvoxtMe1cx5zBDMnAmbnvIIdQW6UWRj7nw+TtR8egiKI/lteQ1p8yFNdpAqIL0+yKXJGS4diXwjFNSAsgtPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF89elJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B333BC433F1;
	Wed, 28 Feb 2024 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129088;
	bh=mkN9EphVfkwSKkkJ22QmMJJrH82VGPuV04x7Zbl5Fd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF89elJbgCiQLnC0iZKBEY5bLTGZ1f+WSm4/bJphB7FEsCETSRuKoKhq9ag47RJim
	 4HMwkPZL6kO+dUg9ztn1zeD4QJowGKwmunHPXjB3Utw5hGHiPLowCF73cwxfQSoyCJ
	 9FKjvkThFGa3WZ83d6l8vIe+3wl7aEPv4pD5pq/k1WWdu3iEtEQSGNbVmACrqAy3vN
	 HTMCaRzHQqe7EEWKwaSMWBokdr8e1h1k0NvEEx7mjzesR+Rol4P42EOV+b5FpNuPRv
	 GmHZKMq3s2T/KUxlRsya6jMRoNQNe431+Q2BQpXwJdt9JqkTS839KxOabku4NejTSP
	 fqdCD8TsM9e6g==
Date: Wed, 28 Feb 2024 14:04:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 7/8] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <8ca79afd-64e4-456c-936d-01faf68c2ad9@sirena.org.uk>
References: <20240228-onboard_xvf3500-v5-0-76b805fd3fe6@wolfvision.net>
 <20240228-onboard_xvf3500-v5-7-76b805fd3fe6@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GZv8oq1Dyph+Z9ez"
Content-Disposition: inline
In-Reply-To: <20240228-onboard_xvf3500-v5-7-76b805fd3fe6@wolfvision.net>
X-Cookie: Function reject.


--GZv8oq1Dyph+Z9ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 02:51:34PM +0100, Javier Carrasco wrote:
> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.

Acked-by: Mark Brown <broonie@kernel.org>

--GZv8oq1Dyph+Z9ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfPXcACgkQJNaLcl1U
h9ClBgf/WEqjCGdSA3iAFJbr122JZWQxEgNaNaZsKWB2+geVKJDo10ZkXVNxg5mN
XNszF9BGXc9nLrLmNu0IBuL038hA8DpAl7r/XIEoF/FhjWMVL3D/O9K2rRRAH8s5
cstxj5XHgf7Vh41TqJrTJG10nlfZwK9S1ZdcfxhKTw/w2nwg0egNvnMxiFo9ny5B
qEUA27fg6yczyVf3Pwj8Nmo9hmJm8QGIztYP4k85X4i6oNS/vH7rjCjk02U+9s31
ZugTtoOeeY/uHB7xZBY+Em8Vgj113/TTxofp2MQunjj3x7uWBiVmgpCk4UnTjO4p
gkJE8XHSeUyrwbbxJqZNjMj74sAowA==
=0dME
-----END PGP SIGNATURE-----

--GZv8oq1Dyph+Z9ez--

