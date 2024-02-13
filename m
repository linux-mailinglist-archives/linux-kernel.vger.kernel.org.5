Return-Path: <linux-kernel+bounces-64010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D898538F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125AB28ED7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B8604D9;
	Tue, 13 Feb 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgK9wBz/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67870604C7;
	Tue, 13 Feb 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846593; cv=none; b=VIZjWsvo/+jt7FEYaU0F0ccto4Mq5HsMXJZJDWdbixQq6P1Zoqn0bzPPuIRb0khtOJggNXXePMb1M9VTvhMKI8O8ncUP+qu1WEaUp3UbtKO7D8GrkUadWtaQMzy6ME0gdYuJb31w45dzWMsLvfKrMswz8TQIiuYpVOBlke/AEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846593; c=relaxed/simple;
	bh=++FMVBpWLKLyJlR/vLHI0EFRJBFU9d6jOdSpHqfXwVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZa7BJO/BNkR7Fp8BsTODSZNSC7rfxt+blbwbWY+BlW/cfyhpfQDXADCuQlrH8L5yVMymEifRjX2JKVIm1XzjNhCOMSlI4oQaEXzosGFzE/s1hZqsfMRQiz+GvxHipBg+bqFQy9ach0JY1sLHMOpJLD5PST52MmSPTc0C9uG8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgK9wBz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E759C433F1;
	Tue, 13 Feb 2024 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846592;
	bh=++FMVBpWLKLyJlR/vLHI0EFRJBFU9d6jOdSpHqfXwVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgK9wBz/91Uy0VhFb6ZwD6JPft52/3myuaCNvyncVA0UjqNMUW0PttI4h11VkTD3Q
	 VUX0OshTOaF1powQRle/eUpRTYoBt8r3+/X1y3CxaHLDytpIgfhyIvKmoUN0VbdOmW
	 SdK7BtXK6Pr9Vr4SvpZLXctt/TbDhp+KxciM3moREBW+hn5ZXtsB0RAaGzG2RdvXEC
	 nKpXWsS2nmSGwlKcIYt15v/U4UsYzQN1ZJNYVZ+YQiNx5DWn7oGp6+u4IkyYpdH5n5
	 M6N5MQphjwf1pRRJj034mnH0KVL9vMQJePMloNUp5CiyuiFNrYDnkVf02y/oD1zEU3
	 +k+NFV7Qcakng==
Date: Tue, 13 Feb 2024 17:49:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <ce80f238-1a56-4254-ac1d-5a9249c40b66@sirena.org.uk>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
 <20240213170657.puwlx5pjl3odcs2k@runtux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dEARMtHgTGDuT8U2"
Content-Disposition: inline
In-Reply-To: <20240213170657.puwlx5pjl3odcs2k@runtux.com>
X-Cookie: Does not include installation.


--dEARMtHgTGDuT8U2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:06:57PM +0100, Ralf Schlatterbeck wrote:
> On Fri, Feb 02, 2024 at 12:53:30PM +0100, Ralf Schlatterbeck wrote:

> > --=20
> > Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
> > Open Source Consulting                  www:   www.runtux.com
> > Reichergasse 131, A-3411 Weidling       email: office@runtux.com

> Any news on this, will it be picked up for the next merge window?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--dEARMtHgTGDuT8U2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLq7sACgkQJNaLcl1U
h9C2zwf/RJiV9n0JXL0mGzO2TlXlfag8bXwX+2okObjXfbjuqmrLr1QjViIIUQAB
iUendQeWA8YWNC/ahhwktRbDkFWF+J0QqoOsL31I3QMAg2dievklvBqKF1x511Jh
JktiB7EKdxlCAyZ9sGJW81zBVCyHe7ZCEeeFvMBzCFkp4mdr4kJXldnm36gEi7ii
AxP/IOOgxZxeubX2OG8cWI08Gtpp9Sv+4wqPR554EXTFSwnZfp/c7aLcOSJR0/2+
I+HbuseWBy6umnwwNxW2YrgfPGEENJutxudMciMUKHwXVhauhQjTs0ZmoqjL19Hu
NXwp7tVBZk7A2DlTkO4tpbO5E8yOSA==
=hMbu
-----END PGP SIGNATURE-----

--dEARMtHgTGDuT8U2--

