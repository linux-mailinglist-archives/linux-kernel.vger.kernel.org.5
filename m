Return-Path: <linux-kernel+bounces-85035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6A86AF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214A3287BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC1F1487DB;
	Wed, 28 Feb 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh8u43GT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38E73501;
	Wed, 28 Feb 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124576; cv=none; b=Dlf1PJVmw+U6WvPXe21sAXfk2sq6pLjo39sD1LMtJ1akz4NwcfnqO1mJ8c/uiQ22Qv7z+rofR+Q73fxgPrVKXqkOyr7yiEixSjRHXFyOub/AhMsPH+35FZsckswRyuFp79N/KVp0u0lue6ZTvif+mbnBCLdbzNvNq5MjbovQ6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124576; c=relaxed/simple;
	bh=kKrhwyZWXORapt6OCBD9X9Cbq63y3UaV5srvhlpNfhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mms/6hzojp2XDus2gOcWkRrwz+y8S6KxNGdmYPW9Zrb+klyFaigH9HePk+5j4tnyAqPm4OolnAgmpBWUy3/iMv3jIYSRHdTxAysblfRF2A10FG8TVkAZ/F0w19nffsHBK3ErrCLZolqthZHUHxkPUBtZ1oMPNrp0biLbslRl4o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh8u43GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36569C433F1;
	Wed, 28 Feb 2024 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709124575;
	bh=kKrhwyZWXORapt6OCBD9X9Cbq63y3UaV5srvhlpNfhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh8u43GTkarJTZG22uMj1OWFlUH6fx586sT5DKG/kug5pyZNtd4iZGMSZhjoBI+JA
	 yaaTX6DNowHRbjw+8rSPFktHWJU8QzbW2+CWnzShPfWbSECHErYZVTV/eDZfALhQoF
	 8UjhA6u4UkMwLGExkEPt3ChCRkqK6uAcNyUQO9RdA7qUSsxJ5pl3efDmtq9i3cgeR6
	 vhu7oSBKc1rp4JfvFV3vRi9yZQkJtSoaWAQbpAo1TdnY7mlc7AlKcwKo81SFng1qS5
	 IJjE/OKSteMKOTfzBBZGDPOPTcN0jB35+OvHuYvrVseUahg9rQxdI0MiXNkjXaKYy/
	 EKmzjRUICA3kQ==
Date: Wed, 28 Feb 2024 12:49:29 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 01/30] dt-bindings: gpio: nomadik: convert into yaml
 format
Message-ID: <20240228-sandbar-hastiness-ec5c1337bd3b@spud>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
 <20240228-mbly-gpio-v2-1-3ba757474006@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XQPnKJoE2X/I/ya7"
Content-Disposition: inline
In-Reply-To: <20240228-mbly-gpio-v2-1-3ba757474006@bootlin.com>


--XQPnKJoE2X/I/ya7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +    gpio1: gpio@8012e080 {

The gpio1 label is not used and can be removed.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +        compatible = "st,nomadik-gpio";
> +        reg =  <0x8012e080 0x80>;
> +        interrupts = <0 120 0x4>;
> +        #gpio-cells = <2>;
> +        gpio-controller;
> +        interrupt-controller;
> +        st,supports-sleepmode;
> +        gpio-bank = <1>;
> +    };


--XQPnKJoE2X/I/ya7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8r2QAKCRB4tDGHoIJi
0n38AQCC1ntsIjUcAEohmeSuO00TkoNmkJJqMRTh0sWa1jMmWAD/dgZeTh5cG9Bh
z+Gc36w3M/CeHOsRflN+45NVkh9w3wc=
=816A
-----END PGP SIGNATURE-----

--XQPnKJoE2X/I/ya7--

