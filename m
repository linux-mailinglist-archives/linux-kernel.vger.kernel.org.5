Return-Path: <linux-kernel+bounces-148502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6218A8396
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DE228506B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC513D53D;
	Wed, 17 Apr 2024 12:59:27 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B742D60C;
	Wed, 17 Apr 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358767; cv=none; b=m0417BN+GwcZbxNDjmzVk0VRev4fu6//gxY5Kmnn/83qwanBkb4kY0qu8Cku/nVfGIeDsuoW6U7IOia+r55iBuO5wVzLhZAon7dnLG+mqlvQ/nkPhsJI3Xot6fRKgoE7AXw3HxUpctrToR/1X9p5gl1cHwUxnv1X0GG7y1ak/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358767; c=relaxed/simple;
	bh=HFvWvay/5DDWO9T/F/109Vc0YMZS09zONeLb7BQUvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFF9C4b35655I7HjP5++VTf0TT6GTCYlY/nbbvfSY4hf9m5pKoGueMMj8nm4P/bRs5PGgj2Y8WddQG5Ng/2AINItIqcElAIoSZyRoQwy/T4QkfIRt4XCUehUb78l7fsBKnOxz1PTYDq+fxEBbiY9zZeVvzlvbQr53RWmnBG7T70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4EE061C0080; Wed, 17 Apr 2024 14:59:17 +0200 (CEST)
Date: Wed, 17 Apr 2024 14:59:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	alex.williamson@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
	michael.roth@amd.com, dsterba@suse.com, aric.cyr@amd.com
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
Message-ID: <Zh/HpAGFqa7YAFuM@duo.ucw.cz>
References: <20240411095435.633465671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WebcVGuD/i7sDG85"
Content-Disposition: inline
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>


--WebcVGuD/i7sDG85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Alex Williamson <alex.williamson@redhat.com>
>     vfio/pci: Create persistent INTx handler

This introduces memory leak in vfio_intx_enable() -- name is not freed
in case vdev->ctx =3D kzalloc() fails, for example.

> Sean Christopherson <seanjc@google.com>
>     x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-define=
d word

AFAICT this is not needed in 5.10.

> Josh Poimboeuf <jpoimboe@redhat.com>
>     objtool: Add asm version of STACK_FRAME_NON_STANDARD

Asm version of this macro is not used in 5.10.

> Michael Roth <michael.roth@amd.com>
>     x86/head/64: Re-enable stack protection

This is preparation for preparation for SEV-SNP CPUID patches, I don't
believe we plan that for 6.1.

> David Sterba <dsterba@suse.com>
>     btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()

(This applies to 4.19, too). mutex_unlock() is needed before "goto
error" here.

> Aric Cyr <aric.cyr@amd.com>
>     drm/amd/display: Fix nanosec stat overflow

(This applies to 4.19, too). This is wrong. It updates prototypes but
not actual functions.

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WebcVGuD/i7sDG85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZh/HpAAKCRAw5/Bqldv6
8jQNAKCgA7GiY1skcB6NPefx12bHsL8tcgCePTp6JbCq8u+7xNLXCnN/mluCLio=
=GdgS
-----END PGP SIGNATURE-----

--WebcVGuD/i7sDG85--

