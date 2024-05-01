Return-Path: <linux-kernel+bounces-164873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A98B8448
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DDF1C224F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA21134BD;
	Wed,  1 May 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW1bmFjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFD11CAB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529948; cv=none; b=b7kvAvoTbgaUP70l2DpcADoiUjgD/Kgylzlg7IEfC3of2xdra9YN2dHSxPnYVtypBD8iA0ptANd3zdogMCOeo90wcK1UAxWkndw0vT03Ig5NS3u2WPiIQ2TZdDi62ywFaKy4o45l/geBmnq+DPU1U6ifkvkZFBqxggzJR/mrOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529948; c=relaxed/simple;
	bh=1VcapQ93ruE/UvGkBUNCPXJf+4grWuZ4C0nUxAGJUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjspx0/El+FgZkhC87lU5hKH6Y2so4wtaDqcsLmxxw3ou4vlYf5AstjUE3P4DOgVgUp45ny46mdd4D6steCu7iaBgJiaqJKTIeEi7MIfsS5qJ7rVkDGt1nbC1sECX0TadUHeGvXjoJPY3NVcxaXqaAyVP82UKlYe6S/mA+PXOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW1bmFjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4DC2BBFC;
	Wed,  1 May 2024 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529948;
	bh=1VcapQ93ruE/UvGkBUNCPXJf+4grWuZ4C0nUxAGJUZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW1bmFjsmZTi3mp9Z7tz1ja/LUhLRUlzj1eEv9RfkB+oebkJUgsBaSTcUUMA58lpP
	 Yw5umspTsm2yipGh2fhzw9uJ/9o33V1fAXmL8pJiZj4pzBKuPcO+z0d/j4J7uX07zE
	 /SrtJ2GMeFoztAOOPZvG/jbaicuH+wZdytL+FtKZiEig9rXzAgdjzWGlum4pVrduyY
	 CSSCnjn21SIV/b4YUhyuOwew8+kFeDkQwPLGKbXp0IKR+kJb8Qv7WX+okz5PTcMDlh
	 o2zKVMzZKWaJqn/VPVCltIvjSuP9Y7fptvLlZmtsiekqnIre5IjkoGBEa9AGlXdR6M
	 Non6pqxksbbIQ==
Date: Wed, 1 May 2024 11:19:05 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yl7/Eyy5kVACNkCg"
Content-Disposition: inline
In-Reply-To: <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
X-Cookie: lisp, v.:


--yl7/Eyy5kVACNkCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 05:58:25PM +0800, Alina Yu wrote:

> In this patch, LDO's adjustable and fixed Vout settings are compatible.
> The LDO Vout ability depends on the init_data->constraints.
> If adjustable, the Vout can be set to either 1800mV or 3300mV.

> +		if (init_data->constraints.min_uV == init_data->constraints.max_uV) {
> +			desc->n_voltages = 1;
> +			desc->fixed_uV = init_data->constraints.min_uV;
> +			desc->ops = &rtq2208_regulator_ldo_fix_ops;
> +		} else {
> +			desc->n_voltages = ARRAY_SIZE(rtq2208_ldo_volt_table);
> +			desc->volt_table = rtq2208_ldo_volt_table;
> +			desc->ops = &rtq2208_regulator_ldo_adj_ops;
> +		}

Why are you making this change?  The operations supported by the
regulator don't change depending on if the system is going to chnage the
voltage.

--yl7/Eyy5kVACNkCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxppYACgkQJNaLcl1U
h9ApSgf+LgoXJNxcFSw3tb07ue63Ba7DUWaYbOaUrYuzQic4YN68AXn7b79upQWH
LmAuIwHrohpDbvgPh2xNoC+sQhs6EHa6Pb9TlXelRg2Um4mMVGdrOWV34+wTgtm8
NdTOMLI1Y6uhYQZaxtZ5PN4TU/hjbqdUYfObsU4k6kjTbrmhlNXhH2BsM0gmQhg3
UiaWeMd7puJxf1SLu7vVWtOwFR/aGk4Yiy3hcJc0InTeHISdT3N5A3U/56UT/L65
0JDauDxcX1dPLnYcMLQx1mN44cAz0GgLbpzrGVnCW+9Pdc4lrcBAuJ32k6GzuSYv
VJ1NIXVocd4Sg2zZi/r8BemcjzmnhQ==
=F+eV
-----END PGP SIGNATURE-----

--yl7/Eyy5kVACNkCg--

