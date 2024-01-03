Return-Path: <linux-kernel+bounces-15859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4957D823460
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CF1C240BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938CD1C6AB;
	Wed,  3 Jan 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apgnLqor"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E11C692
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A446DC433C8;
	Wed,  3 Jan 2024 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704306262;
	bh=2afhLg2dFIIBmiVUJoVEXAjQISrLXWdZa5g63Xq6sMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apgnLqorSmSCV0DbQZoBpyfVm4ZAHmxtPA5zm45K/0cKfOE7VNr5ygYQapEVcYsFN
	 z2eyZnDhvcdQ8fCviRIL3H6u46yuEbPv8X5lz2nF/09nAbnwvORz66/zK2EXTXZeIY
	 wYYt7Vcq9q+i7w8Pmh74CYu9BeDtzAa8SbSIvrQW5BASL7JnjkmzVi8sYtiXcTCjG7
	 m9UVZePBkvSFVcNImty6BPWxrvN7e4OYNC1o1/BbjWzgh6f3nREffLV+vxFIkYtOmu
	 JXhyINpzzyhzVutgj2XnOLMI1W+eaT2aZFXOIAJZGRjoQnLfbXfW01KCPYqIbLHLyn
	 JXZ3bESUrc1Qg==
Date: Wed, 3 Jan 2024 18:24:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+95ffb6a83b20ea7f4f55@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	mark.rutland@arm.com
Subject: Re: [syzbot] [arm?] WARNING in do_sve_acc
Message-ID: <ZZWmU9zFdIqfQL8x@finisterre.sirena.org.uk>
References: <000000000000511e9a060ce5a45c@google.com>
 <20240103180548.GB6200@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0bf6vRTcG7q0E1me"
Content-Disposition: inline
In-Reply-To: <20240103180548.GB6200@willie-the-truck>
X-Cookie: You might have mail.


--0bf6vRTcG7q0E1me
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2024 at 06:05:49PM +0000, Will Deacon wrote:
> [+Broonie and Mark R as I'm sure we've seen this one before, possibly
>  in a report from Naresh? Was it a QEMU issue?]

It's been reported by the LKFT people, but it occurs with *extremely*
low frequency, there's no reproducer and nothing showed up from code
inspection by myself and Mark.  The reports suggest it's been there
since ~v5.15 (that's the oldest stable it was seen in and Linaro do
still cover older), though Linaro's reports were conflating multiple
potentially related symptoms so it's a little unclear what exactly was
seen in what version.

I suspect to the extent it's qemu it's just that that's mostly where
people are exercising SVE.  This was shown with a userspace with SVE
usage in glibc, I *think* that upgrading to a similar glibc version was
what started Linaro seeing things too based on the release dates for the
particular stable versions they mentioned but didn't get them to confirm
yet.

I *might've* been able to show something with current code just before
Christmas but the symptoms are a bit different, I was going to start
looking when I get back.

> > Unfortunately, I don't have any reproducer for this issue yet.

Indeed...

> > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

> > pc : do_sve_acc+0x6c/0x10c arch/arm64/kernel/fpsimd.c:1394
> > lr : do_sve_acc+0x5c/0x10c arch/arm64/kernel/fpsimd.c:1391

--0bf6vRTcG7q0E1me
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWVplAACgkQJNaLcl1U
h9AKLQf/RF8z9wVHPXxMFkRTCcBegv3D1GlkFGzCGdaxBr98Yzgyc1LPn1X835gs
bNPZSL7oFU0HjizrPPI+khfT43aWlhrHFTXtLWO2ETcjxUqqhnUYvh7y2L3nrVmP
CbgSEzWMMGjz/PZmWGgj98W2yi2Xps+KmrMqCJM1RrXTa4wavW+tLV7/T9QugLUq
kF5fSWivhQTrSLRaLGYyE27gZkyCpBMsbwSuSQGH9RrUYO0JUBwgRZZHHaobInZM
TpqOh4RctVboXY6aFF4Z1UXBqhK3E0K8hlW3WjIJYbksG/MIk+BVTlIdjtLE0CmT
e4Akq7Nkm48Aj1tHZ8MDcpSWaPuh+g==
=LjvY
-----END PGP SIGNATURE-----

--0bf6vRTcG7q0E1me--

