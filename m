Return-Path: <linux-kernel+bounces-43170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB065840CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D134B2306A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D3157E62;
	Mon, 29 Jan 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8UTZ+/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E4157E97;
	Mon, 29 Jan 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547665; cv=none; b=mXYMXGrCQlepWj1V365WnXPDmX0z8jzZC9dOanIf5I5ADL/OEz+EICR6r7mUG5M45qFXMrpbWRQIm7/ZjA/XxwyWkav0SzB3fJSznXH7wk2DJIMTvM6q8Ih/UbLlnGOYvKc+nTejYSEo0RzZ3vJ97QI4/3B/oinv3ncES6FNzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547665; c=relaxed/simple;
	bh=zX+G5kuXDX6v7AJY4fAgwDHYmmNEg/NxKfWc+0bpSx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmjUlhqXM8t3sVDQF3VBNpiY10qXTpGSHRmnTkByW7rQqIiJd5EBQhynXcKutocfQ7/n1rlIrifCeKRqoqa9bWRRufcQ2qrRo1/H/y3R6bPhtK3dB4anlRR1p+aOKF7G5tFR6lu8PmkP41r6Hy7g+WqtbYs5a8b6xvs7oWqCn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8UTZ+/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB8C43390;
	Mon, 29 Jan 2024 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547664;
	bh=zX+G5kuXDX6v7AJY4fAgwDHYmmNEg/NxKfWc+0bpSx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8UTZ+/sskXRDBnUhW42YrouT9Je9Hh6LtzcpIyhUvDHPVpSfwbHin9uWa9vkx+zn
	 qaXMieQSB7dBLL6o1Xz+4mz6kLgiDNbjGNlILalcENijGko9JVR/T0+3PCY7zBCVOW
	 GXwK2BJY1hMT/TDhv7TXjOJQuzlsgKD4p2h+cNqHRUDUmEp3thedtNcMTR+FN718aB
	 RUs+J5omOmaEVLl8b6RjzDMmzW+hUbzVNeOQ2pkbAZu8GoUCG44uIRUCLHFFCpBYME
	 JOwuKq6ORXd8j2lfvB0/GITqN4ywvquwTA7dkMXvC4Nbnq5dyLyvyuoECZwb5gAKYn
	 OQuyK9pfj0z1w==
Date: Mon, 29 Jan 2024 17:00:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Message-ID: <20240129-unelected-frail-b6062f091625@spud>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sFGmz0jIHMmay47B"
Content-Disposition: inline
In-Reply-To: <20240129101433.2429536-1-xu.yang_2@nxp.com>


--sFGmz0jIHMmay47B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--sFGmz0jIHMmay47B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfZyAAKCRB4tDGHoIJi
0v9mAP9ztQbdr4n9L1KbI6eS4QYA23fNGhj58popCCug/nQk7QD/QfzUlFo6SjCy
gIKZqDJG/EnKMGDXtlRuqj7KADkkswI=
=Ctoh
-----END PGP SIGNATURE-----

--sFGmz0jIHMmay47B--

