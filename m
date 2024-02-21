Return-Path: <linux-kernel+bounces-75378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434A85E766
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7121F25062
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323608615E;
	Wed, 21 Feb 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV4kJ7oS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093785954;
	Wed, 21 Feb 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544355; cv=none; b=IIcW/Ev9wRfwdZtdJtSlQXfNCzOGhvy3yiahgDelzVmUCHJBCxGlbdwVJJP8apv1zspPpwLjIfVmZf9B2YB61dBmSeYk2HE0y0X/hhuZJMqFlnhGBxFm6FSI7JqnvsIjntu1YHxe6ZbmAkl4bUI/74txPHcgOTFF33ubggKrjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544355; c=relaxed/simple;
	bh=jpjoy9Fsa6//vmMr82XAl99quOukD/lr0ooCOOk0MCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmhJS7L7b51Cal4PgBM986VT4RAJFSION6TfJ2Esz6sQeOOXEkwBjl2oIoiJ5qxM04SifDFBoghXtqia/Jp/bcouJ1PdmAjBlXtX0AapB5+F22IDNY3KxTnMkL3VTuXNLaOVNeRRkv6wm8v7BCvcdY2YaEShNJ7Noaycpp1ZdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV4kJ7oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDFFC433F1;
	Wed, 21 Feb 2024 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544355;
	bh=jpjoy9Fsa6//vmMr82XAl99quOukD/lr0ooCOOk0MCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QV4kJ7oSZqHBFzHeaGSRz0SBLAECwgsglXFHHqcnwn9fttT/26VU2chgTducZEQOB
	 yv94ChGVuehslh8yjnBL2gnt4qojlWuUXEeJuK3Ujbjj5GnK9r3wwgxjRmzutpgDn0
	 E6hcXqO2rnXU+NJsU70UXVTG25Yv1veO26XlxxlYToKrIzYUmsiDCy7wsZMzO5L1Xo
	 QKQjjY30FHe65H4EyDkjl0LngoPhF2nr0reQBR3bBMCxHeBTq9kRFwDiSy9Pi5mJp4
	 PSgyM28KNCZg7VhD6JKkNcy8hc+9b82m2clGcP2y3LYiK+z1yPOKH6prZoFSCcc07b
	 0rPttK8lRbXtQ==
Date: Wed, 21 Feb 2024 19:39:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alex Soo <yuklin.soo@starfivetech.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240221-overstep-degrading-f0aec67f1221@spud>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
 <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oW1W+eroT4GxNUCm"
Content-Disposition: inline
In-Reply-To: <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>


--oW1W+eroT4GxNUCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:24:26AM +0100, Krzysztof Kozlowski wrote:
> On 20/02/2024 20:10, Conor Dooley wrote:
> > On Tue, Feb 20, 2024 at 09:11:43AM +0100, Krzysztof Kozlowski wrote:
> >> On 20/02/2024 07:42, Alex Soo wrote:
> >>> Add documentation and header file for JH8100 pinctrl driver.
> >>>
> >>> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> >>> ---
> >>
> >>
> >> RFC? Why isn't this patch ready for review?
> >=20
> > The TL;DR is that Emil and I didn't want to apply the dts patches to
> > support a platform that hadn't actually been taped out yet.=20
> > For an SoC in that state, at least the bindings for, clock and pinctrl
> > could be subject to changes before tapeou. I think putting RFC on those
> > patches is a good idea, but of course the rationale should be mentioned.
>=20
> That would be useful information. We also could mark some bindings
> unstable and accept breaking ABI under certain conditions, like that it
> is early work without users for long time.

I don't want to discourage a vendor that's clearly doing a good job of
working on things before they've even taped things out, which is why I
suggested sending clocks/pinctrl as RFC until things are finalised.
I'm not sure what a good way to mention this in the bindings would be,
particularly for clock/pinctrl definitions where things could change
"behind the back" of a user - I'm thinking things like U-Boot here.

--oW1W+eroT4GxNUCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZRXAAKCRB4tDGHoIJi
0pHsAPsEyp2tYcjX2nSqPkPh9K+5WEkawzPSKZ3xZfBdBTNjeAEA2DQTPxP4sxi5
G4gYhkpSkY1LV81h9yz8W2TnAykKewY=
=Lo+3
-----END PGP SIGNATURE-----

--oW1W+eroT4GxNUCm--

