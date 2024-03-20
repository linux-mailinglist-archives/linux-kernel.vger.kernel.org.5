Return-Path: <linux-kernel+bounces-109231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258588167F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0392842EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F966FE3E;
	Wed, 20 Mar 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSGqzDQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75006A8A6;
	Wed, 20 Mar 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710955271; cv=none; b=WnbUC2itniXBYPQZRQNsHZpZmsHz4hdqOaxQfBg27ogfX46H/nQoxSmat2uP85DZDeEf4W3fQTsIZv1JH+X8IMdmnrJgYSahuqyXysQg1pfNOE8kMU0YFzLZ9PR9BWmtzovV2I1x6m59yYIxpkOmLBXNG75Fy6A+JmEKqBjljcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710955271; c=relaxed/simple;
	bh=vMt26N+gZlbDIjpZ5zan3Cn3V7tOpJjhfbvtLaaSEq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRp1iqYX+2cg4D8BXSjHn1t/A5E/IyP+zsLUZ3W+3dUjFGnpeBbuZXTXTG40V4J9835/ebd423zGKQjPPYDfKScgAZOyDGqSHy8RVD/vdvO+M/fZOaBhM2h+HXZjwtXaAsZ3ZeUrqy+P+AbJ44g5R3PIEnZaSwRVvlqOd+yIGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSGqzDQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF59C433F1;
	Wed, 20 Mar 2024 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710955270;
	bh=vMt26N+gZlbDIjpZ5zan3Cn3V7tOpJjhfbvtLaaSEq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSGqzDQR5pMJHQpJD2A5Tsa85TNyzs/VaHkeFqTGVRii2quMlXc1YRh9shPu6T7Cp
	 peubW3wxB92VVgh+sNL0e3aZv71RPHtLcLq5pJBIt0TmCezQAlgxtBEXwE4/NNB8yr
	 Fb8Tgm95F+9adlFvSGejqQxARy+vm1InxtlCBbQv7TQBL4Hm+8PizwvLlES2nrAk7z
	 8+ImGXduaZYQ1LpSDmNr4BOT/K6bbIGCnPA4f2V4FOhSoklogSnX0F+uOhHM2Ngv0c
	 Fpy5Mx3zpOBr8J0cY/Vpq84jbQ9q1vAIRlZDvAKXNqS0hnGmq7D6rAahuvHOBXinx6
	 uBeEoHiGZdmUA==
Date: Wed, 20 Mar 2024 17:21:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org,
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 9/9] selftests: riscv: Add a pointer masking test
Message-ID: <20240320-handpick-freight-ec8027baa4d1@spud>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-10-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2lLUjXGQgSitrjkh"
Content-Disposition: inline
In-Reply-To: <20240319215915.832127-10-samuel.holland@sifive.com>


--2lLUjXGQgSitrjkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 02:58:35PM -0700, Samuel Holland wrote:
> This test covers the behavior of the PR_SET_TAGGED_ADDR_CTRL and
> PR_GET_TAGGED_ADDR_CTRL prctl() operations, their effects on the
> userspace ABI, and their effects on the system call ABI.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/tags/Makefile   |  10 +
>  .../selftests/riscv/tags/pointer_masking.c    | 307 ++++++++++++++++++

I dunno much about selftests, but this patch seems to produce some
warnings about gitignores with allmodconfig:
tools/testing/selftests/riscv/tags/Makefile: warning: ignored by one of the=
 .gitignore files
tools/testing/selftests/riscv/tags/pointer_masking.c: warning: ignored by o=
ne of the .gitignore files

--2lLUjXGQgSitrjkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfsbAQAKCRB4tDGHoIJi
0pbyAP4rgHPD5OEauv47v5LeZ6gpBL/+0Gj9XCgAwfpJ1XiI/AEA6/mJhAh0XHlI
JCwPgAQGsM0OU/X+IRCzl56WkN8M1QA=
=mhnd
-----END PGP SIGNATURE-----

--2lLUjXGQgSitrjkh--

