Return-Path: <linux-kernel+bounces-50187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516DC84757D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3809B28783
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378B14A08A;
	Fri,  2 Feb 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk3JHPK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E023BE;
	Fri,  2 Feb 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893119; cv=none; b=AaiQgp1RBimlsRAg9OEeowlPKQB7aC7o2rBYLUXFEwzM7fuZ4BhYTzNOsZ6R+a5V4Xr8bha0IGtE+CttQr73/r0eO9E0XyHaO3I++7rFmlc6TCRVTH8NlJRb99fYnaB7sXuc2cvaNl9FKkkevMFCv+J5cLT4ySAkCHwwFtyuxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893119; c=relaxed/simple;
	bh=LH+trp+KZItbwSJmSPY12pLjo+Wsr9tUoiXQ6/C7tJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5KeZI2HZmLjnXlzjBjdz8kfcC64aj0Z61ApQ+baTQm+t41luf0Afejw1DNulc2ARI2rPJl4POL0gnveEgBTr7lNQ9i5BqX7oZzM5q8DylwoSq1EaREg1mL9rw2tBBefywW++ID/eHitqaRjS/ZTssMESDp5pNkWDnpNmbiediA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk3JHPK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71753C433F1;
	Fri,  2 Feb 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706893118;
	bh=LH+trp+KZItbwSJmSPY12pLjo+Wsr9tUoiXQ6/C7tJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xk3JHPK1ZB+t0LRPUoe+3rFObXyreLE5gOpq8w8eYKqMU0I/DpKgynQcilh1SDk5n
	 FRpms05V+kySq4FIP87xnxf1M7HkhTFp+7Mxhr1VMJiAH1h7pvsEphqzIKu2UOIh+h
	 XYenUNCBq5Hw4Xq3HY+csWhhC4CUTj7Cf1AoyuZIL5tAPP9gH/SOocnXQDvX/hul9c
	 G7V5M7WvbcpY1nOj6aIkJx2kojHpKFN0vCpZFMRt+RJFzaJQehkHrEDnOQIajP42M4
	 gTqRb7qEG5uI6p0/jRXt5NNJvkqhK7TFBGz9HHFktEev5lF4anJcJ/1l36/7AgsZAe
	 5cvwQdQCVYrDg==
Date: Fri, 2 Feb 2024 16:58:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 5/9] dt-bindings: net: add QCA807x PHY defines
Message-ID: <20240202-absurd-guidable-527a3f3147bb@spud>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-6-ansuelsmth@gmail.com>
 <9933685a-5265-467e-aa39-d2c92a12edca@linaro.org>
 <65bd07f7.050a0220.e8e5e.9e28@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7QgArvBGeLGdMaMK"
Content-Disposition: inline
In-Reply-To: <65bd07f7.050a0220.e8e5e.9e28@mx.google.com>


--7QgArvBGeLGdMaMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 04:19:15PM +0100, Christian Marangi wrote:
> On Fri, Feb 02, 2024 at 08:41:56AM +0100, Krzysztof Kozlowski wrote:
> > On 01/02/2024 16:17, Christian Marangi wrote:
> > > From: Robert Marko <robert.marko@sartura.hr>
> > >=20
> > > Add DT bindings defined for Qualcomm QCA807x PHY series related to
> > > calibration and DAC settings.
> >=20
> > Nothing from this file is used and your commit msg does not provide
> > rationale "why", thus it does not look like something for bindings.
> > Otherwise please point me which patch with *driver* uses these bindings.
> >
>=20
> Hi, since I have to squash this, I will include the reason in the schema
> patch.
>=20
> Anyway these are raw values used to configure the qcom,control-dac
> property.

Maybe I am missing something, but a quick scan of the patchset and a
grep of the tree doesn't show this property being documented anywhere.

> In the driver it's used by qca807x_config_init. We read what is set in
> DT and we configure the reg accordingly.
>=20
> If this is wrong should we use a more schema friendly approach with
> declaring an enum of string and document that there?

Without any idea of what that property is used for it is hard to say,
but personally I much prefer enums of strings for what looks like a
property that holds register values.

That you felt it necessary to add defines for the values makes it more
like that that is the case.

Cheers,
Conor.

>=20
> > >=20
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++=
++
> >=20
> > Use filename matching compatible, so vendor,device. No wildcards, unless
> > your compatible also has them.
> >=20
> > >  1 file changed, 30 insertions(+)
> > >  create mode 100644 include/dt-bindings/net/qcom-qca807x.h
> > >=20
> >=20
> >=20
> >=20
> > Best regards,
> > Krzysztof
> >=20
>=20
> --=20
> 	Ansuel

--7QgArvBGeLGdMaMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0fOAAKCRB4tDGHoIJi
0utUAQDk41YOhs1sjqAy6bFX702DP85otH58BZUsZ3NwVbEwTgD/Ysf9qMXV5PBc
uT2MM+l5vuctHqVwqJMcOHmlkwxKngo=
=LyYE
-----END PGP SIGNATURE-----

--7QgArvBGeLGdMaMK--

