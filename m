Return-Path: <linux-kernel+bounces-47018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85084480F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB25B25678
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B03E479;
	Wed, 31 Jan 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="LSeKICjp"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE783B198
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729708; cv=none; b=Ll3QrLRm/yRxW9uB3WzR6hbwNTLin1IAARhQIo0DFFKfMrPp6F2+2gz7zffCWf5zKDwVvoUyg6EcJMckInupUN6r0RRu/238TwFjepO7yzbt6pLThGG40520RAzLyXUGPIGLtrwkbulhPtRdrYyGf+WiLqAKk3iJ9z3sYjO/BNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729708; c=relaxed/simple;
	bh=BRwssqc2jzt/f3mBb8BSDVJgrvePchYdkfdcqXofltc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqDyu6xCsh2Y5TnVMHd6Wfxnqi5dyYNShz+ud9OQyJk5Yn51KK1wINEHysubI4QuMqfpznRoiI0M16ysyf+RHCvr5SZdf91XPm04UaoNlJGTirWDUUa3AniyrUaZR+EpHpR1ScaprnNUhy7sFt6VNaaOYkW37myMvrjNXF3EIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=LSeKICjp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BRws
	sqc2jzt/f3mBb8BSDVJgrvePchYdkfdcqXofltc=; b=LSeKICjpPR1VkkwfK149
	rrg2cOzfsszyIgM2cA0fL+fiTrOREl7Q6xPBikF+Q0plpEov+VAms4+ZazY4H2wG
	01C1ZS4pcAKSEUz0ymEldvPBj3QcrUsfDeBhd/tCHKu3jcVZJz1c86a/ebTpZuPa
	gavI4FHZNwki3OLrIssnrB8984AemTyEy3VTN4Zu5uQ9VZzbXyaoRbgVsIkEjq/o
	ccXW+8s73Tr8VI90bUgGWCz8YSW/9sy3OiDX0SBEwt8Ch1WDB9iv3NcyaNE8J8eZ
	qgBP3a83rprQi/iAgsBzRFr6UI6di2w+hCRIr5I3lFwi8WwOhn+3kWKViKnL5u0G
	Nw==
Received: (qmail 3307818 invoked from network); 31 Jan 2024 20:34:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 31 Jan 2024 20:34:55 +0100
X-UD-Smtp-Session: l3s3148p1@hNU5+UIQQpRehhtJ
Date: Wed, 31 Jan 2024 20:34:55 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tmu: Document input
 capture interrupt
Message-ID: <Zbqg362_6i3M6rcZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8cb38b5236213a467c6c0073f97ccc4bfd5a39ff.1706717378.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1upon9EKclLYqctJ"
Content-Disposition: inline
In-Reply-To: <8cb38b5236213a467c6c0073f97ccc4bfd5a39ff.1706717378.git.geert+renesas@glider.be>


--1upon9EKclLYqctJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 05:11:45PM +0100, Geert Uytterhoeven wrote:
> Some Timer Unit (TMU) instances with 3 channels support a fourth
> interrupt: an input capture interrupt for the third channel.
>=20
> While at it, document the meaning of the four interrupts, and add
> "interrupt-names" for clarity.
>=20
> Update the example to match reality.
>=20
> Inspired by a patch by Yoshinori Sato for SH.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--1upon9EKclLYqctJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmW6oNsACgkQFA3kzBSg
KbYqTQ//cDp6QndTpffOEpF2t/j5OyAXkYle7hJ6hJCeEqYgEoJ8ADdjJoNgooiK
x2ioBaD+xgUZ+Oeb5GURNhx8VPMnsxCjcNicuBBJuYrA731gaXNqsueT8EAZ02vo
yoTGkIRSnzIbamvqs1mRV4yZ9CAQBbSpJNcTqOaTauJhCd6cZ1eAnzBWNb9B5HRz
pt12hFPW2o1anGb5HfCkjedPBc8z8ibmIEYGyBV4LLHFrWvGs2z23LOCvb0//ijZ
xQEOzpPcbflY6VYhXyXZluwT6K0izygVLvtiR/lYYAvMQEE4zajFX8H0MNBZ2f/h
Mq0dHEg1oNy/Nr6g7pMl0ErK2O2+s64kzbcTOIutCTCLaKTId4doHnn5LINQWeUa
NouYK8BCTKKujR5U4kd7wCY3vxvRYTtNeVA0WBDLsmvBl4qzS9MxEosEYJ069r0M
elm6zf8JCOH3EUbD7y68hEqbCY3eDCs7a4XQoy2oKaci1GhBnuIrWOHGkOv1QNly
oDaC6ZpvJufR4PodGmYbdIX2Vc+VtzvLFNzBa9ad34fi09alC5KLWwgJUlDd2DHB
NyqbYNSNG1FMONVqOFDsyD4EXL/B0o9MZVrWrzaz+nK9VjoRAtZwKoXE6dxYaG8t
JynvRKq13lEUefnpX89gHom1H78BR/g4jCBPIDoDX0C0U9wtLSQ=
=DFDJ
-----END PGP SIGNATURE-----

--1upon9EKclLYqctJ--

