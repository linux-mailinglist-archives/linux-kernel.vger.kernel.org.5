Return-Path: <linux-kernel+bounces-157866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD08B1792
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30B328654C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36106171095;
	Wed, 24 Apr 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVprsYQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958B16F26F;
	Wed, 24 Apr 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003109; cv=none; b=DQcbzIFnC1jhp/S0/okBllKLXlfEjzqDhb6XNlouMJCVhUXGda3vO48Av5t6U0NOrGGmL0NIBQNO0OnDbOKUY8OxXwnRMi2+8S8+sMldLZJgPP5WLsodjfS+ACtD4BSPGMYHqiX7NdK48/rbxQ7ZGEIipc6Mou/K0Rt6YNGyrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003109; c=relaxed/simple;
	bh=uFoOF3YO8h0JW7XAW9L2NM3cLaVUAP7oPCFtKLfQxGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4HmMMlKrYC8/78x3qe12MOo4SQtZTKNxfTfzu58eqGaZ1t1qNU2ZelDET6QJi6f8XrdxymyqwwVHxA7qPWBiHLLagna39mBt9H3i8QBmqwB7HM1DCuGNL7GUkyI7K8SaGkk5DqV4OlU4sXkuIBWOp3HfbLh/CWZhp2mCEWSTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVprsYQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41E7C113CE;
	Wed, 24 Apr 2024 23:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714003109;
	bh=uFoOF3YO8h0JW7XAW9L2NM3cLaVUAP7oPCFtKLfQxGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVprsYQHFTj+331xRzeFm97HGexC5nhy7KOsH59tElvZ7w2hox2Oiy1NJjdHLiA2l
	 9h1jFUHoyyqDW9eK+T2PD5dTotq2OYILLtSCgwgiUMj5vrnhwsGSKYGPjqldx6BE3V
	 a+DlmBOEC4n/eVpruu6nfGPuCNLIZ7ILOl65X1qtey5Fwd+oReiwSx0im71jhzREMB
	 EWdnBDb0bdLw2BZFN3xdNrZqEftLIY+Z73sPlrHTnfeATVex1LUdLsqexxBGCnFZz1
	 LnaHO9FqrqpY+/hM/flRo9XqTtxESrep1ulyohYqaCUbSaudvrjCfBGYVB5MhtDffz
	 OeGmrcKMv+fag==
Date: Thu, 25 Apr 2024 08:58:26 +0900
From: Mark Brown <broonie@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 68/71] ASoC: Intel: avs: es8336: Switch to new Intel
 CPU model defines
Message-ID: <Zimcol_3kmP2Bv_J@finisterre.sirena.org.uk>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181550.42466-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SfLdYZdy2UNAMhyr"
Content-Disposition: inline
In-Reply-To: <20240424181550.42466-1-tony.luck@intel.com>
X-Cookie: TANSTAAFL


--SfLdYZdy2UNAMhyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 11:15:50AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.

This appears to be part of a series but I've no cover letter or anything
else from it.  What's the story for dependencies and merging?

--SfLdYZdy2UNAMhyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYpnJsACgkQJNaLcl1U
h9C7eggAgh8i99/Fug4G8/wwyWh/fpTIgUvtZhqqNOWn7IgjB6F7MiSo4BGGdeVC
06VmWSymyyUFWVj+YS54cACrfx4+fmByrIoQrJqIML2e0c3cmRPtQ2/3XBxs2Qe1
CfcqNC3qrT3HfI+22xe/UBBZWRRSN0XXLHYuet1eUc5GDBOgTYKBetGsF6T+jvwX
rhq4V7vnFmF1ZcYlBNTPaxWM7AHfB93Zk/1SCKFBMqpw8woBvsKpd8j5Isbw1wvF
A8RkgMgiTUVKGZtFkrQvFYOfZ2JFaJ/Mg+W7PPcP4h/4tHo70VxHAeDoBMjy+GS4
yyo+/XPsXJ9I9mSv5/Gt+JOc5JyRPQ==
=rzp7
-----END PGP SIGNATURE-----

--SfLdYZdy2UNAMhyr--

