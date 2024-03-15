Return-Path: <linux-kernel+bounces-104483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD787CE88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB861F22632
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E79374FC;
	Fri, 15 Mar 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO1jshuj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FA364D9;
	Fri, 15 Mar 2024 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511861; cv=none; b=HvD7A4+C0MYBoz4BQJ/yoOjB3q22qP/pIMehky/PwDYf4ipJAqorMEkFUH0WfQkpL1nDHG1sUQjULFhDNLLUYKJZvB6c87Kai/7tnN9M+Fw8RMYkFRLVRuC9FQt/7wRp0P1CBkiEGiINCxUfZvNUW/wlBLxAEvsDqnhd/TqONiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511861; c=relaxed/simple;
	bh=cSKcgQGBh20ZPUHLj2EAJ/ss1NKMNE4QqnTTiZmJLD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNNZZdT5ntllZZbSuN8L92EzR8T2lLRrv+9Q3Huwo3dr/dAd8OkrsQ8LVF4ri98O6lj93258LcqdPknxgB96fQo8Op+H+Jk9FlbpnOetpRCxwDKAo7I6W3GwBtiDOPk1azvUSjMfAX42El3Lrqfx6UU6MvZBs6BSXGUzjfNxguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO1jshuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371BBC433C7;
	Fri, 15 Mar 2024 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511861;
	bh=cSKcgQGBh20ZPUHLj2EAJ/ss1NKMNE4QqnTTiZmJLD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QO1jshujASEKiNLMcI1DJqNOpH9QtkNvUXpUB6LNoScSsxelepVChKq5FWXIWPX6P
	 LV+Sj0EoQ7+rMkX1y2E7JT3yb4nSx4/mQy+ao+lsqdLa/qsRojTeBi3ZBDNY1hhetz
	 mjV1caKitMry2KtiI/239jAZsNMRNjGiNJFffZRUpmyYJzI17eq1UphCKS5n5uUq8G
	 RO4shcxApHQ3zZc7CV5cKbUPiBTAHZMlT4fAnoJoRv2hhFo7I5gxDU0HbjMghzCeyZ
	 F28MQsmgk/C4VUPZR1MY+H1x8cFdK/Fk7Y3RNMvQuJhxxfppL1m83O0CKiVDrKJu6D
	 jzwWHCyT1ib9A==
Date: Fri, 15 Mar 2024 14:10:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 10/13] ASoC: ti: davinci-i2s: Make free-running mode
 optional
Message-ID: <b8645e61-2a3c-4aaa-ba3a-7c492ae7c6ed@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-11-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogBFfzYzRWRHlUNe"
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-11-bastien.curutchet@bootlin.com>
X-Cookie: A well-known friend is a treasure.


--ogBFfzYzRWRHlUNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 12:27:42PM +0100, Bastien Curutchet wrote:
> McBSP has free-running mode where serial clocks continue to run during
> emulation halts. This mode is always enabled by the driver.
>=20
> Disable this free-running mode according to the 'ti,disable-free-run'
> device-tree property.

This sounds like SND_SOC_DAIFMT_CONT rather than a DT property.

--ogBFfzYzRWRHlUNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0Vu4ACgkQJNaLcl1U
h9BndAf+NWs8zav3YqeFZOANYiZ3y1vsX4faHjK5ItpsqFTAzG6Q8iv7WPoO4Kkp
Zmp7XSyCA7Q8F5KL/uaLt3jJ00JJnsRd4RO+efjMpt6c1EIQFxnQ+8DC4YAAZXo/
E6/aI+2uJeGWo6sdhvtgoXI9LKP+MMhRpaeQwEa1vS3PD2wisZHx4aIMvZExRGX3
6/i7hzU6kAykhVIA1wsMJGXW6rgtro1R2oIg9Ut5/ps+JaDdDOTWAf6HLqRemHAg
YISt4xrmlRMcG38TdC5/WHGwh19mFfu8AdyXQa6AZwNuX2wC43so5Np9/vdwpqqd
bG1nVwSPOtq79c5j1Hjk6aOuChRW+A==
=02bW
-----END PGP SIGNATURE-----

--ogBFfzYzRWRHlUNe--

