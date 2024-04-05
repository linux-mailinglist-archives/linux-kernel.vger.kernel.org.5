Return-Path: <linux-kernel+bounces-132551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B2899686
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D21F23048
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48136AFE;
	Fri,  5 Apr 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MXKYHZme"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAE364BF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302098; cv=none; b=esFR1FBv7+Yk1pxZIq5jIBJcp2imAxhHtWZdzH1+qeS6a5/QE3TsttNpJQpYXDgyxtf487tcDwosb2VBHYRlG5WOBAVTsLHE9he4Kp3HbzU5xNP4O0fAde/AWfmX2OnfQcOt7Rf/+sDUT9JT6BM7eRtEUc/D8hP1O91IaYXUfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302098; c=relaxed/simple;
	bh=jGylkHnCTJk+jDu8qfJHp96B/vjbh2ojJtUUpFGGnLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfUhwqHs+nC4o853SqJ8riMgHB5CIJ5zyeQxzz40Az7UokiyIIYznMCZJ77ArljKBBXdVxdbe2Et5n59Q1Qhd2UoIGuAYrzbgA6qy9SRrzPZKQr1J3fX5XRRYPRzYykHGpmIKCxEXA/rhaItjcrSDRmQG/S7qI6TEV2eOf/GO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MXKYHZme; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jGyl
	kHnCTJk+jDu8qfJHp96B/vjbh2ojJtUUpFGGnLc=; b=MXKYHZme8ZvwjoWXSkoY
	KTCesM7MgynFrVpQ7l5IiHJfLR5zSM3IFJsO7ctmxv+A4jbwfvLQK6iuzcECXJ0x
	t+g4B1Iy1h1wuSaqIFKGH0y0Pnw+9T/uYy43HuBku7fxsklKhH9LhLFn1sleW62z
	cK8Iv+9QwDUf6ihx5RDcnP3X2h9FYNjLvLWPRSWwGw0Drgr1zaZOUC+q5N2TZGiO
	dGTwfdGN2Cm3w0DcYJYxlgIfGRGMHq0g+jvm+07OVe/C73S5VYbTqPn0VccC9TXH
	cE9Pohe2PWzVol6ByvV+fS5FljMRP+EDyiZyU7Y1tRspdWkF80oYHj8vAMdWhXln
	uw==
Received: (qmail 4020990 invoked from network); 5 Apr 2024 09:28:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Apr 2024 09:28:11 +0200
X-UD-Smtp-Session: l3s3148p1@GDfgZVQVns4gAwDPXwEGAANOsN0UmmrN
Date: Fri, 5 Apr 2024 09:28:10 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add R-Car V4M support
Message-ID: <mbqg5fjpfenc5cxlexe6l2xnd2oov43agpx42ondxwhox7okt6@fmq3h4mnjtft>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <8a39386b1a33db6e83e852b3b365bc1adeb25242.1712068574.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvphx6rphlmtpk7e"
Content-Disposition: inline
In-Reply-To: <8a39386b1a33db6e83e852b3b365bc1adeb25242.1712068574.git.geert+renesas@glider.be>


--vvphx6rphlmtpk7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:37:02PM +0200, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) in the Renesas R-Car V4M
> (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--vvphx6rphlmtpk7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYPqAoACgkQFA3kzBSg
KbbuIxAAooKHBYyEcMKaO+aUwNBD864JcZKrKFRv/ZoRlGSVQTFB9xRZHWXVaY0/
tmSEvTKYdh6/X4eSvHaAC+zKpyVzvkNzam2b876fjNaapqVlfxQDQoaSbZcnWED3
Mkcn0ITy5ad0btH5jnCxFSQEfExVSbH6yd2Mt6Aw2d8CR3LfQKr0YMPNXpYXusLw
EyTUV3B+J4y06bpZYZzS9kpvSA63/3fRlyKSrNnEfbEBM3K1bxaTbJSv3LnVzyE4
Mj9AKaseFAMSq1xomTUt8G9N7Ho+qLUAdvjoDyDxXnYTkuOdlewHJLrWIH9Nli7z
6Z9mLhkKG5cftvptpqk1hEJwPs0wf/J/M15I2dXfkpenQiNWP6ylRztJsiZhGqF7
7buXh8iMB4WfTByuyQ57KW3vGjWTF8PrgeBd/+87DJ67Zd7HgaBEyCwly4t3ECR6
fcxugf8SgIbV5hKqrSFN6UjJuA2hCKIxHcxB6/lsYmhtByMJZQ4nnzP8K+LQ3NSy
HijpOAYEmF2nKGrj6M4OlZkmlwbsB10BlGfg0iBwAtzasBYC5BbMH4Kxj6vS4MWC
FXVAQDv4TGQxU4nDcZF0ZjyNlxlQM2PPcFpQLS4UIrDU4qHlaFAW6x7yfnn2tOA/
fCauPs57BIMub/Co8Ra8JZ1E1jDWskePyFfr/jmTEpE55sS58HY=
=l7DL
-----END PGP SIGNATURE-----

--vvphx6rphlmtpk7e--

