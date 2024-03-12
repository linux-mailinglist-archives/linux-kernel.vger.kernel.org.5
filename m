Return-Path: <linux-kernel+bounces-100370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D00879664
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C197DB203F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C3C7D412;
	Tue, 12 Mar 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8Y55hkG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576156750;
	Tue, 12 Mar 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253901; cv=none; b=GAmEkabfzYQ0b2CtoHWepcCM8UDpP2IFWKH7PYn48CQHbOoIM2++BLSHfjXeBfmC8zmUrUCPVDpy0ntbfbuq8FGJRUtuZNTf/2qcmCVOL/juHNOv1uwEnMZOj+yaVo4HRX225qLmof5trsDdMF9OKAn9MgJTh6n2tY3uv1Jgu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253901; c=relaxed/simple;
	bh=JkjP3QBcCVXwodpuOnjb64q87p6hcmN+DHZyzdDU3n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/yHUQ1BGOKcla1aWOBMUOmvviq8ro+95hcQOujK5Rs38a5I8MB1Hzk1IBPjwQQWQTagbrjppDHS8DvUE154h2GdYO1RNxEbVqYu4dc9GUhGcJpvh4b920+NObegAfKpDDEIIF/ACs6ieJ/Cd2IfOzDIH9nvWWt9a/9wkh6eFcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8Y55hkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD1C433C7;
	Tue, 12 Mar 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253901;
	bh=JkjP3QBcCVXwodpuOnjb64q87p6hcmN+DHZyzdDU3n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8Y55hkG6WDmkZz6/FOoTr5ivZwbyLII8RO2gW6ywhz7XcoUG451PetQHfP4sWdA1
	 b94BiGCvRzsYfLIQj2+A0Gq1u0jbiyOPCH2OBjhdgOIms/21Re0s5IVaO9VUgF0EwY
	 r7e6baT45S6fYkOYEh+XgBVzoUAjdjKSRhi+ZcJ50bjprg7ng/zLKkLcci4tixbJEi
	 FvS7zOlDaT3u+KvPF+F/43V1wVZ7+GpL7CfP8R7MnC9GAjP6VS+wjcfdi/OoKHNRzs
	 qgiLxfOQndj4b+ziXRawuo1kCFw4qFK6DAjBODRB2qan4pqyGKRXlnnOB1tJ0g+glh
	 IfvF7O4MRnajA==
Date: Tue, 12 Mar 2024 14:31:37 +0000
From: Mark Brown <broonie@kernel.org>
To: xuhanwu <2433926602@qq.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuhanwu <xu.hanwu@zxelec.com>
Subject: Re: [PATCH] ASoC: soc-pcm: add a check for unsupported commands to
 the soc_pcm_trigger
Message-ID: <dff13df4-39c4-4995-b7cf-f9240a970cbc@sirena.org.uk>
References: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
 <tencent_8A7C0C985AE1A1975C25D8DE24010D8B2007@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SVXtnl3SxrTOaMQW"
Content-Disposition: inline
In-Reply-To: <tencent_8A7C0C985AE1A1975C25D8DE24010D8B2007@qq.com>
X-Cookie: Oh, so there you are!


--SVXtnl3SxrTOaMQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2024 at 03:05:48PM +0800, xuhanwu wrote:

> >	As can be seen from inspection of the immediately
> >	preceeding handling of start, we're deliberately
> >        ignoring half the values in each switch.

> In kernel version 6.2, when the soc_pcm_trigger function receives a
> command parameter cmd set to SNDRV_PCM_TRIGGER_DRAIN,
> it returns a value of -EINVAL.The function snd_pcm_drain checks
> the returned error value and exits accordingly.

The current kernel version is v6.8 (we're in the merge window for v6.9
now) - any changes that you're submitting should be submitted against
current code, not v6.2.

> In the latest code, when the cmd parameter is set to SNDRV_PCM_TRIGGER_DRAIN,
> the return value is 0. If snd_pcm_drain finds that the return value is 0,
> it will not execute the goto unlock;

Well, it will get to the unlock eventually after going through the for
loop so the lock doesn't get leaked AFAICT?  I'm not sure what the issue
you're seeing here is.

--SVXtnl3SxrTOaMQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwZ0gACgkQJNaLcl1U
h9D7CQf+I65qwiSF2Y7Qh8DH3RkCpngGIXOKfpL2TThE6NklN8FE2csXpMZpGDFD
CVEyolsym8c+sLekPSky2TTMtZ3hBHuukCrGciB9qffhrorQ7MgRdEgBtP1Efip7
GApg3MCVPYwlZYVqWWh7HamuHn6aHJCSqAw3EuvN9JpdWl9tXN8hdc7hNPQun1nG
utgMOAxUseqF7onB9MxViFHFJ2Zd55DrqorFMkjpaOzIVDE8DnV6p+RHgVRv1ISt
dMuTHFQowR3cT6+CJEdyzW2ozg7SCUXr9qIwNG0acBvBOb+WKTw4gXZaiqgS0+tx
XiVAdwuJhfWW/OfNW5e1k+MuJbL72w==
=23qx
-----END PGP SIGNATURE-----

--SVXtnl3SxrTOaMQW--

