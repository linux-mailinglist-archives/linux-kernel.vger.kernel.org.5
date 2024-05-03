Return-Path: <linux-kernel+bounces-167152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02998BA4FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92B2B2367E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DCF510;
	Fri,  3 May 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQrYFdbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B816E541
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700467; cv=none; b=DtdgnA9s0/b/D8Vxc+8lZXqG9fTSEtH2NTiTIMW4YeNrTANR2i3nCQLtu2KB1QxTM/xj8khwDUDc3UFbV86A22Agy51fbRqnwOS+18YEACq0+ScTfH6EwnLepG7PMmfzACRQX1RaQx6vVuPBcbsCliFx/XHC7NCgWOllq3MXpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700467; c=relaxed/simple;
	bh=IGq7YAK1DyJEdi0gyI8AFsujwGjRxsNggeBJbUDhPHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaQYhHADpzPkV1mkgM7j5o3vOKdDye+CRRR0uItxgOnK2Y7XAsTXAjJTv19L6ib1B4qeNPOQvq9quIkWSQjaIQ+BbcOF8MCyWtVGcKwiP80o4TMhzIIP7gB3WDtj4VfS010yaUM3JK0g23cxA4VRnBdzXVFN7Nr6vrL0qM4AWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQrYFdbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C4C113CC;
	Fri,  3 May 2024 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700467;
	bh=IGq7YAK1DyJEdi0gyI8AFsujwGjRxsNggeBJbUDhPHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQrYFdbwGtgM+zHoTX5rdYIXT0pM8vKbi94UG08dXoxSqtMQPO8UUwVCpPVqzJf3Q
	 f7z5tKjIQs30PyDXbpVZlrsky70GHoqo15ai+Eput/SV43Rpd0JzXB3ssRJKT2gqvO
	 ZH8a3S6ADD7Vjwg+8LDtbxXzmdVgnFEmZCNvFACNBvUb1DTdCXznGZ+/idu0QrgPlV
	 Ci8YOrQAmtrSh32FfzUc5y1Ot5fMpPCUrqi8a2STDNCjABxch8tDm2qwaa3hP945/y
	 N96C3wVmYeXC6ulI5qaTDzrPl0cLHxtVgpH6gEFVuVY9fTbAJW5gAJmRQLnTea7eeT
	 fXhZtcjDlLIBw==
Date: Fri, 3 May 2024 10:41:04 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3Pbxy3XR/i3izJR"
Content-Disposition: inline
In-Reply-To: <20240502092614.GA31518@linuxcarl2.richtek.com>
X-Cookie: lisp, v.:


--v3Pbxy3XR/i3izJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2024 at 05:26:14PM +0800, Alina Yu wrote:

> For the fixed LDO Vout, it will be set to either 0.9V or 1.2V, which are outside the range of 1.8V to 3.3V.
> The determination of whether it is fixed or adjustable lies solely with the user.
> This modification aims to ensure compatibility with the user's application.

That's a substantail reconfiguration of the regulator, it would be
better to have an explicit property for these non-standard fixed
voltages rather than trying to do this using constraints, or at the very
least have validation that the values being set are supported by the
hardware.  The code should also be very clear about what is going on.

--v3Pbxy3XR/i3izJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY0QK8ACgkQJNaLcl1U
h9AG+ggAgPDHwSBgOVlPGTgUQMeT5eYCmBzi9FIfmdiPaU88tF2UzX5hGzI0RuvB
ntbNtCdIrgaF9Z8n4V+xIYoUhBK53+8+rNXR9YtAjJvK8DPhKLfH0dyEYzUl+Akt
i38SGrUUfHcS6ZCWFCeK7Gvm3eE5yEIkhkG+rwhivnWiJOpx1HgUGO8Rz1gZbeyc
0/W6upAeHiSJkwwTYeWS2OBcS1aE/JV/+4BsW+gEmY49QZ83BeV2+00q9M/JInr5
mugnyUEc9aMaaTOkLZu8F3jzx4ys9nj3i+B7O/aXDDqjOqFFgxOC2t2Bg0bd6AKE
0/J8trkNef+nN15GAWLn0MQGepvTUA==
=E/Hq
-----END PGP SIGNATURE-----

--v3Pbxy3XR/i3izJR--

