Return-Path: <linux-kernel+bounces-146695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E047B8A6975
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63640B21224
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3F12882D;
	Tue, 16 Apr 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYmwpLN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948921272DF;
	Tue, 16 Apr 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266045; cv=none; b=Qf/fjOXlvuRZg1p8Im8qr7ij3cfYzE+8q9cBWhlex4G3/LSFONOEIQTV4eribbYXvzYF1KBJUQBBZkhrHKWJoax5qDgRXTO5O2NPZfZD8Xc/TwhhiWFXq4jDZmh+nodVd8nfTzwGxLUtIu00CWOaM1TvD9DfYaZL/16ejN46kZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266045; c=relaxed/simple;
	bh=S3Kfiv9DS0nLvicmsmZgYbCioARiZ+nfWbbfcdaTN34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niE0LIXSyuVAI75lWH5B8gOJgz4g7Y67J1nh3bWOFm2vbkVncZ47eHT39bjjXeNTTOAY2QcpOyOblWLS87CB51EPw1t3wk6LDibCjIa8Gq1OFidxBCN+G6EaA5Od0gejD76NjjQqrMlJBh1lwaDeF+AH6TuRTOUdyFNmQisDgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYmwpLN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD286C113CE;
	Tue, 16 Apr 2024 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713266045;
	bh=S3Kfiv9DS0nLvicmsmZgYbCioARiZ+nfWbbfcdaTN34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYmwpLN3qnViraldNuGwwyKyp1jObk6vzfuCJtjgoYsWflfsFmr4kRVj8dLqr46do
	 3LCVHLHCKVFXHeiC1ejEnCe3v93cWWDxXL9uwQyKaWDHbZY4LBque3o/8ouqh7Iuq7
	 FEPDZa3tznq8tzsVEww8VqLmf3PXkX0edas+ouE6qERbwhbWl7CYT4Z9aACEeemF8u
	 EOniw1nybhHe3bk2uY9jMQXDiWudd+5dzLGGVn+ShOs7bz9YdB+2ezBOwDxPGT5djB
	 Ssghr+RpU9W7HQPJBXrttyQvZMlXpLVFZ/flgO7W9EC3YDsSCipuSCKLwciVNTzg/x
	 CUjyl7QP7BhUw==
Date: Tue, 16 Apr 2024 20:14:02 +0900
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, Yihuang Yu <yihyu@redhat.com>,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <Zh5det1wn9wscUFn@finisterre.sirena.org.uk>
References: <20240415141953.365222063@linuxfoundation.org>
 <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
 <8634rlsh4y.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="amu2Tn57XLjbtMUG"
Content-Disposition: inline
In-Reply-To: <8634rlsh4y.wl-maz@kernel.org>
X-Cookie: TANSTAAFL


--amu2Tn57XLjbtMUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2024 at 12:04:29PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> > landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> > e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> > the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> > the bisect and looking at the commit log to pull out people to CC and
> > note that the fix was explicitly targeted at v6.6.

> What are the configurations of the kernel and the FVP?

The kernel is a defconfig, the FVP arguments can be seen in the log from
the job here:

   https://lava.sirena.org.uk/scheduler/job/148281#L233

(sorry, should've included that in the earlier mail.)

--amu2Tn57XLjbtMUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYeXXkACgkQJNaLcl1U
h9BhIQf/coOwRlOX6HOXGuvITmLKiqVnDtDUp/Gd1OiCAK8fdomYe8k2SN+PJTFR
fgpclHNZgGt8HAm6HgwxC6iyoQ3f9QAh58SZ2jsDGpmFUKXW944/JkCG0tmU3hu+
5CF4+TgCM3qsmZ75ikqxwoEJ9+GsF7H2SVTDojqbTQVE2jdEd7GpWBTHldfy8MT4
w/7vmS5YTyhYqkQbF5yAVFdUgNu041g4kCavu/UGuBT8UjnWe4ZUZa1TY6m0Gk2X
v1PtOCXxYM4csW4UeEpM9351EhhHoOsP6hB0RTQ7cIyML8vtZrxBZC6kxGBBF1Vc
rksG3SfgvAEW9vosKZlhR18o+2b8lA==
=33ax
-----END PGP SIGNATURE-----

--amu2Tn57XLjbtMUG--

