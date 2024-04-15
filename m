Return-Path: <linux-kernel+bounces-144440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F58A4677
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C25C1F219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2496AB6;
	Mon, 15 Apr 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT2e5EmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFA3D68;
	Mon, 15 Apr 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713143575; cv=none; b=b6G09/IlxYFfg0494VL+L/d99ndKexJW406teCWZCtERD9L/dDho09q9cKLir95JKRuduINtNpHoASksGEuv6oLx1tg/G5ddCg9t1URBHgU9Bfb1nY2hdBR1y0dhL/YtB0Mk4cNjCCteUhv5ZogOkFonXs8+1UXvLMSmCQrZDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713143575; c=relaxed/simple;
	bh=4nw616AKChzCx+seKRLyzteNEhNOiDLXSiEzQg55aLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBQ6ma8mYH0tiyqdGNZB4vZLyYS4sCaNL6nCJ+CNASz+0rhQPK++8gwY5W3ejyhSe9mcmlgMf6KUwwpgZVsAwYfC1+02k7OrjgHskP3101l4M9iqQKh3jYRnVODk594S/+cM3o0J1nioe40NadT8V76YVFL4P6dChbJPhileiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT2e5EmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFBBC072AA;
	Mon, 15 Apr 2024 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713143574;
	bh=4nw616AKChzCx+seKRLyzteNEhNOiDLXSiEzQg55aLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BT2e5EmIbMazyk275TyLy3AqSviXPlPnPT0CLo1VT9SstY25D5a+z3UuiyE6ezHsu
	 7jlQxHIuTolafSDaAMBDzbzYB33gvgeVMnroV8CxUOCrYJn2JQZ8ZgGU4NkUKHsT+s
	 fWOwT2M2Gck9XbS0ClHxPl9h6FWwrmNMM/r0kD4O0XDpOaJeVbkmUn4Sdr1+FiSpx3
	 /o0LDoLYYGv1XeFoRo3Zy5zBYAfjwX7pjKV3/EfX0dW5CPIMMTnsYZBNBqcXczyfk+
	 YfpolfqCHqaekdimNtM5FqptAKXEmX64uKYWQ4LyBJeXAB/h9OxhquBkeyN0F0JGs9
	 sMMTtSAvk1ktQ==
Date: Mon, 15 Apr 2024 10:12:52 +0900
From: Mark Brown <broonie@kernel.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, tglx@linutronix.de, mark.rutland@arm.com,
	ardb@kernel.org, anshuman.khandual@arm.com, miguel.luis@oracle.com,
	joey.gouly@arm.com, ryan.roberts@arm.com, jeremy.linton@arm.com,
	daniel.thompson@linaro.org, sumit.garg@linaro.org,
	liwei391@huawei.com, peterz@infradead.org, jpoimboe@kernel.org,
	ericchancf@google.com, kristina.martsenko@arm.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, bhe@redhat.com,
	akpm@linux-foundation.org, horms@kernel.org,
	rmk+kernel@armlinux.org.uk, Jonathan.Cameron@huawei.com,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	frederic@kernel.org, reijiw@google.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 4/9] arm64/cpufeature: Simplify detect PE support for
 FEAT_NMI
Message-ID: <Zhx/FKeAtzResmtP@finisterre.sirena.org.uk>
References: <20240411064858.3232574-1-liaochang1@huawei.com>
 <20240411064858.3232574-5-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aDfZ4hfWMZ/wWBnt"
Content-Disposition: inline
In-Reply-To: <20240411064858.3232574-5-liaochang1@huawei.com>
X-Cookie: You might have mail.


--aDfZ4hfWMZ/wWBnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 06:48:53AM +0000, Liao Chang wrote:
> From: Jinjie Ruan <ruanjinjie@huawei.com>
>=20
> Simplify the Non-maskable Interrupts feature implementation with
> ARM64_CPUID_FIELDS macro.

Just squash this into the patch you're updating (I already have that
locally for my half rebased version of the series).

--aDfZ4hfWMZ/wWBnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYcfxMACgkQJNaLcl1U
h9CTUQf/e9t7mCpUXDzWC03yu7qxiocFRQqcDK63sB5lGWfmyW+a8pWv1cR4Wz2i
Fo7Y/WxFjRmjxNO4mdqfFvC5XEF6hxzCM9JIiWtcp0JqIVyIQDq5mGiqUcFL8cLR
J1oI+Acy7sodIrZTb9X957r3J7l0/VMobf2VCWL7U7BgeN1L84NfukmAa0gwFQ7b
ewqUZgPDA/I4ZSozucD6+MoVtwq90I1p3FZmAP7NP/gTvu0QOJn/SwWnglGyjKZX
iKcFxzZgGp2cW6PqBBAk4tiTRQS844EOOC/AKbRAj9zbkJSBqzO9id+WodloDNr0
4uydMzm1dIb6tnDeJWNnji2YHto1XQ==
=6Mo6
-----END PGP SIGNATURE-----

--aDfZ4hfWMZ/wWBnt--

