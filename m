Return-Path: <linux-kernel+bounces-76621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC085FA17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D75B1C23A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98980134CFC;
	Thu, 22 Feb 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uoVKWye8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52412FF73;
	Thu, 22 Feb 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609408; cv=none; b=D8I/YcWylraW4dzC7esMDFWaOPsNgKxG12jAlss+zcocVb7A9XDNWva9hOeeXBdPu+I+p02QBwlQIqjnC/I0Lj9XEcAicOVMyLF0DRpEVxpz9fSpnfgj0Uv9hfE334RsNKz4a7Ug+mxcjZaV55i2avUl2Raa4nEJvZfFO+N6mNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609408; c=relaxed/simple;
	bh=rx7UwmETgtrLzfEQSyPdVWoy1hp//7HkK8bRiXM/Z2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tumg+MIOjbexnk7gl9ALEMhGmVjf6VA8PAyOa1o3Uk80gXwLCWGGMAz8O3QCLVusiqd/qPnTNHaJbQDP2zDM5TsHKsOQXrfp1qcXGVIzyDgjVmIyOmzDFif9bUVhfwRIsmFiKR1evf5ekDHsaU7v+3yf7DDTu7U+HhYQw2/aZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uoVKWye8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8148CC433C7;
	Thu, 22 Feb 2024 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708609408;
	bh=rx7UwmETgtrLzfEQSyPdVWoy1hp//7HkK8bRiXM/Z2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoVKWye8X8C4wWu4eKu1KPMGTZE26Yp8rWA7aWjcfjM9UVVQMUJQpcoBbyrbkTeFE
	 /SoIhjbUyvGGFRklcRiwb8D7aSKu1oZQY/S5iCBLP7CX91x8DnsSQ9yzeWRZaT5vUW
	 HgRyQYrszxy8WgQLgT37AlWD+cHonzKDEd7VCTbI=
Date: Thu, 22 Feb 2024 14:43:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Beyond <Wang.Beyond@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
Message-ID: <2024022214-afflicted-gestate-4b88@gregkh>
References: <20240221125940.058369148@linuxfoundation.org>
 <CA+G9fYua_rKjdmKMgYrRY_HRyMWPdJNz5=O0K4+M9P9wBWLPcw@mail.gmail.com>
 <2024022214-unselect-scrounger-14d8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022214-unselect-scrounger-14d8@gregkh>

On Thu, Feb 22, 2024 at 02:28:39PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 22, 2024 at 04:25:36PM +0530, Naresh Kamboju wrote:
> > On Wed, 21 Feb 2024 at 19:46, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.4.269 release.
> > > There are 267 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > The i386 allmodconfig builds failed on stable-rc 5.15, 5.10 and 5.4.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> > make[2]: *** [/builds/linux/scripts/Makefile.modpost:133:
> > modules-only.symvers] Error 1
> > 
> > Steps to reproduce:
> >  tuxmake --runtime podman --target-arch i386 --toolchain gcc-12
> > --kconfig allmodconfig
> 
> Thanks, I've tracked this down to commit 6fb12518ca58 ("drm/amd/display:
> make flip_timestamp_in_us a 64-bit variable")
> 
> Let me see if I can find a fix, if not, I'll just drop it, thanks!

I've just dropped it from everywhere now, thanks.

greg k-h

