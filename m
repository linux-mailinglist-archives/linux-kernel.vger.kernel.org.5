Return-Path: <linux-kernel+bounces-46850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B81844568
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AFD1F22468
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3527212CDAB;
	Wed, 31 Jan 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzd32YWS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3512C556;
	Wed, 31 Jan 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720281; cv=none; b=Q/Pmvac6u+wZ2h6UC6g/764eVjUuIYetnLWImIMTsg2ifS5szAkCPHRzt/9ES/332/Pt1fO/G679Lj4zVTkmteGfXnL4F9Qp+eCGUFwGjOeEoRRntwTXbUdfociinu/6qtS4hqRRiWyc4b51YhlK0a8mx9BxXtv/UwWd/Vfsx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720281; c=relaxed/simple;
	bh=AAYWli0+ekhwWji5QCBI9mHhUVTGhsGXqS6v4AGlvlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxQf/x/FIqqEO1NSgeRxES2pzOLAWrtM/R8FZlxK32PDEU/INX9v3RvGkMG2JN5ilzUlrPum2UYLRQk69FkMTvmqpNldPR1dbyS/BhJucB/QZ/hJ+NGf11O18PmoEm9a9gKw5FvNyYxLVXckejI+TJaOoI5a5Y5srsBHlWJ4OLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzd32YWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32405C43141;
	Wed, 31 Jan 2024 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720280;
	bh=AAYWli0+ekhwWji5QCBI9mHhUVTGhsGXqS6v4AGlvlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzd32YWSJzGiNrYKNjcbSmNWQC1tX4vuCsbNRyS4hcXoKvaWKLbAXclry+EhmcuJc
	 E8zUGGnjhHod98dwmRjly8o80Y6dt946OjRBjKYburDoqu7vC0MQbvCJnObOtL5k2l
	 Yztm2wprEf7HxsFGZkw9yYUSsYEl4hbOPhTGKbG5kr6EC46OpdiFA0JbDtNSutf8G9
	 GvvTbK8O93UBVZdR/dqomTQeeh8XmSmz0uSFYpsUqa86TtTiYTB2uW1TXIZNA6afko
	 Opl0Hv0E7H0eQipEEHSoxIsBkh6lmZnn5VAbMxP2GqamcL/vjvfR/qPOPCPFFOYVaq
	 riRoyy7u1s6gQ==
Date: Wed, 31 Jan 2024 16:57:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	hari.prasathge@microchip.com, manikandan.m@microchip.com
Subject: Re: [linux][PATCH v5 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to
 DT schema format
Message-ID: <20240131-spray-commodity-673622ffc1b0@spud>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <20240131033523.577450-4-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Up5J+MjpJWWvw0o9"
Content-Disposition: inline
In-Reply-To: <20240131033523.577450-4-dharma.b@microchip.com>


--Up5J+MjpJWWvw0o9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 09:05:23AM +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
>=20
> Align clocks and clock-names properties to clearly indicate that the LCD
> controller expects lvds_pll_clk when interfaced with the lvds display. Th=
is
> alignment with the specific hardware requirements ensures accurate device=
 tree
> configuration for systems utilizing the HLCDC IP.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Up5J+MjpJWWvw0o9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbp8EQAKCRB4tDGHoIJi
0pFnAQCKH+mkNUeIXKouL9L0h7OnKONe67YgBm0bChu/ir7aEQD+J9bT3DR1BQ5V
CebLc0QPs+K8WjytedCfx8EaPxvUBwM=
=OQtS
-----END PGP SIGNATURE-----

--Up5J+MjpJWWvw0o9--

