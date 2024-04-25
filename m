Return-Path: <linux-kernel+bounces-157893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B98B183A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555B01F2503C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647187483;
	Thu, 25 Apr 2024 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMS5vYGQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1F4C98;
	Thu, 25 Apr 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006702; cv=none; b=vF6GJHaDRZDvgqdGoswyD6lkuOctSTFX2p71sQ0981q4Y8ETnD4MkdvelXyPCrWUDRpESztEcqjmi7C2x38KhG1vAdixKQxj8/fbintfb6U28xfS/Y+ql8ci1D62ffnj3SsRrSxSPDXGsqdQtKD/COysxyELbrNA0SsjDTOg9E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006702; c=relaxed/simple;
	bh=ieGhYtG2g3/12L0LUEaCPkUzRxfucBkJXELVtQElB/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjp5zSRPvaWqoGL4s6l/yOFovIVxuTlCR9WM1q7xIeJE98MNRBhNn3u1U5PKwyJsXab66RpsgDzfunQ3bmMzvrMvD8KNoKPweJcclaRBq/8nUVrNkXavKbs7/mFI+vCDyWet7oXSNDx92lOrZYjvDbFICAcE1vA+++BmFm7TjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMS5vYGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0139C113CD;
	Thu, 25 Apr 2024 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006702;
	bh=ieGhYtG2g3/12L0LUEaCPkUzRxfucBkJXELVtQElB/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMS5vYGQrb2MZA3RaQKbV4Lqduqmsw0+pthcKCXdHnk5eZjGAIeJuFdehFXXDgN3N
	 mVn5m3c09YpyiKpmgV8fuwpLvJw86pjSv4QwfUIHRHUIXRFEF20zb/vXKnO8NtunWA
	 U+UdFaiMpQnK4ScRnpIXSOE0dgbuPw93SHm1OI7L0TwIn7IdJarFwa9ujfIYY0ZYPO
	 4iaLSsRmco0v44yGiEJTGHwZBt3NjOTzg0XvFpSUH+j4wir7xemKOqM8aCG/34Q6TP
	 n5bqe00/vF9QXBUD/G7NPbQ6MO320goTVlMB6NSlL4KnYl3LBVw1DPcX0uXyhNLoVE
	 Gn14ep6aClvnw==
Date: Thu, 25 Apr 2024 09:58:18 +0900
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
Message-ID: <ZimqqtNxeNPAYnJe@finisterre.sirena.org.uk>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181550.42466-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E32mvQqMNueXGFVT"
Content-Disposition: inline
In-Reply-To: <20240424181550.42466-1-tony.luck@intel.com>
X-Cookie: TANSTAAFL


--E32mvQqMNueXGFVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 11:15:50AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.

Acked-by: Mark Brown <broonie@kernel.org>

--E32mvQqMNueXGFVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYpqqoACgkQJNaLcl1U
h9ACyQf+PzrGpxX4H1xd/ifpOXOFK3ZiBbC9zJKm4uNj/qbml5F6d8h6jRi9JDdt
YLMES3X8Xb/XwviletXFrjCKPVydEuEovntVr7zrIYHB8pT3pLiUKO8i7+oRWs8M
6dULTZe1TctUQdGigUzHdnwthwifqJhKztgOF7aRzfoH6XSh4X1ukIVdjQhpYJf1
/zpsaWmMzZOaAqCAmVVXElrTdm8U46jONmC/i3D5V1S0Qyq2ohNFLNHcK6Hhv6fi
7aIe8Unn49wJC2bCu7ex6RPe1ucoMdNRISgNWfKgV0XpuduAKwmIDqO1xyvk5Fw/
+ZGemR5LPlZfdV8ye9x0wHyv8aL2Bg==
=CCkV
-----END PGP SIGNATURE-----

--E32mvQqMNueXGFVT--

