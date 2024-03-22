Return-Path: <linux-kernel+bounces-111906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A053B887271
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391171F25029
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421F260DF9;
	Fri, 22 Mar 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+gO5Ljr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6060DF7;
	Fri, 22 Mar 2024 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130443; cv=none; b=B79zUbGmE9CeQ1c602AixsW7+zjspZIEdIrm+X4PP5y4qhrItZ2bMQ5Z/0u0LwCcUIJxywNvAz38yUBT8mcsO/fn7/bVeCDw+f9LHvfgxuFV+qPIgaLmARaqK9bqNGyuNZBO+oXDptbIRJ6kTTjI0le6beJITc73zfV8cG+5epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130443; c=relaxed/simple;
	bh=g9Iyt0g4iUXGAQcOoGRDJSNpVdcT6pD1rHESCP3EsNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agKR4exfowzlDytzLH3SOj7GEPXtRgVWf9NqdkSwB2qd5NVcdmHDw1SSpROl1mELK6TryuKrCNLhjuiiqA727g9DEpyz2/KDKX07hro0m3zD1oFjngSy95AC+jYUpraZxMzPM7jptg/906nIe4fTNLiEC3vwoBIb4If2/X2MTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+gO5Ljr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E043C433F1;
	Fri, 22 Mar 2024 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711130443;
	bh=g9Iyt0g4iUXGAQcOoGRDJSNpVdcT6pD1rHESCP3EsNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+gO5Ljr/Bf1h4I0MSugrfaYWl1wCJfGf9RhQTMSoG8sJkNmF8tOnybyGxthDEiUb
	 //lzM8qLFGc8UOe/pV7WLzwAHwgKOfTLPRkOQ6okD1SSvgfb+AVvgO5S5FmcoKPxNO
	 Shr0sb+tMV4Z5BV2vd6VAs8iQ0Uy4t/g4RLMi89IWyOhNj+U0vP3D19a7uBsurqMoP
	 jx4nTkDWrFyBDYJ03jaTw+Ys6hVC/7OMC5Tv41tCRFfJuj4I76yPMtNkhWNF0WzS6P
	 Ou/E45F1SQWD2Isvlzwd6ex8KUykLlHRp6jZFANMoPsP6xY02HV941wWcTvWdk44Wg
	 oGIx64k0BH5tA==
Date: Fri, 22 Mar 2024 18:00:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] dt-bindings: hwmon: stts751: convert to dtschema
Message-ID: <20240322-swinger-unselfish-8e36bc12cf79@spud>
References: <20240322-hwmon_dtschema-v2-0-570bee1acecb@gmail.com>
 <20240322-hwmon_dtschema-v2-4-570bee1acecb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bGPx4mdUKjkLA5FN"
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v2-4-570bee1acecb@gmail.com>


--bGPx4mdUKjkLA5FN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 07:45:29AM +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
>=20
> This is a straightforward conversion with no new properties.
>=20

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--bGPx4mdUKjkLA5FN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3HRgAKCRB4tDGHoIJi
0iWWAPsF0UuXl0/1wfe0ENaD/RuvprK3ML0fGOVBkNQ4fbTH1QEA97q9xgWqriro
TZDPzIK22sIByFav6M5rmCkkDnTAUgg=
=Hwbs
-----END PGP SIGNATURE-----

--bGPx4mdUKjkLA5FN--

