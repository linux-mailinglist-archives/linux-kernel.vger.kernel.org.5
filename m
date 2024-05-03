Return-Path: <linux-kernel+bounces-167929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537338BB138
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95458B237B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8A156C69;
	Fri,  3 May 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aco0kBue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F929156C6F;
	Fri,  3 May 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754895; cv=none; b=CAwE4cXPqcvLw3+/gsyBjtvE15JYs3akq/yMBG+23KJ8WTvYKJVp/hGtJqjQgUV5i3rGBgxRxEgXSczjIcEo5njFUF3dJCMjrBAeNSxBgp8sVMzeydmSd91CooQCfeLoHE7tKPBtvgKJUoUxuGEXMCZfYdgdH1TPg/6cHYj9UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754895; c=relaxed/simple;
	bh=aE0iuQ/yueU4jPEF48i9AW4lOh1KcBQsXM/Bra676Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkGF5l5XptY9GnQ6tYzhnTl8CDKlauAZrdg+B2v9/Gol4NpxH8VfQsZUktKk6WI7Qa/xMQkgijWS67AiY6WOYQMP1dtOATI1n8Ef9Kb7AVurGsMSlZX9b85x+WXBt1xcAsF1IJ/b2e06a/880HLKx5Qxlhu+3Xvx+J82VNk+gzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aco0kBue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E910C116B1;
	Fri,  3 May 2024 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714754895;
	bh=aE0iuQ/yueU4jPEF48i9AW4lOh1KcBQsXM/Bra676Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aco0kBueWG4Majy+thipijsqB5My9rzYpYkvr5e3CTpi0AypaPbjG/oOhG5lwgGTW
	 xjswA5sEsW26MYKtyB5x96KR8qNT62YxRDY5EumKEzVtSAcq9uezlIHtcpLUz3hfNE
	 0X4By2QImrFmUwXSUYCiN6SfEpuoST79hIQK4S6toK09rYqkqj7/4OnspR7XNFr1H5
	 x7XO4XstfgAjbc3mDqqOKw5NG+0b7b/04zAg0ayYXln5M8ezwXQ+pxN3ssJfwBdmI1
	 vKO/ENkX4douQVm9sbZ5ZnBj2joG1y1Br1NiQGV8FfIx6YlRZzrwj9sAa/Rd3Gy8dD
	 EkxhokJ9WAMhw==
Date: Fri, 3 May 2024 09:48:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/msm/gen_header: allow skipping the validation
Message-ID: <20240503164812.GA4153965@thelio-3990X>
References: <20240409-fd-fix-lxml-v1-1-e5c300d6c1c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-fd-fix-lxml-v1-1-e5c300d6c1c8@linaro.org>

Hi Dmitry,

On Tue, Apr 09, 2024 at 05:22:54PM +0300, Dmitry Baryshkov wrote:
> We don't need to run the validation of the XML files if we are just
> compiling the kernel. Skip the validation unless the user enables
> corresponding Kconfig option. This removes a warning from gen_header.py
> about lxml being not installed.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20240409120108.2303d0bd@canb.auug.org.au/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/Kconfig                 |  8 ++++++++
>  drivers/gpu/drm/msm/Makefile                |  9 ++++++++-
>  drivers/gpu/drm/msm/registers/gen_header.py | 14 +++++++++++---
>  3 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index f202f26adab2..4c9bf237d4a2 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -54,6 +54,14 @@ config DRM_MSM_GPU_SUDO
>  	  Only use this if you are a driver developer.  This should *not*
>  	  be enabled for production kernels.  If unsure, say N.
>  
> +config DRM_MSM_VALIDATE_XML
> +	bool "Validate XML register files against schema"
> +	depends on DRM_MSM && EXPERT
> +	depends on $(success,$(PYTHON3) -c "import lxml")
> +	help
> +	  Validate XML files with register definitions against rules-fd schema.
> +	  This option is mostly targeting DRM MSM developers. If unsure, say N.

Is this change going to be applied? I have gotten a little tired of
seeing "lxml not found, skipping validation" in all of my builds :)

Cheers,
Nathan

