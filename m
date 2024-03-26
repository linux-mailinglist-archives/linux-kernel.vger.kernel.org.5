Return-Path: <linux-kernel+bounces-118448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C975E88BB05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DF62E297D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914213049B;
	Tue, 26 Mar 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIMWFDwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDC1272BB;
	Tue, 26 Mar 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437370; cv=none; b=el+gHC39rZ05ZKFW+TlExneS+vTiZMdAoCA9I/vC3xcrodiXWWDNXRjDChPesB+glwwL7ubVtLOZnSUVO5tUFzG1kFGKB0DEmpE19dWalYVR3ZIQysash1dKwEPD5ytO9/u8viSnDek6ws3KarGTE/NfCKgoAe1Lmopl4FDlVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437370; c=relaxed/simple;
	bh=zwqUSfI04UE8e5qP1oXh410r6hlhmfLlE5LjHLpMUbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWTle9+obwFLWb5gFs4DrFuCIPZYbxC4HUVnCBoK3yRMrP5WrFG0zCu9gKXw5FOp0trLtcbXNjT9aSk760TIwyYDqWFlIYAebvg5FQe5Y0MUUUSQnAUx9gABKibG9ItCG2rZ18Q6uwNNUiX6nJ7B1o8MxbFkD6V5lFO+CKgjbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIMWFDwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6FEC433C7;
	Tue, 26 Mar 2024 07:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711437369;
	bh=zwqUSfI04UE8e5qP1oXh410r6hlhmfLlE5LjHLpMUbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIMWFDwhVPa+AymD1PUhQa0EGJOt0Y28K72VuYZk6N35biR5xUlqug8ViKFoPU6j7
	 UyHo2nGkr/hkrI/yuMNiRC9QIpoa+77oeoDNHYhx4l1+1OJozc6BODvfTZ1Yp+mbq0
	 FG34nIuhSMCbv3GKygo7Uw8YfNobAFIwnX/NeYMFc1PiM6QOYps8pYrH6+lRb5psoS
	 alL/8h3NEcKV7QGxFTB4zzgj0R0VYSmeGqgjvRvthlm5TY90tQvVl68zGfmOsYCOQ8
	 7BCZx2dGI1HUCGFPSWBlUyy2fQ448N+eKEB8K1sZUtDyvB7ZK9nMNcThX0NmiDbYAP
	 JQUyd3S1uHVKA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp12e-000000003rK-3eXh;
	Tue, 26 Mar 2024 08:16:16 +0100
Date: Tue, 26 Mar 2024 08:16:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <ZgJ2QHCYI4wfmfcr@hovoldconsulting.com>
References: <20240325081957.10946-1-johan+linaro@kernel.org>
 <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AptyjpU+c6gakW3J"
Content-Disposition: inline
In-Reply-To: <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>


--AptyjpU+c6gakW3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:01:16PM +0000, Mark Brown wrote:
> On Mon, Mar 25, 2024 at 09:19:57AM +0100, Johan Hovold wrote:
> > Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> > supply for GX gdsc") the GDSC supply must be treated as optional to
> > avoid warnings like:
> >=20
> > 	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, us=
ing dummy regulator
> >=20
> > on SC8280XP.
>=20
> Can this device actually run with the supply physically disconnected?

The gpucc-sc8280xp driver is used for both sc8280xp and a couple of
derivative platforms. AFAIU only the latter use this supply, but the
driver unfortunately currently cannot tell which platform it runs on and
requests the vdd-gfx unconditionally.

An alternative would have been to add new compatible strings for the
derivate platforms and only request the regulator for those as I
mentioned here:

	https://lore.kernel.org/all/ZgFGCGgbY-4Xd_2k@hovoldconsulting.com/

Johan

--AptyjpU+c6gakW3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZgJ2PAAKCRALxc3C7H1l
COOZAQCADSO0a33chhR+oOiBI4673E6MYzdBUKplSq2EznJXGgEAnKuJVq1IoKvU
7jBOzeZ9Jr5Ks3R5/kkSKD0ziDDbJQ4=
=DfH8
-----END PGP SIGNATURE-----

--AptyjpU+c6gakW3J--

