Return-Path: <linux-kernel+bounces-18322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B20825B89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF81C23543
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C43609E;
	Fri,  5 Jan 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBE0tVst"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58A3608A;
	Fri,  5 Jan 2024 20:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A241AC433C8;
	Fri,  5 Jan 2024 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486211;
	bh=PkcN2ihSIABo+ff9pBaTl7f7CQyvSNcHmHiCSRdPILI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBE0tVstwRQZzEgx2TpLnt8egBNvIGcSyAbSQL0n1ApRitECJjcQV6dE3tlP+i/Ql
	 TGd7Cw0ffituK6zO+pBsX86qfiSgyL1XGqz0tAWrxZXV3Cku/A4ud0qPWJa1+eK1PX
	 9qsT4nE9bOmjN2oF4DsBH8PM/TZ950/e0TfI7EJIOwChHSceRz9hVvsJe4S2dQ/QzJ
	 xLUeSdLquFgpWBdyHs4bTrZ0bi7pmtNmk/M2ZBfs30u+T3+bp4hb6nttcNxLBWMvSr
	 2ByvkFdM3b3dbHpaw8rDh3WqjEPkCI3QY+LHqhLgUIjieqmcR/Hkj9m5S8WuNTHaqN
	 04o1AxqVZmt2g==
Date: Fri, 5 Jan 2024 20:23:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: qcom_smd: Keep one rpm handle for all vregs
Message-ID: <3ccef53c-3333-4d1c-a3fc-32b05cd473fc@sirena.org.uk>
References: <20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org>
 <b5a2f511-2758-452d-b6ac-399262b3734d@sirena.org.uk>
 <7271846f-c03f-4d0f-a54b-7424ddd72724@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okGAQarU2f8A9pZu"
Content-Disposition: inline
In-Reply-To: <7271846f-c03f-4d0f-a54b-7424ddd72724@linaro.org>
X-Cookie: Your step will soil many countries.


--okGAQarU2f8A9pZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 05, 2024 at 09:15:49PM +0100, Konrad Dybcio wrote:
> On 5.01.2024 17:31, Mark Brown wrote:

> > It'd be slightly more robust to have a check here that we do get the
> > same RPM back if the variable is already set, just on the off chance
> > that something changes in some future system and we do end up with a
> > second RPM somehow.

> Knowing how improbable this is (currently RPM is responsible for almost all
> power and some clock rails, including DDR), I'd say it's excessive, but if
> you wish, I can add it.

It really feels like something where if this was a good idea we'd have
an API to do this directly rather than passing around through driver
data.  The fact that it's used for all power management doesn't
immediately preclude having two instances managing the power for two
different bits of the system (eg, a low power island).

--okGAQarU2f8A9pZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYZT0ACgkQJNaLcl1U
h9CkTAf/SyvlUQy6c7giS1ICGR00AlRStxV04y1DY4uwCc26V1lL2TX7UNC76a4m
KMqlLOQPh5DN3EqASjWGqjEXfbzR7/imN6WX3SoJL2oITruU4Gm1UXL6jgl6Xxtt
yscAy310pvsZD8BVMI+wAossXHfcw4W0zBzkhoVGtxGvAhxv4S7sXMERXZnXmLbC
4YpqzHI2SQ8ak9oSD449wd2DtEe3IInLVfbBmMJjqXp/BPUdJqYysfHBQlCFXzx7
+Gnzq6hraUyxMeSq7XYbttewaRKL+zR+xGRb6flJV18/9z/YS4Rpi+pIJGJn4plz
sCtCPu63pWdjy5MGqEcMPCJ6Imew+A==
=MjPg
-----END PGP SIGNATURE-----

--okGAQarU2f8A9pZu--

