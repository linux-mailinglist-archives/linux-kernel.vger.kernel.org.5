Return-Path: <linux-kernel+bounces-71760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00285AA0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CF52894AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612E45C04;
	Mon, 19 Feb 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE770cYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA425566;
	Mon, 19 Feb 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363756; cv=none; b=cYh3KQkt6BD31rHmATOQSnIfbIju7FT21qR4ryRjN+1NO6qKvtYXkqZEnH+chAZMYoOx1smr+Mryg3oVamwR9iaNmws4nCne4uPKlbPTgW0UOMlqi+bHHc8y3lQDL4tT/6Y5N/ngmOeY1mChGMm3A9JYAk8h/dORuHL/lqwGFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363756; c=relaxed/simple;
	bh=HDOUgL6Y0nc7IvKBPLbbUpZK2qQlAnpDmaaG/SLeRF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1iPQzRqBxKR8sx11JYoJR7cScv7h4eJC+a3VZDey26upiybbYNXewKyll/ZgEADvpixsQZvCc49BwAUrLs/kS3HM5bngsDb/MFIRS3bD34zVTKfMAYPl8VdDy6WCOmrZhOSMA40GlXlyzAH/0jTWVr+HiZgFrDNAULfnslSvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE770cYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D434C433F1;
	Mon, 19 Feb 2024 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708363756;
	bh=HDOUgL6Y0nc7IvKBPLbbUpZK2qQlAnpDmaaG/SLeRF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GE770cYsLQOhGWHmeW4Wg45pDEMxw26SbCB7J9GSGeTl7xQsE9XqhdyPsSDWl1Zx3
	 GkLul7ypkIJvVGKOnIDIlmwNi8Q+VnTopWh448gGGS5T4pP9gJuH89xqr118L7d1l+
	 obyKh8WkVuV6gjlzFMVRklxXAY53JPCpTT8xRRQlccCm2IQW+xOklWfRPJqQsSsPKl
	 jX+pEMjurC+jfEYSlBBVtis0nu2adzeOz5r3PlYClT5iggsaVZ/Iw8rNmvz8fOtJv2
	 /KGOTaFj8QTc8l5D2mo7mpGYFBC2DwW7mT6IMbPFGcR+H8eiJ7B64HfaZCJtDbhn8w
	 dXFebOuUKJu9A==
Date: Mon, 19 Feb 2024 18:29:10 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Mark Rutland <mark.rutland@arm.com>, andersson@kernel.org,
	ulf.hansson@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, quic_lsrao@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Move psci_init_system_suspend() to
 late_initcall()
Message-ID: <ZdOP5oAwZvEhNAsn@lpieralisi>
References: <20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-suspend_ops_late_init-v1-1-6330ca9597fa@quicinc.com>

On Mon, Feb 19, 2024 at 03:02:04PM +0530, Maulik Shah wrote:
> psci_init_system_suspend() invokes suspend_set_ops() very early during
> bootup even before kernel command line for mem_sleep_default is setup.
> This leads to kernel command line mem_sleep_default=s2idle not working
> as mem_sleep_current gets changed to deep via suspend_set_ops() and never
> changes back to s2idle.
> 
> Move psci_init_system_suspend() to late_initcall() to make sure kernel
> command line mem_sleep_default=s2idle sets up s2idle as default suspend
> mode.

Why can't we fix it the other way around, namely enforce
mem_sleep_current according to the mem_sleep_default command line
even if suspend_set_ops() was already called ?

Just asking, I am not super keen on using initcalls ordering, it
looks fragile to me.

Thanks,
Lorenzo

> Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  drivers/firmware/psci/psci.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index d9629ff87861..655a2db70a67 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -523,18 +523,26 @@ static void __init psci_init_system_reset2(void)
>  		psci_system_reset2_supported = true;
>  }
>  
> -static void __init psci_init_system_suspend(void)
> +static int __init psci_init_system_suspend(void)
>  {
>  	int ret;
> +	u32 ver;
>  
>  	if (!IS_ENABLED(CONFIG_SUSPEND))
> -		return;
> +		return 0;
> +
> +	ver = psci_0_2_get_version();
> +	if (PSCI_VERSION_MAJOR(ver) < 1)
> +		return 0;
>  
>  	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
>  
>  	if (ret != PSCI_RET_NOT_SUPPORTED)
>  		suspend_set_ops(&psci_suspend_ops);
> +
> +	return ret;
>  }
> +late_initcall(psci_init_system_suspend)
>  
>  static void __init psci_init_cpu_suspend(void)
>  {
> @@ -651,7 +659,6 @@ static int __init psci_probe(void)
>  	if (PSCI_VERSION_MAJOR(ver) >= 1) {
>  		psci_init_smccc();
>  		psci_init_cpu_suspend();
> -		psci_init_system_suspend();
>  		psci_init_system_reset2();
>  		kvm_init_hyp_services();
>  	}
> 
> ---
> base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
> change-id: 20240219-suspend_ops_late_init-27fb0b15baee
> 
> Best regards,
> -- 
> Maulik Shah <quic_mkshah@quicinc.com>
> 

