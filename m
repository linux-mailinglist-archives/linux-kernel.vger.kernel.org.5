Return-Path: <linux-kernel+bounces-167149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2008BA4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEE4284565
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ADFF9F7;
	Fri,  3 May 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEEEXDjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9188C05
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700254; cv=none; b=T+rXBdp/BEmwV2jowyOT960MPiAG+mrjfmfDH8jZikAVivbMQpH9EW4aF+iZE0I3ChaK6UcEIHaD8NIl2gxyXk598lOnhAF1e7URQFGDffbvYdWyEDzVRL5LJNstViaHrghCGjj4sOepOkxJ1l0DZCYkP4Fom4SooZBoYwmwtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700254; c=relaxed/simple;
	bh=Sp65uvwAWYdNzfIJirCPF7kUSiJmaYnIID7Yps4ujfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcMC100+fClvSFwmPyU18h6qPhDBWQjZIXou+YLxvUemJWtp7VndIth6WDOoVGlNQcX5ucFI1SpU3TQ67LCYgMUdZ2oawa8Ce5bB3VI7zMJkz8B5Sh9of6xSoFvQiQQFbUyBwdV6hLhiBiuMdjCo2CeD0fecs8uNiRPtE72gXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEEEXDjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1782C113CC;
	Fri,  3 May 2024 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700254;
	bh=Sp65uvwAWYdNzfIJirCPF7kUSiJmaYnIID7Yps4ujfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEEEXDjSQU1u2pzfHNeA0FeXteC2P6RJDly4cX/miR/9dMYm2PjQcv+T+ll7uEqUJ
	 96Mb+E5StryK+yDfBC2RCIRCVNVS7YN/q8MK/O+48rTL2kbwk9FV4jysnDnTWnnYQP
	 mRoCO9/Bt0kasnekKknyiPnyktuwsYoCPUlz0JHRDxdAuxlvRJ24Z1FERYijtRQbg9
	 VteAB9/SboaqKdG6NqwX5GD3Iw3ZXcQYwSF4/W9Qp+7EQi+yP6pbRA4IaZcTYlRm+i
	 FVmrn4z9enCRoPaKNZ3xPS9m1PG26iGww3Qo40rGn+aUjPVQ2HsqSXvkrEmbAsKI76
	 5SZ98FPS821ow==
Date: Fri, 3 May 2024 10:37:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjQ_2_tywLZ5EaM-@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j+uibN81L2oDx5ns"
Content-Disposition: inline
In-Reply-To: <20240502073029.GA4055@linuxcarl2.richtek.com>
X-Cookie: lisp, v.:


--j+uibN81L2oDx5ns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2024 at 03:30:29PM +0800, Alina Yu wrote:
> On Wed, May 01, 2024 at 11:19:05AM +0900, Mark Brown wrote:
> > On Tue, Apr 30, 2024 at 05:58:25PM +0800, Alina Yu wrote:

> > > +		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
> > > +			desc->n_voltages = 1;
> > > +			desc->fixed_uV = init_data->constraints.min_uV;
> > > +			desc->ops = &rtq2208_regulator_ldo_fix_ops;
> > > +		} else {
> > > +			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
> > > +			desc->volt_table = rtq2208_ldo_volt_table;
> > > +			desc->ops = &rtq2208_regulator_ldo_adj_ops;
> > > +		}

> > Why are you making this change?  The operations supported by the
> > regulator don't change depending on if the system is going to chnage the
> > voltage.

> The change is necessary due to the requirement of the SD card for high/default and ultra-high-speed modes. The system needs to adjust the LDO Vout accordingly.
> In ultra-high-speed mode, the LDO Vout needs to be adjusted to 1.8V; otherwise, it will remain at 1.8V.

That just sounds like normal constraints usage, and something that
applies to a wide variety of systems not just this specific regulator.
If there are limits on what voltages can be configured the constraints
will enforce them.

--j+uibN81L2oDx5ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY0P9oACgkQJNaLcl1U
h9ClnQf9HcOrR94eQDtUDFa/g82kKtfAKJLc2VKB7+K2KH8IfzdFGBnQowOKB63d
L9WY94SQmFWkltV3Fgfgpv76O/5l9JrL83xErOwPktNrKpMJK+wIsSTUFYTmLtk4
Sj7ZZy2XzUFoYyExyCzC9xSAHJ3XdZ+td8BA44ziOUygKeKirpqVFGenTJWYmMe0
ClJ/IdJYJcSoQVVIoCyWo4CTkuw2WQei5foU8EkNLmPCXLnSULI9Gto7/dJaqg8D
AL9kMwSRHnseRxHTI+GbyeeBGEYKIBLj6lLPT4z2rAYXr9sXY5XnfEAEPndY2DCW
Ht+2JbeLBXY1gJkS6CCALrYyKhTPzQ==
=UOIY
-----END PGP SIGNATURE-----

--j+uibN81L2oDx5ns--

