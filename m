Return-Path: <linux-kernel+bounces-164028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9EE8B7756
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF90C1C221F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE5171E66;
	Tue, 30 Apr 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1ySKivE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52E171E61;
	Tue, 30 Apr 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484333; cv=none; b=KKtKJPuPPSn7YAOI6PGXlJ50XhJEbMk2yZ3U40RLk77cKLERUkx2mQQMCwn/X1y8TI55WcIyUDbNpKdjbqqvuiy+L/6w9sl2TM6RhwNkP9lgQKbM8dF+how3GkRO24xnDY+gC0Q+D+i6T3ntXFD/o6EmQ9fJ7qpKQLhZmyHLVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484333; c=relaxed/simple;
	bh=YHCBypxT4uIMzW2zI5z0qnxPBx9yqaF2BmbyKZlblMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktMGCRvNuGm6dZUq8SctCP6ArNkQQQiTiHnOkrHY/mxzOKs9wEwXhVJZdgFu7E1npm6HcV+2fHYjR6m2/dyfe/r5kzN3c/2vyjhqfQXmADFbtpNE1M1PXBsO88q/M/daG8vJ65E309CwgIZiJhZgKqNWl/3IEBcJSACKnnLUCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1ySKivE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2FAC2BBFC;
	Tue, 30 Apr 2024 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714484332;
	bh=YHCBypxT4uIMzW2zI5z0qnxPBx9yqaF2BmbyKZlblMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1ySKivEri33apMl0jUoVQg2m9eHr36udd+j6Crbh+jN4eOWLYu6w/sY/TuucTsSh
	 1VYIYjT6ftBjLXT/4qG2cwAxzuAr+rigqnHrUFC4906LGBs80aYFvexG9vetKqL3Yj
	 aX/iVr163vy+qPEYoDCzrrFsJEvaXfo627vNp6rw=
Date: Tue, 30 Apr 2024 15:38:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	SW-Mobile-Linux-Upstreaming <SW-Mobile-Linux-Upstreaming@exchange.nvidia.com>
Subject: Re: [PATCH 5.10 000/138] 5.10.216-rc1 review
Message-ID: <2024043037-postnasal-improve-899d@gregkh>
References: <20240430103049.422035273@linuxfoundation.org>
 <14408365-0270-45a6-9ef6-42dfed18ad64@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14408365-0270-45a6-9ef6-42dfed18ad64@nvidia.com>

On Tue, Apr 30, 2024 at 12:40:04PM +0100, Jon Hunter wrote:
> Hi Greg,
> 
> On 30/04/2024 11:38, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.216 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.216-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> 
> 
> ...
> > Ikjoon Jang <ikjn@chromium.org>
> >      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg
> 
> 
> The above commit is breaking the build for ARM64 ...
> 
>   DTC     arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
> Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:768.26-27 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.lib:326: arch/arm64/boot/dts/mediatek/mt8183-evb.dtb] Error 1
> make[1]: *** [scripts/Makefile.build:503: arch/arm64/boot/dts/mediatek] Error 2
> 
> After reverting this, the dtbs build fine again.

Thanks, will drop it from here and push out a -rc2.

greg k-h

