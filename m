Return-Path: <linux-kernel+bounces-43528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4FB84152D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F30284E60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39E1586ED;
	Mon, 29 Jan 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKalBYr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AD5C8E8;
	Mon, 29 Jan 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563934; cv=none; b=AOYjIs7TAajpZhyqQatjYabIXwX6AhPq3YB1qqhp1QfGmDexBSIqRhnIxKfiCrBraxVGaLimBmQf8YRJWSoBr8Jv0kBVFMDaFyQguxwiBM+QhiPez+o7ouJcGwn7We9qw9XWrn1l9mtHp+TPLuJbpwS8x4/9CgHVmuKSwqWSzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563934; c=relaxed/simple;
	bh=hpaR3uh7h6TCrXW1T5MrWbQzBrdrFXtHOXcaMGeIAwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcW3R+xkoc/uA3WyKM+G2Wd0NRovDjITktarWjx0Qf+rR+dw1OcAVO4dFqvER+5wTyRumCshLLoYQqPGNyk1T2TDAgFAgSt0ec0+idr7hkOwE8Rbn8fNMare4m0wdVKyFoP4fxCfwHbBXLD8jURXISMSr2IX35/VFF5aORTDng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKalBYr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5DAC433C7;
	Mon, 29 Jan 2024 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706563933;
	bh=hpaR3uh7h6TCrXW1T5MrWbQzBrdrFXtHOXcaMGeIAwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKalBYr0i+2F/IsJ0irIOz8/3MBhqatnfIR6y00aUE3dkrCE6vOme7GVocKB1Olfq
	 KQx5mdyvvj8q6Wr5uGbQkm0brx7agc1fxqvxVHI4JTGbkg8ND13gjnxU5HxMCnSIMF
	 suDa3QMkbWfIRcTDipiL06aWZUrclAJj+LG6tpddRnBb3EruTdu5/4X2ZVT/6JqCrV
	 gcHlO6X0sTUqA6g+s/I6wrVGCLAddnC8X6m0GCA8sgP/WaWmP9fU96N76m9hQZlNK2
	 ggBb+3p8/I4LQyLMTn5UZhv8p4PxPv+Z7DsDHuRRrEjcNb/5QtgtKCU01XMtnKFXfq
	 DWIGzFKcexbFw==
Date: Mon, 29 Jan 2024 21:32:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Fullway Wang <fullwaywang@outlook.com>
Cc: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com
Subject: Re: [PATCH] sound: soc: wcd934x: fix an incorrect use of kstrndup()
Message-ID: <b8309f8a-4f2c-48e2-9136-2b7175f2f3ee@sirena.org.uk>
References: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7z1GKA7aLh2MUWPz"
Content-Disposition: inline
In-Reply-To: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Cookie: Jenkinson's Law:


--7z1GKA7aLh2MUWPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2024 at 03:52:49PM +0800, Fullway Wang wrote:
> In wcd934x_codec_enable_dec(), kstrndup() is used to alloc memory.
> However, kmemdup_nul() should be used instead with the size known.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--7z1GKA7aLh2MUWPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW4GVgACgkQJNaLcl1U
h9BDvAf/Q6VS27XkFRg/XHeDnD86iT+b8n661uO70FOG9lck0EnTzytd8x35Pfqn
MCQUG+2rlMz5nAqmeAvJUCen6A0moYB7vnvpKSSl00YmeE6IsXsDGor6jz/yF9cG
BSqSCJXpY9KibrRyrWzp8dhElW5VC+u1xeelLlPgkftrNa2uCrAV9kifndpk2iMK
bl0itNLb+a0WncW/tyRPuuZDCZSWJDYG9/yHwZJ0cxI4ivQXAh2QQa91dM5zhmxj
GhVQs2PFUd1AGmUw23Bp+ipflPQp3Gq7YOvEPtyOhAuaHSw7SqNoJYxSFkGChOTY
DH44bhi2X4e2JY54ySqJCHuEI9LKjw==
=gSp3
-----END PGP SIGNATURE-----

--7z1GKA7aLh2MUWPz--

