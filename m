Return-Path: <linux-kernel+bounces-92270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CF871DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F971C23533
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA1C5D492;
	Tue,  5 Mar 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLc7pvE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5D59171;
	Tue,  5 Mar 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638001; cv=none; b=R6Fbu1Ta2GxHSew1H3q98Qn+/PmiXg96unMhjwTCn2qeXEvvkAL9ytcrU2XAkvq/1ACfNBn6NwbTITN5b5xw0wOsp1DWsWvOmUD2ODeOYoJZFDwONuc50XUQYOBvkDvf8L30lkNEtegOLsbL0vN6Oh5VAPIc8UdB/RnflQ5+Dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638001; c=relaxed/simple;
	bh=J7DVCzHir6/z7fGu3uKzT3SofKuA3XzvBPnprxiO6N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8/aD51gi6g8ZzGxlCU/5qV3Op81Kl6Eu7fMtBBjDLO5yNlHF9LBEvMbihBbXSY15p875gdd+M+vfOaIKAvtOyAboHhhh8ytBN38CL04ly/oDARuuZMYf2gPOGOU61P603EM8/vFl8WAasDUCDp40PdelK1MbxOq7y2Qd5RODIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLc7pvE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA00BC433F1;
	Tue,  5 Mar 2024 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709638001;
	bh=J7DVCzHir6/z7fGu3uKzT3SofKuA3XzvBPnprxiO6N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLc7pvE+m4cUNujQJpI5+GtuJkRc9MTLVD0krP2kZ3lYHi8Lt/y7ICM4bgGmmYjSD
	 +9fAqtXyb526GU70qhIlLRBVWt8Yr7yqBgcb2SooUDkDwtZJiNz0cewa4+fA84V2rv
	 2A79VyrHFyhDVO2svrZCob5u2Z+1Nq9lvdaEMwAA=
Date: Tue, 5 Mar 2024 11:26:38 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ron Economos <re@w6rz.net>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
Message-ID: <2024030521-uncover-pushchair-e68c@gregkh>
References: <20240305074649.580820283@linuxfoundation.org>
 <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <1a9a5456-ea3f-8a30-d8db-f49269966e71@w6rz.net>
 <fc131a72-6421-ad75-44bd-5ab7761d1cc4@w6rz.net>
 <013ebb78-46df-0db7-d95e-51229273bd2c@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013ebb78-46df-0db7-d95e-51229273bd2c@w6rz.net>

On Tue, Mar 05, 2024 at 01:52:59AM -0800, Ron Economos wrote:
> On 3/5/24 1:48 AM, Ron Economos wrote:
> > On 3/5/24 1:27 AM, Ron Economos wrote:
> > > On 3/5/24 12:31 AM, Conor Dooley wrote:
> > > > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.7.9 release.
> > > > > There are 163 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being
> > > > > applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > > > Anything received after that time might be too late.
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >      riscv: Save/restore envcfg CSR during CPU suspend
> > > > > 
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >      riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > > > I left a comment in response to the off-list email about this patch,
> > > > I don't think it's gonna work as the number this custom extension has
> > > > been given exceeds the max in 6.7/
> > > > 
> > > > Cheers,
> > > > Conor.
> > > > 
> > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > >      riscv: Fix enabling cbo.zero when running in M-mode
> > > 
> > > Yeah, it doesn't work. Here's the new error:
> > > 
> > > arch/riscv/kernel/cpufeature.c:180:9: error: implicit declaration of
> > > function '__RISCV_ISA_EXT_SUPERSET'; did you mean
> > > 'RISCV_ISA_EXT_SVPBMT'? [-Werror=implicit-function-declaration]
> > >   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom,
> > > RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > >       |         RISCV_ISA_EXT_SVPBMT
> > > arch/riscv/kernel/cpufeature.c:180:34: error: 'zicbom' undeclared
> > > here (not in a function)
> > >   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom,
> > > RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
> > >       |                                  ^~~~~~
> > > arch/riscv/kernel/cpufeature.c:181:34: error: 'zicboz' undeclared
> > > here (not in a function)
> > >   181 |         __RISCV_ISA_EXT_SUPERSET(zicboz,
> > > RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
> > >       |                                  ^~~~~~
> > > cc1: some warnings being treated as errors
> > > make[4]: *** [scripts/Makefile.build:243:
> > > arch/riscv/kernel/cpufeature.o] Error 1
> > > make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
> > > make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
> > > 
> > > 
> > This depends on a much earlier patch, "riscv: add ISA extension parsing
> > for vector crypto" (upstream commit
> > aec3353963b8de889c3f1ab7cc8ba11e99626606).
> > 
> > I think the best solution will be to revert all three patches.
> > 
> > riscv: Save/restore envcfg CSR during CPU suspend
> > 
> > riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > 
> > riscv: Fix enabling cbo.zero when running in M-mode
> > 
> > 
> > 
> Sorry, "riscv: Fix enabling cbo.zero when running in M-mode" is okay. Just
> the first two.

Ok, will go drop both of them now and will push out a -rc3.

thanks,

greg k-h

