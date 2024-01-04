Return-Path: <linux-kernel+bounces-16345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F1823D13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E3B283DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC85B2030A;
	Thu,  4 Jan 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDX165+y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF50200A0;
	Thu,  4 Jan 2024 07:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829CC433C8;
	Thu,  4 Jan 2024 07:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704355136;
	bh=pqd2XsGEAL030a/IJtydQ3u/u6QoxwjQvRz/c0XYeDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDX165+yBsC4bo1a0C5mhL7PSAMRFq2D/ZWA1RIMIDQw5TQ216p8HY0QuA1HRDNdt
	 24NF0/tD4NGfKftlcnwNvpFfqE20Uhtu18fVg1Cn3Wkhsh25YSYXc6m+cjwlzY2Ojl
	 LvJvgD3YhEuOilMx3bBwiSPVm9IkDadBs3NP9zps=
Date: Thu, 4 Jan 2024 08:58:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, leo@leolam.fr,
	johannes.berg@intel.com
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Message-ID: <2024010427-kisser-canopy-763c@gregkh>
References: <20240103164834.970234661@linuxfoundation.org>
 <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
 <32ebe3f1-49b7-4ad3-9ea5-ed2adbbd78da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32ebe3f1-49b7-4ad3-9ea5-ed2adbbd78da@linaro.org>

On Thu, Jan 04, 2024 at 01:15:45AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 03/01/24 10:10 p. m., Daniel Díaz wrote:
> > Hello!
> > 
> > On 03/01/24 10:55 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.6.10 release.
> > > There are 49 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > We're seeing a build regression with x86/GCC-8 and allmodconfig:
> > 
> > -----8<-----
> >    In file included from /builds/linux/include/linux/string.h:294,
> >                     from /builds/linux/include/linux/bitmap.h:11,
> >                     from /builds/linux/include/linux/cpumask.h:12,
> >                     from /builds/linux/arch/x86/include/asm/paravirt.h:17,
> >                     from /builds/linux/arch/x86/include/asm/cpuid.h:62,
> >                     from /builds/linux/arch/x86/include/asm/processor.h:19,
> >                     from /builds/linux/arch/x86/include/asm/cpufeature.h:5,
> >                     from /builds/linux/arch/x86/include/asm/thread_info.h:53,
> >                     from /builds/linux/include/linux/thread_info.h:60,
> >                     from /builds/linux/include/linux/uio.h:9,
> >                     from /builds/linux/include/linux/socket.h:8,
> >                     from /builds/linux/include/uapi/linux/if.h:25,
> >                     from /builds/linux/net/wireless/nl80211.c:11:
> >    In function 'nl80211_set_cqm_rssi.isra.44',
> >        inlined from 'nl80211_set_cqm' at /builds/linux/net/wireless/nl80211.c:13000:10:
> >    /builds/linux/include/linux/fortify-string.h:57:29: error: '__builtin_memcpy' pointer overflow between offset 36 and size [-1, 9223372036854775807] [-Werror=array-bounds]
> >     #define __underlying_memcpy __builtin_memcpy
> >                                 ^
> >    /builds/linux/include/linux/fortify-string.h:648:2: note: in expansion of macro '__underlying_memcpy'
> >      __underlying_##op(p, q, __fortify_size);   \
> >      ^~~~~~~~~~~~~
> >    /builds/linux/include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> >     #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
> >                              ^~~~~~~~~~~~~~~~~~~~
> >    /builds/linux/net/wireless/nl80211.c:12939:3: note: in expansion of macro 'memcpy'
> >       memcpy(cqm_config->rssi_thresholds, thresholds,
> >       ^~~~~~
> >    cc1: all warnings being treated as errors
> >    make[5]: *** [/builds/linux/scripts/Makefile.build:243: net/wireless/nl80211.o] Error 1
> > ----->8-----
> > 
> > This is currently being bisected, so there is more to follow.
> 
> Bisection pointed to:
> 
>   commit 92045aab1bd9bfd73d816e907ea07739c4550b41
>   Author: Johannes Berg <johannes.berg@intel.com>
>   Date:   Sat Dec 16 05:47:15 2023 +0000
> 
>       wifi: cfg80211: fix CQM for non-range use
>       commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.
> 
> Reverting that was not possible, so I reverted 47f3694a4259 first ("wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)"), but that was not enough. After reverting both 47f3694a4259 and 92045aab1bd9, the build passed again.
> 
> Reproducer:
> 
>   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8 --kconfig allmodconfig

Very odd, 6.1 works fine with this same compiler?  These changes were in
the 6.1.70 release (and the 6.1.66 release) before.

It was also in 6.6.5, before being reverted in 6.6.6, so why is this
causing a problem now?

confused,

greg k-h

