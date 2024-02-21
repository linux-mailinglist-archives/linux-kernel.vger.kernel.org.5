Return-Path: <linux-kernel+bounces-74868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5E85DDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD8C1C22B94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552897EF02;
	Wed, 21 Feb 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2LFNHlc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649C7E0FB;
	Wed, 21 Feb 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524453; cv=none; b=E7C4AsUJt/l8if7oyRp2rtGbKyOPmDzCDWeiM+jFkhE+VsFksiTgtmjqtK7se9YBoD7FG2Nqtc87E76IPuLgtag1W141pwGjJ86t2C1BxaAXmWeT4qT1+ipImDsN0xzzhp6IRvurhVEpuiPTwMozX/Rt4kswEWQNI98XCAqNS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524453; c=relaxed/simple;
	bh=qmJW8whAXUkhIPCspwjZxuCcU6XkNqDNH50DqgXMmZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq+6+Gdq8iiDFloGv74+ng4rECLA1nueFJOWqiY8kKAWZ/27mZz93+TeCVo9bXLAAe7cWZauOJTU/zBM+gpG3YrEBF52G1fTr7ns3K274ouiNy1erGAnXQSg+WxRzwIikTWbCM/bMn8LEY89uW2TdqJP01JOlwZphFOHL7oL4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2LFNHlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1636C433A6;
	Wed, 21 Feb 2024 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708524453;
	bh=qmJW8whAXUkhIPCspwjZxuCcU6XkNqDNH50DqgXMmZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2LFNHlclgXiP9voi/okjMXbdkz2R6A9d9dLGcKb555VBY0L54nhGiNxbth+9qBFG
	 4vjJqgkGUalJ5lhknewu+yI6udR1aY3PoR8VQn2v/keV6x3CiZ+F97g01aVL6P3deQ
	 7u0CsgI7vRtKzvYliwGydT6859SvLI5H51ioVrR8QoN0g4zRzoounr/qgq9fEo4gZs
	 gbLoX2cG+KJldwP8NdiE3j+AbJr1ixdKwzt3W0SS3KmIJSyEcoGF+md8nyXT7lJbok
	 Fa+Vn3dv+SWeN9ufxJj/9y2yeup2y9qiB+JZQE2Jttn0RqAKUr/eJNyl2esQvxIXCR
	 G5NLgzaP+Rtyg==
Date: Wed, 21 Feb 2024 14:07:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Message-ID: <7fe52cb9-12b9-4b03-8e55-08e59b4bef27@sirena.org.uk>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
 <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>
 <ZdYDJPe1n5-V-AnT@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TEIgUKSt5HT3FW4P"
Content-Disposition: inline
In-Reply-To: <ZdYDJPe1n5-V-AnT@FVFF77S0Q05N>
X-Cookie: The second best policy is dishonesty.


--TEIgUKSt5HT3FW4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 02:05:24PM +0000, Mark Rutland wrote:
> On Wed, Feb 21, 2024 at 01:59:03PM +0000, Mark Brown wrote:
> > On Wed, Feb 21, 2024 at 01:52:38PM +0000, Mark Rutland wrote:

> > It's a good point about the sorting, though the file is currently mostly
> > sorted by encoding rather than alphanumerically (similarly to how
> > sysreg.h was done).

> Sure, we're inconsistent. I'd just prefer that there's *some* local ordering
> here, as the patch is neither ordered as above nor by encoding:

I agree, I'm just saying that if we're going to fix the ordering it'd
probably be better to go along with what the rest of the file is doing.

--TEIgUKSt5HT3FW4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXWA58ACgkQJNaLcl1U
h9D0bAf+JEaDy/BWJDe0Bzp2tRu5awCFPXQS6fLFsyz4F/DJoeoe4y8YGJKpKPSH
xfPPXphTrwYdsHpA0Wvopx+3Iq0XgO+Rh95bqOHZR51FhUPXdyVitTyX77tEpulP
l9k3pbNrCsQAvhUidpFayTOTNBbCPMz7eNsdJnN2YWgkIQd7oeo5kOpMt9nYko67
ZCCztKzixFFchguhixQ/9GAEd3EFwQD21ii1QeTAglBsArHgT/5BcRCcamV22c8u
IfKJzwshFpE9zL9VeS65Fbw8If+Kzbs8MrQM1L3OSex8FTG4GLUMEMETnbZm7l0b
xz3fAXuywvCf2pBgE1KLMdRQk+2DnA==
=bNoP
-----END PGP SIGNATURE-----

--TEIgUKSt5HT3FW4P--

