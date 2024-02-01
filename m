Return-Path: <linux-kernel+bounces-48137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123A8457DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880291F258EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1A5CDD3;
	Thu,  1 Feb 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU06cK6/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFE2135B;
	Thu,  1 Feb 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790674; cv=none; b=ohOLkJSSvvzHwAbqp8OOYwRlHdUQtkpdDZ3qOBoFeG49MyZ5AH+IbjlfrjsHjNrQGv2OC4SPHMnqWl8uiNfDGBONC/QGLAsU1VsnROZ2/vWkwcawkXxO2q5CKQwYqIRpRFxdkGNqCR+mnHD0L66m02yPp+gRau5d5W7bebIwDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790674; c=relaxed/simple;
	bh=E4A5iVgzE715w//0CLgtkuodzITNIqD3Gz7PVnBh6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRREpvPs8mLKWR7GyZSRFyDhzVhPOHod20FhD687A3+bGRfrE+89xVY/430x7SEqG07snSO/EnuLv8yQnqs6HF83wyuotM1tq6okXBobgE9P0PEJi0D+U4vgqhFR3bpliyyQS491WQIdQEx4dYA06clBwuItyZnxe+TsU/B/Ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU06cK6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78931C433F1;
	Thu,  1 Feb 2024 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706790674;
	bh=E4A5iVgzE715w//0CLgtkuodzITNIqD3Gz7PVnBh6zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KU06cK6/KJppk6C5DXCgRbg1tp1NHfzoP7v8JNCDbSrsBCiCe4mQIY68WxUzAfgQD
	 3ek8+x4ofpQiuNkFaRqCHIvI8WfbENNBUbp2KRqgSL2JUfNmUvRMD1KoyeLhRI8O8c
	 5Ywg58ONGGezToU/D1im0u4OiT6MkodmcyP9QdW2Usb8/+0tVWd9pX0PLiuDgEzp3V
	 AFGRz6nSkzQTW7ROALNurhfindo+YAQmOMPuFL7s32w0LI8wWVvIUteYSoTiJZ/8RY
	 phkN9ziIj1ROCTTj/7OBVU21SkfOQEV+1LqE2LPLgxqdHHJvghEcf46Blg1H0ueDXw
	 PGc1RT3Hvh8iw==
Date: Thu, 1 Feb 2024 12:31:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, tiwai@suse.com,
	Fullway Wang <fullwaywang@outlook.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, fullwaywang@tencent.com
Subject: Re: [PATCH] sound: soc: wcd934x: fix an incorrect use of kstrndup()
Message-ID: <bf3ffc3e-c786-4d52-9204-ad57e1dfccbe@sirena.org.uk>
References: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
 <170662942110.37296.1277489815994094565.b4-ty@kernel.org>
 <dde96dd7-eb33-41ca-9b08-3a2788164d02@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QR8WRBmfgmn/QwRS"
Content-Disposition: inline
In-Reply-To: <dde96dd7-eb33-41ca-9b08-3a2788164d02@linux.intel.com>
X-Cookie: You can't cheat the phone company.


--QR8WRBmfgmn/QwRS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 10:04:23AM +0100, Amadeusz S=C5=82awi=C5=84ski wrot=
e:

> Mark, my other comment was meant to stop this patch from being applied ;),
> perhaps I could have been more clear? kmemdup_nul() in this case will copy

Your comment appeared to be a complaint about the existing code being
bad which sure but not a blocker to a minor fix.

--QR8WRBmfgmn/QwRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7jwwACgkQJNaLcl1U
h9DlAAf/Zkwb92UAMo+KF0xiS0ypCUfcY7H54ga9UK2UMV6RT3C/R/Kt+2N1bC/j
rq43Inynq2gpcVx+iL77Rjpfx7jKMjeMruG8nXQ5vwn44X8hGqT3Xes4IMpNrG/K
PNjKmgjAyM1cQ/y0NxXpA7CoQuSMnMZ6VDupwkMp6RNs5h9Kngf40spTLc9n15Yf
Z0eKgvR/cTfGlhtLgtj9C06LmmFV7mvk9px1ffUg0SLMaLBIJmTYyO0mFoy1TPtw
SsmdiyTJ4VzchWwOgBBBQiHsOGHC1ePRaGqj2F1g3gu4OeHSzncWr4YhTyXeHiS3
jRQGOxrEIe6bh0DTo9bgRDqEhRGRjA==
=HfjQ
-----END PGP SIGNATURE-----

--QR8WRBmfgmn/QwRS--

