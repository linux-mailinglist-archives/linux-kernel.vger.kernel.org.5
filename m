Return-Path: <linux-kernel+bounces-119817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83188CD4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CEC283BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3213D252;
	Tue, 26 Mar 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4yxmGjC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F73380;
	Tue, 26 Mar 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481700; cv=none; b=WMXeFEIqqEAi+FTyZtMnQ0Tr638yub8R6NGYBP6jRmbK09ki2duHwNFinPkWAscJ5G/oTv/94FvLnA2Thc3r+GHn2TjkoF7jFrEudkftd3mwomz9syt3S/wOgWCPl8C6YhXwdd8YGYN7qaJ1TgBTMxZHxLXgMtxnymAzWmOqDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481700; c=relaxed/simple;
	bh=dd88q1ZEU6vWFMFdtX0JYBknro/QldP57SoW9UmINfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJZKu/26J/6NGhCOWy06bQ2um4NQ+lIOM/4v5VPPA0E0oGsrAAKtj7N6Q+raEMV2g5xKa1y7FA2pDm1iDS19DdT/gF/NcMVTQwsn+qze3hsItOMor9jtnIHHbfuJXc+kVjVm8qexc9MWEj8ZTdOMi9zDwhpGsaT8S0kigea4AHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4yxmGjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C90AC433F1;
	Tue, 26 Mar 2024 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711481699;
	bh=dd88q1ZEU6vWFMFdtX0JYBknro/QldP57SoW9UmINfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4yxmGjC0N+zEn19fH/1bM+s9IgFIlwD+J2ali8Up/WQDOgW2t8N6shOD8Dr2B2W0
	 JoDYxTsIEhUlST2ScUZ1Gn7FDik/5JaR+YLrAwSIkmGDb4sfL6xXf6nj7NkAm/igc6
	 TtxtqWpfUeiJsgTTGid0GDvzTxNBqWsjcRUW1to55B0RNTMzCM+4v18rR2BWivsiOX
	 x1WcmLakDJOZiLSrqQPUG2QQBv8/+wLw5OvKfl1QjzzPBO5rg2vW8leX4b/77EwWQa
	 IA1XOQ+7kIkeMy1hOpKn5lU9Fx07ky5ntFqTwYVfPdJyGGFFzlC3Prnimvhl4nAGrf
	 MVaYQjC2SHQzQ==
Date: Tue, 26 Mar 2024 19:34:54 +0000
From: Conor Dooley <conor@kernel.org>
To: dev@folker-schwesinger.de
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Alban Browaeys <alban.browaeys@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] devicetree: phy: rockchip-emmc: Document changed
 strobe-pulldown property
Message-ID: <20240326-shortage-portly-a3ae475b2f78@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-2-f410c71605c0@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rZWP/rtpsRtp/vzL"
Content-Disposition: inline
In-Reply-To: <20240326-rk-default-enable-strobe-pulldown-v1-2-f410c71605c0@folker-schwesinger.de>


--rZWP/rtpsRtp/vzL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 07:54:36PM +0100, Folker Schwesinger via B4 Relay w=
rote:
> From: Folker Schwesinger <dev@folker-schwesinger.de>

The prefix is "dt-bindings" not "devicetree" FYI.

>=20
> Document the changes regarding the optional strobe-pulldown property.
> These changes are necessary as the default behavior of the driver was
> restored to the Rockchip kernel behavior of enabling the internal
> pulldown by default.

I don't think this is a valid justification, but it'll be easier for me
to explain this on the driver patch.

Thanks,
Conor.

>=20
> Fixes: f34e43f12382 ("devicetree: phy: rockchip-emmc: pulldown property")
> Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
> ---
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt =
b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index 57d28c0d5696..10c05437f7ab 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -16,8 +16,8 @@ Optional properties:
>   - drive-impedance-ohm: Specifies the drive impedance in Ohm.
>                          Possible values are 33, 40, 50, 66 and 100.
>                          If not set, the default value of 50 will be appl=
ied.
> - - rockchip,enable-strobe-pulldown: Enable internal pull-down for the st=
robe
> -                                    line.  If not set, pull-down is not =
used.
> + - rockchip,disable-strobe-pulldown: Disable internal pull-down for the =
strobe
> +                                     line.  If not set, pull-down is use=
d.
>   - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec reg=
ister.
>                                      If not set, the register defaults to=
 0x4.
>                                      Maximum value 0xf.
>=20
> --=20
> 2.44.0
>=20
>=20

--rZWP/rtpsRtp/vzL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMjXgAKCRB4tDGHoIJi
0gDXAQDsnJ2l1e9/GqPRLAJofwCMnAL+WPP/kMag/2lxXFb3sgD8DaHfe8Mk5FsS
FcEt/njhjF1n6zYpqFuyWccUhJQdUwc=
=f9q9
-----END PGP SIGNATURE-----

--rZWP/rtpsRtp/vzL--

