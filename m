Return-Path: <linux-kernel+bounces-65364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F8854BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378CF1C20ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBD5B1FB;
	Wed, 14 Feb 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHE0dX+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AF5577F;
	Wed, 14 Feb 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922327; cv=none; b=LJNNaM5g8qcLUxjJ18upE79ffr0LObGghbnfAZtQNRpcTJGozNuOgISCeDaSJs/ZQyz2CjEJpxlreYsLeUmNJ7ANN+RWqxSIXuXLTZmXD79NfLevQim873/dmrPhGykWrf+xAGIEyDTmfCrvcB0TrdAS+pzxh4wA1Bi4oZGLw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922327; c=relaxed/simple;
	bh=I0eAAlECfeTaN649JnEiiOLMrTwEiRG2rg7sSeVXH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS/lTC0jMexXviCmjhXhb2Qst1VBju3ky2lD4V7ijzf+ERqnm9lzllWCvGCypHK7TcOjfBtUn7CYbhgFn9A2oddMZJ2Clccb2M/hYmiTalpDfgDeHgEqZRjNl+2x8U19U1e2EAqBzxayorA8IBSnQNpxawxapek+dC1BQmJXmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHE0dX+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D86EC433C7;
	Wed, 14 Feb 2024 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707922327;
	bh=I0eAAlECfeTaN649JnEiiOLMrTwEiRG2rg7sSeVXH6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHE0dX+1NWdZjJ3Wc6kMUff8ROj10kh1ldTsz4rMXHGcMWjk4fd1a5Zx+gD7m0TAA
	 fb8nskoekknsf7u788zNCD03oM2sTc4fl98vv1lq8cGkC+5WCZUvk/X+hzucCVRA6N
	 ZquQ0afhLLiT0juee4HZ7whJvvoR5sKFUuHPhDEDBFIIeoLMQbBjQ2RrSKMofB6ZTK
	 nZWgpUSFky8bLKhqi1PX0Lq1jM4LHdmpQcbxjPCygVrB3U+LtelzSYSuiY07GIsyoo
	 Mn+V4apkL/S09AlMS5K2HftXdqkJzp0KMqV779WVPIOtK6wtVEtCabch40/2YQ97mr
	 IxpD5eNM9LvbQ==
Date: Wed, 14 Feb 2024 14:52:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
	quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Message-ID: <a09d6450-95e7-4ed6-a0ad-5e7bb661533a@sirena.org.uk>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
 <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ns+rXoClsiczKO+Q"
Content-Disposition: inline
In-Reply-To: <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
X-Cookie: Available while quantities last.


--Ns+rXoClsiczKO+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 02:44:56PM +0000, Bryan O'Donoghue wrote:
> On 14/02/2024 14:13, Mark Brown wrote:

> > Not just that but also note that every voltage step in the range will
> > have the 8mV offset added.

> The documents I have just show sensors attached to ldo3, ldo4 and ldo6 fixed
> at 1.808.

> I don't think there's any better or different information than a +200000uV
> increment TBH.

This seems like a very surprising and unusual hardware design, the
1.808V voltage is already unusual.  Note that this may break systems
that are trying to set a range of say 1.8-2.0V if they actually need to
set 2V.

--Ns+rXoClsiczKO+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXM05EACgkQJNaLcl1U
h9ByNwf9GVyH+zISFE14EUpDs4CKOlrfNB5r1iTl39OoJqiAJyn/K/Ag6Pou5RBg
3CfjummZrnzSeX6ZSQU7JWfPMpUOBF1ipvHdIGkG9kUyZuWIJYu85WG8KiCPS5pj
AfJI+pTboFJ7Biqg/3rcpPyf88w8SSMhNZyM7F5/0FGzSgu9wf3RrKgdDwyUBZyt
SHu1mfmH71mmZn1zx74hs/4KwkE/g+7dgbJDmFKCSMcMTBjQ6hYP4E5Y+YOe3vyI
i4ITXjEsI/AEj3MD6Jh/Kwjnf2ou7qFiSaGF11XgCsv32lWfpOlAU5Mia1R72grr
JVDLSXKI5SC7Z9/PM+VcGI5Nma43Ow==
=hoBz
-----END PGP SIGNATURE-----

--Ns+rXoClsiczKO+Q--

