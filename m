Return-Path: <linux-kernel+bounces-31235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B5832AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EAD1F23F92
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172D53814;
	Fri, 19 Jan 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufaO3X1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA9537FC;
	Fri, 19 Jan 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673247; cv=none; b=bpWLyVLihjVHwX4MZLWmJI2mW68BtpmDwDejrho2exmtPyng3j9rseOLqDbtn9CW8xTR4JaeM6fBGUc5bEnoCFJW49cTQP+wPQtQBUpJcVUDokZGHGT9elo+G0vxXUz0fR0Gq3P0T2fKuJCc6t6v54D/qi6lAb4Vr/Rcdwteo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673247; c=relaxed/simple;
	bh=mC2DXqdjEQC66exVDQPqaBRO3tMoWAaPPIKH8mIOQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owh6JKaec6KkoThyJz1zkhzBEeZNiyu52SwEHKGQJffRcuOF6go5WSsyIbvMCbiEkxf3R9FM/1314r3qKyBJMdCU3jOelcMfrbVsZStDkUBL9TfzVY9UlmsBnpMmNY6vOYs/i+39AhB7gfOJZCMSocekYlZyliP88SbSXyudTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufaO3X1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D53C433F1;
	Fri, 19 Jan 2024 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705673246;
	bh=mC2DXqdjEQC66exVDQPqaBRO3tMoWAaPPIKH8mIOQvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufaO3X1MTWwDkyXWZKBoxgKn7aCg9nHlDWZjGZKfGaY6vrsNjBFSeiNYXa31tAviv
	 7pIX7VMk0MJGBy8mIJ6sQqfUY77RBPB55RDba9QD3AAYXNXFRgoW/I+z6DIeJYklbt
	 43ZskenGMSJn0neHKZ95l4Ms2joUjgufrHZMxn/hMR9NI26/jk3Jx7sUbVZxkfeyn0
	 /v+QtLv2rNtLWbPWaTE0pDIcZQXMgzMfkhiyndYRQCU7vO0YSS5LIu/nO6wEVMk9PB
	 v+s5j4xem+XNmFvxJH1RnjqSSqX/RibEZQnGS1IlctPul1z9UFREEzGFCQ1A5MqfZt
	 zT+zriz43aK0g==
Date: Fri, 19 Jan 2024 14:07:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [RFC PATCH v1 6/7] regulator: set Power State Change Reason
 before hw_protection_shutdown()
Message-ID: <ZaqCGgd77rs3yq59@finisterre.sirena.org.uk>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0ELjM8ZH/7s+wG5"
Content-Disposition: inline
In-Reply-To: <20240119132521.3609945-7-o.rempel@pengutronix.de>
X-Cookie: You might have mail.


--Q0ELjM8ZH/7s+wG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 19, 2024 at 02:25:20PM +0100, Oleksij Rempel wrote:

> Store the state change reason to some black box, for later
> investigation.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Q0ELjM8ZH/7s+wG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWqghoACgkQJNaLcl1U
h9AqSQf/efBnzcrtjCJBKoNUTCFbiQ0DyNwDETiS+2ZruZjaSBcs7oxxPMuRyjxR
nKcdtnG+U7hx1iD7o2hEJbTkxELEg9Zxf4RYfd9sIgzTA4KfuVRrsGd7AAqFM6hS
/2bqpyennzYcbcom8RrNC+CLggjskFNS5W/fICtswq2L3dOrJ8IE7G2FKzEezWAH
FFyUQSYM5TYee/Rnl/upEpmJAt0tgrshue0MSRfCmpL6WbmZW7pJhIzlDOeVeWKy
CXQywnBxVMHyEpch/2DqlqWOUQXHLYJ2us1pLmINFt7ybc5QjAxZWhzL4T4Hj6Se
pNFoMGrP2Vj42CPLvlPCv/5BNQcSew==
=7Tuc
-----END PGP SIGNATURE-----

--Q0ELjM8ZH/7s+wG5--

