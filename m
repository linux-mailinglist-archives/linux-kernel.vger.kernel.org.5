Return-Path: <linux-kernel+bounces-54868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A184B497
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18E91F28C5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A999132483;
	Tue,  6 Feb 2024 12:08:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEB134744;
	Tue,  6 Feb 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221297; cv=none; b=Jf+aSJL8iMHhjjmAdJZ1klsf0SXBSi4Bbls3+nAiCS/Hi8E8H1i/+4NO5HM6/XcIDi2tC2uAmQXoqjRRZO5wgJgwMxoTI0PFIXLMMr6XMYe6XBB6R4IbBjJQfZeC9t58t/9GR3Z41IZKDuOwo+RGgk4y+91D4fXLeeI77HmR46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221297; c=relaxed/simple;
	bh=H098mPuy9mCSbtQ7HYZw+nmrKMVYVMCn1z01JgjG0ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grc9kRiK9LgmqnfdciYIJA3Fbc8XWZar9RZVhNEce2pIVxIcUn7fF5uSKrOPnTX5gawYrcr+dUrvwp1V4uNR9HsYuJp4V6sXkKgmpQdHduy2Ex14N1EEMgAR1jhQr+xjPSVgyFrAShIyNO6yeO+AUafI4RiuBUAtxonmyep7y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8679B1FB;
	Tue,  6 Feb 2024 04:08:57 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBFA3F762;
	Tue,  6 Feb 2024 04:08:13 -0800 (PST)
Date: Tue, 6 Feb 2024 12:08:07 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: treding@nvidia.com, krzysztof.kozlowski@linaro.org,
	jonathanh@nvidia.com, maz@kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
Message-ID: <ZcIhJxPUZOTjOOYZ@FVFF77S0Q05N.cambridge.arm.com>
References: <20240206114852.8472-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206114852.8472-1-sumitg@nvidia.com>

On Tue, Feb 06, 2024 at 05:18:52PM +0530, Sumit Gupta wrote:
> MC SID register access is restricted for Guest VM.
> So, skip the SID override programming from the Guest VM.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Surely this is probed from the DT?

Why would the hypervisor put this in the guest's DT if that hypervisor isn't
exposing it to the guest?

Mark.

> ---
>  drivers/memory/tegra/tegra186.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 1b3183951bfe..df441896b69d 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -10,6 +10,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <asm/virt.h>
>  
>  #include <soc/tegra/mc.h>
>  
> @@ -118,6 +119,11 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>  	unsigned int i, index = 0;
>  	u32 sid;
>  
> +	if (!is_kernel_in_hyp_mode()) {
> +		dev_dbg(mc->dev, "Register access not allowed\n");
> +		return 0;
> +	}
> +
>  	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
>  		return 0;
>  
> @@ -146,6 +152,11 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
>  #if IS_ENABLED(CONFIG_IOMMU_API)
>  	unsigned int i;
>  
> +	if (!is_kernel_in_hyp_mode()) {
> +		dev_dbg(mc->dev, "Register access not allowed\n");
> +		return 0;
> +	}
> +
>  	for (i = 0; i < mc->soc->num_clients; i++) {
>  		const struct tegra_mc_client *client = &mc->soc->clients[i];
>  
> -- 
> 2.17.1
> 

