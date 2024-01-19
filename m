Return-Path: <linux-kernel+bounces-31625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CBB833168
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4B1F2336F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5759140;
	Fri, 19 Jan 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nqjSpM5g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33855C22;
	Fri, 19 Jan 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706353; cv=none; b=XktBvyDj6kineLqYWsa9G4RiIRc/WO9La6HXTCDLTc+0cnDyqArByrjB8LFHcGw4tP/0/VYoNTnmxudVYrBijYF2x98rukixCdX3am3pkbRvDpj4Zmo8TAIEkL7gb91KY0WOLXPCWTcd0uLIRFm4p3kmvfYQ634189O2Kann8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706353; c=relaxed/simple;
	bh=AnVBsugdrJOJKoBFxn0hA//u3IhVicqISHxvAkkrAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZuFFlkyRiODMekcXR4QbqnJnlFglc2QrhnKuUB0tDX7RBK98QMLmtumm3IQYSnBeFeZsYEP6Fi9t0zXnyklhCdbsPtlSG+uA0yWEcAkVuqMsXuWp6WsFfXZdrpiYoJVaZsTngvOSd1AK4z++JG6Pwtj2ivbD+vQ0SO3GI1QDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nqjSpM5g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705706350;
	bh=AnVBsugdrJOJKoBFxn0hA//u3IhVicqISHxvAkkrAlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqjSpM5ghJN+LLYcQhBSTgswZXWQ153FMUX9SeBtEwSuVWArl5VKq+peQL3F1/i1i
	 tdETI8PqgR3UmO//6wbtNLDY7sESHVgHHZga5u/jFyZa36MhV9nzz9oEmjqRW2yR06
	 0SLmXMUmnO/dzo3LocU1DRGwKh+Nph80VD4remEa4vHNzOpwvnXycjRwpHSIiXzwpL
	 rzjIu4VhIjOBH63c+W2eV9+I1TMByMGITWVX+lSiXtq3meCQetqv5gcpeCnT8rmvtR
	 WMGjL/XoyjxTjBNc6y2b1jpMN0prGFBboF4d0ym6t6OdCRS2Oo53dmEt9JkLrPizjn
	 ihe/TPr5YL7Wg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2F8FA378143B;
	Fri, 19 Jan 2024 23:19:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 940F610609DF; Sat, 20 Jan 2024 00:19:09 +0100 (CET)
Date: Sat, 20 Jan 2024 00:19:09 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [RFC PATCH v1 0/7] Introduction of PSCR Framework and Related
 Components
Message-ID: <7gadkjffeljjwb2cgcmg6ixco3xtg4t4hrxtetfnjyzuxvfsjt@ze7u4glqnerb>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yynn7vmbrmtxc4wq"
Content-Disposition: inline
In-Reply-To: <20240119132521.3609945-1-o.rempel@pengutronix.de>


--yynn7vmbrmtxc4wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 19, 2024 at 02:25:14PM +0100, Oleksij Rempel wrote:
> This patch series introduces the Power State Change Reasons (PSCR)
> tracking framework and its related components into the kernel. The PSCR
> framework is designed for systems where traditional methods of storing
> power state change reasons, like PMICs or watchdogs, are inadequate. It
> provides a structured way to store reasons for system shutdowns and
> reboots, such as under-voltage or software-triggered events, in
> non-volatile hardware storage.
>=20
> These changes are critical for systems requiring detailed postmortem
> analysis and where immediate power-down scenarios limit traditional
> storage options. The framework also assists bootloaders and early-stage
> system components in making informed recovery decisions.

A couple of things come to my mind:

1. Do we need the DT based reason-string-to-integer mapping? Can we
   just use a fixed mapping instead? It simplifies the binding a
   lot. With that the generic part could be dropped completely.

2. I would expect the infrastructure to read and clear the reason
   during boot. If e.g. a watchdog triggers a reset you will otherwise
   get an incorrect value.

3. The reason is only stored, but not used? We have a sysfs ABI to
   expose the reboot reason to userspace since half a year ago, see
   d40befed9a58 (power: reset: at91-reset: add sysfs interface to
   the power on reason).

4. Available options should be synced with the list in
   include/linux/power/power_on_reason.h

-- Sebastian

--yynn7vmbrmtxc4wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWrA2MACgkQ2O7X88g7
+pqqxxAApPpXCMedUU7kOCntJqMLZ2NYWmlTlDiWtgZ1oiZyPTFblTNj052kj1ha
QfFMuwMYVUBOdo3uNUOBx3WGDLk67FPt2soIii79r5t2tXvyhF2+htyUbaIJIgIn
mnqHiaACqdVAMOAjYWMeiy5kTvYtg3ObVuQjhS0WUXFoYsi3ahdHIhvuAp8RBMja
5z0OcA3/p9UvF1jqgxHguo0iImDgCqN1hTOkeOne4KIxWbnrKGz0isFCWs7MXSy5
cgr8AiBJUgabH9Fap8AHR7ejY4M64A5luchfFm/vcRMGa0gW9+2fOGzV90VYtCDT
POEZ3JS+iohk8gAXlDAwLPMqB9xjTX4by1AfneJGP2hAzK/asrbmYrJGKcEog7Kk
gnWMM1WEFRe1dgjJbyW8UNWbsR2YAuB1qPw2n2BYRJOmzV2dAjek7PhjuuC+JnNH
Tk+FkPPe2B8H9pWjMxyDmcBWsxFFFwB6CzmgT59tlPW3Rs+Hned7QoHtG8WZlSMi
q3UTF1H4hTHVo1mGYse500p3jtGibOd4uiUgGYSBsoWfOnOGGoDYkQ6CAHN1Bp34
w0bcqEp+JnqZUB3INzhi04LS3ITZEb192dUp6eaYxpKmSg/1y/u2kVRSFbb1PF1r
ST5BCWNb3z8l3j00dBmM/hu4KKa9E7bzyYLbTOOozpa8VMJS6tE=
=l+0N
-----END PGP SIGNATURE-----

--yynn7vmbrmtxc4wq--

