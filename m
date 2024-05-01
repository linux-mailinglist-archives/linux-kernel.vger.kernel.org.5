Return-Path: <linux-kernel+bounces-165360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A28B8BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C91C20F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6612F364;
	Wed,  1 May 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJJy6q94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5D12E1E0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572874; cv=none; b=Tzv8P5F1lgu11nsemIahdVYoLs90xkLmD8rULO1/LCQYu4MAXa/a77L7aCerJK7TsQBOqSfx0WXfoda7wjN8iLzkDfnQBYR5UAMwvODjpmnwKkhnezo8yLMMX0s6fX8vDw8j06O0ArEyu+2HexIZp4dS6cz9Yn9G3y+5q0a4jRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572874; c=relaxed/simple;
	bh=xz3X6ibzEMtgWN6VO17VZqtNKsmeeM7Ky3gq20nLhLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Susim8s77ZRpJRGucmmMSIfvWJzz+xryVUZOJvg33ty97wGwE1s5MRtCma3tjEV4hTnrURvmsoFxZ/CXl/PeFI63flH9jedbRiYPpZ7DslPd/miW/nchqbj3MeXlmVOeCcSkX5JkdcvCpJrPxkpJBo0wiNspJqtC6lzWAxsyOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJJy6q94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEFBC4AF14;
	Wed,  1 May 2024 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572873;
	bh=xz3X6ibzEMtgWN6VO17VZqtNKsmeeM7Ky3gq20nLhLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJJy6q94/hlfRvotQKgdhHU3JRkHa4FM8LmZicAE1iHpKGw171cqWq8o5pUPNVYLB
	 Fhd0j2+4rvU8HJq+yT6ppUbJr1f3/w82ebMIIMtNnm42i0mXqxuiAIM/H60B6CA6GP
	 L+B4WuJjb0EtSQeu200+S/YyPtbv1ELnt9KLAS1X+KZVClgundNbJEG1PvXXzWkJE6
	 A6hIRQOK5ppomahp9/MOuk7yJVLBC7jr/SDHJPlaMZt6m9Ep6xLuIiT6Rab3D2qakz
	 yxtrGhkaz3+WSC5WUsEuJ31SXrJbsvDCtNB/ccJvRYkYSBrc+ZUPuw8Okbu/+qPCv9
	 zIUAm1SSlRhBw==
Date: Wed, 1 May 2024 23:14:31 +0900
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 1/4] regulator: rtq2208: Fix LDO discharge register
 and add vsel setting
Message-ID: <ZjJOR9kUedFsDW_7@finisterre.sirena.org.uk>
References: <cover.1714467553.git.alina_yu@richtek.com>
 <5d56b79c94de63fc86b5a70b7e374da4240fee8b.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WjKwlfJaleLigCU1"
Content-Disposition: inline
In-Reply-To: <5d56b79c94de63fc86b5a70b7e374da4240fee8b.1714467553.git.alina_yu@richtek.com>
X-Cookie: lisp, v.:


--WjKwlfJaleLigCU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 05:58:24PM +0800, Alina Yu wrote:
> The LDO's Vout is adjustable if the hardware setting allows it,
> and it can be set either 1800mv or 3300mv.
> Additionally, the discharge register has been moved to another position.

The discharge register change should really be a separate patch since
it's a bugfix, though it's probably not a super urgent one.

--WjKwlfJaleLigCU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYyTkYACgkQJNaLcl1U
h9DpLwf+Phhe912MDABDaPG7nqZCD+f58UiPfNoKA56nk1hlmixq9vqEkBOuFIzL
0N9l7VDENqV0Mf6vmLZwdekxsjnICy5zxThuIo8klihEOddt4HCbuezA/mWoJkaI
iPu0VDbV1s7eJzZtAnhvY+kQQS9v+GrSsvtHjLKlvghTQiyn/F5ggPOpkCr3IbGZ
qE+V6sXn5WyugWwMNSG7gApFfKkxzqUwvByJQX9DSd0afpv7QJrtyCMXaHth3KUf
oGPqWIN2b2Hl0yPYyppXrzqtmRQrnJ46JyUZ85hHaj5Fdzxwyhi59JVSxc3fJYyM
1XqcwY3MOiQTSNs9zy77KRbzzZjfig==
=VPMs
-----END PGP SIGNATURE-----

--WjKwlfJaleLigCU1--

