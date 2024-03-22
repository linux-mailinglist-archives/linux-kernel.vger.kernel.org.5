Return-Path: <linux-kernel+bounces-111917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC688729F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939EC28599C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A44627EF;
	Fri, 22 Mar 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blJilI8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8186217C;
	Fri, 22 Mar 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130895; cv=none; b=XtW4x/VmR5PQeNicrbTHthumGGRyHIdzOvIVb3SOXoFrOKCZyVbNEZ8ypgCi5CyAG1n1VEjsOtJKAK5VFFT8PqIvzoxh4YNPGU4q6KcvL/KylFb0yRQsjTIruDo2nXW3si+tKR7R4HjRx9cU5KgendtF9UEUZFHwux4oiOjikh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130895; c=relaxed/simple;
	bh=fQXZuc6meo+LXu79cW5I7jPiDyKbQOSV3nOXls1mcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNIyS/jg/8X+Oztmk4aDw62Qe6NvEGUbJKcZTlaPFeJ0zVYnEO/x5fLA2hnOPO6rF9wyt3PIwmgxLz0tL/pHM2ugLkC8cKm3UMxQKTa2dPYrP8aBzf37wZF9s9LfT1l34FHR53XcQjp2j/VG4M8Kic4iCMKZ38z4PeH++1NxroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blJilI8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2661FC43390;
	Fri, 22 Mar 2024 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130895;
	bh=fQXZuc6meo+LXu79cW5I7jPiDyKbQOSV3nOXls1mcm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blJilI8Hi2JBw1HOLOVWzOx764MvFX6UDS6AmOG45iIc6+1akhltpXW8w6CzxvKHm
	 oJszU/Qt371YWwmXbGij1nq0bb/aLW5D2wQXrKVeTBW7+4t4M2Vd5Qscvai8RO9uP0
	 CtdmlknHA623GlwtdgfEJaoSjM76VTebxdq0vNeuv02zTqEx+Kot8tNjpWf7WhKV8U
	 VAlv8wsjkLzfiH5iXchY4mM4OeYfTfnYnWaxJREJKOPumk2QGg2Hi36itK0iORbvts
	 z0w976BHZaHRAhKvbWCuckQYDZSnVb2wyvrlIMqVMqUOWgHyYk+ygQZW0oFvwvbzjk
	 JJ5rniRAmyLFw==
Date: Fri, 22 Mar 2024 18:08:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Parthiban.Veerasooran@microchip.com
Cc: krzysztof.kozlowski@linaro.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <20240322-bronzing-gangrene-486296d6117c@spud>
References: <20240306-spree-islamist-957acf0ee368@spud>
 <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
 <20240306-ripeness-dimple-e360a031ccde@spud>
 <05a9a7ee-e4f0-443e-9c8a-8ee649a11448@microchip.com>
 <2f384a54-74a0-4a75-a325-8985257b5d66@linaro.org>
 <ba37c212-fb98-407d-9bee-6d14801754d9@microchip.com>
 <96493beb-afbf-42f2-88f0-ad645422ecdb@linaro.org>
 <1735add6-4a6a-452b-bf26-1cf19c95493e@microchip.com>
 <20240321-upcountry-finless-b0e9b1ab4deb@spud>
 <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S2tY6Un3N5uwXbGz"
Content-Disposition: inline
In-Reply-To: <13a28ba3-2da4-428c-8091-25e75c6c11e8@microchip.com>


--S2tY6Un3N5uwXbGz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 06:25:02AM +0000, Parthiban.Veerasooran@microchip.c=
om wrote:
> Ah ok, now I understand this. Then it is supposed to be like below,
>=20
> properties:=20
>=20
>    compatible:=20
>=20
>      oneOf:=20
>=20
>        - const: microchip,lan8650=20
>=20
>        - items:=20
>=20
>            - const: microchip,lan8651=20
>=20
>            - const: microchip,lan8650
>=20
> Executed dt_binding_check with the above update and it was successful.=20
> Hope this is OK?

That looks about what I would expect to see, yes.


--S2tY6Un3N5uwXbGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3JBwAKCRB4tDGHoIJi
0qZBAP9TqELgibVyHTh6TNWuFU2T4oY9Ob9ctLd7nkjGBVVy6QD/V5J/qVbshDrN
sDFI7s1V58/hn+099z9ElLwxU6Ut/wU=
=etGe
-----END PGP SIGNATURE-----

--S2tY6Un3N5uwXbGz--

